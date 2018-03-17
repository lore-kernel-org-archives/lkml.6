Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvCZ5akKFSmi01xlvfdLTB7cBeuS15Ekh10BB5l1HK7AaZasgopuGto2N/NJRTurCKEWuFf
ARC-Seal: i=1; a=rsa-sha256; t=1521290691; cv=none;
        d=google.com; s=arc-20160816;
        b=KhnNVOC03fG0aOFdJTkaJQxzLYbN7WOk7I31iyXkit0HQgxYWoxMynPw4vC2vMSc1k
         DoQV+JpWfuA2YoP9ACcV0Ojp+L0IUuHavZryG7VnFSOeJauCBxjcWxi2/dUEUQE0vX7T
         kh2cpgjFiEzTxq4j3UzfdQLWehnxCczCqjRyx1bCHT95UyKfXZK7SsBFWVAQNhsJIhuw
         FgOT5uMqrDYoYU8D8IKZ+ldDmIaYE4EGt5W87MaUpBgfHb/+7oRoo1lA5eyqGcwFXebf
         hv2REQDBV/87I1ADCAMsEfB2OsSQioonYtwBbIW3bjZt0jt6CNwd07IrX6X0x2IZDEIK
         Nrig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=L3ddK0ikvNqAaGp6LAhuWMU+NLk8G3lmPHXSEBn+O9M=;
        b=V+IZe5YLjuoqM6qMRr/qEblYP/fgM85i/Dncz0sdvWGukvRdM0sBMXCL4ppZ+3bb3P
         JDtOe8g7gQJAYU7JtYPT7UVZpE0rdMNU9vyQBmZbW+p7bLZjtzpooRuq8e0ltcgM09M5
         DQmuPND3nRiqY5C9NL4dr5iJ6CXu/YzoSsZKqRGNsfuzA7T2hkbpX8OqOi2WNgS370xB
         Kti+pTwzUgKyV81sxWVzlWzNSO76jn163JuCblE82490GF2VTu3rs4PJ21W4TTp57WrC
         z/csF5DgqrhFznVV3J/TLdJnVuHojxgsGlm7cUZOtmAM123/uPKsFL9X1ajIQjd1Z5UZ
         v4HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeCQMou (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 08:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbeCQMot (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 08:44:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D5E217BA
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
Subject: [PATCH v6 09/21] tracing: probeevent: Unify fetch type tables
Date: Sat, 17 Mar 2018 21:44:13 +0900
Message-Id: <152129065355.31874.6314953343388210669.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152129024033.31874.15800253385376959274.stgit@devbox>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595188907164979533?=
X-GMAIL-MSGID: =?utf-8?q?1595188907164979533?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Unify {k,u}probe_fetch_type_table to probe_fetch_type_table
because the main difference of those type tables (fetcharg
methods) are gone. Now we can consolidate it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   27 +---------------------
 kernel/trace/trace_probe.c  |   54 +++++++++++++++++++++++++++++--------------
 kernel/trace/trace_probe.h  |    6 +----
 kernel/trace/trace_uprobe.c |   27 +---------------------
 4 files changed, 39 insertions(+), 75 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 1d1e37058f8a..0b73b1ee82c8 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -122,30 +122,6 @@ static int kprobe_dispatcher(struct kprobe *kp, struct pt_regs *regs);
 static int kretprobe_dispatcher(struct kretprobe_instance *ri,
 				struct pt_regs *regs);
 
-/* Fetch type information table */
-static const struct fetch_type kprobes_fetch_type_table[] = {
-	/* Special types */
-	[FETCH_TYPE_STRING] = __ASSIGN_FETCH_TYPE("string", string, string,
-					sizeof(u32), 1, "__data_loc char[]"),
-	[FETCH_TYPE_STRSIZE] = __ASSIGN_FETCH_TYPE("string_size", u32,
-					string_size, sizeof(u32), 0, "u32"),
-	/* Basic types */
-	ASSIGN_FETCH_TYPE(u8,  u8,  0),
-	ASSIGN_FETCH_TYPE(u16, u16, 0),
-	ASSIGN_FETCH_TYPE(u32, u32, 0),
-	ASSIGN_FETCH_TYPE(u64, u64, 0),
-	ASSIGN_FETCH_TYPE(s8,  u8,  1),
-	ASSIGN_FETCH_TYPE(s16, u16, 1),
-	ASSIGN_FETCH_TYPE(s32, u32, 1),
-	ASSIGN_FETCH_TYPE(s64, u64, 1),
-	ASSIGN_FETCH_TYPE_ALIAS(x8,  u8,  u8,  0),
-	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
-	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
-	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
-
-	ASSIGN_FETCH_TYPE_END
-};
-
 /*
  * Allocate new trace_probe and initialize it (including kprobes).
  */
@@ -674,8 +650,7 @@ static int create_trace_kprobe(int argc, char **argv)
 
 		/* Parse fetch argument */
 		ret = traceprobe_parse_probe_arg(arg, &tk->tp.size, parg,
-						 is_return, true,
-						 kprobes_fetch_type_table);
+						 is_return, true);
 		if (ret) {
 			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
 			goto error;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 758968ac165d..ed3766fb290d 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -73,8 +73,29 @@ int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
 
 const char PRINT_TYPE_FMT_NAME(string)[] = "\\\"%s\\\"";
 
-static const struct fetch_type *find_fetch_type(const char *type,
-						const struct fetch_type *ftbl)
+/* Fetch type information table */
+static const struct fetch_type probe_fetch_types[] = {
+	/* Special types */
+	__ASSIGN_FETCH_TYPE("string", string, string, sizeof(u32), 1,
+			    "__data_loc char[]"),
+	/* Basic types */
+	ASSIGN_FETCH_TYPE(u8,  u8,  0),
+	ASSIGN_FETCH_TYPE(u16, u16, 0),
+	ASSIGN_FETCH_TYPE(u32, u32, 0),
+	ASSIGN_FETCH_TYPE(u64, u64, 0),
+	ASSIGN_FETCH_TYPE(s8,  u8,  1),
+	ASSIGN_FETCH_TYPE(s16, u16, 1),
+	ASSIGN_FETCH_TYPE(s32, u32, 1),
+	ASSIGN_FETCH_TYPE(s64, u64, 1),
+	ASSIGN_FETCH_TYPE_ALIAS(x8,  u8,  u8,  0),
+	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
+	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
+	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
+
+	ASSIGN_FETCH_TYPE_END
+};
+
+static const struct fetch_type *find_fetch_type(const char *type)
 {
 	int i;
 
@@ -95,21 +116,21 @@ static const struct fetch_type *find_fetch_type(const char *type,
 
 		switch (bs) {
 		case 8:
-			return find_fetch_type("u8", ftbl);
+			return find_fetch_type("u8");
 		case 16:
-			return find_fetch_type("u16", ftbl);
+			return find_fetch_type("u16");
 		case 32:
-			return find_fetch_type("u32", ftbl);
+			return find_fetch_type("u32");
 		case 64:
-			return find_fetch_type("u64", ftbl);
+			return find_fetch_type("u64");
 		default:
 			goto fail;
 		}
 	}
 
-	for (i = 0; ftbl[i].name; i++) {
-		if (strcmp(type, ftbl[i].name) == 0)
-			return &ftbl[i];
+	for (i = 0; probe_fetch_types[i].name; i++) {
+		if (strcmp(type, probe_fetch_types[i].name) == 0)
+			return &probe_fetch_types[i];
 	}
 
 fail:
@@ -176,8 +197,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 static int
 parse_probe_arg(char *arg, const struct fetch_type *type,
 		struct fetch_insn **pcode, struct fetch_insn *end,
-		bool is_return, bool is_kprobe,
-		const struct fetch_type *ftbl)
+		bool is_return, bool is_kprobe)
 {
 	struct fetch_insn *code = *pcode;
 	unsigned long param;
@@ -259,12 +279,11 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		tmp = strrchr(arg, ')');
 
 		if (tmp) {
-			const struct fetch_type *t2;
+			const struct fetch_type *t2 = find_fetch_type(NULL);
 
-			t2 = find_fetch_type(NULL, ftbl);
 			*tmp = '\0';
 			ret = parse_probe_arg(arg, t2, &code, end, is_return,
-					      is_kprobe, ftbl);
+					      is_kprobe);
 			if (ret)
 				break;
 			if (code->op == FETCH_OP_COMM)
@@ -324,8 +343,7 @@ static int __parse_bitfield_probe_arg(const char *bf,
 
 /* String length checking wrapper */
 int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
-		struct probe_arg *parg, bool is_return, bool is_kprobe,
-		const struct fetch_type *ftbl)
+		struct probe_arg *parg, bool is_return, bool is_kprobe)
 {
 	struct fetch_insn *code, *tmp = NULL;
 	const char *t;
@@ -351,7 +369,7 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 	 */
 	if (!t && strcmp(arg, "$comm") == 0)
 		t = "string";
-	parg->type = find_fetch_type(t, ftbl);
+	parg->type = find_fetch_type(t);
 	if (!parg->type) {
 		pr_info("Unsupported type: %s\n", t);
 		return -EINVAL;
@@ -365,7 +383,7 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
 
 	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
-			      is_return, is_kprobe, ftbl);
+			      is_return, is_kprobe);
 	if (ret)
 		goto fail;
 
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 9d9de7535d06..89d853ef5174 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -196,9 +196,6 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(string);
 
 #define ASSIGN_FETCH_TYPE_END {}
 
-#define FETCH_TYPE_STRING      0
-#define FETCH_TYPE_STRSIZE     1
-
 #ifdef CONFIG_KPROBE_EVENTS
 bool trace_kprobe_on_func_entry(struct trace_event_call *call);
 bool trace_kprobe_error_injectable(struct trace_event_call *call);
@@ -273,8 +270,7 @@ find_event_file_link(struct trace_probe *tp, struct trace_event_file *file)
 }
 
 extern int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
-		   struct probe_arg *parg, bool is_return, bool is_kprobe,
-		   const struct fetch_type *ftbl);
+		   struct probe_arg *parg, bool is_return, bool is_kprobe);
 
 extern int traceprobe_conflict_field_name(const char *name,
 			       struct probe_arg *args, int narg);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index e1bc33c5cd99..9fc0123c721f 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -169,30 +169,6 @@ static unsigned long translate_user_vaddr(unsigned long file_offset)
 	return base_addr + file_offset;
 }
 
