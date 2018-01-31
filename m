Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeAaMU5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:20:57 -0500
Received: from foss.arm.com ([217.140.101.70]:37426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbeAaMU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:20:56 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] locking/qspinlock: Ensure node is initialised before updating prev->next
Date: Wed, 31 Jan 2018 12:20:46 +0000
Message-Id: <1517401246-2750-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a locker ends up queuing on the qspinlock locking slowpath, we
initialise the relevant mcs node and publish it indirectly by updating
the tail portion of the lock word using xchg_tail. If we find that there
was a pre-existing locker in the queue, we subsequently update their
->next field to point at our node so that we are notified when it's our
turn to take the lock.

This can be roughly illustrated as follows:

  /* Initialise the fields in node and encode a pointer to node in tail */
  tail = initialise_node(node);

  /*
   * Exchange tail into the lockword using an atomic read-modify-write
   * operation with release semantics
   */
  old = xchg_tail(lock, tail);

  /* If there was a pre-existing waiter ... */
  if (old & _Q_TAIL_MASK) {
	prev = decode_tail(old);
	smp_read_barrier_depends();

	/* ... then update their ->next field to point to node.
	WRITE_ONCE(prev->next, node);
  }

The conditional update of prev->next therefore relies on the address
dependency from the result of xchg_tail ensuring order against the
prior initialisation of node. However, since the release semantics of
the xchg_tail operation apply only to the write portion of the RmW,
then this ordering is not guaranteed and it is possible for the CPU
to return old before the writes to node have been published, consequently
allowing us to point prev->next to an uninitialised node.

This patch fixes the problem by making the update of prev->next a RELEASE
operation, which also removes the reliance on dependency ordering.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 294294c71ba4..1ebbc366a31d 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -408,16 +408,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 */
 	if (old & _Q_TAIL_MASK) {
 		prev = decode_tail(old);
+
 		/*
-		 * The above xchg_tail() is also a load of @lock which generates,
-		 * through decode_tail(), a pointer.
-		 *
-		 * The address dependency matches the RELEASE of xchg_tail()
-		 * such that the access to @prev must happen after.
+		 * We must ensure that the stores to @node are observed before
+		 * the write to prev->next. The address dependency on xchg_tail
+		 * is not sufficient to ensure this because the read component
+		 * of xchg_tail is unordered with respect to the initialisation
+		 * of node.
 		 */
-		smp_read_barrier_depends();
-
-		WRITE_ONCE(prev->next, node);
+		smp_store_release(prev->next, node);
 
 		pv_wait_node(node, prev);
 		arch_mcs_spin_lock_contended(&node->locked);
-- 
2.1.4
