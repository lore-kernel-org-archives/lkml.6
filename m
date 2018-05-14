Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754403AbeENPCW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:02:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37588 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbeENPCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:02:21 -0400
Date: Mon, 14 May 2018 17:02:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] perf/ring_buffer: ensure atomicity and order of updates
Message-ID: <20180514150213.GK12235@hirez.programming.kicks-ass.net>
References: <20180510130632.34497-1-mark.rutland@arm.com>
 <20180511105931.yyarmtz2gjkbuq2a@lakrids.cambridge.arm.com>
 <20180511162229.GK12217@hirez.programming.kicks-ass.net>
 <20180514110532.kihs5ilrs67kvq7e@lakrids.cambridge.arm.com>
 <20180514112815.GP12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514112815.GP12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 01:28:15PM +0200, Peter Zijlstra wrote:
> On Mon, May 14, 2018 at 12:05:33PM +0100, Mark Rutland wrote:

> > > Also note that in perf_output_put_handle(), where we write ->data_head,
> > > the store is from an 'unsigned long'. So on 32bit that will result in a
> > > zero high word. Similarly, in __perf_output_begin() we read ->data_tail
> > > into an unsigned long, which will discard the high word.
> > 
> > Ah, that's a fair point. So it's just compat userspace that this is
> > potentially borked for. ;)
> 
> Right.. #$$#@ compat. Hurmph.. not sure how to go about fixing that
> there.

How's this?

---
 include/linux/perf_event.h  | 12 ++++++++++++
 kernel/events/core.c        | 31 +++++++++++++++++++++++++++++--
 kernel/events/ring_buffer.c | 39 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e71e99eb9a4e..7834dfb6a83b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -517,6 +517,7 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
  */
 #define PERF_EV_CAP_SOFTWARE		BIT(0)
 #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
+#define PERF_EV_CAP_COMPAT		BIT(2)
 
 #define SWEVENT_HLIST_BITS		8
 #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
@@ -1220,6 +1221,11 @@ static inline bool is_write_backward(struct perf_event *event)
 	return !!event->attr.write_backward;
 }
 
