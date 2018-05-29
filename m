Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936918AbeE2Poq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:44:46 -0400
Received: from foss.arm.com ([217.140.101.70]:43508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936885AbeE2Poc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:44:32 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCHv2 15/16] atomics/treewide: make unconditional inc/dec ops optional
Date: Tue, 29 May 2018 16:43:45 +0100
Message-Id: <20180529154346.3168-16-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180529154346.3168-1-mark.rutland@arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the inc/dec ops are mandatory, but for most architectures inc/dec are
simply trivial wrappers around their corresponding add/sub ops.

Let's make all the inc/dec ops optional, so that we can get rid of these
boilerplate wrappers.

The instrumented atomics are updated accordingly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/alpha/include/asm/atomic.h           | 12 -----
 arch/arc/include/asm/atomic.h             | 11 -----
 arch/arm/include/asm/atomic.h             | 11 -----
 arch/arm64/include/asm/atomic.h           | 24 ----------
 arch/h8300/include/asm/atomic.h           |  7 ---
 arch/hexagon/include/asm/atomic.h         |  6 ---
 arch/ia64/include/asm/atomic.h            |  9 ----
 arch/m68k/include/asm/atomic.h            |  5 +-
 arch/mips/include/asm/atomic.h            | 38 ----------------
 arch/parisc/include/asm/atomic.h          | 12 -----
 arch/powerpc/include/asm/atomic.h         |  4 ++
 arch/riscv/include/asm/atomic.h           | 76 -------------------------------
 arch/s390/include/asm/atomic.h            |  8 ----
 arch/sh/include/asm/atomic.h              |  6 ---
 arch/sparc/include/asm/atomic_32.h        |  5 --
 arch/sparc/include/asm/atomic_64.h        | 12 -----
 arch/x86/include/asm/atomic.h             |  5 +-
 arch/x86/include/asm/atomic64_32.h        |  4 ++
 arch/x86/include/asm/atomic64_64.h        |  5 +-
 arch/xtensa/include/asm/atomic.h          | 32 -------------
 include/asm-generic/atomic-instrumented.h | 24 ++++++++++
 include/asm-generic/atomic.h              | 13 ------
 include/asm-generic/atomic64.h            |  5 --
 include/linux/atomic.h                    | 48 +++++++++++++++++++
 24 files changed, 86 insertions(+), 296 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 31a4904dc8fc..9c50cc512a78 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -297,16 +297,4 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 	return old - 1;
 }
 
-#define atomic_dec_return(v) atomic_sub_return(1,(v))
-#define atomic64_dec_return(v) atomic64_sub_return(1,(v))
-
-#define atomic_inc_return(v) atomic_add_return(1,(v))
-#define atomic64_inc_return(v) atomic64_add_return(1,(v))
-
-#define atomic_inc(v) atomic_add(1,(v))
-#define atomic64_inc(v) atomic64_add(1,(v))
-
-#define atomic_dec(v) atomic_sub(1,(v))
-#define atomic64_dec(v) atomic64_sub(1,(v))
-
 #endif /* _ALPHA_ATOMIC_H */
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 555b0a94b643..abffdc525b46 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -308,12 +308,6 @@ ATOMIC_OPS(xor, ^=, CTOP_INST_AXOR_DI_R2_R2_R3)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_inc(v)			atomic_add(1, v)
-#define atomic_dec(v)			atomic_sub(1, v)
-
-#define atomic_inc_return(v)		atomic_add_return(1, (v))
-#define atomic_dec_return(v)		atomic_sub_return(1, (v))
-
 #ifdef CONFIG_GENERIC_ATOMIC64
 
 #include <asm-generic/atomic64.h>
