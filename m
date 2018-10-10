Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807B5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218BD2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSLmLxNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218BD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeJKGiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbeJKGiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:38:11 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12B0321526;
        Wed, 10 Oct 2018 23:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213229;
        bh=QCITUOR/M/rykBCpevVgO29id+sUFV5Be5gnbG9bQK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSLmLxNknAGHteVK2zCZrz4Hkicr6p4wMAzTipETvLE1a8KMOhKNMQiIEqtJkHAtN
         FUlPgSp5C5dk3AeU6Fhtx7wv81vic4YruMd2fpZljbnugsXL1AYFUUh9/nGyrbwtNs
         QMURbMkB70nDBuflPIWibHd2MFIthEI5Sg14rA7Y=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 25/30] softirq: Push down softirq mask to __local_bh_disable_ip()
Date:   Thu, 11 Oct 2018 01:12:12 +0200
Message-Id: <1539213137-13953-26-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all callers are ready, we can push down the softirq enabled
mask to the core from callers such as spin_lock_bh(), local_bh_disable(),
rcu_read_lock_bh(), etc...

It is applied to the CPU vector enabled mask on __local_bh_disable_ip()
which then returns the old value to be restored on __local_bh_enable_ip().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/bottom_half.h      | 19 ++++++++++---------
 include/linux/rwlock_api_smp.h   | 14 ++++++++------
 include/linux/spinlock_api_smp.h | 10 +++++-----
 kernel/softirq.c                 | 28 +++++++++++++++++++---------
 4 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index 31fcdae..f8a68c8 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -37,9 +37,10 @@ enum
 
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
+extern unsigned int __local_bh_disable_ip(unsigned long ip, unsigned int cnt,
+					  unsigned int mask);
 #else
-static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
+static __always_inline unsigned int __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	preempt_count_add(cnt);
 	barrier();
@@ -48,21 +49,21 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
 
 static inline unsigned int local_bh_disable(unsigned int mask)
 {
-	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
-	return 0;
+	return __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET, mask);
 }
 
-extern void local_bh_enable_no_softirq(void);
-extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
+extern void local_bh_enable_no_softirq(unsigned int bh);
+extern void __local_bh_enable_ip(unsigned long ip,
+				 unsigned int cnt, unsigned int bh);
 
-static inline void local_bh_enable_ip(unsigned long ip)
+static inline void local_bh_enable_ip(unsigned long ip, unsigned int bh)
 {
-	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
+	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET, bh);
 }
 
 static inline void local_bh_enable(unsigned int bh)
 {
-	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
+	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET, bh);
 }
 
 extern void local_bh_disable_all(void);
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index fb66489..90ba7bf 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -173,10 +173,11 @@ static inline void __raw_read_lock_irq(rwlock_t *lock)
 static inline unsigned int __raw_read_lock_bh(rwlock_t *lock,
 					      unsigned int mask)
 {
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
+	unsigned int bh;
+	bh = __local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET, mask);
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
-	return 0;
+	return bh;
 }
 
 static inline unsigned long __raw_write_lock_irqsave(rwlock_t *lock)
@@ -202,10 +203,11 @@ static inline void __raw_write_lock_irq(rwlock_t *lock)
 static inline unsigned int  __raw_write_lock_bh(rwlock_t *lock,
 						unsigned int mask)
 {
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
+	unsigned int bh;
+	bh = __local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET, mask);
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
-	return 0;
+	return bh;
 }
 
 static inline void __raw_write_lock(rwlock_t *lock)
