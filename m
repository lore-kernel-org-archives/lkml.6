Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+LlFcJHZLJxvhT0EMEul/0A1Npa9o2sDOcTJIZULo7O7mNNFWHWhFBfOS/jOnCdJ5efffY
ARC-Seal: i=1; a=rsa-sha256; t=1524658912; cv=none;
        d=google.com; s=arc-20160816;
        b=nDPsrgJdQZrCTliqJTz80ze2xklIIi24MPrIXYgeSiyRSZqPAFJ+QOwZH+r21M8X3x
         OQskN3lSwfJkdnbspEaGZIVaKO0ndwO2x4CZ/eDoEwoU/5clol1xDQ6NsEZDx5qSmYf7
         J7X9aQFHgQfRmJpxDTAvUKLeetLkcpLae1WZR235qmhf+BHgonVbJARnaFn0nacEB+OH
         MW7LLsFn1YQqmeZJPaTbPbnQJQjabUZ2cAK6lnpYylLcbYzUP02HOYFn/Euzu9S1l6b3
         N0qoMsR1RWHGMJzLOUzhoO/Mml17Nz7pJLVPpA8prDZQg/eQk+vTgTemCYm0IJP4iRzo
         F18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=O8vxZc/OepvbB9GLrdZXZnmrxd5L7vlGNVVZCus6l2s=;
        b=oDqsxbSe/3DVSSCCrfWgXPVoaDUmwiaTF2UMlerDyOal98ehmDVNoPABv3s7ajjlEO
         Eks1/CAtLNeEfIKRo/q1lGa5ar34YI9z1VHWaBDU1h8OHfmD+Ergu7NYLQrupKe6gYDW
         5EtrOGT7uAswtcNWVTWA6wQtdLpXr3iV5RhqgRt+7EocJiV31MQgpBHtSVbkoTAldY0x
         UVZcUdxlYvB8smVvsZRXynLwXjLyThF5MIw3qs19uUj0gstivAKgyYDqgNuPtghqgF/j
         dXK/FuEnH/mpCGhILd8GleCLEcV+GqRo/2X8x7xBriic/rCrJQTBVyPw3qdC3M7Gj58P
         QYbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeDYMVv (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 08:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752189AbeDYMVu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 08:21:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AEA21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v7 11/16] tracing: probeevent: Add $argN for accessing function args
Date: Wed, 25 Apr 2018 21:21:26 +0900
Message-Id: <152465888632.26224.3412465701570253696.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152465856498.26224.16969986455942749517.stgit@devbox>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598720743835108810?=
X-GMAIL-MSGID: =?utf-8?q?1598720743835108810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add $argN special fetch variable for accessing function
arguments. This allows user to trace the Nth argument easily
at the function entry.

Note that this returns most probably assignment of registers
and stacks. In some case, it may not work well. If you need
to access correct registers or stacks you should use perf-probe.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Add $argN in README file
  - Make N start from 1 as same as auto-generate event argument
    names.
 Changes in v3:
  - Show $arg<N> in README only when this feature is supported.
 Changes in v7:
  - Update document for restructured text.
---
 Documentation/trace/kprobetrace.rst |   10 ++++++----
 kernel/trace/trace.c                |    4 ++++
 kernel/trace/trace_kprobe.c         |   18 +++++++++++++-----
 kernel/trace/trace_probe.c          |   36 ++++++++++++++++++++++-------------
 kernel/trace/trace_probe.h          |    9 ++++++++-
 kernel/trace/trace_uprobe.c         |    2 +-
 6 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index c920c9be221a..30eb37391064 100644
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
index 4812ae046f43..7add9bfdff76 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4620,7 +4620,11 @@ static const char readme_msg[] =
 #endif
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>\n"
+#else
 	"\t           $stack<index>, $stack, $retval, $comm\n"
