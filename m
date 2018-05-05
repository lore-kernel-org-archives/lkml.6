Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeEEIgn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:36:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:47083 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeEEIgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:36:40 -0400
X-Google-Smtp-Source: AB8JxZq9xgftxl86qrp50rDj+IY2WzU+lc+o2EDDyikz/mZDhtxRM+2huhIr9V1bdWD+eRrykTgIVA==
Date: Sat, 5 May 2018 10:36:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com, catalin.marinas@arm.com,
        dvyukov@google.com, will.deacon@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] locking/atomics: Simplify the op definitions in atomic.h
 some more
Message-ID: <20180505083635.622xmcvb42dw5xxh@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Before:
> 
>  #ifndef atomic_fetch_dec_relaxed
> 
>  #ifndef atomic_fetch_dec
>  #define atomic_fetch_dec(v)	        atomic_fetch_sub(1, (v))
>  #define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed(1, (v))
>  #define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire(1, (v))
>  #define atomic_fetch_dec_release(v)	atomic_fetch_sub_release(1, (v))
>  #else /* atomic_fetch_dec */
>  #define atomic_fetch_dec_relaxed	atomic_fetch_dec
>  #define atomic_fetch_dec_acquire	atomic_fetch_dec
>  #define atomic_fetch_dec_release	atomic_fetch_dec
>  #endif /* atomic_fetch_dec */
> 
>  #else /* atomic_fetch_dec_relaxed */
> 
>  #ifndef atomic_fetch_dec_acquire
>  #define atomic_fetch_dec_acquire(...)					\
> 	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
>  #endif
> 
>  #ifndef atomic_fetch_dec_release
>  #define atomic_fetch_dec_release(...)					\
> 	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
>  #endif
> 
>  #ifndef atomic_fetch_dec
>  #define atomic_fetch_dec(...)						\
> 	__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
>  #endif
>  #endif /* atomic_fetch_dec_relaxed */
> 
> After:
> 
>  #ifndef atomic_fetch_dec_relaxed
>  # ifndef atomic_fetch_dec
>  #  define atomic_fetch_dec(v)		atomic_fetch_sub(1, (v))
>  #  define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed(1, (v))
>  #  define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire(1, (v))
>  #  define atomic_fetch_dec_release(v)	atomic_fetch_sub_release(1, (v))
>  # else
>  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
>  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
>  #  define atomic_fetch_dec_release		atomic_fetch_dec
>  # endif
>  #else
>  # ifndef atomic_fetch_dec_acquire
>  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
>  # endif
>  # ifndef atomic_fetch_dec_release
>  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
>  # endif
>  # ifndef atomic_fetch_dec
>  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
>  # endif
>  #endif
> 
> The new variant is readable at a glance, and the hierarchy of defines is very 
> obvious as well.
> 
> And I think we could do even better - there's absolutely no reason why _every_ 
> operation has to be made conditional on a finegrained level - they are overriden 
> in API groups. In fact allowing individual override is arguably a fragility.
> 
> So we could do the following simplification on top of that:
> 
>  #ifndef atomic_fetch_dec_relaxed
>  # ifndef atomic_fetch_dec
>  #  define atomic_fetch_dec(v)		atomic_fetch_sub(1, (v))
>  #  define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed(1, (v))
>  #  define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire(1, (v))
>  #  define atomic_fetch_dec_release(v)	atomic_fetch_sub_release(1, (v))
>  # else
>  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
>  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
>  #  define atomic_fetch_dec_release		atomic_fetch_dec
>  # endif
>  #else
>  # ifndef atomic_fetch_dec
>  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
>  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
>  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
>  # endif
>  #endif

The attached patch implements this, which gives us another healthy simplification:

 include/linux/atomic.h | 312 ++++++++++---------------------------------------
 1 file changed, 62 insertions(+), 250 deletions(-)

Note that the simplest definition block is now:

#ifndef atomic_cmpxchg_relaxed
# define atomic_cmpxchg_relaxed			atomic_cmpxchg
# define atomic_cmpxchg_acquire			atomic_cmpxchg
# define atomic_cmpxchg_release			atomic_cmpxchg
#else
# ifndef atomic_cmpxchg
#  define atomic_cmpxchg(...)			__atomic_op_fence(atomic_cmpxchg, __VA_ARGS__)
#  define atomic_cmpxchg_acquire(...)		__atomic_op_acquire(atomic_cmpxchg, __VA_ARGS__)
#  define atomic_cmpxchg_release(...)		__atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
# endif
#endif

... which is very readable!

The total linecount reduction of the two patches is pretty significant as well:

 include/linux/atomic.h | 1063 ++++++++++++++++--------------------------------
 1 file changed, 343 insertions(+), 720 deletions(-)

Note that I kept the second patch separate, because technically it changes the way 
we use the defines - it should not break anything, unless I missed some detail.

Please keep this kind of clarity and simplicity in new instrumentation patches!

Thanks,

	Ingo

