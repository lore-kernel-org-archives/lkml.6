Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15B6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A378B20989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298710;
	bh=Z8M1l/y9REiXZAWKjKa2E7LcnPn+MPKkomdbNdFqe0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P3J3LumxdQdL2GarUG3ebaezb9+KkUBKdF1S6AL1nlj7WTSvjmbTe5skRTEU21NwG
	 88mQCyzxXGQzz3KiAoQcSKZ+4l8+jJXb53EXqgf//Ns6a1RIb0/egMfOcDf+t33Eo2
	 dP9HNQJT9DLy+dxx4lJJsFlhmFMJeTSeW18KZHM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733311AbeLTJi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732050AbeLTJ0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:26:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B9F92186A;
        Thu, 20 Dec 2018 09:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297971;
        bh=Z8M1l/y9REiXZAWKjKa2E7LcnPn+MPKkomdbNdFqe0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfhCIjeRN6umKOyKJ7K73C8GouBJj+XwZ7BoobZR7I3fPhXirIeJLlds62OMRjFQD
         7ilPz+PKY2WiVG4II6E6rshz8gzLX1Na6Rf9lT2BDZosJAEo/Jjxe55C0FphvC51KB
         qW9arnRo4y3heIXAl/BChgYXulnd9nhFc8g5fkAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 23/72] locking/qspinlock: Merge struct __qspinlock into struct qspinlock
Date:   Thu, 20 Dec 2018 10:18:22 +0100
Message-Id: <20181220085923.251181210@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 625e88be1f41b53cec55827c984e4a89ea8ee9f9 upstream.

'struct __qspinlock' provides a handy union of fields so that
subcomponents of the lockword can be accessed by name, without having to
manage shifts and masks explicitly and take endianness into account.

