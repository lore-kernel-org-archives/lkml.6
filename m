Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeD3L43 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:56:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33644 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeD3L41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:56:27 -0400
Date: Mon, 30 Apr 2018 13:56:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Gaurav Kohli <gkohli@codeaurora.org>, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180430115612.GX4129@hirez.programming.kicks-ass.net>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
 <20180426084131.GV4129@hirez.programming.kicks-ass.net>
 <20180426161820.GA15391@redhat.com>
 <20180430112029.GF4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430112029.GF4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 01:20:29PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 26, 2018 at 06:18:20PM +0200, Oleg Nesterov wrote:
> > On 04/26, Peter Zijlstra wrote:
> > >
> > > For the others, I think we want to do something like the below. I still
> > > need to look at TASK_TRACED, which I suspect is also special,
> > 
> > ptrace_freeze_traced() and ptrace_unfreeze_traced() should be fine, but
> > ptrace_stop() wants set_special_state() too, I think.
> 
> Thanks for going through that, I'll update the patch.

Something like so then... I'll go write me some Changelog.


diff --git a/include/linux/sched.h b/include/linux/sched.h
index b3d697f3b573..51f46704e566 100644
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
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index a7ce74c74e49..113d1ad1ced7 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -280,7 +280,7 @@ static inline void kernel_signal_stop(void)
 {
 	spin_lock_irq(&current->sighand->siglock);
 	if (current->jobctl & JOBCTL_STOP_DEQUEUED)
-		__set_current_state(TASK_STOPPED);
+		set_special_state(TASK_STOPPED);
 	spin_unlock_irq(&current->sighand->siglock);
 
 	schedule();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10aaeebfcc..3898a8047c11 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3498,23 +3498,8 @@ static void __sched notrace __schedule(bool preempt)
 
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
diff --git a/kernel/signal.c b/kernel/signal.c
index d4ccea599692..564ee214e80a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1968,7 +1968,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, siginfo_t *info)
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
