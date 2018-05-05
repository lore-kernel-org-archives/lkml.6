Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeEEKBB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:01:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55446 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEEKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:00:59 -0400
X-Google-Smtp-Source: AB8JxZoa3Orx5C0cnufswZIcWsRmgNkfjhJgcKOqrNMYcjm0+66UPs+2gJ4Cnwococvsvfu9GOvdEw==
Date: Sat, 5 May 2018 12:00:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com, catalin.marinas@arm.com,
        dvyukov@google.com, will.deacon@arm.com
Subject: [RFC PATCH] locking/atomics/powerpc: Introduce optimized
 cmpxchg_release() family of APIs for PowerPC
Message-ID: <20180505100055.yc4upauxo5etq5ud@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505093829.xfylnedwd5nonhae@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > So there's no loss in arch flexibility.
> 
> BTW., PowerPC for example is already in such a situation, it does not define 
> atomic_cmpxchg_release(), only the other APIs:
> 
> #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
> #define atomic_cmpxchg_relaxed(v, o, n) \
> 	cmpxchg_relaxed(&((v)->counter), (o), (n))
> #define atomic_cmpxchg_acquire(v, o, n) \
> 	cmpxchg_acquire(&((v)->counter), (o), (n))
> 
> Was it really the intention on the PowerPC side that the generic code falls back 
> to cmpxchg(), i.e.:
> 
> #  define atomic_cmpxchg_release(...)           __atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
> 
> Which after macro expansion becomes:
> 
> 	smp_mb__before_atomic();
> 	atomic_cmpxchg_relaxed(v, o, n);
> 
> smp_mb__before_atomic() on PowerPC falls back to the generic __smp_mb(), which 
> falls back to mb(), which on PowerPC is the 'sync' instruction.
> 
> Isn't this a inefficiency bug?
> 
> While I'm pretty clueless about PowerPC low level cmpxchg atomics, they appear to 
> have the following basic structure:
> 
> full cmpxchg():
> 
> 	PPC_ATOMIC_ENTRY_BARRIER # sync
> 	ldarx + stdcx
> 	PPC_ATOMIC_EXIT_BARRIER  # sync
> 
> cmpxchg_relaxed():
> 
> 	ldarx + stdcx
> 
> cmpxchg_acquire():
> 
> 	ldarx + stdcx
> 	PPC_ACQUIRE_BARRIER      # lwsync
> 
> The logical extension for cmpxchg_release() would be:
> 
> cmpxchg_release():
> 
> 	PPC_RELEASE_BARRIER      # lwsync
> 	ldarx + stdcx
> 
> But instead we silently get the generic fallback, which does:
> 
> 	smp_mb__before_atomic();
> 	atomic_cmpxchg_relaxed(v, o, n);
> 
> Which maps to:
> 
> 	sync
> 	ldarx + stdcx
> 
> Note that it uses a full barrier instead of lwsync (does that stand for 
> 'lightweight sync'?).
> 
> Even if it turns out we need the full barrier, with the overly finegrained 
> structure of the atomics this detail is totally undocumented and non-obvious.

The patch below fills in those bits and implements the optimized cmpxchg_release() 
family of APIs. The end effect should be that cmpxchg_release() will now use 
'lwsync' instead of 'sync' on PowerPC, for the following APIs:

  cmpxchg_release()
  cmpxchg64_release()
  atomic_cmpxchg_release()
  atomic64_cmpxchg_release()

I based this choice of the release barrier on an existing bitops low level PowerPC 
method:

   DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)

This clearly suggests that PPC_RELEASE_BARRIER is in active use and 'lwsync' is 
the 'release barrier' instruction, if I interpreted that right.

But I know very little about PowerPC so this might be spectacularly wrong. It's 
totally untested as well. I also pretty sick today so my mental capabilities are 
significantly reduced ...

So not signed off and such.

Thanks,

	Ingo

