Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754379AbeD3O0f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:26:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34764 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbeD3O0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:26:32 -0400
Message-Id: <20180430142235.900370484@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 30 Apr 2018 16:17:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, oleg@redhat.com, will.deacon@arm.com,
        mpe@ellerman.id.au, bigeasy@linutronix.de, gkohli@codeaurora.org,
        neeraju@codeaurora.org, peterz@infradead.org
Subject: [PATCH 2/2] sched: Introduce set_special_state()
References: <20180430141751.377491406@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sched-smpboot-2.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gaurav reported a perceived problem with TASK_PARKED, which turned out
to be a broken wait-loop pattern in __kthread_parkme(), but the
reported issue can (and does) in fact happen for states that do not do
condition based sleeps.

When the 'current->state = TASK_RUNNING' store of a previous
(concurrent) try_to_wake_up() collides with the setting of a 'special'
sleep state, we can loose the sleep state.

Normal condition based wait-loops are immune to this problem, but for
sleep states that are not condition based are subject to this problem.

There already is a fix for TASK_DEAD. Abstract that and also apply it to
TASK_STOPPED and TASK_TRACED, both of which are also without condition
based wait-loop.

Cc: Oleg Nesterov <oleg@redhat.com>
Reported-by: Gaurav Kohli <gkohli@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h        |   52 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/sched/signal.h |    2 -
 kernel/sched/core.c          |   17 --------------
 kernel/signal.c              |    4 +--
 4 files changed, 51 insertions(+), 24 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -112,17 +112,38 @@ struct task_group;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
+/*
+ * Special states are those that do not use the normal wait-loop pattern. See
+ * the comment with set_special_state().
+ */
+#define is_special_task_state(state)	\
+	((state) == TASK_DEAD    ||	\
+	 (state) == TASK_STOPPED ||	\
+	 (state) == TASK_TRACED)
+
 #define __set_current_state(state_value)			\
 	do {							\
+		WARN_ON_ONCE(is_special_task_state(state));	\
 		current->task_state_change = _THIS_IP_;		\
 		current->state = (state_value);			\
 	} while (0)
+
 #define set_current_state(state_value)				\
 	do {							\
+		WARN_ON_ONCE(is_special_task_state(state));	\
 		current->task_state_change = _THIS_IP_;		\
 		smp_store_mb(current->state, (state_value));	\
 	} while (0)
 
+#define set_special_state(state_value)					\
+	do {								\
+		unsigned long flags; /* may shadow */			\
+		WARN_ON_ONCE(!is_special_task_state(state_value));	\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
+		current->task_state_change = _THIS_IP_;			\
+		current->state = (state_value);				\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
+	} while (0)
 #else
 /*
  * set_current_state() includes a barrier so that the write of current->state
@@ -144,8 +165,8 @@ struct task_group;
  *
  * The above is typically ordered against the wakeup, which does:
  *
- *	need_sleep = false;
- *	wake_up_state(p, TASK_UNINTERRUPTIBLE);
+ *   need_sleep = false;
+ *   wake_up_state(p, TASK_UNINTERRUPTIBLE);
  *
  * Where wake_up_state() (and all other wakeup primitives) imply enough
  * barriers to order the store of the variable against wakeup.
@@ -154,12 +175,33 @@ struct task_group;
  * once it observes the TASK_UNINTERRUPTIBLE store the waking CPU can issue a
  * TASK_RUNNING store which can collide with __set_current_state(TASK_RUNNING).
  *
- * This is obviously fine, since they both store the exact same value.
+ * However, with slightly different timing the wakeup TASK_RUNNING store can
+ * also collide with the TASK_UNINTERRUPTIBLE store. Loosing that store is not
+ * a problem either because that will result in one extra go around the loop
+ * and our @cond test will save the day.
  *
  * Also see the comments of try_to_wake_up().
  */
-#define __set_current_state(state_value) do { current->state = (state_value); } while (0)
-#define set_current_state(state_value)	 smp_store_mb(current->state, (state_value))
+#define __set_current_state(state_value)				\
+	current->state = (state_value)
+
+#define set_current_state(state_value)					\
+	smp_store_mb(current->state, (state_value))
+
+/*
+ * set_special_state() should be used for those states when the blocking task
+ * can not use the regular condition based wait-loop. In that case we must
+ * serialize against wakeups such that any possible in-flight TASK_RUNNING stores
+ * will not collide with our state change.
+ */
+#define set_special_state(state_value)					\
+	do {								\
+		unsigned long flags; /* may shadow */			\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
+		current->state = (state_value);				\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
+	} while (0)
+
 #endif
 
 /* Task command name length: */
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -280,7 +280,7 @@ static inline void kernel_signal_stop(vo
 {
 	spin_lock_irq(&current->sighand->siglock);
 	if (current->jobctl & JOBCTL_STOP_DEQUEUED)
-		__set_current_state(TASK_STOPPED);
+		set_special_state(TASK_STOPPED);
 	spin_unlock_irq(&current->sighand->siglock);
 
 	schedule();
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3498,23 +3498,8 @@ static void __sched notrace __schedule(b
 
 void __noreturn do_task_dead(void)
 {
-	/*
-	 * The setting of TASK_RUNNING by try_to_wake_up() may be delayed
-	 * when the following two conditions become true.
-	 *   - There is race condition of mmap_sem (It is acquired by
-	 *     exit_mm()), and
-	 *   - SMI occurs before setting TASK_RUNINNG.
-	 *     (or hypervisor of virtual machine switches to other guest)
-	 *  As a result, we may become TASK_RUNNING after becoming TASK_DEAD
-	 *
-	 * To avoid it, we have to wait for releasing tsk->pi_lock which
-	 * is held by try_to_wake_up()
-	 */
-	raw_spin_lock_irq(&current->pi_lock);
-	raw_spin_unlock_irq(&current->pi_lock);
-
 	/* Causes final put_task_struct in finish_task_switch(): */
-	__set_current_state(TASK_DEAD);
+	set_special_state(TASK_DEAD);
 
 	/* Tell freezer to ignore us: */
 	current->flags |= PF_NOFREEZE;
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1968,7 +1968,7 @@ static void ptrace_stop(int exit_code, i
 	 * atomic with respect to siglock and should be done after the arch
 	 * hook as siglock is released and regrabbed across it.
 	 */
-	set_current_state(TASK_TRACED);
+	set_special_state(TASK_TRACED);
 
 	current->last_siginfo = info;
 	current->exit_code = exit_code;
@@ -2176,7 +2176,7 @@ static bool do_signal_stop(int signr)
 		if (task_participate_group_stop(current))
 			notify = CLD_STOPPED;
 
-		__set_current_state(TASK_STOPPED);
+		set_special_state(TASK_STOPPED);
 		spin_unlock_irq(&current->sighand->siglock);
 
 		/*
