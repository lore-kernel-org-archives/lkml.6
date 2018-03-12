Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeCLJng (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:43:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932410AbeCLJnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:31 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 10/13] libbpf: Add bpf_object__run_(begin|end) functions
Date: Mon, 12 Mar 2018 10:43:10 +0100
Message-Id: <20180312094313.18738-11-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bpf_object__run_(begin|end) functions to run
BEGIN/END code for specific object.

Link: http://lkml.kernel.org/n/tip-hj1hwb7fshdwco706j22ela3@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 30 ++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h |  4 ++++
 2 files changed, 34 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 26231e278bb8..f1f999d64d6a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -45,6 +45,7 @@
 
 #include "libbpf.h"
 #include "bpf.h"
+#include "interp.h"
 
 #ifndef EM_BPF
 #define EM_BPF 247
@@ -2107,3 +2108,32 @@ int bpf_prog_load(const char *file, enum bpf_prog_type type,
 	*prog_fd = bpf_program__fd(first_prog);
 	return 0;
 }
+
+static u64 bpf_program__run(struct bpf_program *prog,
+			    struct bpf_insn *insn,
+			    struct bpf_interp *interp)
+{
+	interp->insns       = prog->insns;
+	interp->insns_cnt   = prog->insns_cnt;
+	interp->insns_start = insn - prog->insns;
+
+	return bpf_interp__run(interp);
+}
+
+u64 bpf_object__run_begin(struct bpf_object *obj, struct bpf_interp *interp)
+{
+	struct bpf_program *prog = obj->text;
+	struct bpf_insn *insn = obj->insn_begin;
+
+	pr_debug("running BEGIN(%p) for %s\n", insn, prog->name);
+	return insn && bpf_program__run(obj->text, insn, interp);
+}
+
+u64 bpf_object__run_end(struct bpf_object *obj, struct bpf_interp *interp)
+{
+	struct bpf_program *prog = obj->text;
+	struct bpf_insn *insn = obj->insn_end;
+
+	pr_debug("running END(%p) for %s\n", insn, prog->name);
+	return insn && bpf_program__run(obj->text, insn, interp);
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index bfc4d0411ec5..8ac4d4efcc1b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -96,6 +96,10 @@ struct bpf_program;
 struct bpf_program *bpf_program__next(struct bpf_program *prog,
 				      struct bpf_object *obj);
 
+struct bpf_interp;
+u64 bpf_object__run_begin(struct bpf_object *obj, struct bpf_interp *interp);
+u64 bpf_object__run_end(struct bpf_object *obj, struct bpf_interp *interp);
+
 #define bpf_object__for_each_program(pos, obj)		\
 	for ((pos) = bpf_program__next(NULL, (obj));	\
 	     (pos) != NULL;				\
-- 
2.13.6
