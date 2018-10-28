Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED91ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAF820843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAF820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeJ1QPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbeJ1QPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:15:23 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC0220896;
        Sun, 28 Oct 2018 07:31:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gGfXq-000844-75; Sun, 28 Oct 2018 03:31:34 -0400
Message-Id: <20181028073134.122455748@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 28 Oct 2018 03:29:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 06/18] tracing: probeevent: Return consumed bytes of dynamic area
References: <20181028072948.693267247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Cleanup string fetching routine so that returns the consumed
bytes of dynamic area and store the string information as
data_loc format instead of data_rloc.
This simplifies the fetcharg loop.

Link: http://lkml.kernel.org/r/152465874163.26224.12125143907501289031.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c     | 57 +++++++++++++++---------------
 kernel/trace/trace_probe.h      | 26 ++++----------
 kernel/trace/trace_probe_tmpl.h | 54 ++++++++++++++---------------
 kernel/trace/trace_uprobe.c     | 61 ++++++++++++++++-----------------
 4 files changed, 88 insertions(+), 110 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index dc1c638daf44..7e5064f8ab8f 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -853,8 +853,8 @@ static const struct file_operations kprobe_profile_ops = {
 /* Kprobe specific fetch functions */
 
 /* Return the length of string -- including null terminal byte */
-static nokprobe_inline void
-fetch_store_strlen(unsigned long addr, void *dest)
+static nokprobe_inline int
+fetch_store_strlen(unsigned long addr)
 {
 	mm_segment_t old_fs;
 	int ret, len = 0;
@@ -872,47 +872,40 @@ fetch_store_strlen(unsigned long addr, void *dest)
 	pagefault_enable();
 	set_fs(old_fs);
 
-	if (ret < 0)	/* Failed to check the length */
-		*(u32 *)dest = 0;
-	else
-		*(u32 *)dest = len;
+	return (ret < 0) ? ret : len;
 }
 
 /*
  * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
  * length and relative data location.
  */
-static nokprobe_inline void
-fetch_store_string(unsigned long addr, void *dest)
+static nokprobe_inline int
+fetch_store_string(unsigned long addr, void *dest, void *base)
 {
-	int maxlen = get_rloc_len(*(u32 *)dest);
-	u8 *dst = get_rloc_data(dest);
+	int maxlen = get_loc_len(*(u32 *)dest);
+	u8 *dst = get_loc_data(dest, base);
 	long ret;
 
-	if (!maxlen)
-		return;
-
+	if (unlikely(!maxlen))
+		return -ENOMEM;
 	/*
 	 * Try to get string again, since the string can be changed while
 	 * probing.
 	 */
 	ret = strncpy_from_unsafe(dst, (void *)addr, maxlen);
 
-	if (ret < 0) {	/* Failed to fetch string */
-		dst[0] = '\0';
-		*(u32 *)dest = make_data_rloc(0, get_rloc_offs(*(u32 *)dest));
-	} else {
-		*(u32 *)dest = make_data_rloc(ret, get_rloc_offs(*(u32 *)dest));
-	}
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
+	return ret;
 }
 
 /* Note that we don't verify it, since the code does not come from user space */
 static int
 process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
-		   bool pre)
+		   void *base)
 {
 	unsigned long val;
-	int ret;
+	int ret = 0;
 
 	/* 1st stage: get value from context */
 	switch (code->op) {
@@ -949,6 +942,13 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 	}
 
 	/* 3rd stage: store value to buffer */
+	if (unlikely(!dest)) {
+		if (code->op == FETCH_OP_ST_STRING)
+			return fetch_store_strlen(val + code->offset);
+		else
+			return -EILSEQ;
+	}
+
 	switch (code->op) {
 	case FETCH_OP_ST_RAW:
 		fetch_store_raw(val, code, dest);
@@ -957,10 +957,7 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		probe_kernel_read(dest, (void *)val + code->offset, code->size);
 		break;
 	case FETCH_OP_ST_STRING:
-		if (pre)
-			fetch_store_strlen(val + code->offset, dest);
-		else
-			fetch_store_string(val + code->offset, dest);
+		ret = fetch_store_string(val + code->offset, dest, base);
 		break;
 	default:
 		return -EILSEQ;
@@ -973,7 +970,7 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		code++;
 	}
 
-	return code->op == FETCH_OP_END ? 0 : -EILSEQ;
+	return code->op == FETCH_OP_END ? ret : -EILSEQ;
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
 
@@ -1008,7 +1005,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 
 	entry = ring_buffer_event_data(event);
 	entry->ip = (unsigned long)tk->rp.kp.addr;
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
 	event_trigger_unlock_commit_regs(trace_file, buffer, event,
 					 entry, irq_flags, pc, regs);
@@ -1057,7 +1054,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	entry = ring_buffer_event_data(event);
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = (unsigned long)ri->ret_addr;
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
 	event_trigger_unlock_commit_regs(trace_file, buffer, event,
 					 entry, irq_flags, pc, regs);
@@ -1203,7 +1200,7 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	memset(&entry[1], 0, dsize);
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 	return 0;
@@ -1239,7 +1236,7 @@ kretprobe_perf_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = (unsigned long)ri->ret_addr;
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 }
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 5c262ed6347c..b6bdd82fa485 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -54,29 +54,15 @@
 #define TP_FLAG_PROFILE		2
 #define TP_FLAG_REGISTERED	4
 
