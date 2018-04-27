Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbeD0JkK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:40:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44771 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932491AbeD0JkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:40:07 -0400
Date: Fri, 27 Apr 2018 02:39:44 -0700
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-c61da58d8a9ba9238250a548f00826eaf44af0f7@git.kernel.org>
Cc: longman@redhat.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: mingo@kernel.org, peterz@infradead.org, longman@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will.deacon@arm.com
In-Reply-To: <1524738868-31318-7-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-7-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock: Kill cmpxchg() loop when
 claiming lock from head of queue
Git-Commit-ID: c61da58d8a9ba9238250a548f00826eaf44af0f7
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

Commit-ID:  c61da58d8a9ba9238250a548f00826eaf44af0f7
Gitweb:     https://git.kernel.org/tip/c61da58d8a9ba9238250a548f00826eaf44af0f7
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Thu, 26 Apr 2018 11:34:20 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 27 Apr 2018 09:48:48 +0200

locking/qspinlock: Kill cmpxchg() loop when claiming lock from head of queue

When a queued locker reaches the head of the queue, it claims the lock
by setting _Q_LOCKED_VAL in the lockword. If there isn't contention, it
must also clear the tail as part of this operation so that subsequent
lockers can avoid taking the slowpath altogether.

Currently this is expressed as a cmpxchg() loop that practically only
runs up to two iterations. This is confusing to the reader and unhelpful
to the compiler. Rewrite the cmpxchg() loop without the loop, so that a
failed cmpxchg() implies that there is contention and we just need to
write to _Q_LOCKED_VAL without considering the rest of the lockword.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-7-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index e06f67e021d9..b51494a50b1e 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -465,24 +465,21 @@ locked:
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
