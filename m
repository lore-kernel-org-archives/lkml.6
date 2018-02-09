Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeBIXNB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:13:01 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:35266 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeBIXM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:12:59 -0500
Date: Sat, 10 Feb 2018 00:12:56 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.14.18-rt15
Message-ID: <20180209231256.xv7wmzypkrrms7s4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.14.18-rt15 patch set. 

Changes since v4.14.18-rt14:

  - Remove unused mutex brd_mutex, it was causing a "defined but not
    used warning". Reported by Dan Murphy, patch by Mikulas Patocka.

  - Update the "tracing: Inter-event (e.g. latency) support" patch to
    what was merged in the end. The significant change is probably the
    inclusion of commit a0e3a18f4baf ("ring-buffer: Bring back context
    level recursive checks").

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.14.18-rt14 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.18-rt14-rt15.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.18-rt15

The RT patch against v4.14.18 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.18-rt15.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.18-rt15.tar.xz

Sebastian

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 2d7178f7754e..c1cf87718c2e 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -60,7 +60,6 @@ struct brd_device {
 /*
  * Look up and return a brd's page for a given sector.
  */
-static DEFINE_MUTEX(brd_mutex);
 static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 47f9791971a4..ea8c1dd830f7 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -120,6 +120,9 @@ int ring_buffer_unlock_commit(struct ring_buffer *buffer,
 int ring_buffer_write(struct ring_buffer *buffer,
 		      unsigned long length, void *data);
 
+void ring_buffer_nest_start(struct ring_buffer *buffer);
+void ring_buffer_nest_end(struct ring_buffer *buffer);
+
 struct ring_buffer_event *
 ring_buffer_peek(struct ring_buffer *buffer, int cpu, u64 *ts,
 		 unsigned long *lost_events);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c4d554286334..76fe2d01d801 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -478,6 +478,7 @@ struct ring_buffer_per_cpu {
 	struct buffer_page		*reader_page;
 	unsigned long			lost_events;
 	unsigned long			last_overrun;
+	unsigned long			nest;
 	local_t				entries_bytes;
 	local_t				entries;
 	local_t				overrun;
@@ -2585,29 +2586,58 @@ rb_wakeups(struct ring_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
  * The lock and unlock are done within a preempt disable section.
  * The current_context per_cpu variable can only be modified
  * by the current task between lock and unlock. But it can
- * be modified more than once via an interrupt. There are four
- * different contexts that we need to consider.
+ * be modified more than once via an interrupt. To pass this
+ * information from the lock to the unlock without having to
+ * access the 'in_interrupt()' functions again (which do show
+ * a bit of overhead in something as critical as function tracing,
+ * we use a bitmask trick.
  *
- *  Normal context.
- *  SoftIRQ context
- *  IRQ context
- *  NMI context
+ *  bit 0 =  NMI context
+ *  bit 1 =  IRQ context
+ *  bit 2 =  SoftIRQ context
+ *  bit 3 =  normal context.
  *
- * If for some reason the ring buffer starts to recurse, we only allow
- * that to happen at most 6 times (one for each context, plus possibly
- * two levels of synthetic event generation). If it happens 7 times,
- * then we consider this a recusive loop and do not let it go further.
+ * This works because this is the order of contexts that can
+ * preempt other contexts. A SoftIRQ never preempts an IRQ
+ * context.
+ *
+ * When the context is determined, the corresponding bit is
+ * checked and set (if it was set, then a recursion of that context
+ * happened).
+ *
+ * On unlock, we need to clear this bit. To do so, just subtract
+ * 1 from the current_context and AND it to itself.
+ *
+ * (binary)
+ *  101 - 1 = 100
+ *  101 & 100 = 100 (clearing bit zero)
+ *
+ *  1010 - 1 = 1001
+ *  1010 & 1001 = 1000 (clearing bit 1)
+ *
+ * The least significant bit can be cleared this way, and it
+ * just so happens that it is the same bit corresponding to
+ * the current context.
  */
 
 static __always_inline int
 trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	if (cpu_buffer->current_context >= 6)
+	unsigned int val = cpu_buffer->current_context;
+	unsigned long pc = preempt_count();
+	int bit;
+
+	if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
+		bit = RB_CTX_NORMAL;
+	else
+		bit = pc & NMI_MASK ? RB_CTX_NMI :
+			pc & HARDIRQ_MASK ? RB_CTX_IRQ : RB_CTX_SOFTIRQ;
+
+	if (unlikely(val & (1 << (bit + cpu_buffer->nest))))
 		return 1;
 
-	cpu_buffer->current_context++;
-	/* Interrupts must see this update */
-	barrier();
+	val |= (1 << (bit + cpu_buffer->nest));
+	cpu_buffer->current_context = val;
 
 	return 0;
 }
@@ -2615,9 +2645,57 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 static __always_inline void
 trace_recursive_unlock(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	/* Don't let the dec leak out */
-	barrier();
-	cpu_buffer->current_context--;
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
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e47b56632367..49afef3cc384 100644
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
diff --git a/localversion-rt b/localversion-rt
index 08b3e75841ad..18777ec0c27d 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt14
+-rt15
