Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeDKSBP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 14:01:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752588AbeDKSBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:01:07 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 05/13] locking/qspinlock: Kill cmpxchg loop when claiming lock from head of queue
Date: Wed, 11 Apr 2018 19:01:12 +0100
Message-Id: <1523469680-17699-6-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a queued locker reaches the head of the queue, it claims the lock
by setting _Q_LOCKED_VAL in the lockword. If there isn't contention, it
must also clear the tail as part of this operation so that subsequent
lockers can avoid taking the slowpath altogether.

Currently this is expressed as a cmpxchg loop that practically only
runs up to two iterations. This is confusing to the reader and unhelpful
to the compiler. Rewrite the cmpxchg loop without the loop, so that a
failed cmpxchg implies that there is contention and we just need to
write to _Q_LOCKED_VAL without considering the rest of the lockword.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index a8fc402b3f3a..01b660442d87 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -505,24 +505,21 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * and nobody is pending, clear the tail code and grab the lock.
 	 * Otherwise, we only need to grab the lock.
 	 */
-	for (;;) {
-		/* In the PV case we might already have _Q_LOCKED_VAL set */
-		if ((val & _Q_TAIL_MASK) != tail || (val & _Q_PENDING_MASK)) {
-			set_locked(lock);
-			break;
-		}
+
+	/* In the PV case we might already have _Q_LOCKED_VAL set */
+	if ((val & _Q_TAIL_MASK) == tail) {
 		/*
 		 * The smp_cond_load_acquire() call above has provided the
-		 * necessary acquire semantics required for locking. At most
-		 * two iterations of this loop may be ran.
+		 * necessary acquire semantics required for locking.
 		 */
 		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
 		if (old == val)
-			goto release;	/* No contention */
-
-		val = old;
+			goto release; /* No contention */
 	}
 
+	/* Either somebody is queued behind us or _Q_PENDING_VAL is set */
+	set_locked(lock);
+
 	/*
 	 * contended path; wait for next if not observed yet, release.
 	 */
-- 
2.1.4