+static inline bool is_compat_event(struct perf_event *event)
+{
+	return event->event_caps & PERF_EV_CAP_COMPAT;
+}
+
 static inline bool has_addr_filter(struct perf_event *event)
 {
 	return event->pmu->nr_addr_filters;
@@ -1249,6 +1255,12 @@ extern int perf_output_begin_forward(struct perf_output_handle *handle,
 extern int perf_output_begin_backward(struct perf_output_handle *handle,
 				      struct perf_event *event,
 				      unsigned int size);
+extern int perf_output_begin_forward_compat(struct perf_output_handle *handle,
+				    struct perf_event *event,
+				    unsigned int size);
+extern int perf_output_begin_backward_compat(struct perf_output_handle *handle,
+				      struct perf_event *event,
+				      unsigned int size);
 
 extern void perf_output_end(struct perf_output_handle *handle);
 extern unsigned int perf_output_copy(struct perf_output_handle *handle,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 67612ce359ad..0e60f35442a6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6523,6 +6523,22 @@ perf_event_output_backward(struct perf_event *event,
 	__perf_event_output(event, data, regs, perf_output_begin_backward);
 }
 
+void
+perf_event_output_forward_compat(struct perf_event *event,
+			 struct perf_sample_data *data,
+			 struct pt_regs *regs)
+{
+	__perf_event_output(event, data, regs, perf_output_begin_forward_compat);
+}
+
+void
+perf_event_output_backward_compat(struct perf_event *event,
+			   struct perf_sample_data *data,
+			   struct pt_regs *regs)
+{
+	__perf_event_output(event, data, regs, perf_output_begin_backward_compat);
+}
+
 void
 perf_event_output(struct perf_event *event,
 		  struct perf_sample_data *data,
@@ -10000,10 +10016,16 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		event->overflow_handler	= overflow_handler;
 		event->overflow_handler_context = context;
 	} else if (is_write_backward(event)){
-		event->overflow_handler = perf_event_output_backward;
+		if (is_compat_event(event))
+			event->overflow_handler = perf_event_output_backward_compat;
+		else
+			event->overflow_handler = perf_event_output_backward;
 		event->overflow_handler_context = NULL;
 	} else {
-		event->overflow_handler = perf_event_output_forward;
+		if (is_compat_event(event))
+			event->overflow_handler = perf_event_output_forward_compat;
+		else
+			event->overflow_handler = perf_event_output_forward;
 		event->overflow_handler_context = NULL;
 	}
 
@@ -10266,6 +10288,8 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 	if (is_write_backward(output_event) != is_write_backward(event))
 		goto out;
 
+	if (is_compat_event(output_event) != is_compat_event(event))
+		goto out;
 	/*
 	 * If both events generate aux data, they must be on the same PMU
 	 */
@@ -10499,6 +10523,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_cred;
 	}
 
+	if (in_compat_syscall())
+		event->event_caps |= PERF_EV_CAP_COMPAT;
+
 	if (is_sampling_event(event)) {
 		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
 			err = -EOPNOTSUPP;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 1d8ca9ea9979..8a8ca117e5de 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -85,7 +85,10 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
 	 * See perf_output_begin().
 	 */
 	smp_wmb(); /* B, matches C */
-	rb->user_page->data_head = head;
+	/*
+	 * 'unsigned long' to 'u64' promotion will zero the high word on 32 bit.
+	 */
+	WRITE_ONCE(rb->user_page->data_head, head);
 
 	/*
 	 * Now check if we missed an update -- rely on previous implied
@@ -117,7 +120,7 @@ ring_buffer_has_space(unsigned long head, unsigned long tail,
 static int __always_inline
 __perf_output_begin(struct perf_output_handle *handle,
 		    struct perf_event *event, unsigned int size,
-		    bool backward)
+		    bool backward, bool compat)
 {
 	struct ring_buffer *rb;
 	unsigned long tail, offset, head;
@@ -158,7 +161,13 @@ __perf_output_begin(struct perf_output_handle *handle,
 	perf_output_get_handle(handle);
 
 	do {
+		/*
+		 * 'u64' to 'unsigned long' demotion looses the high word on 32 bit.
+		 */
 		tail = READ_ONCE(rb->user_page->data_tail);
+		if (compat)
+			tail &= UINT_MAX;
+
 		offset = head = local_read(&rb->head);
 		if (!rb->overwrite) {
 			if (unlikely(!ring_buffer_has_space(head, tail,
@@ -183,6 +192,13 @@ __perf_output_begin(struct perf_output_handle *handle,
 			head += size;
 		else
 			head -= size;
+
+		/*
+		 * Ensure rb->head has the high word clear for compat; this
+		 * avoids having to muck with perf_output_put_handle().
+		 */
+		if (compat)
+			head &= UINT_MAX;
 	} while (local_cmpxchg(&rb->head, offset, head) != offset);
 
 	if (backward) {
@@ -234,13 +250,25 @@ __perf_output_begin(struct perf_output_handle *handle,
 int perf_output_begin_forward(struct perf_output_handle *handle,
 			     struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, event, size, false);
+	return __perf_output_begin(handle, event, size, false, false);
 }
 
 int perf_output_begin_backward(struct perf_output_handle *handle,
 			       struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, event, size, true);
+	return __perf_output_begin(handle, event, size, true, false);
+}
+
+int perf_output_begin_forward_compat(struct perf_output_handle *handle,
+			     struct perf_event *event, unsigned int size)
+{
+	return __perf_output_begin(handle, event, size, false, true);
+}
+
+int perf_output_begin_backward_compat(struct perf_output_handle *handle,
+			       struct perf_event *event, unsigned int size)
+{
+	return __perf_output_begin(handle, event, size, true, true);
 }
 
 int perf_output_begin(struct perf_output_handle *handle,
@@ -248,7 +276,8 @@ int perf_output_begin(struct perf_output_handle *handle,
 {
 
 	return __perf_output_begin(handle, event, size,
-				   unlikely(is_write_backward(event)));
+				   unlikely(is_write_backward(event)),
+				   unlikely(is_compat_event(event));
 }
 
 unsigned int perf_output_copy(struct perf_output_handle *handle,
