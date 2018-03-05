Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeCESYs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:24:48 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38566 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeCESYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:24:47 -0500
X-Google-Smtp-Source: AG47ELtGd+SpOSg+t1nvtehGBvtmKfWQJffMY/+nAusS+og5Up1fSxh9ReNZxjPfLByOzQ67jf7+5Q==
From: Andrea Parri <parri.andrea@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Cc: Daniel Lustig <dlustig@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [RFC PATCH 2/2] riscv/atomic: Strengthen implementations with fences
Date: Mon,  5 Mar 2018 19:24:36 +0100
Message-Id: <1520274276-21871-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atomics present the same issue with locking: release and acquire
variants need to be strengthened to meet the constraints defined
by the Linux-kernel memory consistency model [1].

Atomics present a further issue: implementations of atomics such
as atomic_cmpxchg() and atomic_add_unless() rely on LR/SC pairs,
which do not give full-ordering with .aqrl; for example, current
implementations allow the "lr-sc-aqrl-pair-vs-full-barrier" test
below to end up with the state indicated in the "exists" clause.

In order to "synchronize" LKMM and RISC-V's implementation, this
commit strengthens the implementations of the atomics operations
by replacing .rl and .aq with the use of ("lightweigth") fences,
and by replacing .aqrl LR/SC pairs in sequences such as:

  0:      lr.w.aqrl  %0, %addr
          bne        %0, %old, 1f
          ...
          sc.w.aqrl  %1, %new, %addr
          bnez       %1, 0b
  1:

with sequences of the form:

  0:      lr.w       %0, %addr
          bne        %0, %old, 1f
          ...
          sc.w.rl    %1, %new, %addr   /* SC-release   */
          bnez       %1, 0b
          fence      rw, rw            /* "full" fence */
  1:

following Daniel's suggestion.

These modifications were validated with simulation of the RISC-V
memory consistency model.

C lr-sc-aqrl-pair-vs-full-barrier

{}

P0(int *x, int *y, atomic_t *u)
{
	int r0;
	int r1;

	WRITE_ONCE(*x, 1);
	r0 = atomic_cmpxchg(u, 0, 1);
	r1 = READ_ONCE(*y);
}

P1(int *x, int *y, atomic_t *v)
{
	int r0;
	int r1;

	WRITE_ONCE(*y, 1);
	r0 = atomic_cmpxchg(v, 0, 1);
	r1 = READ_ONCE(*x);
}

exists (u=1 /\ v=1 /\ 0:r1=0 /\ 1:r1=0)

[1] https://marc.info/?l=linux-kernel&m=151930201102853&w=2
    https://groups.google.com/a/groups.riscv.org/forum/#!topic/isa-dev/hKywNHBkAXM
    https://marc.info/?l=linux-kernel&m=151633436614259&w=2

Suggested-by: Daniel Lustig <dlustig@nvidia.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/riscv/include/asm/atomic.h  | 417 +++++++++++++++++++++++++--------------
 arch/riscv/include/asm/cmpxchg.h | 391 +++++++++++++++++++++++++++++-------
 2 files changed, 588 insertions(+), 220 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index e65d1cd89e28b..d004a153bbf58 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -24,6 +24,20 @@
 #include <asm/barrier.h>
 
 #define ATOMIC_INIT(i)	{ (i) }
