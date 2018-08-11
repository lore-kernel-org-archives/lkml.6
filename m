Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB19C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6AC217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6AC217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeHKQY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeHKQY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:29 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0278921A88;
        Sat, 11 Aug 2018 13:50:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHU-00062k-0L; Sat, 11 Aug 2018 09:50:12 -0400
Message-Id: <20180811135011.905622412@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 06/34] tracing: Make unregister_trigger() static
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Nothing uses unregister_trigger() outside of trace_events_trigger.c file,
thus it should be static. Not sure why this was ever converted, because
its counter part, register_trigger(), was always static.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                | 3 ---
 kernel/trace/trace_events_trigger.c | 6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f8f86231ad90..3f9d9acc69e6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1533,9 +1533,6 @@ extern int event_trigger_init(struct event_trigger_ops *ops,
 extern int trace_event_trigger_enable_disable(struct trace_event_file *file,
 					      int trigger_enable);
 extern void update_cond_flag(struct trace_event_file *file);
-extern void unregister_trigger(char *glob, struct event_trigger_ops *ops,
-			       struct event_trigger_data *test,
-			       struct trace_event_file *file);
 extern int set_trigger_filter(char *filter_str,
 			      struct event_trigger_data *trigger_data,
 			      struct trace_event_file *file);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 5dea177cef53..58d21fd52932 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -579,9 +579,9 @@ static int register_trigger(char *glob, struct event_trigger_ops *ops,
  * Usually used directly as the @unreg method in event command
  * implementations.
  */
-void unregister_trigger(char *glob, struct event_trigger_ops *ops,
-			struct event_trigger_data *test,
-			struct trace_event_file *file)
+static void unregister_trigger(char *glob, struct event_trigger_ops *ops,
+			       struct event_trigger_data *test,
+			       struct trace_event_file *file)
 {
 	struct event_trigger_data *data;
 	bool unregistered = false;
-- 
2.18.0