+/* data_loc: data location, compatible with u32 */
+#define make_data_loc(len, offs)	\
+	(((u32)(len) << 16) | ((u32)(offs) & 0xffff))
+#define get_loc_len(dl)		((u32)(dl) >> 16)
+#define get_loc_offs(dl)	((u32)(dl) & 0xffff)
 
-/* data_rloc: data relative location, compatible with u32 */
-#define make_data_rloc(len, roffs)	\
-	(((u32)(len) << 16) | ((u32)(roffs) & 0xffff))
-#define get_rloc_len(dl)		((u32)(dl) >> 16)
-#define get_rloc_offs(dl)		((u32)(dl) & 0xffff)
-
-/*
- * Convert data_rloc to data_loc:
- *  data_rloc stores the offset from data_rloc itself, but data_loc
- *  stores the offset from event entry.
- */
-#define convert_rloc_to_loc(dl, offs)	((u32)(dl) + (offs))
-
-static nokprobe_inline void *get_rloc_data(u32 *dl)
-{
-	return (u8 *)dl + get_rloc_offs(*dl);
-}
-
-/* For data_loc conversion */
 static nokprobe_inline void *get_loc_data(u32 *dl, void *ent)
 {
-	return (u8 *)ent + get_rloc_offs(*dl);
+	return (u8 *)ent + get_loc_offs(*dl);
 }
 
 /* Printing function type */
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index c8a5272abf01..3b4aba6f84cc 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -48,24 +48,28 @@ fetch_apply_bitfield(struct fetch_insn *code, void *buf)
 	}
 }
 
-/* Define this for each callsite */
+/*
+ * This must be defined for each callsite.
+ * Return consumed dynamic data size (>= 0), or error (< 0).
+ * If dest is NULL, don't store result and return required dynamic data size.
+ */
 static int
 process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs,
