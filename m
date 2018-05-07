Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeEGUmV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:42:21 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34499 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeEGUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:42:04 -0400
X-Google-Smtp-Source: AB8JxZqXS3VQcRdWNN3C93AA+6s7C2oq6l8TG9ZGCPFOuOdg3HGengf1djM2T4LBogS2jrEWb7FoJw==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: [PATCH RFC v6 5/5] tracing: Centralize preemptirq tracepoints and unify their usage
Date: Mon,  7 May 2018 13:41:43 -0700
Message-Id: <20180507204143.13061-6-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180507204143.13061-1-joelaf@google.com>
References: <20180507204143.13061-1-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This patch detaches the preemptirq tracepoints from the tracers and
keeps it separate.

Advantages:
* Lockdep and irqsoff event can now run in parallel since they no longer
have their own calls.

* This unifies the usecase of adding hooks to an irqsoff and irqson
event, and a preemptoff and preempton event.
  3 users of the events exist:
  - Lockdep
  - irqsoff and preemptoff tracers
  - irqs and preempt trace events

The unification cleans up several ifdefs and makes the code in preempt
tracer and irqsoff tracers simpler. It gets rid of all the horrific
ifdeferry around PROVE_LOCKING and makes configuration of the different
users of the tracepoints more easy and understandable. It also gets rid
of the time_* function calls from the lockdep hooks used to call into
the preemptirq tracer which is not needed anymore. The negative delta in
lines of code in this patch is quite large too.

In the patch we introduce a new CONFIG option PREEMPTIRQ_TRACEPOINTS
as a single point for registering probes onto the tracepoints. With
this,
the web of config options for preempt/irq toggle tracepoints and its
users becomes:

 PREEMPT_TRACER   PREEMPTIRQ_EVENTS  IRQSOFF_TRACER PROVE_LOCKING
       |                 |     \         |           |
       \    (selects)    /      \        \ (selects) /
      TRACE_PREEMPT_TOGGLE       ----> TRACE_IRQFLAGS
                      \                  /
                       \ (depends on)   /
                     PREEMPTIRQ_TRACEPOINTS

One note, I have to check for lockdep recursion in the code that calls
the trace events API and bail out if we're in lockdep recursion
protection to prevent something like the following case: a spin_lock is
taken. Then lockdep_acquired is called.  That does a raw_local_irq_save
and then sets lockdep_recursion, and then calls __lockdep_acquired. In
this function, a call to get_lock_stats happens which calls
preempt_disable, which calls trace IRQS off somewhere which enters my
tracepoint code and sets the tracing_irq_cpu flag to prevent recursion.
This flag is then never cleared causing lockdep paths to never be
entered and thus causing splats and other bad things.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zilstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Glexiner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Fenguang Wu <fengguang.wu@intel.com>
Cc: Baohong Liu <baohong.liu@intel.com>
Cc: Vedang Patel <vedang.patel@intel.com>
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/ftrace.h            |  11 +-
 include/linux/irqflags.h          |  11 +-
 include/linux/lockdep.h           |   8 +-
 include/linux/preempt.h           |   2 +-
 include/trace/events/preemptirq.h |  23 ++--
 init/main.c                       |   5 +-
 kernel/locking/lockdep.c          |  35 ++---
 kernel/sched/core.c               |   2 +-
 kernel/trace/Kconfig              |  22 ++-
 kernel/trace/Makefile             |   2 +-
 kernel/trace/trace_irqsoff.c      | 213 ++++++++----------------------
 kernel/trace/trace_preemptirq.c   |  71 ++++++++++
 12 files changed, 189 insertions(+), 216 deletions(-)
 create mode 100644 kernel/trace/trace_preemptirq.c

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9c3c9a319e48..5191030af0c0 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -709,16 +709,7 @@ static inline unsigned long get_lock_parent_ip(void)
 	return CALLER_ADDR2;
 }
 