+
+#define __atomic_op_acquire(op, args...)				\
+({									\
+	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
+	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory");	\
+	__ret;								\
+})
+
+#define __atomic_op_release(op, args...)				\
+({									\
+	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");	\
+	op##_relaxed(args);						\
+})
+
 static __always_inline int atomic_read(const atomic_t *v)
 {
 	return READ_ONCE(v->counter);
@@ -50,22 +64,23 @@ static __always_inline void atomic64_set(atomic64_t *v, long i)
  * have the AQ or RL bits set.  These don't return anything, so there's only
  * one version to worry about.
  */
-#define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)				\
-static __always_inline void atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
-{											\
-	__asm__ __volatile__ (								\
-		"amo" #asm_op "." #asm_type " zero, %1, %0"				\
-		: "+A" (v->counter)							\
-		: "r" (I)								\
-		: "memory");								\
-}
+#define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)		\
+static __always_inline							\
+void atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)		\
+{									\
+	__asm__ __volatile__ (						\
+		"	amo" #asm_op "." #asm_type " zero, %1, %0"	\
+		: "+A" (v->counter)					\
+		: "r" (I)						\
+		: "memory");						\
+}									\
 
 #ifdef CONFIG_GENERIC_ATOMIC64
-#define ATOMIC_OPS(op, asm_op, I)			\
+#define ATOMIC_OPS(op, asm_op, I)					\
         ATOMIC_OP (op, asm_op, I, w,  int,   )
 #else
-#define ATOMIC_OPS(op, asm_op, I)			\
-        ATOMIC_OP (op, asm_op, I, w,  int,   )	\
+#define ATOMIC_OPS(op, asm_op, I)					\
+        ATOMIC_OP (op, asm_op, I, w,  int,   )				\
         ATOMIC_OP (op, asm_op, I, d, long, 64)
 #endif
 
@@ -79,75 +94,115 @@ ATOMIC_OPS(xor, xor,  i)
 #undef ATOMIC_OPS
 
 /*
- * Atomic ops that have ordered, relaxed, acquire, and relese variants.
+ * Atomic ops that have ordered, relaxed, acquire, and release variants.
  * There's two flavors of these: the arithmatic ops have both fetch and return
  * versions, while the logical ops only have fetch versions.
  */
-#define ATOMIC_FETCH_OP(op, asm_op, I, asm_or, c_or, asm_type, c_type, prefix)				\
-static __always_inline c_type atomic##prefix##_fetch_##op##c_or(c_type i, atomic##prefix##_t *v)	\
-{													\
-	register c_type ret;										\
-	__asm__ __volatile__ (										\
-		"amo" #asm_op "." #asm_type #asm_or " %1, %2, %0"					\
-		: "+A" (v->counter), "=r" (ret)								\
-		: "r" (I)										\
-		: "memory");										\
-	return ret;											\
+#define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)	\
+static __always_inline							\
+c_type atomic##prefix##_fetch_##op##_relaxed(c_type i,			\
+					     atomic##prefix##_t *v)	\
+{									\
+	register c_type ret;						\
+	__asm__ __volatile__ (						\
+		"	amo" #asm_op "." #asm_type " %1, %2, %0"	\
+		: "+A" (v->counter), "=r" (ret)				\
+		: "r" (I)						\
+		: "memory");						\
+	return ret;							\
+}									\
+static __always_inline							\
+c_type atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
+{									\
+	register c_type ret;						\
+	__asm__ __volatile__ (						\
+		"	amo" #asm_op "." #asm_type ".aqrl  %1, %2, %0"	\
+		: "+A" (v->counter), "=r" (ret)				\
+		: "r" (I)						\
+		: "memory");						\
+	return ret;							\
 }
 
-#define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_or, c_or, asm_type, c_type, prefix)			\
-static __always_inline c_type atomic##prefix##_##op##_return##c_or(c_type i, atomic##prefix##_t *v)	\
-{													\
-        return atomic##prefix##_fetch_##op##c_or(i, v) c_op I;						\
+#define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)	\
+static __always_inline							\
+c_type atomic##prefix##_##op##_return_relaxed(c_type i,			\
+					      atomic##prefix##_t *v)	\
+{									\
+        return atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;	\
+}									\
+static __always_inline							\
+c_type atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
+{									\
+        return atomic##prefix##_fetch_##op(i, v) c_op I;		\
 }
 
 #ifdef CONFIG_GENERIC_ATOMIC64
-#define ATOMIC_OPS(op, asm_op, c_op, I, asm_or, c_or)				\
-        ATOMIC_FETCH_OP (op, asm_op,       I, asm_or, c_or, w,  int,   )	\
-        ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_or, c_or, w,  int,   )
+#define ATOMIC_OPS(op, asm_op, c_op, I)					\
+        ATOMIC_FETCH_OP( op, asm_op,       I, w,  int,   )		\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I, w,  int,   )
 #else
-#define ATOMIC_OPS(op, asm_op, c_op, I, asm_or, c_or)				\
-        ATOMIC_FETCH_OP (op, asm_op,       I, asm_or, c_or, w,  int,   )	\
-        ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_or, c_or, w,  int,   )	\
-        ATOMIC_FETCH_OP (op, asm_op,       I, asm_or, c_or, d, long, 64)	\
-        ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_or, c_or, d, long, 64)
+#define ATOMIC_OPS(op, asm_op, c_op, I)					\
+        ATOMIC_FETCH_OP( op, asm_op,       I, w,  int,   )		\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I, w,  int,   )		\
+        ATOMIC_FETCH_OP( op, asm_op,       I, d, long, 64)		\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I, d, long, 64)
 #endif
 
-ATOMIC_OPS(add, add, +,  i,      , _relaxed)
-ATOMIC_OPS(add, add, +,  i, .aq  , _acquire)
-ATOMIC_OPS(add, add, +,  i, .rl  , _release)
-ATOMIC_OPS(add, add, +,  i, .aqrl,         )
+ATOMIC_OPS(add, add, +,  i)
+ATOMIC_OPS(sub, add, +, -i)
+
+#define atomic_add_return_relaxed	atomic_add_return_relaxed
+#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
+#define atomic_add_return		atomic_add_return
+#define atomic_sub_return		atomic_sub_return
 
-ATOMIC_OPS(sub, add, +, -i,      , _relaxed)
-ATOMIC_OPS(sub, add, +, -i, .aq  , _acquire)
-ATOMIC_OPS(sub, add, +, -i, .rl  , _release)
-ATOMIC_OPS(sub, add, +, -i, .aqrl,         )
+#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
+#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+#define atomic_fetch_add		atomic_fetch_add
+#define atomic_fetch_sub		atomic_fetch_sub
+
+#ifndef CONFIG_GENERIC_ATOMIC64
+#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
+#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
+#define atomic64_add_return		atomic64_add_return
+#define atomic64_sub_return		atomic64_sub_return
+
+#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
+#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+#define atomic64_fetch_add		atomic64_fetch_add
+#define atomic64_fetch_sub		atomic64_fetch_sub
+#endif
 
 #undef ATOMIC_OPS
 
 #ifdef CONFIG_GENERIC_ATOMIC64