@@ -560,11 +554,6 @@ static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
 }
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
-#define atomic64_inc(v)			atomic64_add(1LL, (v))
-#define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
-#define atomic64_dec(v)			atomic64_sub(1LL, (v))
-#define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
-
 #endif	/* !CONFIG_GENERIC_ATOMIC64 */
 
 #endif	/* !__ASSEMBLY__ */
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 35fb7f504daa..5a58d061d3d2 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -245,12 +245,6 @@ ATOMIC_OPS(xor, ^=, eor)
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-#define atomic_inc(v)		atomic_add(1, v)
-#define atomic_dec(v)		atomic_sub(1, v)
-
-#define atomic_inc_return_relaxed(v)    (atomic_add_return_relaxed(1, v))
-#define atomic_dec_return_relaxed(v)    (atomic_sub_return_relaxed(1, v))
-
 #ifndef CONFIG_GENERIC_ATOMIC64
 typedef struct {
 	long long counter;
@@ -512,11 +506,6 @@ static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
 }
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
-#define atomic64_inc(v)			atomic64_add(1LL, (v))
-#define atomic64_inc_return_relaxed(v)	atomic64_add_return_relaxed(1LL, (v))
-#define atomic64_dec(v)			atomic64_sub(1LL, (v))
-#define atomic64_dec_return_relaxed(v)	atomic64_sub_return_relaxed(1LL, (v))
-
 #endif /* !CONFIG_GENERIC_ATOMIC64 */
 #endif
 #endif
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index edbe53fa3106..078f785cd97f 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -50,21 +50,11 @@
 #define atomic_add_return_release	atomic_add_return_release
 #define atomic_add_return		atomic_add_return
 
-#define atomic_inc_return_relaxed(v)	atomic_add_return_relaxed(1, (v))
-#define atomic_inc_return_acquire(v)	atomic_add_return_acquire(1, (v))
-#define atomic_inc_return_release(v)	atomic_add_return_release(1, (v))
-#define atomic_inc_return(v)		atomic_add_return(1, (v))
-
 #define atomic_sub_return_relaxed	atomic_sub_return_relaxed
 #define atomic_sub_return_acquire	atomic_sub_return_acquire
 #define atomic_sub_return_release	atomic_sub_return_release
 #define atomic_sub_return		atomic_sub_return
 
-#define atomic_dec_return_relaxed(v)	atomic_sub_return_relaxed(1, (v))
-#define atomic_dec_return_acquire(v)	atomic_sub_return_acquire(1, (v))
-#define atomic_dec_return_release(v)	atomic_sub_return_release(1, (v))
-#define atomic_dec_return(v)		atomic_sub_return(1, (v))
-
 #define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
 #define atomic_fetch_add_acquire	atomic_fetch_add_acquire
 #define atomic_fetch_add_release	atomic_fetch_add_release
@@ -108,8 +98,6 @@
 	cmpxchg_release(&((v)->counter), (old), (new))
 #define atomic_cmpxchg(v, old, new)	cmpxchg(&((v)->counter), (old), (new))
 
-#define atomic_inc(v)			atomic_add(1, (v))
-#define atomic_dec(v)			atomic_sub(1, (v))
 #define atomic_andnot			atomic_andnot
 
 /*
@@ -124,21 +112,11 @@
 #define atomic64_add_return_release	atomic64_add_return_release
 #define atomic64_add_return		atomic64_add_return
 
-#define atomic64_inc_return_relaxed(v)	atomic64_add_return_relaxed(1, (v))
-#define atomic64_inc_return_acquire(v)	atomic64_add_return_acquire(1, (v))
-#define atomic64_inc_return_release(v)	atomic64_add_return_release(1, (v))
-#define atomic64_inc_return(v)		atomic64_add_return(1, (v))
-
 #define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
 #define atomic64_sub_return_acquire	atomic64_sub_return_acquire
 #define atomic64_sub_return_release	atomic64_sub_return_release
 #define atomic64_sub_return		atomic64_sub_return
 
-#define atomic64_dec_return_relaxed(v)	atomic64_sub_return_relaxed(1, (v))
-#define atomic64_dec_return_acquire(v)	atomic64_sub_return_acquire(1, (v))
-#define atomic64_dec_return_release(v)	atomic64_sub_return_release(1, (v))
-#define atomic64_dec_return(v)		atomic64_sub_return(1, (v))
-
 #define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
 #define atomic64_fetch_add_acquire	atomic64_fetch_add_acquire
 #define atomic64_fetch_add_release	atomic64_fetch_add_release
@@ -179,8 +157,6 @@
 #define atomic64_cmpxchg_release	atomic_cmpxchg_release
 #define atomic64_cmpxchg		atomic_cmpxchg
 
-#define atomic64_inc(v)			atomic64_add(1, (v))
-#define atomic64_dec(v)			atomic64_sub(1, (v))
 #define atomic64_andnot			atomic64_andnot
 
 #endif
diff --git a/arch/h8300/include/asm/atomic.h b/arch/h8300/include/asm/atomic.h
index b658b20d2232..532f3409f751 100644
--- a/arch/h8300/include/asm/atomic.h
+++ b/arch/h8300/include/asm/atomic.h
@@ -69,13 +69,6 @@ ATOMIC_OPS(sub, -=)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_inc_return(v)		atomic_add_return(1, v)
-#define atomic_dec_return(v)		atomic_sub_return(1, v)
-
-#define atomic_inc(v)			(void)atomic_inc_return(v)
-
-#define atomic_dec(v)			(void)atomic_dec_return(v)
-
 static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 31638f511674..311b9894ccc8 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -198,10 +198,4 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 }
 #define atomic_fetch_add_unless atomic_fetch_add_unless
 
-#define atomic_inc(v) atomic_add(1, (v))
-#define atomic_dec(v) atomic_sub(1, (v))
-
-#define atomic_inc_return(v) (atomic_add_return(1, v))
-#define atomic_dec_return(v) (atomic_sub_return(1, v))
-
 #endif
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index e4143c462e65..46a15a974bed 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -231,19 +231,10 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 	return dec;
 }
 
-#define atomic_dec_return(v)		atomic_sub_return(1, (v))
-#define atomic_inc_return(v)		atomic_add_return(1, (v))
-#define atomic64_dec_return(v)		atomic64_sub_return(1, (v))
-#define atomic64_inc_return(v)		atomic64_add_return(1, (v))
-
 #define atomic_add(i,v)			(void)atomic_add_return((i), (v))
 #define atomic_sub(i,v)			(void)atomic_sub_return((i), (v))
-#define atomic_inc(v)			atomic_add(1, (v))
-#define atomic_dec(v)			atomic_sub(1, (v))
 
 #define atomic64_add(i,v)		(void)atomic64_add_return((i), (v))
 #define atomic64_sub(i,v)		(void)atomic64_sub_return((i), (v))
-#define atomic64_inc(v)			atomic64_add(1, (v))
-#define atomic64_dec(v)			atomic64_sub(1, (v))
 
 #endif /* _ASM_IA64_ATOMIC_H */
diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
index 9df09c876fa2..47228b0d4163 100644
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -126,11 +126,13 @@ static inline void atomic_inc(atomic_t *v)
 {
 	__asm__ __volatile__("addql #1,%0" : "+m" (*v));
 }
+#define atomic_inc atomic_inc
 
 static inline void atomic_dec(atomic_t *v)
 {
 	__asm__ __volatile__("subql #1,%0" : "+m" (*v));
 }
+#define atomic_dec atomic_dec
 
 static inline int atomic_dec_and_test(atomic_t *v)
 {
@@ -192,9 +194,6 @@ static inline int atomic_xchg(atomic_t *v, int new)
 
 #endif /* !CONFIG_RMW_INSNS */
 
-#define atomic_dec_return(v)	atomic_sub_return(1, (v))
-#define atomic_inc_return(v)	atomic_add_return(1, (v))
-
 static inline int atomic_sub_and_test(int i, atomic_t *v)
 {
 	char c;
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index fd3008ae164c..79be687de4ab 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -274,31 +274,12 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), (new)))
 
-#define atomic_dec_return(v) atomic_sub_return(1, (v))
-#define atomic_inc_return(v) atomic_add_return(1, (v))
-
 /*
  * atomic_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic_t
  */
 #define atomic_dec_if_positive(v)	atomic_sub_if_positive(1, v)
 
-/*
- * atomic_inc - increment atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1.
- */
-#define atomic_inc(v) atomic_add(1, (v))
-
-/*
- * atomic_dec - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1.
- */
-#define atomic_dec(v) atomic_sub(1, (v))
-
 #ifdef CONFIG_64BIT
 
 #define ATOMIC64_INIT(i)    { (i) }
@@ -554,31 +535,12 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), (new)))
 
-#define atomic64_dec_return(v) atomic64_sub_return(1, (v))
-#define atomic64_inc_return(v) atomic64_add_return(1, (v))
-
 /*
  * atomic64_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic64_t
  */
 #define atomic64_dec_if_positive(v)	atomic64_sub_if_positive(1, v)
 
-/*
- * atomic64_inc - increment atomic variable
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1.
- */
-#define atomic64_inc(v) atomic64_add(1, (v))
-
-/*
- * atomic64_dec - decrement and test
- * @v: pointer of type atomic64_t
- *
- * Atomically decrements @v by 1.
- */
-#define atomic64_dec(v) atomic64_sub(1, (v))
-
 #endif /* CONFIG_64BIT */
 
 #endif /* _ASM_ATOMIC_H */
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index f85844ff6336..10bc490327c1 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -136,12 +136,6 @@ ATOMIC_OPS(xor, ^=)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_inc(v)	(atomic_add(   1,(v)))
-#define atomic_dec(v)	(atomic_add(  -1,(v)))
-
-#define atomic_inc_return(v)	(atomic_add_return(   1,(v)))
-#define atomic_dec_return(v)	(atomic_add_return(  -1,(v)))
-
 #define ATOMIC_INIT(i)	{ (i) }
 
 #ifdef CONFIG_64BIT
