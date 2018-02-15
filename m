Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968039AbeBOR4C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:56:02 -0500
Received: from foss.arm.com ([217.140.101.70]:55986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164183AbeBOPaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:30:14 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using atomic_fetch_*
Date: Thu, 15 Feb 2018 15:29:33 +0000
Message-Id: <1518708575-12284-4-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic bitops can actually be implemented pretty efficiently using
the atomic_fetch_* ops, rather than explicit use of spinlocks.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/bitops/atomic.h | 219 ++++++++++++------------------------
 1 file changed, 71 insertions(+), 148 deletions(-)

diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
index 04deffaf5f7d..69b7915e291d 100644
--- a/include/asm-generic/bitops/atomic.h
+++ b/include/asm-generic/bitops/atomic.h
@@ -2,189 +2,112 @@
 #ifndef _ASM_GENERIC_BITOPS_ATOMIC_H_
 #define _ASM_GENERIC_BITOPS_ATOMIC_H_
 
-#include <asm/types.h>
-#include <linux/irqflags.h>
+#include <linux/atomic.h>
+#include <linux/compiler.h>
+#include <asm/barrier.h>
 
-#ifdef CONFIG_SMP
-#include <asm/spinlock.h>
-#include <asm/cache.h>		/* we use L1_CACHE_BYTES */
-
-/* Use an array of spinlocks for our atomic_ts.
- * Hash function to index into a different SPINLOCK.
- * Since "a" is usually an address, use one spinlock per cacheline.
+/*
+ * Implementation of atomic bitops using atomic-fetch ops.
+ * See Documentation/atomic_bitops.txt for details.
  */
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
 
+static inline void set_bit(unsigned int nr, volatile unsigned long *p)
+{
+	p += BIT_WORD(nr);
+	atomic_long_fetch_or_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
+}
 
-#else
-#  define _atomic_spin_lock_irqsave(l,f) do { local_irq_save(f); } while (0)
-#  define _atomic_spin_unlock_irqrestore(l,f) do { local_irq_restore(f); } while (0)
-#endif
+static inline void clear_bit(unsigned int nr, volatile unsigned long *p)
+{
+	p += BIT_WORD(nr);
+	atomic_long_fetch_andnot_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
+}
 
-/*
- * NMI events can occur at any time, including when interrupts have been
- * disabled by *_irqsave().  So you can get NMI events occurring while a
- * *_bit function is holding a spin lock.  If the NMI handler also wants
- * to do bit manipulation (and they do) then you can get a deadlock
- * between the original caller of *_bit() and the NMI handler.
- *
- * by Keith Owens
- */
+static inline void change_bit(unsigned int nr, volatile unsigned long *p)
+{
+	p += BIT_WORD(nr);
+	atomic_long_fetch_xor_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
+}
 
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
+static inline int test_and_set_bit(unsigned int nr, volatile unsigned long *p)
 {
+	long old;
 	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long flags;
 
-	_atomic_spin_lock_irqsave(p, flags);
-	*p  |= mask;
-	_atomic_spin_unlock_irqrestore(p, flags);
+	p += BIT_WORD(nr);
+	if (READ_ONCE(*p) & mask)
+		return 1;
+
+	old = atomic_long_fetch_or(mask, (atomic_long_t *)p);
+	return !!(old & mask);
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
+static inline int test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
 {
+	long old;
 	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long flags;
 
-	_atomic_spin_lock_irqsave(p, flags);
-	*p &= ~mask;
-	_atomic_spin_unlock_irqrestore(p, flags);
+	p += BIT_WORD(nr);
+	if (!(READ_ONCE(*p) & mask))
+		return 0;
+
+	old = atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
+	return !!(old & mask);
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
+static inline int test_and_change_bit(unsigned int nr, volatile unsigned long *p)
 {
+	long old;
 	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long flags;
 
-	_atomic_spin_lock_irqsave(p, flags);
-	*p ^= mask;
-	_atomic_spin_unlock_irqrestore(p, flags);
+	p += BIT_WORD(nr);
+	old = atomic_long_fetch_xor(mask, (atomic_long_t *)p);
+	return !!(old & mask);
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
+static inline int test_and_set_bit_lock(unsigned int nr,
+					volatile unsigned long *p)
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
+	old = atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
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
+static inline void clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
 {
-	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long old;
-	unsigned long flags;
+	p += BIT_WORD(nr);
+	atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
+}
 
-	_atomic_spin_lock_irqsave(p, flags);
-	old = *p;
-	*p = old & ~mask;
-	_atomic_spin_unlock_irqrestore(p, flags);
+static inline void __clear_bit_unlock(unsigned int nr,
+				      volatile unsigned long *p)
+{
+	unsigned long old;
 
-	return (old & mask) != 0;
+	p += BIT_WORD(nr);
+	old = READ_ONCE(*p);
+	old &= ~BIT_MASK(nr);
+	smp_store_release(p, old);
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
+#ifndef clear_bit_unlock_is_negative_byte
+static inline bool clear_bit_unlock_is_negative_byte(unsigned int nr,
+						     volatile unsigned long *p)
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
+	old = atomic_long_fetch_andnot_release(mask, (atomic_long_t *)p);
+	return !!(old & BIT(7));
 }
+#define clear_bit_unlock_is_negative_byte clear_bit_unlock_is_negative_byte
+#endif
 
 #endif /* _ASM_GENERIC_BITOPS_ATOMIC_H */
-- 
2.1.4