==================>
>From 5affbf7e91901143f84f1b2ca64f4afe70e210fd Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@kernel.org>
Date: Sat, 5 May 2018 10:23:23 +0200
Subject: [PATCH] locking/atomics: Simplify the op definitions in atomic.h some more

Before:

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
 # ifndef atomic_fetch_dec
 #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
 #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
 #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
 # endif
 #endif

The idea is that because we already group these APIs by certain defines
such as atomic_fetch_dec_relaxed and atomic_fetch_dec in the primary
branches - we can do the same in the secondary branch as well.

( Also remove some unnecessarily duplicate comments, as the API
  group defines are now pretty much self-documenting. )

No change in functionality.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/atomic.h | 312 ++++++++++---------------------------------------
 1 file changed, 62 insertions(+), 250 deletions(-)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 67aaafba256b..352ecc72d7f5 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -71,98 +71,66 @@
 })
 #endif
 
-/* atomic_add_return_relaxed() et al: */
-
 #ifndef atomic_add_return_relaxed
 # define atomic_add_return_relaxed		atomic_add_return
 # define atomic_add_return_acquire		atomic_add_return
 # define atomic_add_return_release		atomic_add_return
 #else
-# ifndef atomic_add_return_acquire
-#  define atomic_add_return_acquire(...)	__atomic_op_acquire(atomic_add_return, __VA_ARGS__)
-# endif
-# ifndef atomic_add_return_release
-#  define atomic_add_return_release(...)	__atomic_op_release(atomic_add_return, __VA_ARGS__)
-# endif
 # ifndef atomic_add_return
 #  define atomic_add_return(...)		__atomic_op_fence(atomic_add_return, __VA_ARGS__)
+#  define atomic_add_return_acquire(...)	__atomic_op_acquire(atomic_add_return, __VA_ARGS__)
+#  define atomic_add_return_release(...)	__atomic_op_release(atomic_add_return, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic_inc_return_relaxed() et al: */
-
 #ifndef atomic_inc_return_relaxed
 # define atomic_inc_return_relaxed		atomic_inc_return
 # define atomic_inc_return_acquire		atomic_inc_return
 # define atomic_inc_return_release		atomic_inc_return
 #else
-# ifndef atomic_inc_return_acquire
-#  define atomic_inc_return_acquire(...)	__atomic_op_acquire(atomic_inc_return, __VA_ARGS__)
-# endif
-# ifndef atomic_inc_return_release
-#  define atomic_inc_return_release(...)	__atomic_op_release(atomic_inc_return, __VA_ARGS__)
-# endif
 # ifndef atomic_inc_return
 #  define atomic_inc_return(...)		__atomic_op_fence(atomic_inc_return, __VA_ARGS__)
+#  define atomic_inc_return_acquire(...)	__atomic_op_acquire(atomic_inc_return, __VA_ARGS__)
+#  define atomic_inc_return_release(...)	__atomic_op_release(atomic_inc_return, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic_sub_return_relaxed() et al: */
-
 #ifndef atomic_sub_return_relaxed
 # define atomic_sub_return_relaxed		atomic_sub_return
 # define atomic_sub_return_acquire		atomic_sub_return
 # define atomic_sub_return_release		atomic_sub_return
 #else
-# ifndef atomic_sub_return_acquire
-#  define atomic_sub_return_acquire(...)	__atomic_op_acquire(atomic_sub_return, __VA_ARGS__)
-# endif
-# ifndef atomic_sub_return_release
-#  define atomic_sub_return_release(...)	__atomic_op_release(atomic_sub_return, __VA_ARGS__)
-# endif
 # ifndef atomic_sub_return
 #  define atomic_sub_return(...)		__atomic_op_fence(atomic_sub_return, __VA_ARGS__)
+#  define atomic_sub_return_acquire(...)	__atomic_op_acquire(atomic_sub_return, __VA_ARGS__)
+#  define atomic_sub_return_release(...)	__atomic_op_release(atomic_sub_return, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic_dec_return_relaxed() et al: */
-
 #ifndef atomic_dec_return_relaxed
 # define atomic_dec_return_relaxed		atomic_dec_return
 # define atomic_dec_return_acquire		atomic_dec_return
 # define atomic_dec_return_release		atomic_dec_return
 #else
-# ifndef atomic_dec_return_acquire
-#  define atomic_dec_return_acquire(...)	__atomic_op_acquire(atomic_dec_return, __VA_ARGS__)
-# endif
-# ifndef atomic_dec_return_release
-#  define atomic_dec_return_release(...)	__atomic_op_release(atomic_dec_return, __VA_ARGS__)
-# endif
 # ifndef atomic_dec_return
 #  define atomic_dec_return(...)		__atomic_op_fence(atomic_dec_return, __VA_ARGS__)
