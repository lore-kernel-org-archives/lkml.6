Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeE3LXX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:23:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54338 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeE3LXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:23:19 -0400
Date: Wed, 30 May 2018 12:23:12 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Subject: Re: [PATCHv2 00/16] atomics: API cleanups
Message-ID: <20180530112311.rwtbiqdpds75m4d6@lakrids.cambridge.arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529154346.3168-1-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:43:30PM +0100, Mark Rutland wrote:
> This series contains a few cleanups of the atomic API, fixing
> inconsistencies between atomic_* and atomic64_*, and minimizing
> repetition in arch code. This is nicer for arch code, and the improved
> regularity will help when generating the atomic headers in future.

> Mark Rutland (16):
>   atomics/treewide: s/__atomic_add_unless/atomic_fetch_add_unless/
>   atomics/treewide: remove redundant atomic_inc_not_zero() definitions
>   atomics/treewide: make atomic64_inc_not_zero() optional
>   atomics/treewide: make atomic_fetch_add_unless() optional
>   atomics: prepare for atomic64_fetch_add_unless()
>   atomics/generic: define atomic64_fetch_add_unless()
>   atomics/alpha: define atomic64_fetch_add_unless()
>   atomics/arc: define atomic64_fetch_add_unless()
>   atomics/arm: define atomic64_fetch_add_unless()
>   atomics/powerpc: define atomic64_fetch_add_unless()
>   atomics/riscv: define atomic64_fetch_add_unless()
>   atomics/treewide: make atomic64_fetch_add_unless() optional
>   atomics/treewide: make test ops optional
>   atomics/treewide: remove atomic_inc_not_zero_hint()
>   atomics/treewide: make unconditional inc/dec ops optional
>   atomics/treewide: make conditional inc/dec ops optional

While testing the subsqeuent generated header patches, I discovered that
the andnot ifdeffery was inconsistent to that for all other atomics, so
I'm going to append the below patch to this series, if it needs a v3.

Otherwise, that's pushed out to my atomics/api-cleanup branch.

Thanks,
Mark,

---->8----
>From da1cef7ec7c1ad143a06723164263ef308bfb569 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 30 May 2018 11:55:28 +0100
Subject: [PATCH] atomics/treewide: clean up andnot ifdeffery

The ifdeffery for atomic*_{fetch_,}andnot() is unlike that for all the
other atomics. If atomic*_andnot() is not defined, the corresponding
atomic*_fetch_andnot() is assumed to not be defined.

Additionally, the fallbacks for the various orering cases are written
much later in atomic.h as static inlines.

This isn't problematic today, but gets in the way of scripting the
generation of atomics. To prepare for scripting, this patch:

* Switches to separate ifdefs for atomic*_andnot() and
  atomic*_fetch_andnot(), updating implementations as appropriate.

* Moves the fallbacks into the standards ifdefs, as macro expansions
  rather than static inlines.

* Removes trivial andnot implementations from architectures, where these
  are superceded by core code.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arc/include/asm/atomic.h |  8 ++--
 arch/arm/include/asm/atomic.h |  2 +
 include/linux/atomic.h        | 96 ++++++++++++++-----------------------------
 3 files changed, 36 insertions(+), 70 deletions(-)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 261c6a4d3f05..b706781825ac 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -187,7 +187,8 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
-#define atomic_andnot atomic_andnot
+#define atomic_andnot		atomic_andnot
+#define atomic_fetch_andnot	atomic_fetch_andnot
 
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, c_op, asm_op)					\
@@ -296,8 +297,6 @@ ATOMIC_OPS(add, +=, CTOP_INST_AADD_DI_R2_R2_R3)
 	ATOMIC_FETCH_OP(op, c_op, asm_op)
 
 ATOMIC_OPS(and, &=, CTOP_INST_AAND_DI_R2_R2_R3)
-#define atomic_andnot(mask, v) atomic_and(~(mask), (v))
-#define atomic_fetch_andnot(mask, v) atomic_fetch_and(~(mask), (v))
 ATOMIC_OPS(or, |=, CTOP_INST_AOR_DI_R2_R2_R3)
 ATOMIC_OPS(xor, ^=, CTOP_INST_AXOR_DI_R2_R2_R3)
 
@@ -430,7 +429,8 @@ static inline long long atomic64_fetch_##op(long long a, atomic64_t *v)	\
 	ATOMIC64_OP_RETURN(op, op1, op2)				\
 	ATOMIC64_FETCH_OP(op, op1, op2)
 
-#define atomic64_andnot atomic64_andnot
+#define atomic64_andnot		atomic64_andnot
+#define atomic64_fetch_andnot	atomic64_fetch_andnot
 
 ATOMIC64_OPS(add, add.f, adc)
 ATOMIC64_OPS(sub, sub.f, sbc)
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 884c241424fe..f74756641410 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -216,6 +216,8 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return ret;
 }
 
+#define atomic_fetch_andnot		atomic_fetch_andnot
+
 #endif /* __LINUX_ARM_ARCH__ */
 
 #define ATOMIC_OPS(op, c_op, asm_op)					\
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 9c1b0769a846..99a2448252a1 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -352,12 +352,22 @@
 #endif
 #endif /* atomic_fetch_and_relaxed */
 
-#ifdef atomic_andnot
-/* atomic_fetch_andnot_relaxed */
+#ifndef atomic_andnot
+#define atomic_andnot(i, v)		atomic_and(~(int)(i), (v))
+#endif
+
 #ifndef atomic_fetch_andnot_relaxed