+#endif
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>\n"
 #endif
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 673d4b06edd4..b6d33401b629 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -490,13 +490,15 @@ static int create_trace_kprobe(int argc, char **argv)
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
@@ -579,8 +581,9 @@ static int create_trace_kprobe(int argc, char **argv)
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
@@ -650,7 +653,7 @@ static int create_trace_kprobe(int argc, char **argv)
 
 		/* Parse fetch argument */
 		ret = traceprobe_parse_probe_arg(arg, &tk->tp.size, parg,
-						 is_return, true);
+						 flags);
 		if (ret) {
 			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
 			goto error;
@@ -886,6 +889,11 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
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
index e2a31087f1f8..9458800f394a 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -169,14 +169,13 @@ int traceprobe_split_symbol_offset(char *symbol, long *offset)
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
@@ -185,7 +184,8 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 			code->op = FETCH_OP_STACKP;
 		} else if (isdigit(arg[5])) {
 			ret = kstrtoul(arg + 5, 10, &param);
-			if (ret || (is_kprobe && param > PARAM_MAX_STACK))
+			if (ret || ((flags & TPARG_FL_KERNEL) &&
+				    param > PARAM_MAX_STACK))
 				ret = -EINVAL;
 			else {
 				code->op = FETCH_OP_STACK;
@@ -195,6 +195,18 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
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
 
@@ -205,7 +217,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 static int
 parse_probe_arg(char *arg, const struct fetch_type *type,
 		struct fetch_insn **pcode, struct fetch_insn *end,
-		bool is_return, bool is_kprobe)
+		unsigned int flags)
 {
 	struct fetch_insn *code = *pcode;
 	unsigned long param;
@@ -215,8 +227,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 	switch (arg[0]) {
 	case '$':
-		ret = parse_probe_vars(arg + 1, type, code,
-					is_return, is_kprobe);
+		ret = parse_probe_vars(arg + 1, type, code, flags);
 		break;
 
 	case '%':	/* named register */
@@ -238,7 +249,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			code->immediate = param;
 		} else if (arg[1] == '+') {
 			/* kprobes don't support file offsets */
-			if (is_kprobe)
+			if (flags & TPARG_FL_KERNEL)
 				return -EINVAL;
 
 			ret = kstrtol(arg + 2, 0, &offset);
@@ -249,7 +260,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			code->immediate = (unsigned long)offset;  // imm64?
 		} else {
 			/* uprobes don't support symbols */
-			if (!is_kprobe)
+			if (!(flags & TPARG_FL_KERNEL))
 				return -EINVAL;
 
 			ret = traceprobe_split_symbol_offset(arg + 1, &offset);
@@ -290,8 +301,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			const struct fetch_type *t2 = find_fetch_type(NULL);
 
 			*tmp = '\0';
-			ret = parse_probe_arg(arg, t2, &code, end, is_return,
-					      is_kprobe);
+			ret = parse_probe_arg(arg, t2, &code, end, flags);
 			if (ret)
 				break;
 			if (code->op == FETCH_OP_COMM)
@@ -351,7 +361,7 @@ static int __parse_bitfield_probe_arg(const char *bf,
 
 /* String length checking wrapper */
 int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
-		struct probe_arg *parg, bool is_return, bool is_kprobe)
+		struct probe_arg *parg, unsigned int flags)
 {
 	struct fetch_insn *code, *tmp = NULL;
 	const char *t;
@@ -391,7 +401,7 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
 
 	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
-			      is_return, is_kprobe);
+			      flags);
 	if (ret)
 		goto fail;
 
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index ef477bd8468a..ff91faf70887 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -35,6 +35,7 @@
 #include <linux/stringify.h>
 #include <linux/limits.h>
 #include <linux/uaccess.h>
+#include <linux/bitops.h>
 #include <asm/bitsperlong.h>
 
 #include "trace.h"
@@ -89,6 +90,7 @@ enum fetch_op {
 	FETCH_OP_RETVAL,	/* Return value */
 	FETCH_OP_IMM,		/* Immediate : .immediate */
 	FETCH_OP_COMM,		/* Current comm */
+	FETCH_OP_ARG,		/* Function argument : .param */
 	FETCH_OP_FOFFS,		/* File offset: .immediate */
 	// Stage 2 (dereference) op
 	FETCH_OP_DEREF,		/* Dereference: .offset */
@@ -261,8 +263,13 @@ find_event_file_link(struct trace_probe *tp, struct trace_event_file *file)
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
index 2cf8faeb5b72..bb68e6af1ef5 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -519,7 +519,7 @@ static int create_trace_uprobe(int argc, char **argv)
 
 		/* Parse fetch argument */
 		ret = traceprobe_parse_probe_arg(arg, &tu->tp.size, parg,
-						 is_return, false);
+					is_return ? TPARG_FL_RETURN : 0);
 		if (ret) {
 			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
 			goto error;

