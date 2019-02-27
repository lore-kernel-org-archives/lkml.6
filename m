Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B814EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7581C217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551278680;
	bh=RwDnUD2gyYvm3DGYo33qV7Lm1wruH7Ecqfp6NOQt/ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v/u78IauiaTvfiqRgrJt/lWSaRUdNNFlhUSZMoemto+OWSkSzM12yOP4v2MgQ+m8l
	 OmFR/7stObbfRtIkmro74wrEsuSlyfJ/WrLUoUF4NzU7uZp12c/jy15POVPBSSsv9o
	 xocGyKbVErKGJkNy+66IGtcYDUTSfKd+IN0C9XI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfB0Ooj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:44:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbfB0Ooi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:44:38 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42EA22083D;
        Wed, 27 Feb 2019 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551278677;
        bh=RwDnUD2gyYvm3DGYo33qV7Lm1wruH7Ecqfp6NOQt/ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUfhdtIkG+slYE1IdOx85g14FgeAjifUtovKKzNw7UIb2TUtqM6tva8dUJtA6aENd
         qtGz6JgOmzvfVExK4ehUCsqJ4TpLGAlboXEF8EMBeDK70SqdR/llSX00EfWUQBtVKg
         cdluclCQTcQVd/+xEAn4WSEX0JAVdJg0u6M5t5dU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 4/5] tracing/probe: Add ustring type for user-space string
Date:   Wed, 27 Feb 2019 23:44:13 +0900
Message-Id: <155127865291.32576.4103083638486429600.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <155127853496.32576.3705994926675037747.stgit@devbox>
References: <155127853496.32576.3705994926675037747.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "ustring" type for fetching user-space string from kprobe event.
User can specify ustring type at uprobe event, and it is same as
"string" for uprobe.

Note that probe-event provides this option but it doesn't choose the
correct type automatically since we have not way to decide the address
is in user-space or not on some arch (and on some other arch, you can
fetch the string by "string" type). So user must carefully check the
target code (e.g. if you see __user on the target variable) and
use this new type.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
 - Use strnlen_user() instead of open code for fetch_store_strlen_user().
---
 Documentation/trace/kprobetrace.rst |    9 +++++++--
 kernel/trace/trace.c                |    2 +-
 kernel/trace/trace_kprobe.c         |   37 +++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.c          |   14 ++++++++++---
 kernel/trace/trace_probe.h          |    1 +
 kernel/trace/trace_probe_tmpl.h     |   14 ++++++++++++-
 kernel/trace/trace_uprobe.c         |   12 +++++++++++
 7 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 235ce2ab131a..a3ac7c9ac242 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -55,7 +55,8 @@ Synopsis of kprobe_events
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
-		  (x8/x16/x32/x64), "string" and bitfield are supported.
+		  (x8/x16/x32/x64), "string", "ustring" and bitfield
+		  are supported.
 
   (\*1) only for the probe on function entry (offs == 0).
   (\*2) only for return probe.
@@ -77,7 +78,11 @@ apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
 wrong, but '+8($stack):x8[8]' is OK.)
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
-has been paged out.
+has been paged out. "ustring" type is an alternative of string for user-space.
+Note that kprobe-event provides string/ustring types, but doesn't change it
+automatically. So user has to decide if the targe string in kernel or in user
+space carefully. On some arch, if you choose wrong one, it always fails to
+record string data.
 The string array type is a bit different from other types. For other base
 types, <base-type>[1] is equal to <base-type> (e.g. +0(%di):x32[1] is same
 as +0(%di):x32.) But string[1] is not equal to string. The string type itself
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c4238b441624..4cacbb0e1538 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4643,7 +4643,7 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm\n"
 #endif
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
-	"\t           b<bit-width>@<bit-offset>/<container-size>,\n"
+	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
 	"\t           <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t    field: <stype> <name>;\n"
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9eaf07f99212..8b04cae5fd86 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -872,6 +872,22 @@ fetch_store_strlen(unsigned long addr)
 	return (ret < 0) ? ret : len;
 }
 
