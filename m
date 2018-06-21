Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DF1C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C90B208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C90B208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbeFUMNo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:13:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49286 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933537AbeFUMNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:13:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B97991650;
        Thu, 21 Jun 2018 05:13:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88D6D3F578;
        Thu, 21 Jun 2018 05:13:40 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCHv4 05/18] atomics/treewide: make atomic64_inc_not_zero() optional
Date:   Thu, 21 Jun 2018 13:13:08 +0100
Message-Id: <20180621121321.4761-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180621121321.4761-1-mark.rutland@arm.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We define a trivial fallback for atomic_inc_not_zero(), but don't do
the same for atomic64_inc_not_zero(), leading most architectures to
define the same boilerplate.

Let's add a fallback in <linux/atomic.h>, and remove the redundant
implementations. Note that atomic64_add_unless() is always defined in
<linux/atomic.h>, and promotes its arguments to the requisite types, so
we need not do this explicitly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 arch/alpha/include/asm/atomic.h           |  2 --
 arch/arc/include/asm/atomic.h             |  1 -
 arch/arm/include/asm/atomic.h             |  1 -
 arch/arm64/include/asm/atomic.h           |  2 --
 arch/ia64/include/asm/atomic.h            |  2 --
 arch/mips/include/asm/atomic.h            |  2 --
 arch/parisc/include/asm/atomic.h          |  2 --
 arch/powerpc/include/asm/atomic.h         |  1 +
 arch/riscv/include/asm/atomic.h           |  7 -------
 arch/s390/include/asm/atomic.h            |  1 -
 arch/sparc/include/asm/atomic_64.h        |  2 --
 arch/x86/include/asm/atomic64_32.h        |  2 +-
 arch/x86/include/asm/atomic64_64.h        |  2 --
 include/asm-generic/atomic-instrumented.h |  3 +++
 include/asm-generic/atomic64.h            |  1 -
 include/linux/atomic.h                    | 11 +++++++++++
 16 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 392b15a4dd4f..eb0f25e4c5dd 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -296,8 +296,6 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 	return old - 1;
 }
 
-#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
-
 #define atomic_add_negative(a, v) (atomic_add_return((a), (v)) < 0)
 #define atomic64_add_negative(a, v) (atomic64_add_return((a), (v)) < 0)
 
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index cecdf3403caf..1406825b5e7d 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -603,7 +603,6 @@ static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
 #define atomic64_dec(v)			atomic64_sub(1LL, (v))
 #define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
 #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
-#define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1LL, 0LL)
 
 #endif	/* !CONFIG_GENERIC_ATOMIC64 */
 
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 9d56d0727c9b..02f3894faa48 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -534,7 +534,6 @@ static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
 #define atomic64_dec(v)			atomic64_sub(1LL, (v))
 #define atomic64_dec_return_relaxed(v)	atomic64_sub_return_relaxed(1LL, (v))
 #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
-#define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1LL, 0LL)
 
 #endif /* !CONFIG_GENERIC_ATOMIC64 */
 #endif
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 264d20339f74..ad50412889c5 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -204,7 +204,5 @@
 #define atomic64_add_unless(v, a, u)	(___atomic_add_unless(v, a, u, 64) != u)
 #define atomic64_andnot			atomic64_andnot
 
-#define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1, 0)
-
 #endif
 #endif
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index 9d2ddde5f9d5..93d48b823220 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -246,8 +246,6 @@ static __inline__ long atomic64_add_unless(atomic64_t *v, long a, long u)
 	return c != (u);
 }
 
-#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
-
 static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 {
 	long c, old, dec;
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 02fc1553cf9b..502e691c6393 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -644,8 +644,6 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 	return c != (u);
 }
 
-#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
-
 #define atomic64_dec_return(v) atomic64_sub_return(1, (v))
 #define atomic64_inc_return(v) atomic64_add_return(1, (v))
 
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index 7748abced766..3fd0243bf405 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -305,8 +305,6 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 	return c != (u);
 }
 
