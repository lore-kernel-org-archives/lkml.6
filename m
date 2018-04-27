Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932621AbeD0Jnj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:43:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59771 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932460AbeD0Jne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:43:34 -0400
Date: Fri, 27 Apr 2018 02:43:09 -0700
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-ae75d9089ff7095d1d1a12c3cd86b21d3eaf3b15@git.kernel.org>
Cc: torvalds@linux-foundation.org, will.deacon@arm.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, longman@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, longman@redhat.com,
        peterz@infradead.org, mingo@kernel.org, torvalds@linux-foundation.org,
        will.deacon@arm.com, tglx@linutronix.de
In-Reply-To: <1524738868-31318-13-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-13-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock: Use try_cmpxchg() instead of
 cmpxchg() when locking
Git-Commit-ID: ae75d9089ff7095d1d1a12c3cd86b21d3eaf3b15
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

Commit-ID:  ae75d9089ff7095d1d1a12c3cd86b21d3eaf3b15
Gitweb:     https://git.kernel.org/tip/ae75d9089ff7095d1d1a12c3cd86b21d3eaf3b15
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Thu, 26 Apr 2018 11:34:26 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 27 Apr 2018 09:48:52 +0200

locking/qspinlock: Use try_cmpxchg() instead of cmpxchg() when locking

When reaching the head of an uncontended queue on the qspinlock slow-path,
using a try_cmpxchg() instead of a cmpxchg() operation to transition the
lock work to _Q_LOCKED_VAL generates slightly better code for x86 and
pretty much identical code for arm64.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-13-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 956a12983bd0..46813185957b 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -467,16 +467,15 @@ locked:
 	 * Otherwise, we only need to grab the lock.
 	 */
 
-	/* In the PV case we might already have _Q_LOCKED_VAL set */
-	if ((val & _Q_TAIL_MASK) == tail) {
-		/*
-		 * The atomic_cond_read_acquire() call above has provided the
-		 * necessary acquire semantics required for locking.
-		 */
-		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
-		if (old == val)
-			goto release; /* No contention */
-	}
+	/*
+	 * In the PV case we might already have _Q_LOCKED_VAL set.
+	 *
+	 * The atomic_cond_read_acquire() call above has provided the
+	 * necessary acquire semantics required for locking.
+	 */
+	if (((val & _Q_TAIL_MASK) == tail) &&
+	    atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+		goto release; /* No contention */
 
 	/* Either somebody is queued behind us or _Q_PENDING_VAL is set */
 	set_locked(lock);