+#  define atomic_dec_return_acquire(...)	__atomic_op_acquire(atomic_dec_return, __VA_ARGS__)
+#  define atomic_dec_return_release(...)	__atomic_op_release(atomic_dec_return, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic_fetch_add_relaxed() et al: */
-
 #ifndef atomic_fetch_add_relaxed
 # define atomic_fetch_add_relaxed		atomic_fetch_add
 # define atomic_fetch_add_acquire		atomic_fetch_add
 # define atomic_fetch_add_release		atomic_fetch_add
 #else
-# ifndef atomic_fetch_add_acquire
-#  define atomic_fetch_add_acquire(...)		__atomic_op_acquire(atomic_fetch_add, __VA_ARGS__)
-# endif
-# ifndef atomic_fetch_add_release
-#  define atomic_fetch_add_release(...)		__atomic_op_release(atomic_fetch_add, __VA_ARGS__)
-# endif
 # ifndef atomic_fetch_add
 #  define atomic_fetch_add(...)			__atomic_op_fence(atomic_fetch_add, __VA_ARGS__)
+#  define atomic_fetch_add_acquire(...)		__atomic_op_acquire(atomic_fetch_add, __VA_ARGS__)
+#  define atomic_fetch_add_release(...)		__atomic_op_release(atomic_fetch_add, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic_fetch_inc_relaxed() et al: */
-
 #ifndef atomic_fetch_inc_relaxed
 # ifndef atomic_fetch_inc
 #  define atomic_fetch_inc(v)			atomic_fetch_add(1, (v))
@@ -175,37 +143,25 @@
 #  define atomic_fetch_inc_release		atomic_fetch_inc
 # endif
 #else
-# ifndef atomic_fetch_inc_acquire
-#  define atomic_fetch_inc_acquire(...)		__atomic_op_acquire(atomic_fetch_inc, __VA_ARGS__)
-# endif
-# ifndef atomic_fetch_inc_release
-#  define atomic_fetch_inc_release(...)		__atomic_op_release(atomic_fetch_inc, __VA_ARGS__)
-# endif
 # ifndef atomic_fetch_inc
 #  define atomic_fetch_inc(...)			__atomic_op_fence(atomic_fetch_inc, __VA_ARGS__)
+#  define atomic_fetch_inc_acquire(...)		__atomic_op_acquire(atomic_fetch_inc, __VA_ARGS__)
+#  define atomic_fetch_inc_release(...)		__atomic_op_release(atomic_fetch_inc, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic_fetch_sub_relaxed() et al: */
-
 #ifndef atomic_fetch_sub_relaxed
 # define atomic_fetch_sub_relaxed		atomic_fetch_sub
 # define atomic_fetch_sub_acquire		atomic_fetch_sub
 # define atomic_fetch_sub_release		atomic_fetch_sub
 #else
-# ifndef atomic_fetch_sub_acquire
-#  define atomic_fetch_sub_acquire(...)		__atomic_op_acquire(atomic_fetch_sub, __VA_ARGS__)
-# endif
-# ifndef atomic_fetch_sub_release
-#  define atomic_fetch_sub_release(...)		__atomic_op_release(atomic_fetch_sub, __VA_ARGS__)
-# endif
 # ifndef atomic_fetch_sub
 #  define atomic_fetch_sub(...)			__atomic_op_fence(atomic_fetch_sub, __VA_ARGS__)
+#  define atomic_fetch_sub_acquire(...)		__atomic_op_acquire(atomic_fetch_sub, __VA_ARGS__)
+#  define atomic_fetch_sub_release(...)		__atomic_op_release(atomic_fetch_sub, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic_fetch_dec_relaxed() et al: */
-
 #ifndef atomic_fetch_dec_relaxed
 # ifndef atomic_fetch_dec
 #  define atomic_fetch_dec(v)			atomic_fetch_sub(1, (v))
@@ -218,127 +174,86 @@
 #  define atomic_fetch_dec_release		atomic_fetch_dec
 # endif
 #else
-# ifndef atomic_fetch_dec_acquire
-#  define atomic_fetch_dec_acquire(...)		__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
-# endif
-# ifndef atomic_fetch_dec_release
-#  define atomic_fetch_dec_release(...)		__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
-# endif
 # ifndef atomic_fetch_dec
 #  define atomic_fetch_dec(...)			__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
+#  define atomic_fetch_dec_acquire(...)		__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
+#  define atomic_fetch_dec_release(...)		__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic_fetch_or_relaxed() et al: */
-
 #ifndef atomic_fetch_or_relaxed
 # define atomic_fetch_or_relaxed		atomic_fetch_or
 # define atomic_fetch_or_acquire		atomic_fetch_or
 # define atomic_fetch_or_release		atomic_fetch_or
 #else
-# ifndef atomic_fetch_or_acquire
-#  define atomic_fetch_or_acquire(...)		__atomic_op_acquire(atomic_fetch_or, __VA_ARGS__)
-# endif
-# ifndef atomic_fetch_or_release
-#  define atomic_fetch_or_release(...)		__atomic_op_release(atomic_fetch_or, __VA_ARGS__)
-# endif
 # ifndef atomic_fetch_or
 #  define atomic_fetch_or(...)			__atomic_op_fence(atomic_fetch_or, __VA_ARGS__)