-#ifdef CONFIG_IRQSOFF_TRACER
-  extern void time_hardirqs_on(unsigned long a0, unsigned long a1);
-  extern void time_hardirqs_off(unsigned long a0, unsigned long a1);
-#else
-  static inline void time_hardirqs_on(unsigned long a0, unsigned long a1) { }
-  static inline void time_hardirqs_off(unsigned long a0, unsigned long a1) { }
-#endif
-
-#if defined(CONFIG_PREEMPT_TRACER) || \
-	(defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_PREEMPTIRQ_EVENTS))
+#ifdef CONFIG_TRACE_PREEMPT_TOGGLE
   extern void trace_preempt_on(unsigned long a0, unsigned long a1);
   extern void trace_preempt_off(unsigned long a0, unsigned long a1);
 #else
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 9700f00bbc04..50edb9cbbd26 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -15,9 +15,16 @@
 #include <linux/typecheck.h>
 #include <asm/irqflags.h>
 
-#ifdef CONFIG_TRACE_IRQFLAGS
+/* Currently trace_softirqs_on/off is used only by lockdep */
+#ifdef CONFIG_PROVE_LOCKING
   extern void trace_softirqs_on(unsigned long ip);
   extern void trace_softirqs_off(unsigned long ip);
+#else
+# define trace_softirqs_on(ip)	do { } while (0)
+# define trace_softirqs_off(ip)	do { } while (0)
+#endif
+
+#ifdef CONFIG_TRACE_IRQFLAGS
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
 # define trace_hardirq_context(p)	((p)->hardirq_context)
