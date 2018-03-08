Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvRMbiW2dbP5gCZfKzlr/L5wQSyGeh7jIjG+CBMsGqAXJipLqwObKk2xtwh9GTWbD2wpyj3
ARC-Seal: i=1; a=rsa-sha256; t=1520499076; cv=none;
        d=google.com; s=arc-20160816;
        b=ktLvUf0LTLduiIUFsWHAPDuXkArNl1Bn3BIgaAMyZiI/3HqPbw7xN3oTwREsAzE54a
         /fdEAHfdqQaehu6Xw8PxJauSKibKrJ0QAJzpEJVaVr/27jCFsgqvUX4iOMrpDDcYM73h
         zlOd1/CsVVDPfXPQxRawuOi6T8Jy78aVShAvYPD+qZwHZxXDJe+rxhm9DreSRTRXFIJw
         wlAldJYQWac3jiJTUL4X8TF+CBAfySC1CHgO7wA110Gfl3g3XNPdQEfypYJQsIdOCFyn
         y326ZlhgWZrlD8O/KzrGJrbS7TNQxV1LIaITQGSfAw9osN8CucrRbGHnSPt3RKqDjNC0
         SY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=Z5TAdhhpMS2lK9rivWdEdIAT4f0HC64q7fYVIn7f5/M=;
        b=jQJOSj/XPlZpKUXRV/vBFlExQelfaFB53pTqTTzEU9SbzwLuOO7HfoRSQn+xtKFAyZ
         /JPs56ZI+8LjGLm2SOZYjucn+TL3lrsUwvOKn2ipGYwBwEONJaI+VNnRRw4ccqdBBskc
         5765ZxHffyTtdqoKs2gjA0Yr7c487BJ4SFN0I1ivIJ9ndJFiGY1v+wqfzy0dkBxff1pf
         jwpnHoKjLXzeCTx733LagrXyN6r0J0lSRiHZ2B2Y5B8xrP+su3Sfp82200RQaF3Z3W54
         A3D8dFbGh2B3sebEivZC+8ud3Ux/nPZxkKvD/2pH15zNaVHb+W9nkWzDxPGo5Qxb9Wj7
         uEUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933516AbeCHIvQ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 03:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbeCHIvP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 03:51:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BDC2172D
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
Subject: [PATCH v5 16/19] tracing: probeevent: Add array type support
Date: Thu,  8 Mar 2018 17:50:51 +0900
Message-Id: <152049905133.7289.17516121776689315422.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152049860385.7289.14079393589900496424.stgit@devbox>
References: <152049860385.7289.14079393589900496424.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358839822578667?=
X-GMAIL-MSGID: =?utf-8?q?1594358839822578667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add array type support for probe events.
This allows user to get arraied types from memory address.
The array type syntax is

	TYPE[N]

Where TYPE is one of types (u8/16/32/64,s8/16/32/64,
x8/16/32/64, symbol, string) and N is a fixed value less
than 64.

The string array type is a bit different from other types. For
other base types, <base-type>[1] is equal to <base-type>
(e.g. +0(%di):x32[1] is same as +0(%di):x32.) But string[1] is not
equal to string. The string type itself represents "char array",
but string array type represents "char * array". So, for example,
+0(%di):string[1] is equal to +0(+0(%di)):string.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v4:
  - Fix to use calculated size correctly for field definition.
    (Thank you Namhyung!)
 Changes in v2:
  - Add array description in README file
  - Fix to init s3 code out of loop.
  - Fix to proceed code when the last code is OP_ARRAY.
  - Add string array type and bitfield array type.
---
 Documentation/trace/kprobetrace.txt |   13 ++++
 kernel/trace/trace.c                |    3 +
 kernel/trace/trace_probe.c          |  130 +++++++++++++++++++++++++++--------
 kernel/trace/trace_probe.h          |   14 ++++
 kernel/trace/trace_probe_tmpl.h     |   63 +++++++++++++++--
 5 files changed, 183 insertions(+), 40 deletions(-)

