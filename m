Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeEFMQF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 08:16:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59773 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeEFMQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 08:16:03 -0400
Date: Sun, 6 May 2018 05:15:38 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-ad6812db385540eb2457c945a8e95fc9095b706c@git.kernel.org>
Cc: peterz@infradead.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mark.rutland@arm.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, paulmck@us.ibm.com, akpm@linux-foundation.org
Reply-To: akpm@linux-foundation.org, paulmck@us.ibm.com, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, peterz@infradead.org
In-Reply-To: <20180505104858.ap4bfv6ip2vprzyj@gmail.com>
References: <20180505104858.ap4bfv6ip2vprzyj@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics: Shorten the __atomic_op()
 defines to __op()
Git-Commit-ID: ad6812db385540eb2457c945a8e95fc9095b706c
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

Commit-ID:  ad6812db385540eb2457c945a8e95fc9095b706c
Gitweb:     https://git.kernel.org/tip/ad6812db385540eb2457c945a8e95fc9095b706c
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Sat, 5 May 2018 12:48:58 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 5 May 2018 15:23:55 +0200

locking/atomics: Shorten the __atomic_op() defines to __op()

The __atomic prefix is somewhat of a misnomer, because not all
APIs we use with these macros have an atomic_ prefix.

This also reduces the length of the longest lines in the header,
making them more readable on PeterZ's terminals.

No change in functionality.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul E. McKenney <paulmck@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aryabinin@virtuozzo.com
Cc: boqun.feng@gmail.com
Cc: catalin.marinas@arm.com
Cc: dvyukov@google.com
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20180505104858.ap4bfv6ip2vprzyj@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/alpha/include/asm/atomic.h    |   4 +-
 arch/powerpc/include/asm/cmpxchg.h |   8 +-
 arch/riscv/include/asm/atomic.h    |   4 +-
 include/linux/atomic.h             | 204 +++++++++++++++++++------------------
 4 files changed, 111 insertions(+), 109 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 767bfdd42992..786edb5f16c4 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -21,8 +21,8 @@
  * barriered versions. To avoid redundant back-to-back fences, we can
  * define the _acquire and _fence versions explicitly.
  */
-#define __atomic_op_acquire(op, args...)	op##_relaxed(args)
-#define __atomic_op_fence			__atomic_op_release
+#define __op_acquire(op, args...)	op##_relaxed(args)
+#define __op_fence			__op_release
 
 #define ATOMIC_INIT(i)		{ (i) }
 #define ATOMIC64_INIT(i)	{ (i) }
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index e27a612b957f..dc5a5426d683 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -13,14 +13,14 @@
  * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
  * on the platform without lwsync.
  */
-#define __atomic_op_acquire(op, args...)				\
+#define __op_acquire(op, args...)					\
 ({									\
 	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
 	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");	\
 	__ret;								\
 })
 
-#define __atomic_op_release(op, args...)				\
+#define __op_release(op, args...)					\
 ({									\
 	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
 	op##_relaxed(args);						\
@@ -531,7 +531,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 			sizeof(*(ptr)));				\
 })
 
-#define cmpxchg_release(...) __atomic_op_release(cmpxchg, __VA_ARGS__)
+#define cmpxchg_release(...) __op_release(cmpxchg, __VA_ARGS__)
 
 #ifdef CONFIG_PPC64
 #define cmpxchg64(ptr, o, n)						\
@@ -555,7 +555,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 	cmpxchg_acquire((ptr), (o), (n));				\
 })
 
-#define cmpxchg64_release(...) __atomic_op_release(cmpxchg64, __VA_ARGS__)
+#define cmpxchg64_release(...) __op_release(cmpxchg64, __VA_ARGS__)
 
 #else
 #include <asm-generic/cmpxchg-local.h>
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 855115ace98c..992c0aff9554 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -25,14 +25,14 @@
 
 #define ATOMIC_INIT(i)	{ (i) }
 
