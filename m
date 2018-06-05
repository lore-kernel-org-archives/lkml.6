Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeFERvx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752638AbeFERvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:50 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 23/46] perf annotate: Move disassembler_style global to annotation_options
Date: Tue,  5 Jun 2018 14:50:07 -0300
Message-Id: <20180605175030.32549-24-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Continuing to group annotation specific stuff into a struct.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-p3cdhltj58jt0byjzg3g7obx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 2 +-
 tools/perf/builtin-report.c   | 2 +-
 tools/perf/builtin-top.c      | 2 +-
 tools/perf/util/annotate.c    | 5 ++---
 tools/perf/util/annotate.h    | 3 +--
 5 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 2ca7172f0780..3ee063598364 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -519,7 +519,7 @@ int cmd_annotate(int argc, const char **argv)
 		    "Interleave source code with assembly code (default)"),
 	OPT_BOOLEAN(0, "asm-raw", &annotate.opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
-	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &annotate.opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index bee6dbfbf11e..c74f9a219ad1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1083,7 +1083,7 @@ int cmd_report(int argc, const char **argv)
 		    "Interleave source code with assembly code (default)"),
 	OPT_BOOLEAN(0, "asm-raw", &report.annotation_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
-	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &report.annotation_opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e65e72c06a01..739c158fb39e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1348,7 +1348,7 @@ int cmd_top(int argc, const char **argv)
 		    "Enable kernel symbol demangling"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		    "objdump binary to use for disassembly and annotations"),
-	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_STRING('u', "uid", &target->uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "percent-limit", &top, "percent",
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ff8f4f474b22..a90777717b60 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -51,7 +51,6 @@ struct annotation_options annotation__default_options = {
 	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
 };
 
-const char 	*disassembler_style;
 const char	*objdump_path;
 static regex_t	 file_lineno;
 
@@ -1659,8 +1658,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		 " --stop-address=0x%016" PRIx64
 		 " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
 		 objdump_path ? objdump_path : "objdump",
-		 disassembler_style ? "-M " : "",
-		 disassembler_style ? disassembler_style : "",
+		 opts->disassembler_style ? "-M " : "",
+		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
 		 opts->show_asm_raw ? "" : "--no-show-raw",
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 476ea2a25649..71a734b86873 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -80,6 +80,7 @@ struct annotation_options {
 	int  min_pcnt;
 	int  max_lines;
 	int  context;
+	const char *disassembler_style;
 };
 
 enum {
@@ -368,8 +369,6 @@ static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
 }
 #endif
 
-extern const char	*disassembler_style;
-
 void annotation_config__init(void);
 
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.14.3
