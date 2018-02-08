Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeBHBzG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 20:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbeBHBzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 20:55:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D79E21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 7 Feb 2018 20:55:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v9 35/37] tracing: Increase trace_recursive_lock() limit
 for synthetic events
Message-ID: <20180207205501.2b19c8d6@gandalf.local.home>
In-Reply-To: <827fcc7a6840db06d196fc18905033d519681eff.1516069914.git.tom.zanussi@linux.intel.com>
References: <cover.1516069914.git.tom.zanussi@linux.intel.com>
        <827fcc7a6840db06d196fc18905033d519681eff.1516069914.git.tom.zanussi@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/YzCWD_xeVSL2O3YQ1Z5sEc4"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/YzCWD_xeVSL2O3YQ1Z5sEc4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 15 Jan 2018 20:52:09 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

>  static __always_inline int
>  trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
>  {
> -	if (cpu_buffer->current_context >= 4)
> +	if (cpu_buffer->current_context >= 6)

I can't apply this patch because the new context counting broke tracing
suspend and resume because it depended on the context recursive locking.

Link: http://lkml.kernel.org/r/20180116020051.776011914@goodmis.org

I added the attached two patches which appear to do the job.

Let me know what you think.

-- Steve

--MP_/YzCWD_xeVSL2O3YQ1Z5sEc4
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-ring-buffer-Add-nesting-for-adding-events-within-eve.patch

>From f932ff1d98c482716b4b71a5d76b2aa3d65f66f0 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Wed, 7 Feb 2018 17:26:32 -0500
Subject: [PATCH] ring-buffer: Add nesting for adding events within events

The ring-buffer code has recusion protection in case tracing ends up tracing
itself, the ring-buffer will detect that it was called at the same context
(normal, softirq, interrupt or NMI), and not continue to record the event.

With the histogram synthetic events, they are called while tracing another
event at the same context. The recusion protection triggers because it
detects tracing at the same context and stops it.

Add ring_buffer_nest_start() and ring_buffer_nest_end() that will notify the
ring buffer that a trace is about to happen within another trace and that it
is intended, and not to trigger the recursion blocking.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  3 +++
 kernel/trace/ring_buffer.c  | 57 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index b37a5df05e81..467db0a7b82d 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -117,6 +117,9 @@ int ring_buffer_unlock_commit(struct ring_buffer *buffer,
 int ring_buffer_write(struct ring_buffer *buffer,
 		      unsigned long length, void *data);
 
+void ring_buffer_nest_start(struct ring_buffer *buffer);
+void ring_buffer_nest_end(struct ring_buffer *buffer);
+
 struct ring_buffer_event *
 ring_buffer_peek(struct ring_buffer *buffer, int cpu, u64 *ts,
 		 unsigned long *lost_events);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c4d6cbfd258..d09e453b6c52 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -477,6 +477,7 @@ struct ring_buffer_per_cpu {
 	struct buffer_page		*reader_page;
 	unsigned long			lost_events;
 	unsigned long			last_overrun;
+	unsigned long			nest;
 	local_t				entries_bytes;
 	local_t				entries;
 	local_t				overrun;
@@ -2624,10 +2625,10 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 		bit = pc & NMI_MASK ? RB_CTX_NMI :
 			pc & HARDIRQ_MASK ? RB_CTX_IRQ : RB_CTX_SOFTIRQ;
 
-	if (unlikely(val & (1 << bit)))
+	if (unlikely(val & (1 << (bit + cpu_buffer->nest))))
 		return 1;
 
-	val |= (1 << bit);
+	val |= (1 << (bit + cpu_buffer->nest));
 	cpu_buffer->current_context = val;
 
 	return 0;
@@ -2636,7 +2637,57 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 static __always_inline void
 trace_recursive_unlock(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	cpu_buffer->current_context &= cpu_buffer->current_context - 1;
+	cpu_buffer->current_context &=
+		cpu_buffer->current_context - (1 << cpu_buffer->nest);
+}
+
+/* The recursive locking above uses 4 bits */
+#define NESTED_BITS 4
+
+/**
+ * ring_buffer_nest_start - Allow to trace while nested
+ * @buffer: The ring buffer to modify
+ *
+ * The ring buffer has a safty mechanism to prevent recursion.
+ * But there may be a case where a trace needs to be done while
+ * tracing something else. In this case, calling this function
+ * will allow this function to nest within a currently active
+ * ring_buffer_lock_reserve().
+ *
+ * Call this function before calling another ring_buffer_lock_reserve() and
+ * call ring_buffer_nest_end() after the nested ring_buffer_unlock_commit().
+ */
+void ring_buffer_nest_start(struct ring_buffer *buffer)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	int cpu;
+
+	/* Enabled by ring_buffer_nest_end() */
+	preempt_disable_notrace();
+	cpu = raw_smp_processor_id();
+	cpu_buffer = buffer->buffers[cpu];
+	/* This is the shift value for the above recusive locking */
+	cpu_buffer->nest += NESTED_BITS;
+}
+
+/**
+ * ring_buffer_nest_end - Allow to trace while nested
+ * @buffer: The ring buffer to modify
+ *
+ * Must be called after ring_buffer_nest_start() and after the
+ * ring_buffer_unlock_commit().
+ */
+void ring_buffer_nest_end(struct ring_buffer *buffer)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	int cpu;
+
+	/* disabled by ring_buffer_nest_start() */
+	cpu = raw_smp_processor_id();
+	cpu_buffer = buffer->buffers[cpu];
+	/* This is the shift value for the above recusive locking */
+	cpu_buffer->nest -= NESTED_BITS;
+	preempt_enable_notrace();
 }
 
 /**
-- 
2.13.6


--MP_/YzCWD_xeVSL2O3YQ1Z5sEc4
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-tracing-Use-the-ring-buffer-nesting-to-allow-synthet.patch

>From 92c571543120ffed5e725f5b57b9de0b535e9d0a Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Wed, 7 Feb 2018 17:29:46 -0500
Subject: [PATCH] tracing: Use the ring-buffer nesting to allow synthetic
 events to be traced

Synthetic events can be done within the recording of other events. Notify
the ring buffer via ring_buffer_nest_start() and ring_buffer_nest_end() that
this is intended and not to block it due to its recursion protection.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fdd5c6438d12..b87ea7421f3d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -640,6 +640,7 @@ static notrace void trace_event_raw_event_synth(void *__data,
 	struct trace_event_file *trace_file = __data;
 	struct synth_trace_event *entry;
 	struct trace_event_buffer fbuffer;
+	struct ring_buffer *buffer;
 	struct synth_event *event;
 	unsigned int i, n_u64;
 	int fields_size = 0;
@@ -651,10 +652,17 @@ static notrace void trace_event_raw_event_synth(void *__data,
 
 	fields_size = event->n_u64 * sizeof(u64);
 
+	/*
+	 * Avoid ring buffer recursion detection, as this event
+	 * is being performed within another event.
+	 */
+	buffer = trace_file->tr->trace_buffer.buffer;
+	ring_buffer_nest_start(buffer);
+
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + fields_size);
 	if (!entry)
-		return;
+		goto out;
 
 	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
 		if (event->fields[i]->is_string) {
@@ -670,6 +678,8 @@ static notrace void trace_event_raw_event_synth(void *__data,
 	}
 
 	trace_event_buffer_commit(&fbuffer);
+out:
+	ring_buffer_nest_end(buffer);
 }
 
 static void free_synth_event_print_fmt(struct trace_event_call *call)
-- 
2.13.6


--MP_/YzCWD_xeVSL2O3YQ1Z5sEc4--
