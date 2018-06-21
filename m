Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040EAC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6C7208B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6C7208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933787AbeFUMOG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:14:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49432 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933743AbeFUMOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:14:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7253D1435;
        Thu, 21 Jun 2018 05:14:04 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D6B53F578;
        Thu, 21 Jun 2018 05:14:02 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCHv4 15/18] atomics/treewide: make test ops optional
Date:   Thu, 21 Jun 2018 13:13:18 +0100
Message-Id: <20180621121321.4761-16-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180621121321.4761-1-mark.rutland@arm.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the atomics return the result of a test applied after the atomic
operation, and almost all architectures implement these as trivial
wrappers around the underlying atomic. Specifically:

* <atomic>_inc_and_test(v) is (<atomic>_inc_return(v) == 0)

* <atomic>_dec_and_test(v) is (<atomic>_dec_return(v) == 0)

* <atomic>_sub_and_test(i, v) is (<atomic>_sub_return(i, v) == 0)

* <atomic>_add_negative(i, v) is (<atomic>_add_return(i, v) < 0)

Rather than have these definitions duplicated in all architectures, with
minor inconsistencies in formatting and documentation, let's make these
operations optional, with default fallbacks as above. Implementations
must now provide a preprocessor symbol.

The instrumented atomics are updated accordingly.

Both x86 and m68k have custom implementations, which are left as-is,
given preprocessor symbols to avoid being overridden.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 arch/alpha/include/asm/atomic.h           |  12 ---
 arch/arc/include/asm/atomic.h             |  10 ---
 arch/arm/include/asm/atomic.h             |   9 ---
 arch/arm64/include/asm/atomic.h           |   8 --
 arch/h8300/include/asm/atomic.h           |   5 --
 arch/hexagon/include/asm/atomic.h         |   5 --
 arch/ia64/include/asm/atomic.h            |  23 ------
 arch/m68k/include/asm/atomic.h            |   4 +
 arch/mips/include/asm/atomic.h            |  84 --------------------
 arch/parisc/include/asm/atomic.h          |  22 ------
 arch/powerpc/include/asm/atomic.h         |  30 --------
 arch/riscv/include/asm/atomic.h           |  46 -----------
 arch/s390/include/asm/atomic.h            |   8 --
 arch/sh/include/asm/atomic.h              |   4 -
 arch/sparc/include/asm/atomic_32.h        |  15 ----
 arch/sparc/include/asm/atomic_64.h        |  20 -----
 arch/x86/include/asm/atomic.h             |   4 +
 arch/x86/include/asm/atomic64_32.h        |  54 -------------
 arch/x86/include/asm/atomic64_64.h        |   4 +
 arch/xtensa/include/asm/atomic.h          |  42 ----------
 include/asm-generic/atomic-instrumented.h |  24 ++++++
 include/asm-generic/atomic.h              |   9 ---
 include/asm-generic/atomic64.h            |   4 -
 include/linux/atomic.h                    | 124 ++++++++++++++++++++++++++++++
 24 files changed, 160 insertions(+), 410 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index cc486dbb3837..25f8693c5a42 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -297,24 +297,12 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 	return old - 1;
 }
 
-#define atomic_add_negative(a, v) (atomic_add_return((a), (v)) < 0)
-#define atomic64_add_negative(a, v) (atomic64_add_return((a), (v)) < 0)
-
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic64_dec_return(v) atomic64_sub_return(1,(v))
 
 #define atomic_inc_return(v) atomic_add_return(1,(v))
 #define atomic64_inc_return(v) atomic64_add_return(1,(v))
 
-#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
-#define atomic64_sub_and_test(i,v) (atomic64_sub_return((i), (v)) == 0)
-
-#define atomic_inc_and_test(v) (atomic_add_return(1, (v)) == 0)
-#define atomic64_inc_and_test(v) (atomic64_add_return(1, (v)) == 0)
-
-#define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
-#define atomic64_dec_and_test(v) (atomic64_sub_return(1, (v)) == 0)
-
 #define atomic_inc(v) atomic_add(1,(v))
 #define atomic64_inc(v) atomic64_add(1,(v))
 
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 4917ffa61579..4222e726f84c 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -311,14 +311,8 @@ ATOMIC_OPS(xor, ^=, CTOP_INST_AXOR_DI_R2_R2_R3)
 #define atomic_inc(v)			atomic_add(1, v)
 #define atomic_dec(v)			atomic_sub(1, v)
 
