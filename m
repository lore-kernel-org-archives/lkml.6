Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeCUCaN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751601AbeCUCVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E010C2183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022123.846969384@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:20:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 06/46] ring-buffer: Redefine the unimplemented RINGBUF_TYPE_TIME_STAMP
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0006-ring-buffer-Redefine-the-unimplemented-RINGBUF_TYPE_.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

RINGBUF_TYPE_TIME_STAMP is defined but not used, and from what I can
gather was reserved for something like an absolute timestamp feature
for the ring buffer, if not a complete replacement of the current
time_delta scheme.

This code redefines RINGBUF_TYPE_TIME_STAMP to implement absolute time
stamps.  Another way to look at it is that it essentially forces
extended time_deltas for all events.

The motivation for doing this is to enable time_deltas that aren't
dependent on previous events in the ring buffer, making it feasible to
use the ring_buffer_event timetamps in a more random-access way, for
purposes other than serial event printing.

To set/reset this mode, use tracing_set_timestamp_abs() from the
previous interface patch.

Link: http://lkml.kernel.org/r/477b362dba1ce7fab9889a1a8e885a62c472f041.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  12 ++---
 kernel/trace/ring_buffer.c  | 104 ++++++++++++++++++++++++++++++++------------
 2 files changed, 83 insertions(+), 33 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 025159e17e1b..7cb84774c20d 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -34,10 +34,12 @@ struct ring_buffer_event {
  *				 array[0] = time delta (28 .. 59)
  *				 size = 8 bytes
  *
- * @RINGBUF_TYPE_TIME_STAMP:	Sync time stamp with external clock
- *				 array[0]    = tv_nsec
- *				 array[1..2] = tv_sec
- *				 size = 16 bytes
+ * @RINGBUF_TYPE_TIME_STAMP:	Absolute timestamp
+ *				 Same format as TIME_EXTEND except that the
+ *				 value is an absolute timestamp, not a delta
+ *				 event.time_delta contains bottom 27 bits
+ *				 array[0] = top (28 .. 59) bits
+ *				 size = 8 bytes
  *
  * <= @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
  *				Data record
@@ -54,12 +56,12 @@ enum ring_buffer_type {
 	RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
 	RINGBUF_TYPE_PADDING,
 	RINGBUF_TYPE_TIME_EXTEND,
-	/* FIXME: RINGBUF_TYPE_TIME_STAMP not implemented */
 	RINGBUF_TYPE_TIME_STAMP,
 };
 
 unsigned ring_buffer_event_length(struct ring_buffer_event *event);
 void *ring_buffer_event_data(struct ring_buffer_event *event);
+u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event);
 
 /*
  * ring_buffer_discard_commit will remove an event that has not
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2a03e069bbc6..33073cdebb26 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -41,6 +41,8 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
 			 RINGBUF_TYPE_PADDING);
 	trace_seq_printf(s, "\ttime_extend : type == %d\n",
 			 RINGBUF_TYPE_TIME_EXTEND);
+	trace_seq_printf(s, "\ttime_stamp : type == %d\n",
+			 RINGBUF_TYPE_TIME_STAMP);
 	trace_seq_printf(s, "\tdata max type_len  == %d\n",
 			 RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
 
@@ -140,12 +142,15 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
 
 enum {
 	RB_LEN_TIME_EXTEND = 8,
-	RB_LEN_TIME_STAMP = 16,
+	RB_LEN_TIME_STAMP =  8,
 };
 
 #define skip_time_extend(event) \
 	((struct ring_buffer_event *)((char *)event + RB_LEN_TIME_EXTEND))
 
+#define extended_time(event) \
+	(event->type_len >= RINGBUF_TYPE_TIME_EXTEND)
+
 static inline int rb_null_event(struct ring_buffer_event *event)
 {
 	return event->type_len == RINGBUF_TYPE_PADDING && !event->time_delta;
@@ -209,7 +214,7 @@ rb_event_ts_length(struct ring_buffer_event *event)
 {
 	unsigned len = 0;
 
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND) {
+	if (extended_time(event)) {
 		/* time extends include the data event after it */
 		len = RB_LEN_TIME_EXTEND;
 		event = skip_time_extend(event);
