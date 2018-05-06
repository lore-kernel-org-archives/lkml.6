Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeEFMPe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 08:15:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeEFMPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 08:15:31 -0400
Date: Sun, 6 May 2018 05:15:08 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-7b9b2e57c7edaeac5404f39c5974ff227540d41e@git.kernel.org>
Cc: mingo@kernel.org, torvalds@linux-foundation.org, will.deacon@arm.com,
        akpm@linux-foundation.org, peterz@infradead.org, tglx@linutronix.de,
        paulmck@us.ibm.com, hpa@zytor.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Reply-To: paulmck@us.ibm.com, peterz@infradead.org, tglx@linutronix.de,
        akpm@linux-foundation.org, will.deacon@arm.com, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, hpa@zytor.com
In-Reply-To: <20180505085445.cmdnqh6xpnpfoqzb@gmail.com>
References: <20180505085445.cmdnqh6xpnpfoqzb@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics: Combine the atomic_andnot() and
 atomic64_andnot() API definitions
Git-Commit-ID: 7b9b2e57c7edaeac5404f39c5974ff227540d41e
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

Commit-ID:  7b9b2e57c7edaeac5404f39c5974ff227540d41e
Gitweb:     https://git.kernel.org/tip/7b9b2e57c7edaeac5404f39c5974ff227540d41e
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Sat, 5 May 2018 10:54:45 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 5 May 2018 15:22:45 +0200

locking/atomics: Combine the atomic_andnot() and atomic64_andnot() API definitions

The atomic_andnot() and atomic64_andnot() are defined in 4 separate groups
spred out in the atomic.h header:

 #ifdef atomic_andnot
 ...
 #endif /* atomic_andnot */
 ...
 #ifndef atomic_andnot
 ...
 #endif
 ...
 #ifdef atomic64_andnot
 ...
 #endif /* atomic64_andnot */
 ...
 #ifndef atomic64_andnot
 ...
 #endif

Combine them into unify them into two groups:

 #ifdef atomic_andnot
 #else
 #endif

 ...

 #ifdef atomic64_andnot
 #else
 #endif

So that one API group is defined in a single place within the header.

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
Link: http://lkml.kernel.org/r/20180505085445.cmdnqh6xpnpfoqzb@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/atomic.h | 72 +++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 352ecc72d7f5..1176cf7c6f03 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -205,22 +205,6 @@
 # endif
 #endif
 
-#ifdef atomic_andnot
-
-#ifndef atomic_fetch_andnot_relaxed
-# define atomic_fetch_andnot_relaxed		atomic_fetch_andnot
-# define atomic_fetch_andnot_acquire		atomic_fetch_andnot
-# define atomic_fetch_andnot_release		atomic_fetch_andnot
-#else
-# ifndef atomic_fetch_andnot
-#  define atomic_fetch_andnot(...)		__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
-#  define atomic_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
-#  define atomic_fetch_andnot_release(...)	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
-# endif
-#endif
-
-#endif /* atomic_andnot */
-
 #ifndef atomic_fetch_xor_relaxed
 # define atomic_fetch_xor_relaxed		atomic_fetch_xor
 # define atomic_fetch_xor_acquire		atomic_fetch_xor
@@ -338,7 +322,22 @@ static inline int atomic_add_unless(atomic_t *v, int a, int u)
 # define atomic_inc_not_zero(v)			atomic_add_unless((v), 1, 0)
 #endif
 
-#ifndef atomic_andnot
+#ifdef atomic_andnot
+
+#ifndef atomic_fetch_andnot_relaxed
+# define atomic_fetch_andnot_relaxed		atomic_fetch_andnot
+# define atomic_fetch_andnot_acquire		atomic_fetch_andnot
+# define atomic_fetch_andnot_release		atomic_fetch_andnot
+#else
+# ifndef atomic_fetch_andnot
+#  define atomic_fetch_andnot(...)		__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
+#  define atomic_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
+#  define atomic_fetch_andnot_release(...)	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
+# endif
+#endif
+
+#else /* !atomic_andnot: */
+
 static inline void atomic_andnot(int i, atomic_t *v)
 {
 	atomic_and(~i, v);
@@ -363,7 +362,8 @@ static inline int atomic_fetch_andnot_release(int i, atomic_t *v)
 {
 	return atomic_fetch_and_release(~i, v);
 }
-#endif
+
+#endif /* !atomic_andnot */
 
 /**
  * atomic_inc_not_zero_hint - increment if not null
@@ -600,22 +600,6 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # endif
 #endif
 
-#ifdef atomic64_andnot
-
-#ifndef atomic64_fetch_andnot_relaxed
-# define atomic64_fetch_andnot_relaxed		atomic64_fetch_andnot
-# define atomic64_fetch_andnot_acquire		atomic64_fetch_andnot
-# define atomic64_fetch_andnot_release		atomic64_fetch_andnot
-#else
-# ifndef atomic64_fetch_andnot
-#  define atomic64_fetch_andnot(...)		__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
-#  define atomic64_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
-#  define atomic64_fetch_andnot_release(...)	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
-# endif
-#endif
-
-#endif /* atomic64_andnot */
-
 #ifndef atomic64_fetch_xor_relaxed
 # define atomic64_fetch_xor_relaxed		atomic64_fetch_xor
 # define atomic64_fetch_xor_acquire		atomic64_fetch_xor
@@ -672,7 +656,22 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_try_cmpxchg_release		atomic64_try_cmpxchg
 #endif
 
-#ifndef atomic64_andnot
+#ifdef atomic64_andnot
+
+#ifndef atomic64_fetch_andnot_relaxed
+# define atomic64_fetch_andnot_relaxed		atomic64_fetch_andnot
+# define atomic64_fetch_andnot_acquire		atomic64_fetch_andnot
+# define atomic64_fetch_andnot_release		atomic64_fetch_andnot
+#else
+# ifndef atomic64_fetch_andnot
+#  define atomic64_fetch_andnot(...)		__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
+#  define atomic64_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
+#  define atomic64_fetch_andnot_release(...)	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
+# endif
+#endif
+
+#else /* !atomic64_andnot: */
+
 static inline void atomic64_andnot(long long i, atomic64_t *v)
 {
 	atomic64_and(~i, v);
@@ -697,7 +696,8 @@ static inline long long atomic64_fetch_andnot_release(long long i, atomic64_t *v
 {
 	return atomic64_fetch_and_release(~i, v);
 }
-#endif
+
+#endif /* !atomic64_andnot */
 
 #define atomic64_cond_read_relaxed(v, c)	smp_cond_load_relaxed(&(v)->counter, (c))
 #define atomic64_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
