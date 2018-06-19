Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B97C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E380720874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E380720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937931AbeFSMzT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:55:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49346 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937854AbeFSMwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:52:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F41EA15B2;
        Tue, 19 Jun 2018 05:52:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C626B3F557;
        Tue, 19 Jun 2018 05:52:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id DC99E1AE36FB; Tue, 19 Jun 2018 13:53:15 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        yamada.masahiro@socionext.com, Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH v2 6/9] asm-generic/bitops/atomic.h: Rewrite using atomic_*
Date:   Tue, 19 Jun 2018 13:53:11 +0100
Message-Id: <1529412794-17720-7-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
References: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic bitops can actually be implemented pretty efficiently using
the atomic_* ops, rather than explicit use of spinlocks.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/bitops/atomic.h | 188 +++++++-----------------------------
 1 file changed, 33 insertions(+), 155 deletions(-)

diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
index 04deffaf5f7d..dd90c9792909 100644
--- a/include/asm-generic/bitops/atomic.h
+++ b/include/asm-generic/bitops/atomic.h
@@ -2,189 +2,67 @@
 #ifndef _ASM_GENERIC_BITOPS_ATOMIC_H_
 #define _ASM_GENERIC_BITOPS_ATOMIC_H_
 
-#include <asm/types.h>
-#include <linux/irqflags.h>
-
-#ifdef CONFIG_SMP
-#include <asm/spinlock.h>
-#include <asm/cache.h>		/* we use L1_CACHE_BYTES */
-
-/* Use an array of spinlocks for our atomic_ts.
- * Hash function to index into a different SPINLOCK.
- * Since "a" is usually an address, use one spinlock per cacheline.
- */
-#  define ATOMIC_HASH_SIZE 4
-#  define ATOMIC_HASH(a) (&(__atomic_hash[ (((unsigned long) a)/L1_CACHE_BYTES) & (ATOMIC_HASH_SIZE-1) ]))
-
-extern arch_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned;
-
-/* Can't use raw_spin_lock_irq because of #include problems, so
- * this is the substitute */
-#define _atomic_spin_lock_irqsave(l,f) do {	\
-	arch_spinlock_t *s = ATOMIC_HASH(l);	\
-	local_irq_save(f);			\
-	arch_spin_lock(s);			\
-} while(0)
-
-#define _atomic_spin_unlock_irqrestore(l,f) do {	\
-	arch_spinlock_t *s = ATOMIC_HASH(l);		\
-	arch_spin_unlock(s);				\
-	local_irq_restore(f);				\
-} while(0)
-
-
-#else
-#  define _atomic_spin_lock_irqsave(l,f) do { local_irq_save(f); } while (0)
-#  define _atomic_spin_unlock_irqrestore(l,f) do { local_irq_restore(f); } while (0)
-#endif
+#include <linux/atomic.h>
+#include <linux/compiler.h>
+#include <asm/barrier.h>
 
 /*
- * NMI events can occur at any time, including when interrupts have been
- * disabled by *_irqsave().  So you can get NMI events occurring while a
- * *_bit function is holding a spin lock.  If the NMI handler also wants
- * to do bit manipulation (and they do) then you can get a deadlock
- * between the original caller of *_bit() and the NMI handler.
- *
- * by Keith Owens
+ * Implementation of atomic bitops using atomic-fetch ops.
+ * See Documentation/atomic_bitops.txt for details.
  */
 