-#define atomic_inc_and_test(v)		(atomic_add_return(1, v) == 0)
-#define atomic_dec_and_test(v)		(atomic_sub_return(1, v) == 0)
 #define atomic_inc_return(v)		atomic_add_return(1, (v))
 #define atomic_dec_return(v)		atomic_sub_return(1, (v))
-#define atomic_sub_and_test(i, v)	(atomic_sub_return(i, v) == 0)
-
-#define atomic_add_negative(i, v)	(atomic_add_return(i, v) < 0)
-
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 
@@ -566,14 +560,10 @@ static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
 }
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
-#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
 #define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
-#define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
-#define atomic64_sub_and_test(a, v)	(atomic64_sub_return((a), (v)) == 0)
 #define atomic64_dec(v)			atomic64_sub(1LL, (v))
 #define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
-#define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
 
 #endif	/* !CONFIG_GENERIC_ATOMIC64 */
 
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 852e1fee72b0..35fb7f504daa 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -248,13 +248,8 @@ ATOMIC_OPS(xor, ^=, eor)
 #define atomic_inc(v)		atomic_add(1, v)
 #define atomic_dec(v)		atomic_sub(1, v)
 
-#define atomic_inc_and_test(v)	(atomic_add_return(1, v) == 0)
-#define atomic_dec_and_test(v)	(atomic_sub_return(1, v) == 0)
 #define atomic_inc_return_relaxed(v)    (atomic_add_return_relaxed(1, v))
 #define atomic_dec_return_relaxed(v)    (atomic_sub_return_relaxed(1, v))
-#define atomic_sub_and_test(i, v) (atomic_sub_return(i, v) == 0)
-
-#define atomic_add_negative(i,v) (atomic_add_return(i, v) < 0)
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 typedef struct {
@@ -517,14 +512,10 @@ static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
 }
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
-#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
 #define atomic64_inc_return_relaxed(v)	atomic64_add_return_relaxed(1LL, (v))
-#define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
-#define atomic64_sub_and_test(a, v)	(atomic64_sub_return((a), (v)) == 0)
 #define atomic64_dec(v)			atomic64_sub(1LL, (v))
 #define atomic64_dec_return_relaxed(v)	atomic64_sub_return_relaxed(1LL, (v))
-#define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
 
 #endif /* !CONFIG_GENERIC_ATOMIC64 */
 #endif
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 82db0e4febd4..edbe53fa3106 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -110,10 +110,6 @@
 
 #define atomic_inc(v)			atomic_add(1, (v))
 #define atomic_dec(v)			atomic_sub(1, (v))
-#define atomic_inc_and_test(v)		(atomic_inc_return(v) == 0)
-#define atomic_dec_and_test(v)		(atomic_dec_return(v) == 0)
-#define atomic_sub_and_test(i, v)	(atomic_sub_return((i), (v)) == 0)
-#define atomic_add_negative(i, v)	(atomic_add_return((i), (v)) < 0)
 #define atomic_andnot			atomic_andnot
 
 /*
@@ -185,10 +181,6 @@
 
 #define atomic64_inc(v)			atomic64_add(1, (v))
 #define atomic64_dec(v)			atomic64_sub(1, (v))
-#define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
-#define atomic64_dec_and_test(v)	(atomic64_dec_return(v) == 0)
-#define atomic64_sub_and_test(i, v)	(atomic64_sub_return((i), (v)) == 0)
-#define atomic64_add_negative(i, v)	(atomic64_add_return((i), (v)) < 0)
 #define atomic64_andnot			atomic64_andnot
 
 #endif
diff --git a/arch/h8300/include/asm/atomic.h b/arch/h8300/include/asm/atomic.h
index 250bb3baac23..b658b20d2232 100644
--- a/arch/h8300/include/asm/atomic.h
+++ b/arch/h8300/include/asm/atomic.h
@@ -69,17 +69,12 @@ ATOMIC_OPS(sub, -=)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
-#define atomic_sub_and_test(i, v)	(atomic_sub_return(i, v) == 0)
-
 #define atomic_inc_return(v)		atomic_add_return(1, v)
 #define atomic_dec_return(v)		atomic_sub_return(1, v)
 
 #define atomic_inc(v)			(void)atomic_inc_return(v)
-#define atomic_inc_and_test(v)		(atomic_inc_return(v) == 0)
 
 #define atomic_dec(v)			(void)atomic_dec_return(v)
-#define atomic_dec_and_test(v)		(atomic_dec_return(v) == 0)
 
 static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 86c67e9adbfa..31638f511674 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -201,11 +201,6 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #define atomic_inc(v) atomic_add(1, (v))
 #define atomic_dec(v) atomic_sub(1, (v))
 
-#define atomic_inc_and_test(v) (atomic_add_return(1, (v)) == 0)
-#define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
-#define atomic_sub_and_test(i, v) (atomic_sub_return(i, (v)) == 0)
-#define atomic_add_negative(i, v) (atomic_add_return(i, (v)) < 0)
-
 #define atomic_inc_return(v) (atomic_add_return(1, v))
 #define atomic_dec_return(v) (atomic_sub_return(1, v))
 
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index 0f80a3eafaba..e4143c462e65 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -231,34 +231,11 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 	return dec;
 }
 
-/*
- * Atomically add I to V and return TRUE if the resulting value is
- * negative.
- */
-static __inline__ int
-atomic_add_negative (int i, atomic_t *v)
-{
-	return atomic_add_return(i, v) < 0;
-}
-
-static __inline__ long
-atomic64_add_negative (__s64 i, atomic64_t *v)
-{
-	return atomic64_add_return(i, v) < 0;
-}
-
 #define atomic_dec_return(v)		atomic_sub_return(1, (v))
 #define atomic_inc_return(v)		atomic_add_return(1, (v))
 #define atomic64_dec_return(v)		atomic64_sub_return(1, (v))
 #define atomic64_inc_return(v)		atomic64_add_return(1, (v))
 
