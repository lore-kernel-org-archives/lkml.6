Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeEFMOh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 08:14:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34659 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeEFMOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 08:14:36 -0400
Date: Sun, 6 May 2018 05:14:07 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-a2d636a4bfd5e9b31215e5d1913e7fe0d0c0970a@git.kernel.org>
Cc: peterz@infradead.org, akpm@linux-foundation.org, mingo@kernel.org,
        mark.rutland@arm.com, torvalds@linux-foundation.org,
        will.deacon@arm.com, hpa@zytor.com, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mingo@kernel.org,
        torvalds@linux-foundation.org, mark.rutland@arm.com,
        will.deacon@arm.com
In-Reply-To: <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
References: <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics: Clean up the atomic.h maze of
 #defines
Git-Commit-ID: a2d636a4bfd5e9b31215e5d1913e7fe0d0c0970a
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

Commit-ID:  a2d636a4bfd5e9b31215e5d1913e7fe0d0c0970a
Gitweb:     https://git.kernel.org/tip/a2d636a4bfd5e9b31215e5d1913e7fe0d0c0970a
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Sat, 5 May 2018 10:11:00 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 5 May 2018 15:22:44 +0200

locking/atomics: Clean up the atomic.h maze of #defines

Use structured defines to make it all much more readable.

Before:

 #ifndef atomic_fetch_dec_relaxed

 #ifndef atomic_fetch_dec
 #define atomic_fetch_dec(v)	        atomic_fetch_sub(1, (v))
 #define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed(1, (v))
 #define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire(1, (v))
 #define atomic_fetch_dec_release(v)	atomic_fetch_sub_release(1, (v))
 #else /* atomic_fetch_dec */
 #define atomic_fetch_dec_relaxed	atomic_fetch_dec
 #define atomic_fetch_dec_acquire	atomic_fetch_dec
 #define atomic_fetch_dec_release	atomic_fetch_dec
 #endif /* atomic_fetch_dec */

 #else /* atomic_fetch_dec_relaxed */

 #ifndef atomic_fetch_dec_acquire
 #define atomic_fetch_dec_acquire(...)					\
	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
 #endif

 #ifndef atomic_fetch_dec_release
 #define atomic_fetch_dec_release(...)					\
	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
 #endif

 #ifndef atomic_fetch_dec
 #define atomic_fetch_dec(...)						\
	__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
 #endif
 #endif /* atomic_fetch_dec_relaxed */

After:

 #ifndef atomic_fetch_dec_relaxed
 # ifndef atomic_fetch_dec
 #  define atomic_fetch_dec(v)			atomic_fetch_sub(1, (v))
 #  define atomic_fetch_dec_relaxed(v)		atomic_fetch_sub_relaxed(1, (v))
 #  define atomic_fetch_dec_acquire(v)		atomic_fetch_sub_acquire(1, (v))
 #  define atomic_fetch_dec_release(v)		atomic_fetch_sub_release(1, (v))
 # else
 #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
 #  define atomic_fetch_dec_acquire		atomic_fetch_dec
 #  define atomic_fetch_dec_release		atomic_fetch_dec
 # endif
 #else
 # ifndef atomic_fetch_dec_acquire
 #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
 # endif
 # ifndef atomic_fetch_dec_release
 #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
 # endif
 # ifndef atomic_fetch_dec
 #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
 # endif
 #endif

Beyond the linecount reduction this also makes it easier to follow
the various conditions.

Also clean up a few other minor details and make the code more
consistent throughout.

No change in functionality.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aryabinin@virtuozzo.com
Cc: boqun.feng@gmail.com
Cc: catalin.marinas@arm.com
Cc: dvyukov@google.com
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20180505081100.nsyrqrpzq2vd27bk@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/atomic.h | 1275 +++++++++++++++++++++---------------------------
 1 file changed, 543 insertions(+), 732 deletions(-)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 01ce3997cb42..12f4ad559ab1 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -24,11 +24,11 @@
  */
 
 #ifndef atomic_read_acquire
-#define  atomic_read_acquire(v)		smp_load_acquire(&(v)->counter)
+# define atomic_read_acquire(v)			smp_load_acquire(&(v)->counter)
 #endif
 
 #ifndef atomic_set_release
-#define  atomic_set_release(v, i)	smp_store_release(&(v)->counter, (i))
+# define atomic_set_release(v, i)		smp_store_release(&(v)->counter, (i))
 #endif
 
 /*
@@ -71,454 +71,351 @@
 })
 #endif
 
-/* atomic_add_return_relaxed */
-#ifndef atomic_add_return_relaxed
-#define  atomic_add_return_relaxed	atomic_add_return
-#define  atomic_add_return_acquire	atomic_add_return
-#define  atomic_add_return_release	atomic_add_return
-
-#else /* atomic_add_return_relaxed */
-
-#ifndef atomic_add_return_acquire
-#define  atomic_add_return_acquire(...)					\
-	__atomic_op_acquire(atomic_add_return, __VA_ARGS__)
-#endif
+/* atomic_add_return_relaxed() et al: */
 
