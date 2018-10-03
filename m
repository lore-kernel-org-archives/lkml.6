Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518CAC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0224A2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e+MMJZSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0224A2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJCUB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:01:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeJCUB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=udq0FwVhrZO2l8l7vWFiX6c4Uj6Jnht8rWdaf0vKznQ=; b=e+MMJZSqVH/uWYsxAuvmpXpA2y
        iyHeP52d4j0Mq3gx+Osz+AtIWyzF8Ce+MamHXshhuh+l9uISnvHG6xOZnSKmSzXl0fgw+2kP7ev3Z
        g4rKf2wxhBtXeGtCRPkGnD/4jR97A+qznmzhj7fO/kAdcKPfze3Dszl6fJ8iWuSomE74FsMSrbZBt
        lucA9MG48dojGWC9/160GrcF2LlxzkatNbnSS7phng5SONzLLm+XIsMinis0MIxketSfLy68Wq0R3
        d5p4+TMMzYUYqBCCEPs/vQTEgXvG10a65830MD3IUmJu1/ntMFxSyj1z6myR/b/nF9WxtVK62LcXW
        EQKKGsnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7gxu-0003Ap-IE; Wed, 03 Oct 2018 13:13:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1F6C12025A347; Wed,  3 Oct 2018 15:13:15 +0200 (CEST)
Message-ID: <20181003130957.108960094@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Oct 2018 15:03:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de,
        bigeasy@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        hpa@linux.intel.com, JBeulich@suse.com, bp@alien8.de
Subject: [PATCH v2 3/4] x86/asm: Simplify GEN_*_RMWcc() macros
References: <20181003130257.156322446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the GEN_*_RMWcc() macros include a return statement, which
pretty much mandates we directly wrap them in a (inline) function.

Macros with return statements are tricky and, as per the above, limit
use, so remove the return statement and make them
statement-expressions. This allows them to be used more widely.

Also, shuffle the arguments a bit. Place the @cc argument as 3rd, this
makes it consistent between UNARY and BINARY, but more importantly, it
makes the @arg0 argument last.

Since the @arg0 argument is now last, we can do CPP trickery and make
it an optional argument, simplifying the users; 17 out of 18
occurences do not need this argument.

Finally, change to asm symbolic names, instead of the numeric ordering
of operands, which allows us to get rid of __BINARY_RMWcc_ARG and get
cleaner code overall.

Cc: hpa@linux.intel.com
Cc: JBeulich@suse.com
Cc: bp@alien8.de
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h      |    8 ++--
 arch/x86/include/asm/atomic64_64.h |    8 ++--
 arch/x86/include/asm/bitops.h      |    9 +----
 arch/x86/include/asm/local.h       |    8 ++--
 arch/x86/include/asm/preempt.h     |    2 -
 arch/x86/include/asm/refcount.h    |   18 +++++-----
 arch/x86/include/asm/rmwcc.h       |   66 +++++++++++++++++++++----------------
 7 files changed, 64 insertions(+), 55 deletions(-)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -82,7 +82,7 @@ static __always_inline void arch_atomic_
  */
 static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX "subl", v->counter, "er", i, "%0", e);
+	return GEN_BINARY_RMWcc(LOCK_PREFIX "subl", v->counter, e, "er", i);
 }
 #define arch_atomic_sub_and_test arch_atomic_sub_and_test
 
@@ -122,7 +122,7 @@ static __always_inline void arch_atomic_
  */
 static __always_inline bool arch_atomic_dec_and_test(atomic_t *v)
 {
-	GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, "%0", e);
+	return GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, e);
 }
 #define arch_atomic_dec_and_test arch_atomic_dec_and_test
 
@@ -136,7 +136,7 @@ static __always_inline bool arch_atomic_
  */
 static __always_inline bool arch_atomic_inc_and_test(atomic_t *v)
 {
-	GEN_UNARY_RMWcc(LOCK_PREFIX "incl", v->counter, "%0", e);
+	return GEN_UNARY_RMWcc(LOCK_PREFIX "incl", v->counter, e);
 }
 #define arch_atomic_inc_and_test arch_atomic_inc_and_test
 
@@ -151,7 +151,7 @@ static __always_inline bool arch_atomic_
  */
 static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX "addl", v->counter, "er", i, "%0", s);
+	return GEN_BINARY_RMWcc(LOCK_PREFIX "addl", v->counter, s, "er", i);
 }
 #define arch_atomic_add_negative arch_atomic_add_negative
 
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -73,7 +73,7 @@ static inline void arch_atomic64_sub(lon
  */
 static inline bool arch_atomic64_sub_and_test(long i, atomic64_t *v)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX "subq", v->counter, "er", i, "%0", e);
+	return GEN_BINARY_RMWcc(LOCK_PREFIX "subq", v->counter, e, "er", i);
 }
 #define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
 
@@ -115,7 +115,7 @@ static __always_inline void arch_atomic6
  */
 static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
 {
-	GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, "%0", e);
+	return GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, e);
 }
 #define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
 
