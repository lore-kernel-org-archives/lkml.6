Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeEBP3w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:29:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751991AbeEBPVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:03 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/52] perf Documentation: Support for asciidoctor
Date: Wed,  2 May 2018 12:19:09 -0300
Message-Id: <20180502151942.20542-20-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

The asciidoc package seems behind the recent big wave of python3
conversion, and we were advised to switch to asciidoctor instead.  It's
almost compatible but some extensions used for perf documentation don't
work with it.  Here is the patch to cover them, and add the proper
support for asciidoctor.

Pass USE_ASCIIDOCTOR=yes to make for using asciidoctor instead of
asciidoc.  The man source and manual attributes are passed via command
options.  The support for these attributes have been fixed in the
latest asciidoctor code.

Since asciidoctor can covert to a man page and an HTML directly, we
can omit the dependency on xmlto when USE_ASCIIDOCTOR is set.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180424150456.17353-1-tiwai@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Makefile                  | 29 ++++++++++++++++++----
 tools/perf/Documentation/asciidoctor-extensions.rb | 29 ++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/Documentation/asciidoctor-extensions.rb

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index db11478e30b4..42261a9b280e 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -47,7 +47,8 @@ man5dir=$(mandir)/man5
 man7dir=$(mandir)/man7
 
 ASCIIDOC=asciidoc
-ASCIIDOC_EXTRA = --unsafe
+ASCIIDOC_EXTRA = --unsafe -f asciidoc.conf
+ASCIIDOC_HTML = xhtml11
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO_EXTRA =
 INSTALL?=install
@@ -55,6 +56,14 @@ RM ?= rm -f
 DOC_REF = origin/man
 HTML_REF = origin/html
 
+ifdef USE_ASCIIDOCTOR
+ASCIIDOC = asciidoctor
+ASCIIDOC_EXTRA = -a compat-mode
+ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
+ASCIIDOC_EXTRA += -a mansource="perf" -a manmanual="perf Manual"
+ASCIIDOC_HTML = xhtml5
+endif
+
 infodir?=$(prefix)/share/info
 MAKEINFO=makeinfo
 INSTALL_INFO=install-info
@@ -73,10 +82,12 @@ ifeq ($(_tmp_tool_path),)
 	missing_tools = $(ASCIIDOC)
 endif
 
+ifndef USE_ASCIIDOCTOR
 _tmp_tool_path := $(call get-executable,$(XMLTO))
 ifeq ($(_tmp_tool_path),)
 	missing_tools += $(XMLTO)
 endif
+endif
 
 #
 # For asciidoc ...
@@ -264,9 +275,17 @@ clean:
 
 $(MAN_HTML): $(OUTPUT)%.html : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
+	$(ASCIIDOC) -b $(ASCIIDOC_HTML) -d manpage \
+		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) -o $@+ $< && \
+	mv $@+ $@
+
+ifdef USE_ASCIIDOCTOR
+$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.txt
+	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	$(ASCIIDOC) -b manpage -d manpage \
 		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) -o $@+ $< && \
 	mv $@+ $@
+endif
 
 $(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.xml
 	$(QUIET_XMLTO)$(RM) $@ && \
@@ -274,7 +293,7 @@ $(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.xml
 
 $(OUTPUT)%.xml : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
+	$(ASCIIDOC) -b docbook -d manpage \
 		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
@@ -321,13 +340,13 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 $*.txt
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b $(ASCIIDOC_HTML) $*.txt
 
 WEBDOC_DEST = /pub/software/tools/perf/docs
 
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	sed -e '1,/^$$/d' $< | $(ASCIIDOC) -b xhtml11 - >$@+ && \
+	sed -e '1,/^$$/d' $< | $(ASCIIDOC) -b $(ASCIIDOC_HTML) - >$@+ && \
 	mv $@+ $@
 
 # UNIMPLEMENTED
diff --git a/tools/perf/Documentation/asciidoctor-extensions.rb b/tools/perf/Documentation/asciidoctor-extensions.rb
new file mode 100644
index 000000000000..d148fe95c0c4
--- /dev/null
+++ b/tools/perf/Documentation/asciidoctor-extensions.rb
@@ -0,0 +1,29 @@
+require 'asciidoctor'
+require 'asciidoctor/extensions'
+
+module Perf
+  module Documentation
+    class LinkPerfProcessor < Asciidoctor::Extensions::InlineMacroProcessor
+      use_dsl
+
+      named :chrome
+
+      def process(parent, target, attrs)
+        if parent.document.basebackend? 'html'
+          %(<a href="#{target}.html">#{target}(#{attrs[1]})</a>\n)
+        elsif parent.document.basebackend? 'manpage'
+          "#{target}(#{attrs[1]})"
+        elsif parent.document.basebackend? 'docbook'
+          "<citerefentry>\n" \
+            "<refentrytitle>#{target}</refentrytitle>" \
+            "<manvolnum>#{attrs[1]}</manvolnum>\n" \
+          "</citerefentry>\n"
+        end
+      end
+    end
+  end
+end
+
+Asciidoctor::Extensions.register do
+  inline_macro Perf::Documentation::LinkPerfProcessor, :linkperf
+end
-- 
2.14.3