-#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot
-#define atomic_fetch_andnot_acquire	atomic_fetch_andnot
-#define atomic_fetch_andnot_release	atomic_fetch_andnot
+
+#ifndef atomic_fetch_andnot
+#define atomic_fetch_andnot(i, v)		atomic_fetch_and(~(int)(i), (v))
+#define atomic_fetch_andnot_relaxed(i, v)	atomic_fetch_and_relaxed(~(int)(i), (v))
+#define atomic_fetch_andnot_acquire(i, v)	atomic_fetch_and_acquire(~(int)(i), (v))
+#define atomic_fetch_andnot_release(i, v)	atomic_fetch_and_release(~(int)(i), (v))
+#else /* atomic_fetch_andnot */
+#define atomic_fetch_andnot_relaxed		atomic_fetch_andnot
+#define atomic_fetch_andnot_acquire		atomic_fetch_andnot
+#define atomic_fetch_andnot_release		atomic_fetch_andnot
+#endif /* atomic_fetch_andnot */
 
 #else /* atomic_fetch_andnot_relaxed */
 
@@ -376,7 +386,6 @@
 	__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
 #endif
 #endif /* atomic_fetch_andnot_relaxed */
-#endif /* atomic_andnot */
 
 /* atomic_fetch_xor_relaxed */
 #ifndef atomic_fetch_xor_relaxed
@@ -653,33 +662,6 @@ static inline bool atomic_add_negative(int i, atomic_t *v)
 }
 #endif
 
-#ifndef atomic_andnot
-static inline void atomic_andnot(int i, atomic_t *v)
-{
-	atomic_and(~i, v);
-}
-
-static inline int atomic_fetch_andnot(int i, atomic_t *v)
-{
-	return atomic_fetch_and(~i, v);
-}
-
-static inline int atomic_fetch_andnot_relaxed(int i, atomic_t *v)
-{
-	return atomic_fetch_and_relaxed(~i, v);
-}
-
-static inline int atomic_fetch_andnot_acquire(int i, atomic_t *v)
-{
-	return atomic_fetch_and_acquire(~i, v);
-}
-
-static inline int atomic_fetch_andnot_release(int i, atomic_t *v)
-{
-	return atomic_fetch_and_release(~i, v);
-}
-#endif
-
 #ifndef atomic_inc_unless_negative
 static inline bool atomic_inc_unless_negative(atomic_t *v)
 {
@@ -1026,12 +1008,22 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 #endif
 #endif /* atomic64_fetch_and_relaxed */
 
-#ifdef atomic64_andnot
-/* atomic64_fetch_andnot_relaxed */
+#ifndef atomic_andnot
+#define atomic_andnot(i, v)		atomic_and(~(int)(i), (v))
+#endif
+
 #ifndef atomic64_fetch_andnot_relaxed
-#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot
-#define atomic64_fetch_andnot_acquire	atomic64_fetch_andnot
-#define atomic64_fetch_andnot_release	atomic64_fetch_andnot
+
+#ifndef atomic64_fetch_andnot
+#define atomic64_fetch_andnot(i, v)		atomic64_fetch_and(~(long long)(i), (v))
+#define atomic64_fetch_andnot_relaxed(i, v)	atomic64_fetch_and_relaxed(~(long long)(i), (v))
+#define atomic64_fetch_andnot_acquire(i, v)	atomic64_fetch_and_acquire(~(long long)(i), (v))
+#define atomic64_fetch_andnot_release(i, v)	atomic64_fetch_and_release(~(long long)(i), (v))
+#else /* atomic64_fetch_andnot */
+#define atomic64_fetch_andnot_relaxed		atomic64_fetch_andnot
+#define atomic64_fetch_andnot_acquire		atomic64_fetch_andnot
+#define atomic64_fetch_andnot_release		atomic64_fetch_andnot
+#endif /* atomic64_fetch_andnot */
 
 #else /* atomic64_fetch_andnot_relaxed */
 
@@ -1050,7 +1042,6 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 	__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
 #endif
 #endif /* atomic64_fetch_andnot_relaxed */
-#endif /* atomic64_andnot */
 
 /* atomic64_fetch_xor_relaxed */
 #ifndef atomic64_fetch_xor_relaxed
@@ -1259,33 +1250,6 @@ static inline bool atomic64_add_negative(long long i, atomic64_t *v)
 }
 #endif
 
-#ifndef atomic64_andnot
-static inline void atomic64_andnot(long long i, atomic64_t *v)
-{
-	atomic64_and(~i, v);
-}
-
-static inline long long atomic64_fetch_andnot(long long i, atomic64_t *v)
-{
-	return atomic64_fetch_and(~i, v);
-}
-
-static inline long long atomic64_fetch_andnot_relaxed(long long i, atomic64_t *v)
-{
-	return atomic64_fetch_and_relaxed(~i, v);
-}
-
-static inline long long atomic64_fetch_andnot_acquire(long long i, atomic64_t *v)
-{
-	return atomic64_fetch_and_acquire(~i, v);
-}
-
-static inline long long atomic64_fetch_andnot_release(long long i, atomic64_t *v)
-{
-	return atomic64_fetch_and_release(~i, v);
-}
-#endif
-
 #ifndef atomic64_inc_unless_negative
 static inline bool atomic64_inc_unless_negative(atomic64_t *v)
 {
-- 
2.11.0
