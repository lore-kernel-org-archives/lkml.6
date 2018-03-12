Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeCLJoP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:44:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932416AbeCLJne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:34 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 12/13] perf bpf: Run begin/end programs
Date: Mon, 12 Mar 2018 10:43:12 +0100
Message-Id: <20180312094313.18738-13-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running begin and end programs for ebpf object.

Link: http://lkml.kernel.org/n/tip-ego7m00cr7sru8l5bjpjwwcm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-bpf.c     |  6 ++++
 tools/perf/util/bpf-loader.c | 78 ++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-loader.h |  2 ++
 3 files changed, 86 insertions(+)

diff --git a/tools/perf/builtin-bpf.c b/tools/perf/builtin-bpf.c
index 7065153a9577..1111e240e259 100644
--- a/tools/perf/builtin-bpf.c
+++ b/tools/perf/builtin-bpf.c
@@ -94,6 +94,10 @@ static int __cmd_bpf(int argc , const char **argv)
 		goto out_child;
 	}
 
+	err = bpf__run_begin(stdout);
+	if (err)
+		goto out_child;
+
 	if (forks) {
 		perf_evlist__start_workload(bpf.evlist);
 
@@ -115,6 +119,8 @@ static int __cmd_bpf(int argc , const char **argv)
 
 	child_pid = -1;
 
+	bpf__run_end(stdout);
+
 out_child:
 	if (forks) {
                 if (workload_exec_errno) {
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index e59168153375..d5f9c3cd5280 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -9,6 +9,7 @@
 #include <linux/bpf.h>
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
+#include <bpf/interp.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -23,6 +24,7 @@
 #include "strfilter.h"
 #include "llvm-utils.h"
 #include "c++/clang-c.h"
+#include "bpf-userapi.h"
 
 #define DEFINE_PRINT_FN(name, level) \
 static int libbpf_##name(const char *fmt, ...)	\
@@ -1547,6 +1549,82 @@ int bpf__apply_obj_config(void)
 	return 0;
 }
 
+struct interp {
+	struct bpf_interp  in;
+	FILE		  *out;
+};
+
+static int bpf_interp_call_cb(struct bpf_interp *in,
+			      u64 imm, u64 *regs)
+{
+	struct interp *interp = container_of(in, struct interp, in);
+	u64 dr;
+
+	switch (imm) {
+	case BPF_FUNC_USER_bpf_map_lookup_elem:
+		dr = bpf_map_lookup_elem((int)    regs[1],
+					 (void *) regs[2],
+					 (void *) regs[3]);
+		break;
+	case BPF_FUNC_USER_bpf_map_get_next_key:
+		dr = bpf_map_get_next_key((int)    regs[1],
+					  (void *) regs[2],
+					  (void *) regs[3]);
+		break;
+	case BPF_FUNC_USER_print:
+		dr = fprintf(interp->out, (const char *) regs[1],
+			     regs[2], regs[3], regs[4], regs[5]);
+		fflush(interp->out);
+		break;
+	default:
+		return -1;
+		break;
+	};
+
+	regs[0] = dr;
+	regs[1] = 0xdeadbeef;
+	regs[2] = 0xdeadbeef;
+	regs[3] = 0xdeadbeef;
+	regs[4] = 0xdeadbeef;
+	return 0;
+}
+
+int bpf__run_begin(FILE *out)
+{
+	struct interp interp = {
+		.in.call_cb	= bpf_interp_call_cb,
+		.out		= out,
+	};
+	struct bpf_object *obj, *tmp;
+	int err;
+
+	bpf_object__for_each_safe(obj, tmp) {
+		err = bpf_object__run_begin(obj, &interp.in);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+int bpf__run_end(FILE *out)
+{
+	struct interp interp = {
+		.in.call_cb	= bpf_interp_call_cb,
+		.out		= out,
+	};
+	struct bpf_object *obj, *tmp;
+	int err;
+
+	bpf_object__for_each_safe(obj, tmp) {
+		err = bpf_object__run_end(obj, &interp.in);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 #define bpf__for_each_map(pos, obj, objtmp)	\
 	bpf_object__for_each_safe(obj, objtmp)	\
 		bpf_map__for_each(pos, obj)
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 8c2a494cab53..1ee4c3ca4927 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -87,6 +87,8 @@ int bpf__setup_stdout(struct perf_evlist *evlist);
 int bpf__strerror_setup_stdout(struct perf_evlist *evlist, int err,
 			       char *buf, size_t size);
 
+int bpf__run_begin(FILE *out);
+int bpf__run_end(FILE *out);
 #else
 #include <errno.h>
 
-- 
2.13.6
