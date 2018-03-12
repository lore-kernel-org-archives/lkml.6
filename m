Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeCLJpi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:45:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752342AbeCLJn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:26 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 06/13] perf bpf: Add disasm option
Date: Mon, 12 Mar 2018 10:43:06 +0100
Message-Id: <20180312094313.18738-7-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add -d/--disasm option to get the sbpf assembly
code dump, like:

  $ perf bpf -d ./comm1.o | head
  Disassembly of raw_syscalls:sys_enter:
     0: (b7) r1 = 1
         b7 01 00 00 01 00 00 00
     1: (7b) *(u64 *)(r10 -8) = r1
         7b 1a f8 ff 00 00 00 00
     2: (bf) r6 = r10
         bf a6 00 00 00 00 00 00
     3: (07) r6 += -24
         07 06 00 00 e8 ff ff ff
     4: (bf) r1 = r6
     ...

Link: http://lkml.kernel.org/n/tip-djopq2e6ajsg9h90hb9iuat3@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Build           |   6 +++
 tools/perf/Makefile.config |   1 +
 tools/perf/builtin-bpf.c   | 107 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/tools/perf/Build b/tools/perf/Build
index 7f521ac16466..0585fd3715d0 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -25,6 +25,7 @@ perf-y += builtin-data.o
 perf-y += builtin-version.o
 perf-y += builtin-c2c.o
 perf-y += builtin-bpf.o
+perf-y += bpf-disasm.o
 
 perf-$(CONFIG_TRACE) += builtin-trace.o
 perf-$(CONFIG_LIBELF) += builtin-probe.o
@@ -46,6 +47,7 @@ CFLAGS_perf.o              += -DPERF_HTML_PATH="BUILD_STR($(htmldir_SQ))"	\
 CFLAGS_builtin-trace.o	   += -DSTRACE_GROUPS_DIR="BUILD_STR($(STRACE_GROUPS_DIR_SQ))"
 CFLAGS_builtin-report.o	   += -DTIPDIR="BUILD_STR($(tipdir_SQ))"
 CFLAGS_builtin-report.o	   += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
+CFLAGS_builtin-bpf.o	   += -I$(srctree)/kernel/bpf
 
 libperf-y += util/
 libperf-y += arch/
@@ -54,3 +56,7 @@ libperf-y += scripts/
 libperf-$(CONFIG_TRACE) += trace/beauty/
 
 gtk-y += ui/gtk/
+
+$(OUTPUT)bpf-disasm.o: ../../kernel/bpf/disasm.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 98ff73648b51..575910cebb57 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -999,3 +999,4 @@ $(call detected_var,LIBDIR)
 $(call detected_var,GTK_CFLAGS)
 $(call detected_var,PERL_EMBED_CCOPTS)
 $(call detected_var,PYTHON_EMBED_CCOPTS)
+$(call detected_var,srctree)
diff --git a/tools/perf/builtin-bpf.c b/tools/perf/builtin-bpf.c
index 1ae93fd01a97..7065153a9577 100644
--- a/tools/perf/builtin-bpf.c
+++ b/tools/perf/builtin-bpf.c
@@ -4,6 +4,8 @@
 #include <time.h>
 #include <linux/compiler.h>
 #include <subcmd/parse-options.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
 #include "builtin.h"
 #include "perf.h"
 #include "target.h"
@@ -12,6 +14,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "bpf-loader.h"
+#include "disasm.h"
 
 struct perf_bpf {
 	struct target		 target;
@@ -137,6 +140,104 @@ static int __cmd_bpf(int argc , const char **argv)
 	return WEXITSTATUS(status);
 }
 
+static void print_insn(struct bpf_verifier_env *env __maybe_unused, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vprintf(fmt, args);
+	va_end(args);
+}
+
+static const char *print_call(void *private_data __maybe_unused,
+			      const struct bpf_insn *insn __maybe_unused)
+{
+	return NULL;
+}
+
+static const char *print_imm(void *private_data __maybe_unused,
+			     const struct bpf_insn *insn __maybe_unused,
+			     __u64 full_imm __maybe_unused)
+{
+	return NULL;
+}
+
+static void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
+{
+	unsigned char *data = arg;
+	unsigned int i;
+
+	for (i = 0; i < n; i++) {
+		const char *pfx = "";
+
+		if (!i)
+			/* nothing */;
+		else if (!(i % 16))
+			fprintf(f, "\n");
+		else if (!(i % 8))
+			fprintf(f, "  ");
+		else
+			pfx = sep;
+
+		fprintf(f, "%s%02hhx", i ? pfx : "", data[i]);
+	}
+}
+
+static int disasm_fprintf(FILE *out, const char *filename, bool opcodes)
+{
+	const struct bpf_insn_cbs cbs = {
+		.cb_print       = print_insn,
+		.cb_call        = print_call,
+		.cb_imm         = print_imm,
+		.private_data   = NULL,
+	};
+	bool double_insn = false;
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	int i;
+
+	obj = bpf__prepare_load(filename, false);
+	if (IS_ERR(obj))
+		return -1;
+
+	bpf_object__for_each_program(prog, obj) {
+		struct bpf_insn *insn;
+		int insns_cnt;
+
+		fprintf(out, "Disassembly of %s:\n", bpf_program__title(prog, false));
+
+		insn = bpf_program__insns(prog, &insns_cnt);
+		if (!insn) {
+			pr_err("failed: NULL instructions\n");
+			return -1;
+		}
+
+		for (i = 0; i < (int) insns_cnt; i++) {
+			if (double_insn) {
+				double_insn = false;
+				continue;
+			}
+
+			double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
+
+			printf("% 4d: ", i);
+			print_bpf_insn(&cbs, NULL, insn + i, true);
+
+			if (opcodes) {
+				printf("       ");
+				fprint_hex(stdout, insn + i, 8, " ");
+				if (double_insn && i < (int) (insns_cnt*sizeof(*insn)) - 1) {
+					printf(" ");
+					fprint_hex(stdout, insn + i + 1, 8, " ");
+				}
+				printf("\n");
+			}
+		}
+	}
+
+	return 0;
+}
+
 int cmd_bpf(int argc, const char **argv)
 {
 	int err = -1;
@@ -146,6 +247,7 @@ int cmd_bpf(int argc, const char **argv)
 		NULL
 	};
 	const char *compile_src = NULL;
+	const char *disasm_obj = NULL;
 	const struct option bpf_options[] = {
 		OPT_CALLBACK('e', "event", &bpf.evlist, "event",
 			     "event selector. use 'perf list' to list available events",
@@ -162,6 +264,8 @@ int cmd_bpf(int argc, const char **argv)
 			 "be more verbose"),
 		OPT_STRING('c', "compile", &compile_src, "eBPF source",
 			   "compile eBPF object"),
+		OPT_STRING('d', "disasm", &disasm_obj, "eBPF object",
+			   "disasm eBPF object"),
 		OPT_END()
 	};
 
@@ -177,6 +281,9 @@ int cmd_bpf(int argc, const char **argv)
 	if (compile_src)
 		return bpf__compile(compile_src);
 
+	if (disasm_obj)
+		return disasm_fprintf(stdout, disasm_obj, true);
+
 	if (!argc && target__none(&bpf.target))
 		usage_with_options(bpf_usage, bpf_options);
 
-- 
2.13.6
