Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2265csZjJeHrSGxRDx+DTYZ/eaWJgJT8P/n1RDUFAQ9dPHbPYqi9UxH76I9cSqdsfwZVD43d
ARC-Seal: i=1; a=rsa-sha256; t=1519450462; cv=none;
        d=google.com; s=arc-20160816;
        b=BSvB4wMH8JRbkLHJPi8ru7ryWIgMetr80VtB6C37yjf5MNwk0tEHr2eeBTPX4gVTg7
         z4Sd5uMDeyR7Z7FuUJ6XGBNvn8D0ntZE+DNGRhmiCL8wcYOMpjOFlAYtkzderoLbjqXy
         EE95rDTmcByVwsWTmtcF0wsX5r2J4NrJNL5/RIDJfAhfn5WlVDu4pe3VCNGv5+ZTGVaX
         lXqxMG9ucTMHuP7twS4zDAkYnHtmDhbM0JBCyiEUbkZd3wbr9qrHrtFZqfCh6q2OTT8T
         GSMRMQ+saIo2uVJp9nJ6vAFlib4gYvojhazF15iLvD7SK/yH+yngS+3yLDmxhB2X75Ht
         RDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=7R44+tAImP/+RsvB0xVrqprtB3mqiJqGJrtjXrK06Hw=;
        b=qbOm0Q1392FOIrpr0BKpniVAGST63OvB39wIqA4nJczkoxpd/8C9M9c108YnGGcpKO
         nV66jqY77ZohyYHwdbShq3w4msmweQfva3RMYLy8S9NWH0p+/MO5kicpAG/Z4ZAlEb/b
         S7uE39Jf0v/eXBKzHbbMsmhtjE9c1BZBAfggsObFxGubwS+4AipIvf7TRuWCCxo3Jy6j
         XFzRAd/1gKicGkEMMmu4lxz7GRURArb833Jnlu19BNpiRti1xUikY/GZBOSngbS/MuUy
         HknRF8zHlL0UEQzUbEmZJiasqincTwN7XxmNifGqaiJA6HDAPrenancOzUO2Wj4T5TjV
         maVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbeBXFeJ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 24 Feb 2018 00:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbeBXFeI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Feb 2018 00:34:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BA221741
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
Subject: [PATCH v3 11/18] tracing: probeevent: Unify fetch_insn processing common part
Date: Sat, 24 Feb 2018 14:33:44 +0900
Message-Id: <151945042440.27508.17246630976465214299.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593259288343922381?=
X-GMAIL-MSGID: =?utf-8?q?1593259288343922381?=
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
index 35f81e1eb70e..292d5ae6d18b 100644
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
 

