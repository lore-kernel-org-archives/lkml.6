Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeEEKtP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:49:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35055 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeEEKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:49:02 -0400
X-Google-Smtp-Source: AB8JxZpLFOXEe9q85UKWuGCGC7vxdhRZRrfjxK5c/7AvND+reUcAjDiGe38cV+hP9IdvAGPJzuLIiw==
Date: Sat, 5 May 2018 12:48:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com, catalin.marinas@arm.com,
        dvyukov@google.com, will.deacon@arm.com
Subject: [PATCH] locking/atomics: Shorten the __atomic_op() defines to __op()
Message-ID: <20180505104858.ap4bfv6ip2vprzyj@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090903.ebsf5vosgwckxooy@gmail.com>
 <20180505092911.GC12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505092911.GC12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, May 05, 2018 at 11:09:03AM +0200, Ingo Molnar wrote:
> > > >  # ifndef atomic_fetch_dec_acquire
> > > >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> > > >  # endif
> > > >  # ifndef atomic_fetch_dec_release
> > > >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> > > >  # endif
> > > >  # ifndef atomic_fetch_dec
> > > >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> > > >  # endif
> > > >  #endif
> > > > 
> > > > The new variant is readable at a glance, and the hierarchy of defines is very 
> > > > obvious as well.
> > > 
> > > It wraps and looks hideous in my normal setup. And I do detest that indent
> > > after # thing.
> > 
> > You should use wider terminals if you take a look at such code - there's already 
> > numerous areas of the kernel that are not readable on 80x25 terminals.
> > 
> > _Please_ try the following experiment, for me:
> > 
> > Enter the 21st century temporarily and widen two of your terminals from 80 cols to 
> > 100 cols - it's only ~20% wider.
> 
> Doesn't work that way. The only way I get more columns is if I shrink my
> font further. I work with tiles per monitor (left/right obv.) and use
> two columns per editor. This gets me a total of 4 columns.
> 
> On my desktop that is slightly over 100 characters per column, on my
> laptop that is slightly below 100 -- mostly because I'm pixel limited on
> fontsize on that thing (FullHD sucks).
> 
> If it wraps it wraps.

Out of the 707 lines in atomic.h only 25 are wider than 100 chars - and the max 
length is 104 chars.

If that's too then there's a few more things we could do - for example the 
attached patch renames a (very minor) misnomer to a shorter name and thus saves on 
the longest lines, the column histogram now looks like this:

    79 4
    80 7
    81 3
    82 9
    84 4
    85 2
    86 3
    87 1
    88 4
    89 13
    90 7
    91 20
    92 18
    93 12
    94 11
    96 5

I.e. the longest line is down to 96 columns, and 99% of the file is 94 cols or 
shorter.

Is this still too long?

Thanks,

	Ingo

============================>
From: Ingo Molnar <mingo@kernel.org>
Date: Sat, 5 May 2018 12:41:57 +0200
Subject: [PATCH] locking/atomics: Shorten the __atomic_op() defines to __op()

The __atomic prefix is somewhat of a misnomer, because not all
APIs we use with these macros have an atomic_ prefix.

This also reduces the length of the longest lines in the header,
making them more readable on PeterZ's terminals.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul E. McKenney <paulmck@us.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aryabinin@virtuozzo.com
Cc: boqun.feng@gmail.com
Cc: catalin.marinas@arm.com
Cc: dvyukov@google.com
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/atomic.h | 204 +++++++++++++++++++++++++------------------------
 1 file changed, 103 insertions(+), 101 deletions(-)

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
 
