Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934377AbeBMPkE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933594AbeBMPkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:40:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD76217B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org
Subject: [RFC PATCH 8/8] tracing: probeevent: Add an array for basic types
Date: Wed, 14 Feb 2018 00:39:37 +0900
Message-Id: <151853637718.31487.16480598027821035510.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151853614489.31487.10683006682475678487.stgit@devbox>
References: <151853614489.31487.10683006682475678487.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an array for basic types. This allows user to get arraied
basic types from memory address.
The array type syntax is

	TYPE[N]

Where TYPE is one of basic type (u8/16/32/64,s8/16/32/64, and
x8/16/32/64) and N is a fixed value.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/kprobetrace.txt |    7 ++
 kernel/trace/trace_kprobe.c         |   17 +++++
 kernel/trace/trace_probe.c          |  111 ++++++++++++++++++++++++++---------
 kernel/trace/trace_probe.h          |   29 ++++++++-
 kernel/trace/trace_uprobe.c         |   17 +++++
 5 files changed, 144 insertions(+), 37 deletions(-)

diff --git a/Documentation/trace/kprobetrace.txt b/Documentation/trace/kprobetrace.txt
index ec34640becbd..17d3e1a97d85 100644
--- a/Documentation/trace/kprobetrace.txt
+++ b/Documentation/trace/kprobetrace.txt
@@ -65,6 +65,13 @@ in decimal ('s' and 'u') or hexadecimal ('x'). Without type casting, 'x32'
 or 'x64' is used depends on the architecture (e.g. x86-32 uses x32, and
 x86-64 uses x64).
 
+These value types can be an array. To record array data, you can add '[N]'
+(where N is a fixed number, less than 64) to the base type.
+E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
+Note that the array can be applied to memory type fetchargs, you can not
+apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
+wrong, but '+8($stack):x8[8]' is OK.)
+
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
 has been paged out.
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index cab5efe0a66c..45e00de573d3 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -835,8 +835,9 @@ static int
 process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		   bool pre)
 {
+	struct fetch_insn *s3 = NULL;
 	unsigned long val;
-	int ret;
+	int ret, i = 0;
 
 	/* 1st stage: get value from context */
 	switch (code->op) {
@@ -877,6 +878,8 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		code++;
 	}
 
+stage3:
+	s3 = code;
 	/* 3rd stage: store value to buffer */
 	switch (code->op) {
 	case FETCH_OP_ST_RAW:
@@ -902,6 +905,16 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		code++;
 	}
 
+	/* the last stage: Loop on array */
+	if (code->op == FETCH_OP_LP_ARRAY) {
+		if (++i < code->param) {
+			code = s3;
+			val += s3->size;
+			dest += s3->size;
+			goto stage3;
+		}
+	}
+
 	return code->op == FETCH_OP_END ? 0 : -EILSEQ;
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
@@ -1248,7 +1261,7 @@ static int register_kprobe_event(struct trace_kprobe *tk)
 		call->event.funcs = &kprobe_funcs;
 		call->class->define_fields = kprobe_event_define_fields;
 	}
-	if (set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0)
+	if (traceprobe_set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0)
 		return -ENOMEM;
 	ret = register_trace_event(&call->event);
 	if (!ret) {
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 491a640a1a3e..ae96f98506f0 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -378,8 +378,8 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 		struct probe_arg *parg, unsigned int flags)
 {
 	struct fetch_insn *code, *tmp = NULL;
-	const char *t;
-	int ret;
+	char *t, *t2;
+	int ret, len;
 
 	if (strlen(arg) > MAX_ARGSTR_LEN) {
 		pr_info("Argument is too long.: %s\n",  arg);
@@ -390,24 +390,40 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 		pr_info("Failed to allocate memory for command '%s'.\n", arg);
 		return -ENOMEM;
 	}
-	t = strchr(parg->comm, ':');
+	t = strchr(arg, ':');
 	if (t) {
-		arg[t - parg->comm] = '\0';
-		t++;
+		*t = '\0';
+		t2 = strchr(++t, '[');
+		if (t2) {
+			*t2 = '\0';
+			parg->count = simple_strtoul(t2 + 1, &t2, 0);
+			if (strcmp(t2, "]") || parg->count == 0)
+				return -EINVAL;
+		}
 	}
 	/*
 	 * The default type of $comm should be "string", and it can't be
 	 * dereferenced.
 	 */
 	if (!t && strcmp(arg, "$comm") == 0)
-		t = "string";
-	parg->type = find_fetch_type(t);
+		parg->type = find_fetch_type("string");
+	else
+		parg->type = find_fetch_type(t);
 	if (!parg->type) {
 		pr_info("Unsupported type: %s\n", t);
 		return -EINVAL;
 	}
 	parg->offset = *size;
-	*size += parg->type->size;
+	*size += parg->type->size * (parg->count ?: 1);
+
+	if (parg->count) {
+		len = strlen(parg->type->fmttype) + 6;
+		parg->fmt = kmalloc(len, GFP_KERNEL);
+		if (!parg->fmt)
+			return -ENOMEM;
+		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
+			 parg->count);
+	}
 
 	code = tmp = kzalloc(sizeof(*code) * FETCH_INSN_MAX, GFP_KERNEL);
 	if (!code)