-#define ATOMIC_OPS(op, asm_op, I, asm_or, c_or)				\
-        ATOMIC_FETCH_OP(op, asm_op, I, asm_or, c_or, w,  int,   )
+#define ATOMIC_OPS(op, asm_op, I)					\
+        ATOMIC_FETCH_OP(op, asm_op, I, w,  int,   )
 #else
-#define ATOMIC_OPS(op, asm_op, I, asm_or, c_or)				\
-        ATOMIC_FETCH_OP(op, asm_op, I, asm_or, c_or, w,  int,   )	\
-        ATOMIC_FETCH_OP(op, asm_op, I, asm_or, c_or, d, long, 64)
+#define ATOMIC_OPS(op, asm_op, I)					\
+        ATOMIC_FETCH_OP(op, asm_op, I, w,  int,   )			\
+        ATOMIC_FETCH_OP(op, asm_op, I, d, long, 64)
 #endif
 
-ATOMIC_OPS(and, and, i,      , _relaxed)
-ATOMIC_OPS(and, and, i, .aq  , _acquire)
-ATOMIC_OPS(and, and, i, .rl  , _release)
-ATOMIC_OPS(and, and, i, .aqrl,         )
+ATOMIC_OPS(and, and, i)
+ATOMIC_OPS( or,  or, i)
+ATOMIC_OPS(xor, xor, i)
 
-ATOMIC_OPS( or,  or, i,      , _relaxed)
-ATOMIC_OPS( or,  or, i, .aq  , _acquire)
-ATOMIC_OPS( or,  or, i, .rl  , _release)
-ATOMIC_OPS( or,  or, i, .aqrl,         )
+#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
+#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
+#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+#define atomic_fetch_and		atomic_fetch_and
+#define atomic_fetch_or			atomic_fetch_or
+#define atomic_fetch_xor		atomic_fetch_xor
 
-ATOMIC_OPS(xor, xor, i,      , _relaxed)
-ATOMIC_OPS(xor, xor, i, .aq  , _acquire)
-ATOMIC_OPS(xor, xor, i, .rl  , _release)
-ATOMIC_OPS(xor, xor, i, .aqrl,         )
+#ifndef CONFIG_GENERIC_ATOMIC64
+#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
+#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
+#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+#define atomic64_fetch_and		atomic64_fetch_and
+#define atomic64_fetch_or		atomic64_fetch_or
+#define atomic64_fetch_xor		atomic64_fetch_xor
+#endif
 
 #undef ATOMIC_OPS
 
@@ -157,22 +212,24 @@ ATOMIC_OPS(xor, xor, i, .aqrl,         )
 /*
  * The extra atomic operations that are constructed from one of the core
  * AMO-based operations above (aside from sub, which is easier to fit above).
- * These are required to perform a barrier, but they're OK this way because
- * atomic_*_return is also required to perform a barrier.
+ * These are required to perform a full barrier, but they're OK this way
+ * because atomic_*_return is also required to perform a full barrier.
+ *
  */
-#define ATOMIC_OP(op, func_op, comp_op, I, c_type, prefix)			\
-static __always_inline bool atomic##prefix##_##op(c_type i, atomic##prefix##_t *v) \
-{										\
-	return atomic##prefix##_##func_op##_return(i, v) comp_op I;		\
+#define ATOMIC_OP(op, func_op, comp_op, I, c_type, prefix)		\
+static __always_inline							\
+bool atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)		\
+{									\
+	return atomic##prefix##_##func_op##_return(i, v) comp_op I;	\
 }
 
 #ifdef CONFIG_GENERIC_ATOMIC64
-#define ATOMIC_OPS(op, func_op, comp_op, I)			\
-        ATOMIC_OP (op, func_op, comp_op, I,  int,   )
+#define ATOMIC_OPS(op, func_op, comp_op, I)				\
+        ATOMIC_OP(op, func_op, comp_op, I,  int,   )
 #else
-#define ATOMIC_OPS(op, func_op, comp_op, I)			\
-        ATOMIC_OP (op, func_op, comp_op, I,  int,   )		\
-        ATOMIC_OP (op, func_op, comp_op, I, long, 64)
+#define ATOMIC_OPS(op, func_op, comp_op, I)				\
+        ATOMIC_OP(op, func_op, comp_op, I,  int,   )			\
+        ATOMIC_OP(op, func_op, comp_op, I, long, 64)
 #endif
 
 ATOMIC_OPS(add_and_test, add, ==, 0)
@@ -182,51 +239,87 @@ ATOMIC_OPS(add_negative, add,  <, 0)
 #undef ATOMIC_OP
 #undef ATOMIC_OPS
 