@@ -43,8 +50,6 @@ do {						\
 #else
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
-# define trace_softirqs_on(ip)		do { } while (0)
-# define trace_softirqs_off(ip)		do { } while (0)
 # define trace_hardirq_context(p)	0
 # define trace_softirq_context(p)	0
 # define trace_hardirqs_enabled(p)	0
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6fc77d4dbdcd..a8113357ceeb 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -266,7 +266,8 @@ struct held_lock {
 /*
  * Initialization, self-test and debugging-output methods:
  */
-extern void lockdep_info(void);
+extern void lockdep_init(void);
+extern void lockdep_init_early(void);
 extern void lockdep_reset(void);
 extern void lockdep_reset_lock(struct lockdep_map *lock);
 extern void lockdep_free_key_range(void *start, unsigned long size);
@@ -406,7 +407,8 @@ static inline void lockdep_on(void)
 # define lock_downgrade(l, i)			do { } while (0)
 # define lock_set_class(l, n, k, s, i)		do { } while (0)
 # define lock_set_subclass(l, s, i)		do { } while (0)
-# define lockdep_info()				do { } while (0)
+# define lockdep_init()				do { } while (0)
+# define lockdep_init_early()			do { } while (0)
 # define lockdep_init_map(lock, name, key, sub) \
 		do { (void)(name); (void)(key); } while (0)
 # define lockdep_set_class(lock, key)		do { (void)(key); } while (0)
@@ -532,7 +534,7 @@ do {								\
 
 #endif /* CONFIG_LOCKDEP */
 
-#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_PROVE_LOCKING
 extern void print_irqtrace_events(struct task_struct *curr);
 #else
 static inline void print_irqtrace_events(struct task_struct *curr)
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 5bd3f151da78..c01813c3fbe9 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -150,7 +150,7 @@
  */
 #define in_atomic_preempt_off() (preempt_count() != PREEMPT_DISABLE_OFFSET)
 
-#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_PREEMPT_TRACER)
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
 extern void preempt_count_add(int val);
 extern void preempt_count_sub(int val);
 #define preempt_count_dec_and_test() \
diff --git a/include/trace/events/preemptirq.h b/include/trace/events/preemptirq.h
index 9c4eb33c5a1d..9a0d4ceeb166 100644
--- a/include/trace/events/preemptirq.h
+++ b/include/trace/events/preemptirq.h
@@ -1,4 +1,4 @@
-#ifdef CONFIG_PREEMPTIRQ_EVENTS
+#ifdef CONFIG_PREEMPTIRQ_TRACEPOINTS
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM preemptirq
@@ -32,7 +32,7 @@ DECLARE_EVENT_CLASS(preemptirq_template,
 		  (void *)((unsigned long)(_stext) + __entry->parent_offs))
 );
 
-#ifndef CONFIG_PROVE_LOCKING
+#ifdef CONFIG_TRACE_IRQFLAGS
 DEFINE_EVENT(preemptirq_template, irq_disable,
 	     TP_PROTO(unsigned long ip, unsigned long parent_ip),
 	     TP_ARGS(ip, parent_ip));
@@ -40,9 +40,14 @@ DEFINE_EVENT(preemptirq_template, irq_disable,
 DEFINE_EVENT(preemptirq_template, irq_enable,
 	     TP_PROTO(unsigned long ip, unsigned long parent_ip),
 	     TP_ARGS(ip, parent_ip));
+#else
+#define trace_irq_enable(...)
+#define trace_irq_disable(...)
+#define trace_irq_enable_rcuidle(...)
+#define trace_irq_disable_rcuidle(...)
 #endif
 
-#ifdef CONFIG_DEBUG_PREEMPT
+#ifdef CONFIG_TRACE_PREEMPT_TOGGLE
 DEFINE_EVENT(preemptirq_template, preempt_disable,
 	     TP_PROTO(unsigned long ip, unsigned long parent_ip),
 	     TP_ARGS(ip, parent_ip));
@@ -50,22 +55,22 @@ DEFINE_EVENT(preemptirq_template, preempt_disable,
 DEFINE_EVENT(preemptirq_template, preempt_enable,
 	     TP_PROTO(unsigned long ip, unsigned long parent_ip),
 	     TP_ARGS(ip, parent_ip));
+#else
+#define trace_preempt_enable(...)
+#define trace_preempt_disable(...)
+#define trace_preempt_enable_rcuidle(...)
+#define trace_preempt_disable_rcuidle(...)
 #endif
 
 #endif /* _TRACE_PREEMPTIRQ_H */
 
 #include <trace/define_trace.h>
 
-#endif /* !CONFIG_PREEMPTIRQ_EVENTS */
-
-#if !defined(CONFIG_PREEMPTIRQ_EVENTS) || defined(CONFIG_PROVE_LOCKING)
+#else /* !CONFIG_PREEMPTIRQ_TRACEPOINTS */
 #define trace_irq_enable(...)
 #define trace_irq_disable(...)
 #define trace_irq_enable_rcuidle(...)
 #define trace_irq_disable_rcuidle(...)
-#endif
-
-#if !defined(CONFIG_PREEMPTIRQ_EVENTS) || !defined(CONFIG_DEBUG_PREEMPT)
 #define trace_preempt_enable(...)
 #define trace_preempt_disable(...)
 #define trace_preempt_enable_rcuidle(...)
diff --git a/init/main.c b/init/main.c
index 21efbf6ace93..37f23ed10666 100644
--- a/init/main.c
+++ b/init/main.c
@@ -630,6 +630,9 @@ asmlinkage __visible void __init start_kernel(void)
 	call_function_init();
 	WARN(!irqs_disabled(), "Interrupts were enabled early\n");
 	early_boot_irqs_disabled = false;
+
+	lockdep_init_early();
+
 	local_irq_enable();
 
 	kmem_cache_init_late();
@@ -644,7 +647,7 @@ asmlinkage __visible void __init start_kernel(void)
 		panic("Too many boot %s vars at `%s'", panic_later,
 		      panic_param);
 
-	lockdep_info();
+	lockdep_init();
 
 	/*
 	 * Need to run this when irqs are enabled, because it wants
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 89b5f83f1969..1e79cf7293ef 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -55,6 +55,7 @@
 
 #include "lockdep_internals.h"
 
+#include <trace/events/preemptirq.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/lock.h>
 
@@ -2841,10 +2842,9 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	debug_atomic_inc(hardirqs_on_events);
 }
 
-__visible void trace_hardirqs_on_caller(unsigned long ip)
+static void lockdep_hardirqs_on(void *none, unsigned long ignore,
+				unsigned long ip)
 {
-	time_hardirqs_on(CALLER_ADDR0, ip);
-
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
@@ -2883,23 +2883,15 @@ __visible void trace_hardirqs_on_caller(unsigned long ip)
 	__trace_hardirqs_on_caller(ip);
 	current->lockdep_recursion = 0;
 }
-EXPORT_SYMBOL(trace_hardirqs_on_caller);
-
-void trace_hardirqs_on(void)
-{
-	trace_hardirqs_on_caller(CALLER_ADDR0);
-}
-EXPORT_SYMBOL(trace_hardirqs_on);
 
 /*
  * Hardirqs were disabled:
  */
-__visible void trace_hardirqs_off_caller(unsigned long ip)
+static void lockdep_hardirqs_off(void *none, unsigned long ignore,
+				 unsigned long ip)
 {
 	struct task_struct *curr = current;
 
-	time_hardirqs_off(CALLER_ADDR0, ip);
-
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
@@ -2921,13 +2913,6 @@ __visible void trace_hardirqs_off_caller(unsigned long ip)
 	} else
 		debug_atomic_inc(redundant_hardirqs_off);
 }
-EXPORT_SYMBOL(trace_hardirqs_off_caller);
-
-void trace_hardirqs_off(void)
-{
-	trace_hardirqs_off_caller(CALLER_ADDR0);
-}
-EXPORT_SYMBOL(trace_hardirqs_off);
 
 /*
  * Softirqs will be enabled:
@@ -4334,7 +4319,15 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 	raw_local_irq_restore(flags);
 }
 
-void __init lockdep_info(void)
+void __init lockdep_init_early(void)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	register_trace_prio_irq_disable(lockdep_hardirqs_off, NULL, INT_MAX);
+	register_trace_prio_irq_enable(lockdep_hardirqs_on, NULL, INT_MIN);
+#endif
+}
+
+void __init lockdep_init(void)
 {
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c94895bc5a2c..417c40c0eeef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3128,7 +3128,7 @@ u64 scheduler_tick_max_deferment(void)
 #endif
 
 #if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
-				defined(CONFIG_PREEMPT_TRACER))
+				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
 /*
  * If the value passed in is equal to the current preempt count
  * then we just disabled preemption. Start timing the latency.
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0b249e2f0c3c..af027233b762 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -82,6 +82,15 @@ config RING_BUFFER_ALLOW_SWAP
 	 Allow the use of ring_buffer_swap_cpu.
 	 Adds a very slight overhead to tracing when enabled.
 
+config PREEMPTIRQ_TRACEPOINTS
+	bool
+	depends on TRACE_PREEMPT_TOGGLE || TRACE_IRQFLAGS
+	select TRACING
+	default y
+	help
+	  Create preempt/irq toggle tracepoints if needed, so that other parts
+	  of the kernel can use them to generate or add hooks to them.
+
 # All tracer options should select GENERIC_TRACER. For those options that are
 # enabled by all tracers (context switch and event tracer) they select TRACING.
 # This allows those options to appear when no other tracer is selected. But the
@@ -159,18 +168,20 @@ config FUNCTION_GRAPH_TRACER
 	  the return value. This is done by setting the current return
 	  address on the current task structure into a stack of calls.
 
+config TRACE_PREEMPT_TOGGLE
+	bool
+	help
+	  Enables hooks which will be called when preemption is first disabled,
+	  and last enabled.
 
 config PREEMPTIRQ_EVENTS
 	bool "Enable trace events for preempt and irq disable/enable"
 	select TRACE_IRQFLAGS
-	depends on DEBUG_PREEMPT || !PROVE_LOCKING
-	depends on TRACING
+	select TRACE_PREEMPT_TOGGLE if PREEMPT
+	select GENERIC_TRACER
 	default n
 	help
 	  Enable tracing of disable and enable events for preemption and irqs.
-	  For tracing preempt disable/enable events, DEBUG_PREEMPT must be
-	  enabled. For tracing irq disable/enable events, PROVE_LOCKING must
-	  be disabled.
 
 config IRQSOFF_TRACER
 	bool "Interrupts-off Latency Tracer"
@@ -207,6 +218,7 @@ config PREEMPT_TRACER
 	select RING_BUFFER_ALLOW_SWAP
 	select TRACER_SNAPSHOT
 	select TRACER_SNAPSHOT_PER_CPU_SWAP
+	select TRACE_PREEMPT_TOGGLE
 	help
 	  This option measures the time spent in preemption-off critical
 	  sections, with microsecond accuracy.
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index e2538c7638d4..84a0cb222f20 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_TRACING) += trace_printk.o
 obj-$(CONFIG_TRACING_MAP) += tracing_map.o
 obj-$(CONFIG_CONTEXT_SWITCH_TRACER) += trace_sched_switch.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
-obj-$(CONFIG_PREEMPTIRQ_EVENTS) += trace_irqsoff.o
+obj-$(CONFIG_PREEMPTIRQ_TRACEPOINTS) += trace_preemptirq.o
 obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_PREEMPT_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_SCHED_TRACER) += trace_sched_wakeup.o
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index f8daa754cce2..d2d8284088f0 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -16,7 +16,6 @@
 
 #include "trace.h"
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/preemptirq.h>
 
 #if defined(CONFIG_IRQSOFF_TRACER) || defined(CONFIG_PREEMPT_TRACER)
@@ -450,66 +449,6 @@ void stop_critical_timings(void)
 }
 EXPORT_SYMBOL_GPL(stop_critical_timings);
 
-#ifdef CONFIG_IRQSOFF_TRACER
-#ifdef CONFIG_PROVE_LOCKING
-void time_hardirqs_on(unsigned long a0, unsigned long a1)
-{
-	if (!preempt_trace() && irq_trace())
-		stop_critical_timing(a0, a1);
-}
-
-void time_hardirqs_off(unsigned long a0, unsigned long a1)
-{
-	if (!preempt_trace() && irq_trace())
-		start_critical_timing(a0, a1);
-}
-
-#else /* !CONFIG_PROVE_LOCKING */
-
-/*
- * We are only interested in hardirq on/off events:
- */
-static inline void tracer_hardirqs_on(void)
-{
-	if (!preempt_trace() && irq_trace())
-		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-}
-
-static inline void tracer_hardirqs_off(void)
-{
-	if (!preempt_trace() && irq_trace())
-		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-}
-
-static inline void tracer_hardirqs_on_caller(unsigned long caller_addr)
-{
-	if (!preempt_trace() && irq_trace())
-		stop_critical_timing(CALLER_ADDR0, caller_addr);
-}
-
-static inline void tracer_hardirqs_off_caller(unsigned long caller_addr)
-{
-	if (!preempt_trace() && irq_trace())
-		start_critical_timing(CALLER_ADDR0, caller_addr);
-}
-
-#endif /* CONFIG_PROVE_LOCKING */
-#endif /*  CONFIG_IRQSOFF_TRACER */
-
-#ifdef CONFIG_PREEMPT_TRACER
-static inline void tracer_preempt_on(unsigned long a0, unsigned long a1)
-{
-	if (preempt_trace() && !irq_trace())
-		stop_critical_timing(a0, a1);
-}
-
-static inline void tracer_preempt_off(unsigned long a0, unsigned long a1)
-{
-	if (preempt_trace() && !irq_trace())
-		start_critical_timing(a0, a1);
-}
-#endif /* CONFIG_PREEMPT_TRACER */
-
 #ifdef CONFIG_FUNCTION_TRACER
 static bool function_enabled;
 
@@ -659,15 +598,34 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
 }
 
 #ifdef CONFIG_IRQSOFF_TRACER
+/*
+ * We are only interested in hardirq on/off events:
+ */
+static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
+{
+	if (!preempt_trace() && irq_trace())
+		stop_critical_timing(a0, a1);
+}
+
+static void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
+{
+	if (!preempt_trace() && irq_trace())
+		start_critical_timing(a0, a1);
+}
+
 static int irqsoff_tracer_init(struct trace_array *tr)
 {
 	trace_type = TRACER_IRQS_OFF;
 
+	register_trace_irq_disable(tracer_hardirqs_off, NULL);
+	register_trace_irq_enable(tracer_hardirqs_on, NULL);
 	return __irqsoff_tracer_init(tr);
 }
 
 static void irqsoff_tracer_reset(struct trace_array *tr)
 {
+	unregister_trace_irq_disable(tracer_hardirqs_off, NULL);
+	unregister_trace_irq_enable(tracer_hardirqs_on, NULL);
 	__irqsoff_tracer_reset(tr);
 }
 
@@ -692,19 +650,37 @@ static struct tracer irqsoff_tracer __read_mostly =
 };
 # define register_irqsoff(trace) register_tracer(&trace)
 #else
+static inline void tracer_hardirqs_on(unsigned long a0, unsigned long a1) { }
+static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
 # define register_irqsoff(trace) do { } while (0)
-#endif
+#endif /*  CONFIG_IRQSOFF_TRACER */
 
 #ifdef CONFIG_PREEMPT_TRACER
+static void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1)
+{
+	if (preempt_trace() && !irq_trace())
+		stop_critical_timing(a0, a1);
+}
+
+static void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1)
+{
+	if (preempt_trace() && !irq_trace())
+		start_critical_timing(a0, a1);
+}
+
 static int preemptoff_tracer_init(struct trace_array *tr)
 {
 	trace_type = TRACER_PREEMPT_OFF;
 
+	register_trace_preempt_disable(tracer_preempt_off, NULL);
+	register_trace_preempt_enable(tracer_preempt_on, NULL);
 	return __irqsoff_tracer_init(tr);
 }
 
 static void preemptoff_tracer_reset(struct trace_array *tr)
 {
+	unregister_trace_preempt_disable(tracer_preempt_off, NULL);
+	unregister_trace_preempt_enable(tracer_preempt_on, NULL);
 	__irqsoff_tracer_reset(tr);
 }
 
