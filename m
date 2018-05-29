Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965184AbeE2PrG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:47:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43500 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936850AbeE2Po0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:44:26 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCHv2 12/16] atomics/treewide: make atomic64_fetch_add_unless() optional
Date: Tue, 29 May 2018 16:43:42 +0100
Message-Id: <20180529154346.3168-13-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180529154346.3168-1-mark.rutland@arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures with atomic64_fetch_add_unless provide a preprocessor
symbol if they do so, and all other architectures have trivial C
implementations of atomic64_add_unless() which are near-identical.

Let's unify the trivial definitions of atomic64_fetch_add_unless() in
<linux/atomic.h>, so that we always have both
atomic64_fetch_add_unless() and atomic64_add_unless() with less
boilerplate code.

This means that atomic64_add_unless() is always implemented in core
code, and the instrumented atomics are updated accordingly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic.h           | 12 ------------
 arch/ia64/include/asm/atomic.h            | 15 ---------------
 arch/mips/include/asm/atomic.h            | 24 ------------------------
 arch/parisc/include/asm/atomic.h          | 24 ------------------------
 arch/s390/include/asm/atomic.h            | 16 ----------------
 arch/sparc/include/asm/atomic_64.h        | 15 ---------------
 arch/x86/include/asm/atomic64_64.h        | 19 -------------------
 include/asm-generic/atomic-instrumented.h |  6 ------
 include/linux/atomic.h                    | 26 ++++++++++++++++++++++++--
 9 files changed, 24 insertions(+), 133 deletions(-)

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 22c8c43d6689..82db0e4febd4 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -40,17 +40,6 @@
 
 #include <asm/cmpxchg.h>
 
-#define ___atomic_add_unless(v, a, u, sfx)				\
-({									\
-	typeof((v)->counter) c, old;					\
-									\
-	c = atomic##sfx##_read(v);					\
-	while (c != (u) &&						\
-	      (old = atomic##sfx##_cmpxchg((v), c, c + (a))) != c)	\
-		c = old;						\
-	c;								\
- })
-
 #define ATOMIC_INIT(i)	{ (i) }
 
 #define atomic_read(v)			READ_ONCE((v)->counter)
@@ -200,7 +189,6 @@
 #define atomic64_dec_and_test(v)	(atomic64_dec_return(v) == 0)
 #define atomic64_sub_and_test(i, v)	(atomic64_sub_return((i), (v)) == 0)
 #define atomic64_add_negative(i, v)	(atomic64_add_return((i), (v)) < 0)
-#define atomic64_add_unless(v, a, u)	(___atomic_add_unless(v, a, u, 64) != u)
 #define atomic64_andnot			atomic64_andnot
 
 #endif
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index cfe44086338e..0f80a3eafaba 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -215,21 +215,6 @@ ATOMIC64_FETCH_OP(xor, ^)
 	(cmpxchg(&((v)->counter), old, new))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
-static __inline__ long atomic64_add_unless(atomic64_t *v, long a, long u)
-{
-	long c, old;
-	c = atomic64_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic64_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c != (u);
-}
-
 static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 {
 	long c, old, dec;
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 794734e730d9..d42b27df1548 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -596,30 +596,6 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), (new)))
 
-/**
- * atomic64_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns true iff @v was not @u.
- */
-static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
-{
-	long c, old;
-	c = atomic64_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic64_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c != (u);
-}
-
 #define atomic64_dec_return(v) atomic64_sub_return(1, (v))
 #define atomic64_inc_return(v) atomic64_add_return(1, (v))
 
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index b2b6261d05e7..f53ba2d6ff67 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -257,30 +257,6 @@ atomic64_read(const atomic64_t *v)
 	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
-/**
- * atomic64_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
-static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
-{
-	long c, old;
-	c = atomic64_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic64_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c != (u);
-}
-
 /*
  * atomic64_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic_t
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index 26c6b713a7a3..eb9329741bad 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -153,22 +153,6 @@ ATOMIC64_OPS(xor)
 
 #undef ATOMIC64_OPS
 
-static inline int atomic64_add_unless(atomic64_t *v, long i, long u)
-{
-	long c, old;
-
-	c = atomic64_read(v);
-	for (;;) {
-		if (unlikely(c == u))
-			break;
-		old = atomic64_cmpxchg(v, c, c + i);
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c != u;
-}
-
 static inline long atomic64_dec_if_positive(atomic64_t *v)
 {
 	long c, old, dec;
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index e4f1c93db31f..458783e99997 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -93,21 +93,6 @@ static inline int atomic_xchg(atomic_t *v, int new)
 	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
-static inline long atomic64_add_unless(atomic64_t *v, long a, long u)
-{
-	long c, old;
-	c = atomic64_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic64_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c != (u);
-}
-
 long atomic64_dec_if_positive(atomic64_t *v);
 
 #endif /* !(__ARCH_SPARC64_ATOMIC__) */
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 6f95023894b7..7e04b294e6eb 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -188,25 +188,6 @@ static inline long arch_atomic64_xchg(atomic64_t *v, long new)
 	return xchg(&v->counter, new);
 }
 
-/**
- * arch_atomic64_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
-static inline bool arch_atomic64_add_unless(atomic64_t *v, long a, long u)
-{
-	s64 c = arch_atomic64_read(v);
-	do {
-		if (unlikely(c == u))
-			return false;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, c + a));
-	return true;
-}
-
 /*
  * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic_t
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index e22d7e5f4ce7..719168de5c6e 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -100,12 +100,6 @@ static __always_inline int atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_unless(v, a, u);
 }
-#else
-static __always_inline bool atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
-{
-	kasan_check_write(v, sizeof(*v));
-	return arch_atomic64_add_unless(v, a, u);
-}
 #endif
 
 static __always_inline void atomic_inc(atomic_t *v)
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8d93209052e1..ab534fad09e1 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -1072,6 +1072,30 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 #endif /* atomic64_try_cmpxchg */
 
 /**
+ * atomic64_fetch_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns original value of @v
+ */
+#ifndef atomic64_fetch_add_unless
+static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
+						  long long u)
+{
+	long long c = atomic64_read(v);
+
+	do {
+		if (unlikely(c == u))
+			break;
+	} while (!atomic64_try_cmpxchg(v, &c, c + a));
+
+	return c;
+}
+#endif
+
+/**
  * atomic64_add_unless - add unless the number is already a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
@@ -1080,12 +1104,10 @@ static inline int atomic_dec_if_positive(atomic_t *v)
  * Atomically adds @a to @v, so long as @v was not already @u.
  * Returns non-zero if @v was not @u, and zero otherwise.
  */
-#ifdef atomic64_fetch_add_unless
 static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
 {
 	return atomic64_fetch_add_unless(v, a, u) != u;
 }
-#endif
 
 /**
  * atomic64_inc_not_zero - increment unless the number is zero
-- 
2.11.0