@@ -224,12 +218,6 @@ atomic64_read(const atomic64_t *v)
 	return READ_ONCE((v)->counter);
 }
 
-#define atomic64_inc(v)		(atomic64_add(   1,(v)))
-#define atomic64_dec(v)		(atomic64_add(  -1,(v)))
-
-#define atomic64_inc_return(v)		(atomic64_add_return(   1,(v)))
-#define atomic64_dec_return(v)		(atomic64_add_return(  -1,(v)))
-
 /* exported interface */
 #define atomic64_cmpxchg(v, o, n) \
 	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 5d76f05d2be3..ebaefdee4a57 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -143,6 +143,7 @@ static __inline__ void atomic_inc(atomic_t *v)
 	: "r" (&v->counter)
 	: "cc", "xer");
 }
+#define atomic_inc atomic_inc
 
 static __inline__ int atomic_inc_return_relaxed(atomic_t *v)
 {
@@ -175,6 +176,7 @@ static __inline__ void atomic_dec(atomic_t *v)
 	: "r" (&v->counter)
 	: "cc", "xer");
 }
+#define atomic_dec atomic_dec
 
 static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
 {
@@ -411,6 +413,7 @@ static __inline__ void atomic64_inc(atomic64_t *v)
 	: "r" (&v->counter)
 	: "cc", "xer");
 }
+#define atomic64_inc atomic64_inc
 
 static __inline__ long atomic64_inc_return_relaxed(atomic64_t *v)
 {
@@ -441,6 +444,7 @@ static __inline__ void atomic64_dec(atomic64_t *v)
 	: "r" (&v->counter)
 	: "cc", "xer");
 }
+#define atomic64_dec atomic64_dec
 
 static __inline__ long atomic64_dec_return_relaxed(atomic64_t *v)
 {
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 68eef0a805ca..512b89485790 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -209,82 +209,6 @@ ATOMIC_OPS(xor, xor, i)
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 
-#define ATOMIC_OP(op, func_op, I, c_type, prefix)			\
-static __always_inline							\
-void atomic##prefix##_##op(atomic##prefix##_t *v)			\
-{									\
-	atomic##prefix##_##func_op(I, v);				\
-}
-
-#define ATOMIC_FETCH_OP(op, func_op, I, c_type, prefix)			\
-static __always_inline							\
-c_type atomic##prefix##_fetch_##op##_relaxed(atomic##prefix##_t *v)	\
-{									\
-	return atomic##prefix##_fetch_##func_op##_relaxed(I, v);	\
-}									\
-static __always_inline							\
-c_type atomic##prefix##_fetch_##op(atomic##prefix##_t *v)		\
-{									\
-	return atomic##prefix##_fetch_##func_op(I, v);			\
-}
-
-#define ATOMIC_OP_RETURN(op, asm_op, c_op, I, c_type, prefix)		\
-static __always_inline							\
-c_type atomic##prefix##_##op##_return_relaxed(atomic##prefix##_t *v)	\
-{									\
-        return atomic##prefix##_fetch_##op##_relaxed(v) c_op I;		\
-}									\
-static __always_inline							\
-c_type atomic##prefix##_##op##_return(atomic##prefix##_t *v)		\
-{									\
-        return atomic##prefix##_fetch_##op(v) c_op I;			\
-}
-
-#ifdef CONFIG_GENERIC_ATOMIC64
-#define ATOMIC_OPS(op, asm_op, c_op, I)					\
-        ATOMIC_OP(       op, asm_op,       I,  int,   )			\
-        ATOMIC_FETCH_OP( op, asm_op,       I,  int,   )			\
-        ATOMIC_OP_RETURN(op, asm_op, c_op, I,  int,   )
-#else
-#define ATOMIC_OPS(op, asm_op, c_op, I)					\
-        ATOMIC_OP(       op, asm_op,       I,  int,   )			\
-        ATOMIC_FETCH_OP( op, asm_op,       I,  int,   )			\
-        ATOMIC_OP_RETURN(op, asm_op, c_op, I,  int,   )			\
-        ATOMIC_OP(       op, asm_op,       I, long, 64)			\
-        ATOMIC_FETCH_OP( op, asm_op,       I, long, 64)			\
-        ATOMIC_OP_RETURN(op, asm_op, c_op, I, long, 64)
-#endif
-
-ATOMIC_OPS(inc, add, +,  1)
-ATOMIC_OPS(dec, add, +, -1)
-
-#define atomic_inc_return_relaxed	atomic_inc_return_relaxed
-#define atomic_dec_return_relaxed	atomic_dec_return_relaxed
-#define atomic_inc_return		atomic_inc_return
-#define atomic_dec_return		atomic_dec_return
-
-#define atomic_fetch_inc_relaxed	atomic_fetch_inc_relaxed
-#define atomic_fetch_dec_relaxed	atomic_fetch_dec_relaxed
-#define atomic_fetch_inc		atomic_fetch_inc
-#define atomic_fetch_dec		atomic_fetch_dec
-
-#ifndef CONFIG_GENERIC_ATOMIC64
-#define atomic64_inc_return_relaxed	atomic64_inc_return_relaxed
-#define atomic64_dec_return_relaxed	atomic64_dec_return_relaxed
-#define atomic64_inc_return		atomic64_inc_return
-#define atomic64_dec_return		atomic64_dec_return
-
-#define atomic64_fetch_inc_relaxed	atomic64_fetch_inc_relaxed
-#define atomic64_fetch_dec_relaxed	atomic64_fetch_dec_relaxed
-#define atomic64_fetch_inc		atomic64_fetch_inc
-#define atomic64_fetch_dec		atomic64_fetch_dec
-#endif
-
-#undef ATOMIC_OPS
-#undef ATOMIC_OP
-#undef ATOMIC_FETCH_OP
-#undef ATOMIC_OP_RETURN
-
 /* This is required to provide a full barrier on success. */
 static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index 7f5fbd595f01..376e64af951f 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -55,13 +55,9 @@ static inline void atomic_add(int i, atomic_t *v)
 	__atomic_add(i, &v->counter);
 }
 