@@ -453,6 +469,21 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 		if (ret)
 			goto fail;
 	}
+	/* Loop(Array) operation */
+	if (parg->count) {
+		if (code->op != FETCH_OP_ST_MEM) {
+			pr_info("array only accepts memory or address\n");
+			ret = -EINVAL;
+			goto fail;
+		}
+		code++;
+		if (code->op != FETCH_OP_NOP) {
+			ret = -E2BIG;
+			goto fail;
+		}
+		code->op = FETCH_OP_LP_ARRAY;
+		code->param = parg->count;
+	}
 	code++;
 	code->op = FETCH_OP_END;
 
@@ -491,14 +522,17 @@ void traceprobe_free_probe_arg(struct probe_arg *arg)
 	kfree(arg->code);
 	kfree(arg->name);
 	kfree(arg->comm);
+	kfree(arg->fmt);
 }
 
+/* When len=0, we just calculate the needed length */
+#define LEN_OR_ZERO (len ? len - pos : 0)
 static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 			   bool is_return)
 {
-	int i;
+	struct probe_arg *parg;
+	int i, j;
 	int pos = 0;
-
 	const char *fmt, *arg;
 
 	if (!is_return) {
@@ -509,35 +543,51 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 		arg = "REC->" FIELD_STRING_FUNC ", REC->" FIELD_STRING_RETIP;
 	}
 
-	/* When len=0, we just calculate the needed length */
-#define LEN_OR_ZERO (len ? len - pos : 0)
-
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"%s", fmt);
 
 	for (i = 0; i < tp->nr_args; i++) {
-		pos += snprintf(buf + pos, LEN_OR_ZERO, " %s=%s",
-				tp->args[i].name, tp->args[i].type->fmt);
+		parg = tp->args + i;
+		pos += snprintf(buf + pos, LEN_OR_ZERO, " %s=", parg->name);
+		if (parg->count) {
+			pos += snprintf(buf + pos, LEN_OR_ZERO, "{%s",
+					parg->type->fmt);
+			for (j = 1; j < parg->count; j++)
+				pos += snprintf(buf + pos, LEN_OR_ZERO, ",%s",
+						parg->type->fmt);
+			pos += snprintf(buf + pos, LEN_OR_ZERO, "}");
+		} else
+			pos += snprintf(buf + pos, LEN_OR_ZERO, "%s",
+					parg->type->fmt);
 	}
 
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\", %s", arg);
 
 	for (i = 0; i < tp->nr_args; i++) {
-		if (strcmp(tp->args[i].type->name, "string") == 0)
+		parg = tp->args + i;
+		if (parg->count) {
+			if (strcmp(parg->type->name, "string") == 0)
+				fmt = ", __get_str(%s[%d])";
+			else
+				fmt = ", REC->%s[%d]";
+			for (j = 0; j < parg->count; j++)
+				pos += snprintf(buf + pos, LEN_OR_ZERO,
+						fmt, parg->name, j);
+		} else {
+			if (strcmp(parg->type->name, "string") == 0)
+				fmt = ", __get_str(%s)";
+			else
+				fmt = ", REC->%s";
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
-					", __get_str(%s)",
-					tp->args[i].name);
-		else
-			pos += snprintf(buf + pos, LEN_OR_ZERO, ", REC->%s",
-					tp->args[i].name);
+					fmt, parg->name);
+		}
 	}
 
-#undef LEN_OR_ZERO
-
 	/* return the length of print_fmt */
 	return pos;
 }
+#undef LEN_OR_ZERO
 
