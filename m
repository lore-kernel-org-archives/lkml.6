Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225R8euNoo/xdj3BtcrXH6xLNJyGowuo7YVNRabDBBN8TeLNapz38O8Vwc3/Q/8mJgTKJgBR
ARC-Seal: i=1; a=rsa-sha256; t=1519450536; cv=none;
        d=google.com; s=arc-20160816;
        b=yNN3Msjxy6ldQCr4tbQrHY2IqKqZ0Qu6ZbZBubKmwsbv7TlJQkoJcl7Xzuf9Nq5Lb/
         4fkHPKcKwdysDNWBenyB2Qg8UXrKudbmeqMDrlJe14yA8RNQp+3vOl8jzI3geiG8Iwjq
         4HAwxKCQ29DDXnqGv2H/C5XaYnxcWsEUp8z9K8SPHn45VBvq6LvYJTHSlow2pMN710K/
         7Ws+KTThLRokb/3w7YwwzhFrwS6FQc1cRcSHvsKB9itCwIIndznMfnjQghGeefnF69m6
         R97J2f4MOLiod2r9vlEUSSs6RgwyITy6WtRvf9/tQ+R5LfgTrU5zwREwyY+IdBBGS/9y
         nPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=1QFcrr5RnGnu8emUJS2MpPUKURoKGKxlG4pJZkdQa/g=;
        b=xXghBLvD3nvfow1Tf9n1FYeDiTAtPuepxUl+ORbxXoF4Rhr2Ojtns6z8hpcqaEQTen
         r19xHKL35yjASmT0M4d9flwVfZxWR1/CdKTlnfNYv/aXKF6Gyl7KRpbSZGx5IKT5/uk8
         lYdpLiE0mg1di5tCb07WqIzPkEeuczL4pkpjF1VGp7NCzWgkKVvxalEn3KB2PJ7+fP86
         Fx5/pvi3mAPFvzjfko1y6DFvXe6Mja+O/zZiOCjl3c8g4OzSaM/9uEJk2JjaEVBKThNt
         PvhXrhhzxyjTIAj7++pBotiCTwd8HZ0EEJGynWMwaabaxi7R6osVePHRGPsSc0MEoAoO
         786w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeBXFfg (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 24 Feb 2018 00:35:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeBXFff (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Feb 2018 00:35:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1108C21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v3 14/18] tracing: probeevent: Add $argN for accessing function args
Date: Sat, 24 Feb 2018 14:35:11 +0900
Message-Id: <151945051099.27508.5752012656097018587.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151945010287.27508.6226184958678620828.stgit@devbox>
References: <151945010287.27508.6226184958678620828.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593259366176015166?=
X-GMAIL-MSGID: =?utf-8?q?1593259366176015166?=
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
---
 Documentation/trace/kprobetrace.txt |   10 ++++++----
 kernel/trace/trace.c                |    4 ++++
 kernel/trace/trace_kprobe.c         |   18 +++++++++++++-----
 kernel/trace/trace_probe.c          |   36 ++++++++++++++++++++++-------------
 kernel/trace/trace_probe.h          |    9 ++++++++-
 kernel/trace/trace_uprobe.c         |    2 +-
 6 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/Documentation/trace/kprobetrace.txt b/Documentation/trace/kprobetrace.txt
index d49381f2e411..1d082f8ffeee 100644
--- a/Documentation/trace/kprobetrace.txt
+++ b/Documentation/trace/kprobetrace.txt
@@ -43,16 +43,18 @@ Synopsis of kprobe_events
   @SYM[+|-offs]	: Fetch memory at SYM +|- offs (SYM should be a data symbol)
   $stackN	: Fetch Nth entry of stack (N >= 0)
   $stack	: Fetch stack address.
-  $retval	: Fetch return value.(*)
+  $argN		: Fetch the Nth function argument. (N >= 1) (*1)
+  $retval	: Fetch return value.(*2)
   $comm		: Fetch current task comm.
-  +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(**)
+  +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(*3)
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
 		  (x8/x16/x32/x64), "string" and bitfield are supported.
 
-  (*) only for return probe.
-  (**) this is useful for fetching a field of data structures.
+  (*1) only for the probe on function entry (offs == 0).
+  (*2) only for return probe.
+  (*3) this is useful for fetching a field of data structures.
 
 Types
 -----
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8f08811d15b8..bcd1fd87082d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4608,7 +4608,11 @@ static const char readme_msg[] =
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
index 292d5ae6d18b..e5a52b5f70ec 100644
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
@@ -890,6 +893,11 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
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
index 4c83b00ebec0..84887754702a 100644
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
index 64c1fbe087a1..e15da2281855 100644
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