@@ -129,7 +129,7 @@ static inline bool arch_atomic64_dec_and
  */
 static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
 {
-	GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, "%0", e);
+	return GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, e);
 }
 #define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
 
@@ -144,7 +144,7 @@ static inline bool arch_atomic64_inc_and
  */
 static inline bool arch_atomic64_add_negative(long i, atomic64_t *v)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, "er", i, "%0", s);
+	return GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, s, "er", i);
 }
 #define arch_atomic64_add_negative arch_atomic64_add_negative
 
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -217,8 +217,7 @@ static __always_inline void change_bit(l
  */
 static __always_inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts),
-	                 *addr, "Ir", nr, "%0", c);
+	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts), *addr, c, "Ir", nr);
 }
 
 /**
@@ -264,8 +263,7 @@ static __always_inline bool __test_and_s
  */
 static __always_inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btr),
-	                 *addr, "Ir", nr, "%0", c);
+	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btr), *addr, c, "Ir", nr);
 }
 
 /**
@@ -318,8 +316,7 @@ static __always_inline bool __test_and_c
  */
 static __always_inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc),
-	                 *addr, "Ir", nr, "%0", c);
+	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
 static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -53,7 +53,7 @@ static inline void local_sub(long i, loc
  */
 static inline bool local_sub_and_test(long i, local_t *l)
 {
-	GEN_BINARY_RMWcc(_ASM_SUB, l->a.counter, "er", i, "%0", e);
+	return GEN_BINARY_RMWcc(_ASM_SUB, l->a.counter, e, "er", i);
 }
 
 /**
@@ -66,7 +66,7 @@ static inline bool local_sub_and_test(lo
  */
 static inline bool local_dec_and_test(local_t *l)
 {
-	GEN_UNARY_RMWcc(_ASM_DEC, l->a.counter, "%0", e);
+	return GEN_UNARY_RMWcc(_ASM_DEC, l->a.counter, e);
 }
 
 /**
@@ -79,7 +79,7 @@ static inline bool local_dec_and_test(lo
  */
 static inline bool local_inc_and_test(local_t *l)
 {
-	GEN_UNARY_RMWcc(_ASM_INC, l->a.counter, "%0", e);
+	return GEN_UNARY_RMWcc(_ASM_INC, l->a.counter, e);
 }
 
 /**
@@ -93,7 +93,7 @@ static inline bool local_inc_and_test(lo
  */
 static inline bool local_add_negative(long i, local_t *l)
 {
-	GEN_BINARY_RMWcc(_ASM_ADD, l->a.counter, "er", i, "%0", s);
+	return GEN_BINARY_RMWcc(_ASM_ADD, l->a.counter, s, "er", i);
 }
 
 /**
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -88,7 +88,7 @@ static __always_inline void __preempt_co
  */
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
-	GEN_UNARY_RMWcc("decl", __preempt_count, __percpu_arg(0), e);
+	return GEN_UNARY_RMWcc("decl", __preempt_count, e, __percpu_arg([var]));
 }
 
 /*
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -17,7 +17,7 @@
  */
 #define _REFCOUNT_EXCEPTION				\
 	".pushsection .text..refcount\n"		\
-	"111:\tlea %[counter], %%" _ASM_CX "\n"		\
+	"111:\tlea %[var], %%" _ASM_CX "\n"		\
 	"112:\t" ASM_UD2 "\n"				\
 	ASM_UNREACHABLE					\
 	".popsection\n"					\
@@ -43,7 +43,7 @@ static __always_inline void refcount_add
 {
 	asm volatile(LOCK_PREFIX "addl %1,%0\n\t"
 		REFCOUNT_CHECK_LT_ZERO
-		: [counter] "+m" (r->refs.counter)
+		: [var] "+m" (r->refs.counter)
 		: "ir" (i)
 		: "cc", "cx");
 }
@@ -52,7 +52,7 @@ static __always_inline void refcount_inc
 {
 	asm volatile(LOCK_PREFIX "incl %0\n\t"
 		REFCOUNT_CHECK_LT_ZERO
-		: [counter] "+m" (r->refs.counter)
+		: [var] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
 
@@ -60,21 +60,21 @@ static __always_inline void refcount_dec
 {
 	asm volatile(LOCK_PREFIX "decl %0\n\t"
 		REFCOUNT_CHECK_LE_ZERO
-		: [counter] "+m" (r->refs.counter)
+		: [var] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
 
 static __always_inline __must_check
 bool refcount_sub_and_test(unsigned int i, refcount_t *r)
 {
-	GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl", REFCOUNT_CHECK_LT_ZERO,
-				  r->refs.counter, "er", i, "%0", e, "cx");
+	return GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
+		REFCOUNT_CHECK_LT_ZERO, r->refs.counter, e, "er", i, "cx");
 }
 
 static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
-	GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl", REFCOUNT_CHECK_LT_ZERO,
-				 r->refs.counter, "%0", e, "cx");
+	return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
+		REFCOUNT_CHECK_LT_ZERO, r->refs.counter, e, "cx");
 }
 
 static __always_inline __must_check