-#define atomic_sub_and_test(i,v)	(atomic_sub_return((i), (v)) == 0)
-#define atomic_dec_and_test(v)		(atomic_sub_return(1, (v)) == 0)
-#define atomic_inc_and_test(v)		(atomic_add_return(1, (v)) == 0)
-#define atomic64_sub_and_test(i,v)	(atomic64_sub_return((i), (v)) == 0)
-#define atomic64_dec_and_test(v)	(atomic64_sub_return(1, (v)) == 0)
-#define atomic64_inc_and_test(v)	(atomic64_add_return(1, (v)) == 0)
-
 #define atomic_add(i,v)			(void)atomic_add_return((i), (v))
 #define atomic_sub(i,v)			(void)atomic_sub_return((i), (v))
 #define atomic_inc(v)			atomic_add(1, (v))
diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
index 596882cda224..9df09c876fa2 100644
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -138,6 +138,7 @@ static inline int atomic_dec_and_test(atomic_t *v)
 	__asm__ __volatile__("subql #1,%1; seq %0" : "=d" (c), "+m" (*v));
 	return c != 0;
 }
+#define atomic_dec_and_test atomic_dec_and_test
 
 static inline int atomic_dec_and_test_lt(atomic_t *v)
 {
@@ -155,6 +156,7 @@ static inline int atomic_inc_and_test(atomic_t *v)
 	__asm__ __volatile__("addql #1,%1; seq %0" : "=d" (c), "+m" (*v));
 	return c != 0;
 }
+#define atomic_inc_and_test atomic_inc_and_test
 
 #ifdef CONFIG_RMW_INSNS
 
@@ -201,6 +203,7 @@ static inline int atomic_sub_and_test(int i, atomic_t *v)
 			     : ASM_DI (i));
 	return c != 0;
 }
+#define atomic_sub_and_test atomic_sub_and_test
 
 static inline int atomic_add_negative(int i, atomic_t *v)
 {
@@ -210,5 +213,6 @@ static inline int atomic_add_negative(int i, atomic_t *v)
 			     : ASM_DI (i));
 	return c != 0;
 }
+#define atomic_add_negative atomic_add_negative
 
 #endif /* __ARCH_M68K_ATOMIC __ */
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index d42b27df1548..fd3008ae164c 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -278,37 +278,6 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 #define atomic_inc_return(v) atomic_add_return(1, (v))
 
 /*
- * atomic_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
-#define atomic_sub_and_test(i, v) (atomic_sub_return((i), (v)) == 0)
-
-/*
- * atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
-
-/*
- * atomic_dec_and_test - decrement by 1 and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
-#define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
-
-/*
  * atomic_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic_t
  */
@@ -330,17 +299,6 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
  */
 #define atomic_dec(v) atomic_sub(1, (v))
 
