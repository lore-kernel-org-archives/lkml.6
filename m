Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87072C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FBF20652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FBF20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937085AbeFRKUd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:20:33 -0400
Received: from foss.arm.com ([217.140.101.70]:59534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937040AbeFRKUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:20:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0423815B2;
        Mon, 18 Jun 2018 03:20:08 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C793D3F25D;
        Mon, 18 Jun 2018 03:20:06 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com
Cc:     mingo@kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv3 17/18] atomics/treewide: make conditional inc/dec ops optional
Date:   Mon, 18 Jun 2018 11:19:18 +0100
Message-Id: <20180618101919.51973-18-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180618101919.51973-1-mark.rutland@arm.com>
References: <20180618101919.51973-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conditional inc/dec ops differ for atomic_t and atomic64_t:

* atomic_inc_unless_positive() is optional for atomic_t, and doesn't exist for
  atomic64_t.

* atomic_dec_unless_negative() is optional for atomic_t, and doesn't exist for
  atomic64_t.

* atomic_dec_if_positive is optional for atomic_t, and is mandatory for
  atomic64_t.

Let's make these consistently optional for both. At the same time, let's clean
up the exisiting fallbacks to use atomic_try_cmpxchg().

The instrumented atomics are updated accordingly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/alpha/include/asm/atomic.h           |  1 +
 arch/arc/include/asm/atomic.h             |  1 +
 arch/arm/include/asm/atomic.h             |  1 +
 arch/arm64/include/asm/atomic.h           |  2 +
 arch/ia64/include/asm/atomic.h            | 16 -----
 arch/parisc/include/asm/atomic.h          | 23 --------
 arch/powerpc/include/asm/atomic.h         |  1 +
 arch/s390/include/asm/atomic.h            | 17 ------
 arch/sparc/include/asm/atomic_64.h        |  1 +
 arch/x86/include/asm/atomic64_32.h        |  1 +
 arch/x86/include/asm/atomic64_64.h        | 18 ------
 include/asm-generic/atomic-instrumented.h |  3 +
 include/asm-generic/atomic64.h            |  1 +
 include/linux/atomic.h                    | 97 +++++++++++++++++++++++--------
 14 files changed, 85 insertions(+), 98 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 9c50cc512a78..81bf9d15dcc1 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -296,5 +296,6 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 	smp_mb();
 	return old - 1;
 }
+#define atomic64_dec_if_positive atomic64_dec_if_positive
 
 #endif /* _ALPHA_ATOMIC_H */
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 27b95a928c1e..8f64f3b79b8a 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -517,6 +517,7 @@ static inline long long atomic64_dec_if_positive(atomic64_t *v)
 
 	return val;
 }
+#define atomic64_dec_if_positive atomic64_dec_if_positive
 
 /**
  * atomic64_fetch_add_unless - add unless the number is a given value
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 5a58d061d3d2..884c241424fe 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -474,6 +474,7 @@ static inline long long atomic64_dec_if_positive(atomic64_t *v)
 
 	return result;
 }
+#define atomic64_dec_if_positive atomic64_dec_if_positive
 
 static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
 						  long long u)
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 078f785cd97f..9bca54dda75c 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -159,5 +159,7 @@
 
 #define atomic64_andnot			atomic64_andnot
 
+#define atomic64_dec_if_positive	atomic64_dec_if_positive
+
 #endif
 #endif
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index 46a15a974bed..206530d0751b 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -215,22 +215,6 @@ ATOMIC64_FETCH_OP(xor, ^)
 	(cmpxchg(&((v)->counter), old, new))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
-static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
-{
-	long c, old, dec;
-	c = atomic64_read(v);
-	for (;;) {
-		dec = c - 1;
-		if (unlikely(dec < 0))
-			break;
-		old = atomic64_cmpxchg((v), c, dec);
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return dec;
-}
-
 #define atomic_add(i,v)			(void)atomic_add_return((i), (v))
 #define atomic_sub(i,v)			(void)atomic_sub_return((i), (v))
 
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index 10bc490327c1..118953d41763 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -223,29 +223,6 @@ atomic64_read(const atomic64_t *v)
 	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * atomic64_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic_t
- *
- * The function returns the old value of *v minus 1, even if
- * the atomic variable, v, was not decremented.
- */
-static inline long atomic64_dec_if_positive(atomic64_t *v)
-{
-	long c, old, dec;
-	c = atomic64_read(v);
-	for (;;) {
-		dec = c - 1;
-		if (unlikely(dec < 0))
-			break;
-		old = atomic64_cmpxchg((v), c, dec);
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return dec;
-}
-
 #endif /* !CONFIG_64BIT */
 
 
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index ebaefdee4a57..a0156cb43d1f 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -488,6 +488,7 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 
 	return t;
 }
