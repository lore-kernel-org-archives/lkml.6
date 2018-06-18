Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888D8C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD8E208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD8E208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937064AbeFRKUM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:20:12 -0400
Received: from foss.arm.com ([217.140.101.70]:59542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937028AbeFRKUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:20:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD2B215BE;
        Mon, 18 Jun 2018 03:20:09 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC3D93F25D;
        Mon, 18 Jun 2018 03:20:08 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com
Cc:     mingo@kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv3 18/18] atomics/treewide: clean up andnot ifdeffery
Date:   Mon, 18 Jun 2018 11:19:19 +0100
Message-Id: <20180618101919.51973-19-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180618101919.51973-1-mark.rutland@arm.com>
References: <20180618101919.51973-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ifdeffery for atomic*_{fetch_,}andnot() is unlike that for all the
other atomics. If atomic*_andnot() is not defined, the corresponding
atomic*_fetch_andnot() is assumed to not be defined.

Additionally, the fallbacks for the various ordering cases are written
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arc/include/asm/atomic.h |  8 ++--
 arch/arm/include/asm/atomic.h |  2 +
 include/linux/atomic.h        | 96 ++++++++++++++-----------------------------
 3 files changed, 36 insertions(+), 70 deletions(-)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 8f64f3b79b8a..4e0072730241 100644
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
index 93fe5b4041e1..8e04f1f69bd9 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -354,12 +354,22 @@
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
 
@@ -378,7 +388,6 @@
 	__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
 #endif
 #endif /* atomic_fetch_andnot_relaxed */
-#endif /* atomic_andnot */
 
 /* atomic_fetch_xor_relaxed */
 #ifndef atomic_fetch_xor_relaxed
@@ -655,33 +664,6 @@ static inline bool atomic_add_negative(int i, atomic_t *v)
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
@@ -1029,12 +1011,22 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 #endif
 #endif /* atomic64_fetch_and_relaxed */
 
-#ifdef atomic64_andnot
-/* atomic64_fetch_andnot_relaxed */
+#ifndef atomic64_andnot
+#define atomic64_andnot(i, v)		atomic64_and(~(long long)(i), (v))
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
 
@@ -1053,7 +1045,6 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 	__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
 #endif
 #endif /* atomic64_fetch_andnot_relaxed */
-#endif /* atomic64_andnot */
 
 /* atomic64_fetch_xor_relaxed */
 #ifndef atomic64_fetch_xor_relaxed
@@ -1262,33 +1253,6 @@ static inline bool atomic64_add_negative(long long i, atomic64_t *v)
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

