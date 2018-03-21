Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeCUCaJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbeCUCVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4956121835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022124.220256868@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 08/46] tracing: Give event triggers access to ring_buffer_event
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0008-tracing-Give-event-triggers-access-to-ring_buffer_ev.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

The ring_buffer event can provide a timestamp that may be useful to
various triggers - pass it into the handlers for that purpose.

Link: http://lkml.kernel.org/r/6de592683b59fa70ffa5d43d0109896623fc1367.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h        | 14 ++++++-----
 kernel/trace/trace.h                |  9 +++----
 kernel/trace/trace_events_hist.c    | 11 +++++----
 kernel/trace/trace_events_trigger.c | 47 +++++++++++++++++++++++--------------
 4 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a1442c4e513..0cf48c61cc6d 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -430,11 +430,13 @@ enum event_trigger_type {
 
 extern int filter_match_preds(struct event_filter *filter, void *rec);
 
-extern enum event_trigger_type event_triggers_call(struct trace_event_file *file,
-						   void *rec);
-extern void event_triggers_post_call(struct trace_event_file *file,
-				     enum event_trigger_type tt,
-				     void *rec);
+extern enum event_trigger_type
+event_triggers_call(struct trace_event_file *file, void *rec,
+		    struct ring_buffer_event *event);
+extern void
+event_triggers_post_call(struct trace_event_file *file,
+			 enum event_trigger_type tt,
+			 void *rec, struct ring_buffer_event *event);
 
 bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
 
@@ -454,7 +456,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
 
 	if (!(eflags & EVENT_FILE_FL_TRIGGER_COND)) {
 		if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
-			event_triggers_call(file, NULL);
+			event_triggers_call(file, NULL, NULL);
 		if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
 			return true;
 		if (eflags & EVENT_FILE_FL_PID_FILTER)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 477341710ebf..99060f7eebbd 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1294,7 +1294,7 @@ __event_trigger_test_discard(struct trace_event_file *file,
 	unsigned long eflags = file->flags;
 
 	if (eflags & EVENT_FILE_FL_TRIGGER_COND)
-		*tt = event_triggers_call(file, entry);
+		*tt = event_triggers_call(file, entry, event);
 
 	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
 	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
@@ -1331,7 +1331,7 @@ event_trigger_unlock_commit(struct trace_event_file *file,
 		trace_buffer_unlock_commit(file->tr, buffer, event, irq_flags, pc);
 
 	if (tt)
-		event_triggers_post_call(file, tt, entry);
+		event_triggers_post_call(file, tt, entry, event);
 }
 
 /**
@@ -1364,7 +1364,7 @@ event_trigger_unlock_commit_regs(struct trace_event_file *file,
 						irq_flags, pc, regs);
 
 	if (tt)
-		event_triggers_post_call(file, tt, entry);
+		event_triggers_post_call(file, tt, entry, event);
 }
 
 #define FILTER_PRED_INVALID	((unsigned short)-1)
@@ -1589,7 +1589,8 @@ extern int register_trigger_hist_enable_disable_cmds(void);
  */
 struct event_trigger_ops {
 	void			(*func)(struct event_trigger_data *data,
-					void *rec);
+					void *rec,
+					struct ring_buffer_event *rbe);
 	int			(*init)(struct event_trigger_ops *ops,
 					struct event_trigger_data *data);
 	void			(*free)(struct event_trigger_ops *ops,
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 712260e72be5..63a19123cf47 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -909,7 +909,8 @@ static inline void add_to_key(char *compound_key, void *key,
 	memcpy(compound_key + key_field->offset, key, size);
 }
 
-static void event_hist_trigger(struct event_trigger_data *data, void *rec)
+static void event_hist_trigger(struct event_trigger_data *data, void *rec,
+			       struct ring_buffer_event *event)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 	bool use_compound_key = (hist_data->n_keys > 1);
@@ -1658,7 +1659,8 @@ __init int register_trigger_hist_cmd(void)
 }
 
 static void
-hist_enable_trigger(struct event_trigger_data *data, void *rec)
+hist_enable_trigger(struct event_trigger_data *data, void *rec,
+		    struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 	struct event_trigger_data *test;
@@ -1674,7 +1676,8 @@ hist_enable_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-hist_enable_count_trigger(struct event_trigger_data *data, void *rec)
+hist_enable_count_trigger(struct event_trigger_data *data, void *rec,
+			  struct ring_buffer_event *event)
 {
 	if (!data->count)
 		return;
@@ -1682,7 +1685,7 @@ hist_enable_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	hist_enable_trigger(data, rec);
+	hist_enable_trigger(data, rec, event);
 }
 
 static struct event_trigger_ops hist_enable_trigger_ops = {
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 87411482a46f..632471692462 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -63,7 +63,8 @@ void trigger_data_free(struct event_trigger_data *data)
  * any trigger that should be deferred, ETT_NONE if nothing to defer.
  */
 enum event_trigger_type
-event_triggers_call(struct trace_event_file *file, void *rec)
+event_triggers_call(struct trace_event_file *file, void *rec,
+		    struct ring_buffer_event *event)
 {
 	struct event_trigger_data *data;
 	enum event_trigger_type tt = ETT_NONE;
@@ -76,7 +77,7 @@ event_triggers_call(struct trace_event_file *file, void *rec)
 		if (data->paused)
 			continue;
 		if (!rec) {
-			data->ops->func(data, rec);
+			data->ops->func(data, rec, event);
 			continue;
 		}
 		filter = rcu_dereference_sched(data->filter);
@@ -86,7 +87,7 @@ event_triggers_call(struct trace_event_file *file, void *rec)
 			tt |= data->cmd_ops->trigger_type;
 			continue;
 		}
-		data->ops->func(data, rec);
+		data->ops->func(data, rec, event);
 	}
 	return tt;
 }
@@ -108,7 +109,7 @@ EXPORT_SYMBOL_GPL(event_triggers_call);
 void
 event_triggers_post_call(struct trace_event_file *file,
 			 enum event_trigger_type tt,
-			 void *rec)
+			 void *rec, struct ring_buffer_event *event)
 {
 	struct event_trigger_data *data;
 
@@ -116,7 +117,7 @@ event_triggers_post_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (data->cmd_ops->trigger_type & tt)
-			data->ops->func(data, rec);
+			data->ops->func(data, rec, event);
 	}
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
@@ -909,7 +910,8 @@ void set_named_trigger_data(struct event_trigger_data *data,
 }
 
 static void
-traceon_trigger(struct event_trigger_data *data, void *rec)
+traceon_trigger(struct event_trigger_data *data, void *rec,
+		struct ring_buffer_event *event)
 {
 	if (tracing_is_on())
 		return;
@@ -918,7 +920,8 @@ traceon_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-traceon_count_trigger(struct event_trigger_data *data, void *rec)
+traceon_count_trigger(struct event_trigger_data *data, void *rec,
+		      struct ring_buffer_event *event)
 {
 	if (tracing_is_on())
 		return;
@@ -933,7 +936,8 @@ traceon_count_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-traceoff_trigger(struct event_trigger_data *data, void *rec)
+traceoff_trigger(struct event_trigger_data *data, void *rec,
+		 struct ring_buffer_event *event)
 {
 	if (!tracing_is_on())
 		return;
@@ -942,7 +946,8 @@ traceoff_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-traceoff_count_trigger(struct event_trigger_data *data, void *rec)
+traceoff_count_trigger(struct event_trigger_data *data, void *rec,
+		       struct ring_buffer_event *event)
 {
 	if (!tracing_is_on())
 		return;
@@ -1039,13 +1044,15 @@ static struct event_command trigger_traceoff_cmd = {
 
 #ifdef CONFIG_TRACER_SNAPSHOT
 static void
-snapshot_trigger(struct event_trigger_data *data, void *rec)
+snapshot_trigger(struct event_trigger_data *data, void *rec,
+		 struct ring_buffer_event *event)
 {
 	tracing_snapshot();
 }
 
 static void
-snapshot_count_trigger(struct event_trigger_data *data, void *rec)
+snapshot_count_trigger(struct event_trigger_data *data, void *rec,
+		       struct ring_buffer_event *event)
 {
 	if (!data->count)
 		return;
@@ -1053,7 +1060,7 @@ snapshot_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	snapshot_trigger(data, rec);
+	snapshot_trigger(data, rec, event);
 }
 
 static int
@@ -1141,13 +1148,15 @@ static __init int register_trigger_snapshot_cmd(void) { return 0; }
 #endif
 
 static void
-stacktrace_trigger(struct event_trigger_data *data, void *rec)
+stacktrace_trigger(struct event_trigger_data *data, void *rec,
+		   struct ring_buffer_event *event)
 {
 	trace_dump_stack(STACK_SKIP);
 }
 
 static void
-stacktrace_count_trigger(struct event_trigger_data *data, void *rec)
+stacktrace_count_trigger(struct event_trigger_data *data, void *rec,
+			 struct ring_buffer_event *event)
 {
 	if (!data->count)
 		return;
@@ -1155,7 +1164,7 @@ stacktrace_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	stacktrace_trigger(data, rec);
+	stacktrace_trigger(data, rec, event);
 }
 
 static int
@@ -1217,7 +1226,8 @@ static __init void unregister_trigger_traceon_traceoff_cmds(void)
 }
 
 static void
-event_enable_trigger(struct event_trigger_data *data, void *rec)
+event_enable_trigger(struct event_trigger_data *data, void *rec,
+		     struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
@@ -1228,7 +1238,8 @@ event_enable_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-event_enable_count_trigger(struct event_trigger_data *data, void *rec)
+event_enable_count_trigger(struct event_trigger_data *data, void *rec,
+			   struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
@@ -1242,7 +1253,7 @@ event_enable_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	event_enable_trigger(data, rec);
+	event_enable_trigger(data, rec, event);
 }
 
 int event_enable_trigger_print(struct seq_file *m,
-- 
2.15.1
