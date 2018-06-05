Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeFESAY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752665AbeFERv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:56 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 25/46] perf annotate: Move objdump_path to struct annotation_options
Date: Tue,  5 Jun 2018 14:50:09 -0300
Message-Id: <20180605175030.32549-26-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more step in grouping annotation options.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-sogzdhugoavm6fyw60jnb0vs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/common.c       | 4 ++--
 tools/perf/arch/common.h       | 4 +---
 tools/perf/builtin-annotate.c  | 7 ++++---
 tools/perf/builtin-report.c    | 2 +-
 tools/perf/builtin-top.c       | 7 ++++---
 tools/perf/ui/browsers/hists.c | 3 ++-
 tools/perf/util/annotate.c     | 3 +--
 tools/perf/util/annotate.h     | 1 +
 8 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index c6f373508a4f..82657c01a3b8 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -189,7 +189,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 	return -1;
 }
 
-int perf_env__lookup_objdump(struct perf_env *env)
+int perf_env__lookup_objdump(struct perf_env *env, const char **path)
 {
 	/*
 	 * For live mode, env->arch will be NULL and we can use
@@ -198,5 +198,5 @@ int perf_env__lookup_objdump(struct perf_env *env)
 	if (env->arch == NULL)
 		return 0;
 
-	return perf_env__lookup_binutils_path(env, "objdump", &objdump_path);
+	return perf_env__lookup_binutils_path(env, "objdump", path);
 }
diff --git a/tools/perf/arch/common.h b/tools/perf/arch/common.h
index 2d875baa92e6..2167001b18c5 100644
--- a/tools/perf/arch/common.h
+++ b/tools/perf/arch/common.h
@@ -4,8 +4,6 @@
 
 #include "../util/env.h"
 
-extern const char *objdump_path;
-
-int perf_env__lookup_objdump(struct perf_env *env);
+int perf_env__lookup_objdump(struct perf_env *env, const char **path);
 
 #endif /* ARCH_PERF_COMMON_H */
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 2339ae719e1d..5eb22cc56363 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -388,8 +388,9 @@ static int __cmd_annotate(struct perf_annotate *ann)
 			goto out;
 	}
 
-	if (!objdump_path) {
-		ret = perf_env__lookup_objdump(&session->header.env);
+	if (!ann->opts.objdump_path) {
+		ret = perf_env__lookup_objdump(&session->header.env,
+					       &ann->opts.objdump_path);
 		if (ret)
 			goto out;
 	}
@@ -521,7 +522,7 @@ int cmd_annotate(int argc, const char **argv)
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &annotate.opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
-	OPT_STRING(0, "objdump", &objdump_path, "path",
+	OPT_STRING(0, "objdump", &annotate.opts.objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
 		    "Show event group information together"),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 14b516a3a0de..bc133e7a7ac2 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1094,7 +1094,7 @@ int cmd_report(int argc, const char **argv)
 		    parse_branch_mode),
 	OPT_BOOLEAN(0, "branch-history", &branch_call_mode,
 		    "add last branch records to call history"),
-	OPT_STRING(0, "objdump", &objdump_path, "path",
+	OPT_STRING(0, "objdump", &report.annotation_opts.objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
 		    "Disable symbol demangling"),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index bd60a631a481..ffdc2769ff9f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1077,8 +1077,9 @@ static int __cmd_top(struct perf_top *top)
 	if (top->session == NULL)
 		return -1;
 
-	if (!objdump_path) {
-		ret = perf_env__lookup_objdump(&top->session->header.env);
+	if (!top->annotation_opts.objdump_path) {
+		ret = perf_env__lookup_objdump(&top->session->header.env,
+					       &top->annotation_opts.objdump_path);
 		if (ret)
 			goto out_delete;
 	}
@@ -1347,7 +1348,7 @@ int cmd_top(int argc, const char **argv)
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
-	OPT_STRING(0, "objdump", &objdump_path, "path",
+	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
 		    "objdump binary to use for disassembly and annotations"),
 	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 3af1b74608ab..22054107f1af 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2338,7 +2338,8 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	struct hist_entry *he;
 	int err;
 
-	if (!objdump_path && perf_env__lookup_objdump(browser->env))
+	if (!browser->annotation_opts->objdump_path &&
+	    perf_env__lookup_objdump(browser->env, &browser->annotation_opts->objdump_path))
 		return 0;
 
 	notes = symbol__annotation(act->ms.sym);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a90777717b60..2baa22933b0e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -51,7 +51,6 @@ struct annotation_options annotation__default_options = {
 	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
 };
 
-const char	*objdump_path;
 static regex_t	 file_lineno;
 
 static struct ins_ops *ins__find(struct arch *arch, const char *name);
@@ -1657,7 +1656,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
 		 " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
-		 objdump_path ? objdump_path : "objdump",
+		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 6e6e2a571928..a4c0d91907e6 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -80,6 +80,7 @@ struct annotation_options {
 	int  min_pcnt;
 	int  max_lines;
 	int  context;
+	const char *objdump_path;
 	const char *disassembler_style;
 };
 
-- 
2.14.3
