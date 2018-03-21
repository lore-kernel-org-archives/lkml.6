Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeCUCaT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751551AbeCUCVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC95421838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022123.701682929@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:20:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Baohong Liu <baohong.liu@intel.com>
Subject: [for-next][PATCH 05/46] ring-buffer: Add interface for setting absolute time stamps
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0005-ring-buffer-Add-interface-for-setting-absolute-time-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Define a new function, tracing_set_time_stamp_abs(), which can be used
to enable or disable the use of absolute timestamps rather than time
deltas for a trace array.

Only the interface is added here; a subsequent patch will add the
underlying implementation.

Link: http://lkml.kernel.org/r/ce96119de44c7fe0ee44786d15254e9b493040d3.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Baohong Liu <baohong.liu@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  2 ++
 kernel/trace/ring_buffer.c  | 11 +++++++++++
 kernel/trace/trace.c        | 33 ++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h        |  3 +++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 7d9eb39fa76a..025159e17e1b 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -178,6 +178,8 @@ void ring_buffer_normalize_time_stamp(struct ring_buffer *buffer,
 				      int cpu, u64 *ts);
 void ring_buffer_set_clock(struct ring_buffer *buffer,
 			   u64 (*clock)(void));
+void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs);
+bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer);
 
 size_t ring_buffer_page_len(void *page);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dcf1c4dd3efe..2a03e069bbc6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -488,6 +488,7 @@ struct ring_buffer {
 	u64				(*clock)(void);
 
 	struct rb_irq_work		irq_work;
+	bool				time_stamp_abs;
 };
 
 struct ring_buffer_iter {
@@ -1382,6 +1383,16 @@ void ring_buffer_set_clock(struct ring_buffer *buffer,
 	buffer->clock = clock;
 }
 
+void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs)
+{
+	buffer->time_stamp_abs = abs;
+}
+
+bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer)
+{
+	return buffer->time_stamp_abs;
+}
+
 static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
 
 static inline unsigned long rb_page_entries(struct buffer_page *bpage)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 20a2300ae4e8..cba003f0362e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2269,7 +2269,7 @@ trace_event_buffer_lock_reserve(struct ring_buffer **current_rb,
 
 	*current_rb = trace_file->tr->trace_buffer.buffer;
 
-	if ((trace_file->flags &
+	if (!ring_buffer_time_stamp_abs(*current_rb) && (trace_file->flags &
 	     (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
@@ -6282,6 +6282,37 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs)
+{
+	int ret = 0;
+
+	mutex_lock(&trace_types_lock);
+
+	if (abs && tr->time_stamp_abs_ref++)
+		goto out;
+
+	if (!abs) {
+		if (WARN_ON_ONCE(!tr->time_stamp_abs_ref)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (--tr->time_stamp_abs_ref)
+			goto out;
+	}
+
+	ring_buffer_set_time_stamp_abs(tr->trace_buffer.buffer, abs);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	if (tr->max_buffer.buffer)
+		ring_buffer_set_time_stamp_abs(tr->max_buffer.buffer, abs);
+#endif
+ out:
+	mutex_unlock(&trace_types_lock);
+
+	return ret;
+}
+
 struct ftrace_buffer_info {
 	struct trace_iterator	iter;
 	void			*spare;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2a6d0325a761..477341710ebf 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -273,6 +273,7 @@ struct trace_array {
 	/* function tracing enabled */
 	int			function_enabled;
 #endif
+	int			time_stamp_abs_ref;
 };
 
 enum {
@@ -286,6 +287,8 @@ extern struct mutex trace_types_lock;
 extern int trace_array_get(struct trace_array *tr);
 extern void trace_array_put(struct trace_array *tr);
 
+extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
-- 
2.15.1
