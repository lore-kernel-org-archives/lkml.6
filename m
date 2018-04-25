Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+T41KSsFUn/NaKFyqD8Fjm+wqnpsSFeEiJZF1bmdwWLClvistisJH691kFD1PReiw6D64m
ARC-Seal: i=1; a=rsa-sha256; t=1524658662; cv=none;
        d=google.com; s=arc-20160816;
        b=O0yMLACSkkZrGJ4DqtTQVCXuhmePVxYFQ6ePDh9CILl6Q8iOIsECGVs8TbPZsRWjVx
         V7YHv6O2qZ+EpPwwCXYkLNqznNjAY6rOYZTSdci1ExPQwPX3lzpS9wmy2oOCuIIaamnd
         Un1ML3RO+8rdQpGIp9NK2yaiM4mqH8CiwqA/I2714ygoEN9iCjBug07mXCIMISAS9iQ3
         IcSkO1yHtSPvuKc1p0tRedgFXnnFoB7jgQRZoIAf8jGv7oibBxFGZw/d8pVkK36XSPwq
         xTmQx7pNjYcK0XSiKsBobsTZziUgh2UDVQAas3/bqyCFgHbGxBFT28gPhbyFXVurLwaB
         i/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=mFBDMOnGVxWiWAYPee0pHFBvyekqkkRwKFouWyBt14o=;
        b=Qo/zO/5msGE9NZmhCahD4QPfFJdgXEIOs4bpYmrh61TUqkCE0GUJfLaS9SGTGDD5z5
         N+N2paE8cppN2xY9XtiJ9TATNcrhZ0K/raoGCzW5zGb+XIY1Wn7qIBmwo0Qv0xC1kQfL
         pAmJzwes+8ORAqxkNHHB8NL7VoHT07VozRnUcn0ckQvsgwO5dD38F5L/5U40eUgD2qbR
         kKqH0KvXqaPd3h2VZhWAvt+P3d/xa64gaQ/rvu7Jm38oj0bhsU1t+aLd588L/b0+3WqC
         WrY99FcNP1F42Y//vO5JRbUYKFijnHuwTd/xETeFnGUA2kB82NV7UXr9va/PEwMQt+fv
         enzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752987AbeDYMRa (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 08:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752276AbeDYMR3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 08:17:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5310721748
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
Subject: [PATCH v7 02/16] tracing: probeevent: Cleanup argument field definition
Date: Wed, 25 Apr 2018 21:17:05 +0900
Message-Id: <152465862529.26224.9068605421476018902.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1598720481735214423?=
X-GMAIL-MSGID: =?utf-8?q?1598720481735214423?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cleanup event argument definition code in one place for
maintenancability.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   32 ++++----------------------------
 kernel/trace/trace_probe.c  |   21 +++++++++++++++++++++
 kernel/trace/trace_probe.h  |    2 ++
 kernel/trace/trace_uprobe.c |   15 ++-------------
 4 files changed, 29 insertions(+), 41 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 81e2eb5a1566..a8f8cce066a9 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1146,49 +1146,25 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 
 static int kprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret, i;
+	int ret;
 	struct kprobe_trace_entry_head field;
 	struct trace_kprobe *tk = (struct trace_kprobe *)event_call->data;
 
 	DEFINE_FIELD(unsigned long, ip, FIELD_STRING_IP, 0);
-	/* Set argument names as fields */
-	for (i = 0; i < tk->tp.nr_args; i++) {
-		struct probe_arg *parg = &tk->tp.args[i];
 
-		ret = trace_define_field(event_call, parg->type->fmttype,
-					 parg->name,
-					 sizeof(field) + parg->offset,
-					 parg->type->size,
-					 parg->type->is_signed,
-					 FILTER_OTHER);
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return traceprobe_define_arg_fields(event_call, sizeof(field), &tk->tp);
 }
 
 static int kretprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret, i;
+	int ret;
 	struct kretprobe_trace_entry_head field;
 	struct trace_kprobe *tk = (struct trace_kprobe *)event_call->data;
 
 	DEFINE_FIELD(unsigned long, func, FIELD_STRING_FUNC, 0);
 	DEFINE_FIELD(unsigned long, ret_ip, FIELD_STRING_RETIP, 0);
-	/* Set argument names as fields */
-	for (i = 0; i < tk->tp.nr_args; i++) {
-		struct probe_arg *parg = &tk->tp.args[i];
 
-		ret = trace_define_field(event_call, parg->type->fmttype,
-					 parg->name,
-					 sizeof(field) + parg->offset,
-					 parg->type->size,
-					 parg->type->is_signed,
-					 FILTER_OTHER);
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return traceprobe_define_arg_fields(event_call, sizeof(field), &tk->tp);
 }
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 8894b81e29b0..049e8531fdf8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -680,3 +680,24 @@ int set_print_fmt(struct trace_probe *tp, bool is_return)
 
 	return 0;
 }
+
+int traceprobe_define_arg_fields(struct trace_event_call *event_call,
+				 size_t offset, struct trace_probe *tp)
+{
+	int ret, i;
+
+	/* Set argument names as fields */
+	for (i = 0; i < tp->nr_args; i++) {
+		struct probe_arg *parg = &tp->args[i];
+
+		ret = trace_define_field(event_call, parg->type->fmttype,
+					 parg->name,
+					 offset + parg->offset,
+					 parg->type->size,
+					 parg->type->is_signed,
+					 FILTER_OTHER);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 0c8e66f9c855..de928052926b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -440,3 +440,5 @@ extern struct trace_event_call *
 create_local_trace_uprobe(char *name, unsigned long offs, bool is_return);
 extern void destroy_local_trace_uprobe(struct trace_event_call *event_call);
 #endif
+extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
+					size_t offset, struct trace_probe *tp);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index d5e7d84e375a..c21c3783d055 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -969,7 +969,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
 
 static int uprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret, i, size;
+	int ret, size;
 	struct uprobe_trace_entry_head field;
 	struct trace_uprobe *tu = event_call->data;
 
@@ -981,19 +981,8 @@ static int uprobe_event_define_fields(struct trace_event_call *event_call)
 		DEFINE_FIELD(unsigned long, vaddr[0], FIELD_STRING_IP, 0);
 		size = SIZEOF_TRACE_ENTRY(false);
 	}
-	/* Set argument names as fields */
-	for (i = 0; i < tu->tp.nr_args; i++) {
-		struct probe_arg *parg = &tu->tp.args[i];
-
-		ret = trace_define_field(event_call, parg->type->fmttype,
-					 parg->name, size + parg->offset,
-					 parg->type->size, parg->type->is_signed,
-					 FILTER_OTHER);
 
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return traceprobe_define_arg_fields(event_call, size, &tu->tp);
 }
 
 #ifdef CONFIG_PERF_EVENTS

