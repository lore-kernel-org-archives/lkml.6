Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4A0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58B0222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991775;
	bh=3ODwQmsQZ/PTQOMOOxTM8MwMaGc93ITBMD0mk0bJmQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=105gh9d8EgDEM1c4/Su+wMCA9MKCXyXCSc+x8IJDOy1wLSeZSkl8kbhGH3rucH4SI
	 PbbK+hhm4BZp8tPPOOs21GUUOOPxYIBSX+KI9S5lTrgaShuIL1nMeojnjV5JY8gv3F
	 or4gdjbah/JBXP+eMSYB5Dx1c69m+4dlVD+J1Y8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfBLRQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731650AbfBLRQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:12 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE303222BD;
        Tue, 12 Feb 2019 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991770;
        bh=3ODwQmsQZ/PTQOMOOxTM8MwMaGc93ITBMD0mk0bJmQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uX0k/d06pHjt0+QVfqKzcYAh6BF5EkPc9bldo2JUlDvXyocUyKffEaf4JvxXPHwoZ
         NZeyINbE7NO002lpxxjZvNqT8gEK5brBcnvl6m/MJBZYOgomnqq9p3AAsHoNdud+FD
         pZnhmZ73nZRYJF7zwG/NY8wAlwPnIXRxZbKYu4zE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 31/32] locking: Introduce spin_[un]lock_bh_mask()
Date:   Tue, 12 Feb 2019 18:14:22 +0100
Message-Id: <20190212171423.8308-32-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It allows us to extend the coverage of vector finegrained masking
throughout softirq safe locking. This is especially interesting with
networking that makes extensive use of it.

It works the same way as local_bh_disable_mask():

    bh = spin_lock_bh_mask(lock, BIT(NET_RX_SOFTIRQ));
    [...]
    spin_unlock_bh_mask(lock, bh);

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/spinlock.h         | 14 ++++++++++++++
 include/linux/spinlock_api_smp.h | 26 ++++++++++++++++++++++++++
 include/linux/spinlock_api_up.h  | 13 +++++++++++++
 kernel/locking/spinlock.c        | 19 +++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index e089157dcf97..57dd73ed202d 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -270,6 +270,7 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 
 #define raw_spin_lock_irq(lock)		_raw_spin_lock_irq(lock)
 #define raw_spin_lock_bh(lock)		_raw_spin_lock_bh(lock)
+#define raw_spin_lock_bh_mask(lock, mask)	_raw_spin_lock_bh_mask(lock, mask)
 #define raw_spin_unlock(lock)		_raw_spin_unlock(lock)
 #define raw_spin_unlock_irq(lock)	_raw_spin_unlock_irq(lock)
 
@@ -279,6 +280,7 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 		_raw_spin_unlock_irqrestore(lock, flags);	\
 	} while (0)
 #define raw_spin_unlock_bh(lock)	_raw_spin_unlock_bh(lock)
+#define raw_spin_unlock_bh_mask(lock, mask)	_raw_spin_unlock_bh_mask(lock, mask)
 
 #define raw_spin_trylock_bh(lock) \
 	__cond_lock(lock, _raw_spin_trylock_bh(lock))
@@ -334,6 +336,12 @@ static __always_inline void spin_lock_bh(spinlock_t *lock)
 	raw_spin_lock_bh(&lock->rlock);
 }
 
+static __always_inline unsigned int spin_lock_bh_mask(spinlock_t *lock,
+						      unsigned int mask)
+{
+	return raw_spin_lock_bh_mask(&lock->rlock, mask);
+}
+
 static __always_inline int spin_trylock(spinlock_t *lock)
 {
 	return raw_spin_trylock(&lock->rlock);
@@ -374,6 +382,12 @@ static __always_inline void spin_unlock_bh(spinlock_t *lock)
 	raw_spin_unlock_bh(&lock->rlock);
 }
 
+static __always_inline void spin_unlock_bh_mask(spinlock_t *lock,
+						unsigned int mask)
+{
+	raw_spin_unlock_bh_mask(&lock->rlock, mask);
+}
+
 static __always_inline void spin_unlock_irq(spinlock_t *lock)
 {
 	raw_spin_unlock_irq(&lock->rlock);
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 42dfab89e740..987ecc1e3bc3 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -26,6 +26,8 @@ void __lockfunc
 _raw_spin_lock_nest_lock(raw_spinlock_t *lock, struct lockdep_map *map)
 								__acquires(lock);
 void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)		__acquires(lock);
+unsigned int __lockfunc
+_raw_spin_lock_bh_mask(raw_spinlock_t *lock, unsigned int mask)	__acquires(lock);
 void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
 								__acquires(lock);
 
@@ -38,6 +40,9 @@ int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock);
 int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock);
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)		__releases(lock);
 void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)	__releases(lock);
