Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932549AbeD0JmZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:42:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57267 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbeD0JmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:42:23 -0400
Date: Fri, 27 Apr 2018 02:42:00 -0700
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-626e5fbc14358901ddaa90ce510e0fbeab310432@git.kernel.org>
Cc: will.deacon@arm.com, torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, longman@redhat.com, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, will.deacon@arm.com,
        longman@redhat.com, tglx@linutronix.de, peterz@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <1524738868-31318-11-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-11-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock: Use smp_store_release() in
 queued_spin_unlock()
Git-Commit-ID: 626e5fbc14358901ddaa90ce510e0fbeab310432
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

Commit-ID:  626e5fbc14358901ddaa90ce510e0fbeab310432
Gitweb:     https://git.kernel.org/tip/626e5fbc14358901ddaa90ce510e0fbeab310432
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Thu, 26 Apr 2018 11:34:24 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 27 Apr 2018 09:48:51 +0200

locking/qspinlock: Use smp_store_release() in queued_spin_unlock()

A qspinlock can be unlocked simply by writing zero to the locked byte.
This can be implemented in the generic code, so do that and remove the
arch-specific override for x86 in the !PV case.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-11-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
 