@@ -253,7 +255,7 @@ static inline void __raw_read_unlock_bh(rwlock_t *lock,
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_read_unlock(lock);
-	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
+	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET, bh);
 }
 
 static inline void __raw_write_unlock_irqrestore(rwlock_t *lock,
@@ -278,7 +280,7 @@ static inline void __raw_write_unlock_bh(rwlock_t *lock,
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_write_unlock(lock);
-	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
+	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET, bh);
 }
 
 #endif /* __LINUX_RWLOCK_API_SMP_H */
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 42bbf68..6602a56 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -132,9 +132,9 @@ static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
 
 static inline unsigned int __raw_spin_lock_bh(raw_spinlock_t *lock, unsigned int mask)
 {
-	unsigned int bh = 0;
+	unsigned int bh;
 
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
+	bh = __local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET, mask);
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 
@@ -179,19 +179,19 @@ static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock,
 {
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_spin_unlock(lock);
-	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
+	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET, bh);
 }
 
 static inline int __raw_spin_trylock_bh(raw_spinlock_t *lock,
 					unsigned int *bh,
 					unsigned int mask)
 {
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
+	*bh = __local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET, mask);
 	if (do_raw_spin_trylock(lock)) {
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 		return 1;
 	}
-	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
+	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET, *bh);
 	return 0;
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 22cc0a7..e2435b0 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -107,13 +107,16 @@ static bool ksoftirqd_running(unsigned long pending)
  * where hardirqs are disabled legitimately:
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
-void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
+unsigned int __local_bh_disable_ip(unsigned long ip, unsigned int cnt,
+				   unsigned int mask)
 {
 	unsigned long flags;
+	unsigned int enabled;
 
 	WARN_ON_ONCE(in_irq());
 
 	raw_local_irq_save(flags);
+
 	/*
 	 * The preempt tracer hooks into preempt_count_add and will break
 	 * lockdep because it calls back into lockdep after SOFTIRQ_OFFSET
@@ -127,6 +130,9 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	 */
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
 		trace_softirqs_off(ip);
+
+	enabled = local_softirq_enabled();
+	softirq_enabled_nand(mask);
 	raw_local_irq_restore(flags);
 
 	if (preempt_count() == cnt) {
@@ -135,6 +141,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 #endif
 		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
 	}
+	return enabled;
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
 #endif /* CONFIG_TRACE_IRQFLAGS */
@@ -143,11 +150,13 @@ EXPORT_SYMBOL(__local_bh_disable_ip);
  * Special-case - softirqs can safely be enabled by __do_softirq(),
  * without processing still-pending softirqs:
  */
-void local_bh_enable_no_softirq(void)
+void local_bh_enable_no_softirq(unsigned int bh)
 {
 	WARN_ON_ONCE(in_irq());
 	lockdep_assert_irqs_disabled();
 
+	softirq_enabled_set(bh);
+
 	if (preempt_count() == SOFTIRQ_DISABLE_OFFSET)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 
@@ -155,17 +164,18 @@ void local_bh_enable_no_softirq(void)
 		trace_softirqs_on(_RET_IP_);
 
 	__preempt_count_sub(SOFTIRQ_DISABLE_OFFSET);
-
 }
 EXPORT_SYMBOL(local_bh_enable_no_softirq);
 
-void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
+void __local_bh_enable_ip(unsigned long ip, unsigned int cnt, unsigned int bh)
 {
 	WARN_ON_ONCE(in_irq());
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_disable();
 #endif
+	softirq_enabled_set(bh);
+
 	/*
 	 * Are softirqs going to be turned on now:
 	 */
@@ -177,6 +187,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	 */
 	preempt_count_sub(cnt - 1);
 
+
 	if (unlikely(!in_interrupt() && local_softirq_pending())) {
 		/*
 		 * Run softirq if any pending. And do it in its own stack
@@ -246,9 +257,6 @@ static void local_bh_exit(void)
 	__preempt_count_sub(SOFTIRQ_OFFSET);
 }
 
-
-
-
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
@@ -395,15 +403,17 @@ asmlinkage __visible void do_softirq(void)
  */
 void irq_enter(void)
 {
+	unsigned int bh;
+
 	rcu_irq_enter();
 	if (is_idle_task(current) && !in_interrupt()) {
 		/*
 		 * Prevent raise_softirq from needlessly waking up ksoftirqd
 		 * here, as softirq will be serviced on return from interrupt.
 		 */
-		local_bh_disable(SOFTIRQ_ALL_MASK);
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		tick_irq_enter();
-		local_bh_enable_no_softirq();
+		local_bh_enable_no_softirq(bh);
 	}
 
 	__irq_enter();
-- 
2.7.4