-#define ATOMIC_OP(op, func_op, I, c_type, prefix)				\
-static __always_inline void atomic##prefix##_##op(atomic##prefix##_t *v)	\
-{										\
-	atomic##prefix##_##func_op(I, v);					\
+#define ATOMIC_OP(op, func_op, I, c_type, prefix)			\
+static __always_inline							\
+void atomic##prefix##_##op(atomic##prefix##_t *v)			\
+{									\
+	atomic##prefix##_##func_op(I, v);				\
 }
 
-#define ATOMIC_FETCH_OP(op, func_op, I, c_type, prefix)					\
-static __always_inline c_type atomic##prefix##_fetch_##op(atomic##prefix##_t *v)	\
-{											\
-	return atomic##prefix##_fetch_##func_op(I, v);					\
+#define ATOMIC_FETCH_OP(op, func_op, I, c_type, prefix)			\
+static __always_inline							\
+c_type atomic##prefix##_fetch_##op##_relaxed(atomic##prefix##_t *v)	\
+{									\
+	return atomic##prefix##_fetch_##func_op##_relaxed(I, v);	\
+}									\
+static __always_inline							\
+c_type atomic##prefix##_fetch_##op(atomic##prefix##_t *v)		\
+{									\
+	return atomic##prefix##_fetch_##func_op(I, v);			\
 }
 
-#define ATOMIC_OP_RETURN(op, asm_op, c_op, I, c_type, prefix)				\
-static __always_inline c_type atomic##prefix##_##op##_return(atomic##prefix##_t *v)	\
-{											\
-        return atomic##prefix##_fetch_##op(v) c_op I;					\
+#define ATOMIC_OP_RETURN(op, asm_op, c_op, I, c_type, prefix)		\
+static __always_inline							\
+c_type atomic##prefix##_##op##_return_relaxed(atomic##prefix##_t *v)	\
+{									\
+        return atomic##prefix##_fetch_##op##_relaxed(v) c_op I;		\
+}									\
+static __always_inline							\
+c_type atomic##prefix##_##op##_return(atomic##prefix##_t *v)		\
+{									\
+        return atomic##prefix##_fetch_##op(v) c_op I;			\
 }
 
 #ifdef CONFIG_GENERIC_ATOMIC64
-#define ATOMIC_OPS(op, asm_op, c_op, I)						\
-        ATOMIC_OP       (op, asm_op,       I,  int,   )				\
-        ATOMIC_FETCH_OP (op, asm_op,       I,  int,   )				\
+#define ATOMIC_OPS(op, asm_op, c_op, I)					\
+        ATOMIC_OP(       op, asm_op,       I,  int,   )			\
+        ATOMIC_FETCH_OP( op, asm_op,       I,  int,   )			\
         ATOMIC_OP_RETURN(op, asm_op, c_op, I,  int,   )
 #else
-#define ATOMIC_OPS(op, asm_op, c_op, I)						\
-        ATOMIC_OP       (op, asm_op,       I,  int,   )				\
-        ATOMIC_FETCH_OP (op, asm_op,       I,  int,   )				\
-        ATOMIC_OP_RETURN(op, asm_op, c_op, I,  int,   )				\
-        ATOMIC_OP       (op, asm_op,       I, long, 64)				\
-        ATOMIC_FETCH_OP (op, asm_op,       I, long, 64)				\
+#define ATOMIC_OPS(op, asm_op, c_op, I)					\
+        ATOMIC_OP(       op, asm_op,       I,  int,   )			\
+        ATOMIC_FETCH_OP( op, asm_op,       I,  int,   )			\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I,  int,   )			\
+        ATOMIC_OP(       op, asm_op,       I, long, 64)			\
+        ATOMIC_FETCH_OP( op, asm_op,       I, long, 64)			\
         ATOMIC_OP_RETURN(op, asm_op, c_op, I, long, 64)
 #endif
 
 ATOMIC_OPS(inc, add, +,  1)
 ATOMIC_OPS(dec, add, +, -1)
 
+#define atomic_inc_return_relaxed	atomic_inc_return_relaxed
+#define atomic_dec_return_relaxed	atomic_dec_return_relaxed
+#define atomic_inc_return		atomic_inc_return
+#define atomic_dec_return		atomic_dec_return
+
+#define atomic_fetch_inc_relaxed	atomic_fetch_inc_relaxed
+#define atomic_fetch_dec_relaxed	atomic_fetch_dec_relaxed
+#define atomic_fetch_inc		atomic_fetch_inc
+#define atomic_fetch_dec		atomic_fetch_dec
+
+#ifndef CONFIG_GENERIC_ATOMIC64
+#define atomic64_inc_return_relaxed	atomic64_inc_return_relaxed
+#define atomic64_dec_return_relaxed	atomic64_dec_return_relaxed
+#define atomic64_inc_return		atomic64_inc_return
+#define atomic64_dec_return		atomic64_dec_return
+
+#define atomic64_fetch_inc_relaxed	atomic64_fetch_inc_relaxed
+#define atomic64_fetch_dec_relaxed	atomic64_fetch_dec_relaxed
+#define atomic64_fetch_inc		atomic64_fetch_inc
+#define atomic64_fetch_dec		atomic64_fetch_dec
+#endif
+
 #undef ATOMIC_OPS
 #undef ATOMIC_OP
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 
-#define ATOMIC_OP(op, func_op, comp_op, I, prefix)				\
-static __always_inline bool atomic##prefix##_##op(atomic##prefix##_t *v)	\
-{										\
-	return atomic##prefix##_##func_op##_return(v) comp_op I;		\
+#define ATOMIC_OP(op, func_op, comp_op, I, prefix)			\
+static __always_inline							\
+bool atomic##prefix##_##op(atomic##prefix##_t *v)			\
+{									\
+	return atomic##prefix##_##func_op##_return(v) comp_op I;	\
 }
 
 ATOMIC_OP(inc_and_test, inc, ==, 0,   )
@@ -238,19 +331,19 @@ ATOMIC_OP(dec_and_test, dec, ==, 0, 64)
 
 #undef ATOMIC_OP
 
-/* This is required to provide a barrier on success. */
+/* This is required to provide a full barrier on success. */
 static __always_inline int __atomic_add_unless(atomic_t *v, int a, int u)
 {
        int prev, rc;
 
 	__asm__ __volatile__ (
-		"0:\n\t"
-		"lr.w.aqrl  %[p],  %[c]\n\t"
-		"beq        %[p],  %[u], 1f\n\t"
-		"add       %[rc],  %[p], %[a]\n\t"
-		"sc.w.aqrl %[rc], %[rc], %[c]\n\t"
-		"bnez      %[rc], 0b\n\t"
-		"1:"
+		"0:	lr.w     %[p],  %[c]\n"
+		"	beq      %[p],  %[u], 1f\n"
+		"	add      %[rc], %[p], %[a]\n"
+		"	sc.w.rl  %[rc], %[rc], %[c]\n"
+		"	bnez     %[rc], 0b\n"
+		"	fence    rw, rw\n"
+		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [a]"r" (a), [u]"r" (u)
 		: "memory");
@@ -263,13 +356,13 @@ static __always_inline long __atomic64_add_unless(atomic64_t *v, long a, long u)
        long prev, rc;
 
 	__asm__ __volatile__ (
-		"0:\n\t"
-		"lr.d.aqrl  %[p],  %[c]\n\t"
-		"beq        %[p],  %[u], 1f\n\t"
-		"add       %[rc],  %[p], %[a]\n\t"
-		"sc.d.aqrl %[rc], %[rc], %[c]\n\t"
-		"bnez      %[rc], 0b\n\t"
-		"1:"
+		"0:	lr.d     %[p],  %[c]\n"
+		"	beq      %[p],  %[u], 1f\n"
+		"	add      %[rc], %[p], %[a]\n"
+		"	sc.d.rl  %[rc], %[rc], %[c]\n"
+		"	bnez     %[rc], 0b\n"
+		"	fence    rw, rw\n"
+		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [a]"r" (a), [u]"r" (u)
 		: "memory");
@@ -300,37 +393,63 @@ static __always_inline long atomic64_inc_not_zero(atomic64_t *v)
 
 /*
  * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
- * {cmp,}xchg and the operations that return, so they need a barrier.
- */
-/*
- * FIXME: atomic_cmpxchg_{acquire,release,relaxed} are all implemented by
- * assigning the same barrier to both the LR and SC operations, but that might
- * not make any sense.  We're waiting on a memory model specification to
- * determine exactly what the right thing to do is here.
+ * {cmp,}xchg and the operations that return, so they need a full barrier.
  */
-#define ATOMIC_OP(c_t, prefix, c_or, size, asm_or)						\
-static __always_inline c_t atomic##prefix##_cmpxchg##c_or(atomic##prefix##_t *v, c_t o, c_t n) 	\
-{												\
-	return __cmpxchg(&(v->counter), o, n, size, asm_or, asm_or);				\
-}												\
-static __always_inline c_t atomic##prefix##_xchg##c_or(atomic##prefix##_t *v, c_t n) 		\
-{												\
-	return __xchg(n, &(v->counter), size, asm_or);						\
+#define ATOMIC_OP(c_t, prefix, size)					\
+static __always_inline							\
+c_t atomic##prefix##_xchg_relaxed(atomic##prefix##_t *v, c_t n)		\
+{									\
+	return __xchg_relaxed(&(v->counter), n, size);			\
+}									\
+static __always_inline							\
+c_t atomic##prefix##_xchg_acquire(atomic##prefix##_t *v, c_t n)		\
+{									\
+	return __xchg_acquire(&(v->counter), n, size);			\
+}									\
+static __always_inline							\
+c_t atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)		\
+{									\
+	return __xchg_acquire(&(v->counter), n, size);			\
+}									\
+static __always_inline							\
+c_t atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)			\
+{									\
+	return __xchg(&(v->counter), n, size);				\
+}									\
+static __always_inline							\
+c_t atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,		\
+				     c_t o, c_t n)			\
+{									\
+	return __cmpxchg_relaxed(&(v->counter), o, n, size);		\
+}									\
+static __always_inline							\
+c_t atomic##prefix##_cmpxchg_acquire(atomic##prefix##_t *v,		\
+				     c_t o, c_t n)			\
+{									\
+	return __cmpxchg_acquire(&(v->counter), o, n, size);		\
+}									\
+static __always_inline							\
+c_t atomic##prefix##_cmpxchg_release(atomic##prefix##_t *v,		\
+				     c_t o, c_t n)			\
+{									\
+	return __cmpxchg_acquire(&(v->counter), o, n, size);		\
+}									\
+static __always_inline							\
+c_t atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
+{									\
+	return __cmpxchg(&(v->counter), o, n, size);			\
 }
 
 #ifdef CONFIG_GENERIC_ATOMIC64
