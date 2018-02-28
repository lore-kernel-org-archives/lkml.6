Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224hhoELe8z4dhmuv4i4f4b2ofFTbFdM/IgsBETeWk7zfn8cg1irNm43cL4C7gHrhtCGZjjl
ARC-Seal: i=1; a=rsa-sha256; t=1519788168; cv=none;
        d=google.com; s=arc-20160816;
        b=GCvezQ7V+Wgt3Y/u6t/y2ylxxU/mYlTa9aU4emA/rqTHcEMOZfBjF07RIFsB6Odrj5
         B0STRr7G6AnEYSoPj/DCaFJELBiQ9UB25iCEaNcGzCZEDEyw81k30kyY6keFb5oDJPaE
         zCQaqRapKbGSKYetYfMWt3Bekvh4uHQdOaOpePv3y6HcdVd8VMGLqxkjKAqZMYeOy0Ql
         peY7VP8stQQqGVmZOsWrQwHFfL1X/UtxJwdBRLJczLE0nL8aEUqgBvthgXyyQsGmmxho
         +vQ3MBjAnYW3XyvRZFp6vgYs9s1eFOevCTcBu0qDaxR8ffrjySYyeynse/tO3qSJ5Eui
         J67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=tn1AVs8JfOfm0GVQI1hVWIQSva71L9HJNFTB0zG6Fc0=;
        b=nT8/DSMxlwu7L6E4YhwT6VpfAtD4HlPY5NH2PnJWW+vEcAk50lq50/cCQTRG86QxQ0
         mGMPmtqMEI7rrrLlJe0fZnhYZo6ZX2n7gSQFMgt9WWEtZbwb/Duv5X9pyaUAWwwozb8g
         Fw8U9s9nwJjoX7VvvQzPGM/OQ0S2Ot38HxFun1tfCpbhWWLmjE82ycqKLJ2/w2C2+SqJ
         zPqWQdntebUzU3Ft/R7XkWfisLZ0UHybr+j8Cbgi7o7h90nzWri+Vx7J4Zt443LFuS5T
         YwESWd7BMhbKVYJnTkoQBxqMvuW1w6K6ZT37rxh8GjyFLfIc1yXQDpQ/POXiPhOyX3ST
         ALuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeB1DWs (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 22:22:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751713AbeB1DWr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 22:22:47 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FC32168D
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
Subject: [PATCH v4 06/19] tracing: probeevent: Cleanup argument field definition
Date: Wed, 28 Feb 2018 12:22:23 +0900
Message-Id: <151978814335.2577.15921272808526116424.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151978796240.2577.6531711990653677529.stgit@devbox>
References: <151978796240.2577.6531711990653677529.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613398729987969?=
X-GMAIL-MSGID: =?utf-8?q?1593613398729987969?=
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
index 4c006a693663..887da2bb63aa 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -982,7 +982,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
 
 static int uprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret, i, size;
+	int ret, size;
 	struct uprobe_trace_entry_head field;
 	struct trace_uprobe *tu = event_call->data;
 
@@ -994,19 +994,8 @@ static int uprobe_event_define_fields(struct trace_event_call *event_call)
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

