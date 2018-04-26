Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755808AbeDZKfp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:35:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51078 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755108AbeDZKeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:34:10 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com, will.deacon@arm.com
Subject: [PATCH v3 07/14] locking/qspinlock: Use atomic_cond_read_acquire
Date: Thu, 26 Apr 2018 11:34:21 +0100
Message-Id: <1524738868-31318-8-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than dig into the counter field of the atomic_t inside the
qspinlock structure so that we can call smp_cond_load_acquire, use
atomic_cond_read_acquire instead, which operates on the atomic_t
directly.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index e42f50d69ed6..5e383cfe4cce 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -337,8 +337,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		 * barriers.
 		 */
 		if (val & _Q_LOCKED_MASK) {
-			smp_cond_load_acquire(&lock->val.counter,
-					      !(VAL & _Q_LOCKED_MASK));
+			atomic_cond_read_acquire(&lock->val,
+						 !(VAL & _Q_LOCKED_MASK));
 		}
 
 		/*
@@ -441,8 +441,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *
 	 * The PV pv_wait_head_or_lock function, if active, will acquire
 	 * the lock and return a non-zero value. So we have to skip the
-	 * smp_cond_load_acquire() call. As the next PV queue head hasn't been
-	 * designated yet, there is no way for the locked value to become
+	 * atomic_cond_read_acquire() call. As the next PV queue head hasn't
+	 * been designated yet, there is no way for the locked value to become
 	 * _Q_SLOW_VAL. So both the set_locked() and the
 	 * atomic_cmpxchg_relaxed() calls will be safe.
 	 *
@@ -452,7 +452,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if ((val = pv_wait_head_or_lock(lock, node)))
 		goto locked;
 
-	val = smp_cond_load_acquire(&lock->val.counter, !(VAL & _Q_LOCKED_PENDING_MASK));
+	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
 
 locked:
 	/*
@@ -469,7 +469,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/* In the PV case we might already have _Q_LOCKED_VAL set */
 	if ((val & _Q_TAIL_MASK) == tail) {
 		/*
-		 * The smp_cond_load_acquire() call above has provided the
+		 * The atomic_cond_read_acquire() call above has provided the
 		 * necessary acquire semantics required for locking.
 		 */
 		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
-- 
2.1.4