-#define atomic_inc(_v)			atomic_add(1, _v)
-#define atomic_inc_return(_v)		atomic_add_return(1, _v)
 #define atomic_sub(_i, _v)		atomic_add(-(int)(_i), _v)
 #define atomic_sub_return(_i, _v)	atomic_add_return(-(int)(_i), _v)
 #define atomic_fetch_sub(_i, _v)	atomic_fetch_add(-(int)(_i), _v)
-#define atomic_dec(_v)			atomic_sub(1, _v)
-#define atomic_dec_return(_v)		atomic_sub_return(1, _v)
 
 #define ATOMIC_OPS(op)							\
 static inline void atomic_##op(int i, atomic_t *v)			\
@@ -166,12 +162,8 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 	return dec;
 }
 
-#define atomic64_inc(_v)		atomic64_add(1, _v)
-#define atomic64_inc_return(_v)		atomic64_add_return(1, _v)
 #define atomic64_sub_return(_i, _v)	atomic64_add_return(-(long)(_i), _v)
 #define atomic64_fetch_sub(_i, _v)	atomic64_fetch_add(-(long)(_i), _v)
 #define atomic64_sub(_i, _v)		atomic64_add(-(long)(_i), _v)
-#define atomic64_dec(_v)		atomic64_sub(1, _v)
-#define atomic64_dec_return(_v)		atomic64_sub_return(1, _v)
 
 #endif /* __ARCH_S390_ATOMIC__  */
diff --git a/arch/sh/include/asm/atomic.h b/arch/sh/include/asm/atomic.h
index d438494fa112..f37b95a80232 100644
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -32,12 +32,6 @@
 #include <asm/atomic-irq.h>
 #endif
 
-#define atomic_dec_return(v)		atomic_sub_return(1, (v))
-#define atomic_inc_return(v)		atomic_add_return(1, (v))
-
-#define atomic_inc(v)			atomic_add(1, (v))
-#define atomic_dec(v)			atomic_sub(1, (v))
-
 #define atomic_xchg(v, new)		(xchg(&((v)->counter), new))
 #define atomic_cmpxchg(v, o, n)		(cmpxchg(&((v)->counter), (o), (n)))
 
diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index 3a26573790c6..94c930f0bc62 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -38,8 +38,6 @@ void atomic_set(atomic_t *, int);
 
 #define atomic_add(i, v)	((void)atomic_add_return( (int)(i), (v)))
 #define atomic_sub(i, v)	((void)atomic_add_return(-(int)(i), (v)))
-#define atomic_inc(v)		((void)atomic_add_return(        1, (v)))
-#define atomic_dec(v)		((void)atomic_add_return(       -1, (v)))
 
 #define atomic_and(i, v)	((void)atomic_fetch_and((i), (v)))
 #define atomic_or(i, v)		((void)atomic_fetch_or((i), (v)))
@@ -48,7 +46,4 @@ void atomic_set(atomic_t *, int);
 #define atomic_sub_return(i, v)	(atomic_add_return(-(int)(i), (v)))
 #define atomic_fetch_sub(i, v)  (atomic_fetch_add (-(int)(i), (v)))
 
-#define atomic_inc_return(v)	(atomic_add_return(        1, (v)))
-#define atomic_dec_return(v)	(atomic_add_return(       -1, (v)))
-
 #endif /* !(__ARCH_SPARC_ATOMIC__) */
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index 634508282aea..304865c7cdbb 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -50,18 +50,6 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_dec_return(v)   atomic_sub_return(1, v)
-#define atomic64_dec_return(v) atomic64_sub_return(1, v)
-
-#define atomic_inc_return(v)   atomic_add_return(1, v)
-#define atomic64_inc_return(v) atomic64_add_return(1, v)
-
-#define atomic_inc(v) atomic_add(1, v)
-#define atomic64_inc(v) atomic64_add(1, v)
-
-#define atomic_dec(v) atomic_sub(1, v)
-#define atomic64_dec(v) atomic64_sub(1, v)
-
 #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 
 static inline int atomic_xchg(atomic_t *v, int new)
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 73bda4abe180..823fd2f320cf 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -92,6 +92,7 @@ static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
  *
  * Atomically increments @v by 1.
  */
+#define arch_atomic_inc arch_atomic_inc
 static __always_inline void arch_atomic_inc(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "incl %0"
@@ -104,6 +105,7 @@ static __always_inline void arch_atomic_inc(atomic_t *v)
  *
  * Atomically decrements @v by 1.
  */
+#define arch_atomic_dec arch_atomic_dec
 static __always_inline void arch_atomic_dec(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "decl %0"
@@ -177,9 +179,6 @@ static __always_inline int arch_atomic_sub_return(int i, atomic_t *v)
 	return arch_atomic_add_return(-i, v);
 }
 
-#define arch_atomic_inc_return(v)  (arch_atomic_add_return(1, v))
-#define arch_atomic_dec_return(v)  (arch_atomic_sub_return(1, v))
-
 static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 {
 	return xadd(&v->counter, i);
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index a26810d005e0..472c7af0ed48 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -158,6 +158,7 @@ static inline long long arch_atomic64_inc_return(atomic64_t *v)
 			     "S" (v) : "memory", "ecx");
 	return a;
 }
+#define arch_atomic64_inc_return arch_atomic64_inc_return
 
 static inline long long arch_atomic64_dec_return(atomic64_t *v)
 {
@@ -166,6 +167,7 @@ static inline long long arch_atomic64_dec_return(atomic64_t *v)
 			     "S" (v) : "memory", "ecx");
 	return a;
 }
+#define arch_atomic64_dec_return arch_atomic64_dec_return
 
 /**
  * arch_atomic64_add - add integer to atomic64 variable
@@ -203,6 +205,7 @@ static inline long long arch_atomic64_sub(long long i, atomic64_t *v)
  *
  * Atomically increments @v by 1.
  */