+#define atomic64_dec_if_positive atomic64_dec_if_positive
 
 #define atomic64_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 #define atomic64_cmpxchg_relaxed(v, o, n) \
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index 376e64af951f..fd20ab5d4cf7 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -145,23 +145,6 @@ ATOMIC64_OPS(xor)
 
 #undef ATOMIC64_OPS
 
-static inline long atomic64_dec_if_positive(atomic64_t *v)
-{
-	long c, old, dec;
-
-	c = atomic64_read(v);
-	for (;;) {
-		dec = c - 1;
-		if (unlikely(dec < 0))
-			break;
-		old = atomic64_cmpxchg((v), c, dec);
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return dec;
-}
-
 #define atomic64_sub_return(_i, _v)	atomic64_add_return(-(long)(_i), _v)
 #define atomic64_fetch_sub(_i, _v)	atomic64_fetch_add(-(long)(_i), _v)
 #define atomic64_sub(_i, _v)		atomic64_add(-(long)(_i), _v)
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index 304865c7cdbb..6963482c81d8 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -62,5 +62,6 @@ static inline int atomic_xchg(atomic_t *v, int new)
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
 long atomic64_dec_if_positive(atomic64_t *v);
+#define atomic64_dec_if_positive atomic64_dec_if_positive
 
 #endif /* !(__ARCH_SPARC64_ATOMIC__) */
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 472c7af0ed48..ef959f02d070 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -254,6 +254,7 @@ static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 	return r;
 }
 
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 static inline long long arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	long long r;
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 1b282272a801..849f1c566a11 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -191,24 +191,6 @@ static inline long arch_atomic64_xchg(atomic64_t *v, long new)
 	return xchg(&v->counter, new);
 }
 
-/*
- * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic_t
- *
- * The function returns the old value of *v minus 1, even if
- * the atomic variable, v, was not decremented.
- */
-static inline long arch_atomic64_dec_if_positive(atomic64_t *v)
-{
-	s64 dec, c = arch_atomic64_read(v);
-	do {
-		dec = c - 1;
-		if (unlikely(dec < 0))
-			break;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, dec));
-	return dec;
-}
-
 static inline void arch_atomic64_and(long i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "andq %1,%0"
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 8a1bd4b0aece..e0da7f9d108a 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -243,11 +243,14 @@ static __always_inline bool atomic64_inc_not_zero(atomic64_t *v)
 }
 #endif
 
+#ifdef arch_atomic64_dec_if_positive
+#define atomic64_dec_if_positive atomic64_dec_if_positive
 static __always_inline s64 atomic64_dec_if_positive(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_if_positive(v);
 }
+#endif
 
 #ifdef arch_atomic_dec_and_test
 #define atomic_dec_and_test atomic_dec_and_test
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 242b79ae0b57..97b28b7f1f29 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -51,6 +51,7 @@ ATOMIC64_OPS(xor)
 #undef ATOMIC64_OP
 
 extern long long atomic64_dec_if_positive(atomic64_t *v);