-/* Fetch type information table */
-static const struct fetch_type uprobes_fetch_type_table[] = {
-	/* Special types */
-	[FETCH_TYPE_STRING] = __ASSIGN_FETCH_TYPE("string", string, string,
-					sizeof(u32), 1, "__data_loc char[]"),
-	[FETCH_TYPE_STRSIZE] = __ASSIGN_FETCH_TYPE("string_size", u32,
-					string_size, sizeof(u32), 0, "u32"),
-	/* Basic types */
-	ASSIGN_FETCH_TYPE(u8,  u8,  0),
-	ASSIGN_FETCH_TYPE(u16, u16, 0),
-	ASSIGN_FETCH_TYPE(u32, u32, 0),
-	ASSIGN_FETCH_TYPE(u64, u64, 0),
-	ASSIGN_FETCH_TYPE(s8,  u8,  1),
-	ASSIGN_FETCH_TYPE(s16, u16, 1),
-	ASSIGN_FETCH_TYPE(s32, u32, 1),
-	ASSIGN_FETCH_TYPE(s64, u64, 1),
-	ASSIGN_FETCH_TYPE_ALIAS(x8,  u8,  u8,  0),
-	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
-	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
-	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
-
-	ASSIGN_FETCH_TYPE_END
-};
-
 /* Note that we don't verify it, since the code does not come from user space */
 static int
 process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
@@ -581,8 +557,7 @@ static int create_trace_uprobe(int argc, char **argv)
 
 		/* Parse fetch argument */
 		ret = traceprobe_parse_probe_arg(arg, &tu->tp.size, parg,
-						 is_return, false,
-						 uprobes_fetch_type_table);
+						 is_return, false);
 		if (ret) {
 			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
 			goto error;