+#  define atomic_fetch_or_acquire(...)		__atomic_op_acquire(atomic_fetch_or, __VA_ARGS__)
+#  define atomic_fetch_or_release(...)		__atomic_op_release(atomic_fetch_or, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic_fetch_and_relaxed() et al: */
-
 #ifndef atomic_fetch_and_relaxed
 # define atomic_fetch_and_relaxed		atomic_fetch_and
 # define atomic_fetch_and_acquire		atomic_fetch_and
 # define atomic_fetch_and_release		atomic_fetch_and
 #else
-# ifndef atomic_fetch_and_acquire
-#  define atomic_fetch_and_acquire(...)		__atomic_op_acquire(atomic_fetch_and, __VA_ARGS__)
-# endif
-# ifndef atomic_fetch_and_release
-#  define atomic_fetch_and_release(...)		__atomic_op_release(atomic_fetch_and, __VA_ARGS__)
-# endif
 # ifndef atomic_fetch_and
 #  define atomic_fetch_and(...)			__atomic_op_fence(atomic_fetch_and, __VA_ARGS__)
+#  define atomic_fetch_and_acquire(...)		__atomic_op_acquire(atomic_fetch_and, __VA_ARGS__)
+#  define atomic_fetch_and_release(...)		__atomic_op_release(atomic_fetch_and, __VA_ARGS__)
 # endif
 #endif
 
 #ifdef atomic_andnot
 
-/* atomic_fetch_andnot_relaxed() et al: */
-
 #ifndef atomic_fetch_andnot_relaxed
 # define atomic_fetch_andnot_relaxed		atomic_fetch_andnot
 # define atomic_fetch_andnot_acquire		atomic_fetch_andnot
 # define atomic_fetch_andnot_release		atomic_fetch_andnot
 #else
-# ifndef atomic_fetch_andnot_acquire
-#  define atomic_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
-# endif
-# ifndef atomic_fetch_andnot_release
-#  define atomic_fetch_andnot_release(...)	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
-# endif
 # ifndef atomic_fetch_andnot
 #  define atomic_fetch_andnot(...)		__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
+#  define atomic_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
+#  define atomic_fetch_andnot_release(...)	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
 # endif
 #endif
 
 #endif /* atomic_andnot */
 
-/* atomic_fetch_xor_relaxed() et al: */
-
 #ifndef atomic_fetch_xor_relaxed
 # define atomic_fetch_xor_relaxed		atomic_fetch_xor
 # define atomic_fetch_xor_acquire		atomic_fetch_xor
 # define atomic_fetch_xor_release		atomic_fetch_xor
 #else
-# ifndef atomic_fetch_xor_acquire
-#  define atomic_fetch_xor_acquire(...)		__atomic_op_acquire(atomic_fetch_xor, __VA_ARGS__)
-# endif
-# ifndef atomic_fetch_xor_release
-#  define atomic_fetch_xor_release(...)		__atomic_op_release(atomic_fetch_xor, __VA_ARGS__)
-# endif
 # ifndef atomic_fetch_xor
 #  define atomic_fetch_xor(...)			__atomic_op_fence(atomic_fetch_xor, __VA_ARGS__)
+#  define atomic_fetch_xor_acquire(...)		__atomic_op_acquire(atomic_fetch_xor, __VA_ARGS__)
+#  define atomic_fetch_xor_release(...)		__atomic_op_release(atomic_fetch_xor, __VA_ARGS__)
 # endif
 #endif
 
-
-/* atomic_xchg_relaxed() et al: */
-
 #ifndef atomic_xchg_relaxed
 #define atomic_xchg_relaxed			atomic_xchg
 #define atomic_xchg_acquire			atomic_xchg
 #define atomic_xchg_release			atomic_xchg
 #else
-# ifndef atomic_xchg_acquire
-#  define atomic_xchg_acquire(...)		__atomic_op_acquire(atomic_xchg, __VA_ARGS__)
-# endif
-# ifndef atomic_xchg_release
-#  define atomic_xchg_release(...)		__atomic_op_release(atomic_xchg, __VA_ARGS__)
-# endif
 # ifndef atomic_xchg
 #  define atomic_xchg(...)			__atomic_op_fence(atomic_xchg, __VA_ARGS__)
+#  define atomic_xchg_acquire(...)		__atomic_op_acquire(atomic_xchg, __VA_ARGS__)
+#  define atomic_xchg_release(...)		__atomic_op_release(atomic_xchg, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic_cmpxchg_relaxed() et al: */
-
 #ifndef atomic_cmpxchg_relaxed
 # define atomic_cmpxchg_relaxed			atomic_cmpxchg
 # define atomic_cmpxchg_acquire			atomic_cmpxchg
 # define atomic_cmpxchg_release			atomic_cmpxchg
 #else