diff --git a/Documentation/trace/kprobetrace.txt b/Documentation/trace/kprobetrace.txt
index 1d082f8ffeee..8bf752dfc072 100644
--- a/Documentation/trace/kprobetrace.txt
+++ b/Documentation/trace/kprobetrace.txt
@@ -65,9 +65,22 @@ in decimal ('s' and 'u') or hexadecimal ('x'). Without type casting, 'x32'
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
+The string array type is a bit different from other types. For other base
+types, <base-type>[1] is equal to <base-type> (e.g. +0(%di):x32[1] is same
+as +0(%di):x32.) But string[1] is not equal to string. The string type itself
+represents "char array", but string array type represents "char * array".
+So, for example, +0(%di):string[1] is equal to +0(+0(%di)):string.
+
 Bitfield is another special type, which takes 3 parameters, bit-width, bit-
 offset, and container-size (usually 32). The syntax is;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bcd1fd87082d..b7c6698265e5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4614,7 +4614,8 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm\n"
 #endif
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
-	"\t           b<bit-width>@<bit-offset>/<container-size>\n"
+	"\t           b<bit-width>@<bit-offset>/<container-size>,\n"
+	"\t           <type>[<array-size>]\n"
 #endif
 	"  events/\t\t- Directory containing all trace event subsystems:\n"
 	"      enable\t\t- Write 0/1 to enable/disable tracing of all events\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9458800f394a..0e185050e492 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -363,9 +363,9 @@ static int __parse_bitfield_probe_arg(const char *bf,
 int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 		struct probe_arg *parg, unsigned int flags)
 {
-	struct fetch_insn *code, *tmp = NULL;
-	const char *t;
-	int ret;
+	struct fetch_insn *code, *scode, *tmp = NULL;
+	char *t, *t2;
+	int ret, len;
 
 	if (strlen(arg) > MAX_ARGSTR_LEN) {
 		pr_info("Argument is too long.: %s\n",  arg);
@@ -376,24 +376,42 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
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
+			if (parg->count > MAX_ARRAY_LEN)
+				return -E2BIG;
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
@@ -413,10 +431,20 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 			ret = -EINVAL;
 			goto fail;
 		}
-		/* Since IMM or COMM must be the 1st insn, this is safe */
-		if (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM)
+		if (code->op != FETCH_OP_DEREF || parg->count) {
+			/*
+			 * IMM and COMM is pointing actual address, those must
+			 * be kept, and if parg->count != 0, this is an array
+			 * of string pointers instead of string address itself.
+			 */
 			code++;
+			if (code->op != FETCH_OP_NOP) {
+				ret = -E2BIG;
+				goto fail;
+			}
+		}
 		code->op = FETCH_OP_ST_STRING;	/* In DEREF case, replace it */
+		code->size = parg->type->size;
 		parg->dynamic = true;
 	} else if (code->op == FETCH_OP_DEREF) {
 		code->op = FETCH_OP_ST_MEM;
@@ -430,12 +458,29 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 		code->op = FETCH_OP_ST_RAW;
 		code->size = parg->type->size;
 	}
+	scode = code;
 	/* Modify operation */
 	if (t != NULL) {
 		ret = __parse_bitfield_probe_arg(t, parg->type, &code);
 		if (ret)
 			goto fail;
 	}
