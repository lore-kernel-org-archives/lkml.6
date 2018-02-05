Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeBEPvd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:51:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52460 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752986AbeBEPvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:51:25 -0500
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] sched/core: avoid spurious spinlock recursion splats
Date: Mon,  5 Feb 2018 15:51:18 +0000
Message-Id: <20180205155118.23657-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The runqueue locks are special in that the owner changes over a context
switch. To ensure that this is accounted for in CONFIG_DEBUG_SPINLOCK
builds, finish_lock_switch updates rq->lock.owner while the lock is
held.

However, this happens *after* prev->on_cpu is cleared, which allows prev
to be scheduled on another CPU. If prev then attempts to acquire the
same rq lock, before the updated rq->lock.owner is made visible, it will
see itself as the owner.

This can happen in virtual environments, where a vCPU can be preempted
for an arbitrarily long period between updating prev->on_cpu and
rq->lock.owner, as has been observed on arm64 and x86 under KVM, e.g.

BUG: spinlock recursion on CPU#1, syz-executor1/1521
 lock: 0xffff80001a764080, .magic: dead4ead, .owner: syz-executor1/1521, .owner_cpu: 0
CPU: 1 PID: 1521 Comm: syz-executor1 Not tainted 4.15.0 #3
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x330 arch/arm64/kernel/time.c:52
 show_stack+0x20/0x30 arch/arm64/kernel/traps.c:151
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0xd0/0x120 lib/dump_stack.c:53
 spin_dump+0x150/0x1f0 kernel/locking/spinlock_debug.c:67
 spin_bug kernel/locking/spinlock_debug.c:75 [inline]
 debug_spin_lock_before kernel/locking/spinlock_debug.c:84 [inline]
 do_raw_spin_lock+0x1e4/0x250 kernel/locking/spinlock_debug.c:112
 __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_lock+0x44/0x50 kernel/locking/spinlock.c:144
 __task_rq_lock+0xc0/0x288 kernel/sched/core.c:103
 wake_up_new_task+0x384/0x798 kernel/sched/core.c:2465
 _do_fork+0x1b4/0xa78 kernel/fork.c:2069
 SYSC_clone kernel/fork.c:2154 [inline]
 SyS_clone+0x48/0x60 kernel/fork.c:2132
 el0_svc_naked+0x20/0x24

Let's avoid this updating rq->lock.owner before clearing prev->on_cpu.
As the latter is a release, it ensures that the new owner is visible to
prev if it is scheduled on another CPU.

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