@@ -729,21 +705,32 @@ static struct tracer preemptoff_tracer __read_mostly =
 };
 # define register_preemptoff(trace) register_tracer(&trace)
 #else
+static inline void tracer_preempt_on(unsigned long a0, unsigned long a1) { }
+static inline void tracer_preempt_off(unsigned long a0, unsigned long a1) { }
 # define register_preemptoff(trace) do { } while (0)
-#endif
+#endif /* CONFIG_PREEMPT_TRACER */
 
-#if defined(CONFIG_IRQSOFF_TRACER) && \
-	defined(CONFIG_PREEMPT_TRACER)
+#if defined(CONFIG_IRQSOFF_TRACER) && defined(CONFIG_PREEMPT_TRACER)
 
 static int preemptirqsoff_tracer_init(struct trace_array *tr)
 {
 	trace_type = TRACER_IRQS_OFF | TRACER_PREEMPT_OFF;
 
+	register_trace_irq_disable(tracer_hardirqs_off, NULL);
+	register_trace_irq_enable(tracer_hardirqs_on, NULL);
+	register_trace_preempt_disable(tracer_preempt_off, NULL);
+	register_trace_preempt_enable(tracer_preempt_on, NULL);
+
 	return __irqsoff_tracer_init(tr);
 }
 
 static void preemptirqsoff_tracer_reset(struct trace_array *tr)
 {
+	unregister_trace_irq_disable(tracer_hardirqs_off, NULL);
+	unregister_trace_irq_enable(tracer_hardirqs_on, NULL);
+	unregister_trace_preempt_disable(tracer_preempt_off, NULL);
+	unregister_trace_preempt_enable(tracer_preempt_on, NULL);
+
 	__irqsoff_tracer_reset(tr);
 }
 
