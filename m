Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2379DC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5C4217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5C4217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeHKQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbeHKQY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:29 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D41321B31;
        Sat, 11 Aug 2018 13:50:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHU-00064N-GH; Sat, 11 Aug 2018 09:50:12 -0400
Message-Id: <20180811135012.404058343@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 09/34] tracing/kprobes: Simplify the logic of enable_trace_kprobe()
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function enable_trace_kprobe() performs slightly differently if the file
parameter is passed in as NULL on non-NULL. Instead of checking file twice,
move the code between the two tests into a static inline helper function to
make the code easier to follow.

Link: http://lkml.kernel.org/r/20180725224728.7b1d5db2@vmware.local.home
Link: http://lkml.kernel.org/r/20180726121152.4dd54330@gandalf.local.home

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 42 +++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 6b71860f3998..0534eb8b7640 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -393,6 +393,20 @@ static struct trace_kprobe *find_trace_kprobe(const char *event,
 	return NULL;
 }
 
+static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
+{
+	int ret = 0;
+
+	if (trace_probe_is_registered(&tk->tp) && !trace_kprobe_has_gone(tk)) {
+		if (trace_kprobe_is_return(tk))
+			ret = enable_kretprobe(&tk->rp);
+		else
+			ret = enable_kprobe(&tk->rp.kp);
+	}
+
+	return ret;
+}
+
 /*
  * Enable trace_probe
  * if the file is NULL, enable "perf" handler, or enable "trace" handler.
@@ -400,7 +414,7 @@ static struct trace_kprobe *find_trace_kprobe(const char *event,
 static int
 enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 {
-	struct event_file_link *link = NULL;
+	struct event_file_link *link;
 	int ret = 0;
 
 	if (file) {
@@ -414,26 +428,18 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 		list_add_tail_rcu(&link->list, &tk->tp.files);
 
 		tk->tp.flags |= TP_FLAG_TRACE;
-	} else
-		tk->tp.flags |= TP_FLAG_PROFILE;
-
-	if (trace_probe_is_registered(&tk->tp) && !trace_kprobe_has_gone(tk)) {
-		if (trace_kprobe_is_return(tk))
-			ret = enable_kretprobe(&tk->rp);
-		else
-			ret = enable_kprobe(&tk->rp.kp);
-	}
-
-	if (ret) {
-		if (file) {
-			/* Notice the if is true on not WARN() */
-			if (!WARN_ON_ONCE(!link))
-				list_del_rcu(&link->list);
+		ret = __enable_trace_kprobe(tk);
+		if (ret) {
+			list_del_rcu(&link->list);
 			kfree(link);
 			tk->tp.flags &= ~TP_FLAG_TRACE;
-		} else {
-			tk->tp.flags &= ~TP_FLAG_PROFILE;
 		}
+
+	} else {
+		tk->tp.flags |= TP_FLAG_PROFILE;
+		ret = __enable_trace_kprobe(tk);
+		if (ret)
+			tk->tp.flags &= ~TP_FLAG_PROFILE;
 	}
  out:
 	return ret;
-- 
2.18.0