-#define __atomic_op_acquire(op, args...)				\
+#define __op_acquire(op, args...)					\
 ({									\
 	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
 	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory");	\
 	__ret;								\
 })
 
-#define __atomic_op_release(op, args...)				\
+#define __op_release(op, args...)					\
 ({									\
 	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");	\
 	op##_relaxed(args);						\
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 1176cf7c6f03..f32ff6d9e4d2 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -37,33 +37,35 @@
  * variant is already fully ordered, no additional barriers are needed.
  *
  * Besides, if an arch has a special barrier for acquire/release, it could
- * implement its own __atomic_op_* and use the same framework for building
+ * implement its own __op_* and use the same framework for building
  * variants
  *
- * If an architecture overrides __atomic_op_acquire() it will probably want
+ * If an architecture overrides __op_acquire() it will probably want
  * to define smp_mb__after_spinlock().
  */
-#ifndef __atomic_op_acquire
-#define __atomic_op_acquire(op, args...)				\
+#ifndef __op_acquire
+#define __op_acquire(op, args...)					\
 ({									\
 	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
+									\
 	smp_mb__after_atomic();						\
 	__ret;								\
 })
 #endif
 
-#ifndef __atomic_op_release
-#define __atomic_op_release(op, args...)				\
+#ifndef __op_release
+#define __op_release(op, args...)					\
 ({									\
 	smp_mb__before_atomic();					\
 	op##_relaxed(args);						\
 })
 #endif
 
-#ifndef __atomic_op_fence
-#define __atomic_op_fence(op, args...)					\
+#ifndef __op_fence
+#define __op_fence(op, args...)						\
 ({									\
 	typeof(op##_relaxed(args)) __ret;				\
+									\
 	smp_mb__before_atomic();					\
 	__ret = op##_relaxed(args);					\
 	smp_mb__after_atomic();						\
@@ -77,9 +79,9 @@
 # define atomic_add_return_release		atomic_add_return
 #else
 # ifndef atomic_add_return
-#  define atomic_add_return(...)		__atomic_op_fence(atomic_add_return, __VA_ARGS__)
-#  define atomic_add_return_acquire(...)	__atomic_op_acquire(atomic_add_return, __VA_ARGS__)
-#  define atomic_add_return_release(...)	__atomic_op_release(atomic_add_return, __VA_ARGS__)
+#  define atomic_add_return(...)		__op_fence(atomic_add_return, __VA_ARGS__)
+#  define atomic_add_return_acquire(...)	__op_acquire(atomic_add_return, __VA_ARGS__)
+#  define atomic_add_return_release(...)	__op_release(atomic_add_return, __VA_ARGS__)
 # endif
 #endif
 
@@ -89,9 +91,9 @@
 # define atomic_inc_return_release		atomic_inc_return
 #else
 # ifndef atomic_inc_return
-#  define atomic_inc_return(...)		__atomic_op_fence(atomic_inc_return, __VA_ARGS__)
-#  define atomic_inc_return_acquire(...)	__atomic_op_acquire(atomic_inc_return, __VA_ARGS__)
-#  define atomic_inc_return_release(...)	__atomic_op_release(atomic_inc_return, __VA_ARGS__)
+#  define atomic_inc_return(...)		__op_fence(atomic_inc_return, __VA_ARGS__)
+#  define atomic_inc_return_acquire(...)	__op_acquire(atomic_inc_return, __VA_ARGS__)
+#  define atomic_inc_return_release(...)	__op_release(atomic_inc_return, __VA_ARGS__)
 # endif
 #endif
 
@@ -101,9 +103,9 @@
 # define atomic_sub_return_release		atomic_sub_return
 #else
 # ifndef atomic_sub_return
-#  define atomic_sub_return(...)		__atomic_op_fence(atomic_sub_return, __VA_ARGS__)
-#  define atomic_sub_return_acquire(...)	__atomic_op_acquire(atomic_sub_return, __VA_ARGS__)
-#  define atomic_sub_return_release(...)	__atomic_op_release(atomic_sub_return, __VA_ARGS__)
+#  define atomic_sub_return(...)		__op_fence(atomic_sub_return, __VA_ARGS__)
+#  define atomic_sub_return_acquire(...)	__op_acquire(atomic_sub_return, __VA_ARGS__)
+#  define atomic_sub_return_release(...)	__op_release(atomic_sub_return, __VA_ARGS__)
 # endif
 #endif
 
@@ -113,9 +115,9 @@
 # define atomic_dec_return_release		atomic_dec_return
 #else
 # ifndef atomic_dec_return
-#  define atomic_dec_return(...)		__atomic_op_fence(atomic_dec_return, __VA_ARGS__)
-#  define atomic_dec_return_acquire(...)	__atomic_op_acquire(atomic_dec_return, __VA_ARGS__)
-#  define atomic_dec_return_release(...)	__atomic_op_release(atomic_dec_return, __VA_ARGS__)
+#  define atomic_dec_return(...)		__op_fence(atomic_dec_return, __VA_ARGS__)
+#  define atomic_dec_return_acquire(...)	__op_acquire(atomic_dec_return, __VA_ARGS__)
+#  define atomic_dec_return_release(...)	__op_release(atomic_dec_return, __VA_ARGS__)
 # endif
 #endif
 
@@ -125,9 +127,9 @@
 # define atomic_fetch_add_release		atomic_fetch_add
 #else
 # ifndef atomic_fetch_add
-#  define atomic_fetch_add(...)			__atomic_op_fence(atomic_fetch_add, __VA_ARGS__)
-#  define atomic_fetch_add_acquire(...)		__atomic_op_acquire(atomic_fetch_add, __VA_ARGS__)
-#  define atomic_fetch_add_release(...)		__atomic_op_release(atomic_fetch_add, __VA_ARGS__)
+#  define atomic_fetch_add(...)			__op_fence(atomic_fetch_add, __VA_ARGS__)
+#  define atomic_fetch_add_acquire(...)		__op_acquire(atomic_fetch_add, __VA_ARGS__)
+#  define atomic_fetch_add_release(...)		__op_release(atomic_fetch_add, __VA_ARGS__)
 # endif
 #endif
 
@@ -144,9 +146,9 @@
 # endif
 #else
 # ifndef atomic_fetch_inc
-#  define atomic_fetch_inc(...)			__atomic_op_fence(atomic_fetch_inc, __VA_ARGS__)
-#  define atomic_fetch_inc_acquire(...)		__atomic_op_acquire(atomic_fetch_inc, __VA_ARGS__)
-#  define atomic_fetch_inc_release(...)		__atomic_op_release(atomic_fetch_inc, __VA_ARGS__)
+#  define atomic_fetch_inc(...)			__op_fence(atomic_fetch_inc, __VA_ARGS__)
+#  define atomic_fetch_inc_acquire(...)		__op_acquire(atomic_fetch_inc, __VA_ARGS__)
+#  define atomic_fetch_inc_release(...)		__op_release(atomic_fetch_inc, __VA_ARGS__)
 # endif
 #endif
 
@@ -156,9 +158,9 @@
 # define atomic_fetch_sub_release		atomic_fetch_sub
 #else
 # ifndef atomic_fetch_sub
-#  define atomic_fetch_sub(...)			__atomic_op_fence(atomic_fetch_sub, __VA_ARGS__)
-#  define atomic_fetch_sub_acquire(...)		__atomic_op_acquire(atomic_fetch_sub, __VA_ARGS__)
-#  define atomic_fetch_sub_release(...)		__atomic_op_release(atomic_fetch_sub, __VA_ARGS__)
+#  define atomic_fetch_sub(...)			__op_fence(atomic_fetch_sub, __VA_ARGS__)
+#  define atomic_fetch_sub_acquire(...)		__op_acquire(atomic_fetch_sub, __VA_ARGS__)
+#  define atomic_fetch_sub_release(...)		__op_release(atomic_fetch_sub, __VA_ARGS__)
 # endif
 #endif
 
@@ -175,9 +177,9 @@
 # endif
 #else
 # ifndef atomic_fetch_dec
-#  define atomic_fetch_dec(...)			__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
-#  define atomic_fetch_dec_acquire(...)		__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
-#  define atomic_fetch_dec_release(...)		__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
+#  define atomic_fetch_dec(...)			__op_fence(atomic_fetch_dec, __VA_ARGS__)
+#  define atomic_fetch_dec_acquire(...)		__op_acquire(atomic_fetch_dec, __VA_ARGS__)
+#  define atomic_fetch_dec_release(...)		__op_release(atomic_fetch_dec, __VA_ARGS__)
 # endif
 #endif
 
@@ -187,9 +189,9 @@
 # define atomic_fetch_or_release		atomic_fetch_or
 #else
 # ifndef atomic_fetch_or
-#  define atomic_fetch_or(...)			__atomic_op_fence(atomic_fetch_or, __VA_ARGS__)
-#  define atomic_fetch_or_acquire(...)		__atomic_op_acquire(atomic_fetch_or, __VA_ARGS__)
-#  define atomic_fetch_or_release(...)		__atomic_op_release(atomic_fetch_or, __VA_ARGS__)
+#  define atomic_fetch_or(...)			__op_fence(atomic_fetch_or, __VA_ARGS__)
+#  define atomic_fetch_or_acquire(...)		__op_acquire(atomic_fetch_or, __VA_ARGS__)
+#  define atomic_fetch_or_release(...)		__op_release(atomic_fetch_or, __VA_ARGS__)
 # endif
 #endif
 
@@ -199,9 +201,9 @@
 # define atomic_fetch_and_release		atomic_fetch_and
 #else
 # ifndef atomic_fetch_and
-#  define atomic_fetch_and(...)			__atomic_op_fence(atomic_fetch_and, __VA_ARGS__)
-#  define atomic_fetch_and_acquire(...)		__atomic_op_acquire(atomic_fetch_and, __VA_ARGS__)
-#  define atomic_fetch_and_release(...)		__atomic_op_release(atomic_fetch_and, __VA_ARGS__)
+#  define atomic_fetch_and(...)			__op_fence(atomic_fetch_and, __VA_ARGS__)
+#  define atomic_fetch_and_acquire(...)		__op_acquire(atomic_fetch_and, __VA_ARGS__)
+#  define atomic_fetch_and_release(...)		__op_release(atomic_fetch_and, __VA_ARGS__)
 # endif
 #endif
 
@@ -211,9 +213,9 @@
 # define atomic_fetch_xor_release		atomic_fetch_xor
 #else
 # ifndef atomic_fetch_xor
-#  define atomic_fetch_xor(...)			__atomic_op_fence(atomic_fetch_xor, __VA_ARGS__)
-#  define atomic_fetch_xor_acquire(...)		__atomic_op_acquire(atomic_fetch_xor, __VA_ARGS__)
-#  define atomic_fetch_xor_release(...)		__atomic_op_release(atomic_fetch_xor, __VA_ARGS__)
+#  define atomic_fetch_xor(...)			__op_fence(atomic_fetch_xor, __VA_ARGS__)
+#  define atomic_fetch_xor_acquire(...)		__op_acquire(atomic_fetch_xor, __VA_ARGS__)
+#  define atomic_fetch_xor_release(...)		__op_release(atomic_fetch_xor, __VA_ARGS__)
 # endif
 #endif
 
@@ -223,9 +225,9 @@
 #define atomic_xchg_release			atomic_xchg
 #else
 # ifndef atomic_xchg
-#  define atomic_xchg(...)			__atomic_op_fence(atomic_xchg, __VA_ARGS__)
-#  define atomic_xchg_acquire(...)		__atomic_op_acquire(atomic_xchg, __VA_ARGS__)
-#  define atomic_xchg_release(...)		__atomic_op_release(atomic_xchg, __VA_ARGS__)
+#  define atomic_xchg(...)			__op_fence(atomic_xchg, __VA_ARGS__)
+#  define atomic_xchg_acquire(...)		__op_acquire(atomic_xchg, __VA_ARGS__)
+#  define atomic_xchg_release(...)		__op_release(atomic_xchg, __VA_ARGS__)
 # endif
 #endif
 
@@ -235,9 +237,9 @@
 # define atomic_cmpxchg_release			atomic_cmpxchg
 #else
 # ifndef atomic_cmpxchg
-#  define atomic_cmpxchg(...)			__atomic_op_fence(atomic_cmpxchg, __VA_ARGS__)
-#  define atomic_cmpxchg_acquire(...)		__atomic_op_acquire(atomic_cmpxchg, __VA_ARGS__)
-#  define atomic_cmpxchg_release(...)		__atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
+#  define atomic_cmpxchg(...)			__op_fence(atomic_cmpxchg, __VA_ARGS__)
+#  define atomic_cmpxchg_acquire(...)		__op_acquire(atomic_cmpxchg, __VA_ARGS__)
+#  define atomic_cmpxchg_release(...)		__op_release(atomic_cmpxchg, __VA_ARGS__)
 # endif
 #endif
 
@@ -267,9 +269,9 @@
 # define cmpxchg_release			cmpxchg
 #else
 # ifndef cmpxchg
-#  define cmpxchg(...)				__atomic_op_fence(cmpxchg, __VA_ARGS__)
-#  define cmpxchg_acquire(...)			__atomic_op_acquire(cmpxchg, __VA_ARGS__)
-#  define cmpxchg_release(...)			__atomic_op_release(cmpxchg, __VA_ARGS__)
+#  define cmpxchg(...)				__op_fence(cmpxchg, __VA_ARGS__)
+#  define cmpxchg_acquire(...)			__op_acquire(cmpxchg, __VA_ARGS__)
+#  define cmpxchg_release(...)			__op_release(cmpxchg, __VA_ARGS__)
 # endif
 #endif
 
@@ -279,9 +281,9 @@
 # define cmpxchg64_release			cmpxchg64
 #else
 # ifndef cmpxchg64
-#  define cmpxchg64(...)			__atomic_op_fence(cmpxchg64, __VA_ARGS__)
-#  define cmpxchg64_acquire(...)		__atomic_op_acquire(cmpxchg64, __VA_ARGS__)
-#  define cmpxchg64_release(...)		__atomic_op_release(cmpxchg64, __VA_ARGS__)
+#  define cmpxchg64(...)			__op_fence(cmpxchg64, __VA_ARGS__)
+#  define cmpxchg64_acquire(...)		__op_acquire(cmpxchg64, __VA_ARGS__)
+#  define cmpxchg64_release(...)		__op_release(cmpxchg64, __VA_ARGS__)
 # endif
 #endif
 
@@ -291,9 +293,9 @@
 # define xchg_release				xchg
 #else
 # ifndef xchg
-#  define xchg(...)				__atomic_op_fence(xchg, __VA_ARGS__)
-#  define xchg_acquire(...)			__atomic_op_acquire(xchg, __VA_ARGS__)
-#  define xchg_release(...)			__atomic_op_release(xchg, __VA_ARGS__)
+#  define xchg(...)				__op_fence(xchg, __VA_ARGS__)
+#  define xchg_acquire(...)			__op_acquire(xchg, __VA_ARGS__)
+#  define xchg_release(...)			__op_release(xchg, __VA_ARGS__)
 # endif
 #endif
 
@@ -330,9 +332,9 @@ static inline int atomic_add_unless(atomic_t *v, int a, int u)
 # define atomic_fetch_andnot_release		atomic_fetch_andnot
 #else
 # ifndef atomic_fetch_andnot
-#  define atomic_fetch_andnot(...)		__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
-#  define atomic_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
-#  define atomic_fetch_andnot_release(...)	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
+#  define atomic_fetch_andnot(...)		__op_fence(atomic_fetch_andnot, __VA_ARGS__)
+#  define atomic_fetch_andnot_acquire(...)	__op_acquire(atomic_fetch_andnot, __VA_ARGS__)
+#  define atomic_fetch_andnot_release(...)	__op_release(atomic_fetch_andnot, __VA_ARGS__)
 # endif
 #endif
 
@@ -472,9 +474,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_add_return_release		atomic64_add_return
 #else
 # ifndef atomic64_add_return
-#  define atomic64_add_return(...)		__atomic_op_fence(atomic64_add_return, __VA_ARGS__)
-#  define atomic64_add_return_acquire(...)	__atomic_op_acquire(atomic64_add_return, __VA_ARGS__)
-#  define atomic64_add_return_release(...)	__atomic_op_release(atomic64_add_return, __VA_ARGS__)
+#  define atomic64_add_return(...)		__op_fence(atomic64_add_return, __VA_ARGS__)
+#  define atomic64_add_return_acquire(...)	__op_acquire(atomic64_add_return, __VA_ARGS__)
+#  define atomic64_add_return_release(...)	__op_release(atomic64_add_return, __VA_ARGS__)
 # endif
 #endif
 
@@ -484,9 +486,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_inc_return_release		atomic64_inc_return
 #else
 # ifndef atomic64_inc_return
-#  define atomic64_inc_return(...)		__atomic_op_fence(atomic64_inc_return, __VA_ARGS__)
-#  define atomic64_inc_return_acquire(...)	__atomic_op_acquire(atomic64_inc_return, __VA_ARGS__)
-#  define atomic64_inc_return_release(...)	__atomic_op_release(atomic64_inc_return, __VA_ARGS__)
+#  define atomic64_inc_return(...)		__op_fence(atomic64_inc_return, __VA_ARGS__)
+#  define atomic64_inc_return_acquire(...)	__op_acquire(atomic64_inc_return, __VA_ARGS__)
+#  define atomic64_inc_return_release(...)	__op_release(atomic64_inc_return, __VA_ARGS__)
 # endif
 #endif
 
@@ -496,9 +498,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_sub_return_release		atomic64_sub_return
 #else
 # ifndef atomic64_sub_return
-#  define atomic64_sub_return(...)		__atomic_op_fence(atomic64_sub_return, __VA_ARGS__)
-#  define atomic64_sub_return_acquire(...)	__atomic_op_acquire(atomic64_sub_return, __VA_ARGS__)
-#  define atomic64_sub_return_release(...)	__atomic_op_release(atomic64_sub_return, __VA_ARGS__)
+#  define atomic64_sub_return(...)		__op_fence(atomic64_sub_return, __VA_ARGS__)
+#  define atomic64_sub_return_acquire(...)	__op_acquire(atomic64_sub_return, __VA_ARGS__)
+#  define atomic64_sub_return_release(...)	__op_release(atomic64_sub_return, __VA_ARGS__)
 # endif
 #endif
 
@@ -508,9 +510,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_dec_return_release		atomic64_dec_return
 #else
 # ifndef atomic64_dec_return
-#  define atomic64_dec_return(...)		__atomic_op_fence(atomic64_dec_return, __VA_ARGS__)
-#  define atomic64_dec_return_acquire(...)	__atomic_op_acquire(atomic64_dec_return, __VA_ARGS__)
-#  define atomic64_dec_return_release(...)	__atomic_op_release(atomic64_dec_return, __VA_ARGS__)
+#  define atomic64_dec_return(...)		__op_fence(atomic64_dec_return, __VA_ARGS__)
+#  define atomic64_dec_return_acquire(...)	__op_acquire(atomic64_dec_return, __VA_ARGS__)
+#  define atomic64_dec_return_release(...)	__op_release(atomic64_dec_return, __VA_ARGS__)
 # endif
 #endif
 
@@ -520,9 +522,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_fetch_add_release		atomic64_fetch_add
 #else
 # ifndef atomic64_fetch_add
-#  define atomic64_fetch_add(...)		__atomic_op_fence(atomic64_fetch_add, __VA_ARGS__)
-#  define atomic64_fetch_add_acquire(...)	__atomic_op_acquire(atomic64_fetch_add, __VA_ARGS__)
-#  define atomic64_fetch_add_release(...)	__atomic_op_release(atomic64_fetch_add, __VA_ARGS__)
+#  define atomic64_fetch_add(...)		__op_fence(atomic64_fetch_add, __VA_ARGS__)
+#  define atomic64_fetch_add_acquire(...)	__op_acquire(atomic64_fetch_add, __VA_ARGS__)
+#  define atomic64_fetch_add_release(...)	__op_release(atomic64_fetch_add, __VA_ARGS__)
 # endif
 #endif
 
@@ -539,9 +541,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # endif
 #else
 # ifndef atomic64_fetch_inc
-#  define atomic64_fetch_inc(...)		__atomic_op_fence(atomic64_fetch_inc, __VA_ARGS__)
-#  define atomic64_fetch_inc_acquire(...)	__atomic_op_acquire(atomic64_fetch_inc, __VA_ARGS__)
-#  define atomic64_fetch_inc_release(...)	__atomic_op_release(atomic64_fetch_inc, __VA_ARGS__)
+#  define atomic64_fetch_inc(...)		__op_fence(atomic64_fetch_inc, __VA_ARGS__)
+#  define atomic64_fetch_inc_acquire(...)	__op_acquire(atomic64_fetch_inc, __VA_ARGS__)
+#  define atomic64_fetch_inc_release(...)	__op_release(atomic64_fetch_inc, __VA_ARGS__)
 # endif
 #endif
 
@@ -551,9 +553,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_fetch_sub_release		atomic64_fetch_sub
 #else
 # ifndef atomic64_fetch_sub
-#  define atomic64_fetch_sub(...)		__atomic_op_fence(atomic64_fetch_sub, __VA_ARGS__)
-#  define atomic64_fetch_sub_acquire(...)	__atomic_op_acquire(atomic64_fetch_sub, __VA_ARGS__)
-#  define atomic64_fetch_sub_release(...)	__atomic_op_release(atomic64_fetch_sub, __VA_ARGS__)
+#  define atomic64_fetch_sub(...)		__op_fence(atomic64_fetch_sub, __VA_ARGS__)
+#  define atomic64_fetch_sub_acquire(...)	__op_acquire(atomic64_fetch_sub, __VA_ARGS__)
+#  define atomic64_fetch_sub_release(...)	__op_release(atomic64_fetch_sub, __VA_ARGS__)
 # endif
 #endif
 
@@ -570,9 +572,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # endif
 #else
 # ifndef atomic64_fetch_dec
-#  define atomic64_fetch_dec(...)		__atomic_op_fence(atomic64_fetch_dec, __VA_ARGS__)
-#  define atomic64_fetch_dec_acquire(...)	__atomic_op_acquire(atomic64_fetch_dec, __VA_ARGS__)
-#  define atomic64_fetch_dec_release(...)	__atomic_op_release(atomic64_fetch_dec, __VA_ARGS__)
+#  define atomic64_fetch_dec(...)		__op_fence(atomic64_fetch_dec, __VA_ARGS__)
+#  define atomic64_fetch_dec_acquire(...)	__op_acquire(atomic64_fetch_dec, __VA_ARGS__)
+#  define atomic64_fetch_dec_release(...)	__op_release(atomic64_fetch_dec, __VA_ARGS__)
 # endif
 #endif
 
@@ -582,9 +584,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_fetch_or_release		atomic64_fetch_or
 #else
 # ifndef atomic64_fetch_or
-#  define atomic64_fetch_or(...)		__atomic_op_fence(atomic64_fetch_or, __VA_ARGS__)
-#  define atomic64_fetch_or_acquire(...)	__atomic_op_acquire(atomic64_fetch_or, __VA_ARGS__)
-#  define atomic64_fetch_or_release(...)	__atomic_op_release(atomic64_fetch_or, __VA_ARGS__)
+#  define atomic64_fetch_or(...)		__op_fence(atomic64_fetch_or, __VA_ARGS__)
+#  define atomic64_fetch_or_acquire(...)	__op_acquire(atomic64_fetch_or, __VA_ARGS__)
+#  define atomic64_fetch_or_release(...)	__op_release(atomic64_fetch_or, __VA_ARGS__)
 # endif
 #endif
 
@@ -594,9 +596,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_fetch_and_release		atomic64_fetch_and
 #else
 # ifndef atomic64_fetch_and
-#  define atomic64_fetch_and(...)		__atomic_op_fence(atomic64_fetch_and, __VA_ARGS__)
-#  define atomic64_fetch_and_acquire(...)	__atomic_op_acquire(atomic64_fetch_and, __VA_ARGS__)
-#  define atomic64_fetch_and_release(...)	__atomic_op_release(atomic64_fetch_and, __VA_ARGS__)
+#  define atomic64_fetch_and(...)		__op_fence(atomic64_fetch_and, __VA_ARGS__)
+#  define atomic64_fetch_and_acquire(...)	__op_acquire(atomic64_fetch_and, __VA_ARGS__)
+#  define atomic64_fetch_and_release(...)	__op_release(atomic64_fetch_and, __VA_ARGS__)
 # endif
 #endif
 
@@ -606,9 +608,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_fetch_xor_release		atomic64_fetch_xor
 #else
 # ifndef atomic64_fetch_xor
-#  define atomic64_fetch_xor(...)		__atomic_op_fence(atomic64_fetch_xor, __VA_ARGS__)
-#  define atomic64_fetch_xor_acquire(...)	__atomic_op_acquire(atomic64_fetch_xor, __VA_ARGS__)
-#  define atomic64_fetch_xor_release(...)	__atomic_op_release(atomic64_fetch_xor, __VA_ARGS__)
+#  define atomic64_fetch_xor(...)		__op_fence(atomic64_fetch_xor, __VA_ARGS__)
+#  define atomic64_fetch_xor_acquire(...)	__op_acquire(atomic64_fetch_xor, __VA_ARGS__)
+#  define atomic64_fetch_xor_release(...)	__op_release(atomic64_fetch_xor, __VA_ARGS__)
 # endif
 #endif
 
@@ -618,9 +620,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_xchg_release			atomic64_xchg
 #else
 # ifndef atomic64_xchg
-#  define atomic64_xchg(...)			__atomic_op_fence(atomic64_xchg, __VA_ARGS__)
-#  define atomic64_xchg_acquire(...)		__atomic_op_acquire(atomic64_xchg, __VA_ARGS__)
-#  define atomic64_xchg_release(...)		__atomic_op_release(atomic64_xchg, __VA_ARGS__)
+#  define atomic64_xchg(...)			__op_fence(atomic64_xchg, __VA_ARGS__)
+#  define atomic64_xchg_acquire(...)		__op_acquire(atomic64_xchg, __VA_ARGS__)
+#  define atomic64_xchg_release(...)		__op_release(atomic64_xchg, __VA_ARGS__)
 # endif
 #endif
 
@@ -630,9 +632,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_cmpxchg_release		atomic64_cmpxchg
 #else
 # ifndef atomic64_cmpxchg
-#  define atomic64_cmpxchg(...)			__atomic_op_fence(atomic64_cmpxchg, __VA_ARGS__)
-#  define atomic64_cmpxchg_acquire(...)		__atomic_op_acquire(atomic64_cmpxchg, __VA_ARGS__)
-#  define atomic64_cmpxchg_release(...)		__atomic_op_release(atomic64_cmpxchg, __VA_ARGS__)
+#  define atomic64_cmpxchg(...)			__op_fence(atomic64_cmpxchg, __VA_ARGS__)
+#  define atomic64_cmpxchg_acquire(...)		__op_acquire(atomic64_cmpxchg, __VA_ARGS__)
+#  define atomic64_cmpxchg_release(...)		__op_release(atomic64_cmpxchg, __VA_ARGS__)
 # endif
 #endif
 
@@ -664,9 +666,9 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_fetch_andnot_release		atomic64_fetch_andnot
 #else
 # ifndef atomic64_fetch_andnot
-#  define atomic64_fetch_andnot(...)		__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
-#  define atomic64_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
-#  define atomic64_fetch_andnot_release(...)	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
+#  define atomic64_fetch_andnot(...)		__op_fence(atomic64_fetch_andnot, __VA_ARGS__)
+#  define atomic64_fetch_andnot_acquire(...)	__op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
+#  define atomic64_fetch_andnot_release(...)	__op_release(atomic64_fetch_andnot, __VA_ARGS__)
 # endif
 #endif
 