-# ifndef atomic_cmpxchg_acquire
-#  define atomic_cmpxchg_acquire(...)		__atomic_op_acquire(atomic_cmpxchg, __VA_ARGS__)
-# endif
-# ifndef atomic_cmpxchg_release
-#  define atomic_cmpxchg_release(...)		__atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
-# endif
 # ifndef atomic_cmpxchg
 #  define atomic_cmpxchg(...)			__atomic_op_fence(atomic_cmpxchg, __VA_ARGS__)
+#  define atomic_cmpxchg_acquire(...)		__atomic_op_acquire(atomic_cmpxchg, __VA_ARGS__)
+#  define atomic_cmpxchg_release(...)		__atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
 # endif
 #endif
 
@@ -362,57 +277,39 @@
 # define atomic_try_cmpxchg_release		atomic_try_cmpxchg
 #endif
 
-/* cmpxchg_relaxed() et al: */
-
 #ifndef cmpxchg_relaxed
 # define cmpxchg_relaxed			cmpxchg
 # define cmpxchg_acquire			cmpxchg
 # define cmpxchg_release			cmpxchg
 #else
-# ifndef cmpxchg_acquire
-#  define cmpxchg_acquire(...)			__atomic_op_acquire(cmpxchg, __VA_ARGS__)
-# endif
-# ifndef cmpxchg_release
-#  define cmpxchg_release(...)			__atomic_op_release(cmpxchg, __VA_ARGS__)
-# endif
 # ifndef cmpxchg
 #  define cmpxchg(...)				__atomic_op_fence(cmpxchg, __VA_ARGS__)
+#  define cmpxchg_acquire(...)			__atomic_op_acquire(cmpxchg, __VA_ARGS__)
+#  define cmpxchg_release(...)			__atomic_op_release(cmpxchg, __VA_ARGS__)
 # endif
 #endif
 
-/* cmpxchg64_relaxed() et al: */
-
 #ifndef cmpxchg64_relaxed
 # define cmpxchg64_relaxed			cmpxchg64
 # define cmpxchg64_acquire			cmpxchg64
 # define cmpxchg64_release			cmpxchg64
 #else
-# ifndef cmpxchg64_acquire
-#  define cmpxchg64_acquire(...)		__atomic_op_acquire(cmpxchg64, __VA_ARGS__)
-# endif
-# ifndef cmpxchg64_release
-#  define cmpxchg64_release(...)		__atomic_op_release(cmpxchg64, __VA_ARGS__)
-# endif
 # ifndef cmpxchg64
 #  define cmpxchg64(...)			__atomic_op_fence(cmpxchg64, __VA_ARGS__)
+#  define cmpxchg64_acquire(...)		__atomic_op_acquire(cmpxchg64, __VA_ARGS__)
+#  define cmpxchg64_release(...)		__atomic_op_release(cmpxchg64, __VA_ARGS__)
 # endif
 #endif
 
-/* xchg_relaxed() et al: */
-
 #ifndef xchg_relaxed
 # define xchg_relaxed				xchg
 # define xchg_acquire				xchg
 # define xchg_release				xchg
 #else
-# ifndef xchg_acquire
-#  define xchg_acquire(...)			__atomic_op_acquire(xchg, __VA_ARGS__)
-# endif
-# ifndef xchg_release
-#  define xchg_release(...)			__atomic_op_release(xchg, __VA_ARGS__)
-# endif
 # ifndef xchg
 #  define xchg(...)				__atomic_op_fence(xchg, __VA_ARGS__)
+#  define xchg_acquire(...)			__atomic_op_acquire(xchg, __VA_ARGS__)
+#  define xchg_release(...)			__atomic_op_release(xchg, __VA_ARGS__)
 # endif
 #endif
 
@@ -569,98 +466,66 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 # define atomic64_set_release(v, i)		smp_store_release(&(v)->counter, (i))
 #endif
 
-/* atomic64_add_return_relaxed() et al: */
-
 #ifndef atomic64_add_return_relaxed
 # define atomic64_add_return_relaxed		atomic64_add_return
 # define atomic64_add_return_acquire		atomic64_add_return
 # define atomic64_add_return_release		atomic64_add_return
 #else
-# ifndef atomic64_add_return_acquire
-#  define atomic64_add_return_acquire(...)	__atomic_op_acquire(atomic64_add_return, __VA_ARGS__)
-# endif
-# ifndef atomic64_add_return_release
-#  define atomic64_add_return_release(...)	__atomic_op_release(atomic64_add_return, __VA_ARGS__)
-# endif
 # ifndef atomic64_add_return
 #  define atomic64_add_return(...)		__atomic_op_fence(atomic64_add_return, __VA_ARGS__)
