Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeDISJX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:09:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751676AbeDISJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:09:21 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        boqun.feng@gmail.com, catalin.marinas@arm.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] locking/qspinlock: Limit # of spins in _Q_PENDING_VAL wait loop
Date: Mon,  9 Apr 2018 14:08:52 -0400
Message-Id: <1523297332-22720-2-git-send-email-longman@redhat.com>
In-Reply-To: <1523297332-22720-1-git-send-email-longman@redhat.com>
References: <1523297332-22720-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A locker in the pending code path is doing an infinite number of spins
when waiting for the _Q_PENDING_VAL to _Q_LOCK_VAL transition. There
is a concern that lock starvation can happen concurrent lockers are
able to take the lock in the cmpxchg loop without queuing and pass it
around amongst themselves.

To ensure forward progress while still taking advantage of using
the pending code path without queuing, the code is now modified
to do a limited number of spins before aborting the effort and
going to queue itself.

Ideally, the spinning times should be at least a few times the typical
cacheline load time from memory which I think can be down to 100ns or
so for each cacheline load with the newest systems or up to several
hundreds ns for older systems.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 634a49b..35367cc 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -82,6 +82,15 @@
 #endif
 
 /*
+ * The pending bit spinning loop count.
+ * This parameter can be overridden by another architecture specific
+ * constant. Default is 512.
+ */
+#ifndef _Q_PENDING_LOOP
+#define _Q_PENDING_LOOP	(1 << 9)
+#endif
+
+/*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
  *
@@ -311,13 +320,19 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		return;
 
 	/*
-	 * wait for in-progress pending->locked hand-overs
+	 * wait for in-progress pending->locked hand-overs with a
+	 * limited number of spins.
 	 *
 	 * 0,1,0 -> 0,0,1
 	 */
 	if (val == _Q_PENDING_VAL) {
-		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
+		int cnt = _Q_PENDING_LOOP;
+
+		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL) {
+			if (!--cnt)
+				goto queue;
 			cpu_relax();
+		}
 	}
 
 	/*
-- 
1.8.3.1