This is useful in qspinlock.h and also potentially in arch headers, so
move the 'struct __qspinlock' into 'struct qspinlock' and kill the extra
definition.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-3-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/qspinlock.h          |  2 +-
 arch/x86/include/asm/qspinlock_paravirt.h |  3 +-
 include/asm-generic/qspinlock_types.h     | 32 +++++++++++++++-
 kernel/locking/qspinlock.c                | 46 ++---------------------
 kernel/locking/qspinlock_paravirt.h       | 34 ++++++-----------
 5 files changed, 46 insertions(+), 71 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 9982dd96f093..cf4cdf508ef4 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -15,7 +15,7 @@
  */
 static inline void native_queued_spin_unlock(struct qspinlock *lock)
 {
-	smp_store_release((u8 *)lock, 0);
+	smp_store_release(&lock->locked, 0);
 }
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 923307ea11c7..9ef5ee03d2d7 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -22,8 +22,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
  *
  * void __pv_queued_spin_unlock(struct qspinlock *lock)
  * {
- *	struct __qspinlock *l = (void *)lock;
- *	u8 lockval = cmpxchg(&l->locked, _Q_LOCKED_VAL, 0);
+ *	u8 lockval = cmpxchg(&lock->locked, _Q_LOCKED_VAL, 0);
  *
  *	if (likely(lockval == _Q_LOCKED_VAL))
  *		return;
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 034acd0c4956..0763f065b975 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -29,13 +29,41 @@
 #endif
 
 typedef struct qspinlock {
-	atomic_t	val;
+	union {
+		atomic_t val;
+
+		/*
+		 * By using the whole 2nd least significant byte for the
+		 * pending bit, we can allow better optimization of the lock
+		 * acquisition for the pending bit holder.
+		 */
+#ifdef __LITTLE_ENDIAN
+		struct {
+			u8	locked;
+			u8	pending;
+		};
+		struct {
+			u16	locked_pending;
+			u16	tail;
+		};
+#else
+		struct {
+			u16	tail;
+			u16	locked_pending;
+		};
+		struct {
+			u8	reserved[2];
+			u8	pending;
+			u8	locked;
+		};
+#endif
+	};
 } arch_spinlock_t;
 
 /*
  * Initializier
  */
-#define	__ARCH_SPIN_LOCK_UNLOCKED	{ ATOMIC_INIT(0) }
+#define	__ARCH_SPIN_LOCK_UNLOCKED	{ .val = ATOMIC_INIT(0) }
 
 /*
  * Bitfields in the atomic value:
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 18161264227a..e60e618287b4 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -126,40 +126,6 @@ static inline __pure struct mcs_spinlock *decode_tail(u32 tail)
 
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
 
-/*
- * By using the whole 2nd least significant byte for the pending bit, we
- * can allow better optimization of the lock acquisition for the pending
- * bit holder.
- *
- * This internal structure is also used by the set_locked function which
- * is not restricted to _Q_PENDING_BITS == 8.
- */
-struct __qspinlock {
-	union {
-		atomic_t val;
-#ifdef __LITTLE_ENDIAN
-		struct {
-			u8	locked;
-			u8	pending;
-		};
-		struct {
-			u16	locked_pending;
-			u16	tail;
-		};
-#else
-		struct {
-			u16	tail;
-			u16	locked_pending;
-		};
-		struct {
-			u8	reserved[2];
-			u8	pending;
-			u8	locked;
-		};
-#endif
-	};
-};
-
 #if _Q_PENDING_BITS == 8
 /**
  * clear_pending_set_locked - take ownership and clear the pending bit.
@@ -171,9 +137,7 @@ struct __qspinlock {
  */
 static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
-	WRITE_ONCE(l->locked_pending, _Q_LOCKED_VAL);
+	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
 }
 
 /*
@@ -188,13 +152,11 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
  */
 static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 {
-	struct __qspinlock *l = (void *)lock;
-
 	/*
 	 * Use release semantics to make sure that the MCS node is properly
 	 * initialized before changing the tail code.
 	 */
-	return (u32)xchg_release(&l->tail,
+	return (u32)xchg_release(&lock->tail,
 				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
 }
 
@@ -249,9 +211,7 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
  */
 static __always_inline void set_locked(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
-	WRITE_ONCE(l->locked, _Q_LOCKED_VAL);
+	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
 }
 
 
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 15b6a39366c6..1435ba7954c3 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -70,10 +70,8 @@ struct pv_node {
 #define queued_spin_trylock(l)	pv_queued_spin_steal_lock(l)
 static inline bool pv_queued_spin_steal_lock(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
 	if (!(atomic_read(&lock->val) & _Q_LOCKED_PENDING_MASK) &&
-	    (cmpxchg_acquire(&l->locked, 0, _Q_LOCKED_VAL) == 0)) {
+	    (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
 		qstat_inc(qstat_pv_lock_stealing, true);
 		return true;
 	}
@@ -88,16 +86,12 @@ static inline bool pv_queued_spin_steal_lock(struct qspinlock *lock)
 #if _Q_PENDING_BITS == 8
 static __always_inline void set_pending(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
-	WRITE_ONCE(l->pending, 1);
+	WRITE_ONCE(lock->pending, 1);
 }
 
 static __always_inline void clear_pending(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
-	WRITE_ONCE(l->pending, 0);
+	WRITE_ONCE(lock->pending, 0);
 }
 
 /*
@@ -107,10 +101,8 @@ static __always_inline void clear_pending(struct qspinlock *lock)
  */
 static __always_inline int trylock_clear_pending(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
-	return !READ_ONCE(l->locked) &&
-	       (cmpxchg_acquire(&l->locked_pending, _Q_PENDING_VAL,
+	return !READ_ONCE(lock->locked) &&
+	       (cmpxchg_acquire(&lock->locked_pending, _Q_PENDING_VAL,
 				_Q_LOCKED_VAL) == _Q_PENDING_VAL);
 }
 #else /* _Q_PENDING_BITS == 8 */
@@ -355,7 +347,6 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-	struct __qspinlock *l = (void *)lock;
 
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
@@ -384,7 +375,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * the hash table later on at unlock time, no atomic instruction is
 	 * needed.
 	 */
-	WRITE_ONCE(l->locked, _Q_SLOW_VAL);
+	WRITE_ONCE(lock->locked, _Q_SLOW_VAL);
 	(void)pv_hash(lock, pn);
 }
 
@@ -399,7 +390,6 @@ static u32
 pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-	struct __qspinlock *l = (void *)lock;
 	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
 	int loop;
@@ -450,13 +440,13 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 			 *
 			 * Matches the smp_rmb() in __pv_queued_spin_unlock().
 			 */
-			if (xchg(&l->locked, _Q_SLOW_VAL) == 0) {
+			if (xchg(&lock->locked, _Q_SLOW_VAL) == 0) {
 				/*
 				 * The lock was free and now we own the lock.
 				 * Change the lock value back to _Q_LOCKED_VAL
 				 * and unhash the table.
 				 */
-				WRITE_ONCE(l->locked, _Q_LOCKED_VAL);
+				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
 				WRITE_ONCE(*lp, NULL);
 				goto gotlock;
 			}
@@ -464,7 +454,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 		WRITE_ONCE(pn->state, vcpu_hashed);
 		qstat_inc(qstat_pv_wait_head, true);
 		qstat_inc(qstat_pv_wait_again, waitcnt);
-		pv_wait(&l->locked, _Q_SLOW_VAL);
+		pv_wait(&lock->locked, _Q_SLOW_VAL);
 
 		/*
 		 * Because of lock stealing, the queue head vCPU may not be
@@ -489,7 +479,6 @@ gotlock:
 __visible void
 __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 {
-	struct __qspinlock *l = (void *)lock;
 	struct pv_node *node;
 
 	if (unlikely(locked != _Q_SLOW_VAL)) {
@@ -518,7 +507,7 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 	 * Now that we have a reference to the (likely) blocked pv_node,
 	 * release the lock.
 	 */
-	smp_store_release(&l->locked, 0);
+	smp_store_release(&lock->locked, 0);
 
 	/*
 	 * At this point the memory pointed at by lock can be freed/reused,
@@ -544,7 +533,6 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 #ifndef __pv_queued_spin_unlock
 __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
 	u8 locked;
 
 	/*
@@ -552,7 +540,7 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 	 * unhash. Otherwise it would be possible to have multiple @lock
 	 * entries, which would be BAD.
 	 */
-	locked = cmpxchg_release(&l->locked, _Q_LOCKED_VAL, 0);
+	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
 	if (likely(locked == _Q_LOCKED_VAL))
 		return;
 
-- 
2.19.1



