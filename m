Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuNhtRG7v8ZsmUN8nyeKYiHrFypHOVqZSqFxDWfk4jywoZwsdcTQdt9sXK9zaTFIUwhqxL5
ARC-Seal: i=1; a=rsa-sha256; t=1521290841; cv=none;
        d=google.com; s=arc-20160816;
        b=sdat5r0vIL+2NgFo6MzfwBQZBNTNna1U8HBw3qZStUiBpgKDOmFJvgpygrXao8hrKm
         FKJC7jDQpsQniL1BU9ZRAcwpJIQXPhFSMDYG12/E87S2zc0XxF4PDmLintAKNkMjdK7S
         kF5XrVjYBpvz5kH1evNsaLUZ7kUvLmlpo+Voc99Xczr45MskMKpiikBGFFzbih5p9DFK
         qGFjoMhkjjYlGYcmBRBNU4f6C715uEStEoyT3NnH/36Li6Rk4WhOZ8CURgHMhlQCB4b8
         nq2H/p9GbYnNUNgb7L4Bu4yU0EsYBQ7qQtzckN69IP16+IcFFnor18u0sRAi3m6/Kh4k
         KjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=zoVJhhcwNcuVVx3UkN6Dq/Hd5zqL5fozrFS2UPZf6U0=;
        b=WNIT/38k62Du0wF3TUQ9qVgA9Lgr9PcE3idyOP3txAM+lJl+H/mjn01awKWLhZSTiA
         QxGn0ONdy8X+AJGillM3+w8utVryyIFRF1u9dUFs09UorVNU2l6q36aOB25uCPaMJdC4
         HhKQ6/W1fs0z63uExyMypa58CE5WaEM42HvEQHyo/9VF8ZV43RaAqm6k3v5a3UxoKfXc
         UFfMXSXf+9s9J8YClFZow0rxHBuTFq+12eP/8dhkDb1JAD82lpjbvEwUQg/3NLHzvqMb
         Fqh0fLAnGVhfGmAUlBJnE9wSCBRwHoeAbfzMndZDqA7Uf190ZDuzD4z2wZj6juqbQ3TI
         lJAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeCQMrI (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 08:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752514AbeCQMrH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 08:47:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1C221737
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
Subject: [PATCH v6 12/21] tracing: probeevent: Unify fetch_insn processing common part
Date: Sat, 17 Mar 2018 21:46:25 +0900
Message-Id: <152129078491.31874.6052619718602591149.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1595189064753959249?=
X-GMAIL-MSGID: =?utf-8?q?1595189064753959249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Unify the fetch_insn bottom process (from stage 2: dereference
indirect data) from kprobe and uprobe events, since those are
mostly same.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c     |   47 +++++----------------------------
 kernel/trace/trace_probe_tmpl.h |   55 ++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_uprobe.c     |   43 +-----------------------------
 3 files changed, 63 insertions(+), 82 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7d48ae5f0617..b564d38810b7 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -857,13 +857,18 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	return ret;
 }
 
+static nokprobe_inline int
+probe_mem_read(void *dest, void *src, size_t size)
+{
+	return probe_kernel_read(dest, src, size);
+}
+
 /* Note that we don't verify it, since the code does not come from user space */
 static int
 process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		   void *base)
 {
 	unsigned long val;
-	int ret = 0;
 
 	/* 1st stage: get value from context */
 	switch (code->op) {
@@ -890,45 +895,7 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 	}
 	code++;
 
-	/* 2nd stage: dereference memory if needed */
-	while (code->op == FETCH_OP_DEREF) {
-		ret = probe_kernel_read(&val, (void *)val + code->offset,
-					sizeof(val));
-		if (ret)
-			return ret;
-		code++;
-	}
-
-	/* 3rd stage: store value to buffer */
-	if (unlikely(!dest)) {
-		if (code->op == FETCH_OP_ST_STRING)
-			return fetch_store_strlen(val + code->offset);
-		else
-			return -EILSEQ;
-	}
-
-	switch (code->op) {
-	case FETCH_OP_ST_RAW:
-		fetch_store_raw(val, code, dest);
-		break;
-	case FETCH_OP_ST_MEM:
-		probe_kernel_read(dest, (void *)val + code->offset, code->size);
-		break;
-	case FETCH_OP_ST_STRING:
-		ret = fetch_store_string(val + code->offset, dest, base);
-		break;
-	default:
-		return -EILSEQ;
-	}
-	code++;
-
-	/* 4th stage: modify stored value if needed */
-	if (code->op == FETCH_OP_MOD_BF) {
-		fetch_apply_bitfield(code, dest);
-		code++;
-	}
-
-	return code->op == FETCH_OP_END ? ret : -EILSEQ;
+	return process_fetch_insn_bottom(code, val, dest, base);
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
 
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index d9aebd395a9d..32ae2fc78190 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -49,13 +49,66 @@ fetch_apply_bitfield(struct fetch_insn *code, void *buf)
 }
 
 /*
- * This must be defined for each callsite.
+ * These functions must be defined for each callsite.
  * Return consumed dynamic data size (>= 0), or error (< 0).
  * If dest is NULL, don't store result and return required dynamic data size.
  */
 static int
 process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs,
 		   void *dest, void *base);
