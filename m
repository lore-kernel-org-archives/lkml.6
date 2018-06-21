Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F56EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2859208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2859208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933626AbeFUMNr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:13:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49298 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933580AbeFUMNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:13:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C32D6165C;
        Thu, 21 Jun 2018 05:13:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D7BC3F578;
        Thu, 21 Jun 2018 05:13:42 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCHv4 06/18] atomics/treewide: make atomic_fetch_add_unless() optional
Date:   Thu, 21 Jun 2018 13:13:09 +0100
Message-Id: <20180621121321.4761-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180621121321.4761-1-mark.rutland@arm.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several architectures these have a near-identical implementation based
on atomic_read() and atomic_cmpxchg() which we can instead define in
<linux/atomic.h>, so let's do so, using something close to the existing
x86 implementation with try_cmpxchg().

Where an architecture provides its own atomic_fetch_add_unless(), it
must define a preprocessor symbol for it. The instrumented atomics are
updated accordingly.

Note that arch/arc's existing atomic_fetch_add_unless() had redundant
barriers, as these are already present in its atomic_cmpxchg()
implementation.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
---
 arch/alpha/include/asm/atomic.h           |  2 +-
 arch/arc/include/asm/atomic.h             | 28 ----------------------------
 arch/arm/include/asm/atomic.h             | 11 +----------
 arch/arm64/include/asm/atomic.h           |  1 -
 arch/h8300/include/asm/atomic.h           |  1 +
 arch/hexagon/include/asm/atomic.h         |  1 +
 arch/ia64/include/asm/atomic.h            | 16 ----------------
 arch/m68k/include/asm/atomic.h            | 15 ---------------
 arch/mips/include/asm/atomic.h            | 24 ------------------------
 arch/parisc/include/asm/atomic.h          | 24 ------------------------
 arch/powerpc/include/asm/atomic.h         |  1 +
 arch/riscv/include/asm/atomic.h           |  1 +
 arch/s390/include/asm/atomic.h            | 15 ---------------
 arch/sh/include/asm/atomic.h              | 25 -------------------------
 arch/sparc/include/asm/atomic_32.h        |  2 ++
 arch/sparc/include/asm/atomic_64.h        | 15 ---------------
 arch/x86/include/asm/atomic.h             | 21 ---------------------
 arch/xtensa/include/asm/atomic.h          | 24 ------------------------
 include/asm-generic/atomic-instrumented.h |  4 +++-
 include/asm-generic/atomic.h              | 11 -----------
 include/linux/atomic.h                    | 23 +++++++++++++++++++++++
 21 files changed, 34 insertions(+), 231 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index eb0f25e4c5dd..4a800a3424a3 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -235,7 +235,7 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	smp_mb();
 	return old;
 }
-
+#define atomic_fetch_add_unless atomic_fetch_add_unless
 
 /**
  * atomic64_add_unless - add unless the number is a given value
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 1406825b5e7d..60da80481c5d 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -308,34 +308,6 @@ ATOMIC_OPS(xor, ^=, CTOP_INST_AXOR_DI_R2_R2_R3)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-/**
- * atomic_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v
- */
-#define atomic_fetch_add_unless(v, a, u)					\
-({									\
-	int c, old;							\
-									\
-	/*								\
-	 * Explicit full memory barrier needed before/after as		\
-	 * LLOCK/SCOND thmeselves don't provide any such semantics	\
-	 */								\
-	smp_mb();							\
-									\
-	c = atomic_read(v);						\
-	while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c)\
-		c = old;						\
-									\
-	smp_mb();							\
-									\
-	c;								\
-})
-
 #define atomic_inc(v)			atomic_add(1, v)
 #define atomic_dec(v)			atomic_sub(1, v)
 
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 02f3894faa48..74460aa00fa0 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -156,6 +156,7 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 
 	return oldval;
 }
+#define atomic_fetch_add_unless		atomic_fetch_add_unless
 
 #else /* ARM_ARCH_6 */
 
