Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeEGN07 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:26:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37375 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbeEGN05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:26:57 -0400
X-Google-Smtp-Source: AB8JxZptVtn/+NgpwgMlknHQ89Qk7wr3YjzvsB82eSe4mx2vxxKqrbYIRFIGwkZolCbtagO8seSUfg==
X-ME-Sender: <xms:HVTwWowAW8e5dD2nbpgcE1HNme09D3rV2ja5ZyV2M7CJhVropGQckQ>
From: Boqun Feng <boqun.feng@gmail.com>
To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, aryabinin@virtuozzo.com,
        catalin.marinas@arm.com, dvyukov@google.com,
        linux-arm-kernel@lists.infradead.org, will.deacon@arm.com
Subject: [PATCH v2] locking/atomics/powerpc: Move cmpxchg helpers to asm/cmpxchg.h and define the full set of cmpxchg APIs
Date: Mon,  7 May 2018 21:31:14 +0800
Message-Id: <20180507133114.10106-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <tip-0476a632cb3aa88c03cefc294050a9a86760e88d@git.kernel.org>
References: <tip-0476a632cb3aa88c03cefc294050a9a86760e88d@git.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move PowerPC's __op_{acqurie,release}() from atomic.h to
cmpxchg.h (in arch/powerpc/include/asm), plus use them to
define these two methods:

	#define cmpxchg_release __op_release(cmpxchg, __VA_ARGS__);
	#define cmpxchg64_release __op_release(cmpxchg64, __VA_ARGS__);

... the idea is to generate all these methods in cmpxchg.h and to define the full
array of atomic primitives, including the cmpxchg_release() methods which were
defined by the generic code before.

Also define the atomic[64]_() variants explicitly.

This ensures that all these low level cmpxchg APIs are defined in
PowerPC headers, with no generic header fallbacks.

Also remove the duplicate definitions of atomic_xchg() and
atomic64_xchg() in asm/atomic.h: they could be generated via the generic
atomic.h header using _relaxed() primitives. This helps ppc adopt the
upcoming change of generic atomic.h header.

No change in functionality or code generation.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: aryabinin@virtuozzo.com
Cc: catalin.marinas@arm.com
Cc: dvyukov@google.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: will.deacon@arm.com
---
v1 --> v2:
	remove duplicate definitions for atomic*_xchg() for future
	change

Ingo,
	I also remove the link and your SoB because I think your bot
	could add them automatically.

 arch/powerpc/include/asm/atomic.h  | 24 ++++--------------------
 arch/powerpc/include/asm/cmpxchg.h | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 682b3e6a1e21..583837a41bcc 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -13,24 +13,6 @@
 
 #define ATOMIC_INIT(i)		{ (i) }
 
-/*
- * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
- * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
- * on the platform without lwsync.
- */
-#define __atomic_op_acquire(op, args...)				\
-({									\
-	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
-	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");	\
-	__ret;								\
-})
-
-#define __atomic_op_release(op, args...)				\
-({									\
-	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
-	op##_relaxed(args);						\
-})
-
 static __inline__ int atomic_read(const atomic_t *v)
 {
 	int t;
@@ -213,8 +195,9 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
 	cmpxchg_relaxed(&((v)->counter), (o), (n))
 #define atomic_cmpxchg_acquire(v, o, n) \
 	cmpxchg_acquire(&((v)->counter), (o), (n))
+#define atomic_cmpxchg_release(v, o, n) \
+	cmpxchg_release(&((v)->counter), (o), (n))
 
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 #define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
 /**
@@ -519,8 +502,9 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 	cmpxchg_relaxed(&((v)->counter), (o), (n))
 #define atomic64_cmpxchg_acquire(v, o, n) \
 	cmpxchg_acquire(&((v)->counter), (o), (n))
+#define atomic64_cmpxchg_release(v, o, n) \
+	cmpxchg_release(&((v)->counter), (o), (n))
 
-#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 #define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
 /**
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 9b001f1f6b32..e27a612b957f 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -8,6 +8,24 @@
 #include <asm/asm-compat.h>
 #include <linux/bug.h>
 
+/*
+ * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
+ * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
+ * on the platform without lwsync.
+ */
+#define __atomic_op_acquire(op, args...)				\
+({									\
+	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
+	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");	\
+	__ret;								\
+})
+
+#define __atomic_op_release(op, args...)				\
+({									\
+	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
+	op##_relaxed(args);						\
+})
+
 #ifdef __BIG_ENDIAN
 #define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYTE)
 #else
@@ -512,6 +530,9 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 			(unsigned long)_o_, (unsigned long)_n_,		\
 			sizeof(*(ptr)));				\
 })
+
+#define cmpxchg_release(...) __atomic_op_release(cmpxchg, __VA_ARGS__)
+
 #ifdef CONFIG_PPC64
 #define cmpxchg64(ptr, o, n)						\
   ({									\
@@ -533,6 +554,9 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	cmpxchg_acquire((ptr), (o), (n));				\
 })
+
+#define cmpxchg64_release(...) __atomic_op_release(cmpxchg64, __VA_ARGS__)
+
 #else
 #include <asm-generic/cmpxchg-local.h>
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
-- 
2.16.2