-/*
- * atomic_add_negative - add and test if negative
- * @v: pointer of type atomic_t
- * @i: integer value to add
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
-#define atomic_add_negative(i, v) (atomic_add_return(i, (v)) < 0)
-
 #ifdef CONFIG_64BIT
 
 #define ATOMIC64_INIT(i)    { (i) }
@@ -600,37 +558,6 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 #define atomic64_inc_return(v) atomic64_add_return(1, (v))
 
 /*
- * atomic64_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic64_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
-#define atomic64_sub_and_test(i, v) (atomic64_sub_return((i), (v)) == 0)
-
-/*
- * atomic64_inc_and_test - increment and test
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define atomic64_inc_and_test(v) (atomic64_inc_return(v) == 0)
-
-/*
- * atomic64_dec_and_test - decrement by 1 and test
- * @v: pointer of type atomic64_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
-#define atomic64_dec_and_test(v) (atomic64_sub_return(1, (v)) == 0)
-
-/*
  * atomic64_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic64_t
  */
@@ -652,17 +579,6 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
  */
 #define atomic64_dec(v) atomic64_sub(1, (v))
 
-/*
- * atomic64_add_negative - add and test if negative
- * @v: pointer of type atomic64_t
- * @i: integer value to add
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
-#define atomic64_add_negative(i, v) (atomic64_add_return(i, (v)) < 0)
-
 #endif /* CONFIG_64BIT */
 
 #endif /* _ASM_ATOMIC_H */
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index f53ba2d6ff67..f85844ff6336 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -142,22 +142,6 @@ ATOMIC_OPS(xor, ^=)
 #define atomic_inc_return(v)	(atomic_add_return(   1,(v)))
 #define atomic_dec_return(v)	(atomic_add_return(  -1,(v)))
 
-#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
-
-/*
- * atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
-
-#define atomic_dec_and_test(v)	(atomic_dec_return(v) == 0)
-
-#define atomic_sub_and_test(i,v)	(atomic_sub_return((i),(v)) == 0)
-
 #define ATOMIC_INIT(i)	{ (i) }
 
 #ifdef CONFIG_64BIT
@@ -246,12 +230,6 @@ atomic64_read(const atomic64_t *v)
 #define atomic64_inc_return(v)		(atomic64_add_return(   1,(v)))
 #define atomic64_dec_return(v)		(atomic64_add_return(  -1,(v)))
 
-#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
-
-#define atomic64_inc_and_test(v) 	(atomic64_inc_return(v) == 0)
-#define atomic64_dec_and_test(v)	(atomic64_dec_return(v) == 0)
-#define atomic64_sub_and_test(i,v)	(atomic64_sub_return((i),(v)) == 0)
-
 /* exported interface */
 #define atomic64_cmpxchg(v, o, n) \
 	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 233dbf31911c..5d76f05d2be3 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -129,8 +129,6 @@ ATOMIC_OPS(xor, xor)
 #undef ATOMIC_OP_RETURN_RELAXED
 #undef ATOMIC_OP
 
-#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
-
 static __inline__ void atomic_inc(atomic_t *v)
 {
 	int t;
@@ -163,16 +161,6 @@ static __inline__ int atomic_inc_return_relaxed(atomic_t *v)
 	return t;
 }
 
-/*
- * atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
-
 static __inline__ void atomic_dec(atomic_t *v)
 {
 	int t;
@@ -281,9 +269,6 @@ static __inline__ int atomic_inc_not_zero(atomic_t *v)
 }
 #define atomic_inc_not_zero(v) atomic_inc_not_zero((v))
 
-#define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
-#define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
-
 /*
  * Atomically test *v and decrement if it is greater than 0.
  * The function returns the old value of *v minus 1, even if
@@ -413,8 +398,6 @@ ATOMIC64_OPS(xor, xor)
 #undef ATOMIC64_OP_RETURN_RELAXED
 #undef ATOMIC64_OP
 
-#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
-
 static __inline__ void atomic64_inc(atomic64_t *v)
 {
 	long t;
@@ -445,16 +428,6 @@ static __inline__ long atomic64_inc_return_relaxed(atomic64_t *v)
 	return t;
 }
 
-/*
- * atomic64_inc_and_test - increment and test
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define atomic64_inc_and_test(v) (atomic64_inc_return(v) == 0)
-
 static __inline__ void atomic64_dec(atomic64_t *v)
 {
 	long t;
@@ -488,9 +461,6 @@ static __inline__ long atomic64_dec_return_relaxed(atomic64_t *v)
 #define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
 #define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
 
-#define atomic64_sub_and_test(a, v)	(atomic64_sub_return((a), (v)) == 0)
-#define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
-
 /*
  * Atomically test *v and decrement if it is greater than 0.
  * The function returns the old value of *v minus 1.
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index d959bbaaad41..68eef0a805ca 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -209,36 +209,6 @@ ATOMIC_OPS(xor, xor, i)
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 
-/*
- * The extra atomic operations that are constructed from one of the core
- * AMO-based operations above (aside from sub, which is easier to fit above).
- * These are required to perform a full barrier, but they're OK this way
- * because atomic_*_return is also required to perform a full barrier.
- *
- */
-#define ATOMIC_OP(op, func_op, comp_op, I, c_type, prefix)		\
-static __always_inline							\
-bool atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)		\
-{									\
-	return atomic##prefix##_##func_op##_return(i, v) comp_op I;	\
-}
-
-#ifdef CONFIG_GENERIC_ATOMIC64
-#define ATOMIC_OPS(op, func_op, comp_op, I)				\
-        ATOMIC_OP(op, func_op, comp_op, I,  int,   )
-#else
-#define ATOMIC_OPS(op, func_op, comp_op, I)				\
-        ATOMIC_OP(op, func_op, comp_op, I,  int,   )			\
-        ATOMIC_OP(op, func_op, comp_op, I, long, 64)
-#endif
-
-ATOMIC_OPS(add_and_test, add, ==, 0)
-ATOMIC_OPS(sub_and_test, sub, ==, 0)
-ATOMIC_OPS(add_negative, add,  <, 0)
-
-#undef ATOMIC_OP
-#undef ATOMIC_OPS
-
 #define ATOMIC_OP(op, func_op, I, c_type, prefix)			\
 static __always_inline							\
 void atomic##prefix##_##op(atomic##prefix##_t *v)			\