@@ -92,7 +92,7 @@ bool refcount_add_not_zero(unsigned int
 		/* Did we try to increment from/to an undesirable state? */
 		if (unlikely(c < 0 || c == INT_MAX || result < c)) {
 			asm volatile(REFCOUNT_ERROR
-				     : : [counter] "m" (r->refs.counter)
+				     : : [var] "m" (r->refs.counter)
 				     : "cc", "cx");
 			break;
 		}
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -2,56 +2,68 @@
 #ifndef _ASM_X86_RMWcc
 #define _ASM_X86_RMWcc
 
+/* This counts to 12. Any more, it will return 13th argument. */
+#define __RMWcc_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
+#define RMWcc_ARGS(X...) __RMWcc_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+
+#define __RMWcc_CONCAT(a, b) a ## b
+#define RMWcc_CONCAT(a, b) __RMWcc_CONCAT(a, b)
+
 #define __CLOBBERS_MEM(clb...)	"memory", ## clb
 
 #if !defined(__GCC_ASM_FLAG_OUTPUTS__) && defined(CC_HAVE_ASM_GOTO)
 
 /* Use asm goto */
 
-#define __GEN_RMWcc(fullop, var, cc, clobbers, ...)			\
-do {									\
+#define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
+({									\
+	__label__ cc_label;						\
 	asm_volatile_goto (fullop "; j" #cc " %l[cc_label]"		\
-			: : [counter] "m" (var), ## __VA_ARGS__		\
+			: : [var] "m" (_var), ## __VA_ARGS__		\
 			: clobbers : cc_label);				\
-	return 0;							\
+	0;								\
 cc_label:								\
-	return 1;							\
-} while (0)
-
-#define __BINARY_RMWcc_ARG	" %1, "
-
+	1;								\
+})
 
 #else /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CC_HAVE_ASM_GOTO) */
 
 /* Use flags output or a set instruction */
 
-#define __GEN_RMWcc(fullop, var, cc, clobbers, ...)			\
-do {									\
+#define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
+({									\
 	bool c;								\
 	asm volatile (fullop CC_SET(cc)					\
-			: [counter] "+m" (var), CC_OUT(cc) (c)		\
+			: [var] "+m" (_var), CC_OUT(cc) (c)		\
 			: __VA_ARGS__ : clobbers);			\
-	return c;							\
-} while (0)
-
-#define __BINARY_RMWcc_ARG	" %2, "
+	c;								\
+})
 
 #endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CC_HAVE_ASM_GOTO) */
 
-#define GEN_UNARY_RMWcc(op, var, arg0, cc)				\
+#define GEN_UNARY_RMWcc_4(op, var, cc, arg0)				\
 	__GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM())
 
-#define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, arg0, cc, clobbers...)\
-	__GEN_RMWcc(op " " arg0 "\n\t" suffix, var, cc,			\
+#define GEN_UNARY_RMWcc_3(op, var, cc)					\
+	GEN_UNARY_RMWcc_4(op, var, cc, "%[var]")
+
+#define GEN_UNARY_RMWcc(X...) RMWcc_CONCAT(GEN_UNARY_RMWcc_, RMWcc_ARGS(X))(X)
+
+#define GEN_BINARY_RMWcc_6(op, var, cc, vcon, _val, arg0)		\
+	__GEN_RMWcc(op " %[val], " arg0, var, cc,			\
+		    __CLOBBERS_MEM(), [val] vcon (_val))
+
+#define GEN_BINARY_RMWcc_5(op, var, cc, vcon, val)			\
+	GEN_BINARY_RMWcc_6(op, var, cc, vcon, val, "%[var]")
+
+#define GEN_BINARY_RMWcc(X...) RMWcc_CONCAT(GEN_BINARY_RMWcc_, RMWcc_ARGS(X))(X)
+
+#define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, cc, clobbers...)	\
+	__GEN_RMWcc(op " %[var]\n\t" suffix, var, cc,			\
 		    __CLOBBERS_MEM(clobbers))
 
-#define GEN_BINARY_RMWcc(op, var, vcon, val, arg0, cc)			\
-	__GEN_RMWcc(op __BINARY_RMWcc_ARG arg0, var, cc,		\
-		    __CLOBBERS_MEM(), vcon (val))
-
-#define GEN_BINARY_SUFFIXED_RMWcc(op, suffix, var, vcon, val, arg0, cc,	\
-				  clobbers...)				\
-	__GEN_RMWcc(op __BINARY_RMWcc_ARG arg0 "\n\t" suffix, var, cc,	\
-		    __CLOBBERS_MEM(clobbers), vcon (val))
+#define GEN_BINARY_SUFFIXED_RMWcc(op, suffix, var, cc, vcon, _val, clobbers...)\
+	__GEN_RMWcc(op " %[val], %[var]\n\t" suffix, var, cc,		\
+		    __CLOBBERS_MEM(clobbers), [val] vcon (_val))
 
 #endif /* _ASM_X86_RMWcc */


