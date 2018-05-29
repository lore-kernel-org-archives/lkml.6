Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933531AbeE2Lyu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933426AbeE2LyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:54:25 -0400
Message-Id: <20180529115423.753599049@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 07:53:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: [PATCH 2/2] tracing: Make the snapshot trigger work with instances
References: <20180529115329.698052604@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0002-tracing-Make-the-snapshot-trigger-work-with-instance.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The snapshot trigger currently only affects the main ring buffer, even when
it is used by the instances. This can be confusing as the snapshot trigger
is listed in the instance.

 > # cd /sys/kernel/tracing
 > # mkdir instances/foo
 > # echo snapshot > instances/foo/events/syscalls/sys_enter_fchownat/trigger
 > # echo top buffer > trace_marker
 > # echo foo buffer > instances/foo/trace_marker
 > # touch /tmp/bar
 > # chown rostedt /tmp/bar
 > # cat instances/foo/snapshot
 # tracer: nop
 #
 #
 # * Snapshot is freed *
 #
 # Snapshot commands:
 # echo 0 > snapshot : Clears and frees snapshot buffer
 # echo 1 > snapshot : Allocates snapshot buffer, if not already allocated.
 #                      Takes a snapshot of the main buffer.
 # echo 2 > snapshot : Clears snapshot buffer (but does not allocate or free)
 #                      (Doesn't have to be '2' works with any number that
 #                       is not a '0' or '1')

 > # cat snapshot
 # tracer: nop
 #
 #                              _-----=> irqs-off
 #                             / _----=> need-resched
 #                            | / _---=> hardirq/softirq
 #                            || / _--=> preempt-depth
 #                            ||| /     delay
 #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
 #              | |       |   ||||       |         |
             bash-1189  [000] ....   111.488323: tracing_mark_write: top buffer

Not only did the snapshot occur in the top level buffer, but the instance
snapshot buffer should have been allocated, and it is still free.

Cc: stable@vger.kernel.org
Fixes: 85f2b08268c01 ("tracing: Add basic event trigger framework")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c                | 12 ++++++------
 kernel/trace/trace.h                | 11 +++++++++++
 kernel/trace/trace_events_trigger.c | 10 ++++++++--
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 414d7210b2ec..bcd93031d042 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -893,7 +893,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 EXPORT_SYMBOL_GPL(__trace_bputs);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-static void tracing_snapshot_instance(struct trace_array *tr)
+void tracing_snapshot_instance(struct trace_array *tr)
 {
 	struct tracer *tracer = tr->current_trace;
 	unsigned long flags;
@@ -949,7 +949,7 @@ static int resize_buffer_duplicate_size(struct trace_buffer *trace_buf,
 					struct trace_buffer *size_buf, int cpu_id);
 static void set_buffer_entries(struct trace_buffer *buf, unsigned long val);
 
-static int alloc_snapshot(struct trace_array *tr)
+int tracing_alloc_snapshot_instance(struct trace_array *tr)
 {
 	int ret;
 
@@ -995,7 +995,7 @@ int tracing_alloc_snapshot(void)
 	struct trace_array *tr = &global_trace;
 	int ret;
 
-	ret = alloc_snapshot(tr);
+	ret = tracing_alloc_snapshot_instance(tr);
 	WARN_ON(ret < 0);
 
 	return ret;
@@ -5408,7 +5408,7 @@ static int tracing_set_tracer(struct trace_array *tr, const char *buf)
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 	if (t->use_max_tr && !had_max_tr) {
-		ret = alloc_snapshot(tr);
+		ret = tracing_alloc_snapshot_instance(tr);
 		if (ret < 0)
 			goto out;
 	}
@@ -6451,7 +6451,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		}
 #endif
 		if (!tr->allocated_snapshot) {
-			ret = alloc_snapshot(tr);
+			ret = tracing_alloc_snapshot_instance(tr);
 			if (ret < 0)
 				break;
 		}
@@ -7179,7 +7179,7 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
 		return ret;
 
  out_reg:
-	ret = alloc_snapshot(tr);
+	ret = tracing_alloc_snapshot_instance(tr);
 	if (ret < 0)
 		goto out;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6fb46a06c9dc..507954b4e058 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1817,6 +1817,17 @@ static inline void __init trace_event_init(void) { }
 static inline void trace_event_eval_update(struct trace_eval_map **map, int len) { }
 #endif
 
+#ifdef CONFIG_TRACER_SNAPSHOT
+void tracing_snapshot_instance(struct trace_array *tr);
+int tracing_alloc_snapshot_instance(struct trace_array *tr);
+#else
+static inline void tracing_snapshot_instance(struct trace_array *tr) { }
+static inline int tracing_alloc_snapshot_instance(struct trace_array *tr)
+{
+	return 0;
+}
+#endif
+
 extern struct trace_iterator *tracepoint_print_iter;
 
 #endif /* _LINUX_KERNEL_TRACE_H */
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 9be317d388c5..8b5bdcf64871 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -643,6 +643,7 @@ event_trigger_callback(struct event_command *cmd_ops,
 	trigger_data->count = -1;
 	trigger_data->ops = trigger_ops;
 	trigger_data->cmd_ops = cmd_ops;
+	trigger_data->private_data = file;
 	INIT_LIST_HEAD(&trigger_data->list);
 	INIT_LIST_HEAD(&trigger_data->named_list);
 
@@ -1054,7 +1055,12 @@ static void
 snapshot_trigger(struct event_trigger_data *data, void *rec,
 		 struct ring_buffer_event *event)
 {
-	tracing_snapshot();
+	struct trace_event_file *file = data->private_data;
+
+	if (file)
+		tracing_snapshot_instance(file->tr);
+	else
+		tracing_snapshot();
 }
 
 static void
@@ -1077,7 +1083,7 @@ register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
 {
 	int ret = register_trigger(glob, ops, data, file);
 
-	if (ret > 0 && tracing_alloc_snapshot() != 0) {
+	if (ret > 0 && tracing_alloc_snapshot_instance(file->tr) != 0) {
 		unregister_trigger(glob, ops, data, file);
 		ret = 0;
 	}
-- 
2.17.0
