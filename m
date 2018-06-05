Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeFERvt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeFERvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:47 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 22/46] perf annotate: Adopt anotation options from symbol_conf
Date: Tue,  5 Jun 2018 14:50:06 -0300
Message-Id: <20180605175030.32549-23-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Continuing to group annotation options in an annotation specific struct.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-astei92tzxp4yccag5pxb2h7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 4 ++--
 tools/perf/builtin-report.c   | 6 ++++--
 tools/perf/builtin-top.c      | 4 ++--
 tools/perf/util/annotate.c    | 6 ++++--
 tools/perf/util/annotate.h    | 4 +++-
 tools/perf/util/symbol.c      | 1 -
 tools/perf/util/symbol.h      | 2 --
 7 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 7238010f28d4..2ca7172f0780 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -515,9 +515,9 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK(0, "symfs", NULL, "directory",
 		     "Look for files with symbols relative to this directory",
 		     symbol__config_symfs),
-	OPT_BOOLEAN(0, "source", &symbol_conf.annotate_src,
+	OPT_BOOLEAN(0, "source", &annotate.opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &symbol_conf.annotate_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &annotate.opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 7a689c933f04..bee6dbfbf11e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -71,6 +71,7 @@ struct report {
 	bool			group_set;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
+	struct annotation_options annotation_opts;
 	const char		*pretty_printing_style;
 	const char		*cpu_list;
 	const char		*symbol_filter_str;
@@ -988,6 +989,7 @@ int cmd_report(int argc, const char **argv)
 		.max_stack		 = PERF_MAX_STACK_DEPTH,
 		.pretty_printing_style	 = "normal",
 		.socket_filter		 = -1,
+		.annotation_opts	 = annotation__default_options,
 	};
 	const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
@@ -1077,9 +1079,9 @@ int cmd_report(int argc, const char **argv)
 		   "list of cpus to profile"),
 	OPT_BOOLEAN('I', "show-info", &report.show_full_info,
 		    "Display extended information about perf.data file"),
-	OPT_BOOLEAN(0, "source", &symbol_conf.annotate_src,
+	OPT_BOOLEAN(0, "source", &report.annotation_opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &symbol_conf.annotate_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &report.annotation_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 2c14ca61c657..e65e72c06a01 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1340,9 +1340,9 @@ int cmd_top(int argc, const char **argv)
 		   "only consider symbols in these comms"),
 	OPT_STRING(0, "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
 		   "only consider these symbols"),
-	OPT_BOOLEAN(0, "source", &symbol_conf.annotate_src,
+	OPT_BOOLEAN(0, "source", &top.annotation_opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &symbol_conf.annotate_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &top.annotation_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 502f9d124a44..ff8f4f474b22 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -47,6 +47,7 @@
 struct annotation_options annotation__default_options = {
 	.use_offset     = true,
 	.jump_arrows    = true,
+	.annotate_src	= true,
 	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
 };
 
@@ -1609,6 +1610,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
+	struct annotation_options *opts = args->options;
 	struct map *map = args->ms.map;
 	struct dso *dso = map->dso;
 	char *command;
@@ -1661,8 +1663,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		 disassembler_style ? disassembler_style : "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
-		 symbol_conf.annotate_asm_raw ? "" : "--no-show-raw",
-		 symbol_conf.annotate_src ? "-S" : "",
+		 opts->show_asm_raw ? "" : "--no-show-raw",
+		 opts->annotate_src ? "-S" : "",
 		 symfs_filename, symfs_filename);
 
 	if (err < 0) {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 013d414b0e57..476ea2a25649 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -73,7 +73,9 @@ struct annotation_options {
 	     show_nr_jumps,
 	     show_nr_samples,
 	     show_total_period,
-	     show_minmax_cycle;
+	     show_minmax_cycle,
+	     show_asm_raw,
+	     annotate_src;
 	u8   offset_level;
 	int  min_pcnt;
 	int  max_lines;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8c84437f2a10..3f632c60888f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -40,7 +40,6 @@ char **vmlinux_path;
 struct symbol_conf symbol_conf = {
 	.use_modules		= true,
 	.try_vmlinux_path	= true,
-	.annotate_src		= true,
 	.demangle		= true,
 	.demangle_kernel	= false,
 	.cumulate_callchain	= true,
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 1be9a6bad967..f25fae4b5743 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -108,8 +108,6 @@ struct symbol_conf {
 			show_cpu_utilization,
 			initialized,
 			kptr_restrict,
-			annotate_asm_raw,
-			annotate_src,
 			event_group,
 			demangle,
 			demangle_kernel,
-- 
2.14.3