@@ -782,99 +769,3 @@ __init static int init_irqsoff_tracer(void)
 }
 core_initcall(init_irqsoff_tracer);
 #endif /* IRQSOFF_TRACER || PREEMPTOFF_TRACER */
-
-#ifndef CONFIG_IRQSOFF_TRACER
-static inline void tracer_hardirqs_on(void) { }
-static inline void tracer_hardirqs_off(void) { }
-static inline void tracer_hardirqs_on_caller(unsigned long caller_addr) { }
-static inline void tracer_hardirqs_off_caller(unsigned long caller_addr) { }
-#endif
-
-#ifndef CONFIG_PREEMPT_TRACER
-static inline void tracer_preempt_on(unsigned long a0, unsigned long a1) { }
-static inline void tracer_preempt_off(unsigned long a0, unsigned long a1) { }
-#endif
-
-#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_PROVE_LOCKING)
-/* Per-cpu variable to prevent redundant calls when IRQs already off */
-static DEFINE_PER_CPU(int, tracing_irq_cpu);
-
-void trace_hardirqs_on(void)
-{
-	if (!this_cpu_read(tracing_irq_cpu))
-		return;
-
-	trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
-	tracer_hardirqs_on();
-
-	this_cpu_write(tracing_irq_cpu, 0);
-}
-EXPORT_SYMBOL(trace_hardirqs_on);
-
-void trace_hardirqs_off(void)
-{
-	if (this_cpu_read(tracing_irq_cpu))
-		return;
-
-	this_cpu_write(tracing_irq_cpu, 1);
-
-	trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
-	tracer_hardirqs_off();
-}
-EXPORT_SYMBOL(trace_hardirqs_off);
-
-__visible void trace_hardirqs_on_caller(unsigned long caller_addr)
-{
-	if (!this_cpu_read(tracing_irq_cpu))
-		return;
-
-	trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
-	tracer_hardirqs_on_caller(caller_addr);
-
-	this_cpu_write(tracing_irq_cpu, 0);
-}
-EXPORT_SYMBOL(trace_hardirqs_on_caller);
-
-__visible void trace_hardirqs_off_caller(unsigned long caller_addr)
-{
-	if (this_cpu_read(tracing_irq_cpu))
-		return;
-
-	this_cpu_write(tracing_irq_cpu, 1);
-
-	trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
-	tracer_hardirqs_off_caller(caller_addr);
-}
-EXPORT_SYMBOL(trace_hardirqs_off_caller);
-
-/*
- * Stubs:
- */
-
-void trace_softirqs_on(unsigned long ip)
-{
-}
-
-void trace_softirqs_off(unsigned long ip)
-{
-}
-
-inline void print_irqtrace_events(struct task_struct *curr)
-{
-}
-#endif
-
-#if defined(CONFIG_PREEMPT_TRACER) || \
-	(defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_PREEMPTIRQ_EVENTS))
-void trace_preempt_on(unsigned long a0, unsigned long a1)
-{
-	trace_preempt_enable_rcuidle(a0, a1);
-	tracer_preempt_on(a0, a1);
-}
-
-void trace_preempt_off(unsigned long a0, unsigned long a1)
-{
-	trace_preempt_disable_rcuidle(a0, a1);
-	tracer_preempt_off(a0, a1);
-}
-#endif
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
new file mode 100644
index 000000000000..dc01c7f4d326
--- /dev/null
+++ b/kernel/trace/trace_preemptirq.c
@@ -0,0 +1,71 @@
+/*
+ * preemptoff and irqoff tracepoints
+ *
+ * Copyright (C) Joel Fernandes (Google) <joel@joelfernandes.org>
+ */
+
+#include <linux/kallsyms.h>
+#include <linux/uaccess.h>
+#include <linux/module.h>
+#include <linux/ftrace.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/preemptirq.h>
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+/* Per-cpu variable to prevent redundant calls when IRQs already off */
+static DEFINE_PER_CPU(int, tracing_irq_cpu);
+
+void trace_hardirqs_on(void)
+{
+	if (lockdep_recursing(current) || !this_cpu_read(tracing_irq_cpu))
+		return;
+
+	trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+	this_cpu_write(tracing_irq_cpu, 0);
+}
+EXPORT_SYMBOL(trace_hardirqs_on);
+
+void trace_hardirqs_off(void)
+{
+	if (lockdep_recursing(current) || this_cpu_read(tracing_irq_cpu))
+		return;
+
+	this_cpu_write(tracing_irq_cpu, 1);
+	trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+}
+EXPORT_SYMBOL(trace_hardirqs_off);
+
+__visible void trace_hardirqs_on_caller(unsigned long caller_addr)
+{
+	if (lockdep_recursing(current) || !this_cpu_read(tracing_irq_cpu))
+		return;
+
+	trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
+	this_cpu_write(tracing_irq_cpu, 0);
+}
+EXPORT_SYMBOL(trace_hardirqs_on_caller);
+
+__visible void trace_hardirqs_off_caller(unsigned long caller_addr)
+{
+	if (lockdep_recursing(current) || this_cpu_read(tracing_irq_cpu))
+		return;
+
+	this_cpu_write(tracing_irq_cpu, 1);
+	trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
+}
+EXPORT_SYMBOL(trace_hardirqs_off_caller);
+#endif /* CONFIG_TRACE_IRQFLAGS */
+
+#ifdef CONFIG_TRACE_PREEMPT_TOGGLE
+
+void trace_preempt_on(unsigned long a0, unsigned long a1)
+{
+	trace_preempt_enable_rcuidle(a0, a1);
+}
+
+void trace_preempt_off(unsigned long a0, unsigned long a1)
+{
+	trace_preempt_disable_rcuidle(a0, a1);
+}
+#endif
-- 
2.17.0.441.gb46fe60e1d-goog