-int set_print_fmt(struct trace_probe *tp, bool is_return)
+int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return)
 {
 	int len;
 	char *print_fmt;
@@ -563,11 +613,16 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	/* Set argument names as fields */
 	for (i = 0; i < tp->nr_args; i++) {
 		struct probe_arg *parg = &tp->args[i];
-
-		ret = trace_define_field(event_call, parg->type->fmttype,
-					 parg->name,
+		const char *fmt = parg->type->fmttype;
+		int size = parg->type->size;
+
+		if (parg->fmt)
+			fmt = parg->fmt;
+		if (parg->count)
+			size *= parg->count;
+		ret = trace_define_field(event_call, fmt, parg->name,
 					 offset + parg->offset,
-					 parg->type->size,
+					 parg->type->size * parg->count,
 					 parg->type->is_signed,
 					 FILTER_OTHER);
 		if (ret)
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index c23aa7e20502..62e68e4ef80b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -114,6 +114,8 @@ enum fetch_op {
 	FETCH_OP_ST_STRING,	/* String: .offset, .size */
 	// Stage 4 (modify) op
 	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
+	// Stage 5 (loop) op
+	FETCH_OP_LP_ARRAY,	/* Array: .param = loop count */
 	FETCH_OP_END,
 };
 
@@ -203,13 +205,16 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 	_ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, atype)
 
 #define ASSIGN_FETCH_TYPE_END {}
+#define MAX_ARRAY_LEN	64
 
 struct probe_arg {
 	struct fetch_insn	*code;
 	bool			dynamic;/* Dynamic array (string) is used */
 	unsigned int		offset;	/* Offset from argument entry */
+	unsigned int		count;	/* Array count */
 	const char		*name;	/* Name of this argument */
 	const char		*comm;	/* Command of this argument */
+	char			*fmt;	/* Format string if needed */
 	const struct fetch_type	*type;	/* Type of this argument */
 };
 
@@ -385,16 +390,30 @@ static inline int
 print_probe_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
 		 u8 *data, void *field)
 {
-	int i;
+	void *p;
+	int i, j;
 
 	for (i = 0; i < nr_args; i++) {
-		trace_seq_printf(s, " %s=", args[i].name);
-		if (!args[i].type->print(s, data + args[i].offset, field))
-			return -ENOMEM;
+		struct probe_arg *a = args + i;
+
+		trace_seq_printf(s, " %s=", a->name);
+		if (likely(!a->count)) {
+			if (!a->type->print(s, data + a->offset, field))
+				return -ENOMEM;
+			continue;
+		}
+		trace_seq_putc(s, '{');
+		p = data + a->offset;
+		for (j = 0; j < a->count; j++) {
+			if (!a->type->print(s, p, field))
+				return -ENOMEM;
+			trace_seq_putc(s, j == a->count - 1 ? '}' : ',');
+			p += a->type->size;
+		}
 	}
 	return 0;
 }
 
-extern int set_print_fmt(struct trace_probe *tp, bool is_return);
+extern int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return);
 extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 					size_t offset, struct trace_probe *tp);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index d6479af1e6ac..6fc7ea0159d4 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -173,8 +173,9 @@ static int
 process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		   bool pre)
 {
+	struct fetch_insn *s3 = NULL;
 	unsigned long val;
-	int ret;
+	int ret, i = 0;
 
 	/* 1st stage: get value from context */
 	switch (code->op) {
@@ -210,6 +211,8 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		code++;
 	}
 
+stage3:
+	s3 = code;
 	/* 3rd stage: store value to buffer */
 	switch (code->op) {
 	case FETCH_OP_ST_RAW:
@@ -235,6 +238,16 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		code++;
 	}
 
+	/* the last stage: Loop on array */
+	if (code->op == FETCH_OP_LP_ARRAY) {
+		if (++i < code->param) {
+			code = s3;
+			val += s3->size;
+			dest += s3->size;
+			goto stage3;
+		}
+	}
+
 	return code->op == FETCH_OP_END ? 0 : -EILSEQ;
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
@@ -1303,7 +1316,7 @@ static int register_uprobe_event(struct trace_uprobe *tu)
 	call->event.funcs = &uprobe_funcs;
 	call->class->define_fields = uprobe_event_define_fields;
 
-	if (set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0)
+	if (traceprobe_set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0)
 		return -ENOMEM;
 
 	ret = register_trace_event(&call->event);