---
 arch/powerpc/include/asm/atomic.h  |  4 ++
 arch/powerpc/include/asm/cmpxchg.h | 81 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

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
index 9b001f1f6b32..6e46310b1833 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -213,10 +213,12 @@ __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
 CMPXCHG_GEN(u8, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "memory");
 CMPXCHG_GEN(u8, _local, , , "memory");
 CMPXCHG_GEN(u8, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
+CMPXCHG_GEN(u8, _release, PPC_RELEASE_BARRIER, , "memory");
 CMPXCHG_GEN(u8, _relaxed, , , "cc");
 CMPXCHG_GEN(u16, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "memory");
 CMPXCHG_GEN(u16, _local, , , "memory");
 CMPXCHG_GEN(u16, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
+CMPXCHG_GEN(u16, _release, PPC_RELEASE_BARRIER, , "memory");
 CMPXCHG_GEN(u16, _relaxed, , , "cc");
 
 static __always_inline unsigned long
@@ -314,6 +316,29 @@ __cmpxchg_u32_acquire(u32 *p, unsigned long old, unsigned long new)
 	return prev;
 }
 
+static __always_inline unsigned long
+__cmpxchg_u32_release(u32 *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__ (
+	PPC_RELEASE_BARRIER
+"1:	lwarx	%0,0,%2		# __cmpxchg_u32_release\n"
+"	cmpw	0,%0,%3\n"
+"	bne-	2f\n"
+	PPC405_ERR77(0, %2)
+"	stwcx.	%4,0,%2\n"
+"	bne-	1b\n"
+	"\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
+
+
 #ifdef CONFIG_PPC64
 static __always_inline unsigned long
 __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned long new)
@@ -397,6 +422,27 @@ __cmpxchg_u64_acquire(u64 *p, unsigned long old, unsigned long new)
 
 	return prev;
 }
+
+static __always_inline unsigned long
+__cmpxchg_u64_release(u64 *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__ (
+	PPC_RELEASE_BARRIER
+"1:	ldarx	%0,0,%2		# __cmpxchg_u64_release\n"
+"	cmpd	0,%0,%3\n"
+"	bne-	2f\n"
+"	stdcx.	%4,0,%2\n"
+"	bne-	1b\n"
+	"\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
 #endif
 
 static __always_inline unsigned long
@@ -478,6 +524,27 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 	BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg_acquire");
 	return old;
 }
+
+static __always_inline unsigned long
+__cmpxchg_release(void *ptr, unsigned long old, unsigned long new,
+		  unsigned int size)
+{
+	switch (size) {
+	case 1:
+		return __cmpxchg_u8_release(ptr, old, new);
+	case 2:
+		return __cmpxchg_u16_release(ptr, old, new);
+	case 4:
+		return __cmpxchg_u32_release(ptr, old, new);
+#ifdef CONFIG_PPC64
+	case 8:
+		return __cmpxchg_u64_release(ptr, old, new);
+#endif
+	}
+	BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg_release");
+	return old;
+}
+
 #define cmpxchg(ptr, o, n)						 \
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
@@ -512,6 +579,15 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 			(unsigned long)_o_, (unsigned long)_n_,		\
 			sizeof(*(ptr)));				\
 })
+
+#define cmpxchg_release(ptr, o, n)					\
+({									\
+	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _n_ = (n);					\
+	(__typeof__(*(ptr))) __cmpxchg_release((ptr),			\
+			(unsigned long)_o_, (unsigned long)_n_,		\
+			sizeof(*(ptr)));				\
+})
 #ifdef CONFIG_PPC64
 #define cmpxchg64(ptr, o, n)						\
   ({									\
@@ -533,6 +609,11 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	cmpxchg_acquire((ptr), (o), (n));				\
 })
+#define cmpxchg64_release(ptr, o, n)					\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	cmpxchg_release((ptr), (o), (n));				\
+})
 #else
 #include <asm-generic/cmpxchg-local.h>
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