+#  define atomic64_add_return_acquire(...)	__atomic_op_acquire(atomic64_add_return, __VA_ARGS__)
+#  define atomic64_add_return_release(...)	__atomic_op_release(atomic64_add_return, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic64_inc_return_relaxed() et al: */
-
 #ifndef atomic64_inc_return_relaxed
 # define atomic64_inc_return_relaxed		atomic64_inc_return
 # define atomic64_inc_return_acquire		atomic64_inc_return
 # define atomic64_inc_return_release		atomic64_inc_return
 #else
-# ifndef atomic64_inc_return_acquire
-#  define atomic64_inc_return_acquire(...)	__atomic_op_acquire(atomic64_inc_return, __VA_ARGS__)
-# endif
-# ifndef atomic64_inc_return_release
-#  define atomic64_inc_return_release(...)	__atomic_op_release(atomic64_inc_return, __VA_ARGS__)
-# endif
 # ifndef atomic64_inc_return
 #  define atomic64_inc_return(...)		__atomic_op_fence(atomic64_inc_return, __VA_ARGS__)
+#  define atomic64_inc_return_acquire(...)	__atomic_op_acquire(atomic64_inc_return, __VA_ARGS__)
+#  define atomic64_inc_return_release(...)	__atomic_op_release(atomic64_inc_return, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic64_sub_return_relaxed() et al: */
-
 #ifndef atomic64_sub_return_relaxed
 # define atomic64_sub_return_relaxed		atomic64_sub_return
 # define atomic64_sub_return_acquire		atomic64_sub_return
 # define atomic64_sub_return_release		atomic64_sub_return
 #else
-# ifndef atomic64_sub_return_acquire
-#  define atomic64_sub_return_acquire(...)	__atomic_op_acquire(atomic64_sub_return, __VA_ARGS__)
-# endif
-# ifndef atomic64_sub_return_release
-#  define atomic64_sub_return_release(...)	__atomic_op_release(atomic64_sub_return, __VA_ARGS__)
-# endif
 # ifndef atomic64_sub_return
 #  define atomic64_sub_return(...)		__atomic_op_fence(atomic64_sub_return, __VA_ARGS__)
+#  define atomic64_sub_return_acquire(...)	__atomic_op_acquire(atomic64_sub_return, __VA_ARGS__)
+#  define atomic64_sub_return_release(...)	__atomic_op_release(atomic64_sub_return, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic64_dec_return_relaxed() et al: */
-
 #ifndef atomic64_dec_return_relaxed
 # define atomic64_dec_return_relaxed		atomic64_dec_return
 # define atomic64_dec_return_acquire		atomic64_dec_return
 # define atomic64_dec_return_release		atomic64_dec_return
 #else
-# ifndef atomic64_dec_return_acquire
-#  define atomic64_dec_return_acquire(...)	__atomic_op_acquire(atomic64_dec_return, __VA_ARGS__)
-# endif
-# ifndef atomic64_dec_return_release
-#  define atomic64_dec_return_release(...)	__atomic_op_release(atomic64_dec_return, __VA_ARGS__)
-# endif
 # ifndef atomic64_dec_return
 #  define atomic64_dec_return(...)		__atomic_op_fence(atomic64_dec_return, __VA_ARGS__)
+#  define atomic64_dec_return_acquire(...)	__atomic_op_acquire(atomic64_dec_return, __VA_ARGS__)
+#  define atomic64_dec_return_release(...)	__atomic_op_release(atomic64_dec_return, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic64_fetch_add_relaxed() et al: */
-
 #ifndef atomic64_fetch_add_relaxed
 # define atomic64_fetch_add_relaxed		atomic64_fetch_add
 # define atomic64_fetch_add_acquire		atomic64_fetch_add
 # define atomic64_fetch_add_release		atomic64_fetch_add
 #else
-# ifndef atomic64_fetch_add_acquire
-#  define atomic64_fetch_add_acquire(...)	__atomic_op_acquire(atomic64_fetch_add, __VA_ARGS__)
-# endif
-# ifndef atomic64_fetch_add_release
-#  define atomic64_fetch_add_release(...)	__atomic_op_release(atomic64_fetch_add, __VA_ARGS__)
-# endif
 # ifndef atomic64_fetch_add
 #  define atomic64_fetch_add(...)		__atomic_op_fence(atomic64_fetch_add, __VA_ARGS__)
+#  define atomic64_fetch_add_acquire(...)	__atomic_op_acquire(atomic64_fetch_add, __VA_ARGS__)
+#  define atomic64_fetch_add_release(...)	__atomic_op_release(atomic64_fetch_add, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic64_fetch_inc_relaxed() et al: */
-
 #ifndef atomic64_fetch_inc_relaxed
 # ifndef atomic64_fetch_inc
 #  define atomic64_fetch_inc(v)			atomic64_fetch_add(1, (v))
@@ -673,37 +538,25 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 #  define atomic64_fetch_inc_release		atomic64_fetch_inc
 # endif
 #else
