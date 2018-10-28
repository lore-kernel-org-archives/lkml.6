Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F10AECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F4620843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F4620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeJ1QP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeJ1QPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:15:24 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5431520892;
        Sun, 28 Oct 2018 07:31:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gGfXr-00087G-Bl; Sun, 28 Oct 2018 03:31:35 -0400
Message-Id: <20181028073135.265370416@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 28 Oct 2018 03:30:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 12/18] tracing: probeevent: Add $argN for accessing function args
References: <20181028072948.693267247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add $argN special fetch variable for accessing function
arguments. This allows user to trace the Nth argument easily
at the function entry.

Note that this returns most probably assignment of registers
and stacks. In some case, it may not work well. If you need
to access correct registers or stacks you should use perf-probe.

Link: http://lkml.kernel.org/r/152465888632.26224.3412465701570253696.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/kprobetrace.rst | 10 ++++----
 kernel/trace/trace.c                |  4 ++++
 kernel/trace/trace_kprobe.c         | 18 +++++++++++----
 kernel/trace/trace_probe.c          | 36 ++++++++++++++++++-----------
 kernel/trace/trace_probe.h          |  9 +++++++-
 kernel/trace/trace_uprobe.c         |  2 +-
 6 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 2dfed7a1ea6f..47e765c2f2c3 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -45,16 +45,18 @@ Synopsis of kprobe_events
   @SYM[+|-offs]	: Fetch memory at SYM +|- offs (SYM should be a data symbol)
   $stackN	: Fetch Nth entry of stack (N >= 0)
   $stack	: Fetch stack address.
-  $retval	: Fetch return value.(*)
+  $argN		: Fetch the Nth function argument. (N >= 1) (\*1)
+  $retval	: Fetch return value.(\*2)
   $comm		: Fetch current task comm.
-  +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(**)
+  +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(\*3)
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
 		  (x8/x16/x32/x64), "string" and bitfield are supported.
 
-  (*) only for return probe.
-  (**) this is useful for fetching a field of data structures.
+  (\*1) only for the probe on function entry (offs == 0).
+  (\*2) only for return probe.
+  (\*3) this is useful for fetching a field of data structures.
 
 Types
 -----
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e7f99f513959..ec5b21778806 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4625,7 +4625,11 @@ static const char readme_msg[] =
 #endif
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>\n"
+#else
 	"\t           $stack<index>, $stack, $retval, $comm\n"
+#endif
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>,\n"
 	"\t           <type>\\[<array-size>\\]\n"
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index fdd43f2f1fd1..3faaadbddf54 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -533,13 +533,15 @@ static int create_trace_kprobe(int argc, char **argv)
 	long offset = 0;
 	void *addr = NULL;
 	char buf[MAX_EVENT_NAME_LEN];
+	unsigned int flags = TPARG_FL_KERNEL;
 
 	/* argc must be >= 1 */
 	if (argv[0][0] == 'p')
 		is_return = false;
