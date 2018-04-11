Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754103AbeDKSC4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 14:02:56 -0400
Received: from foss.arm.com ([217.140.101.70]:52152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752662AbeDKSBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:01:07 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 10/13] locking/qspinlock: Make queued_spin_unlock use smp_store_release
Date: Wed, 11 Apr 2018 19:01:17 +0100
Message-Id: <1523469680-17699-11-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A qspinlock can be unlocked simply by writing zero to the locked byte.
This can be implemented in the generic code, so do that and remove the
arch-specific override for x86 in the !PV case.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/x86/include/asm/qspinlock.h | 17 ++++++-----------
 include/asm-generic/qspinlock.h  |  2 +-
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index da1370ad206d..3e70bed8a978 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -9,6 +9,12 @@
 
 #define _Q_PENDING_LOOPS	(1 << 9)
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __pv_init_lock_hash(void);
+extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
+
 #define	queued_spin_unlock queued_spin_unlock
 /**
  * queued_spin_unlock - release a queued spinlock
@@ -21,12 +27,6 @@ static inline void native_queued_spin_unlock(struct qspinlock *lock)
 	smp_store_release(&lock->locked, 0);
 }
 
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
-extern void __pv_init_lock_hash(void);
-extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
-extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
-
 static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	pv_queued_spin_lock_slowpath(lock, val);
@@ -42,11 +42,6 @@ static inline bool vcpu_is_preempted(long cpu)
 {
 	return pv_vcpu_is_preempted(cpu);
 }
-#else
-static inline void queued_spin_unlock(struct qspinlock *lock)
-{
-	native_queued_spin_unlock(lock);
-}
 #endif
 
 #ifdef CONFIG_PARAVIRT
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index b37b4ad7eb94..a8ed0a352d75 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -100,7 +100,7 @@ static __always_inline void queued_spin_unlock(struct qspinlock *lock)
 	/*
 	 * unlock() needs release semantics:
 	 */
-	(void)atomic_sub_return_release(_Q_LOCKED_VAL, &lock->val);
+	smp_store_release(&lock->locked, 0);
 }
 #endif
 
-- 
2.1.4
