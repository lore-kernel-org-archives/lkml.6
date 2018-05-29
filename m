Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935824AbeE2PXu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935454AbeE2PX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:29 -0400
Message-Id: <20180529152326.280237725@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [for-next][PATCH 03/19] tracing: Do not reference event data in post call triggers
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0003-tracing-Do-not-reference-event-data-in-post-call-tri.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Trace event triggers can be called before or after the event has been
committed. If it has been called after the commit, there's a possibility
that the event no longer exists. Currently, the two post callers is the
trigger to disable tracing (traceoff) and the one that will record a stack
dump (stacktrace). Neither of them reference the trace event entry record,
as that would lead to a race condition that could pass in corrupted data.

To prevent any other users of the post data triggers from using the trace
event record, pass in NULL to the post call trigger functions for the event
record, as they should never need to use them in the first place.

This does not fix any bug, but prevents bugs from happening by new post call
trigger users.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h        | 3 +--
 kernel/trace/trace.h                | 4 ++--
 kernel/trace/trace_events_trigger.c | 6 ++----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 2bde3eff564c..d1c442d9bd85 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -435,8 +435,7 @@ event_triggers_call(struct trace_event_file *file, void *rec,
 		    struct ring_buffer_event *event);
 extern void
 event_triggers_post_call(struct trace_event_file *file,
-			 enum event_trigger_type tt,
-			 void *rec, struct ring_buffer_event *event);
+			 enum event_trigger_type tt);
 
 bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 507954b4e058..6bfc2467479c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1334,7 +1334,7 @@ event_trigger_unlock_commit(struct trace_event_file *file,
 		trace_buffer_unlock_commit(file->tr, buffer, event, irq_flags, pc);
 
 	if (tt)
-		event_triggers_post_call(file, tt, entry, event);
+		event_triggers_post_call(file, tt);
 }
 
 /**
@@ -1367,7 +1367,7 @@ event_trigger_unlock_commit_regs(struct trace_event_file *file,
 						irq_flags, pc, regs);
 
 	if (tt)
-		event_triggers_post_call(file, tt, entry, event);
+		event_triggers_post_call(file, tt);
 }
 
 #define FILTER_PRED_INVALID	((unsigned short)-1)
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 8b5bdcf64871..d18249683682 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -97,7 +97,6 @@ EXPORT_SYMBOL_GPL(event_triggers_call);
  * event_triggers_post_call - Call 'post_triggers' for a trace event
  * @file: The trace_event_file associated with the event
  * @tt: enum event_trigger_type containing a set bit for each trigger to invoke
- * @rec: The trace entry for the event
  *
  * For each trigger associated with an event, invoke the trigger
  * function registered with the associated trigger command, if the
@@ -108,8 +107,7 @@ EXPORT_SYMBOL_GPL(event_triggers_call);
  */
 void
 event_triggers_post_call(struct trace_event_file *file,
-			 enum event_trigger_type tt,
-			 void *rec, struct ring_buffer_event *event)
+			 enum event_trigger_type tt)
 {
 	struct event_trigger_data *data;
 
@@ -117,7 +115,7 @@ event_triggers_post_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (data->cmd_ops->trigger_type & tt)
-			data->ops->func(data, rec, event);
+			data->ops->func(data, NULL, NULL);
 	}
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
-- 
2.17.0