+/* Return the length of string -- including null terminal byte */
+static nokprobe_inline int
+fetch_store_strlen_user(unsigned long addr)
+{
+	mm_segment_t old_fs = get_fs();
+	int ret;
+
+	set_fs(USER_DS);
+	pagefault_disable();
+	ret = strnlen_user((__force const char __user *)addr, MAX_STRING_SIZE);
+	pagefault_enable();
+	set_fs(old_fs);
+
+	return ret;
+}
+
 /*
  * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
  * length and relative data location.
@@ -896,6 +912,27 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	return ret;
 }
 
+/*
+ * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
+ * with max length and relative data location.
+ */
+static nokprobe_inline int
+fetch_store_string_user(unsigned long addr, void *dest, void *base)
+{
+	int maxlen = get_loc_len(*(u32 *)dest);
+	u8 *dst = get_loc_data(dest, base);
+	long ret;
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+	ret = strncpy_from_unsafe_user(dst, (__force const void __user *)addr,
+				       maxlen);
+
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
+	return ret;
+}
+
 static nokprobe_inline int
 probe_mem_read(void *dest, void *src, size_t size)
 {
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9962cb5da8ac..a7012de37a00 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -73,6 +73,8 @@ static const struct fetch_type probe_fetch_types[] = {
 	/* Special types */
 	__ASSIGN_FETCH_TYPE("string", string, string, sizeof(u32), 1,
 			    "__data_loc char[]"),
+	__ASSIGN_FETCH_TYPE("ustring", string, string, sizeof(u32), 1,
+			    "__data_loc char[]"),
 	/* Basic types */
 	ASSIGN_FETCH_TYPE(u8,  u8,  0),
 	ASSIGN_FETCH_TYPE(u16, u16, 0),
@@ -440,7 +442,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 		goto fail;
 
 	/* Store operation */
-	if (!strcmp(parg->type->name, "string")) {
+	if (!strcmp(parg->type->name, "string") ||
+	    !strcmp(parg->type->name, "ustring")) {
 		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_IMM &&
 		    code->op != FETCH_OP_COMM) {
 			pr_info("string only accepts memory or address.\n");
@@ -459,7 +462,11 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 				goto fail;
 			}
 		}
-		code->op = FETCH_OP_ST_STRING;	/* In DEREF case, replace it */
+		/* If op == DEREF, replace it with STRING */
+		if (!strcmp(parg->type->name, "ustring"))
+			code->op = FETCH_OP_ST_USTRING;
+		else
+			code->op = FETCH_OP_ST_STRING;
 		code->size = parg->type->size;
 		parg->dynamic = true;
 	} else if (code->op == FETCH_OP_DEREF) {
@@ -484,7 +491,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	/* Loop(Array) operation */
 	if (parg->count) {
 		if (scode->op != FETCH_OP_ST_MEM &&
-		    scode->op != FETCH_OP_ST_STRING) {
+		    scode->op != FETCH_OP_ST_STRING &&
+		    scode->op != FETCH_OP_ST_USTRING) {
 			pr_info("array only accepts memory or address\n");
 			ret = -EINVAL;
 			goto fail;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 8a63f8bc01bc..cf4ba8bbb841 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -95,6 +95,7 @@ enum fetch_op {
 	FETCH_OP_ST_RAW,	/* Raw: .size */
 	FETCH_OP_ST_MEM,	/* Mem: .offset, .size */
 	FETCH_OP_ST_STRING,	/* String: .offset, .size */
+	FETCH_OP_ST_USTRING,	/* User String: .offset, .size */
 	// Stage 4 (modify) op
 	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
 	// Stage 5 (loop) op
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 4737bb8c07a3..7526f6f8d7b0 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -59,6 +59,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs,
 static nokprobe_inline int fetch_store_strlen(unsigned long addr);
 static nokprobe_inline int
 fetch_store_string(unsigned long addr, void *dest, void *base);
+static nokprobe_inline int fetch_store_strlen_user(unsigned long addr);
+static nokprobe_inline int
+fetch_store_string_user(unsigned long addr, void *dest, void *base);
 static nokprobe_inline int
 probe_mem_read(void *dest, void *src, size_t size);
 
@@ -91,6 +94,10 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 			ret += fetch_store_strlen(val + code->offset);
 			code++;
 			goto array;
+		} else if (code->op == FETCH_OP_ST_USTRING) {
+			ret += fetch_store_strlen_user(val + code->offset);
+			code++;
+			goto array;
 		} else
 			return -EILSEQ;
 	}
@@ -106,6 +113,10 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		loc = *(u32 *)dest;
 		ret = fetch_store_string(val + code->offset, dest, base);
 		break;
+	case FETCH_OP_ST_USTRING:
+		loc = *(u32 *)dest;
+		ret = fetch_store_string_user(val + code->offset, dest, base);
+		break;
 	default:
 		return -EILSEQ;
 	}
@@ -123,7 +134,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		total += ret;
 		if (++i < code->param) {
 			code = s3;
-			if (s3->op != FETCH_OP_ST_STRING) {
+			if (s3->op != FETCH_OP_ST_STRING &&
+			    s3->op != FETCH_OP_ST_USTRING) {
 				dest += s3->size;
 				val += s3->size;
 				goto stage3;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9bde07c06362..92facae8c3d8 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -173,6 +173,12 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	return ret;
 }
 
+static nokprobe_inline int
+fetch_store_string_user(unsigned long addr, void *dest, void *base)
+{
+	return fetch_store_string(addr, dest, base);
+}
+
 /* Return the length of string -- including null terminal byte */
 static nokprobe_inline int
 fetch_store_strlen(unsigned long addr)
@@ -185,6 +191,12 @@ fetch_store_strlen(unsigned long addr)
 	return (len > MAX_STRING_SIZE) ? 0 : len;
 }
 
+static nokprobe_inline int
+fetch_store_strlen_user(unsigned long addr)
+{
+	return fetch_store_strlen(addr);
+}
+
 static unsigned long translate_user_vaddr(unsigned long file_offset)
 {
 	unsigned long base_addr;