+void __lockfunc
+_raw_spin_unlock_bh_mask(raw_spinlock_t *lock, unsigned int mask)
+								__releases(lock);
 void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)	__releases(lock);
 void __lockfunc
 _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
@@ -136,6 +141,19 @@ static inline void __raw_spin_lock_bh(raw_spinlock_t *lock)
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 }
 
+static inline unsigned int __raw_spin_lock_bh_mask(raw_spinlock_t *lock,
+						   unsigned int mask)
+{
+	unsigned int old_mask;
+
+	old_mask = local_bh_disable_mask(_RET_IP_, SOFTIRQ_LOCK_OFFSET, mask);
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
+
+	return old_mask;
+}
+
+
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	preempt_disable();
@@ -176,6 +194,14 @@ static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock)
 	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 }
 
+static inline void __raw_spin_unlock_bh_mask(raw_spinlock_t *lock,
+					     unsigned int mask)
+{
+	spin_release(&lock->dep_map, 1, _RET_IP_);
+	do_raw_spin_unlock(lock);
+	local_bh_enable_mask(_RET_IP_, SOFTIRQ_LOCK_OFFSET, mask);
+}
+
 static inline int __raw_spin_trylock_bh(raw_spinlock_t *lock)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index d0d188861ad6..3bfb7cbbee4e 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -33,6 +33,13 @@
 #define __LOCK_BH(lock) \
   do { __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); ___LOCK(lock); } while (0)
 
+#define __LOCK_BH_MASK(lock, mask) ({							\
+	unsigned int ____old_mask;							\
+	____old_mask = local_bh_disable_mask(_THIS_IP_, SOFTIRQ_LOCK_OFFSET, mask);	\
+	___LOCK(lock);									\
+	____old_mask;
+})
+
 #define __LOCK_IRQ(lock) \
   do { local_irq_disable(); __LOCK(lock); } while (0)
 
@@ -49,6 +56,10 @@
   do { __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); \
        ___UNLOCK(lock); } while (0)
 
+#define __UNLOCK_BH_MASK(lock, mask)				   \
+  do { local_bh_enable_mask(_THIS_IP_, SOFTIRQ_LOCK_OFFSET, mask); \
+       ___UNLOCK(lock); } while (0)
+
 #define __UNLOCK_IRQ(lock) \
   do { local_irq_enable(); __UNLOCK(lock); } while (0)
 
@@ -60,6 +71,7 @@
 #define _raw_read_lock(lock)			__LOCK(lock)
 #define _raw_write_lock(lock)			__LOCK(lock)
 #define _raw_spin_lock_bh(lock)			__LOCK_BH(lock)
+#define _raw_spin_lock_bh_mask(lock, mask)	__LOCK_BH_MASK(lock, mask)
 #define _raw_read_lock_bh(lock)			__LOCK_BH(lock)
 #define _raw_write_lock_bh(lock)		__LOCK_BH(lock)
 #define _raw_spin_lock_irq(lock)		__LOCK_IRQ(lock)
@@ -76,6 +88,7 @@
 #define _raw_read_unlock(lock)			__UNLOCK(lock)
 #define _raw_write_unlock(lock)			__UNLOCK(lock)
 #define _raw_spin_unlock_bh(lock)		__UNLOCK_BH(lock)
+#define _raw_spin_unlock_bh_mask(lock, mask)	__UNLOCK_BH_MASK(lock, mask)
 #define _raw_write_unlock_bh(lock)		__UNLOCK_BH(lock)
 #define _raw_read_unlock_bh(lock)		__UNLOCK_BH(lock)
 #define _raw_spin_unlock_irq(lock)		__UNLOCK_IRQ(lock)
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 936f3d14dd6b..4245cb3cda5a 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -170,6 +170,16 @@ void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_lock_bh);
 #endif
 
+#ifndef CONFIG_INLINE_SPIN_LOCK_BH
+unsigned int __lockfunc _raw_spin_lock_bh_mask(raw_spinlock_t *lock,
+					       unsigned int mask)
+{
+	return __raw_spin_lock_bh_mask(lock, mask);
+}
+EXPORT_SYMBOL(_raw_spin_lock_bh_mask);
+#endif
+
+
 #ifdef CONFIG_UNINLINE_SPIN_UNLOCK
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)
 {
@@ -202,6 +212,15 @@ void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_unlock_bh);
 #endif
 
+#ifndef CONFIG_INLINE_SPIN_UNLOCK_BH
+void __lockfunc _raw_spin_unlock_bh_mask(raw_spinlock_t *lock,
+					 unsigned int mask)
+{
+	__raw_spin_unlock_bh_mask(lock, mask);
+}
+EXPORT_SYMBOL(_raw_spin_unlock_bh_mask);
+#endif
+
 #ifndef CONFIG_INLINE_READ_TRYLOCK
 int __lockfunc _raw_read_trylock(rwlock_t *lock)
 {
-- 
2.17.1

