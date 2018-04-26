Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755771AbeDZKhz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:37:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51046 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754932AbeDZKeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:34:10 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com, will.deacon@arm.com
Subject: [PATCH v3 05/14] locking/qspinlock: Remove unbounded cmpxchg loop from locking slowpath
Date: Thu, 26 Apr 2018 11:34:19 +0100
Message-Id: <1524738868-31318-6-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qspinlock locking slowpath utilises a "pending" bit as a simple form
of an embedded test-and-set lock that can avoid the overhead of explicit
queuing in cases where the lock is held but uncontended. This bit is
managed using a cmpxchg loop which tries to transition the uncontended
lock word from (0,0,0) -> (0,0,1) or (0,0,1) -> (0,1,1).

Unfortunately, the cmpxchg loop is unbounded and lockers can be starved
indefinitely if the lock word is seen to oscillate between unlocked
(0,0,0) and locked (0,0,1). This could happen if concurrent lockers are
able to take the lock in the cmpxchg loop without queuing and pass it
around amongst themselves.

This patch fixes the problem by unconditionally setting _Q_PENDING_VAL
using atomic_fetch_or, and then inspecting the old value to see whether
we need to spin on the current lock owner, or whether we now effectively
hold the lock. The tricky scenario is when concurrent lockers end up
queuing on the lock and the lock becomes available, causing us to see
a lockword of (n,0,0). With pending now set, simply queuing could lead
to deadlock as the head of the queue may not have observed the pending
flag being cleared. Conversely, if the head of the queue did observe
pending being cleared, then it could transition the lock from (n,0,0) ->
(0,0,1) meaning that any attempt to "undo" our setting of the pending
bit could race with a concurrent locker trying to set it.

We handle this race by preserving the pending bit when taking the lock
after reaching the head of the queue and leaving the tail entry intact
if we saw pending set, because we know that the tail is going to be
updated shortly.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c          | 102 ++++++++++++++++++++----------------
 kernel/locking/qspinlock_paravirt.h |   5 --
 2 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index a0f7976348f8..ad94b7def005 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -128,6 +128,17 @@ static inline __pure struct mcs_spinlock *decode_tail(u32 tail)
 
 #if _Q_PENDING_BITS == 8
 /**
+ * clear_pending - clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,* -> *,0,*
+ */
+static __always_inline void clear_pending(struct qspinlock *lock)
+{
+	WRITE_ONCE(lock->pending, 0);
+}
+
+/**
  * clear_pending_set_locked - take ownership and clear the pending bit.
  * @lock: Pointer to queued spinlock structure
  *
@@ -163,6 +174,17 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 #else /* _Q_PENDING_BITS == 8 */
 
 /**
+ * clear_pending - clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,* -> *,0,*
+ */
+static __always_inline void clear_pending(struct qspinlock *lock)
+{
+	atomic_andnot(_Q_PENDING_VAL, &lock->val);
+}
+
+/**
  * clear_pending_set_locked - take ownership and clear the pending bit.
  * @lock: Pointer to queued spinlock structure
  *
@@ -266,7 +288,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
-	u32 new, old, tail;
+	u32 old, tail;
 	int idx;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
@@ -290,58 +312,50 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	}
 
 	/*
+	 * If we observe any contention; queue.
+	 */
+	if (val & ~_Q_LOCKED_MASK)
+		goto queue;
+
+	/*
 	 * trylock || pending
 	 *
 	 * 0,0,0 -> 0,0,1 ; trylock
 	 * 0,0,1 -> 0,1,1 ; pending
 	 */
-	for (;;) {
+	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+	if (!(val & ~_Q_LOCKED_MASK)) {
 		/*
-		 * If we observe any contention; queue.
+		 * we're pending, wait for the owner to go away.
+		 *
+		 * *,1,1 -> *,1,0
+		 *
+		 * this wait loop must be a load-acquire such that we match the
+		 * store-release that clears the locked bit and create lock
+		 * sequentiality; this is because not all
+		 * clear_pending_set_locked() implementations imply full
+		 * barriers.
 		 */
-		if (val & ~_Q_LOCKED_MASK)
-			goto queue;
-
-		new = _Q_LOCKED_VAL;
-		if (val == new)
-			new |= _Q_PENDING_VAL;
+		if (val & _Q_LOCKED_MASK) {
+			smp_cond_load_acquire(&lock->val.counter,
+					      !(VAL & _Q_LOCKED_MASK));
+		}
 
 		/*
-		 * Acquire semantic is required here as the function may
-		 * return immediately if the lock was free.
+		 * take ownership and clear the pending bit.
+		 *
+		 * *,1,0 -> *,0,1
 		 */
-		old = atomic_cmpxchg_acquire(&lock->val, val, new);
-		if (old == val)
-			break;
-
-		val = old;
-	}
-
-	/*
-	 * we won the trylock
-	 */
-	if (new == _Q_LOCKED_VAL)
+		clear_pending_set_locked(lock);
 		return;
+	}
 
 	/*
-	 * we're pending, wait for the owner to go away.
-	 *
-	 * *,1,1 -> *,1,0
-	 *
-	 * this wait loop must be a load-acquire such that we match the
-	 * store-release that clears the locked bit and create lock
-	 * sequentiality; this is because not all clear_pending_set_locked()
-	 * implementations imply full barriers.
-	 */
-	smp_cond_load_acquire(&lock->val.counter, !(VAL & _Q_LOCKED_MASK));
-
-	/*
-	 * take ownership and clear the pending bit.
-	 *
-	 * *,1,0 -> *,0,1
+	 * If pending was clear but there are waiters in the queue, then
+	 * we need to undo our setting of pending before we queue ourselves.
 	 */
-	clear_pending_set_locked(lock);
-	return;
+	if (!(val & _Q_PENDING_MASK))
+		clear_pending(lock);
 
 	/*
 	 * End of pending bit optimistic spinning and beginning of MCS
@@ -445,15 +459,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * claim the lock:
 	 *
 	 * n,0,0 -> 0,0,1 : lock, uncontended
-	 * *,0,0 -> *,0,1 : lock, contended
+	 * *,*,0 -> *,*,1 : lock, contended
 	 *
-	 * If the queue head is the only one in the queue (lock value == tail),
-	 * clear the tail code and grab the lock. Otherwise, we only need
-	 * to grab the lock.
+	 * If the queue head is the only one in the queue (lock value == tail)
+	 * and nobody is pending, clear the tail code and grab the lock.
+	 * Otherwise, we only need to grab the lock.
 	 */
 	for (;;) {
 		/* In the PV case we might already have _Q_LOCKED_VAL set */
-		if ((val & _Q_TAIL_MASK) != tail) {
+		if ((val & _Q_TAIL_MASK) != tail || (val & _Q_PENDING_MASK)) {
 			set_locked(lock);
 			break;
 		}
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 2711940429f5..2dbad2f25480 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -118,11 +118,6 @@ static __always_inline void set_pending(struct qspinlock *lock)
 	WRITE_ONCE(lock->pending, 1);
 }
 
-static __always_inline void clear_pending(struct qspinlock *lock)
-{
-	WRITE_ONCE(lock->pending, 0);
-}
-
 /*
  * The pending bit check in pv_queued_spin_steal_lock() isn't a memory
  * barrier. Therefore, an atomic cmpxchg_acquire() is used to acquire the
-- 
2.1.4