@@ -231,7 +236,7 @@ unsigned ring_buffer_event_length(struct ring_buffer_event *event)
 {
 	unsigned length;
 
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (extended_time(event))
 		event = skip_time_extend(event);
 
 	length = rb_event_length(event);
@@ -248,7 +253,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_length);
 static __always_inline void *
 rb_event_data(struct ring_buffer_event *event)
 {
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (extended_time(event))
 		event = skip_time_extend(event);
 	BUG_ON(event->type_len > RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
 	/* If length is in len field, then array[0] has the data */
@@ -275,6 +280,27 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
 #define TS_MASK		((1ULL << TS_SHIFT) - 1)
 #define TS_DELTA_TEST	(~TS_MASK)
 
+/**
+ * ring_buffer_event_time_stamp - return the event's extended timestamp
+ * @event: the event to get the timestamp of
+ *
+ * Returns the extended timestamp associated with a data event.
+ * An extended time_stamp is a 64-bit timestamp represented
+ * internally in a special way that makes the best use of space
+ * contained within a ring buffer event.  This function decodes
+ * it and maps it to a straight u64 value.
+ */
+u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event)
+{
+	u64 ts;
+
+	ts = event->array[0];
+	ts <<= TS_SHIFT;
+	ts += event->time_delta;
+
+	return ts;
+}
+
 /* Flag when events were overwritten */
 #define RB_MISSED_EVENTS	(1 << 31)
 /* Missed count stored at end */
@@ -2217,12 +2243,15 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 
 /* Slow path, do not inline */
 static noinline struct ring_buffer_event *
-rb_add_time_stamp(struct ring_buffer_event *event, u64 delta)
+rb_add_time_stamp(struct ring_buffer_event *event, u64 delta, bool abs)
 {
-	event->type_len = RINGBUF_TYPE_TIME_EXTEND;
+	if (abs)
+		event->type_len = RINGBUF_TYPE_TIME_STAMP;
+	else
+		event->type_len = RINGBUF_TYPE_TIME_EXTEND;
 
-	/* Not the first event on the page? */
-	if (rb_event_index(event)) {
+	/* Not the first event on the page, or not delta? */
+	if (abs || rb_event_index(event)) {
 		event->time_delta = delta & TS_MASK;
 		event->array[0] = delta >> TS_SHIFT;
 	} else {
@@ -2265,7 +2294,9 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 	 * add it to the start of the resevered space.
 	 */
 	if (unlikely(info->add_timestamp)) {
-		event = rb_add_time_stamp(event, delta);
+		bool abs = ring_buffer_time_stamp_abs(cpu_buffer->buffer);
+
+		event = rb_add_time_stamp(event, info->delta, abs);
 		length -= RB_LEN_TIME_EXTEND;
 		delta = 0;
 	}
@@ -2453,7 +2484,7 @@ static __always_inline void rb_end_commit(struct ring_buffer_per_cpu *cpu_buffer
 
 static inline void rb_event_discard(struct ring_buffer_event *event)
 {
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (extended_time(event))
 		event = skip_time_extend(event);
 
 	/* array[0] holds the actual length for the discarded event */
@@ -2497,10 +2528,11 @@ rb_update_write_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 			cpu_buffer->write_stamp =
 				cpu_buffer->commit_page->page->time_stamp;
 		else if (event->type_len == RINGBUF_TYPE_TIME_EXTEND) {
-			delta = event->array[0];
-			delta <<= TS_SHIFT;
-			delta += event->time_delta;
+			delta = ring_buffer_event_time_stamp(event);
 			cpu_buffer->write_stamp += delta;
+		} else if (event->type_len == RINGBUF_TYPE_TIME_STAMP) {
+			delta = ring_buffer_event_time_stamp(event);
+			cpu_buffer->write_stamp = delta;
 		} else
 			cpu_buffer->write_stamp += event->time_delta;
 	}
@@ -2680,7 +2712,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	 * If this is the first commit on the page, then it has the same
 	 * timestamp as the page itself.
 	 */
-	if (!tail)
+	if (!tail && !ring_buffer_time_stamp_abs(cpu_buffer->buffer))
 		info->delta = 0;
 
 	/* See if we shot pass the end of this buffer page */
@@ -2757,8 +2789,11 @@ rb_reserve_next_event(struct ring_buffer *buffer,
 	/* make sure this diff is calculated here */
 	barrier();
 
-	/* Did the write stamp get updated already? */
-	if (likely(info.ts >= cpu_buffer->write_stamp)) {
+	if (ring_buffer_time_stamp_abs(buffer)) {
+		info.delta = info.ts;
+		rb_handle_timestamp(cpu_buffer, &info);
+	} else /* Did the write stamp get updated already? */
+		if (likely(info.ts >= cpu_buffer->write_stamp)) {
 		info.delta = diff;
 		if (unlikely(test_time_stamp(info.delta)))
 			rb_handle_timestamp(cpu_buffer, &info);
@@ -3440,14 +3475,13 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
-		delta = event->array[0];
-		delta <<= TS_SHIFT;
-		delta += event->time_delta;
+		delta = ring_buffer_event_time_stamp(event);
 		cpu_buffer->read_stamp += delta;
 		return;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		delta = ring_buffer_event_time_stamp(event);
+		cpu_buffer->read_stamp = delta;
 		return;
 
 	case RINGBUF_TYPE_DATA:
@@ -3471,14 +3505,13 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 		return;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
-		delta = event->array[0];
-		delta <<= TS_SHIFT;
-		delta += event->time_delta;
+		delta = ring_buffer_event_time_stamp(event);
 		iter->read_stamp += delta;
 		return;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		delta = ring_buffer_event_time_stamp(event);
+		iter->read_stamp = delta;
 		return;
 
 	case RINGBUF_TYPE_DATA:
@@ -3702,6 +3735,8 @@ rb_buffer_peek(struct ring_buffer_per_cpu *cpu_buffer, u64 *ts,
 	struct buffer_page *reader;
 	int nr_loops = 0;
 
+	if (ts)
+		*ts = 0;
  again:
 	/*
 	 * We repeat when a time extend is encountered.
@@ -3738,12 +3773,17 @@ rb_buffer_peek(struct ring_buffer_per_cpu *cpu_buffer, u64 *ts,
 		goto again;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		if (ts) {
+			*ts = ring_buffer_event_time_stamp(event);
+			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
+							 cpu_buffer->cpu, ts);
+		}
+		/* Internal data, OK to advance */
 		rb_advance_reader(cpu_buffer);
 		goto again;
 
 	case RINGBUF_TYPE_DATA:
-		if (ts) {
+		if (ts && !(*ts)) {
 			*ts = cpu_buffer->read_stamp + event->time_delta;
 			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
 							 cpu_buffer->cpu, ts);
@@ -3768,6 +3808,9 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct ring_buffer_event *event;
 	int nr_loops = 0;
 
+	if (ts)
+		*ts = 0;
+
 	cpu_buffer = iter->cpu_buffer;
 	buffer = cpu_buffer->buffer;
 
@@ -3820,12 +3863,17 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 		goto again;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		if (ts) {
+			*ts = ring_buffer_event_time_stamp(event);
+			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
+							 cpu_buffer->cpu, ts);
+		}
+		/* Internal data, OK to advance */
 		rb_advance_iter(iter);
 		goto again;
 
 	case RINGBUF_TYPE_DATA:
-		if (ts) {
+		if (ts && !(*ts)) {
 			*ts = iter->read_stamp + event->time_delta;
 			ring_buffer_normalize_time_stamp(buffer,
 							 cpu_buffer->cpu, ts);
-- 
2.15.1
