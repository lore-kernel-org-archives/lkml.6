Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbeDZIlv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:41:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43028 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbeDZIlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:41:46 -0400
Date: Thu, 26 Apr 2018 10:41:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gaurav Kohli <gkohli@codeaurora.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180426084131.GV4129@hirez.programming.kicks-ass.net>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 10:09:17PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 25, 2018 at 02:03:19PM +0530, Gaurav Kohli wrote:
> > diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> > index 5043e74..c5c5184 100644
> > --- a/kernel/smpboot.c
> > +++ b/kernel/smpboot.c
> > @@ -122,7 +122,45 @@ static int smpboot_thread_fn(void *data)
> >  		}
> >  
> >  		if (kthread_should_park()) {
> > +			/*
> > +			 * Serialize against wakeup.
> 			 *
> 			 * Prior wakeups must complete and later wakeups
> 			 * will observe TASK_RUNNING.
> 			 *
> 			 * This avoids the case where the TASK_RUNNING
> 			 * store from ttwu() competes with the
> 			 * TASK_PARKED store from kthread_parkme().
> 			 *
> 			 * If the TASK_PARKED store looses that
> 			 * competition, kthread_unpark() will go wobbly.
> > +			 */
> > +			raw_spin_lock(&current->pi_lock);
> >  			__set_current_state(TASK_RUNNING);
> > +			raw_spin_unlock(&current->pi_lock);
> >  			preempt_enable();
> >  			if (ht->park && td->status == HP_THREAD_ACTIVE) {
> >  				BUG_ON(td->cpu != smp_processor_id());
> 
> Does that work for you?
> 
> But looking at this a bit more; don't we have the exact same problem
> with the TASK_RUNNING store in the !ht->thread_should_run() case?
> Suppose a ttwu() happens concurrently there, it can end up competing
> against the TASK_INTERRUPTIBLE store, no?
> 
> Of course, that race is not fatal, we'll just end up going around the
> loop once again I suppose. Maybe a comment there too?
> 
> 			/*
> 			 * A similar race is possible here, but loosing
> 			 * the TASK_INTERRUPTIBLE store is harmless and
> 			 * will make us go around the loop once more.
> 			 */
> 

And with slightly more sleep I realize this is actually the normal
and expected pattern. The comment with __set_current_state() even
mentions this.

Also, I think the above patch is 'wrong'. It is not the TASK_RUNNING
store that is a problem it is the TASK_PARKED state that is special. And
if you look at do_task_dead() you'll see we do something very similar
for setting TASK_DEAD.

It is a problem specific to blocked states that do not follow the normal
wait pattern:

	for (;;) {
		set_current_state(STATE);
		if (cond)
			break;
		schedule();
	}
	__set_current_state(RUNNING);

The initial store or STATE can _always_ loose against a competing
RUNNING store from a previous wakeup, but the wait-loop and @cond test
will make it harmless.

The special states (DEAD,STOPPED,..) are different though, they
do not have a loop and expect to be honoured.

This had me looking at __kthread_park() and afaict we actually have a
condition, namely KTHREAD_SHOULD_PARK, which would suggest the following
change:

diff --git a/kernel/kthread.c b/kernel/kthread.c
index cd50e99202b0..4b6503c6a029 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -177,12 +177,13 @@ void *kthread_probe_data(struct task_struct *task)
 
 static void __kthread_parkme(struct kthread *self)
 {
-	__set_current_state(TASK_PARKED);
-	while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {
+	for (;;) {
+		__set_task_state(TASK_PARKED);
+		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
+			break;
 		if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))
 			complete(&self->parked);
 		schedule();
-		__set_current_state(TASK_PARKED);
 	}
 	clear_bit(KTHREAD_IS_PARKED, &self->flags);
 	__set_current_state(TASK_RUNNING);


For the others, I think we want to do something like the below. I still
need to look at TASK_TRACED, which I suspect is also special, but ptrace
always hurts my brain.

Opinions?

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b3d697f3b573..f4098435a882 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -110,19 +110,45 @@ struct task_group;
 					 (task->flags & PF_FROZEN) == 0 && \
 					 (task->state & TASK_NOLOAD) == 0)
 
+/*
+ * Special states are those that do not use the normal wait-loop pattern. See
+ * the comment with set_special_state().
+ */
+#define is_special_state(state)		\
+	((state) == TASK_DEAD ||	\
+	 (state) == TASK_STOPPED)
+
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
+/*
+ * Assert we don't use the regular *set_current_state() helpers for special
+ * states. See the comment with set_special_state().
+ */
+#define assert_special_state(state)	WARN_ON_ONCE(is_special_state(state))
+
 #define __set_current_state(state_value)			\
 	do {							\
+		assert_special_state(state_value);		\
 		current->task_state_change = _THIS_IP_;		\
 		current->state = (state_value);			\
 	} while (0)
+
 #define set_current_state(state_value)				\
 	do {							\
+		assert_special_state(state_value);		\
 		current->task_state_change = _THIS_IP_;		\
 		smp_store_mb(current->state, (state_value));	\
 	} while (0)
 
+#define set_special_state(state_value)					\
+	do {								\
+		unsigned long flags; /* may shadow */			\
+		WARN_ON_ONCE(!is_special_state(state_value));		\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
+		current->task_state_change = _THIS_IP_;			\
+		current->state = (state_value);				\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
+	} while (0)
 #else
 /*
  * set_current_state() includes a barrier so that the write of current->state
@@ -154,12 +180,30 @@ struct task_group;
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
 #define __set_current_state(state_value) do { current->state = (state_value); } while (0)
 #define set_current_state(state_value)	 smp_store_mb(current->state, (state_value))
+
+/*
+ * set_special_state() should be used for those states when the blocking task
+ * can not use the regular condition based wait-loop. In that case we must
+ * serialize against wakeups such that any possible in-flight TASK_RUNNING stores
+ * will not collide with out state change.
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
index d4ccea599692..c9cac52b1369 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2176,7 +2176,7 @@ static bool do_signal_stop(int signr)
 		if (task_participate_group_stop(current))
 			notify = CLD_STOPPED;
 
-		__set_current_state(TASK_STOPPED);
+		set_special_state(TASK_STOPPED);
 		spin_unlock_irq(&current->sighand->siglock);
 
 		/*