+#define atomic64_dec_if_positive atomic64_dec_if_positive
 extern long long atomic64_cmpxchg(atomic64_t *v, long long o, long long n);
 extern long long atomic64_xchg(atomic64_t *v, long long new);
 extern long long atomic64_fetch_add_unless(atomic64_t *v, long long a, long long u);
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 24f345df7ba6..93fe5b4041e1 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -683,28 +683,30 @@ static inline int atomic_fetch_andnot_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_inc_unless_negative
-static inline bool atomic_inc_unless_negative(atomic_t *p)
+static inline bool atomic_inc_unless_negative(atomic_t *v)
 {
-	int v, v1;
-	for (v = 0; v >= 0; v = v1) {
-		v1 = atomic_cmpxchg(p, v, v + 1);
-		if (likely(v1 == v))
-			return true;
-	}
-	return false;
+	int c = atomic_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!atomic_try_cmpxchg(v, &c, c + 1));
+
+	return true;
 }
 #endif
 
 #ifndef atomic_dec_unless_positive
-static inline bool atomic_dec_unless_positive(atomic_t *p)
+static inline bool atomic_dec_unless_positive(atomic_t *v)
 {
-	int v, v1;
-	for (v = 0; v <= 0; v = v1) {
-		v1 = atomic_cmpxchg(p, v, v - 1);
-		if (likely(v1 == v))
-			return true;
-	}
-	return false;
+	int c = atomic_read(v);
+
+	do {
+		if (unlikely(c > 0))
+			return false;
+	} while (!atomic_try_cmpxchg(v, &c, c - 1));
+
+	return true;
 }
 #endif
 
@@ -718,17 +720,14 @@ static inline bool atomic_dec_unless_positive(atomic_t *p)
 #ifndef atomic_dec_if_positive
 static inline int atomic_dec_if_positive(atomic_t *v)
 {
-	int c, old, dec;
-	c = atomic_read(v);
-	for (;;) {
+	int dec, c = atomic_read(v);
+
+	do {
 		dec = c - 1;
 		if (unlikely(dec < 0))
 			break;
-		old = atomic_cmpxchg((v), c, dec);
-		if (likely(old == c))
-			break;
-		c = old;
-	}
+	} while (!atomic_try_cmpxchg(v, &c, dec));
+
 	return dec;
 }
 #endif
@@ -1290,6 +1289,56 @@ static inline long long atomic64_fetch_andnot_release(long long i, atomic64_t *v
 }
 #endif
 
+#ifndef atomic64_inc_unless_negative
+static inline bool atomic64_inc_unless_negative(atomic64_t *v)
+{
+	long long c = atomic64_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!atomic64_try_cmpxchg(v, &c, c + 1));
+
+	return true;
+}
+#endif
+
+#ifndef atomic64_dec_unless_positive
+static inline bool atomic64_dec_unless_positive(atomic64_t *v)
+{
+	long long c = atomic64_read(v);
+
+	do {
+		if (unlikely(c > 0))
+			return false;
+	} while (!atomic64_try_cmpxchg(v, &c, c - 1));
+
+	return true;
+}
+#endif
+
+/*
+ * atomic64_dec_if_positive - decrement by 1 if old value positive
+ * @v: pointer of type atomic64_t
+ *
+ * The function returns the old value of *v minus 1, even if
+ * the atomic64 variable, v, was not decremented.
+ */
+#ifndef atomic64_dec_if_positive
+static inline long long atomic64_dec_if_positive(atomic64_t *v)
+{
+	long long dec, c = atomic64_read(v);
+
+	do {
+		dec = c - 1;
+		if (unlikely(dec < 0))
+			break;
+	} while (!atomic64_try_cmpxchg(v, &c, dec));
+
+	return dec;
+}
+#endif
+
 #define atomic64_cond_read_relaxed(v, c)	smp_cond_load_relaxed(&(v)->counter, (c))
 #define atomic64_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
 
-- 
2.11.0

