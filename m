Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+stXAHdbXhm0yizJ7jNoBOrBGtAKvtvrWLsuH7Ej1gKCGlevD39xs+7ju0bKTF9lAXWnxe
ARC-Seal: i=1; a=rsa-sha256; t=1524658767; cv=none;
        d=google.com; s=arc-20160816;
        b=Qmp+1GalbZc3okFWXWs/HAqxSTqTZPOGRHyTEKi6byUTcKxyhcWGIb4Odv0UhPOfeH
         wRQNDdX2hSdfQGhQPrggGXYGwL50mf9c4mtNSqnUJNd6d/lPW2MnD52boBvozlkpQP5d
         qTaHyygIyWazx1+waIxqMPyFV7f9posJDK3OLheFa1D4Azs6HBtQPa5efSVSGmVao0SF
         l+UVQVkIVZigTF9Ogdrl8W1NAfVQvwDBV61lXAuzDSSHvT9q0ivL4Q3KXlrqlFjXawbG
         M02GoOEezOND2Kggx1tdCEpNuj8o3gAlN7DZp0yTIFXEgj3N8TQguhuOpEels5hdxoNe
         yVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=cpybpzcryGszGXfb1ParoOBGjgHfZLVDpQafH2IxUWo=;
        b=fK/+B4mqIZTBnjGSOOqtxfTjR1zw/4Y9PlXaKhQe5Gy4wl8ojGrOEFvp5k99rsVJKn
         az95FJE9qwflcoCCCJL+wlcNgfxGDS2MVIPaQ2kHhXiI5056IGCILKvuA254WPtfkL2l
         kGN7gdRcpA+tnKNlz6cO0YB6jjvvJ2Cp9YCuMNm3DSD2Hhz7xQsYSBYUknfX0oyLvSNR
         vUtGK173ZcuF3mX2Yzx1TsDbJTcK/rvppU80JHJIM9v/PuTxvCEm35HYUglGZL9fRANC
         lV9pjh9139ZU7DsnZLeWqYu9W1YIMCaXityU8QlJMD7dlYB4laFNXDfJqVHYq8TsUQDL
         KC+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDYMT0 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 08:19:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752700AbeDYMTZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 08:19:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F6B21748
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
Subject: [PATCH v7 06/16] tracing: probeevent: Return consumed bytes of dynamic area
Date: Wed, 25 Apr 2018 21:19:01 +0900
Message-Id: <152465874163.26224.12125143907501289031.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1598720591939360666?=
X-GMAIL-MSGID: =?utf-8?q?1598720591939360666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cleanup string fetching routine so that returns the consumed
bytes of dynamic area and store the string information as
data_loc format instead of data_rloc.
This simplifies the fetcharg loop.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v7:
  - Fix to return an error if failed to fetch string and
    fill zero-length data_loc in error case.
---
 kernel/trace/trace_kprobe.c     |   57 +++++++++++++++++-------------------
 kernel/trace/trace_probe.h      |   26 ++++-------------
 kernel/trace/trace_probe_tmpl.h |   54 ++++++++++++++++-------------------
 kernel/trace/trace_uprobe.c     |   61 +++++++++++++++++++--------------------
 4 files changed, 88 insertions(+), 110 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 0b73b1ee82c8..fab796d55d70 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -807,8 +807,8 @@ static const struct file_operations kprobe_profile_ops = {
 /* Kprobe specific fetch functions */
 
 /* Return the length of string -- including null terminal byte */
-static nokprobe_inline void
-fetch_store_strlen(unsigned long addr, void *dest)
+static nokprobe_inline int
+fetch_store_strlen(unsigned long addr)
 {
 	mm_segment_t old_fs;
 	int ret, len = 0;
@@ -826,47 +826,40 @@ fetch_store_strlen(unsigned long addr, void *dest)
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
@@ -903,6 +896,13 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
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
@@ -911,10 +911,7 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
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
@@ -927,7 +924,7 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		code++;
 	}
 
-	return code->op == FETCH_OP_END ? 0 : -EILSEQ;
+	return code->op == FETCH_OP_END ? ret : -EILSEQ;
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
 
@@ -962,7 +959,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 
 	entry = ring_buffer_event_data(event);
 	entry->ip = (unsigned long)tk->rp.kp.addr;
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
 	event_trigger_unlock_commit_regs(trace_file, buffer, event,
 					 entry, irq_flags, pc, regs);
@@ -1011,7 +1008,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	entry = ring_buffer_event_data(event);
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = (unsigned long)ri->ret_addr;
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
 	event_trigger_unlock_commit_regs(trace_file, buffer, event,
 					 entry, irq_flags, pc, regs);
@@ -1162,7 +1159,7 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	memset(&entry[1], 0, dsize);
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 	return 0;
@@ -1198,7 +1195,7 @@ kretprobe_perf_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = (unsigned long)ri->ret_addr;
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 }
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 89d853ef5174..d1b8bd74bf56 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -66,29 +66,15 @@
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
index e56925e77781..9961bee490fd 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -121,43 +121,38 @@ probe_user_read(void *dest, void *src, size_t size)
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
@@ -174,10 +169,10 @@ static unsigned long translate_user_vaddr(unsigned long file_offset)
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
@@ -214,18 +209,22 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
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
@@ -238,7 +237,7 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		code++;
 	}
 
-	return code->op == FETCH_OP_END ? 0 : -EILSEQ;
+	return code->op == FETCH_OP_END ? ret : -EILSEQ;
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
 
@@ -1229,7 +1228,7 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
-	store_trace_args(esize, &tu->tp, regs, ucb->buf, dsize);
+	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
 	if (tu->tp.flags & TP_FLAG_TRACE)
 		ret |= uprobe_trace_func(tu, regs, ucb, dsize);
@@ -1264,7 +1263,7 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
-	store_trace_args(esize, &tu->tp, regs, ucb->buf, dsize);
+	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
 	if (tu->tp.flags & TP_FLAG_TRACE)
 		uretprobe_trace_func(tu, func, regs, ucb, dsize);