-/**
- * set_bit - Atomically set a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * This function is atomic and may not be reordered.  See __set_bit()
- * if you do not require the atomic guarantees.
- *
- * Note: there are no guarantees that this function will not be reordered
- * on non x86 architectures, so if you are writing portable code,
- * make sure not to rely on its reordering guarantees.
- *
- * Note that @nr may be almost arbitrarily large; this function is not
- * restricted to acting on a single-word quantity.
- */
-static inline void set_bit(int nr, volatile unsigned long *addr)
+static inline void set_bit(unsigned int nr, volatile unsigned long *p)
 {
-	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long flags;
-
-	_atomic_spin_lock_irqsave(p, flags);
-	*p  |= mask;
-	_atomic_spin_unlock_irqrestore(p, flags);
+	p += BIT_WORD(nr);
+	atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
-/**
- * clear_bit - Clears a bit in memory
- * @nr: Bit to clear
- * @addr: Address to start counting from
- *
- * clear_bit() is atomic and may not be reordered.  However, it does
- * not contain a memory barrier, so if it is used for locking purposes,
- * you should call smp_mb__before_atomic() and/or smp_mb__after_atomic()
- * in order to ensure changes are visible on other processors.
- */
-static inline void clear_bit(int nr, volatile unsigned long *addr)
+static inline void clear_bit(unsigned int nr, volatile unsigned long *p)
 {
-	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long flags;
-
-	_atomic_spin_lock_irqsave(p, flags);
-	*p &= ~mask;
-	_atomic_spin_unlock_irqrestore(p, flags);
+	p += BIT_WORD(nr);
+	atomic_long_andnot(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
-/**
- * change_bit - Toggle a bit in memory
- * @nr: Bit to change
- * @addr: Address to start counting from
- *
- * change_bit() is atomic and may not be reordered. It may be
- * reordered on other architectures than x86.
- * Note that @nr may be almost arbitrarily large; this function is not
- * restricted to acting on a single-word quantity.
- */
-static inline void change_bit(int nr, volatile unsigned long *addr)
+static inline void change_bit(unsigned int nr, volatile unsigned long *p)
 {
-	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long flags;
-
-	_atomic_spin_lock_irqsave(p, flags);
-	*p ^= mask;
-	_atomic_spin_unlock_irqrestore(p, flags);
+	p += BIT_WORD(nr);
+	atomic_long_xor(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
-/**
- * test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It may be reordered on other architectures than x86.
- * It also implies a memory barrier.
- */
-static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
+static inline int test_and_set_bit(unsigned int nr, volatile unsigned long *p)
 {
+	long old;
 	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long old;
-	unsigned long flags;
 
-	_atomic_spin_lock_irqsave(p, flags);
-	old = *p;
-	*p = old | mask;
-	_atomic_spin_unlock_irqrestore(p, flags);
+	p += BIT_WORD(nr);
+	if (READ_ONCE(*p) & mask)
+		return 1;
 
-	return (old & mask) != 0;
+	old = atomic_long_fetch_or(mask, (atomic_long_t *)p);
+	return !!(old & mask);
 }
 
-/**
- * test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to clear
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It can be reorderdered on other architectures other than x86.
- * It also implies a memory barrier.
- */
-static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
+static inline int test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
 {
+	long old;
 	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long old;
-	unsigned long flags;
 
-	_atomic_spin_lock_irqsave(p, flags);
-	old = *p;
-	*p = old & ~mask;
-	_atomic_spin_unlock_irqrestore(p, flags);
+	p += BIT_WORD(nr);
+	if (!(READ_ONCE(*p) & mask))
+		return 0;
 
-	return (old & mask) != 0;
+	old = atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
+	return !!(old & mask);
 }
 
-/**
- * test_and_change_bit - Change a bit and return its old value
- * @nr: Bit to change
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It also implies a memory barrier.
- */
-static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
+static inline int test_and_change_bit(unsigned int nr, volatile unsigned long *p)
 {
+	long old;
 	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long old;
-	unsigned long flags;
-
-	_atomic_spin_lock_irqsave(p, flags);
-	old = *p;
-	*p = old ^ mask;
-	_atomic_spin_unlock_irqrestore(p, flags);
 
-	return (old & mask) != 0;
+	p += BIT_WORD(nr);
+	old = atomic_long_fetch_xor(mask, (atomic_long_t *)p);
+	return !!(old & mask);
 }
 
 #endif /* _ASM_GENERIC_BITOPS_ATOMIC_H */
-- 
2.1.4