@@ -315,22 +285,6 @@ ATOMIC_OPS(dec, add, +, -1)
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 
-#define ATOMIC_OP(op, func_op, comp_op, I, prefix)			\
-static __always_inline							\
-bool atomic##prefix##_##op(atomic##prefix##_t *v)			\
-{									\
-	return atomic##prefix##_##func_op##_return(v) comp_op I;	\
-}
-
-ATOMIC_OP(inc_and_test, inc, ==, 0,   )
-ATOMIC_OP(dec_and_test, dec, ==, 0,   )
-#ifndef CONFIG_GENERIC_ATOMIC64
-ATOMIC_OP(inc_and_test, inc, ==, 0, 64)
-ATOMIC_OP(dec_and_test, dec, ==, 0, 64)
-#endif
-
-#undef ATOMIC_OP
-
 /* This is required to provide a full barrier on success. */
 static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index eb9329741bad..7f5fbd595f01 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -55,17 +55,13 @@ static inline void atomic_add(int i, atomic_t *v)
 	__atomic_add(i, &v->counter);
 }
 
-#define atomic_add_negative(_i, _v)	(atomic_add_return(_i, _v) < 0)
 #define atomic_inc(_v)			atomic_add(1, _v)
 #define atomic_inc_return(_v)		atomic_add_return(1, _v)
-#define atomic_inc_and_test(_v)		(atomic_add_return(1, _v) == 0)
 #define atomic_sub(_i, _v)		atomic_add(-(int)(_i), _v)
 #define atomic_sub_return(_i, _v)	atomic_add_return(-(int)(_i), _v)
 #define atomic_fetch_sub(_i, _v)	atomic_fetch_add(-(int)(_i), _v)
-#define atomic_sub_and_test(_i, _v)	(atomic_sub_return(_i, _v) == 0)
 #define atomic_dec(_v)			atomic_sub(1, _v)
 #define atomic_dec_return(_v)		atomic_sub_return(1, _v)
-#define atomic_dec_and_test(_v)		(atomic_sub_return(1, _v) == 0)
 
 #define ATOMIC_OPS(op)							\
 static inline void atomic_##op(int i, atomic_t *v)			\
@@ -170,16 +166,12 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 	return dec;
 }
 
-#define atomic64_add_negative(_i, _v)	(atomic64_add_return(_i, _v) < 0)
 #define atomic64_inc(_v)		atomic64_add(1, _v)
 #define atomic64_inc_return(_v)		atomic64_add_return(1, _v)
-#define atomic64_inc_and_test(_v)	(atomic64_add_return(1, _v) == 0)
 #define atomic64_sub_return(_i, _v)	atomic64_add_return(-(long)(_i), _v)
 #define atomic64_fetch_sub(_i, _v)	atomic64_fetch_add(-(long)(_i), _v)
 #define atomic64_sub(_i, _v)		atomic64_add(-(long)(_i), _v)
-#define atomic64_sub_and_test(_i, _v)	(atomic64_sub_return(_i, _v) == 0)
 #define atomic64_dec(_v)		atomic64_sub(1, _v)
 #define atomic64_dec_return(_v)		atomic64_sub_return(1, _v)
