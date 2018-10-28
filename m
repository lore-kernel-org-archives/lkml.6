Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F1BECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635C320843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635C320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeJ1QPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbeJ1QPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:15:23 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CEFC20883;
        Sun, 28 Oct 2018 07:31:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gGfXp-00081w-Kr; Sun, 28 Oct 2018 03:31:33 -0400
Message-Id: <20181028073133.548223936@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 28 Oct 2018 03:29:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 02/18] tracing: probeevent: Cleanup argument field definition
References: <20181028072948.693267247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Cleanup event argument definition code in one place for
maintenancability.

Link: http://lkml.kernel.org/r/152465862529.26224.9068605421476018902.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 32 ++++----------------------------
 kernel/trace/trace_probe.c  | 21 +++++++++++++++++++++
 kernel/trace/trace_probe.h  |  2 ++
 kernel/trace/trace_uprobe.c | 15 ++-------------
 4 files changed, 29 insertions(+), 41 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 6326c71181aa..1356927e32d0 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1192,49 +1192,25 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 
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
index e2c184eaa7db..21af28ffba3a 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -668,3 +668,24 @@ int set_print_fmt(struct trace_probe *tp, bool is_return)
 
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
index 8254a061ac35..a1df7763b797 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -429,3 +429,5 @@ create_local_trace_uprobe(char *name, unsigned long offs,
 			  unsigned long ref_ctr_offset, bool is_return);
 extern void destroy_local_trace_uprobe(struct trace_event_call *event_call);
 #endif
+extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
+					size_t offset, struct trace_probe *tp);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c55753e1079e..28a8f69cec89 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1018,7 +1018,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
 
 static int uprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret, i, size;
+	int ret, size;
 	struct uprobe_trace_entry_head field;
 	struct trace_uprobe *tu = event_call->data;
 
@@ -1030,19 +1030,8 @@ static int uprobe_event_define_fields(struct trace_event_call *event_call)
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
-- 
2.19.0


