Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755966AbeDZKiD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:38:03 -0400
Received: from foss.arm.com ([217.140.101.70]:51004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754678AbeDZKeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:34:09 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com, will.deacon@arm.com
Subject: [PATCH v3 03/14] locking/qspinlock: Bound spinning on pending->locked transition in slowpath
Date: Thu, 26 Apr 2018 11:34:17 +0100
Message-Id: <1524738868-31318-4-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a locker taking the qspinlock slowpath reads a lock value indicating
that only the pending bit is set, then it will spin whilst the
concurrent pending->locked transition takes effect.

Unfortunately, there is no guarantee that such a transition will ever be
observed since concurrent lockers could continuously set pending and
hand over the lock amongst themselves, leading to starvation. Whilst
this would probably resolve in practice, it means that it is not
possible to prove liveness properties about the lock and means that lock
acquisition time is unbounded.

Rather than removing the pending->locked spinning from the slowpath
altogether (which has been shown to heavily penalise a 2-threaded
locking stress test on x86), this patch replaces the explicit spinning
with a call to atomic_cond_read_relaxed and allows the architecture to
provide a bound on the number of spins. For architectures that can
respond to changes in cacheline state in their smp_cond_load implementation,
it should be sufficient to use the default bound of 1.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index f5b0e59f6d14..a0f7976348f8 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -77,6 +77,18 @@
 #endif
 
 /*
+ * The pending bit spinning loop count.
+ * This heuristic is used to limit the number of lockword accesses
+ * made by atomic_cond_read_relaxed when waiting for the lock to
+ * transition out of the "== _Q_PENDING_VAL" state. We don't spin
+ * indefinitely because there's no guarantee that we'll make forward
+ * progress.
+ */
+#ifndef _Q_PENDING_LOOPS
+#define _Q_PENDING_LOOPS	1
+#endif
+
+/*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
  *
@@ -266,13 +278,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		return;
 
 	/*
-	 * wait for in-progress pending->locked hand-overs
+	 * Wait for in-progress pending->locked hand-overs with a bounded
+	 * number of spins so that we guarantee forward progress.
 	 *
 	 * 0,1,0 -> 0,0,1
 	 */
 	if (val == _Q_PENDING_VAL) {
-		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
-			cpu_relax();
+		int cnt = _Q_PENDING_LOOPS;
+		val = atomic_cond_read_relaxed(&lock->val,
+					       (VAL != _Q_PENDING_VAL) || !cnt--);
 	}
 
 	/*
-- 
2.1.4
