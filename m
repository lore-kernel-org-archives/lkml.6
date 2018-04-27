Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932561AbeD0Jkl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:40:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52249 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932435AbeD0Jkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:40:39 -0400
Date: Fri, 27 Apr 2018 02:40:16 -0700
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-f9c811fac48cfbbfb452b08d1042386947868d07@git.kernel.org>
Cc: longman@redhat.com, tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, will.deacon@arm.com, hpa@zytor.com
Reply-To: hpa@zytor.com, will.deacon@arm.com, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, longman@redhat.com
In-Reply-To: <1524738868-31318-8-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-8-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock: Use
 atomic_cond_read_acquire()
Git-Commit-ID: f9c811fac48cfbbfb452b08d1042386947868d07
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f9c811fac48cfbbfb452b08d1042386947868d07
Gitweb:     https://git.kernel.org/tip/f9c811fac48cfbbfb452b08d1042386947868d07
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Thu, 26 Apr 2018 11:34:21 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 27 Apr 2018 09:48:49 +0200

locking/qspinlock: Use atomic_cond_read_acquire()

Rather than dig into the counter field of the atomic_t inside the
qspinlock structure so that we can call smp_cond_load_acquire(), use
atomic_cond_read_acquire() instead, which operates on the atomic_t
directly.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-8-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b51494a50b1e..56af1fa9874d 100644
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
@@ -441,8 +441,8 @@ queue:
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
@@ -452,7 +452,7 @@ queue:
 	if ((val = pv_wait_head_or_lock(lock, node)))
 		goto locked;
 
-	val = smp_cond_load_acquire(&lock->val.counter, !(VAL & _Q_LOCKED_PENDING_MASK));
+	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
 
 locked:
 	/*
@@ -469,7 +469,7 @@ locked:
 	/* In the PV case we might already have _Q_LOCKED_VAL set */
 	if ((val & _Q_TAIL_MASK) == tail) {
 		/*
-		 * The smp_cond_load_acquire() call above has provided the
+		 * The atomic_cond_read_acquire() call above has provided the
 		 * necessary acquire semantics required for locking.
 		 */
 		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
