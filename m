Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5991C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A25A20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298790;
	bh=UbNsHsbYJVbOmpI+pe4996Tja8FvHzTIrhaqSPBg9OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rQN2Vxn+rCSzmkIER/TiONKkKlT3sHEc8ZHPvwhbOLtUhn4IYdDKABElnrMZbS2KD
	 7r3uRipWrkrb6+jI5zJORj+4Mg5VrTiezvoclpoFh0huPpWDxbA7PWph4cYOUWoF+J
	 77klJXlADAYTpddJXQvWzHg9BH/0YSzQI1o1pUxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbeLTJZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbeLTJZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665E5217D9;
        Thu, 20 Dec 2018 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297906;
        bh=UbNsHsbYJVbOmpI+pe4996Tja8FvHzTIrhaqSPBg9OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPc2wIWLb4fcskJvPUlTn4YEUYgMjeRfr9HDDJPv6Lir1859cQIed/eHSgcfCUgtG
         2Jsf7UM7scD95ckxCt6SikLf1KioQI70+YpTSRe2CzwR+KP+xZd/6xEgNbhD0TgbZC
         6JmoSTMiKL26evLEyP6joRyrr+HD3r0ZmV5RxjN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, boqun.feng@gmail.com,
        linux-arm-kernel@lists.infradead.org, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 24/61] locking/qspinlock: Remove unbounded cmpxchg() loop from locking slowpath
Date:   Thu, 20 Dec 2018 10:18:24 +0100
Message-Id: <20181220085844.710354700@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 59fb586b4a07b4e1a0ee577140ab4842ba451acd upstream.

The qspinlock locking slowpath utilises a "pending" bit as a simple form
of an embedded test-and-set lock that can avoid the overhead of explicit
queuing in cases where the lock is held but uncontended. This bit is
managed using a cmpxchg() loop which tries to transition the uncontended
lock word from (0,0,0) -> (0,0,1) or (0,0,1) -> (0,1,1).

Unfortunately, the cmpxchg() loop is unbounded and lockers can be starved
indefinitely if the lock word is seen to oscillate between unlocked
(0,0,0) and locked (0,0,1). This could happen if concurrent lockers are
able to take the lock in the cmpxchg() loop without queuing and pass it
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

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-6-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/qspinlock.c          | 102 ++++++++++++++++------------
 kernel/locking/qspinlock_paravirt.h |   5 --
 2 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cc98050e8bec..e7ab99a1f438 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -126,6 +126,17 @@ static inline __pure struct mcs_spinlock *decode_tail(u32 tail)
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
 
 #if _Q_PENDING_BITS == 8
+/**
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
 /**
  * clear_pending_set_locked - take ownership and clear the pending bit.
  * @lock: Pointer to queued spinlock structure
@@ -161,6 +172,17 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 
 #else /* _Q_PENDING_BITS == 8 */
 
+/**
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
 /**
  * clear_pending_set_locked - take ownership and clear the pending bit.
  * @lock: Pointer to queued spinlock structure
@@ -382,7 +404,7 @@ EXPORT_SYMBOL(queued_spin_unlock_wait);
 void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
-	u32 new, old, tail;
+	u32 old, tail;
 	int idx;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
@@ -405,59 +427,51 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 					       (VAL != _Q_PENDING_VAL) || !cnt--);
 	}
 
+	/*
+	 * If we observe any contention; queue.
+	 */
+	if (val & ~_Q_LOCKED_MASK)
+		goto queue;
+
 	/*
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
+		 * We're pending, wait for the owner to go away.
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
@@ -561,15 +575,15 @@ locked:
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
index 3e33336911ff..9c07c72fb10e 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -88,11 +88,6 @@ static __always_inline void set_pending(struct qspinlock *lock)
 	WRITE_ONCE(lock->pending, 1);
 }
 
-static __always_inline void clear_pending(struct qspinlock *lock)
-{
-	WRITE_ONCE(lock->pending, 0);
-}
-
 /*
  * The pending bit check in pv_queued_spin_steal_lock() isn't a memory
  * barrier. Therefore, an atomic cmpxchg() is used to acquire the lock
-- 
2.19.1



