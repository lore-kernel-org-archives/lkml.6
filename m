Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbeFAQHM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:07:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55030 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752360AbeFAQGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:06:00 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 7/9] asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*
Date: Fri,  1 Jun 2018 17:06:27 +0100
Message-Id: <1527869189-31512-8-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
References: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock bitops can be implemented more efficiently using the atomic_fetch_*
ops, which provide finer-grained control over the memory ordering semantics
than the bitops.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/bitops/lock.h | 68 ++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index 67ab280ad134..3ae021368f48 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_GENERIC_BITOPS_LOCK_H_
 #define _ASM_GENERIC_BITOPS_LOCK_H_
 
+#include <linux/atomic.h>
+#include <linux/compiler.h>
+#include <asm/barrier.h>
+
 /**
  * test_and_set_bit_lock - Set a bit and return its old value, for lock
  * @nr: Bit to set
@@ -11,7 +15,20 @@
  * the returned value is 0.
  * It can be used to implement bit locks.
  */
-#define test_and_set_bit_lock(nr, addr)	test_and_set_bit(nr, addr)
+static inline int test_and_set_bit_lock(unsigned int nr,
+					volatile unsigned long *p)
+{
+	long old;
+	unsigned long mask = BIT_MASK(nr);
+
+	p += BIT_WORD(nr);
+	if (READ_ONCE(*p) & mask)
+		return 1;
+
+	old = atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
+	return !!(old & mask);
+}
+
 
 /**
  * clear_bit_unlock - Clear a bit in memory, for unlock
@@ -20,11 +37,11 @@
  *
  * This operation is atomic and provides release barrier semantics.
  */
-#define clear_bit_unlock(nr, addr)	\
-do {					\
-	smp_mb__before_atomic();	\
-	clear_bit(nr, addr);		\
-} while (0)
+static inline void clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
+{
+	p += BIT_WORD(nr);
+	atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
+}
 
 /**
  * __clear_bit_unlock - Clear a bit in memory, for unlock
@@ -37,11 +54,38 @@ do {					\
  *
  * See for example x86's implementation.
  */
-#define __clear_bit_unlock(nr, addr)	\
-do {					\
-	smp_mb__before_atomic();	\
-	clear_bit(nr, addr);		\
-} while (0)
+static inline void __clear_bit_unlock(unsigned int nr,
+				      volatile unsigned long *p)
+{
+	unsigned long old;
 
-#endif /* _ASM_GENERIC_BITOPS_LOCK_H_ */
+	p += BIT_WORD(nr);
+	old = READ_ONCE(*p);
+	old &= ~BIT_MASK(nr);
+	atomic_long_set_release((atomic_long_t *)p, old);
+}
+
+/**
+ * clear_bit_unlock_is_negative_byte - Clear a bit in memory and test if bottom
+ *                                     byte is negative, for unlock.
+ * @nr: the bit to clear
+ * @addr: the address to start counting from
+ *
+ * This is a bit of a one-trick-pony for the filemap code, which clears
+ * PG_locked and tests PG_waiters,
+ */
+#ifndef clear_bit_unlock_is_negative_byte
+static inline bool clear_bit_unlock_is_negative_byte(unsigned int nr,
+						     volatile unsigned long *p)
+{
+	long old;
+	unsigned long mask = BIT_MASK(nr);
+
+	p += BIT_WORD(nr);
+	old = atomic_long_fetch_andnot_release(mask, (atomic_long_t *)p);
+	return !!(old & BIT(7));
+}
+#define clear_bit_unlock_is_negative_byte clear_bit_unlock_is_negative_byte
+#endif
 
+#endif /* _ASM_GENERIC_BITOPS_LOCK_H_ */
-- 
2.1.4
