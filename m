Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeFEUNf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:13:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44854 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbeFEUNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:13:34 -0400
Date: Tue, 5 Jun 2018 22:13:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Kohli, Gaurav" <gkohli@codeaurora.org>, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180605201316.GZ12198@hirez.programming.kicks-ass.net>
References: <9b289790-9b3a-73bd-7166-bf39f32cefd8@codeaurora.org>
 <20180502082011.GB12180@hirez.programming.kicks-ass.net>
 <830d7225-af90-a55a-991a-bb2023d538f1@codeaurora.org>
 <cdd5d434-9c11-7c19-2895-0f7f3811eb11@codeaurora.org>
 <55221a5b-dd52-3359-f582-86830dd9f205@codeaurora.org>
 <ba12bc49-33c0-b4ee-05cf-f84124bd66cc@codeaurora.org>
 <20180605150841.GA24053@redhat.com>
 <20180605152212.GY12180@hirez.programming.kicks-ass.net>
 <20180605154053.GB12235@hirez.programming.kicks-ass.net>
 <20180605163515.GB24053@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605163515.GB24053@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 06:35:16PM +0200, Oleg Nesterov wrote:
> Yes, but this won't fix the race decribed by Kohli...

Clearly I'm not going strong today... and yes, looking at that again I
didn't address that.

> Plus this complicates the schedule() paths for the very special case

I checked, we already spilled @preempt onto the stack, context_switch()
is inlined so the extra argument is a no-op, if finish_task_switch()
also gets inlined (possible, could force it) the only additional cost is
the @preempt load from stack in the slow path. If it doesn't get inlined
we get the additional function call overhead, which should be minimal.

But yes, I wasn't a fan either.

> and to me it seems that all this kthread_park/unpark logic needs some
> serious cleanups...

I really hated how even with TASK_PARKED special the smpboot thread
could still get migrated, which is why I moved the completion. Do you
have any saner suggestions?

Humm, I suppose we could do wait_task_inactive() after
wait_for_completion().  I absolutely abhor wait_task_inactive(), but I
remember us both failing to fix that at least twice :/

Also, I think we still need TASK_PARKED as a special state for that.

How's the below?

---
 include/linux/kthread.h |  1 -
 include/linux/sched.h   |  2 +-
 kernel/kthread.c        | 32 +++++++++++++++++++++++++-------
 kernel/sched/core.c     | 31 +++++++++++--------------------
 4 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 2803264c512f..c1961761311d 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -62,7 +62,6 @@ void *kthread_probe_data(struct task_struct *k);
 int kthread_park(struct task_struct *k);
 void kthread_unpark(struct task_struct *k);
 void kthread_parkme(void);
-void kthread_park_complete(struct task_struct *k);
 
 int kthreadd(void *unused);
 extern struct task_struct *kthreadd_task;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 14e4f9c12337..4e32c1cc7794 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -117,7 +117,7 @@ struct task_group;
  * the comment with set_special_state().
  */
 #define is_special_task_state(state)				\
-	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_DEAD))
+	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
 
 #define __set_current_state(state_value)			\
 	do {							\
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 481951bf091d..8f66a3dc767a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -177,12 +177,24 @@ void *kthread_probe_data(struct task_struct *task)
 static void __kthread_parkme(struct kthread *self)
 {
 	for (;;) {
-		set_current_state(TASK_PARKED);
+		/*
+		 * TASK_PARKED is a special state; we must serialize against
+		 * possible pending wakeups to avoid store-store collisions on
+		 * task->state.
+		 *
+		 * Such a collision might possibly result in the task state
+		 * changin from TASK_PARKED and us failing the
+		 * wait_task_inactive() in kthread_park().
+		 */
+		set_special_state(TASK_PARKED);
 		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
 			break;
+
+		complete_all(&self->parked);
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);
+	reinit_completion(&self->parked);
 }
 
 void kthread_parkme(void)
@@ -191,11 +203,6 @@ void kthread_parkme(void)
 }
 EXPORT_SYMBOL_GPL(kthread_parkme);
 
-void kthread_park_complete(struct task_struct *k)
-{
-	complete_all(&to_kthread(k)->parked);
-}
-
 static int kthread(void *_create)
 {
 	/* Copy data: it's on kthread's stack */
@@ -459,8 +466,10 @@ void kthread_unpark(struct task_struct *k)
 	if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
 		__kthread_bind(k, kthread->cpu, TASK_PARKED);
 
-	reinit_completion(&kthread->parked);
 	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
+	/*
+	 * __kthread_parkme() will either see !SHOULD_PARK or get the wakeup.
+	 */
 	wake_up_state(k, TASK_PARKED);
 }
 EXPORT_SYMBOL_GPL(kthread_unpark);
@@ -487,7 +496,16 @@ int kthread_park(struct task_struct *k)
 	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	if (k != current) {
 		wake_up_process(k);
+		/*
+		 * Wait for __kthread_parkme() to complete(), this means we
+		 * _will_ have TASK_PARKED and are about to call schedule().
+		 */
 		wait_for_completion(&kthread->parked);
+		/*
+		 * Now wait for that schedule() to complete and the task to
+		 * get scheduled out.
+		 */
+		WARN_ON_ONCE(!wait_task_inactive(p, TASK_PARKED));
 	}
 
 	return 0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8d59b259af4a..cf72c4eed7da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7,7 +7,6 @@
  */
 #include "sched.h"
 
-#include <linux/kthread.h>
 #include <linux/nospec.h>
 
 #include <asm/switch_to.h>
@@ -2701,28 +2700,20 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		membarrier_mm_sync_core_before_usermode(mm);
 		mmdrop(mm);
 	}
-	if (unlikely(prev_state & (TASK_DEAD|TASK_PARKED))) {
-		switch (prev_state) {
-		case TASK_DEAD:
-			if (prev->sched_class->task_dead)
-				prev->sched_class->task_dead(prev);
+	if (unlikely(prev_state == TASK_DEAD)) {
+		if (prev->sched_class->task_dead)
+			prev->sched_class->task_dead(prev);
 
-			/*
-			 * Remove function-return probe instances associated with this
-			 * task and put them back on the free list.
-			 */
-			kprobe_flush_task(prev);
-
-			/* Task is done with its stack. */
-			put_task_stack(prev);
+		/*
+		 * Remove function-return probe instances associated with this
+		 * task and put them back on the free list.
+		 */
+		kprobe_flush_task(prev);
 
-			put_task_struct(prev);
-			break;
+		/* Task is done with its stack. */
+		put_task_stack(prev);
 
-		case TASK_PARKED:
-			kthread_park_complete(prev);
-			break;
-		}
+		put_task_struct(prev);
 	}
 
 	tick_nohz_task_switch();
