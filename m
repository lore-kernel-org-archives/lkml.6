Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757969AbeD0JiY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:38:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757789AbeD0JiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:38:22 -0400
Date: Fri, 27 Apr 2018 02:37:59 -0700
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-6512276d97b160d90b53285bd06f7f201459a7e3@git.kernel.org>
Cc: mingo@kernel.org, peterz@infradead.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, longman@redhat.com
Reply-To: longman@redhat.com, mingo@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, will.deacon@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <1524738868-31318-4-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-4-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock: Bound spinning on
 pending->locked transition in slowpath
Git-Commit-ID: 6512276d97b160d90b53285bd06f7f201459a7e3
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

Commit-ID:  6512276d97b160d90b53285bd06f7f201459a7e3
Gitweb:     https://git.kernel.org/tip/6512276d97b160d90b53285bd06f7f201459a7e3
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Thu, 26 Apr 2018 11:34:17 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 27 Apr 2018 09:48:46 +0200

locking/qspinlock: Bound spinning on pending->locked transition in slowpath

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

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-4-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index f5b0e59f6d14..a0f7976348f8 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -76,6 +76,18 @@
 #define MAX_NODES	4
 #endif
 
+/*
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
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
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