-# ifndef atomic64_fetch_inc_acquire
-#  define atomic64_fetch_inc_acquire(...)	__atomic_op_acquire(atomic64_fetch_inc, __VA_ARGS__)
-# endif
-# ifndef atomic64_fetch_inc_release
-#  define atomic64_fetch_inc_release(...)	__atomic_op_release(atomic64_fetch_inc, __VA_ARGS__)
-# endif
 # ifndef atomic64_fetch_inc
 #  define atomic64_fetch_inc(...)		__atomic_op_fence(atomic64_fetch_inc, __VA_ARGS__)
+#  define atomic64_fetch_inc_acquire(...)	__atomic_op_acquire(atomic64_fetch_inc, __VA_ARGS__)
+#  define atomic64_fetch_inc_release(...)	__atomic_op_release(atomic64_fetch_inc, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic64_fetch_sub_relaxed() et al: */
-
 #ifndef atomic64_fetch_sub_relaxed
 # define atomic64_fetch_sub_relaxed		atomic64_fetch_sub
 # define atomic64_fetch_sub_acquire		atomic64_fetch_sub
 # define atomic64_fetch_sub_release		atomic64_fetch_sub
 #else
-# ifndef atomic64_fetch_sub_acquire
-#  define atomic64_fetch_sub_acquire(...)	__atomic_op_acquire(atomic64_fetch_sub, __VA_ARGS__)
-# endif
-# ifndef atomic64_fetch_sub_release
-#  define atomic64_fetch_sub_release(...)	__atomic_op_release(atomic64_fetch_sub, __VA_ARGS__)
-# endif
 # ifndef atomic64_fetch_sub
 #  define atomic64_fetch_sub(...)		__atomic_op_fence(atomic64_fetch_sub, __VA_ARGS__)
+#  define atomic64_fetch_sub_acquire(...)	__atomic_op_acquire(atomic64_fetch_sub, __VA_ARGS__)
+#  define atomic64_fetch_sub_release(...)	__atomic_op_release(atomic64_fetch_sub, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic64_fetch_dec_relaxed() et al: */
-
 #ifndef atomic64_fetch_dec_relaxed
 # ifndef atomic64_fetch_dec
 #  define atomic64_fetch_dec(v)			atomic64_fetch_sub(1, (v))
@@ -716,127 +569,86 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 #  define atomic64_fetch_dec_release		atomic64_fetch_dec
 # endif
 #else
-# ifndef atomic64_fetch_dec_acquire
-#  define atomic64_fetch_dec_acquire(...)	__atomic_op_acquire(atomic64_fetch_dec, __VA_ARGS__)
-# endif
-# ifndef atomic64_fetch_dec_release
-#  define atomic64_fetch_dec_release(...)	__atomic_op_release(atomic64_fetch_dec, __VA_ARGS__)
-# endif
 # ifndef atomic64_fetch_dec
 #  define atomic64_fetch_dec(...)		__atomic_op_fence(atomic64_fetch_dec, __VA_ARGS__)
+#  define atomic64_fetch_dec_acquire(...)	__atomic_op_acquire(atomic64_fetch_dec, __VA_ARGS__)
+#  define atomic64_fetch_dec_release(...)	__atomic_op_release(atomic64_fetch_dec, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic64_fetch_or_relaxed() et al: */
-
 #ifndef atomic64_fetch_or_relaxed
 # define atomic64_fetch_or_relaxed		atomic64_fetch_or
 # define atomic64_fetch_or_acquire		atomic64_fetch_or
 # define atomic64_fetch_or_release		atomic64_fetch_or
 #else
-# ifndef atomic64_fetch_or_acquire
-#  define atomic64_fetch_or_acquire(...)	__atomic_op_acquire(atomic64_fetch_or, __VA_ARGS__)
-# endif
-# ifndef atomic64_fetch_or_release
-#  define atomic64_fetch_or_release(...)	__atomic_op_release(atomic64_fetch_or, __VA_ARGS__)
-# endif
 # ifndef atomic64_fetch_or
 #  define atomic64_fetch_or(...)		__atomic_op_fence(atomic64_fetch_or, __VA_ARGS__)
+#  define atomic64_fetch_or_acquire(...)	__atomic_op_acquire(atomic64_fetch_or, __VA_ARGS__)
+#  define atomic64_fetch_or_release(...)	__atomic_op_release(atomic64_fetch_or, __VA_ARGS__)
 # endif
 #endif
 
-
-/* atomic64_fetch_and_relaxed() et al: */
-
 #ifndef atomic64_fetch_and_relaxed
 # define atomic64_fetch_and_relaxed		atomic64_fetch_and
 # define atomic64_fetch_and_acquire		atomic64_fetch_and
 # define atomic64_fetch_and_release		atomic64_fetch_and
 #else
-# ifndef atomic64_fetch_and_acquire
-#  define atomic64_fetch_and_acquire(...)	__atomic_op_acquire(atomic64_fetch_and, __VA_ARGS__)
-# endif
-# ifndef atomic64_fetch_and_release
-#  define atomic64_fetch_and_release(...)	__atomic_op_release(atomic64_fetch_and, __VA_ARGS__)
-# endif
 # ifndef atomic64_fetch_and
 #  define atomic64_fetch_and(...)		__atomic_op_fence(atomic64_fetch_and, __VA_ARGS__)
