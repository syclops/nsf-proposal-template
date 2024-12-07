SOURCES = $(wildcard *.tex)
TARGETS = $(SOURCES:.tex=.pdf)
LATEXMK = latexmk
FLAGS = -pdf -bibtex-cond
CLEAN_FLAGS = -c -bibtex-cond
CLEAN_FULL_FLAGS = -C -bibtex-cond

.PHONY = all clean clean-full

all: $(TARGETS)

clean:
	$(LATEXMK) $(CLEAN_FLAGS) $(basename $(TARGETS))
	rm *.bbl

clean-full:
	$(LATEXMK) $(CLEAN_FULL_FLAGS) $(basename $(TARGETS))
	rm *.bbl

# Most proposal-related documents are generated from a single .tex source file.
%.pdf: %.tex
	$(LATEXMK) $(FLAGS) $*

# The project description itself is a bit different from the other documents,
# since it has LaTeX sources in the sec/ and setup/ directories, and figures in
# the fig/ directory. Make sure those are considered in recompiling.
proposal.pdf: proposal.tex $(wildcard */*.tex) $(wildcard fig/*.pdf)
	$(LATEXMK) $(FLAGS) $(basename $@)