@@ -215,16 +216,6 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return ret;
 }
 
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-
-	c = atomic_read(v);
-	while (c != u && (old = atomic_cmpxchg((v), c, c + a)) != c)
-		c = old;
-	return c;
-}
-
 #endif /* __LINUX_ARM_ARCH__ */
 
 #define ATOMIC_OPS(op, c_op, asm_op)					\
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index ad50412889c5..22c8c43d6689 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -125,7 +125,6 @@
 #define atomic_dec_and_test(v)		(atomic_dec_return(v) == 0)
 #define atomic_sub_and_test(i, v)	(atomic_sub_return((i), (v)) == 0)
 #define atomic_add_negative(i, v)	(atomic_add_return((i), (v)) < 0)
-#define atomic_fetch_add_unless(v, a, u)	___atomic_add_unless(v, a, u,)
 #define atomic_andnot			atomic_andnot
 
 /*
diff --git a/arch/h8300/include/asm/atomic.h b/arch/h8300/include/asm/atomic.h
index 4465cfc30a3a..250bb3baac23 100644
--- a/arch/h8300/include/asm/atomic.h
+++ b/arch/h8300/include/asm/atomic.h
@@ -106,5 +106,6 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	arch_local_irq_restore(flags);
 	return ret;
 }
+#define atomic_fetch_add_unless		atomic_fetch_add_unless
 
 #endif /* __ARCH_H8300_ATOMIC __ */
diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index d2feeba93c44..86c67e9adbfa 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -196,6 +196,7 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	);
 	return __oldval;
 }
+#define atomic_fetch_add_unless atomic_fetch_add_unless
 
 #define atomic_inc(v) atomic_add(1, (v))
 #define atomic_dec(v) atomic_sub(1, (v))
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index 93d48b823220..cfe44086338e 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -215,22 +215,6 @@ ATOMIC64_FETCH_OP(xor, ^)
 	(cmpxchg(&((v)->counter), old, new))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
-static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-	c = atomic_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c;
-}
-
-
 static __inline__ long atomic64_add_unless(atomic64_t *v, long a, long u)
 {
 	long c, old;
diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
index 8022d9ea1213..596882cda224 100644
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -211,19 +211,4 @@ static inline int atomic_add_negative(int i, atomic_t *v)
 	return c != 0;
 }
 
-static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-	c = atomic_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c;
-}
-
 #endif /* __ARCH_M68K_ATOMIC __ */
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 502e691c6393..794734e730d9 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -274,30 +274,6 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), (new)))
 
-/**
- * atomic_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
-static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-	c = atomic_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c;
-}
-
 #define atomic_dec_return(v) atomic_sub_return(1, (v))
 #define atomic_inc_return(v) atomic_add_return(1, (v))
 
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index 3fd0243bf405..b2b6261d05e7 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -77,30 +77,6 @@ static __inline__ int atomic_read(const atomic_t *v)
 #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/**
- * atomic_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
-static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-	c = atomic_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c;
-}
-
 #define ATOMIC_OP(op, c_op)						\
 static __inline__ void atomic_##op(int i, atomic_t *v)			\
 {									\
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index e59620ee4f6b..b5646c079c16 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -248,6 +248,7 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 
 	return t;
 }
+#define atomic_fetch_add_unless atomic_fetch_add_unless
 
 /**
  * atomic_inc_not_zero - increment unless the number is zero
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 18259e90f57e..5f161daefcd2 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -349,6 +349,7 @@ static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 		: "memory");
 	return prev;
 }
+#define atomic_fetch_add_unless atomic_fetch_add_unless
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 static __always_inline long __atomic64_add_unless(atomic64_t *v, long a, long u)
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index 66dac30a4fe1..26c6b713a7a3 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -90,21 +90,6 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return __atomic_cmpxchg(&v->counter, old, new);
 }
 
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-	c = atomic_read(v);
-	for (;;) {
-		if (unlikely(c == u))
-			break;
-		old = atomic_cmpxchg(v, c, c + a);
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c;
-}
-
 #define ATOMIC64_INIT(i)  { (i) }
 
 static inline long atomic64_read(const atomic64_t *v)
diff --git a/arch/sh/include/asm/atomic.h b/arch/sh/include/asm/atomic.h
index ef45931ebac5..422fac764ca1 100644
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -45,31 +45,6 @@
 #define atomic_xchg(v, new)		(xchg(&((v)->counter), new))
 #define atomic_cmpxchg(v, o, n)		(cmpxchg(&((v)->counter), (o), (n)))
 
-/**
- * atomic_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-	c = atomic_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-
-	return c;
-}
-
 #endif /* CONFIG_CPU_J2 */
 
 #endif /* __ASM_SH_ATOMIC_H */
diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index a58f4b43bcc7..9d7a15acc0c5 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -30,6 +30,8 @@ int atomic_xchg(atomic_t *, int);
 int atomic_fetch_add_unless(atomic_t *, int, int);
 void atomic_set(atomic_t *, int);
 
+#define atomic_fetch_add_unless	atomic_fetch_add_unless
+
 #define atomic_set_release(v, i)	atomic_set((v), (i))
 
 #define atomic_read(v)          READ_ONCE((v)->counter)
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index 07830a316464..e4f1c93db31f 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -89,21 +89,6 @@ static inline int atomic_xchg(atomic_t *v, int new)
 	return xchg(&v->counter, new);
 }
 
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-	c = atomic_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c;
-}
-
 #define atomic64_cmpxchg(v, o, n) \
 	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 84ed0bd76aef..616327ac9d39 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -253,27 +253,6 @@ static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 	return val;
 }
 
-/**
- * arch_atomic_fetch_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns the old value of @v.
- */
-static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c = arch_atomic_read(v);
-
-	do {
-		if (unlikely(c == u))
-			break;
-	} while (!arch_atomic_try_cmpxchg(v, &c, c + a));
-
-	return c;
-}
-
 #ifdef CONFIG_X86_32
 # include <asm/atomic64_32.h>
 #else
diff --git a/arch/xtensa/include/asm/atomic.h b/arch/xtensa/include/asm/atomic.h
index 4188e56c06c9..f4c9f82c40c6 100644
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -274,30 +274,6 @@ ATOMIC_OPS(xor)
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/**
- * atomic_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
-static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-	c = atomic_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c;
-}
-
 #endif /* __KERNEL__ */
 
 #endif /* _XTENSA_ATOMIC_H */
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 83bb88d791c4..1f9b2a767d3c 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -84,12 +84,14 @@ static __always_inline bool atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 ne
 }
 #endif
 
+#ifdef arch_atomic_fetch_add_unless
+#define atomic_fetch_add_unless atomic_fetch_add_unless
 static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_unless(v, a, u);
 }
-
+#endif
 
 static __always_inline bool atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 10051ed6d088..757e45821220 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -221,15 +221,4 @@ static inline void atomic_dec(atomic_t *v)
 #define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
 
-#ifndef atomic_fetch_add_unless
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-	c = atomic_read(v);
-	while (c != u && (old = atomic_cmpxchg(v, c, c + a)) != c)
-		c = old;
-	return c;
-}
-#endif
-
 #endif /* __ASM_GENERIC_ATOMIC_H */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index ae3f30923d05..b89ba36cab94 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -522,6 +522,29 @@
 #endif /* xchg_relaxed */
 
 /**
+ * atomic_fetch_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns the original value of @v.
+ */
+#ifndef atomic_fetch_add_unless
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	int c = atomic_read(v);
+
+	do {
+		if (unlikely(c == u))
+			break;
+	} while (!atomic_try_cmpxchg(v, &c, c + a));
+
+	return c;
+}
+#endif
+
+/**
  * atomic_add_unless - add unless the number is already a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
-- 
2.11.0

