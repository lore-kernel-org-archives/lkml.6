Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeEFMOF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 08:14:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40741 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeEFMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 08:14:02 -0400
Date: Sun, 6 May 2018 05:13:39 -0700
From: tip-bot for Boqun Feng <tipbot@zytor.com>
Message-ID: <tip-0476a632cb3aa88c03cefc294050a9a86760e88d@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, boqun.feng@gmail.com, peterz@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, boqun.feng@gmail.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <20180505112817.ihrb726i37bwm4cj@tardis>
References: <20180505112817.ihrb726i37bwm4cj@tardis>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics/powerpc: Move cmpxchg helpers to
 asm/cmpxchg.h and define the full set of cmpxchg APIs
Git-Commit-ID: 0476a632cb3aa88c03cefc294050a9a86760e88d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0476a632cb3aa88c03cefc294050a9a86760e88d
Gitweb:     https://git.kernel.org/tip/0476a632cb3aa88c03cefc294050a9a86760e88d
Author:     Boqun Feng <boqun.feng@gmail.com>
AuthorDate: Sat, 5 May 2018 19:28:17 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 5 May 2018 15:22:20 +0200

locking/atomics/powerpc: Move cmpxchg helpers to asm/cmpxchg.h and define the full set of cmpxchg APIs

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
Link: http://lkml.kernel.org/r/20180505112817.ihrb726i37bwm4cj@tardis
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/powerpc/include/asm/atomic.h  | 22 ++++------------------
 arch/powerpc/include/asm/cmpxchg.h | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 682b3e6a1e21..4e06955ec10f 100644
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
@@ -213,6 +195,8 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
 	cmpxchg_relaxed(&((v)->counter), (o), (n))
 #define atomic_cmpxchg_acquire(v, o, n) \
 	cmpxchg_acquire(&((v)->counter), (o), (n))
+#define atomic_cmpxchg_release(v, o, n) \
+	cmpxchg_release(&((v)->counter), (o), (n))
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 #define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
@@ -519,6 +503,8 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 	cmpxchg_relaxed(&((v)->counter), (o), (n))
 #define atomic64_cmpxchg_acquire(v, o, n) \
 	cmpxchg_acquire(&((v)->counter), (o), (n))
+#define atomic64_cmpxchg_release(v, o, n) \
+	cmpxchg_release(&((v)->counter), (o), (n))
 
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 #define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
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