-#define ATOMIC_OPS(c_or, asm_or)			\
-	ATOMIC_OP( int,   , c_or, 4, asm_or)
+#define ATOMIC_OPS()							\
+	ATOMIC_OP( int,   , 4)
 #else
-#define ATOMIC_OPS(c_or, asm_or)			\
-	ATOMIC_OP( int,   , c_or, 4, asm_or)		\
-	ATOMIC_OP(long, 64, c_or, 8, asm_or)
+#define ATOMIC_OPS()							\
+	ATOMIC_OP( int,   , 4)						\
+	ATOMIC_OP(long, 64, 8)
 #endif
 
-ATOMIC_OPS(        , .aqrl)
-ATOMIC_OPS(_acquire,   .aq)
-ATOMIC_OPS(_release,   .rl)
-ATOMIC_OPS(_relaxed,      )
+ATOMIC_OPS()
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP
@@ -340,13 +459,13 @@ static __always_inline int atomic_sub_if_positive(atomic_t *v, int offset)
        int prev, rc;
 
 	__asm__ __volatile__ (
-		"0:\n\t"
-		"lr.w.aqrl  %[p],  %[c]\n\t"
-		"sub       %[rc],  %[p], %[o]\n\t"
-		"bltz      %[rc],    1f\n\t"
-		"sc.w.aqrl %[rc], %[rc], %[c]\n\t"
-		"bnez      %[rc],    0b\n\t"
-		"1:"
+		"0:	lr.w     %[p],  %[c]\n"
+		"	sub      %[rc], %[p], %[o]\n"
+		"	bltz     %[rc], 1f\n"
+		"	sc.w.rl  %[rc], %[rc], %[c]\n"
+		"	bnez     %[rc], 0b\n"
+		"	fence    rw, rw\n"
+		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [o]"r" (offset)
 		: "memory");