+static nokprobe_inline int fetch_store_strlen(unsigned long addr);
+static nokprobe_inline int
+fetch_store_string(unsigned long addr, void *dest, void *base);
+static nokprobe_inline int
+probe_mem_read(void *dest, void *src, size_t size);
+
+/* From the 2nd stage, routine is same */
+static nokprobe_inline int
+process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
+			   void *dest, void *base)
+{
+	int ret = 0;
+
+	/* 2nd stage: dereference memory if needed */
+	while (code->op == FETCH_OP_DEREF) {
+		ret = probe_mem_read(&val, (void *)val + code->offset,
+					sizeof(val));
+		if (ret)
+			return ret;
+		code++;
+	}
+
+	/* 3rd stage: store value to buffer */
+	if (unlikely(!dest)) {
+		if (code->op == FETCH_OP_ST_STRING)
+			return fetch_store_strlen(val + code->offset);
+		else
+			return -EILSEQ;
+	}
+
+	switch (code->op) {
+	case FETCH_OP_ST_RAW:
+		fetch_store_raw(val, code, dest);
+		break;
+	case FETCH_OP_ST_MEM:
+		probe_mem_read(dest, (void *)val + code->offset, code->size);
+		break;
+	case FETCH_OP_ST_STRING:
+		ret = fetch_store_string(val + code->offset, dest, base);
+		break;
+	default:
+		return -EILSEQ;
+	}
+	code++;
+
+	/* 4th stage: modify stored value if needed */
+	if (code->op == FETCH_OP_MOD_BF) {
+		fetch_apply_bitfield(code, dest);
+		code++;
+	}
+
+	return code->op == FETCH_OP_END ? ret : -EILSEQ;
+}
 
 /* Sum up total data length for dynamic arraies (strings) */
 static nokprobe_inline int
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fafd48310823..64c1fbe087a1 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -111,7 +111,7 @@ static unsigned long get_user_stack_nth(struct pt_regs *regs, unsigned int n)
  * Uprobes-specific fetch functions
  */
 static nokprobe_inline int
-probe_user_read(void *dest, void *src, size_t size)
+probe_mem_read(void *dest, void *src, size_t size)
 {
 	void __user *vaddr = (void __force __user *)src;
 
@@ -172,7 +172,6 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		   void *base)
 {
 	unsigned long val;
-	int ret = 0;
 
 	/* 1st stage: get value from context */
 	switch (code->op) {
@@ -199,45 +198,7 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 	}
 	code++;
 
-	/* 2nd stage: dereference memory if needed */
-	while (code->op == FETCH_OP_DEREF) {
-		ret = probe_user_read(&val, (void *)val + code->offset,
-				      sizeof(val));
-		if (ret)
-			return ret;
-		code++;
-	}
-
-	/* 3rd stage: store value to buffer */
-	if (unlikely(!dest)) {
-		if (code->op == FETCH_OP_ST_STRING)
-			return fetch_store_strlen(val + code->offset);
-		else
-			return -EILSEQ;
-	}
-
-	switch (code->op) {
-	case FETCH_OP_ST_RAW:
-		fetch_store_raw(val, code, dest);
-		break;
-	case FETCH_OP_ST_MEM:
-		probe_kernel_read(dest, (void *)val + code->offset, code->size);
-		break;
-	case FETCH_OP_ST_STRING:
-		ret = fetch_store_string(val + code->offset, dest, base);
-		break;
-	default:
-		return -EILSEQ;
-	}
-	code++;
-
-	/* 4th stage: modify stored value if needed */
-	if (code->op == FETCH_OP_MOD_BF) {
-		fetch_apply_bitfield(code, dest);
-		code++;
-	}
-
-	return code->op == FETCH_OP_END ? ret : -EILSEQ;
+	return process_fetch_insn_bottom(code, val, dest, base);
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
 

