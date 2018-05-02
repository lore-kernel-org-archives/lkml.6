Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeEBRtC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:49:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbeEBRtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:49:00 -0400
Date: Wed, 2 May 2018 10:48:35 -0700
From: tip-bot for Takashi Iwai <tipbot@zytor.com>
Message-ID: <tip-ffef80ecf89f0a883e976534a62db04059d3a4f6@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        hpa@zytor.com, tglx@linutronix.de, acme@redhat.com, tiwai@suse.de
Reply-To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, acme@redhat.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20180424150456.17353-1-tiwai@suse.de>
References: <20180424150456.17353-1-tiwai@suse.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf Documentation: Support for asciidoctor
Git-Commit-ID: ffef80ecf89f0a883e976534a62db04059d3a4f6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ffef80ecf89f0a883e976534a62db04059d3a4f6
Gitweb:     https://git.kernel.org/tip/ffef80ecf89f0a883e976534a62db04059d3a4f6
Author:     Takashi Iwai <tiwai@suse.de>
AuthorDate: Tue, 24 Apr 2018 17:04:56 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:10 -0300

perf Documentation: Support for asciidoctor

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