-#ifndef atomic_add_return_release
-#define  atomic_add_return_release(...)					\
-	__atomic_op_release(atomic_add_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic_add_return
-#define  atomic_add_return(...)						\
-	__atomic_op_fence(atomic_add_return, __VA_ARGS__)
-#endif
-#endif /* atomic_add_return_relaxed */
+#ifndef atomic_add_return_relaxed
+# define atomic_add_return_relaxed		atomic_add_return
+# define atomic_add_return_acquire		atomic_add_return
+# define atomic_add_return_release		atomic_add_return
+#else
+# ifndef atomic_add_return_acquire
+#  define atomic_add_return_acquire(...)	__atomic_op_acquire(atomic_add_return, __VA_ARGS__)
+# endif
+# ifndef atomic_add_return_release
+#  define atomic_add_return_release(...)	__atomic_op_release(atomic_add_return, __VA_ARGS__)
+# endif
+# ifndef atomic_add_return
+#  define atomic_add_return(...)		__atomic_op_fence(atomic_add_return, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic_inc_return_relaxed() et al: */
 
-/* atomic_inc_return_relaxed */
 #ifndef atomic_inc_return_relaxed
-#define  atomic_inc_return_relaxed	atomic_inc_return
-#define  atomic_inc_return_acquire	atomic_inc_return
-#define  atomic_inc_return_release	atomic_inc_return
-
-#else /* atomic_inc_return_relaxed */
-
-#ifndef atomic_inc_return_acquire
-#define  atomic_inc_return_acquire(...)					\
-	__atomic_op_acquire(atomic_inc_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic_inc_return_release
-#define  atomic_inc_return_release(...)					\
-	__atomic_op_release(atomic_inc_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic_inc_return
-#define  atomic_inc_return(...)						\
-	__atomic_op_fence(atomic_inc_return, __VA_ARGS__)
-#endif
-#endif /* atomic_inc_return_relaxed */
+# define atomic_inc_return_relaxed		atomic_inc_return
+# define atomic_inc_return_acquire		atomic_inc_return
+# define atomic_inc_return_release		atomic_inc_return
+#else
+# ifndef atomic_inc_return_acquire
+#  define atomic_inc_return_acquire(...)	__atomic_op_acquire(atomic_inc_return, __VA_ARGS__)
+# endif
+# ifndef atomic_inc_return_release
+#  define atomic_inc_return_release(...)	__atomic_op_release(atomic_inc_return, __VA_ARGS__)
+# endif
+# ifndef atomic_inc_return
+#  define atomic_inc_return(...)		__atomic_op_fence(atomic_inc_return, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic_sub_return_relaxed() et al: */
 
-/* atomic_sub_return_relaxed */
 #ifndef atomic_sub_return_relaxed
-#define  atomic_sub_return_relaxed	atomic_sub_return
-#define  atomic_sub_return_acquire	atomic_sub_return
-#define  atomic_sub_return_release	atomic_sub_return
-
-#else /* atomic_sub_return_relaxed */
-
-#ifndef atomic_sub_return_acquire
-#define  atomic_sub_return_acquire(...)					\
-	__atomic_op_acquire(atomic_sub_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic_sub_return_release
-#define  atomic_sub_return_release(...)					\
-	__atomic_op_release(atomic_sub_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic_sub_return
-#define  atomic_sub_return(...)						\
-	__atomic_op_fence(atomic_sub_return, __VA_ARGS__)
-#endif
-#endif /* atomic_sub_return_relaxed */
+# define atomic_sub_return_relaxed		atomic_sub_return
+# define atomic_sub_return_acquire		atomic_sub_return
+# define atomic_sub_return_release		atomic_sub_return
+#else
+# ifndef atomic_sub_return_acquire
+#  define atomic_sub_return_acquire(...)	__atomic_op_acquire(atomic_sub_return, __VA_ARGS__)
+# endif
+# ifndef atomic_sub_return_release
+#  define atomic_sub_return_release(...)	__atomic_op_release(atomic_sub_return, __VA_ARGS__)
+# endif
+# ifndef atomic_sub_return
+#  define atomic_sub_return(...)		__atomic_op_fence(atomic_sub_return, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic_dec_return_relaxed() et al: */
 
-/* atomic_dec_return_relaxed */
 #ifndef atomic_dec_return_relaxed
-#define  atomic_dec_return_relaxed	atomic_dec_return
-#define  atomic_dec_return_acquire	atomic_dec_return
-#define  atomic_dec_return_release	atomic_dec_return
-
-#else /* atomic_dec_return_relaxed */
-
-#ifndef atomic_dec_return_acquire
-#define  atomic_dec_return_acquire(...)					\
-	__atomic_op_acquire(atomic_dec_return, __VA_ARGS__)
-#endif
+# define atomic_dec_return_relaxed		atomic_dec_return
+# define atomic_dec_return_acquire		atomic_dec_return
+# define atomic_dec_return_release		atomic_dec_return
+#else
+# ifndef atomic_dec_return_acquire
+#  define atomic_dec_return_acquire(...)	__atomic_op_acquire(atomic_dec_return, __VA_ARGS__)
+# endif
+# ifndef atomic_dec_return_release
+#  define atomic_dec_return_release(...)	__atomic_op_release(atomic_dec_return, __VA_ARGS__)
+# endif
+# ifndef atomic_dec_return
+#  define atomic_dec_return(...)		__atomic_op_fence(atomic_dec_return, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic_fetch_add_relaxed() et al: */
 
-#ifndef atomic_dec_return_release
-#define  atomic_dec_return_release(...)					\
-	__atomic_op_release(atomic_dec_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic_dec_return
-#define  atomic_dec_return(...)						\
-	__atomic_op_fence(atomic_dec_return, __VA_ARGS__)
-#endif
-#endif /* atomic_dec_return_relaxed */
-
-
-/* atomic_fetch_add_relaxed */
 #ifndef atomic_fetch_add_relaxed
-#define atomic_fetch_add_relaxed	atomic_fetch_add
-#define atomic_fetch_add_acquire	atomic_fetch_add
-#define atomic_fetch_add_release	atomic_fetch_add
-
-#else /* atomic_fetch_add_relaxed */
-
-#ifndef atomic_fetch_add_acquire
-#define atomic_fetch_add_acquire(...)					\
-	__atomic_op_acquire(atomic_fetch_add, __VA_ARGS__)
-#endif
-
-#ifndef atomic_fetch_add_release
-#define atomic_fetch_add_release(...)					\
-	__atomic_op_release(atomic_fetch_add, __VA_ARGS__)
-#endif
+# define atomic_fetch_add_relaxed		atomic_fetch_add
+# define atomic_fetch_add_acquire		atomic_fetch_add
+# define atomic_fetch_add_release		atomic_fetch_add
+#else
+# ifndef atomic_fetch_add_acquire
+#  define atomic_fetch_add_acquire(...)		__atomic_op_acquire(atomic_fetch_add, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_add_release
+#  define atomic_fetch_add_release(...)		__atomic_op_release(atomic_fetch_add, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_add
+#  define atomic_fetch_add(...)			__atomic_op_fence(atomic_fetch_add, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic_fetch_inc_relaxed() et al: */
 
-#ifndef atomic_fetch_add
-#define atomic_fetch_add(...)						\
-	__atomic_op_fence(atomic_fetch_add, __VA_ARGS__)
-#endif
-#endif /* atomic_fetch_add_relaxed */
-
-/* atomic_fetch_inc_relaxed */
 #ifndef atomic_fetch_inc_relaxed
+# ifndef atomic_fetch_inc
+#  define atomic_fetch_inc(v)			atomic_fetch_add(1, (v))
+#  define atomic_fetch_inc_relaxed(v)		atomic_fetch_add_relaxed(1, (v))
+#  define atomic_fetch_inc_acquire(v)		atomic_fetch_add_acquire(1, (v))
+#  define atomic_fetch_inc_release(v)		atomic_fetch_add_release(1, (v))
+# else
+#  define atomic_fetch_inc_relaxed		atomic_fetch_inc
+#  define atomic_fetch_inc_acquire		atomic_fetch_inc
+#  define atomic_fetch_inc_release		atomic_fetch_inc
+# endif
+#else
+# ifndef atomic_fetch_inc_acquire
+#  define atomic_fetch_inc_acquire(...)		__atomic_op_acquire(atomic_fetch_inc, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_inc_release
+#  define atomic_fetch_inc_release(...)		__atomic_op_release(atomic_fetch_inc, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_inc
+#  define atomic_fetch_inc(...)			__atomic_op_fence(atomic_fetch_inc, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic_fetch_sub_relaxed() et al: */
 
-#ifndef atomic_fetch_inc
-#define atomic_fetch_inc(v)	        atomic_fetch_add(1, (v))
-#define atomic_fetch_inc_relaxed(v)	atomic_fetch_add_relaxed(1, (v))
-#define atomic_fetch_inc_acquire(v)	atomic_fetch_add_acquire(1, (v))
-#define atomic_fetch_inc_release(v)	atomic_fetch_add_release(1, (v))
-#else /* atomic_fetch_inc */
-#define atomic_fetch_inc_relaxed	atomic_fetch_inc
-#define atomic_fetch_inc_acquire	atomic_fetch_inc
-#define atomic_fetch_inc_release	atomic_fetch_inc
-#endif /* atomic_fetch_inc */
-
-#else /* atomic_fetch_inc_relaxed */
-
-#ifndef atomic_fetch_inc_acquire
-#define atomic_fetch_inc_acquire(...)					\
-	__atomic_op_acquire(atomic_fetch_inc, __VA_ARGS__)
-#endif
-
-#ifndef atomic_fetch_inc_release
-#define atomic_fetch_inc_release(...)					\
-	__atomic_op_release(atomic_fetch_inc, __VA_ARGS__)
-#endif
-
-#ifndef atomic_fetch_inc
-#define atomic_fetch_inc(...)						\
-	__atomic_op_fence(atomic_fetch_inc, __VA_ARGS__)
-#endif
-#endif /* atomic_fetch_inc_relaxed */
-
-/* atomic_fetch_sub_relaxed */
 #ifndef atomic_fetch_sub_relaxed
-#define atomic_fetch_sub_relaxed	atomic_fetch_sub
-#define atomic_fetch_sub_acquire	atomic_fetch_sub
-#define atomic_fetch_sub_release	atomic_fetch_sub
-
-#else /* atomic_fetch_sub_relaxed */
-
-#ifndef atomic_fetch_sub_acquire
-#define atomic_fetch_sub_acquire(...)					\
-	__atomic_op_acquire(atomic_fetch_sub, __VA_ARGS__)
-#endif
+# define atomic_fetch_sub_relaxed		atomic_fetch_sub
+# define atomic_fetch_sub_acquire		atomic_fetch_sub
+# define atomic_fetch_sub_release		atomic_fetch_sub
+#else
+# ifndef atomic_fetch_sub_acquire
+#  define atomic_fetch_sub_acquire(...)		__atomic_op_acquire(atomic_fetch_sub, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_sub_release
+#  define atomic_fetch_sub_release(...)		__atomic_op_release(atomic_fetch_sub, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_sub
+#  define atomic_fetch_sub(...)			__atomic_op_fence(atomic_fetch_sub, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic_fetch_dec_relaxed() et al: */
 
-#ifndef atomic_fetch_sub_release
-#define atomic_fetch_sub_release(...)					\
-	__atomic_op_release(atomic_fetch_sub, __VA_ARGS__)
-#endif
-
-#ifndef atomic_fetch_sub
-#define atomic_fetch_sub(...)						\
-	__atomic_op_fence(atomic_fetch_sub, __VA_ARGS__)
-#endif
-#endif /* atomic_fetch_sub_relaxed */
-
-/* atomic_fetch_dec_relaxed */
 #ifndef atomic_fetch_dec_relaxed
+# ifndef atomic_fetch_dec
+#  define atomic_fetch_dec(v)			atomic_fetch_sub(1, (v))
+#  define atomic_fetch_dec_relaxed(v)		atomic_fetch_sub_relaxed(1, (v))
+#  define atomic_fetch_dec_acquire(v)		atomic_fetch_sub_acquire(1, (v))
+#  define atomic_fetch_dec_release(v)		atomic_fetch_sub_release(1, (v))
+# else
+#  define atomic_fetch_dec_relaxed		atomic_fetch_dec
+#  define atomic_fetch_dec_acquire		atomic_fetch_dec
+#  define atomic_fetch_dec_release		atomic_fetch_dec
+# endif
+#else
+# ifndef atomic_fetch_dec_acquire
+#  define atomic_fetch_dec_acquire(...)		__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_dec_release
+#  define atomic_fetch_dec_release(...)		__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_dec
+#  define atomic_fetch_dec(...)			__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic_fetch_or_relaxed() et al: */
 
-#ifndef atomic_fetch_dec
-#define atomic_fetch_dec(v)	        atomic_fetch_sub(1, (v))
-#define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed(1, (v))
-#define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire(1, (v))
-#define atomic_fetch_dec_release(v)	atomic_fetch_sub_release(1, (v))
-#else /* atomic_fetch_dec */
-#define atomic_fetch_dec_relaxed	atomic_fetch_dec
-#define atomic_fetch_dec_acquire	atomic_fetch_dec
-#define atomic_fetch_dec_release	atomic_fetch_dec
-#endif /* atomic_fetch_dec */
-
-#else /* atomic_fetch_dec_relaxed */
-
-#ifndef atomic_fetch_dec_acquire
-#define atomic_fetch_dec_acquire(...)					\
-	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
-#endif
-
-#ifndef atomic_fetch_dec_release
-#define atomic_fetch_dec_release(...)					\
-	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
-#endif
-
-#ifndef atomic_fetch_dec
-#define atomic_fetch_dec(...)						\
-	__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
-#endif
-#endif /* atomic_fetch_dec_relaxed */
-
-/* atomic_fetch_or_relaxed */
 #ifndef atomic_fetch_or_relaxed
-#define atomic_fetch_or_relaxed	atomic_fetch_or
-#define atomic_fetch_or_acquire	atomic_fetch_or
-#define atomic_fetch_or_release	atomic_fetch_or
-
-#else /* atomic_fetch_or_relaxed */
-
-#ifndef atomic_fetch_or_acquire
-#define atomic_fetch_or_acquire(...)					\
-	__atomic_op_acquire(atomic_fetch_or, __VA_ARGS__)
-#endif
-
-#ifndef atomic_fetch_or_release
-#define atomic_fetch_or_release(...)					\
-	__atomic_op_release(atomic_fetch_or, __VA_ARGS__)
-#endif
-
-#ifndef atomic_fetch_or
-#define atomic_fetch_or(...)						\
-	__atomic_op_fence(atomic_fetch_or, __VA_ARGS__)
-#endif
-#endif /* atomic_fetch_or_relaxed */
+# define atomic_fetch_or_relaxed		atomic_fetch_or
+# define atomic_fetch_or_acquire		atomic_fetch_or
+# define atomic_fetch_or_release		atomic_fetch_or
+#else
+# ifndef atomic_fetch_or_acquire
+#  define atomic_fetch_or_acquire(...)		__atomic_op_acquire(atomic_fetch_or, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_or_release
+#  define atomic_fetch_or_release(...)		__atomic_op_release(atomic_fetch_or, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_or
+#  define atomic_fetch_or(...)			__atomic_op_fence(atomic_fetch_or, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic_fetch_and_relaxed() et al: */
 
-/* atomic_fetch_and_relaxed */
 #ifndef atomic_fetch_and_relaxed
-#define atomic_fetch_and_relaxed	atomic_fetch_and
-#define atomic_fetch_and_acquire	atomic_fetch_and
-#define atomic_fetch_and_release	atomic_fetch_and
-
-#else /* atomic_fetch_and_relaxed */
-
-#ifndef atomic_fetch_and_acquire
-#define atomic_fetch_and_acquire(...)					\
-	__atomic_op_acquire(atomic_fetch_and, __VA_ARGS__)
-#endif
-
-#ifndef atomic_fetch_and_release
-#define atomic_fetch_and_release(...)					\
-	__atomic_op_release(atomic_fetch_and, __VA_ARGS__)
-#endif
-
-#ifndef atomic_fetch_and
-#define atomic_fetch_and(...)						\
-	__atomic_op_fence(atomic_fetch_and, __VA_ARGS__)
+# define atomic_fetch_and_relaxed		atomic_fetch_and
+# define atomic_fetch_and_acquire		atomic_fetch_and
+# define atomic_fetch_and_release		atomic_fetch_and
+#else
+# ifndef atomic_fetch_and_acquire
+#  define atomic_fetch_and_acquire(...)		__atomic_op_acquire(atomic_fetch_and, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_and_release
+#  define atomic_fetch_and_release(...)		__atomic_op_release(atomic_fetch_and, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_and
+#  define atomic_fetch_and(...)			__atomic_op_fence(atomic_fetch_and, __VA_ARGS__)
+# endif
 #endif
-#endif /* atomic_fetch_and_relaxed */
 
 #ifdef atomic_andnot
-/* atomic_fetch_andnot_relaxed */
-#ifndef atomic_fetch_andnot_relaxed
-#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot
-#define atomic_fetch_andnot_acquire	atomic_fetch_andnot
-#define atomic_fetch_andnot_release	atomic_fetch_andnot
-
-#else /* atomic_fetch_andnot_relaxed */
 
-#ifndef atomic_fetch_andnot_acquire
-#define atomic_fetch_andnot_acquire(...)					\
-	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
-#endif
+/* atomic_fetch_andnot_relaxed() et al: */
 
-#ifndef atomic_fetch_andnot_release
-#define atomic_fetch_andnot_release(...)					\
-	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
+#ifndef atomic_fetch_andnot_relaxed
+# define atomic_fetch_andnot_relaxed		atomic_fetch_andnot
+# define atomic_fetch_andnot_acquire		atomic_fetch_andnot
+# define atomic_fetch_andnot_release		atomic_fetch_andnot
+#else
+# ifndef atomic_fetch_andnot_acquire
+#  define atomic_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_andnot_release
+#  define atomic_fetch_andnot_release(...)	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_andnot
+#  define atomic_fetch_andnot(...)		__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
+# endif
 #endif
 
-#ifndef atomic_fetch_andnot
-#define atomic_fetch_andnot(...)						\
-	__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
-#endif
-#endif /* atomic_fetch_andnot_relaxed */
 #endif /* atomic_andnot */
 
-/* atomic_fetch_xor_relaxed */
-#ifndef atomic_fetch_xor_relaxed
-#define atomic_fetch_xor_relaxed	atomic_fetch_xor
-#define atomic_fetch_xor_acquire	atomic_fetch_xor
-#define atomic_fetch_xor_release	atomic_fetch_xor
-
-#else /* atomic_fetch_xor_relaxed */
+/* atomic_fetch_xor_relaxed() et al: */
 
-#ifndef atomic_fetch_xor_acquire
-#define atomic_fetch_xor_acquire(...)					\
-	__atomic_op_acquire(atomic_fetch_xor, __VA_ARGS__)
-#endif
-
-#ifndef atomic_fetch_xor_release
-#define atomic_fetch_xor_release(...)					\
-	__atomic_op_release(atomic_fetch_xor, __VA_ARGS__)
+#ifndef atomic_fetch_xor_relaxed
+# define atomic_fetch_xor_relaxed		atomic_fetch_xor
+# define atomic_fetch_xor_acquire		atomic_fetch_xor
+# define atomic_fetch_xor_release		atomic_fetch_xor
+#else
+# ifndef atomic_fetch_xor_acquire
+#  define atomic_fetch_xor_acquire(...)		__atomic_op_acquire(atomic_fetch_xor, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_xor_release
+#  define atomic_fetch_xor_release(...)		__atomic_op_release(atomic_fetch_xor, __VA_ARGS__)
+# endif
+# ifndef atomic_fetch_xor
+#  define atomic_fetch_xor(...)			__atomic_op_fence(atomic_fetch_xor, __VA_ARGS__)
+# endif
 #endif
 
-#ifndef atomic_fetch_xor
-#define atomic_fetch_xor(...)						\
-	__atomic_op_fence(atomic_fetch_xor, __VA_ARGS__)
-#endif
-#endif /* atomic_fetch_xor_relaxed */
 
+/* atomic_xchg_relaxed() et al: */
 
-/* atomic_xchg_relaxed */
 #ifndef atomic_xchg_relaxed
-#define  atomic_xchg_relaxed		atomic_xchg
-#define  atomic_xchg_acquire		atomic_xchg
-#define  atomic_xchg_release		atomic_xchg
-
-#else /* atomic_xchg_relaxed */
-
-#ifndef atomic_xchg_acquire
-#define  atomic_xchg_acquire(...)					\
-	__atomic_op_acquire(atomic_xchg, __VA_ARGS__)
-#endif
-
-#ifndef atomic_xchg_release
-#define  atomic_xchg_release(...)					\
-	__atomic_op_release(atomic_xchg, __VA_ARGS__)
-#endif
+#define atomic_xchg_relaxed			atomic_xchg
+#define atomic_xchg_acquire			atomic_xchg
+#define atomic_xchg_release			atomic_xchg
+#else
+# ifndef atomic_xchg_acquire
+#  define atomic_xchg_acquire(...)		__atomic_op_acquire(atomic_xchg, __VA_ARGS__)
+# endif
+# ifndef atomic_xchg_release
+#  define atomic_xchg_release(...)		__atomic_op_release(atomic_xchg, __VA_ARGS__)
+# endif
+# ifndef atomic_xchg
+#  define atomic_xchg(...)			__atomic_op_fence(atomic_xchg, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic_cmpxchg_relaxed() et al: */
 
-#ifndef atomic_xchg
-#define  atomic_xchg(...)						\
-	__atomic_op_fence(atomic_xchg, __VA_ARGS__)
-#endif
-#endif /* atomic_xchg_relaxed */
-
-/* atomic_cmpxchg_relaxed */
 #ifndef atomic_cmpxchg_relaxed
-#define  atomic_cmpxchg_relaxed		atomic_cmpxchg
-#define  atomic_cmpxchg_acquire		atomic_cmpxchg
-#define  atomic_cmpxchg_release		atomic_cmpxchg
-
-#else /* atomic_cmpxchg_relaxed */
-
-#ifndef atomic_cmpxchg_acquire
-#define  atomic_cmpxchg_acquire(...)					\
-	__atomic_op_acquire(atomic_cmpxchg, __VA_ARGS__)
+# define atomic_cmpxchg_relaxed			atomic_cmpxchg
+# define atomic_cmpxchg_acquire			atomic_cmpxchg
+# define atomic_cmpxchg_release			atomic_cmpxchg
+#else
+# ifndef atomic_cmpxchg_acquire
+#  define atomic_cmpxchg_acquire(...)		__atomic_op_acquire(atomic_cmpxchg, __VA_ARGS__)
+# endif
+# ifndef atomic_cmpxchg_release
+#  define atomic_cmpxchg_release(...)		__atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
+# endif
+# ifndef atomic_cmpxchg
+#  define atomic_cmpxchg(...)			__atomic_op_fence(atomic_cmpxchg, __VA_ARGS__)
+# endif
 #endif
 
-#ifndef atomic_cmpxchg_release
-#define  atomic_cmpxchg_release(...)					\
-	__atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef atomic_cmpxchg
-#define  atomic_cmpxchg(...)						\
-	__atomic_op_fence(atomic_cmpxchg, __VA_ARGS__)
-#endif
-#endif /* atomic_cmpxchg_relaxed */
-
 #ifndef atomic_try_cmpxchg
-
-#define __atomic_try_cmpxchg(type, _p, _po, _n)				\
-({									\
+# define __atomic_try_cmpxchg(type, _p, _po, _n)			\
+  ({									\
 	typeof(_po) __po = (_po);					\
 	typeof(*(_po)) __r, __o = *__po;				\
 	__r = atomic_cmpxchg##type((_p), __o, (_n));			\
 	if (unlikely(__r != __o))					\
 		*__po = __r;						\
 	likely(__r == __o);						\
-})
-
-#define atomic_try_cmpxchg(_p, _po, _n)		__atomic_try_cmpxchg(, _p, _po, _n)
-#define atomic_try_cmpxchg_relaxed(_p, _po, _n)	__atomic_try_cmpxchg(_relaxed, _p, _po, _n)
-#define atomic_try_cmpxchg_acquire(_p, _po, _n)	__atomic_try_cmpxchg(_acquire, _p, _po, _n)
-#define atomic_try_cmpxchg_release(_p, _po, _n)	__atomic_try_cmpxchg(_release, _p, _po, _n)
-
-#else /* atomic_try_cmpxchg */
-#define atomic_try_cmpxchg_relaxed	atomic_try_cmpxchg
-#define atomic_try_cmpxchg_acquire	atomic_try_cmpxchg
-#define atomic_try_cmpxchg_release	atomic_try_cmpxchg
-#endif /* atomic_try_cmpxchg */
-
-/* cmpxchg_relaxed */
-#ifndef cmpxchg_relaxed
-#define  cmpxchg_relaxed		cmpxchg
-#define  cmpxchg_acquire		cmpxchg
-#define  cmpxchg_release		cmpxchg
-
-#else /* cmpxchg_relaxed */
-
-#ifndef cmpxchg_acquire
-#define  cmpxchg_acquire(...)						\
-	__atomic_op_acquire(cmpxchg, __VA_ARGS__)
+  })
+# define atomic_try_cmpxchg(_p, _po, _n)	 __atomic_try_cmpxchg(, _p, _po, _n)
+# define atomic_try_cmpxchg_relaxed(_p, _po, _n) __atomic_try_cmpxchg(_relaxed, _p, _po, _n)
+# define atomic_try_cmpxchg_acquire(_p, _po, _n) __atomic_try_cmpxchg(_acquire, _p, _po, _n)
+# define atomic_try_cmpxchg_release(_p, _po, _n) __atomic_try_cmpxchg(_release, _p, _po, _n)
+#else
+# define atomic_try_cmpxchg_relaxed		atomic_try_cmpxchg
+# define atomic_try_cmpxchg_acquire		atomic_try_cmpxchg
+# define atomic_try_cmpxchg_release		atomic_try_cmpxchg
 #endif
 
-#ifndef cmpxchg_release
-#define  cmpxchg_release(...)						\
-	__atomic_op_release(cmpxchg, __VA_ARGS__)
-#endif
+/* cmpxchg_relaxed() et al: */
 
-#ifndef cmpxchg
-#define  cmpxchg(...)							\
-	__atomic_op_fence(cmpxchg, __VA_ARGS__)
-#endif
-#endif /* cmpxchg_relaxed */
+#ifndef cmpxchg_relaxed
+# define cmpxchg_relaxed			cmpxchg
+# define cmpxchg_acquire			cmpxchg
+# define cmpxchg_release			cmpxchg
+#else
+# ifndef cmpxchg_acquire
+#  define cmpxchg_acquire(...)			__atomic_op_acquire(cmpxchg, __VA_ARGS__)
+# endif
+# ifndef cmpxchg_release
+#  define cmpxchg_release(...)			__atomic_op_release(cmpxchg, __VA_ARGS__)
+# endif
+# ifndef cmpxchg
+#  define cmpxchg(...)				__atomic_op_fence(cmpxchg, __VA_ARGS__)
+# endif
+#endif
+
+/* cmpxchg64_relaxed() et al: */
 
-/* cmpxchg64_relaxed */
 #ifndef cmpxchg64_relaxed
-#define  cmpxchg64_relaxed		cmpxchg64
-#define  cmpxchg64_acquire		cmpxchg64
-#define  cmpxchg64_release		cmpxchg64
-
-#else /* cmpxchg64_relaxed */
-
-#ifndef cmpxchg64_acquire
-#define  cmpxchg64_acquire(...)						\
-	__atomic_op_acquire(cmpxchg64, __VA_ARGS__)
-#endif
-
-#ifndef cmpxchg64_release
-#define  cmpxchg64_release(...)						\
-	__atomic_op_release(cmpxchg64, __VA_ARGS__)
-#endif
-
-#ifndef cmpxchg64
-#define  cmpxchg64(...)							\
-	__atomic_op_fence(cmpxchg64, __VA_ARGS__)
-#endif
-#endif /* cmpxchg64_relaxed */
+# define cmpxchg64_relaxed			cmpxchg64
+# define cmpxchg64_acquire			cmpxchg64
+# define cmpxchg64_release			cmpxchg64
+#else
+# ifndef cmpxchg64_acquire
+#  define cmpxchg64_acquire(...)		__atomic_op_acquire(cmpxchg64, __VA_ARGS__)
+# endif
+# ifndef cmpxchg64_release
+#  define cmpxchg64_release(...)		__atomic_op_release(cmpxchg64, __VA_ARGS__)
+# endif
+# ifndef cmpxchg64
+#  define cmpxchg64(...)			__atomic_op_fence(cmpxchg64, __VA_ARGS__)
+# endif
+#endif
+
+/* xchg_relaxed() et al: */
 
-/* xchg_relaxed */
 #ifndef xchg_relaxed
-#define  xchg_relaxed			xchg
-#define  xchg_acquire			xchg
-#define  xchg_release			xchg
-
-#else /* xchg_relaxed */
-
-#ifndef xchg_acquire
-#define  xchg_acquire(...)		__atomic_op_acquire(xchg, __VA_ARGS__)
-#endif
-
-#ifndef xchg_release
-#define  xchg_release(...)		__atomic_op_release(xchg, __VA_ARGS__)
+# define xchg_relaxed				xchg
+# define xchg_acquire				xchg
+# define xchg_release				xchg
+#else
+# ifndef xchg_acquire
+#  define xchg_acquire(...)			__atomic_op_acquire(xchg, __VA_ARGS__)
+# endif
+# ifndef xchg_release
+#  define xchg_release(...)			__atomic_op_release(xchg, __VA_ARGS__)
+# endif
+# ifndef xchg
+#  define xchg(...)				__atomic_op_fence(xchg, __VA_ARGS__)
+# endif
 #endif
 
-#ifndef xchg
-#define  xchg(...)			__atomic_op_fence(xchg, __VA_ARGS__)
-#endif
-#endif /* xchg_relaxed */
-
 /**
  * atomic_add_unless - add unless the number is already a given value
  * @v: pointer of type atomic_t
@@ -541,7 +438,7 @@ static inline int atomic_add_unless(atomic_t *v, int a, int u)
  * Returns non-zero if @v was non-zero, and zero otherwise.
  */
 #ifndef atomic_inc_not_zero
-#define atomic_inc_not_zero(v)		atomic_add_unless((v), 1, 0)
+# define atomic_inc_not_zero(v)			atomic_add_unless((v), 1, 0)
 #endif
 
 #ifndef atomic_andnot
@@ -607,6 +504,7 @@ static inline int atomic_inc_not_zero_hint(atomic_t *v, int hint)
 static inline int atomic_inc_unless_negative(atomic_t *p)
 {
 	int v, v1;
+
 	for (v = 0; v >= 0; v = v1) {
 		v1 = atomic_cmpxchg(p, v, v + 1);
 		if (likely(v1 == v))
@@ -620,6 +518,7 @@ static inline int atomic_inc_unless_negative(atomic_t *p)
 static inline int atomic_dec_unless_positive(atomic_t *p)
 {
 	int v, v1;
+
 	for (v = 0; v <= 0; v = v1) {
 		v1 = atomic_cmpxchg(p, v, v - 1);
 		if (likely(v1 == v))
@@ -640,6 +539,7 @@ static inline int atomic_dec_unless_positive(atomic_t *p)
 static inline int atomic_dec_if_positive(atomic_t *v)
 {
 	int c, old, dec;
+
 	c = atomic_read(v);
 	for (;;) {
 		dec = c - 1;
@@ -654,400 +554,311 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 }
 #endif
 
-#define atomic_cond_read_relaxed(v, c)	smp_cond_load_relaxed(&(v)->counter, (c))
-#define atomic_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
+#define atomic_cond_read_relaxed(v, c)		smp_cond_load_relaxed(&(v)->counter, (c))
+#define atomic_cond_read_acquire(v, c)		smp_cond_load_acquire(&(v)->counter, (c))
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
 
 #ifndef atomic64_read_acquire
-#define  atomic64_read_acquire(v)	smp_load_acquire(&(v)->counter)
+# define atomic64_read_acquire(v)		smp_load_acquire(&(v)->counter)
 #endif
 
 #ifndef atomic64_set_release
-#define  atomic64_set_release(v, i)	smp_store_release(&(v)->counter, (i))
-#endif
-
-/* atomic64_add_return_relaxed */
-#ifndef atomic64_add_return_relaxed
-#define  atomic64_add_return_relaxed	atomic64_add_return
-#define  atomic64_add_return_acquire	atomic64_add_return
-#define  atomic64_add_return_release	atomic64_add_return
-
-#else /* atomic64_add_return_relaxed */
-
-#ifndef atomic64_add_return_acquire
-#define  atomic64_add_return_acquire(...)				\
-	__atomic_op_acquire(atomic64_add_return, __VA_ARGS__)
+# define atomic64_set_release(v, i)		smp_store_release(&(v)->counter, (i))
 #endif
 
-#ifndef atomic64_add_return_release
-#define  atomic64_add_return_release(...)				\
-	__atomic_op_release(atomic64_add_return, __VA_ARGS__)
-#endif
+/* atomic64_add_return_relaxed() et al: */
 
-#ifndef atomic64_add_return
-#define  atomic64_add_return(...)					\
-	__atomic_op_fence(atomic64_add_return, __VA_ARGS__)
-#endif
-#endif /* atomic64_add_return_relaxed */
+#ifndef atomic64_add_return_relaxed
+# define atomic64_add_return_relaxed		atomic64_add_return
+# define atomic64_add_return_acquire		atomic64_add_return
+# define atomic64_add_return_release		atomic64_add_return
+#else
+# ifndef atomic64_add_return_acquire
+#  define atomic64_add_return_acquire(...)	__atomic_op_acquire(atomic64_add_return, __VA_ARGS__)
+# endif
+# ifndef atomic64_add_return_release
+#  define atomic64_add_return_release(...)	__atomic_op_release(atomic64_add_return, __VA_ARGS__)
+# endif
+# ifndef atomic64_add_return
+#  define atomic64_add_return(...)		__atomic_op_fence(atomic64_add_return, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic64_inc_return_relaxed() et al: */
 
-/* atomic64_inc_return_relaxed */
 #ifndef atomic64_inc_return_relaxed
-#define  atomic64_inc_return_relaxed	atomic64_inc_return
-#define  atomic64_inc_return_acquire	atomic64_inc_return
-#define  atomic64_inc_return_release	atomic64_inc_return
-
-#else /* atomic64_inc_return_relaxed */
-
-#ifndef atomic64_inc_return_acquire
-#define  atomic64_inc_return_acquire(...)				\
-	__atomic_op_acquire(atomic64_inc_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_inc_return_release
-#define  atomic64_inc_return_release(...)				\
-	__atomic_op_release(atomic64_inc_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_inc_return
-#define  atomic64_inc_return(...)					\
-	__atomic_op_fence(atomic64_inc_return, __VA_ARGS__)
-#endif
-#endif /* atomic64_inc_return_relaxed */
-
+# define atomic64_inc_return_relaxed		atomic64_inc_return
+# define atomic64_inc_return_acquire		atomic64_inc_return
+# define atomic64_inc_return_release		atomic64_inc_return
+#else
+# ifndef atomic64_inc_return_acquire
+#  define atomic64_inc_return_acquire(...)	__atomic_op_acquire(atomic64_inc_return, __VA_ARGS__)
+# endif
+# ifndef atomic64_inc_return_release
+#  define atomic64_inc_return_release(...)	__atomic_op_release(atomic64_inc_return, __VA_ARGS__)
+# endif
+# ifndef atomic64_inc_return
+#  define atomic64_inc_return(...)		__atomic_op_fence(atomic64_inc_return, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic64_sub_return_relaxed() et al: */
 
-/* atomic64_sub_return_relaxed */
 #ifndef atomic64_sub_return_relaxed
-#define  atomic64_sub_return_relaxed	atomic64_sub_return
-#define  atomic64_sub_return_acquire	atomic64_sub_return
-#define  atomic64_sub_return_release	atomic64_sub_return
+# define atomic64_sub_return_relaxed		atomic64_sub_return
+# define atomic64_sub_return_acquire		atomic64_sub_return
+# define atomic64_sub_return_release		atomic64_sub_return
+#else
+# ifndef atomic64_sub_return_acquire
+#  define atomic64_sub_return_acquire(...)	__atomic_op_acquire(atomic64_sub_return, __VA_ARGS__)
+# endif
+# ifndef atomic64_sub_return_release
+#  define atomic64_sub_return_release(...)	__atomic_op_release(atomic64_sub_return, __VA_ARGS__)
+# endif
+# ifndef atomic64_sub_return
+#  define atomic64_sub_return(...)		__atomic_op_fence(atomic64_sub_return, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic64_dec_return_relaxed() et al: */
 
-#else /* atomic64_sub_return_relaxed */
-
-#ifndef atomic64_sub_return_acquire
-#define  atomic64_sub_return_acquire(...)				\
-	__atomic_op_acquire(atomic64_sub_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_sub_return_release
-#define  atomic64_sub_return_release(...)				\
-	__atomic_op_release(atomic64_sub_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_sub_return
-#define  atomic64_sub_return(...)					\
-	__atomic_op_fence(atomic64_sub_return, __VA_ARGS__)
-#endif
-#endif /* atomic64_sub_return_relaxed */
-
-/* atomic64_dec_return_relaxed */
 #ifndef atomic64_dec_return_relaxed
-#define  atomic64_dec_return_relaxed	atomic64_dec_return
-#define  atomic64_dec_return_acquire	atomic64_dec_return
-#define  atomic64_dec_return_release	atomic64_dec_return
-
-#else /* atomic64_dec_return_relaxed */
-
-#ifndef atomic64_dec_return_acquire
-#define  atomic64_dec_return_acquire(...)				\
-	__atomic_op_acquire(atomic64_dec_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_dec_return_release
-#define  atomic64_dec_return_release(...)				\
-	__atomic_op_release(atomic64_dec_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_dec_return
-#define  atomic64_dec_return(...)					\
-	__atomic_op_fence(atomic64_dec_return, __VA_ARGS__)
-#endif
-#endif /* atomic64_dec_return_relaxed */
+# define atomic64_dec_return_relaxed		atomic64_dec_return
+# define atomic64_dec_return_acquire		atomic64_dec_return
+# define atomic64_dec_return_release		atomic64_dec_return
+#else
+# ifndef atomic64_dec_return_acquire
+#  define atomic64_dec_return_acquire(...)	__atomic_op_acquire(atomic64_dec_return, __VA_ARGS__)
+# endif
+# ifndef atomic64_dec_return_release
+#  define atomic64_dec_return_release(...)	__atomic_op_release(atomic64_dec_return, __VA_ARGS__)
+# endif
+# ifndef atomic64_dec_return
+#  define atomic64_dec_return(...)		__atomic_op_fence(atomic64_dec_return, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic64_fetch_add_relaxed() et al: */
 
-
-/* atomic64_fetch_add_relaxed */
 #ifndef atomic64_fetch_add_relaxed
-#define atomic64_fetch_add_relaxed	atomic64_fetch_add
-#define atomic64_fetch_add_acquire	atomic64_fetch_add
-#define atomic64_fetch_add_release	atomic64_fetch_add
-
-#else /* atomic64_fetch_add_relaxed */
-
-#ifndef atomic64_fetch_add_acquire
-#define atomic64_fetch_add_acquire(...)					\
-	__atomic_op_acquire(atomic64_fetch_add, __VA_ARGS__)
-#endif
+# define atomic64_fetch_add_relaxed		atomic64_fetch_add
+# define atomic64_fetch_add_acquire		atomic64_fetch_add
+# define atomic64_fetch_add_release		atomic64_fetch_add
+#else
+# ifndef atomic64_fetch_add_acquire
+#  define atomic64_fetch_add_acquire(...)	__atomic_op_acquire(atomic64_fetch_add, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_add_release
+#  define atomic64_fetch_add_release(...)	__atomic_op_release(atomic64_fetch_add, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_add
+#  define atomic64_fetch_add(...)		__atomic_op_fence(atomic64_fetch_add, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic64_fetch_inc_relaxed() et al: */
 
-#ifndef atomic64_fetch_add_release
-#define atomic64_fetch_add_release(...)					\
-	__atomic_op_release(atomic64_fetch_add, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_fetch_add
-#define atomic64_fetch_add(...)						\
-	__atomic_op_fence(atomic64_fetch_add, __VA_ARGS__)
-#endif
-#endif /* atomic64_fetch_add_relaxed */
-
-/* atomic64_fetch_inc_relaxed */
 #ifndef atomic64_fetch_inc_relaxed
+# ifndef atomic64_fetch_inc
+#  define atomic64_fetch_inc(v)			atomic64_fetch_add(1, (v))
+#  define atomic64_fetch_inc_relaxed(v)		atomic64_fetch_add_relaxed(1, (v))
+#  define atomic64_fetch_inc_acquire(v)		atomic64_fetch_add_acquire(1, (v))
+#  define atomic64_fetch_inc_release(v)		atomic64_fetch_add_release(1, (v))
+# else
+#  define atomic64_fetch_inc_relaxed		atomic64_fetch_inc
+#  define atomic64_fetch_inc_acquire		atomic64_fetch_inc
+#  define atomic64_fetch_inc_release		atomic64_fetch_inc
+# endif
+#else
+# ifndef atomic64_fetch_inc_acquire
+#  define atomic64_fetch_inc_acquire(...)	__atomic_op_acquire(atomic64_fetch_inc, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_inc_release
+#  define atomic64_fetch_inc_release(...)	__atomic_op_release(atomic64_fetch_inc, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_inc
+#  define atomic64_fetch_inc(...)		__atomic_op_fence(atomic64_fetch_inc, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic64_fetch_sub_relaxed() et al: */
 
-#ifndef atomic64_fetch_inc
-#define atomic64_fetch_inc(v)		atomic64_fetch_add(1, (v))
-#define atomic64_fetch_inc_relaxed(v)	atomic64_fetch_add_relaxed(1, (v))
-#define atomic64_fetch_inc_acquire(v)	atomic64_fetch_add_acquire(1, (v))
-#define atomic64_fetch_inc_release(v)	atomic64_fetch_add_release(1, (v))
-#else /* atomic64_fetch_inc */
-#define atomic64_fetch_inc_relaxed	atomic64_fetch_inc
-#define atomic64_fetch_inc_acquire	atomic64_fetch_inc
-#define atomic64_fetch_inc_release	atomic64_fetch_inc
-#endif /* atomic64_fetch_inc */
-
-#else /* atomic64_fetch_inc_relaxed */
-
-#ifndef atomic64_fetch_inc_acquire
-#define atomic64_fetch_inc_acquire(...)					\
-	__atomic_op_acquire(atomic64_fetch_inc, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_fetch_inc_release
-#define atomic64_fetch_inc_release(...)					\
-	__atomic_op_release(atomic64_fetch_inc, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_fetch_inc
-#define atomic64_fetch_inc(...)						\
-	__atomic_op_fence(atomic64_fetch_inc, __VA_ARGS__)
-#endif
-#endif /* atomic64_fetch_inc_relaxed */
-
-/* atomic64_fetch_sub_relaxed */
 #ifndef atomic64_fetch_sub_relaxed
-#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub
-#define atomic64_fetch_sub_acquire	atomic64_fetch_sub
-#define atomic64_fetch_sub_release	atomic64_fetch_sub
-
-#else /* atomic64_fetch_sub_relaxed */
-
-#ifndef atomic64_fetch_sub_acquire
-#define atomic64_fetch_sub_acquire(...)					\
-	__atomic_op_acquire(atomic64_fetch_sub, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_fetch_sub_release
-#define atomic64_fetch_sub_release(...)					\
-	__atomic_op_release(atomic64_fetch_sub, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_fetch_sub
-#define atomic64_fetch_sub(...)						\
-	__atomic_op_fence(atomic64_fetch_sub, __VA_ARGS__)
-#endif
-#endif /* atomic64_fetch_sub_relaxed */
+# define atomic64_fetch_sub_relaxed		atomic64_fetch_sub
+# define atomic64_fetch_sub_acquire		atomic64_fetch_sub
+# define atomic64_fetch_sub_release		atomic64_fetch_sub
+#else
+# ifndef atomic64_fetch_sub_acquire
+#  define atomic64_fetch_sub_acquire(...)	__atomic_op_acquire(atomic64_fetch_sub, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_sub_release
+#  define atomic64_fetch_sub_release(...)	__atomic_op_release(atomic64_fetch_sub, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_sub
+#  define atomic64_fetch_sub(...)		__atomic_op_fence(atomic64_fetch_sub, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic64_fetch_dec_relaxed() et al: */
 
-/* atomic64_fetch_dec_relaxed */
 #ifndef atomic64_fetch_dec_relaxed
+# ifndef atomic64_fetch_dec
+#  define atomic64_fetch_dec(v)			atomic64_fetch_sub(1, (v))
+#  define atomic64_fetch_dec_relaxed(v)		atomic64_fetch_sub_relaxed(1, (v))
+#  define atomic64_fetch_dec_acquire(v)		atomic64_fetch_sub_acquire(1, (v))
+#  define atomic64_fetch_dec_release(v)		atomic64_fetch_sub_release(1, (v))
+# else
+#  define atomic64_fetch_dec_relaxed		atomic64_fetch_dec
+#  define atomic64_fetch_dec_acquire		atomic64_fetch_dec
+#  define atomic64_fetch_dec_release		atomic64_fetch_dec
+# endif
+#else
+# ifndef atomic64_fetch_dec_acquire
+#  define atomic64_fetch_dec_acquire(...)	__atomic_op_acquire(atomic64_fetch_dec, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_dec_release
+#  define atomic64_fetch_dec_release(...)	__atomic_op_release(atomic64_fetch_dec, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_dec
+#  define atomic64_fetch_dec(...)		__atomic_op_fence(atomic64_fetch_dec, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic64_fetch_or_relaxed() et al: */
 
-#ifndef atomic64_fetch_dec
-#define atomic64_fetch_dec(v)		atomic64_fetch_sub(1, (v))
-#define atomic64_fetch_dec_relaxed(v)	atomic64_fetch_sub_relaxed(1, (v))
-#define atomic64_fetch_dec_acquire(v)	atomic64_fetch_sub_acquire(1, (v))
-#define atomic64_fetch_dec_release(v)	atomic64_fetch_sub_release(1, (v))
-#else /* atomic64_fetch_dec */
-#define atomic64_fetch_dec_relaxed	atomic64_fetch_dec
-#define atomic64_fetch_dec_acquire	atomic64_fetch_dec
-#define atomic64_fetch_dec_release	atomic64_fetch_dec
-#endif /* atomic64_fetch_dec */
-
-#else /* atomic64_fetch_dec_relaxed */
-
-#ifndef atomic64_fetch_dec_acquire
-#define atomic64_fetch_dec_acquire(...)					\
-	__atomic_op_acquire(atomic64_fetch_dec, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_fetch_dec_release
-#define atomic64_fetch_dec_release(...)					\
-	__atomic_op_release(atomic64_fetch_dec, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_fetch_dec
-#define atomic64_fetch_dec(...)						\
-	__atomic_op_fence(atomic64_fetch_dec, __VA_ARGS__)
-#endif
-#endif /* atomic64_fetch_dec_relaxed */
-
-/* atomic64_fetch_or_relaxed */
 #ifndef atomic64_fetch_or_relaxed
-#define atomic64_fetch_or_relaxed	atomic64_fetch_or
-#define atomic64_fetch_or_acquire	atomic64_fetch_or
-#define atomic64_fetch_or_release	atomic64_fetch_or
-
-#else /* atomic64_fetch_or_relaxed */
-
-#ifndef atomic64_fetch_or_acquire
-#define atomic64_fetch_or_acquire(...)					\
-	__atomic_op_acquire(atomic64_fetch_or, __VA_ARGS__)
+# define atomic64_fetch_or_relaxed		atomic64_fetch_or
+# define atomic64_fetch_or_acquire		atomic64_fetch_or
+# define atomic64_fetch_or_release		atomic64_fetch_or
+#else
+# ifndef atomic64_fetch_or_acquire
+#  define atomic64_fetch_or_acquire(...)	__atomic_op_acquire(atomic64_fetch_or, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_or_release
+#  define atomic64_fetch_or_release(...)	__atomic_op_release(atomic64_fetch_or, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_or
+#  define atomic64_fetch_or(...)		__atomic_op_fence(atomic64_fetch_or, __VA_ARGS__)
+# endif
 #endif
 
-#ifndef atomic64_fetch_or_release
-#define atomic64_fetch_or_release(...)					\
-	__atomic_op_release(atomic64_fetch_or, __VA_ARGS__)
-#endif
 
-#ifndef atomic64_fetch_or
-#define atomic64_fetch_or(...)						\
-	__atomic_op_fence(atomic64_fetch_or, __VA_ARGS__)
-#endif
-#endif /* atomic64_fetch_or_relaxed */
+/* atomic64_fetch_and_relaxed() et al: */
 
-/* atomic64_fetch_and_relaxed */
 #ifndef atomic64_fetch_and_relaxed
-#define atomic64_fetch_and_relaxed	atomic64_fetch_and
-#define atomic64_fetch_and_acquire	atomic64_fetch_and
-#define atomic64_fetch_and_release	atomic64_fetch_and
-
-#else /* atomic64_fetch_and_relaxed */
-
-#ifndef atomic64_fetch_and_acquire
-#define atomic64_fetch_and_acquire(...)					\
-	__atomic_op_acquire(atomic64_fetch_and, __VA_ARGS__)
+# define atomic64_fetch_and_relaxed		atomic64_fetch_and
+# define atomic64_fetch_and_acquire		atomic64_fetch_and
+# define atomic64_fetch_and_release		atomic64_fetch_and
+#else
+# ifndef atomic64_fetch_and_acquire
+#  define atomic64_fetch_and_acquire(...)	__atomic_op_acquire(atomic64_fetch_and, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_and_release
+#  define atomic64_fetch_and_release(...)	__atomic_op_release(atomic64_fetch_and, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_and
+#  define atomic64_fetch_and(...)		__atomic_op_fence(atomic64_fetch_and, __VA_ARGS__)
+# endif
 #endif
 
-#ifndef atomic64_fetch_and_release
-#define atomic64_fetch_and_release(...)					\
-	__atomic_op_release(atomic64_fetch_and, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_fetch_and
-#define atomic64_fetch_and(...)						\
-	__atomic_op_fence(atomic64_fetch_and, __VA_ARGS__)
-#endif
-#endif /* atomic64_fetch_and_relaxed */
-
 #ifdef atomic64_andnot
-/* atomic64_fetch_andnot_relaxed */
-#ifndef atomic64_fetch_andnot_relaxed
-#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot
-#define atomic64_fetch_andnot_acquire	atomic64_fetch_andnot
-#define atomic64_fetch_andnot_release	atomic64_fetch_andnot
-
-#else /* atomic64_fetch_andnot_relaxed */
 
-#ifndef atomic64_fetch_andnot_acquire
-#define atomic64_fetch_andnot_acquire(...)					\
-	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
-#endif
+/* atomic64_fetch_andnot_relaxed() et al: */
 
-#ifndef atomic64_fetch_andnot_release
-#define atomic64_fetch_andnot_release(...)					\
-	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
+#ifndef atomic64_fetch_andnot_relaxed
+# define atomic64_fetch_andnot_relaxed		atomic64_fetch_andnot
+# define atomic64_fetch_andnot_acquire		atomic64_fetch_andnot
+# define atomic64_fetch_andnot_release		atomic64_fetch_andnot
+#else
+# ifndef atomic64_fetch_andnot_acquire
+#  define atomic64_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_andnot_release
+#  define atomic64_fetch_andnot_release(...)	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_andnot
+#  define atomic64_fetch_andnot(...)		__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
+# endif
 #endif
 
-#ifndef atomic64_fetch_andnot
-#define atomic64_fetch_andnot(...)						\
-	__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
-#endif
-#endif /* atomic64_fetch_andnot_relaxed */
 #endif /* atomic64_andnot */
 
-/* atomic64_fetch_xor_relaxed */
-#ifndef atomic64_fetch_xor_relaxed
-#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor
-#define atomic64_fetch_xor_acquire	atomic64_fetch_xor
-#define atomic64_fetch_xor_release	atomic64_fetch_xor
-
-#else /* atomic64_fetch_xor_relaxed */
+/* atomic64_fetch_xor_relaxed() et al: */
 
-#ifndef atomic64_fetch_xor_acquire
-#define atomic64_fetch_xor_acquire(...)					\
-	__atomic_op_acquire(atomic64_fetch_xor, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_fetch_xor_release
-#define atomic64_fetch_xor_release(...)					\
-	__atomic_op_release(atomic64_fetch_xor, __VA_ARGS__)
+#ifndef atomic64_fetch_xor_relaxed
+# define atomic64_fetch_xor_relaxed		atomic64_fetch_xor
+# define atomic64_fetch_xor_acquire		atomic64_fetch_xor
+# define atomic64_fetch_xor_release		atomic64_fetch_xor
+#else
+# ifndef atomic64_fetch_xor_acquire
+#  define atomic64_fetch_xor_acquire(...)	__atomic_op_acquire(atomic64_fetch_xor, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_xor_release
+#  define atomic64_fetch_xor_release(...)	__atomic_op_release(atomic64_fetch_xor, __VA_ARGS__)
+# endif
+# ifndef atomic64_fetch_xor
+#  define atomic64_fetch_xor(...)		__atomic_op_fence(atomic64_fetch_xor, __VA_ARGS__)
 #endif
-
-#ifndef atomic64_fetch_xor
-#define atomic64_fetch_xor(...)						\
-	__atomic_op_fence(atomic64_fetch_xor, __VA_ARGS__)
 #endif
-#endif /* atomic64_fetch_xor_relaxed */
 
+/* atomic64_xchg_relaxed() et al: */
 
-/* atomic64_xchg_relaxed */
 #ifndef atomic64_xchg_relaxed
-#define  atomic64_xchg_relaxed		atomic64_xchg
-#define  atomic64_xchg_acquire		atomic64_xchg
-#define  atomic64_xchg_release		atomic64_xchg
-
-#else /* atomic64_xchg_relaxed */
-
-#ifndef atomic64_xchg_acquire
-#define  atomic64_xchg_acquire(...)					\
-	__atomic_op_acquire(atomic64_xchg, __VA_ARGS__)
-#endif
+# define atomic64_xchg_relaxed			atomic64_xchg
+# define atomic64_xchg_acquire			atomic64_xchg
+# define atomic64_xchg_release			atomic64_xchg
+#else
+# ifndef atomic64_xchg_acquire
+#  define atomic64_xchg_acquire(...)		__atomic_op_acquire(atomic64_xchg, __VA_ARGS__)
+# endif
+# ifndef atomic64_xchg_release
+#  define atomic64_xchg_release(...)		__atomic_op_release(atomic64_xchg, __VA_ARGS__)
+# endif
+# ifndef atomic64_xchg
+#  define atomic64_xchg(...)			__atomic_op_fence(atomic64_xchg, __VA_ARGS__)
+# endif
+#endif
+
+/* atomic64_cmpxchg_relaxed() et al: */
 
-#ifndef atomic64_xchg_release
-#define  atomic64_xchg_release(...)					\
-	__atomic_op_release(atomic64_xchg, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_xchg
-#define  atomic64_xchg(...)						\
-	__atomic_op_fence(atomic64_xchg, __VA_ARGS__)
-#endif
-#endif /* atomic64_xchg_relaxed */
-
-/* atomic64_cmpxchg_relaxed */
 #ifndef atomic64_cmpxchg_relaxed
-#define  atomic64_cmpxchg_relaxed	atomic64_cmpxchg
-#define  atomic64_cmpxchg_acquire	atomic64_cmpxchg
-#define  atomic64_cmpxchg_release	atomic64_cmpxchg
-
-#else /* atomic64_cmpxchg_relaxed */
-
-#ifndef atomic64_cmpxchg_acquire
-#define  atomic64_cmpxchg_acquire(...)					\
-	__atomic_op_acquire(atomic64_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_cmpxchg_release
-#define  atomic64_cmpxchg_release(...)					\
-	__atomic_op_release(atomic64_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_cmpxchg
-#define  atomic64_cmpxchg(...)						\
-	__atomic_op_fence(atomic64_cmpxchg, __VA_ARGS__)
+# define atomic64_cmpxchg_relaxed		atomic64_cmpxchg
+# define atomic64_cmpxchg_acquire		atomic64_cmpxchg
+# define atomic64_cmpxchg_release		atomic64_cmpxchg
+#else
+# ifndef atomic64_cmpxchg_acquire
+#  define atomic64_cmpxchg_acquire(...)		__atomic_op_acquire(atomic64_cmpxchg, __VA_ARGS__)
+# endif
+# ifndef atomic64_cmpxchg_release
+#  define atomic64_cmpxchg_release(...)		__atomic_op_release(atomic64_cmpxchg, __VA_ARGS__)
+# endif
+# ifndef atomic64_cmpxchg
+#  define atomic64_cmpxchg(...)			__atomic_op_fence(atomic64_cmpxchg, __VA_ARGS__)
+# endif
 #endif
-#endif /* atomic64_cmpxchg_relaxed */
 
 #ifndef atomic64_try_cmpxchg
-
-#define __atomic64_try_cmpxchg(type, _p, _po, _n)			\
-({									\
+# define __atomic64_try_cmpxchg(type, _p, _po, _n)			\
+  ({									\
 	typeof(_po) __po = (_po);					\
 	typeof(*(_po)) __r, __o = *__po;				\
 	__r = atomic64_cmpxchg##type((_p), __o, (_n));			\
 	if (unlikely(__r != __o))					\
 		*__po = __r;						\
 	likely(__r == __o);						\
-})
-
-#define atomic64_try_cmpxchg(_p, _po, _n)		__atomic64_try_cmpxchg(, _p, _po, _n)
-#define atomic64_try_cmpxchg_relaxed(_p, _po, _n)	__atomic64_try_cmpxchg(_relaxed, _p, _po, _n)
-#define atomic64_try_cmpxchg_acquire(_p, _po, _n)	__atomic64_try_cmpxchg(_acquire, _p, _po, _n)
-#define atomic64_try_cmpxchg_release(_p, _po, _n)	__atomic64_try_cmpxchg(_release, _p, _po, _n)
-
-#else /* atomic64_try_cmpxchg */
-#define atomic64_try_cmpxchg_relaxed	atomic64_try_cmpxchg
-#define atomic64_try_cmpxchg_acquire	atomic64_try_cmpxchg
-#define atomic64_try_cmpxchg_release	atomic64_try_cmpxchg
-#endif /* atomic64_try_cmpxchg */
+  })
+# define atomic64_try_cmpxchg(_p, _po, _n)	   __atomic64_try_cmpxchg(, _p, _po, _n)
+# define atomic64_try_cmpxchg_relaxed(_p, _po, _n) __atomic64_try_cmpxchg(_relaxed, _p, _po, _n)
+# define atomic64_try_cmpxchg_acquire(_p, _po, _n) __atomic64_try_cmpxchg(_acquire, _p, _po, _n)
+# define atomic64_try_cmpxchg_release(_p, _po, _n) __atomic64_try_cmpxchg(_release, _p, _po, _n)
+#else
+# define atomic64_try_cmpxchg_relaxed		atomic64_try_cmpxchg
+# define atomic64_try_cmpxchg_acquire		atomic64_try_cmpxchg
+# define atomic64_try_cmpxchg_release		atomic64_try_cmpxchg
+#endif
 
 #ifndef atomic64_andnot
 static inline void atomic64_andnot(long long i, atomic64_t *v)
