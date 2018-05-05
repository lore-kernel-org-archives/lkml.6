Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeEEN15 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 09:27:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51713 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeEEN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 09:27:55 -0400
X-Google-Smtp-Source: AB8JxZobQY4g8SY2lEJ/QpD0C+LlZMmrEa6yYEigQqEbnXIEnYRXodtGYfPvqbP0KJmItheW5KxhEg==
Date: Sat, 5 May 2018 15:27:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, catalin.marinas@arm.com, dvyukov@google.com,
        will.deacon@arm.com
Subject: [PATCH] locking/atomics/powerpc: Move cmpxchg helpers to
 asm/cmpxchg.h and define the full set of cmpxchg APIs
Message-ID: <20180505132751.gwzu2vbzibr2risd@gmail.com>
References: <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
 <20180505101609.5wb56j4mspjkokmw@tardis>
 <20180505103550.s7xsnto7tgppkmle@gmail.com>
 <20180505112817.ihrb726i37bwm4cj@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505112817.ihrb726i37bwm4cj@tardis>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Boqun Feng <boqun.feng@gmail.com> wrote:

> > May I suggest the patch below? No change in functionality, but it documents the 
> > lack of the cmpxchg_release() APIs and maps them explicitly to the full cmpxchg() 
> > version. (Which the generic code does now in a rather roundabout way.)
> > 
> 
> Hmm.. cmpxchg_release() is actually lwsync() + cmpxchg_relaxed(), but
> you just make it sync() + cmpxchg_relaxed() + sync() with the fallback,
> and sync() is much heavier, so I don't think the fallback is correct.

Indeed!

The bit I missed previously is that PowerPC provides its own __atomic_op_release() 
method:

   #define __atomic_op_release(op, args...)                                \
   ({                                                                      \
           __asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");    \
           op##_relaxed(args);                                             \
   })

... which maps to LWSYNC as you say, and my patch made that worse.

> I think maybe you can move powerpc's __atomic_op_{acqurie,release}()
> from atomic.h to cmpxchg.h (in arch/powerpc/include/asm), and
> 
> 	#define cmpxchg_release __atomic_op_release(cmpxchg, __VA_ARGS__);
> 	#define cmpxchg64_release __atomic_op_release(cmpxchg64, __VA_ARGS__);
> 
> I put a diff below to say what I mean (untested).
> 
> > Also, the change to arch/powerpc/include/asm/atomic.h has no functional effect 
> > right now either, but should anyone add a _relaxed() variant in the future, with 
> > this change atomic_cmpxchg_release() and atomic64_cmpxchg_release() will pick that 
> > up automatically.
> > 
> 
> You mean with your other modification in include/linux/atomic.h, right?
> Because with the unmodified include/linux/atomic.h, we already pick that
> autmatically. If so, I think that's fine.
> 
> Here is the diff for the modification for cmpxchg_release(), the idea is
> we generate them in asm/cmpxchg.h other than linux/atomic.h for ppc, so
> we keep the new linux/atomic.h working. Because if I understand
> correctly, the next linux/atomic.h only accepts that
> 
> 1)	architecture only defines fully ordered primitives
> 
> or
> 
> 2)	architecture only defines _relaxed primitives
> 
> or
> 
> 3)	architecture defines all four (fully, _relaxed, _acquire,
> 	_release) primitives
> 
> So powerpc needs to define all four primitives in its only
> asm/cmpxchg.h.

Correct, although the new logic is still RFC, PeterZ didn't like the first version 
I proposed and might NAK them.

Thanks for the patch - I have created the patch below from it and added your 
Signed-off-by.

The only change I made beyond a trivial build fix is that I also added the release 
atomics variants explicitly:

+#define atomic_cmpxchg_release(v, o, n) \
+	cmpxchg_release(&((v)->counter), (o), (n))
+#define atomic64_cmpxchg_release(v, o, n) \
+	cmpxchg_release(&((v)->counter), (o), (n))

It has passed a PowerPC cross-build test here, but no runtime tests.

Does this patch look good to you?

(Still subject to PeterZ's Ack/NAK.)

Thanks,

	Ingo

======================>
From: Boqun Feng <boqun.feng@gmail.com>
Date: Sat, 5 May 2018 19:28:17 +0800
Subject: [PATCH] locking/atomics/powerpc: Move cmpxchg helpers to asm/cmpxchg.h and define the full set of cmpxchg APIs

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