+#define arch_atomic64_inc arch_atomic64_inc
 static inline void arch_atomic64_inc(atomic64_t *v)
 {
 	__alternative_atomic64(inc, inc_return, /* no output */,
@@ -215,6 +218,7 @@ static inline void arch_atomic64_inc(atomic64_t *v)
  *
  * Atomically decrements @v by 1.
  */
+#define arch_atomic64_dec arch_atomic64_dec
 static inline void arch_atomic64_dec(atomic64_t *v)
 {
 	__alternative_atomic64(dec, dec_return, /* no output */,
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 6a65228a3db6..1b282272a801 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -83,6 +83,7 @@ static inline bool arch_atomic64_sub_and_test(long i, atomic64_t *v)
  *
  * Atomically increments @v by 1.
  */
+#define arch_atomic64_inc arch_atomic64_inc
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "incq %0"
@@ -96,6 +97,7 @@ static __always_inline void arch_atomic64_inc(atomic64_t *v)
  *
  * Atomically decrements @v by 1.
  */
+#define arch_atomic64_dec arch_atomic64_dec
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "decq %0"
@@ -173,9 +175,6 @@ static inline long arch_atomic64_fetch_sub(long i, atomic64_t *v)
 	return xadd(&v->counter, -i);
 }
 
-#define arch_atomic64_inc_return(v)  (arch_atomic64_add_return(1, (v)))
-#define arch_atomic64_dec_return(v)  (arch_atomic64_sub_return(1, (v)))
-
 static inline long arch_atomic64_cmpxchg(atomic64_t *v, long old, long new)
 {
 	return arch_cmpxchg(&v->counter, old, new);
diff --git a/arch/xtensa/include/asm/atomic.h b/arch/xtensa/include/asm/atomic.h
index 332ae4eca737..7de0149e1cf7 100644
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -197,38 +197,6 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-/**
- * atomic_inc - increment atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1.
- */
-#define atomic_inc(v) atomic_add(1,(v))
-
-/**
- * atomic_inc - increment atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1.
- */
-#define atomic_inc_return(v) atomic_add_return(1,(v))
-
-/**
- * atomic_dec - decrement atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1.
- */
-#define atomic_dec(v) atomic_sub(1,(v))
-
-/**
- * atomic_dec_return - decrement atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1.
- */
-#define atomic_dec_return(v) atomic_sub_return(1,(v))
-
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index b59edd520e39..8c9887a0cb1d 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -102,29 +102,41 @@ static __always_inline int atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u
 }
 #endif
 
+#ifdef arch_atomic_inc
+#define atomic_inc atomic_inc
 static __always_inline void atomic_inc(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	arch_atomic_inc(v);
 }
+#endif
 
+#ifdef arch_atomic64_inc
+#define atomic64_inc atomic64_inc
 static __always_inline void atomic64_inc(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	arch_atomic64_inc(v);
 }
+#endif
 
+#ifdef arch_atomic_dec
+#define atomic_dec atomic_dec
 static __always_inline void atomic_dec(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	arch_atomic_dec(v);
 }
+#endif
 
+#ifdef atch_atomic64_dec
+#define atomic64_dec
 static __always_inline void atomic64_dec(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	arch_atomic64_dec(v);
 }
+#endif
 
 static __always_inline void atomic_add(int i, atomic_t *v)
 {
@@ -186,29 +198,41 @@ static __always_inline void atomic64_xor(s64 i, atomic64_t *v)
 	arch_atomic64_xor(i, v);
 }
 
+#ifdef arch_atomic_inc_return
+#define atomic_inc_return atomic_inc_return
 static __always_inline int atomic_inc_return(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_inc_return(v);
 }
+#endif
 
+#ifdef arch_atomic64_in_return
+#define atomic64_inc_return atomic64_inc_return
 static __always_inline s64 atomic64_inc_return(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_return(v);
 }
+#endif
 
+#ifdef arch_atomic_dec_return
+#define atomic_dec_return atomic_dec_return
 static __always_inline int atomic_dec_return(atomic_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_dec_return(v);
 }
+#endif
 
+#ifdef arch_atomic64_dec_return
+#define atomic64_dec_return atomic64_dec_return
 static __always_inline s64 atomic64_dec_return(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_return(v);
 }
+#endif
 
 #ifdef arch_atomic64_inc_not_zero
 #define atomic64_inc_not_zero atomic64_inc_not_zero
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 40cab858aaaa..13324aa828eb 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -196,19 +196,6 @@ static inline void atomic_sub(int i, atomic_t *v)
 	atomic_sub_return(i, v);
 }
 
-static inline void atomic_inc(atomic_t *v)
-{
-	atomic_add_return(1, v);
-}
-
-static inline void atomic_dec(atomic_t *v)
-{
-	atomic_sub_return(1, v);
-}
-
-#define atomic_dec_return(v)		atomic_sub_return(1, (v))
-#define atomic_inc_return(v)		atomic_add_return(1, (v))
-
 #define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
 
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 15fe7cca29ab..1810a0ca96ec 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -55,9 +55,4 @@ extern long long atomic64_xchg(atomic64_t *v, long long new);
 extern long long atomic64_fetch_add_unless(atomic64_t *v, long long a, long long u);
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
-#define atomic64_inc(v)			atomic64_add(1LL, (v))
-#define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
-#define atomic64_dec(v)			atomic64_sub(1LL, (v))
-#define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
-
 #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8ec4d120b264..d6ec2dc37057 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -95,11 +95,23 @@
 #endif
 #endif /* atomic_add_return_relaxed */
 
+#ifndef atomic_inc
+#define atomic_inc(v)			atomic_add(1, (v))
+#endif
+
 /* atomic_inc_return_relaxed */
 #ifndef atomic_inc_return_relaxed
+
+#ifndef atomic_inc_return
+#define atomic_inc_return(v)		atomic_add_return(1, (v))
+#define atomic_inc_return_relaxed(v)	atomic_add_return_relaxed(1, (v))
+#define atomic_inc_return_acquire(v)	atomic_add_return_acquire(1, (v))
+#define atomic_inc_return_release(v)	atomic_add_return_release(1, (v))
+#else /* atomic_inc_return */
 #define  atomic_inc_return_relaxed	atomic_inc_return
 #define  atomic_inc_return_acquire	atomic_inc_return
 #define  atomic_inc_return_release	atomic_inc_return
+#endif /* atomic_inc_return */
 
 #else /* atomic_inc_return_relaxed */
 
@@ -143,11 +155,23 @@
 #endif
 #endif /* atomic_sub_return_relaxed */
 
+#ifndef atomic_dec
+#define atomic_dec(v)			atomic_sub(1, (v))
+#endif
+
 /* atomic_dec_return_relaxed */
 #ifndef atomic_dec_return_relaxed
+
+#ifndef atomic_dec_return
+#define atomic_dec_return(v)		atomic_sub_return(1, (v))
+#define atomic_dec_return_relaxed(v)	atomic_sub_return_relaxed(1, (v))
+#define atomic_dec_return_acquire(v)	atomic_sub_return_acquire(1, (v))
+#define atomic_dec_return_release(v)	atomic_sub_return_release(1, (v))
+#else /* atomic_dec_return */
 #define  atomic_dec_return_relaxed	atomic_dec_return
 #define  atomic_dec_return_acquire	atomic_dec_return
 #define  atomic_dec_return_release	atomic_dec_return
+#endif /* atomic_dec_return */
 
 #else /* atomic_dec_return_relaxed */
 
@@ -745,11 +769,23 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 #endif
 #endif /* atomic64_add_return_relaxed */
 
+#ifndef atomic64_inc
+#define atomic64_inc(v)			atomic64_add(1, (v))
+#endif
+
 /* atomic64_inc_return_relaxed */
 #ifndef atomic64_inc_return_relaxed
+
+#ifndef atomic64_inc_return
+#define atomic64_inc_return(v)		atomic64_add_return(1, (v))
+#define atomic64_inc_return_relaxed(v)	atomic64_add_return_relaxed(1, (v))
+#define atomic64_inc_return_acquire(v)	atomic64_add_return_acquire(1, (v))
+#define atomic64_inc_return_release(v)	atomic64_add_return_release(1, (v))
+#else /* atomic64_inc_return */
 #define  atomic64_inc_return_relaxed	atomic64_inc_return
 #define  atomic64_inc_return_acquire	atomic64_inc_return
 #define  atomic64_inc_return_release	atomic64_inc_return
+#endif /* atomic64_inc_return */
 
 #else /* atomic64_inc_return_relaxed */
 
@@ -794,11 +830,23 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 #endif
 #endif /* atomic64_sub_return_relaxed */
 
+#ifndef atomic64_dec
+#define atomic64_dec(v)			atomic64_sub(1, (v))
+#endif
+
 /* atomic64_dec_return_relaxed */
 #ifndef atomic64_dec_return_relaxed
+
+#ifndef atomic64_dec_return
+#define atomic64_dec_return(v)		atomic64_sub_return(1, (v))
+#define atomic64_dec_return_relaxed(v)	atomic64_sub_return_relaxed(1, (v))
+#define atomic64_dec_return_acquire(v)	atomic64_sub_return_acquire(1, (v))
+#define atomic64_dec_return_release(v)	atomic64_sub_return_release(1, (v))
+#else /* atomic64_dec_return */
 #define  atomic64_dec_return_relaxed	atomic64_dec_return
 #define  atomic64_dec_return_acquire	atomic64_dec_return
 #define  atomic64_dec_return_release	atomic64_dec_return
+#endif /* atomic64_dec_return */
 
 #else /* atomic64_dec_return_relaxed */
 
-- 
2.11.0
