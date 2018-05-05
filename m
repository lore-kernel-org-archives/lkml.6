Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeEEKf4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:35:56 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51250 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeEEKfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:35:54 -0400
X-Google-Smtp-Source: AB8JxZosssAm7G9y1FDTGrxwXejzarM9S8/o06FTmhYEl3+2Hqe7WEQYqcPkuAKIl8u2hpqmXd7/qA==
Date: Sat, 5 May 2018 12:35:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, catalin.marinas@arm.com, dvyukov@google.com,
        will.deacon@arm.com
Subject: [RFC PATCH] locking/atomics/powerpc: Clarify why the
 cmpxchg_relaxed() family of APIs falls back to full cmpxchg()
Message-ID: <20180505103550.s7xsnto7tgppkmle@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
 <20180505101609.5wb56j4mspjkokmw@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505101609.5wb56j4mspjkokmw@tardis>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sat, May 05, 2018 at 11:38:29AM +0200, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > > * Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > > So we could do the following simplification on top of that:
> > > > > 
> > > > >  #ifndef atomic_fetch_dec_relaxed
> > > > >  # ifndef atomic_fetch_dec
> > > > >  #  define atomic_fetch_dec(v)		atomic_fetch_sub(1, (v))
> > > > >  #  define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed(1, (v))
> > > > >  #  define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire(1, (v))
> > > > >  #  define atomic_fetch_dec_release(v)	atomic_fetch_sub_release(1, (v))
> > > > >  # else
> > > > >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> > > > >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> > > > >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> > > > >  # endif
> > > > >  #else
> > > > >  # ifndef atomic_fetch_dec
> > > > >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> > > > >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> > > > >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> > > > >  # endif
> > > > >  #endif
> > > > 
> > > > This would disallow an architecture to override just fetch_dec_release for
> > > > instance.
> > > 
> > > Couldn't such a crazy arch just define _all_ the 3 APIs in this group?
> > > That's really a small price and makes the place pay the complexity
> > > price that does the weirdness...
> > > 
> > > > I don't think there currently is any architecture that does that, but the
> > > > intent was to allow it to override anything and only provide defaults where it
> > > > does not.
> > > 
> > > I'd argue that if a new arch only defines one of these APIs that's probably a bug. 
> > > If they absolutely want to do it, they still can - by defining all 3 APIs.
> > > 
> > > So there's no loss in arch flexibility.
> > 
> > BTW., PowerPC for example is already in such a situation, it does not define 
> > atomic_cmpxchg_release(), only the other APIs:
> > 
> > #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
> > #define atomic_cmpxchg_relaxed(v, o, n) \
> > 	cmpxchg_relaxed(&((v)->counter), (o), (n))
> > #define atomic_cmpxchg_acquire(v, o, n) \
> > 	cmpxchg_acquire(&((v)->counter), (o), (n))
> > 
> > Was it really the intention on the PowerPC side that the generic code falls back 
> > to cmpxchg(), i.e.:
> > 
> > #  define atomic_cmpxchg_release(...)           __atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
> > 
> 
> So ppc has its own definition __atomic_op_release() in
> arch/powerpc/include/asm/atomic.h:
> 
> 	#define __atomic_op_release(op, args...)				\
> 	({									\
> 		__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
> 		op##_relaxed(args);						\
> 	})
> 
> , and PPC_RELEASE_BARRIER is lwsync, so we map to
> 
> 	lwsync();
> 	atomic_cmpxchg_relaxed(v, o, n);
> 
> And the reason, why we don't define atomic_cmpxchg_release() but define
> atomic_cmpxchg_acquire() is that, atomic_cmpxchg_*() could provide no
> ordering guarantee if the cmp fails, we did this for
> atomic_cmpxchg_acquire() but not for atomic_cmpxchg_release(), because
> doing so may introduce a memory barrier inside a ll/sc critical section,
> please see the comment before __cmpxchg_u32_acquire() in
> arch/powerpc/include/asm/cmpxchg.h:
> 
> 	/*
> 	 * cmpxchg family don't have order guarantee if cmp part fails, therefore we
> 	 * can avoid superfluous barriers if we use assembly code to implement
> 	 * cmpxchg() and cmpxchg_acquire(), however we don't do the similar for
> 	 * cmpxchg_release() because that will result in putting a barrier in the
> 	 * middle of a ll/sc loop, which is probably a bad idea. For example, this
> 	 * might cause the conditional store more likely to fail.
> 	 */

Makes sense, thanks a lot for the explanation, missed that comment in the middle 
of the assembly functions!

So the patch I sent is buggy, please disregard it.

May I suggest the patch below? No change in functionality, but it documents the 
lack of the cmpxchg_release() APIs and maps them explicitly to the full cmpxchg() 
version. (Which the generic code does now in a rather roundabout way.)

Also, the change to arch/powerpc/include/asm/atomic.h has no functional effect 
right now either, but should anyone add a _relaxed() variant in the future, with 
this change atomic_cmpxchg_release() and atomic64_cmpxchg_release() will pick that 
up automatically.

Would this be acceptable?

Thanks,

	Ingo

---
 arch/powerpc/include/asm/atomic.h  |  4 ++++
 arch/powerpc/include/asm/cmpxchg.h | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 682b3e6a1e21..f7a6f29acb12 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -213,6 +213,8 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
 	cmpxchg_relaxed(&((v)->counter), (o), (n))
 #define atomic_cmpxchg_acquire(v, o, n) \
 	cmpxchg_acquire(&((v)->counter), (o), (n))
+#define atomic_cmpxchg_release(v, o, n) \
+	cmpxchg_release(&((v)->counter), (o), (n))
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 #define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
@@ -519,6 +521,8 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 	cmpxchg_relaxed(&((v)->counter), (o), (n))
 #define atomic64_cmpxchg_acquire(v, o, n) \
 	cmpxchg_acquire(&((v)->counter), (o), (n))
+#define atomic64_cmpxchg_release(v, o, n) \
+	cmpxchg_release(&((v)->counter), (o), (n))
 
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 #define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 9b001f1f6b32..1f1d35062f3a 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -512,6 +512,13 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 			(unsigned long)_o_, (unsigned long)_n_,		\
 			sizeof(*(ptr)));				\
 })
+
+/*
+ * cmpxchg_release() falls back to a full cmpxchg(),
+ * see the comments at __cmpxchg_u32_acquire():
+ */
+#define cmpxchg_release cmpxchg
+
 #ifdef CONFIG_PPC64
 #define cmpxchg64(ptr, o, n)						\
   ({									\
@@ -538,5 +545,11 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
 #endif
 
+/*
+ * cmpxchg64_release() falls back to a full cmpxchg(),
+ * see the comments at __cmpxchg_u32_acquire():
+ */
+#define cmpxchg64_release cmpxchg64
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CMPXCHG_H_ */