@@ -361,13 +480,13 @@ static __always_inline long atomic64_sub_if_positive(atomic64_t *v, int offset)
        long prev, rc;
 
 	__asm__ __volatile__ (
-		"0:\n\t"
-		"lr.d.aqrl  %[p],  %[c]\n\t"
-		"sub       %[rc],  %[p], %[o]\n\t"
-		"bltz      %[rc],    1f\n\t"
-		"sc.d.aqrl %[rc], %[rc], %[c]\n\t"
-		"bnez      %[rc],    0b\n\t"
-		"1:"
+		"0:	lr.d     %[p],  %[c]\n"
+		"	sub      %[rc], %[p], %[o]\n"
+		"	bltz     %[rc], 1f\n"
+		"	sc.d.rl  %[rc], %[rc], %[c]\n"
+		"	bnez     %[rc], 0b\n"
+		"	fence    rw, rw\n"
+		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [o]"r" (offset)
 		: "memory");
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index db249dbc7b976..c12833f7b6bd1 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -17,45 +17,153 @@
 #include <linux/bug.h>
 
 #include <asm/barrier.h>
+#include <asm/fence.h>
 
-#define __xchg(new, ptr, size, asm_or)				\
-({								\
-	__typeof__(ptr) __ptr = (ptr);				\
-	__typeof__(new) __new = (new);				\
-	__typeof__(*(ptr)) __ret;				\
-	switch (size) {						\
-	case 4:							\
-		__asm__ __volatile__ (				\
-			"amoswap.w" #asm_or " %0, %2, %1"	\
-			: "=r" (__ret), "+A" (*__ptr)		\
-			: "r" (__new)				\
-			: "memory");				\
-		break;						\
-	case 8:							\
-		__asm__ __volatile__ (				\
-			"amoswap.d" #asm_or " %0, %2, %1"	\
-			: "=r" (__ret), "+A" (*__ptr)		\
-			: "r" (__new)				\
-			: "memory");				\
-		break;						\
-	default:						\
-		BUILD_BUG();					\
-	}							\
-	__ret;							\
-})
-
-#define xchg(ptr, x)    (__xchg((x), (ptr), sizeof(*(ptr)), .aqrl))
-
-#define xchg32(ptr, x)				\
-({						\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 4);	\
-	xchg((ptr), (x));			\
-})
-
-#define xchg64(ptr, x)				\
-({						\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);	\
-	xchg((ptr), (x));			\
+#define __xchg_relaxed(ptr, new, size)					\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(new) __new = (new);					\
+	__typeof__(*(ptr)) __ret;					\
+	switch (size) {							\
+	case 4:								\
+		__asm__ __volatile__ (					\
+			"	amoswap.w %0, %2, %1\n"			\
+			: "=r" (__ret), "+A" (*__ptr)			\
+			: "r" (__new)					\
+			: "memory");					\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__ (					\
+			"	amoswap.d %0, %2, %1\n"			\
+			: "=r" (__ret), "+A" (*__ptr)			\
+			: "r" (__new)					\
+			: "memory");					\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
+
+#define xchg_relaxed(ptr, x)						\
+({									\
+	__typeof__(*(ptr)) _x_ = (x);					\
+	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
+					    _x_, sizeof(*(ptr)));	\
+})
+
+#define __xchg_acquire(ptr, new, size)					\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(new) __new = (new);					\
+	__typeof__(*(ptr)) __ret;					\
+	switch (size) {							\
+	case 4:								\
+		__asm__ __volatile__ (					\
+			"	amoswap.w %0, %2, %1\n"			\
+			RISCV_ACQUIRE_BARRIER				\
+			: "=r" (__ret), "+A" (*__ptr)			\
+			: "r" (__new)					\
+			: "memory");					\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__ (					\
+			"	amoswap.d %0, %2, %1\n"			\
+			RISCV_ACQUIRE_BARRIER				\
+			: "=r" (__ret), "+A" (*__ptr)			\
+			: "r" (__new)					\
+			: "memory");					\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
+
+#define xchg_acquire(ptr, x)						\
+({									\
+	__typeof__(*(ptr)) _x_ = (x);					\
+	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
+					    _x_, sizeof(*(ptr)));	\
+})
+
+#define __xchg_release(ptr, new, size)					\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(new) __new = (new);					\
+	__typeof__(*(ptr)) __ret;					\
+	switch (size) {							\
+	case 4:								\
+		__asm__ __volatile__ (					\
+			RISCV_RELEASE_BARRIER				\
+			"	amoswap.w %0, %2, %1\n"			\
+			: "=r" (__ret), "+A" (*__ptr)			\
+			: "r" (__new)					\
+			: "memory");					\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__ (					\
+			RISCV_RELEASE_BARRIER				\
+			"	amoswap.d %0, %2, %1\n"			\
+			: "=r" (__ret), "+A" (*__ptr)			\
+			: "r" (__new)					\
+			: "memory");					\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
+
+#define xchg_release(ptr, x)						\
+({									\
+	__typeof__(*(ptr)) _x_ = (x);					\
+	(__typeof__(*(ptr))) __xchg_release((ptr),			\
+					    _x_, sizeof(*(ptr)));	\
+})
+
+#define __xchg(ptr, new, size)						\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(new) __new = (new);					\
+	__typeof__(*(ptr)) __ret;					\
+	switch (size) {							\
+	case 4:								\
+		__asm__ __volatile__ (					\
+			"	amoswap.w.aqrl %0, %2, %1\n"		\
+			: "=r" (__ret), "+A" (*__ptr)			\
+			: "r" (__new)					\
+			: "memory");					\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__ (					\
+			"	amoswap.d.aqrl %0, %2, %1\n"		\
+			: "=r" (__ret), "+A" (*__ptr)			\
+			: "r" (__new)					\
+			: "memory");					\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
+
+#define xchg(ptr, x)							\
+({									\
+	__typeof__(*(ptr)) _x_ = (x);					\
+	(__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));	\
+})
+
+#define xchg32(ptr, x)							\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
+	xchg((ptr), (x));						\
+})
+
+#define xchg64(ptr, x)							\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	xchg((ptr), (x));						\
 })
 
 /*
@@ -63,7 +171,51 @@
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  */
-#define __cmpxchg(ptr, old, new, size, lrb, scb)			\
+#define __cmpxchg_relaxed(ptr, old, new, size)				\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(*(ptr)) __old = (old);				\
+	__typeof__(*(ptr)) __new = (new);				\
+	__typeof__(*(ptr)) __ret;					\
+	register unsigned int __rc;					\
+	switch (size) {							\
+	case 4:								\
+		__asm__ __volatile__ (					\
+			"0:	lr.w %0, %2\n"				\
+			"	bne  %0, %z3, 1f\n"			\
+			"	sc.w %1, %z4, %2\n"			\
+			"	bnez %1, 0b\n"				\
+			"1:\n"						\
+			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
+			: "rJ" (__old), "rJ" (__new)			\
+			: "memory");					\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__ (					\
+			"0:	lr.d %0, %2\n"				\
+			"	bne %0, %z3, 1f\n"			\
+			"	sc.d %1, %z4, %2\n"			\
+			"	bnez %1, 0b\n"				\
+			"1:\n"						\
+			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
+			: "rJ" (__old), "rJ" (__new)			\
+			: "memory");					\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
+
+#define cmpxchg_relaxed(ptr, o, n)					\
+({									\
+	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _n_ = (n);					\
+	(__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),			\
+					_o_, _n_, sizeof(*(ptr)));	\
+})
+
+#define __cmpxchg_acquire(ptr, old, new, size)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(ptr)) __old = (old);				\
@@ -73,24 +225,24 @@
 	switch (size) {							\
 	case 4:								\
 		__asm__ __volatile__ (					\
-		"0:"							\
-			"lr.w" #scb " %0, %2\n"				\
-			"bne         %0, %z3, 1f\n"			\
-			"sc.w" #lrb " %1, %z4, %2\n"			\
-			"bnez        %1, 0b\n"				\
-		"1:"							\
+			"0:	lr.w %0, %2\n"				\
+			"	bne  %0, %z3, 1f\n"			\
+			"	sc.w %1, %z4, %2\n"			\
+			"	bnez %1, 0b\n"				\
+			RISCV_ACQUIRE_BARRIER				\
+			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" (__old), "rJ" (__new)			\
 			: "memory");					\
 		break;							\
 	case 8:								\
 		__asm__ __volatile__ (					\
-		"0:"							\
-			"lr.d" #scb " %0, %2\n"				\
-			"bne         %0, %z3, 1f\n"			\
-			"sc.d" #lrb " %1, %z4, %2\n"			\
-			"bnez        %1, 0b\n"				\
-		"1:"							\
+			"0:	lr.d %0, %2\n"				\
+			"	bne %0, %z3, 1f\n"			\
+			"	sc.d %1, %z4, %2\n"			\
+			"	bnez %1, 0b\n"				\
+			RISCV_ACQUIRE_BARRIER				\
+			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" (__old), "rJ" (__new)			\
 			: "memory");					\
@@ -101,34 +253,131 @@
 	__ret;								\
 })
 
