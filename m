Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA46BC46470
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B43217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B43217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeHKQYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbeHKQYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:34 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6554421A2B;
        Sat, 11 Aug 2018 13:50:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHZ-0006H9-2L; Sat, 11 Aug 2018 09:50:17 -0400
Message-Id: <20180811135016.978955328@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:50:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 32/34] tracing: Fix synchronizing to event changes with
 tracepoint_synchronize_unregister()
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Now that some trace events can be protected by srcu_read_lock(tracepoint_srcu),
we need to make sure all locations that depend on this are also protected.
There were many places that did a synchronize_sched() thinking that it was
enough to protect againts access to trace events. This use to be the case,
but now that we use SRCU for _rcuidle() trace events, they may not be
protected by synchronize_sched(), as they may be called in paths that RCU is
not watching for preempt disable.

Fixes: e6753f23d961d ("tracepoint: Make rcuidle tracepoint callers use SRCU")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c         |  8 ++++----
 kernel/trace/trace_events_filter.c  | 15 ++++++++-------
 kernel/trace/trace_events_hist.c    |  2 +-
 kernel/trace/trace_events_trigger.c |  6 ++++--
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7b508ce8ac44..808cf29febe2 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -636,7 +636,7 @@ static void __ftrace_clear_event_pids(struct trace_array *tr)
 	rcu_assign_pointer(tr->filtered_pids, NULL);
 
 	/* Wait till all users are no longer using pid filtering */
-	synchronize_sched();
+	tracepoint_synchronize_unregister();
 
 	trace_free_pid_list(pid_list);
 }
@@ -1622,7 +1622,7 @@ ftrace_event_pid_write(struct file *filp, const char __user *ubuf,
 	}
 
 	if (filtered_pids) {
-		synchronize_sched();
+		tracepoint_synchronize_unregister();
 		trace_free_pid_list(filtered_pids);
 	} else if (pid_list) {
 		/*
@@ -3036,8 +3036,8 @@ int event_trace_del_tracer(struct trace_array *tr)
 	/* Disable any running events */
 	__ftrace_set_clr_event_nolock(tr, NULL, NULL, NULL, 0);
 
-	/* Access to events are within rcu_read_lock_sched() */
-	synchronize_sched();
+	/* Make sure no more events are being executed */
+	tracepoint_synchronize_unregister();
 
 	down_write(&trace_event_sem);
 	__trace_remove_event_dirs(tr);
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 893a206bcba4..184c7685d5ea 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -899,7 +899,8 @@ int filter_match_preds(struct event_filter *filter, void *rec)
 	if (!filter)
 		return 1;
 
-	prog = rcu_dereference_sched(filter->prog);
+	/* Protected by either SRCU(tracepoint_srcu) or preempt_disable */
+	prog = rcu_dereference_raw(filter->prog);
 	if (!prog)
 		return 1;
 
@@ -1626,10 +1627,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 
 	/*
 	 * The calls can still be using the old filters.
-	 * Do a synchronize_sched() to ensure all calls are
+	 * Do a synchronize_sched() and to ensure all calls are
 	 * done with them before we free them.
 	 */
-	synchronize_sched();
+	tracepoint_synchronize_unregister();
 	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
 		__free_filter(filter_item->filter);
 		list_del(&filter_item->list);
@@ -1648,7 +1649,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	kfree(filter);
 	/* If any call succeeded, we still need to sync */
 	if (!fail)
-		synchronize_sched();
+		tracepoint_synchronize_unregister();
 	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
 		__free_filter(filter_item->filter);
 		list_del(&filter_item->list);
@@ -1790,7 +1791,7 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 		event_clear_filter(file);
 
 		/* Make sure the filter is not being used */
-		synchronize_sched();
+		tracepoint_synchronize_unregister();
 		__free_filter(filter);
 
 		return 0;
@@ -1817,7 +1818,7 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 
 		if (tmp) {
 			/* Make sure the call is done with the filter */
-			synchronize_sched();
+			tracepoint_synchronize_unregister();
 			__free_filter(tmp);
 		}
 	}
@@ -1847,7 +1848,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 		filter = system->filter;
 		system->filter = NULL;
 		/* Ensure all filters are no longer used */
-		synchronize_sched();
+		tracepoint_synchronize_unregister();
 		filter_free_subsystem_filters(dir, tr);
 		__free_filter(filter);
 		goto out_unlock;
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index aae18af94c94..c522b51d9909 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5141,7 +5141,7 @@ static void hist_clear(struct event_trigger_data *data)
 	if (data->name)
 		pause_named_trigger(data);
 
-	synchronize_sched();
+	tracepoint_synchronize_unregister();
 
 	tracing_map_clear(hist_data->map);
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 58d21fd52932..750044ef15e8 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -34,7 +34,9 @@ void trigger_data_free(struct event_trigger_data *data)
 	if (data->cmd_ops->set_filter)
 		data->cmd_ops->set_filter(NULL, data, NULL);
 
-	synchronize_sched(); /* make sure current triggers exit before free */
+	/* make sure current triggers exit before free */
+	tracepoint_synchronize_unregister();
+
 	kfree(data);
 }
 
@@ -752,7 +754,7 @@ int set_trigger_filter(char *filter_str,
 
 	if (tmp) {
 		/* Make sure the call is done with the filter */
-		synchronize_sched();
+		tracepoint_synchronize_unregister();
 		free_event_filter(tmp);
 	}
 
-- 
2.18.0