+	/* Loop(Array) operation */
+	if (parg->count) {
+		if (scode->op != FETCH_OP_ST_MEM &&
+		    scode->op != FETCH_OP_ST_STRING) {
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
 
@@ -474,14 +519,17 @@ void traceprobe_free_probe_arg(struct probe_arg *arg)
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
@@ -492,33 +540,49 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
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
 
 int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return)
 {
@@ -546,11 +610,15 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	/* Set argument names as fields */
 	for (i = 0; i < tp->nr_args; i++) {
 		struct probe_arg *parg = &tp->args[i];
-
-		ret = trace_define_field(event_call, parg->type->fmttype,
-					 parg->name,
-					 offset + parg->offset,
-					 parg->type->size,
+		const char *fmt = parg->type->fmttype;
+		int size = parg->type->size;
+
+		if (parg->fmt)
+			fmt = parg->fmt;
+		if (parg->count)
+			size *= parg->count;
+		ret = trace_define_field(event_call, fmt, parg->name,
+					 offset + parg->offset, size,
 					 parg->type->is_signed,
 					 FILTER_OTHER);
 		if (ret)
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index ff91faf70887..d256a19ee6d1 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -43,6 +43,7 @@
 
 #define MAX_TRACE_ARGS		128
 #define MAX_ARGSTR_LEN		63
+#define MAX_ARRAY_LEN		64
 #define MAX_STRING_SIZE		PATH_MAX
 
 /* Reserved field names */
@@ -78,6 +79,14 @@ static nokprobe_inline void *get_loc_data(u32 *dl, void *ent)
 	return (u8 *)ent + get_loc_offs(*dl);
 }
 
+static nokprobe_inline u32 update_data_loc(u32 loc, int consumed)
+{
+	u32 maxlen = get_loc_len(loc);
+	u32 offset = get_loc_offs(loc);
+
+	return make_data_loc(maxlen - consumed, offset + consumed);
+}
+
 /* Printing function type */
 typedef int (*print_type_func_t)(struct trace_seq *, void *, void *);
 
@@ -100,6 +109,8 @@ enum fetch_op {
 	FETCH_OP_ST_STRING,	/* String: .offset, .size */
 	// Stage 4 (modify) op
 	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
+	// Stage 5 (loop) op
+	FETCH_OP_LP_ARRAY,	/* Array: .param = loop count */
 	FETCH_OP_END,
 };
 
@@ -189,6 +200,7 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 	_ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, atype)
 
 #define ASSIGN_FETCH_TYPE_END {}
+#define MAX_ARRAY_LEN	64
 
 #ifdef CONFIG_KPROBE_EVENTS
 bool trace_kprobe_on_func_entry(struct trace_event_call *call);
@@ -209,8 +221,10 @@ struct probe_arg {
 	struct fetch_insn	*code;
 	bool			dynamic;/* Dynamic array (string) is used */
 	unsigned int		offset;	/* Offset from argument entry */
+	unsigned int		count;	/* Array count */
 	const char		*name;	/* Name of this argument */
 	const char		*comm;	/* Command of this argument */
+	char			*fmt;	/* Format string if needed */
 	const struct fetch_type	*type;	/* Type of this argument */
 };
 
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 32ae2fc78190..edc09f2cd6b2 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -67,10 +67,15 @@ static nokprobe_inline int
 process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 			   void *dest, void *base)
 {
-	int ret = 0;
+	struct fetch_insn *s3 = NULL;
+	int total = 0, ret = 0, i = 0;
+	u32 loc = 0;
+	unsigned long lval = val;
 
+stage2:
 	/* 2nd stage: dereference memory if needed */
 	while (code->op == FETCH_OP_DEREF) {
+		lval = val;
 		ret = probe_mem_read(&val, (void *)val + code->offset,
 					sizeof(val));
 		if (ret)
@@ -78,11 +83,15 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		code++;
 	}
 
+	s3 = code;
+stage3:
 	/* 3rd stage: store value to buffer */
 	if (unlikely(!dest)) {
-		if (code->op == FETCH_OP_ST_STRING)
-			return fetch_store_strlen(val + code->offset);
-		else
+		if (code->op == FETCH_OP_ST_STRING) {
+			ret += fetch_store_strlen(val + code->offset);
+			code++;
+			goto array;
+		} else
 			return -EILSEQ;
 	}
 
@@ -94,6 +103,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		probe_mem_read(dest, (void *)val + code->offset, code->size);
 		break;
 	case FETCH_OP_ST_STRING:
+		loc = *(u32 *)dest;
 		ret = fetch_store_string(val + code->offset, dest, base);
 		break;
 	default:
@@ -107,6 +117,29 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		code++;
 	}
 
+array:
+	/* the last stage: Loop on array */
+	if (code->op == FETCH_OP_LP_ARRAY) {
+		total += ret;
+		if (++i < code->param) {
+			code = s3;
+			if (s3->op != FETCH_OP_ST_STRING) {
+				dest += s3->size;
+				val += s3->size;
+				goto stage3;
+			}
+			code--;
+			val = lval + sizeof(char *);
+			if (dest) {
+				dest += sizeof(u32);
+				*(u32 *)dest = update_data_loc(loc, ret);
+			}
+			goto stage2;
+		}
+		code++;
+		ret = total;
+	}
+
 	return code->op == FETCH_OP_END ? ret : -EILSEQ;
 }
 
@@ -156,12 +189,26 @@ static inline int
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