-#define atomic64_dec_and_test(_v)	(atomic64_sub_return(1, _v) == 0)
 
 #endif /* __ARCH_S390_ATOMIC__  */
diff --git a/arch/sh/include/asm/atomic.h b/arch/sh/include/asm/atomic.h
index 422fac764ca1..d438494fa112 100644
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -32,12 +32,8 @@
 #include <asm/atomic-irq.h>
 #endif
 
-#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
 #define atomic_dec_return(v)		atomic_sub_return(1, (v))
 #define atomic_inc_return(v)		atomic_add_return(1, (v))
-#define atomic_inc_and_test(v)		(atomic_inc_return(v) == 0)
-#define atomic_sub_and_test(i,v)	(atomic_sub_return((i), (v)) == 0)
-#define atomic_dec_and_test(v)		(atomic_sub_return(1, (v)) == 0)
 
 #define atomic_inc(v)			atomic_add(1, (v))
 #define atomic_dec(v)			atomic_sub(1, (v))
diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index 9d7a15acc0c5..3a26573790c6 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -51,19 +51,4 @@ void atomic_set(atomic_t *, int);
 #define atomic_inc_return(v)	(atomic_add_return(        1, (v)))
 #define atomic_dec_return(v)	(atomic_add_return(       -1, (v)))
 
-#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
-
-/*
- * atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
-
-#define atomic_dec_and_test(v) (atomic_dec_return(v) == 0)
-#define atomic_sub_and_test(i, v) (atomic_sub_return(i, v) == 0)
-
 #endif /* !(__ARCH_SPARC_ATOMIC__) */
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index 458783e99997..634508282aea 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -56,32 +56,12 @@ ATOMIC_OPS(xor)
 #define atomic_inc_return(v)   atomic_add_return(1, v)
 #define atomic64_inc_return(v) atomic64_add_return(1, v)
 
-/*
- * atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
-#define atomic64_inc_and_test(v) (atomic64_inc_return(v) == 0)
-
-#define atomic_sub_and_test(i, v) (atomic_sub_return(i, v) == 0)
-#define atomic64_sub_and_test(i, v) (atomic64_sub_return(i, v) == 0)
-
-#define atomic_dec_and_test(v) (atomic_sub_return(1, v) == 0)
-#define atomic64_dec_and_test(v) (atomic64_sub_return(1, v) == 0)
-
 #define atomic_inc(v) atomic_add(1, v)
 #define atomic64_inc(v) atomic64_add(1, v)
 
 #define atomic_dec(v) atomic_sub(1, v)
 #define atomic64_dec(v) atomic64_sub(1, v)
 
-#define atomic_add_negative(i, v) (atomic_add_return(i, v) < 0)
-#define atomic64_add_negative(i, v) (atomic64_add_return(i, v) < 0)
-
 #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 
 static inline int atomic_xchg(atomic_t *v, int new)
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 616327ac9d39..73bda4abe180 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -80,6 +80,7 @@ static __always_inline void arch_atomic_sub(int i, atomic_t *v)
  * true if the result is zero, or false for all
  * other cases.
  */
+#define arch_atomic_sub_and_test arch_atomic_sub_and_test
 static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "subl", v->counter, "er", i, "%0", e);