-		   void *dest, bool pre);
+		   void *dest, void *base);
 
 /* Sum up total data length for dynamic arraies (strings) */
 static nokprobe_inline int
 __get_data_size(struct trace_probe *tp, struct pt_regs *regs)
 {
 	struct probe_arg *arg;
-	int i, ret = 0;
-	u32 len;
+	int i, len, ret = 0;
 
 	for (i = 0; i < tp->nr_args; i++) {
 		arg = tp->args + i;
 		if (unlikely(arg->dynamic)) {
-			process_fetch_insn(arg->code, regs, &len, true);
-			ret += len;
+			len = process_fetch_insn(arg->code, regs, NULL, NULL);
+			if (len > 0)
+				ret += len;
 		}
 	}
 
@@ -74,34 +78,26 @@ __get_data_size(struct trace_probe *tp, struct pt_regs *regs)
 
 /* Store the value of each argument */
 static nokprobe_inline void
-store_trace_args(int ent_size, struct trace_probe *tp, struct pt_regs *regs,
-		 u8 *data, int maxlen)
+store_trace_args(void *data, struct trace_probe *tp, struct pt_regs *regs,
+		 int header_size, int maxlen)
 {
 	struct probe_arg *arg;
-	u32 end = tp->size;
-	u32 *dl;	/* Data (relative) location */
-	int i;
+	void *base = data - header_size;
+	void *dyndata = data + tp->size;
+	u32 *dl;	/* Data location */
+	int ret, i;
 
 	for (i = 0; i < tp->nr_args; i++) {
 		arg = tp->args + i;
-		if (unlikely(arg->dynamic)) {
-			/*
-			 * First, we set the relative location and
-			 * maximum data length to *dl
-			 */
-			dl = (u32 *)(data + arg->offset);
-			*dl = make_data_rloc(maxlen, end - arg->offset);
-			/* Then try to fetch string or dynamic array data */
-			process_fetch_insn(arg->code, regs, dl, false);
-			/* Reduce maximum length */
-			end += get_rloc_len(*dl);
-			maxlen -= get_rloc_len(*dl);
-			/* Trick here, convert data_rloc to data_loc */
-			*dl = convert_rloc_to_loc(*dl, ent_size + arg->offset);
-		} else
-			/* Just fetching data normally */
-			process_fetch_insn(arg->code, regs, data + arg->offset,
-					   false);
+		dl = data + arg->offset;
+		/* Point the dynamic data area if needed */
+		if (unlikely(arg->dynamic))
+			*dl = make_data_loc(maxlen, dyndata - base);
+		ret = process_fetch_insn(arg->code, regs, dl, base);
+		if (unlikely(ret < 0 && arg->dynamic))
+			*dl = make_data_loc(0, dyndata - base);
+		else
+			dyndata += ret;
 	}
 }
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 7772fec84c12..08ad51c8ebc0 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -111,43 +111,38 @@ probe_user_read(void *dest, void *src, size_t size)
  * Fetch a null-terminated string. Caller MUST set *(u32 *)dest with max
  * length and relative data location.
  */
-static nokprobe_inline void
-fetch_store_string(unsigned long addr, void *dest)
+static nokprobe_inline int
+fetch_store_string(unsigned long addr, void *dest, void *base)
 {
 	long ret;
-	u32 rloc = *(u32 *)dest;
-	int maxlen  = get_rloc_len(rloc);
-	u8 *dst = get_rloc_data(dest);
+	u32 loc = *(u32 *)dest;
+	int maxlen  = get_loc_len(loc);
+	u8 *dst = get_loc_data(dest, base);
 	void __user *src = (void __force __user *) addr;
 
-	if (!maxlen)
-		return;
+	if (unlikely(!maxlen))
+		return -ENOMEM;
 
 	ret = strncpy_from_user(dst, src, maxlen);
-	if (ret == maxlen)
-		dst[--ret] = '\0';
-
-	if (ret < 0) {	/* Failed to fetch string */
-		((u8 *)get_rloc_data(dest))[0] = '\0';
-		*(u32 *)dest = make_data_rloc(0, get_rloc_offs(rloc));
-	} else {
-		*(u32 *)dest = make_data_rloc(ret, get_rloc_offs(rloc));
+	if (ret >= 0) {
+		if (ret == maxlen)
+			dst[ret - 1] = '\0';
+		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
 	}
+
+	return ret;
 }
 
 /* Return the length of string -- including null terminal byte */
-static nokprobe_inline void
-fetch_store_strlen(unsigned long addr, void *dest)
+static nokprobe_inline int
+fetch_store_strlen(unsigned long addr)
 {
 	int len;
 	void __user *vaddr = (void __force __user *) addr;
 
 	len = strnlen_user(vaddr, MAX_STRING_SIZE);
 
-	if (len == 0 || len > MAX_STRING_SIZE)  /* Failed to check length */
-		*(u32 *)dest = 0;
-	else
-		*(u32 *)dest = len;
+	return (len > MAX_STRING_SIZE) ? 0 : len;
 }
 
 static unsigned long translate_user_vaddr(unsigned long file_offset)
@@ -164,10 +159,10 @@ static unsigned long translate_user_vaddr(unsigned long file_offset)
 /* Note that we don't verify it, since the code does not come from user space */
 static int
 process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
-		   bool pre)
+		   void *base)
 {
 	unsigned long val;
-	int ret;
+	int ret = 0;
 
 	/* 1st stage: get value from context */
 	switch (code->op) {
@@ -204,18 +199,22 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 	}
 
 	/* 3rd stage: store value to buffer */
+	if (unlikely(!dest)) {
+		if (code->op == FETCH_OP_ST_STRING)
+			return fetch_store_strlen(val + code->offset);
+		else
+			return -EILSEQ;
+	}
+
 	switch (code->op) {
 	case FETCH_OP_ST_RAW:
 		fetch_store_raw(val, code, dest);
 		break;
 	case FETCH_OP_ST_MEM:
-		probe_user_read(dest, (void *)val + code->offset, code->size);
+		probe_kernel_read(dest, (void *)val + code->offset, code->size);
 		break;
 	case FETCH_OP_ST_STRING:
-		if (pre)
-			fetch_store_strlen(val + code->offset, dest);
-		else
-			fetch_store_string(val + code->offset, dest);
+		ret = fetch_store_string(val + code->offset, dest, base);
 		break;
 	default:
 		return -EILSEQ;
@@ -228,7 +227,7 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		code++;
 	}
 
-	return code->op == FETCH_OP_END ? 0 : -EILSEQ;
+	return code->op == FETCH_OP_END ? ret : -EILSEQ;
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
 
@@ -1300,7 +1299,7 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
-	store_trace_args(esize, &tu->tp, regs, ucb->buf, dsize);
+	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
 	if (tu->tp.flags & TP_FLAG_TRACE)
 		ret |= uprobe_trace_func(tu, regs, ucb, dsize);
@@ -1335,7 +1334,7 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
-	store_trace_args(esize, &tu->tp, regs, ucb->buf, dsize);
+	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
 	if (tu->tp.flags & TP_FLAG_TRACE)
 		uretprobe_trace_func(tu, func, regs, ucb, dsize);
-- 
2.19.0