-#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
-
 /*
  * atomic64_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic_t
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 1483261080a1..e59620ee4f6b 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -582,6 +582,7 @@ static __inline__ int atomic64_inc_not_zero(atomic64_t *v)
 
 	return t1 != 0;
 }
+#define atomic64_inc_not_zero(v) atomic64_inc_not_zero((v))
 
 #endif /* __powerpc64__ */
 
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 0e27e050ba14..18259e90f57e 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -375,13 +375,6 @@ static __always_inline int atomic64_add_unless(atomic64_t *v, long a, long u)
 }
 #endif
 
-#ifndef CONFIG_GENERIC_ATOMIC64
-static __always_inline long atomic64_inc_not_zero(atomic64_t *v)
-{
-        return atomic64_add_unless(v, 1, 0);
-}
-#endif
-
 /*
  * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
  * {cmp,}xchg and the operations that return, so they need a full barrier.
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index c2858cdd8c29..66dac30a4fe1 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -212,6 +212,5 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 #define atomic64_dec(_v)		atomic64_sub(1, _v)
 #define atomic64_dec_return(_v)		atomic64_sub_return(1, _v)
 #define atomic64_dec_and_test(_v)	(atomic64_sub_return(1, _v) == 0)
-#define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1, 0)
 
 #endif /* __ARCH_S390_ATOMIC__  */
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index f416fd3d2708..07830a316464 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -123,8 +123,6 @@ static inline long atomic64_add_unless(atomic64_t *v, long a, long u)
 	return c != (u);
 }
 
-#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
-
 long atomic64_dec_if_positive(atomic64_t *v);
 
 #endif /* !(__ARCH_SPARC64_ATOMIC__) */
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 92212bf0484f..2a33cc17801b 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -295,7 +295,7 @@ static inline int arch_atomic64_add_unless(atomic64_t *v, long long a,
 	return (int)a;
 }
 
-
+#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
 static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
 	int r;
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 6106b59d3260..6f95023894b7 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -207,8 +207,6 @@ static inline bool arch_atomic64_add_unless(atomic64_t *v, long a, long u)
 	return true;
 }
 
-#define arch_atomic64_inc_not_zero(v) arch_atomic64_add_unless((v), 1, 0)
-
 /*
  * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic_t
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 497faa4a05e3..83bb88d791c4 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -205,11 +205,14 @@ static __always_inline s64 atomic64_dec_return(atomic64_t *v)
 	return arch_atomic64_dec_return(v);
 }
 
+#ifdef arch_atomic64_inc_not_zero
+#define atomic64_inc_not_zero atomic64_inc_not_zero
 static __always_inline bool atomic64_inc_not_zero(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_not_zero(v);
 }
+#endif
 
 static __always_inline s64 atomic64_dec_if_positive(atomic64_t *v)
 {
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index a951a721e1bb..5105275ac825 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -63,6 +63,5 @@ extern bool	 atomic64_add_unless(atomic64_t *v, long long a, long long u);
 #define atomic64_dec(v)			atomic64_sub(1LL, (v))
 #define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
 #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
-#define atomic64_inc_not_zero(v) 	atomic64_add_unless((v), 1LL, 0LL)
 
 #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 307a7f6d619a..ae3f30923d05 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -1019,6 +1019,17 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 #define atomic64_try_cmpxchg_release	atomic64_try_cmpxchg
 #endif /* atomic64_try_cmpxchg */
 
+/**
+ * atomic64_inc_not_zero - increment unless the number is zero
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increments @v by 1, if @v is non-zero.
+ * Returns true if the increment was done.
+ */
+#ifndef atomic64_inc_not_zero
+#define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1, 0)
+#endif
+
 #ifndef atomic64_andnot
 static inline void atomic64_andnot(long long i, atomic64_t *v)
 {
-- 
2.11.0

