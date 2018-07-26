Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D3CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F16920857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F16920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeG0AZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbeG0AZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:25:50 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0462220894;
        Thu, 26 Jul 2018 23:06:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fipLQ-0006AS-0m; Thu, 26 Jul 2018 19:06:52 -0400
Message-Id: <20180726230651.924950754@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 26 Jul 2018 19:06:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, stable@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCH 4/7] tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe()
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Savkov <asavkov@redhat.com>

If enable_trace_kprobe fails to enable the probe in enable_k(ret)probe
it returns an error, but does not unset the tp flags it set previously.
This results in a probe being considered enabled and failures like being
unable to remove the probe through kprobe_events file since probes_open()
expects every probe to be disabled.

Link: http://lkml.kernel.org/r/20180725102826.8300-1-asavkov@redhat.com
Link: http://lkml.kernel.org/r/20180725142038.4765-1-asavkov@redhat.com

Cc: Ingo Molnar <mingo@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 41a7dd420c57 ("tracing/kprobes: Support ftrace_event_file base multibuffer")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 21f718472942..27ace4513c43 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -400,11 +400,10 @@ static struct trace_kprobe *find_trace_kprobe(const char *event,
 static int
 enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 {
+	struct event_file_link *link;
 	int ret = 0;
 
 	if (file) {
-		struct event_file_link *link;
-
 		link = kmalloc(sizeof(*link), GFP_KERNEL);
 		if (!link) {
 			ret = -ENOMEM;
@@ -424,6 +423,16 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 		else
 			ret = enable_kprobe(&tk->rp.kp);
 	}
+
+	if (ret) {
+		if (file) {
+			list_del_rcu(&link->list);
+			kfree(link);
+			tk->tp.flags &= ~TP_FLAG_TRACE;
+		} else {
+			tk->tp.flags &= ~TP_FLAG_PROFILE;
+		}
+	}
  out:
 	return ret;
 }
-- 
2.17.1