@@ -117,6 +118,7 @@ static __always_inline void arch_atomic_dec(atomic_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
+#define arch_atomic_dec_and_test arch_atomic_dec_and_test
 static __always_inline bool arch_atomic_dec_and_test(atomic_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, "%0", e);
@@ -130,6 +132,7 @@ static __always_inline bool arch_atomic_dec_and_test(atomic_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
+#define arch_atomic_inc_and_test arch_atomic_inc_and_test
 static __always_inline bool arch_atomic_inc_and_test(atomic_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "incl", v->counter, "%0", e);
@@ -144,6 +147,7 @@ static __always_inline bool arch_atomic_inc_and_test(atomic_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
+#define arch_atomic_add_negative arch_atomic_add_negative
 static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "addl", v->counter, "er", i, "%0", s);
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 2a33cc17801b..a26810d005e0 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -198,20 +198,6 @@ static inline long long arch_atomic64_sub(long long i, atomic64_t *v)
 }
 
 /**
- * arch_atomic64_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer to type atomic64_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
-static inline int arch_atomic64_sub_and_test(long long i, atomic64_t *v)
-{
-	return arch_atomic64_sub_return(i, v) == 0;
-}
-
-/**
  * arch_atomic64_inc - increment atomic64 variable
  * @v: pointer to type atomic64_t
  *
@@ -236,46 +222,6 @@ static inline void arch_atomic64_dec(atomic64_t *v)
 }
 
 /**
- * arch_atomic64_dec_and_test - decrement and test
- * @v: pointer to type atomic64_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
-static inline int arch_atomic64_dec_and_test(atomic64_t *v)
-{
-	return arch_atomic64_dec_return(v) == 0;
-}
-
-/**
- * atomic64_inc_and_test - increment and test
- * @v: pointer to type atomic64_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-static inline int arch_atomic64_inc_and_test(atomic64_t *v)
-{
-	return arch_atomic64_inc_return(v) == 0;
-}
-
-/**
- * arch_atomic64_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer to type atomic64_t
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
-static inline int arch_atomic64_add_negative(long long i, atomic64_t *v)
-{
-	return arch_atomic64_add_return(i, v) < 0;
-}
-
-/**
  * arch_atomic64_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
  * @a: the amount to add to v...
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 7e04b294e6eb..6a65228a3db6 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -71,6 +71,7 @@ static inline void arch_atomic64_sub(long i, atomic64_t *v)
  * true if the result is zero, or false for all
  * other cases.
  */
+#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
 static inline bool arch_atomic64_sub_and_test(long i, atomic64_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "subq", v->counter, "er", i, "%0", e);
@@ -110,6 +111,7 @@ static __always_inline void arch_atomic64_dec(atomic64_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
+#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
 static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, "%0", e);
@@ -123,6 +125,7 @@ static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
+#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
 static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, "%0", e);
@@ -137,6 +140,7 @@ static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
+#define arch_atomic64_add_negative arch_atomic64_add_negative
 static inline bool arch_atomic64_add_negative(long i, atomic64_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, "er", i, "%0", s);
