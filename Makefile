# Makefile for the PerlDancer book
#
# Use:
#  AsciiDoctor 0.1.4 (https://github.com/asciidoctor/asciidoctor)
#  asciidoctor-fopub (https://github.com/asciidoctor/asciidoctor-fopub)
#  a2x (asciidoc 8.6.9)
#  DocBook xsl-stylesheets-1.78.1
#
#  Experimental:
#  asciidoctor-epub3 with AsciiDoctor 1.5.0.preview.8
#                    (https://github.com/opendevise/asciidoctor-epub3)

SRC_FILE=book
SRC_DIR=sections
OUT_DIR=build/output

all: clean html pdf epub

html:
	@echo -n "Generating HTML..."
	@asciidoctor -a toc2 -a last-update-label! -b html5 -o ${OUT_DIR}/${SRC_FILE}.html ${SRC_DIR}/${SRC_FILE}.adoc
	@echo "done"

pdf:
	@echo -n "Generating PDF..."
	@asciidoctor -b docbook -o ${OUT_DIR}/${SRC_FILE}.xml ${SRC_DIR}/${SRC_FILE}.adoc
	@fopub ${OUT_DIR}/${SRC_FILE}.xml
	@echo "done"

epub:
	@echo -n "Generating epub..."
	@a2x -f epub -D ${OUT_DIR} -d book -a docinfo ${SRC_DIR}/${SRC_FILE}.adoc
	@echo "done"

epub3:
	@echo -n "Generating epub3 (alpha)..."
	@asciidoctor-epub3 -D ${OUT_DIR} ${SRC_DIR}/${SRC_FILE}.adoc
	@echo "done"

clean:
	@rm -rf ${OUT_DIR}/*.pdf ${OUT_DIR}/*.epub ${OUT_DIR}/*.xml ${OUT_DIR}/*.html