+#  define atomic64_fetch_and_acquire(...)	__atomic_op_acquire(atomic64_fetch_and, __VA_ARGS__)
+#  define atomic64_fetch_and_release(...)	__atomic_op_release(atomic64_fetch_and, __VA_ARGS__)
 # endif
 #endif
 
 #ifdef atomic64_andnot
 
-/* atomic64_fetch_andnot_relaxed() et al: */
-
 #ifndef atomic64_fetch_andnot_relaxed
 # define atomic64_fetch_andnot_relaxed		atomic64_fetch_andnot
 # define atomic64_fetch_andnot_acquire		atomic64_fetch_andnot
 # define atomic64_fetch_andnot_release		atomic64_fetch_andnot
 #else
-# ifndef atomic64_fetch_andnot_acquire
-#  define atomic64_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
-# endif
-# ifndef atomic64_fetch_andnot_release
-#  define atomic64_fetch_andnot_release(...)	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
-# endif
 # ifndef atomic64_fetch_andnot
 #  define atomic64_fetch_andnot(...)		__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
+#  define atomic64_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
+#  define atomic64_fetch_andnot_release(...)	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
 # endif
 #endif
 
 #endif /* atomic64_andnot */
 
-/* atomic64_fetch_xor_relaxed() et al: */
-
 #ifndef atomic64_fetch_xor_relaxed
 # define atomic64_fetch_xor_relaxed		atomic64_fetch_xor
 # define atomic64_fetch_xor_acquire		atomic64_fetch_xor
 # define atomic64_fetch_xor_release		atomic64_fetch_xor
 #else
-# ifndef atomic64_fetch_xor_acquire
-#  define atomic64_fetch_xor_acquire(...)	__atomic_op_acquire(atomic64_fetch_xor, __VA_ARGS__)
-# endif
-# ifndef atomic64_fetch_xor_release
-#  define atomic64_fetch_xor_release(...)	__atomic_op_release(atomic64_fetch_xor, __VA_ARGS__)
-# endif
 # ifndef atomic64_fetch_xor
 #  define atomic64_fetch_xor(...)		__atomic_op_fence(atomic64_fetch_xor, __VA_ARGS__)
+#  define atomic64_fetch_xor_acquire(...)	__atomic_op_acquire(atomic64_fetch_xor, __VA_ARGS__)
+#  define atomic64_fetch_xor_release(...)	__atomic_op_release(atomic64_fetch_xor, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic64_xchg_relaxed() et al: */
-
 #ifndef atomic64_xchg_relaxed
 # define atomic64_xchg_relaxed			atomic64_xchg
 # define atomic64_xchg_acquire			atomic64_xchg
 # define atomic64_xchg_release			atomic64_xchg
 #else
-# ifndef atomic64_xchg_acquire
-#  define atomic64_xchg_acquire(...)		__atomic_op_acquire(atomic64_xchg, __VA_ARGS__)
-# endif
-# ifndef atomic64_xchg_release
-#  define atomic64_xchg_release(...)		__atomic_op_release(atomic64_xchg, __VA_ARGS__)
-# endif
 # ifndef atomic64_xchg
 #  define atomic64_xchg(...)			__atomic_op_fence(atomic64_xchg, __VA_ARGS__)
+#  define atomic64_xchg_acquire(...)		__atomic_op_acquire(atomic64_xchg, __VA_ARGS__)
+#  define atomic64_xchg_release(...)		__atomic_op_release(atomic64_xchg, __VA_ARGS__)
 # endif
 #endif
 
-/* atomic64_cmpxchg_relaxed() et al: */
-
 #ifndef atomic64_cmpxchg_relaxed
 # define atomic64_cmpxchg_relaxed		atomic64_cmpxchg
 # define atomic64_cmpxchg_acquire		atomic64_cmpxchg
 # define atomic64_cmpxchg_release		atomic64_cmpxchg
 #else
-# ifndef atomic64_cmpxchg_acquire
-#  define atomic64_cmpxchg_acquire(...)		__atomic_op_acquire(atomic64_cmpxchg, __VA_ARGS__)
-# endif
-# ifndef atomic64_cmpxchg_release
-#  define atomic64_cmpxchg_release(...)		__atomic_op_release(atomic64_cmpxchg, __VA_ARGS__)
-# endif
 # ifndef atomic64_cmpxchg
 #  define atomic64_cmpxchg(...)			__atomic_op_fence(atomic64_cmpxchg, __VA_ARGS__)
+#  define atomic64_cmpxchg_acquire(...)		__atomic_op_acquire(atomic64_cmpxchg, __VA_ARGS__)
+#  define atomic64_cmpxchg_release(...)		__atomic_op_release(atomic64_cmpxchg, __VA_ARGS__)
 # endif
 #endif
 