diff --git a/arch/xtensa/include/asm/atomic.h b/arch/xtensa/include/asm/atomic.h
index f4c9f82c40c6..332ae4eca737 100644
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -198,17 +198,6 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP
 
 /**
- * atomic_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
-#define atomic_sub_and_test(i,v) (atomic_sub_return((i),(v)) == 0)
-
-/**
  * atomic_inc - increment atomic variable
  * @v: pointer of type atomic_t
  *
@@ -240,37 +229,6 @@ ATOMIC_OPS(xor)
  */
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 
-/**
- * atomic_dec_and_test - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
-#define atomic_dec_and_test(v) (atomic_sub_return(1,(v)) == 0)
-
-/**
- * atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define atomic_inc_and_test(v) (atomic_add_return(1,(v)) == 0)
-
-/**
- * atomic_add_negative - add and test if negative
- * @v: pointer of type atomic_t
- * @i: integer value to add
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
-#define atomic_add_negative(i,v) (atomic_add_return((i),(v)) < 0)
-
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 2b487f28ef35..6b64c200de73 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -225,29 +225,41 @@ static __always_inline s64 atomic64_dec_if_positive(atomic64_t *v)
 	return arch_atomic64_dec_if_positive(v);
 }
 
+#ifdef arch_atomic_dec_and_test
+#define atomic_dec_and_test atomic_dec_and_test
 static __always_inline bool atomic_dec_and_test(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_dec_and_test(v);
 }
+#endif
 
+#ifdef arch_atomic64_dec_and_test
+#define atomic64_dec_and_test atomic64_dec_and_test
 static __always_inline bool atomic64_dec_and_test(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_and_test(v);
 }
+#endif
 
+#ifdef arch_atomic_inc_and_test
+#define atomic_inc_and_test atomic_inc_and_test
 static __always_inline bool atomic_inc_and_test(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_inc_and_test(v);
 }
+#endif
 
+#ifdef arch_atomic64_inc_and_test
+#define atomic64_inc_and_test atomic64_inc_and_test
 static __always_inline bool atomic64_inc_and_test(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_and_test(v);
 }
+#endif
 
 static __always_inline int atomic_add_return(int i, atomic_t *v)
 {
@@ -333,29 +345,41 @@ static __always_inline s64 atomic64_fetch_xor(s64 i, atomic64_t *v)
 	return arch_atomic64_fetch_xor(i, v);
 }
 
+#ifdef arch_atomic_sub_and_test
+#define atomic_sub_and_test atomic_sub_and_test
 static __always_inline bool atomic_sub_and_test(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_sub_and_test(i, v);
 }
+#endif
 
+#ifdef arch_atomic64_sub_and_test
+#define atomic64_sub_and_test atomic64_sub_and_test
 static __always_inline bool atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_and_test(i, v);
 }
+#endif
 
+#ifdef arch_atomic_add_negative
+#define atomic_add_negative atomic_add_negative
 static __always_inline bool atomic_add_negative(int i, atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_add_negative(i, v);
 }
+#endif
 
+#ifdef arch_atomic64_add_negative
+#define atomic64_add_negative atomic64_add_negative
 static __always_inline bool atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_add_negative(i, v);
 }
+#endif
 
 static __always_inline unsigned long
 cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 757e45821220..40cab858aaaa 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -186,11 +186,6 @@ ATOMIC_OP(xor, ^)
 
 #include <linux/irqflags.h>
 
-static inline int atomic_add_negative(int i, atomic_t *v)
-{
-	return atomic_add_return(i, v) < 0;
-}
-
 static inline void atomic_add(int i, atomic_t *v)
 {
 	atomic_add_return(i, v);
@@ -214,10 +209,6 @@ static inline void atomic_dec(atomic_t *v)
 #define atomic_dec_return(v)		atomic_sub_return(1, (v))
 #define atomic_inc_return(v)		atomic_add_return(1, (v))
 
-#define atomic_sub_and_test(i, v)	(atomic_sub_return((i), (v)) == 0)
-#define atomic_dec_and_test(v)		(atomic_dec_return(v) == 0)
-#define atomic_inc_and_test(v)		(atomic_inc_return(v) == 0)
-
 #define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
 
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 49460107b29a..d3827ab97aa4 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -56,13 +56,9 @@ extern long long atomic64_xchg(atomic64_t *v, long long new);
 extern long long atomic64_fetch_add_unless(atomic64_t *v, long long a, long long u);
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
-#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
 #define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
-#define atomic64_inc_and_test(v) 	(atomic64_inc_return(v) == 0)
-#define atomic64_sub_and_test(a, v)	(atomic64_sub_return((a), (v)) == 0)
 #define atomic64_dec(v)			atomic64_sub(1LL, (v))
 #define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
-#define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
 
 #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 530562ac7909..3ee8da9023cd 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -569,6 +569,68 @@ static inline bool atomic_add_unless(atomic_t *v, int a, int u)
 #define atomic_inc_not_zero(v)		atomic_add_unless((v), 1, 0)
 #endif
 
+/**
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#ifndef atomic_inc_and_test
+static inline bool atomic_inc_and_test(atomic_t *v)
+{
+	return atomic_inc_return(v) == 0;
+}
+#endif
+
+/**
+ * atomic_dec_and_test - decrement and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+#ifndef atomic_dec_and_test
+static inline bool atomic_dec_and_test(atomic_t *v)
+{
+	return atomic_dec_return(v) == 0;
+}
+#endif
+
+/**
+ * atomic_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+#ifndef atomic_sub_and_test
+static inline bool atomic_sub_and_test(int i, atomic_t *v)
+{
+	return atomic_sub_return(i, v) == 0;
+}
+#endif
+
+/**
+ * atomic_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+#ifndef atomic_add_negative
+static inline bool atomic_add_negative(int i, atomic_t *v)
+{
+	return atomic_add_return(i, v) < 0;
+}
+#endif
+
 #ifndef atomic_andnot
 static inline void atomic_andnot(int i, atomic_t *v)
 {
@@ -1091,6 +1153,68 @@ static inline bool atomic64_add_unless(atomic64_t *v, long long a, long long u)
 #define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1, 0)
 #endif
 
+/**
+ * atomic64_inc_and_test - increment and test
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#ifndef atomic64_inc_and_test
+static inline bool atomic64_inc_and_test(atomic64_t *v)
+{
+	return atomic64_inc_return(v) == 0;
+}
+#endif
+
+/**
+ * atomic64_dec_and_test - decrement and test
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+#ifndef atomic64_dec_and_test
+static inline bool atomic64_dec_and_test(atomic64_t *v)
+{
+	return atomic64_dec_return(v) == 0;
+}
+#endif
+
+/**
+ * atomic64_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+#ifndef atomic64_sub_and_test
+static inline bool atomic64_sub_and_test(long long i, atomic64_t *v)
+{
+	return atomic64_sub_return(i, v) == 0;
+}
+#endif
+
+/**
+ * atomic64_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+#ifndef atomic64_add_negative
+static inline bool atomic64_add_negative(long long i, atomic64_t *v)
+{
+	return atomic64_add_return(i, v) < 0;
+}
+#endif
+
 #ifndef atomic64_andnot
 static inline void atomic64_andnot(long long i, atomic64_t *v)
 {
-- 
2.11.0