-	else if (argv[0][0] == 'r')
+	else if (argv[0][0] == 'r') {
 		is_return = true;
-	else if (argv[0][0] == '-')
+		flags |= TPARG_FL_RETURN;
+	} else if (argv[0][0] == '-')
 		is_delete = true;
 	else {
 		pr_info("Probe definition must be started with 'p', 'r' or"
@@ -625,8 +627,9 @@ static int create_trace_kprobe(int argc, char **argv)
 			pr_info("Failed to parse either an address or a symbol.\n");
 			return ret;
 		}
-		if (offset && is_return &&
-		    !kprobe_on_func_entry(NULL, symbol, offset)) {
+		if (kprobe_on_func_entry(NULL, symbol, offset))
+			flags |= TPARG_FL_FENTRY;
+		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
 			pr_info("Given offset is not valid for return probe.\n");
 			return -EINVAL;
 		}
@@ -696,7 +699,7 @@ static int create_trace_kprobe(int argc, char **argv)
 
 		/* Parse fetch argument */
 		ret = traceprobe_parse_probe_arg(arg, &tk->tp.size, parg,
-						 is_return, true);
+						 flags);
 		if (ret) {
 			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
 			goto error;
@@ -932,6 +935,11 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 	case FETCH_OP_COMM:
 		val = (unsigned long)current->comm;
 		break;
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	case FETCH_OP_ARG:
+		val = regs_get_kernel_argument(regs, code->param);
+		break;
+#endif
 	default:
 		return -EILSEQ;
 	}
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index dfd096031305..333cda6d2633 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -157,14 +157,13 @@ int traceprobe_split_symbol_offset(char *symbol, long *offset)
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
 static int parse_probe_vars(char *arg, const struct fetch_type *t,
-			    struct fetch_insn *code, bool is_return,
-			    bool is_kprobe)
+			    struct fetch_insn *code, unsigned int flags)
 {
 	int ret = 0;
 	unsigned long param;
 
 	if (strcmp(arg, "retval") == 0) {
-		if (is_return)
+		if (flags & TPARG_FL_RETURN)
 			code->op = FETCH_OP_RETVAL;
 		else
 			ret = -EINVAL;
@@ -173,7 +172,8 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 			code->op = FETCH_OP_STACKP;
 		} else if (isdigit(arg[5])) {
 			ret = kstrtoul(arg + 5, 10, &param);
-			if (ret || (is_kprobe && param > PARAM_MAX_STACK))
+			if (ret || ((flags & TPARG_FL_KERNEL) &&
+				    param > PARAM_MAX_STACK))
 				ret = -EINVAL;
 			else {
 				code->op = FETCH_OP_STACK;
@@ -183,6 +183,18 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 			ret = -EINVAL;
 	} else if (strcmp(arg, "comm") == 0) {
 		code->op = FETCH_OP_COMM;
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	} else if (((flags & TPARG_FL_MASK) ==
+		    (TPARG_FL_KERNEL | TPARG_FL_FENTRY)) &&
+		   strncmp(arg, "arg", 3) == 0) {
+		if (!isdigit(arg[3]))
+			return -EINVAL;
+		ret = kstrtoul(arg + 3, 10, &param);
+		if (ret || !param || param > PARAM_MAX_STACK)
+			return -EINVAL;
+		code->op = FETCH_OP_ARG;
+		code->param = (unsigned int)param - 1;
+#endif
 	} else
 		ret = -EINVAL;
 
@@ -193,7 +205,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 static int
 parse_probe_arg(char *arg, const struct fetch_type *type,
 		struct fetch_insn **pcode, struct fetch_insn *end,
-		bool is_return, bool is_kprobe)
+		unsigned int flags)
 {
 	struct fetch_insn *code = *pcode;
 	unsigned long param;
@@ -203,8 +215,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 	switch (arg[0]) {
 	case '$':
-		ret = parse_probe_vars(arg + 1, type, code,
-					is_return, is_kprobe);
+		ret = parse_probe_vars(arg + 1, type, code, flags);
 		break;
 
 	case '%':	/* named register */
@@ -226,7 +237,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			code->immediate = param;
 		} else if (arg[1] == '+') {
 			/* kprobes don't support file offsets */
-			if (is_kprobe)
+			if (flags & TPARG_FL_KERNEL)
 				return -EINVAL;
 
 			ret = kstrtol(arg + 2, 0, &offset);
@@ -237,7 +248,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			code->immediate = (unsigned long)offset;  // imm64?
 		} else {
 			/* uprobes don't support symbols */
-			if (!is_kprobe)
+			if (!(flags & TPARG_FL_KERNEL))
 				return -EINVAL;
 
 			ret = traceprobe_split_symbol_offset(arg + 1, &offset);
@@ -278,8 +289,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			const struct fetch_type *t2 = find_fetch_type(NULL);
 
 			*tmp = '\0';
-			ret = parse_probe_arg(arg, t2, &code, end, is_return,
-					      is_kprobe);
+			ret = parse_probe_arg(arg, t2, &code, end, flags);
 			if (ret)
 				break;
 			if (code->op == FETCH_OP_COMM)
@@ -339,7 +349,7 @@ static int __parse_bitfield_probe_arg(const char *bf,
 
 /* String length checking wrapper */
 int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
-		struct probe_arg *parg, bool is_return, bool is_kprobe)
+		struct probe_arg *parg, unsigned int flags)
 {
 	struct fetch_insn *code, *scode, *tmp = NULL;
 	char *t, *t2;
@@ -397,7 +407,7 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
 
 	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
-			      is_return, is_kprobe);
+			      flags);
 	if (ret)
 		goto fail;
 
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 1f456fd82483..09f62171cc23 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -23,6 +23,7 @@
 #include <linux/stringify.h>
 #include <linux/limits.h>
 #include <linux/uaccess.h>
+#include <linux/bitops.h>
 #include <asm/bitsperlong.h>
 
 #include "trace.h"
@@ -86,6 +87,7 @@ enum fetch_op {
 	FETCH_OP_RETVAL,	/* Return value */
 	FETCH_OP_IMM,		/* Immediate : .immediate */
 	FETCH_OP_COMM,		/* Current comm */
+	FETCH_OP_ARG,		/* Function argument : .param */
 	FETCH_OP_FOFFS,		/* File offset: .immediate */
 	// Stage 2 (dereference) op
 	FETCH_OP_DEREF,		/* Dereference: .offset */
@@ -263,8 +265,13 @@ find_event_file_link(struct trace_probe *tp, struct trace_event_file *file)
 	return NULL;
 }
 
+#define TPARG_FL_RETURN BIT(0)
+#define TPARG_FL_KERNEL BIT(1)
+#define TPARG_FL_FENTRY BIT(2)
+#define TPARG_FL_MASK	GENMASK(2, 0)
+
 extern int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
-		   struct probe_arg *parg, bool is_return, bool is_kprobe);
+		   struct probe_arg *parg, unsigned int flags);
 
 extern int traceprobe_conflict_field_name(const char *name,
 			       struct probe_arg *args, int narg);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 7154473ffaa4..394b93572506 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -557,7 +557,7 @@ static int create_trace_uprobe(int argc, char **argv)
 
 		/* Parse fetch argument */
 		ret = traceprobe_parse_probe_arg(arg, &tu->tp.size, parg,
-						 is_return, false);
+					is_return ? TPARG_FL_RETURN : 0);
 		if (ret) {
 			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
 			goto error;
-- 
2.19.0


