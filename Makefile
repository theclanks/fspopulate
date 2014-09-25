CC = g++

# I use Boost 1.35 with headers installed in /usr/local/include/boost-1_35/.
# If you use the Boost library from your distribution, you don't need the
# "-I/usr/local/include/boost-1_35" option.

# Use this for recent AMD CPUs
#CFLAGS  = -I/usr/local/include -Wall -I. -I/usr/local/include/boost-1_35 -g -DHAVE_SSE2 -DMEXP=216091 -Os -march=athlon64
#CXXFLAGS= -I/usr/local/include -Wall -I. -I/usr/local/include/boost-1_35 -g -DHAVE_SSE2 -DMEXP=216091 -Os -march=athlon64

# Use this if you have an Intel Core2Duo
#CFLAGS  = -I/usr/local/include -Wall -I. -I/usr/local/include/boost-1_35 -g -DHAVE_SSE2 -DMEXP=216091 -Os -march=nocona
#CXXFLAGS= -I/usr/local/include -Wall -I. -I/usr/local/include/boost-1_35 -g -DHAVE_SSE2 -DMEXP=216091 -Os -march=nocona

# Use these if you don't know what CPU you have (or use the switches from the Gentoo
# Wiki at http://gentoo-wiki.com/Safe_Cflags)
CFLAGS  = -I/usr/local/include -Wall -I. -I/usr/local/include/boost-1_35 -g -DMEXP=216091 -Os -mtune=i686
CXXFLAGS= -I/usr/local/include -Wall -I. -I/usr/local/include/boost-1_35 -g -DMEXP=216091 -Os -mtune=i686

#LDFLAGS = -lboost_program_options-gcc41-mt -lboost_filesystem-gcc41-mt

# If you use the Boost library from your distribution, you can use these linker flags
LDFLAGS = -lboost_program_options -lboost_filesystem

DEPS = SFMT/SFMT.c fspopulate.cc
OBJS = SFMT/SFMT.o fspopulate.o

%.s: %.c $(DEPS)
	$(CC) $(CFLAGS) -S -o $@ $<

%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.cc $(DEPS)
	$(CC) $(CXXFLAGS) -c -o $@ $<

fspopulate: $(OBJS)
	$(CC) $(CFLAGS) $(CXXFLAGS) $(LDFLAGS) -o $@ $^

.PHONY: clean

clean:
	rm -rf *.o fspopulate

all: fspopulate

