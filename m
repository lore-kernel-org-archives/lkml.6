Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755661AbeDZKf0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:35:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51150 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755235AbeDZKeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:34:11 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com, will.deacon@arm.com
Subject: [PATCH v3 11/14] locking/qspinlock: Elide back-to-back RELEASE operations with smp_wmb()
Date: Thu, 26 Apr 2018 11:34:25 +0100
Message-Id: <1524738868-31318-12-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qspinlock slowpath must ensure that the MCS node is fully initialised
before it can be reached by another other CPU. This is currently enforced
by using a RELEASE operation when updating the tail and also when linking
the node into the waitqueue (since the control dependency off xchg_tail
is insufficient to enforce sufficient ordering -- see 95bcade33a8a
("locking/qspinlock: Ensure node is initialised before updating prev->next")).

Back-to-back RELEASE operations may be expensive on some architectures,
particularly those that implement them using fences under the hood. We
can replace the two RELEASE operations with a single smp_wmb() fence and
use RELAXED operations for the subsequent publishing of the node.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 7b8c81ebb15e..fa5d2ab369f9 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -164,10 +164,10 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 {
 	/*
-	 * Use release semantics to make sure that the MCS node is properly
-	 * initialized before changing the tail code.
+	 * We can use relaxed semantics since the caller ensures that the
+	 * MCS node is properly initialized before updating the tail.
 	 */
-	return (u32)xchg_release(&lock->tail,
+	return (u32)xchg_relaxed(&lock->tail,
 				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
 }
 
@@ -212,10 +212,11 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 	for (;;) {
 		new = (val & _Q_LOCKED_PENDING_MASK) | tail;
 		/*
-		 * Use release semantics to make sure that the MCS node is
-		 * properly initialized before changing the tail code.
+		 * We can use relaxed semantics since the caller ensures that
+		 * the MCS node is properly initialized before updating the
+		 * tail.
 		 */
-		old = atomic_cmpxchg_release(&lock->val, val, new);
+		old = atomic_cmpxchg_relaxed(&lock->val, val, new);
 		if (old == val)
 			break;
 
@@ -388,12 +389,18 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		goto release;
 
 	/*
+	 * Ensure that the initialisation of @node is complete before we
+	 * publish the updated tail via xchg_tail() and potentially link
+	 * @node into the waitqueue via WRITE_ONCE(prev->next, node) below.
+	 */
+	smp_wmb();
+
+	/*
+	 * Publish the updated tail.
 	 * We have already touched the queueing cacheline; don't bother with
 	 * pending stuff.
 	 *
 	 * p,*,* -> n,*,*
-	 *
-	 * RELEASE, such that the stores to @node must be complete.
 	 */
 	old = xchg_tail(lock, tail);
 	next = NULL;
@@ -405,14 +412,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (old & _Q_TAIL_MASK) {
 		prev = decode_tail(old);
 
-		/*
-		 * We must ensure that the stores to @node are observed before
-		 * the write to prev->next. The address dependency from
-		 * xchg_tail is not sufficient to ensure this because the read
-		 * component of xchg_tail is unordered with respect to the
-		 * initialisation of @node.
-		 */
-		smp_store_release(&prev->next, node);
+		/* Link @node into the waitqueue. */
+		WRITE_ONCE(prev->next, node);
 
 		pv_wait_node(node, prev);
 		arch_mcs_spin_lock_contended(&node->locked);
-- 
2.1.4
