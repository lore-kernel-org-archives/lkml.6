Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeBBWHj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:07:39 -0500
Received: from foss.arm.com ([217.140.101.70]:36622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752211AbeBBWHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:07:34 -0500
Date: Fri, 2 Feb 2018 22:07:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        efault@gmx.de, tglx@linutronix.de, mingo@kernel.org,
        alexander.levin@verizon.com
Subject: Re: Runqueue spinlock recursion on arm64 v4.15
Message-ID: <20180202220726.23d4ljxxdysafbxd@salmiak>
References: <20180202192704.nqwjsthl3agszhzt@lakrids.cambridge.arm.com>
 <20180202195506.GP2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202195506.GP2269@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 08:55:06PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 02, 2018 at 07:27:04PM +0000, Mark Rutland wrote:
> > ... in some cases, owner_cpu is -1, so I guess we're racing with an
> > unlock. I only ever see this on the runqueue locks in wake up functions.
> 
> So runqueue locks are special in that the owner changes over a contex
> switch, maybe something goes funny there?

Aha! I think that's it!

In finish_lock_switch() we do:

	smp_store_release(&prev->on_cpu, 0);
	...
	rq->lock.owner = current;

As soon as we update prev->on_cpu, prev can be scheduled on another CPU, and
can thus see a stale value for rq->lock.owner (e.g. if it tries to wake up
another task on that rq).

I guess the below (completely untested) would fix that. I'll try to give it a
go next week.

Thanks,
Mark.

---->8----
>From 3ef7e7466d09d2270d2a353d032ff0f9bc0488a7 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 2 Feb 2018 21:56:17 +0000
Subject: [PATCH] sched/core: avoid spurious spinlock recursion splats

The runqueue locks are special in that the owner changes over a context switch.
To ensure that this is account for in CONFIG_DEBUG_SPINLOCK builds,
finish_lock_switch updates rq->lock.owner while the lock is held.

However, this happens *after* prev->on_cpu is cleared, which allows prev to be
scheduled on another CPU. If prev then attempts to acquire the same rq lock, it
will see itself as the owner.

This can be seen in virtual environments, where the vCPU can be preempted for
an arbitrarily long period between updating prev->on_cpu and rq->lock.owner.

We can avoid this issue by updating rq->lock.owner first. The release of
prev->on_cpu will ensure that the new owner is visible to prev if it is
scheduled on another CPU.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b19552a212de..4f0d2e3701c3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1342,6 +1342,10 @@ static inline void prepare_lock_switch(struct rq *rq, struct task_struct *next)
 
 static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
 {
+#ifdef CONFIG_DEBUG_SPINLOCK
+	/* this is a valid case when another task releases the spinlock */
+	rq->lock.owner = current;
+#endif
 #ifdef CONFIG_SMP
 	/*
 	 * After ->on_cpu is cleared, the task can be moved to a different CPU.
@@ -1355,10 +1359,6 @@ static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
 	 */
 	smp_store_release(&prev->on_cpu, 0);
 #endif
-#ifdef CONFIG_DEBUG_SPINLOCK
-	/* this is a valid case when another task releases the spinlock */
-	rq->lock.owner = current;
-#endif
 	/*
 	 * If we are tracking spinlock dependencies then we have to
 	 * fix up the runqueue lock - which gets 'carried over' from
-- 
2.11.0
