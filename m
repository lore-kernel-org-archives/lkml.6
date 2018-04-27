Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeD0E1R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 00:27:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36210 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeD0E1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 00:27:15 -0400
X-Google-Smtp-Source: AB8JxZoo74zIdmh7fVwO9sM05KENYZlt2sJFJ529DsF8AahhS4gtPi7n/EqShniD05Qp7giL1P3lqg==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>,
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
Subject: [PATCH RFC] tracepoint: Introduce tracepoint callbacks executing with preempt on
Date: Thu, 26 Apr 2018 21:26:56 -0700
Message-Id: <20180427042656.190746-1-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In recent tests with IRQ on/off tracepoints, a large performance
overhead ~10% is noticed when running hackbench. This is root caused to
calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
tracepoint code. Following a long discussion on the list [1] about this,
we concluded that srcu is a better alternative for use during rcu idle.
Although it does involve extra barriers, its lighter than the sched-rcu
version which has to do additional RCU calls to notify RCU idle about
entry into RCU sections.

In this patch, we change the underlying implementation of the
trace_*_rcuidle API to use SRCU. This has shown to improve performance
alot for the high frequency irq enable/disable tracepoints.

In the future, we can add a new may_sleep API which can use this
infrastructure for callbacks that actually can sleep which will support
Mathieu's usecase of blocking probes.

Test: Tested idle and preempt/irq tracepoints.

[1] https://patchwork.kernel.org/patch/10344297/

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
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 include/linux/tracepoint.h | 37 +++++++++++++++++++++++++++++--------
 kernel/tracepoint.c        | 10 +++++++++-
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index c94f466d57ef..a1c1987de423 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -15,6 +15,7 @@
  */
 
 #include <linux/smp.h>
+#include <linux/srcu.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
@@ -33,6 +34,8 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
+extern struct srcu_struct tracepoint_srcu;
+
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
@@ -77,6 +80,7 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
  */
 static inline void tracepoint_synchronize_unregister(void)
 {
+	synchronize_srcu(&tracepoint_srcu);
 	synchronize_sched();
 }
 
@@ -129,18 +133,26 @@ extern void syscall_unregfunc(void);
  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
  */
-#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
+#define __DO_TRACE(tp, proto, args, cond, preempt_on)			\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
 		void *__data;						\
+		int __maybe_unused idx = 0;				\
 									\
 		if (!(cond))						\
 			return;						\
-		if (rcucheck)						\
-			rcu_irq_enter_irqson();				\
-		rcu_read_lock_sched_notrace();				\
-		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
+		if (preempt_on) {					\
+			WARN_ON_ONCE(in_nmi()); /* no srcu from nmi */	\
+			idx = srcu_read_lock(&tracepoint_srcu);         \
+			it_func_ptr = srcu_dereference((tp)->funcs,	\
+						&tracepoint_srcu);	\
+		} else {						\
+			rcu_read_lock_sched_notrace();			\
+			it_func_ptr =					\
+				rcu_dereference_sched((tp)->funcs);	\
+		}							\
+									\
 		if (it_func_ptr) {					\
 			do {						\
 				it_func = (it_func_ptr)->func;		\
@@ -148,12 +160,21 @@ extern void syscall_unregfunc(void);
 				((void(*)(proto))(it_func))(args);	\
 			} while ((++it_func_ptr)->func);		\
 		}							\
-		rcu_read_unlock_sched_notrace();			\
-		if (rcucheck)						\
-			rcu_irq_exit_irqson();				\
+									\
+		if (preempt_on)					\
+			srcu_read_unlock(&tracepoint_srcu, idx);	\
+		else							\
+			rcu_read_unlock_sched_notrace();		\
 	} while (0)
 
 #ifndef MODULE
+/*
+ * This is for tracepoints that may be called from an rcu idle path. To make
+ * sure we its safe in the idle path, use the srcu instead of sched-rcu by
+ * specifying the preempt_on flag below.  This has the obvious effect that any
+ * callback expecting preemption to be disabled should explicitly do so since
+ * with srcu it'd run with preempt on.
+ */
 #define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args) \
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 671b13457387..b3b1d65a2460 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -31,6 +31,9 @@
 extern struct tracepoint * const __start___tracepoints_ptrs[];
 extern struct tracepoint * const __stop___tracepoints_ptrs[];
 
+DEFINE_SRCU(tracepoint_srcu);
+EXPORT_SYMBOL_GPL(tracepoint_srcu);
+
 /* Set to 1 to enable tracepoint debug output */
 static const int tracepoint_debug;
 
@@ -67,11 +70,16 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void rcu_free_old_probes(struct rcu_head *head)
+static void srcu_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
+static void rcu_free_old_probes(struct rcu_head *head)
+{
+	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+}
+
 static inline void release_probes(struct tracepoint_func *old)
 {
 	if (old) {
-- 
2.17.0.441.gb46fe60e1d-goog
