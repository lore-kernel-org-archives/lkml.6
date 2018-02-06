Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeBFKDV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 05:03:21 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:35117 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbeBFKDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:03:10 -0500
Date: Tue, 6 Feb 2018 11:03:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/core: avoid spurious spinlock recursion splats
Message-ID: <20180206100307.GD2269@hirez.programming.kicks-ass.net>
References: <20180205155118.23657-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205155118.23657-1-mark.rutland@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 03:51:18PM +0000, Mark Rutland wrote:
> However, this happens *after* prev->on_cpu is cleared, which allows prev
> to be scheduled on another CPU. If prev then attempts to acquire the
> same rq lock, before the updated rq->lock.owner is made visible, it will
> see itself as the owner.

Cute.

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b19552a212de..4f0d2e3701c3 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1342,6 +1342,10 @@ static inline void prepare_lock_switch(struct rq *rq, struct task_struct *next)
>  
>  static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
>  {
> +#ifdef CONFIG_DEBUG_SPINLOCK
> +	/* this is a valid case when another task releases the spinlock */
> +	rq->lock.owner = current;
> +#endif
>  #ifdef CONFIG_SMP
>  	/*
>  	 * After ->on_cpu is cleared, the task can be moved to a different CPU.
> @@ -1355,10 +1359,6 @@ static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
>  	 */
>  	smp_store_release(&prev->on_cpu, 0);
>  #endif
> -#ifdef CONFIG_DEBUG_SPINLOCK
> -	/* this is a valid case when another task releases the spinlock */
> -	rq->lock.owner = current;
> -#endif
>  	/*
>  	 * If we are tracking spinlock dependencies then we have to
>  	 * fix up the runqueue lock - which gets 'carried over' from

Right, so patch:

  31cb1bc0dc94 ("sched/core: Rework and clarify prepare_lock_switch()")

munched all that code and the above no longer fits. Does the below
change also work for you? (tip/master)

---
 kernel/sched/core.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee420d78e674..abfd10692022 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2600,19 +2600,31 @@ static inline void finish_task(struct task_struct *prev)
 #endif
 }
 
-static inline void finish_lock_switch(struct rq *rq)
+static inline void
+prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
+	/*
+	 * Since the runqueue lock will be released by the next
+	 * task (which is an invalid locking op but in the case
+	 * of the scheduler it's an obvious special-case), so we
+	 * do an early lockdep release here:
+	 */
+	rq_unpin_lock(rq, rf);
+	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
-	rq->lock.owner = current;
+	rq->lock.owner = next;
 #endif
+}
+
+static inline void finish_lock_switch(struct rq *rq)
+{
 	/*
 	 * If we are tracking spinlock dependencies then we have to
 	 * fix up the runqueue lock - which gets 'carried over' from
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -2843,14 +2855,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
 
-	/*
-	 * Since the runqueue lock will be released by the next
-	 * task (which is an invalid locking op but in the case
-	 * of the scheduler it's an obvious special-case), so we
-	 * do an early lockdep release here:
-	 */
-	rq_unpin_lock(rq, rf);
-	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
+	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
 	switch_to(prev, next, prev);