-#define cmpxchg(ptr, o, n) \
-	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr)), .aqrl, .aqrl))
+#define cmpxchg_acquire(ptr, o, n)					\
+({									\
+	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _n_ = (n);					\
+	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
+					_o_, _n_, sizeof(*(ptr)));	\
+})
 
-#define cmpxchg_local(ptr, o, n) \
-	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr)), , ))
+#define __cmpxchg_release(ptr, old, new, size)				\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(*(ptr)) __old = (old);				\
+	__typeof__(*(ptr)) __new = (new);				\
+	__typeof__(*(ptr)) __ret;					\
+	register unsigned int __rc;					\
+	switch (size) {							\
+	case 4:								\
+		__asm__ __volatile__ (					\
+			RISCV_RELEASE_BARRIER				\
+			"0:	lr.w %0, %2\n"				\
+			"	bne  %0, %z3, 1f\n"			\
+			"	sc.w %1, %z4, %2\n"			\
+			"	bnez %1, 0b\n"				\
+			"1:\n"						\
+			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
+			: "rJ" (__old), "rJ" (__new)			\
+			: "memory");					\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__ (					\
+			RISCV_RELEASE_BARRIER				\
+			"0:	lr.d %0, %2\n"				\
+			"	bne %0, %z3, 1f\n"			\
+			"	sc.d %1, %z4, %2\n"			\
+			"	bnez %1, 0b\n"				\
+			"1:\n"						\
+			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
+			: "rJ" (__old), "rJ" (__new)			\
+			: "memory");					\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
+
+#define cmpxchg_release(ptr, o, n)					\
+({									\
+	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _n_ = (n);					\
+	(__typeof__(*(ptr))) __cmpxchg_release((ptr),			\
+					_o_, _n_, sizeof(*(ptr)));	\
+})
+
+#define __cmpxchg(ptr, old, new, size)					\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(*(ptr)) __old = (old);				\
+	__typeof__(*(ptr)) __new = (new);				\
+	__typeof__(*(ptr)) __ret;					\
+	register unsigned int __rc;					\
+	switch (size) {							\
+	case 4:								\
+		__asm__ __volatile__ (					\
+			"0:	lr.w %0, %2\n"				\
+			"	bne  %0, %z3, 1f\n"			\
+			"	sc.w.rl %1, %z4, %2\n"			\
+			"	bnez %1, 0b\n"				\
+			"	fence rw, rw\n"				\
+			"1:\n"						\
+			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
+			: "rJ" (__old), "rJ" (__new)			\
+			: "memory");					\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__ (					\
+			"0:	lr.d %0, %2\n"				\
+			"	bne %0, %z3, 1f\n"			\
+			"	sc.d.rl %1, %z4, %2\n"			\
+			"	bnez %1, 0b\n"				\
+			"	fence rw, rw\n"				\
+			"1:\n"						\
+			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
+			: "rJ" (__old), "rJ" (__new)			\
+			: "memory");					\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
 
-#define cmpxchg32(ptr, o, n)			\
-({						\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 4);	\
-	cmpxchg((ptr), (o), (n));		\
+#define cmpxchg(ptr, o, n)						\
+({									\
+	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _n_ = (n);					\
+	(__typeof__(*(ptr))) __cmpxchg((ptr),				\
+				       _o_, _n_, sizeof(*(ptr)));	\
 })
 
-#define cmpxchg32_local(ptr, o, n)		\
-({						\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 4);	\
-	cmpxchg_local((ptr), (o), (n));		\
+#define cmpxchg_local(ptr, o, n)					\
+	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
+
+#define cmpxchg32(ptr, o, n)						\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
+	cmpxchg((ptr), (o), (n));					\
 })
 
-#define cmpxchg64(ptr, o, n)			\
-({						\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);	\
-	cmpxchg((ptr), (o), (n));		\
+#define cmpxchg32_local(ptr, o, n)					\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
+	cmpxchg_relaxed((ptr), (o), (n))				\
 })
 
-#define cmpxchg64_local(ptr, o, n)		\
-({						\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);	\
-	cmpxchg_local((ptr), (o), (n));		\
+#define cmpxchg64(ptr, o, n)						\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	cmpxchg((ptr), (o), (n));					\
+})
+
+#define cmpxchg64_local(ptr, o, n)					\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	cmpxchg_relaxed((ptr), (o), (n));				\
 })
 
 #endif /* _ASM_RISCV_CMPXCHG_H */
-- 
2.7.4
