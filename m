Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B45C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE2B257C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE2B257C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932758AbeFYLAi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:00:38 -0400
Received: from foss.arm.com ([217.140.101.70]:54654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932340AbeFYLAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:00:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D6B922C7;
        Mon, 25 Jun 2018 04:00:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0B8C3F73D;
        Mon, 25 Jun 2018 04:00:21 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCHv2 11/11] arm64: use instrumented atomics
Date:   Mon, 25 Jun 2018 11:59:52 +0100
Message-Id: <20180625105952.3756-12-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180625105952.3756-1-mark.rutland@arm.com>
References: <20180625105952.3756-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the generic atomic headers provide instrumented wrappers of all
the atomics implemented by arm64, let's migrate arm64 over to these.

The additional instrumentation will help to find bugs (e.g. when fuzzing
with Syzkaller).

Mostly this change involes adding an arch_ prefix to a number of
function names and macro definitions. Due to the way we call the LL/SC
atomics via the LSE atomic wrappers, this requires adding an arch_
prefix to some arm64-specific atomic primitives.

Some unusual whitespace in the cmpxchg wrappers is fixed up as part of
the change.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic.h      | 237 ++++++++++++++++++-----------------
 arch/arm64/include/asm/atomic_lse.h  |  51 ++++----
 arch/arm64/include/asm/cmpxchg.h     | 106 ++++++++--------
 arch/arm64/include/asm/lse.h         |   2 +-
 arch/arm64/include/asm/sync_bitops.h |  16 +--
 5 files changed, 212 insertions(+), 200 deletions(-)

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 9bca54dda75c..1f4e9ee641c9 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -42,124 +42,131 @@
 
 #define ATOMIC_INIT(i)	{ (i) }
 
-#define atomic_read(v)			READ_ONCE((v)->counter)
-#define atomic_set(v, i)		WRITE_ONCE(((v)->counter), (i))
-
-#define atomic_add_return_relaxed	atomic_add_return_relaxed
-#define atomic_add_return_acquire	atomic_add_return_acquire
-#define atomic_add_return_release	atomic_add_return_release
-#define atomic_add_return		atomic_add_return
-
-#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
-#define atomic_sub_return_acquire	atomic_sub_return_acquire
-#define atomic_sub_return_release	atomic_sub_return_release
-#define atomic_sub_return		atomic_sub_return
-
-#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
-#define atomic_fetch_add_acquire	atomic_fetch_add_acquire
-#define atomic_fetch_add_release	atomic_fetch_add_release
-#define atomic_fetch_add		atomic_fetch_add
-
-#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
-#define atomic_fetch_sub_acquire	atomic_fetch_sub_acquire
-#define atomic_fetch_sub_release	atomic_fetch_sub_release
-#define atomic_fetch_sub		atomic_fetch_sub
-
-#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
-#define atomic_fetch_and_acquire	atomic_fetch_and_acquire
-#define atomic_fetch_and_release	atomic_fetch_and_release
-#define atomic_fetch_and		atomic_fetch_and
-
-#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot_relaxed
-#define atomic_fetch_andnot_acquire	atomic_fetch_andnot_acquire
-#define atomic_fetch_andnot_release	atomic_fetch_andnot_release
-#define atomic_fetch_andnot		atomic_fetch_andnot
-
-#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
-#define atomic_fetch_or_acquire		atomic_fetch_or_acquire
-#define atomic_fetch_or_release		atomic_fetch_or_release
-#define atomic_fetch_or			atomic_fetch_or
-
-#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
-#define atomic_fetch_xor_acquire	atomic_fetch_xor_acquire
-#define atomic_fetch_xor_release	atomic_fetch_xor_release
-#define atomic_fetch_xor		atomic_fetch_xor
-
-#define atomic_xchg_relaxed(v, new)	xchg_relaxed(&((v)->counter), (new))
-#define atomic_xchg_acquire(v, new)	xchg_acquire(&((v)->counter), (new))
-#define atomic_xchg_release(v, new)	xchg_release(&((v)->counter), (new))
-#define atomic_xchg(v, new)		xchg(&((v)->counter), (new))
-
-#define atomic_cmpxchg_relaxed(v, old, new)				\
-	cmpxchg_relaxed(&((v)->counter), (old), (new))
-#define atomic_cmpxchg_acquire(v, old, new)				\
-	cmpxchg_acquire(&((v)->counter), (old), (new))
-#define atomic_cmpxchg_release(v, old, new)				\
-	cmpxchg_release(&((v)->counter), (old), (new))
-#define atomic_cmpxchg(v, old, new)	cmpxchg(&((v)->counter), (old), (new))
-
-#define atomic_andnot			atomic_andnot
+#define arch_atomic_read(v)			READ_ONCE((v)->counter)
+#define arch_atomic_set(v, i)			WRITE_ONCE(((v)->counter), (i))
+
+#define arch_atomic_add_return_relaxed		arch_atomic_add_return_relaxed
+#define arch_atomic_add_return_acquire		arch_atomic_add_return_acquire
+#define arch_atomic_add_return_release		arch_atomic_add_return_release
+#define arch_atomic_add_return			arch_atomic_add_return
+
+#define arch_atomic_sub_return_relaxed		arch_atomic_sub_return_relaxed
+#define arch_atomic_sub_return_acquire		arch_atomic_sub_return_acquire
+#define arch_atomic_sub_return_release		arch_atomic_sub_return_release
+#define arch_atomic_sub_return			arch_atomic_sub_return
+
+#define arch_atomic_fetch_add_relaxed		arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_add_acquire		arch_atomic_fetch_add_acquire
+#define arch_atomic_fetch_add_release		arch_atomic_fetch_add_release
+#define arch_atomic_fetch_add			arch_atomic_fetch_add
+
+#define arch_atomic_fetch_sub_relaxed		arch_atomic_fetch_sub_relaxed
+#define arch_atomic_fetch_sub_acquire		arch_atomic_fetch_sub_acquire
+#define arch_atomic_fetch_sub_release		arch_atomic_fetch_sub_release
+#define arch_atomic_fetch_sub			arch_atomic_fetch_sub
+
+#define arch_atomic_fetch_and_relaxed		arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_and_acquire		arch_atomic_fetch_and_acquire
+#define arch_atomic_fetch_and_release		arch_atomic_fetch_and_release
+#define arch_atomic_fetch_and			arch_atomic_fetch_and
+
+#define arch_atomic_fetch_andnot_relaxed	arch_atomic_fetch_andnot_relaxed
+#define arch_atomic_fetch_andnot_acquire	arch_atomic_fetch_andnot_acquire
+#define arch_atomic_fetch_andnot_release	arch_atomic_fetch_andnot_release
+#define arch_atomic_fetch_andnot		arch_atomic_fetch_andnot
+
+#define arch_atomic_fetch_or_relaxed		arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_or_acquire		arch_atomic_fetch_or_acquire
+#define arch_atomic_fetch_or_release		arch_atomic_fetch_or_release
+#define arch_atomic_fetch_or			arch_atomic_fetch_or
+
+#define arch_atomic_fetch_xor_relaxed		arch_atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_xor_acquire		arch_atomic_fetch_xor_acquire
+#define arch_atomic_fetch_xor_release		arch_atomic_fetch_xor_release
+#define arch_atomic_fetch_xor			arch_atomic_fetch_xor
+
+#define arch_atomic_xchg_relaxed(v, new) \
+	arch_xchg_relaxed(&((v)->counter), (new))
+#define arch_atomic_xchg_acquire(v, new) \
+	arch_xchg_acquire(&((v)->counter), (new))
+#define arch_atomic_xchg_release(v, new) \
+	arch_xchg_release(&((v)->counter), (new))
+#define arch_atomic_xchg(v, new) \
+	arch_xchg(&((v)->counter), (new))
+
+#define arch_atomic_cmpxchg_relaxed(v, old, new) \
+	arch_cmpxchg_relaxed(&((v)->counter), (old), (new))
+#define arch_atomic_cmpxchg_acquire(v, old, new) \
+	arch_cmpxchg_acquire(&((v)->counter), (old), (new))
+#define arch_atomic_cmpxchg_release(v, old, new) \
+	arch_cmpxchg_release(&((v)->counter), (old), (new))
+#define arch_atomic_cmpxchg(v, old, new) \
+	arch_cmpxchg(&((v)->counter), (old), (new))
+
+#define arch_atomic_andnot			arch_atomic_andnot
 
 /*
- * 64-bit atomic operations.
+ * 64-bit arch_atomic operations.
  */
-#define ATOMIC64_INIT			ATOMIC_INIT
-#define atomic64_read			atomic_read
-#define atomic64_set			atomic_set
-
-#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
-#define atomic64_add_return_acquire	atomic64_add_return_acquire
-#define atomic64_add_return_release	atomic64_add_return_release
-#define atomic64_add_return		atomic64_add_return
-
-#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
-#define atomic64_sub_return_acquire	atomic64_sub_return_acquire
-#define atomic64_sub_return_release	atomic64_sub_return_release
-#define atomic64_sub_return		atomic64_sub_return
-
-#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
-#define atomic64_fetch_add_acquire	atomic64_fetch_add_acquire
-#define atomic64_fetch_add_release	atomic64_fetch_add_release
-#define atomic64_fetch_add		atomic64_fetch_add
-
-#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
-#define atomic64_fetch_sub_acquire	atomic64_fetch_sub_acquire
-#define atomic64_fetch_sub_release	atomic64_fetch_sub_release
-#define atomic64_fetch_sub		atomic64_fetch_sub
-
-#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
-#define atomic64_fetch_and_acquire	atomic64_fetch_and_acquire
-#define atomic64_fetch_and_release	atomic64_fetch_and_release
-#define atomic64_fetch_and		atomic64_fetch_and
-
-#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot_relaxed
-#define atomic64_fetch_andnot_acquire	atomic64_fetch_andnot_acquire
-#define atomic64_fetch_andnot_release	atomic64_fetch_andnot_release
-#define atomic64_fetch_andnot		atomic64_fetch_andnot
-
-#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
-#define atomic64_fetch_or_acquire	atomic64_fetch_or_acquire
-#define atomic64_fetch_or_release	atomic64_fetch_or_release
-#define atomic64_fetch_or		atomic64_fetch_or
-
-#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
-#define atomic64_fetch_xor_acquire	atomic64_fetch_xor_acquire
-#define atomic64_fetch_xor_release	atomic64_fetch_xor_release
-#define atomic64_fetch_xor		atomic64_fetch_xor
-
-#define atomic64_xchg_relaxed		atomic_xchg_relaxed
-#define atomic64_xchg_acquire		atomic_xchg_acquire
-#define atomic64_xchg_release		atomic_xchg_release
-#define atomic64_xchg			atomic_xchg
-
-#define atomic64_cmpxchg_relaxed	atomic_cmpxchg_relaxed
-#define atomic64_cmpxchg_acquire	atomic_cmpxchg_acquire
-#define atomic64_cmpxchg_release	atomic_cmpxchg_release
-#define atomic64_cmpxchg		atomic_cmpxchg
-
-#define atomic64_andnot			atomic64_andnot
-
-#define atomic64_dec_if_positive	atomic64_dec_if_positive
+#define ATOMIC64_INIT				ATOMIC_INIT
+#define arch_atomic64_read			arch_atomic_read
+#define arch_atomic64_set			arch_atomic_set
+
+#define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+#define arch_atomic64_add_return_acquire	arch_atomic64_add_return_acquire
+#define arch_atomic64_add_return_release	arch_atomic64_add_return_release
+#define arch_atomic64_add_return		arch_atomic64_add_return
+
+#define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+#define arch_atomic64_sub_return_acquire	arch_atomic64_sub_return_acquire
+#define arch_atomic64_sub_return_release	arch_atomic64_sub_return_release
+#define arch_atomic64_sub_return		arch_atomic64_sub_return
+
+#define arch_atomic64_fetch_add_relaxed		arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_add_acquire		arch_atomic64_fetch_add_acquire
+#define arch_atomic64_fetch_add_release		arch_atomic64_fetch_add_release
+#define arch_atomic64_fetch_add			arch_atomic64_fetch_add
+
+#define arch_atomic64_fetch_sub_relaxed		arch_atomic64_fetch_sub_relaxed
+#define arch_atomic64_fetch_sub_acquire		arch_atomic64_fetch_sub_acquire
+#define arch_atomic64_fetch_sub_release		arch_atomic64_fetch_sub_release
+#define arch_atomic64_fetch_sub			arch_atomic64_fetch_sub
+
+#define arch_atomic64_fetch_and_relaxed		arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_and_acquire		arch_atomic64_fetch_and_acquire
+#define arch_atomic64_fetch_and_release		arch_atomic64_fetch_and_release
+#define arch_atomic64_fetch_and			arch_atomic64_fetch_and
+
+#define arch_atomic64_fetch_andnot_relaxed	arch_atomic64_fetch_andnot_relaxed
+#define arch_atomic64_fetch_andnot_acquire	arch_atomic64_fetch_andnot_acquire
+#define arch_atomic64_fetch_andnot_release	arch_atomic64_fetch_andnot_release
+#define arch_atomic64_fetch_andnot		arch_atomic64_fetch_andnot
+
+#define arch_atomic64_fetch_or_relaxed		arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_or_acquire		arch_atomic64_fetch_or_acquire
+#define arch_atomic64_fetch_or_release		arch_atomic64_fetch_or_release
+#define arch_atomic64_fetch_or			arch_atomic64_fetch_or
+
+#define arch_atomic64_fetch_xor_relaxed		arch_atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_xor_acquire		arch_atomic64_fetch_xor_acquire
+#define arch_atomic64_fetch_xor_release		arch_atomic64_fetch_xor_release
+#define arch_atomic64_fetch_xor			arch_atomic64_fetch_xor
+
+#define arch_atomic64_xchg_relaxed		arch_atomic_xchg_relaxed
+#define arch_atomic64_xchg_acquire		arch_atomic_xchg_acquire
+#define arch_atomic64_xchg_release		arch_atomic_xchg_release
+#define arch_atomic64_xchg			arch_atomic_xchg
+
+#define arch_atomic64_cmpxchg_relaxed		arch_atomic_cmpxchg_relaxed
+#define arch_atomic64_cmpxchg_acquire		arch_atomic_cmpxchg_acquire
+#define arch_atomic64_cmpxchg_release		arch_atomic_cmpxchg_release
+#define arch_atomic64_cmpxchg			arch_atomic_cmpxchg
+
+#define arch_atomic64_andnot			arch_atomic64_andnot
+
+#define arch_atomic64_dec_if_positive		arch_atomic64_dec_if_positive
+
+#include <asm-generic/atomic-instrumented.h>
 
 #endif
 #endif
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index f9b0b09153e0..1c974568d963 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -27,7 +27,7 @@
 
 #define __LL_SC_ATOMIC(op)	__LL_SC_CALL(atomic_##op)
 #define ATOMIC_OP(op, asm_op)						\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	register int w0 asm ("w0") = i;					\
 	register atomic_t *x1 asm ("x1") = v;				\
@@ -47,7 +47,7 @@ ATOMIC_OP(add, stadd)
 #undef ATOMIC_OP
 
 #define ATOMIC_FETCH_OP(name, mb, op, asm_op, cl...)			\
-static inline int atomic_fetch_##op##name(int i, atomic_t *v)		\
+static inline int arch_atomic_fetch_##op##name(int i, atomic_t *v)	\
 {									\
 	register int w0 asm ("w0") = i;					\
 	register atomic_t *x1 asm ("x1") = v;				\
@@ -79,7 +79,7 @@ ATOMIC_FETCH_OPS(add, ldadd)
 #undef ATOMIC_FETCH_OPS
 
 #define ATOMIC_OP_ADD_RETURN(name, mb, cl...)				\
-static inline int atomic_add_return##name(int i, atomic_t *v)		\
+static inline int arch_atomic_add_return##name(int i, atomic_t *v)	\
 {									\
 	register int w0 asm ("w0") = i;					\
 	register atomic_t *x1 asm ("x1") = v;				\
@@ -105,7 +105,7 @@ ATOMIC_OP_ADD_RETURN(        , al, "memory")
 
 #undef ATOMIC_OP_ADD_RETURN
 
-static inline void atomic_and(int i, atomic_t *v)
+static inline void arch_atomic_and(int i, atomic_t *v)
 {
 	register int w0 asm ("w0") = i;
 	register atomic_t *x1 asm ("x1") = v;
@@ -123,7 +123,7 @@ static inline void atomic_and(int i, atomic_t *v)
 }
 
 #define ATOMIC_FETCH_OP_AND(name, mb, cl...)				\
-static inline int atomic_fetch_and##name(int i, atomic_t *v)		\
+static inline int arch_atomic_fetch_and##name(int i, atomic_t *v)	\
 {									\
 	register int w0 asm ("w0") = i;					\
 	register atomic_t *x1 asm ("x1") = v;				\
@@ -149,7 +149,7 @@ ATOMIC_FETCH_OP_AND(        , al, "memory")
 
 #undef ATOMIC_FETCH_OP_AND
 
-static inline void atomic_sub(int i, atomic_t *v)
+static inline void arch_atomic_sub(int i, atomic_t *v)
 {
 	register int w0 asm ("w0") = i;
 	register atomic_t *x1 asm ("x1") = v;
@@ -167,7 +167,7 @@ static inline void atomic_sub(int i, atomic_t *v)
 }
 
 #define ATOMIC_OP_SUB_RETURN(name, mb, cl...)				\
-static inline int atomic_sub_return##name(int i, atomic_t *v)		\
+static inline int arch_atomic_sub_return##name(int i, atomic_t *v)	\
 {									\
 	register int w0 asm ("w0") = i;					\
 	register atomic_t *x1 asm ("x1") = v;				\
@@ -195,7 +195,7 @@ ATOMIC_OP_SUB_RETURN(        , al, "memory")
 #undef ATOMIC_OP_SUB_RETURN
 
 #define ATOMIC_FETCH_OP_SUB(name, mb, cl...)				\
-static inline int atomic_fetch_sub##name(int i, atomic_t *v)		\
+static inline int arch_atomic_fetch_sub##name(int i, atomic_t *v)	\
 {									\
 	register int w0 asm ("w0") = i;					\
 	register atomic_t *x1 asm ("x1") = v;				\
@@ -224,7 +224,7 @@ ATOMIC_FETCH_OP_SUB(        , al, "memory")
 
 #define __LL_SC_ATOMIC64(op)	__LL_SC_CALL(atomic64_##op)
 #define ATOMIC64_OP(op, asm_op)						\
-static inline void atomic64_##op(long i, atomic64_t *v)			\
+static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
 {									\
 	register long x0 asm ("x0") = i;				\
 	register atomic64_t *x1 asm ("x1") = v;				\
@@ -244,7 +244,7 @@ ATOMIC64_OP(add, stadd)
 #undef ATOMIC64_OP
 
 #define ATOMIC64_FETCH_OP(name, mb, op, asm_op, cl...)			\
-static inline long atomic64_fetch_##op##name(long i, atomic64_t *v)	\
+static inline long arch_atomic64_fetch_##op##name(long i, atomic64_t *v)\
 {									\
 	register long x0 asm ("x0") = i;				\
 	register atomic64_t *x1 asm ("x1") = v;				\
@@ -276,7 +276,7 @@ ATOMIC64_FETCH_OPS(add, ldadd)
 #undef ATOMIC64_FETCH_OPS
 
 #define ATOMIC64_OP_ADD_RETURN(name, mb, cl...)				\
-static inline long atomic64_add_return##name(long i, atomic64_t *v)	\
+static inline long arch_atomic64_add_return##name(long i, atomic64_t *v)\
 {									\
 	register long x0 asm ("x0") = i;				\
 	register atomic64_t *x1 asm ("x1") = v;				\
@@ -302,7 +302,7 @@ ATOMIC64_OP_ADD_RETURN(        , al, "memory")
 
 #undef ATOMIC64_OP_ADD_RETURN
 
-static inline void atomic64_and(long i, atomic64_t *v)
+static inline void arch_atomic64_and(long i, atomic64_t *v)
 {
 	register long x0 asm ("x0") = i;
 	register atomic64_t *x1 asm ("x1") = v;
@@ -320,7 +320,7 @@ static inline void atomic64_and(long i, atomic64_t *v)
 }
 
 #define ATOMIC64_FETCH_OP_AND(name, mb, cl...)				\
-static inline long atomic64_fetch_and##name(long i, atomic64_t *v)	\
+static inline long arch_atomic64_fetch_and##name(long i, atomic64_t *v)	\
 {									\
 	register long x0 asm ("x0") = i;				\
 	register atomic64_t *x1 asm ("x1") = v;				\
@@ -346,7 +346,7 @@ ATOMIC64_FETCH_OP_AND(        , al, "memory")
 
 #undef ATOMIC64_FETCH_OP_AND
 
-static inline void atomic64_sub(long i, atomic64_t *v)
+static inline void arch_atomic64_sub(long i, atomic64_t *v)
 {
 	register long x0 asm ("x0") = i;
 	register atomic64_t *x1 asm ("x1") = v;
@@ -364,7 +364,7 @@ static inline void atomic64_sub(long i, atomic64_t *v)
 }
 
 #define ATOMIC64_OP_SUB_RETURN(name, mb, cl...)				\
-static inline long atomic64_sub_return##name(long i, atomic64_t *v)	\
+static inline long arch_atomic64_sub_return##name(long i, atomic64_t *v)\
 {									\
 	register long x0 asm ("x0") = i;				\
 	register atomic64_t *x1 asm ("x1") = v;				\
@@ -392,7 +392,7 @@ ATOMIC64_OP_SUB_RETURN(        , al, "memory")
 #undef ATOMIC64_OP_SUB_RETURN
 
 #define ATOMIC64_FETCH_OP_SUB(name, mb, cl...)				\
-static inline long atomic64_fetch_sub##name(long i, atomic64_t *v)	\
+static inline long arch_atomic64_fetch_sub##name(long i, atomic64_t *v)	\
 {									\
 	register long x0 asm ("x0") = i;				\
 	register atomic64_t *x1 asm ("x1") = v;				\
@@ -418,7 +418,7 @@ ATOMIC64_FETCH_OP_SUB(        , al, "memory")
 
 #undef ATOMIC64_FETCH_OP_SUB
 
-static inline long atomic64_dec_if_positive(atomic64_t *v)
+static inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	register long x0 asm ("x0") = (long)v;
 
@@ -447,9 +447,10 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 #define __LL_SC_CMPXCHG(op)	__LL_SC_CALL(__cmpxchg_case_##op)
 
 #define __CMPXCHG_CASE(w, sz, name, mb, cl...)				\
-static inline unsigned long __cmpxchg_case_##name(volatile void *ptr,	\
-						  unsigned long old,	\
-						  unsigned long new)	\
+static inline unsigned long						\
+arch___cmpxchg_case_##name(volatile void *ptr,				\
+			   unsigned long old,				\
+			   unsigned long new)				\
 {									\
 	register unsigned long x0 asm ("x0") = (unsigned long)ptr;	\
 	register unsigned long x1 asm ("x1") = old;			\
@@ -493,11 +494,11 @@ __CMPXCHG_CASE(x,  ,  mb_8, al, "memory")
 #define __LL_SC_CMPXCHG_DBL(op)	__LL_SC_CALL(__cmpxchg_double##op)
 
 #define __CMPXCHG_DBL(name, mb, cl...)					\
-static inline long __cmpxchg_double##name(unsigned long old1,		\
-					 unsigned long old2,		\
-					 unsigned long new1,		\
-					 unsigned long new2,		\
-					 volatile void *ptr)		\
+static inline long arch___cmpxchg_double##name(unsigned long old1,	\
+					       unsigned long old2,	\
+					       unsigned long new1,	\
+					       unsigned long new2,	\
+					       volatile void *ptr)	\
 {									\
 	unsigned long oldval1 = old1;					\
 	unsigned long oldval2 = old2;					\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 3b0938281541..5efb546f1a82 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -110,31 +110,31 @@ __XCHG_GEN(_mb)
 })
 
 /* xchg */
-#define xchg_relaxed(...)	__xchg_wrapper(    , __VA_ARGS__)
-#define xchg_acquire(...)	__xchg_wrapper(_acq, __VA_ARGS__)
-#define xchg_release(...)	__xchg_wrapper(_rel, __VA_ARGS__)
-#define xchg(...)		__xchg_wrapper( _mb, __VA_ARGS__)
-
-#define __CMPXCHG_GEN(sfx)						\
-static inline unsigned long __cmpxchg##sfx(volatile void *ptr,		\
-					   unsigned long old,		\
-					   unsigned long new,		\
-					   int size)			\
-{									\
-	switch (size) {							\
-	case 1:								\
-		return __cmpxchg_case##sfx##_1(ptr, (u8)old, new);	\
-	case 2:								\
-		return __cmpxchg_case##sfx##_2(ptr, (u16)old, new);	\
-	case 4:								\
-		return __cmpxchg_case##sfx##_4(ptr, old, new);		\
-	case 8:								\
-		return __cmpxchg_case##sfx##_8(ptr, old, new);		\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-									\
-	unreachable();							\
+#define arch_xchg_relaxed(...)	__xchg_wrapper(    , __VA_ARGS__)
+#define arch_xchg_acquire(...)	__xchg_wrapper(_acq, __VA_ARGS__)
+#define arch_xchg_release(...)	__xchg_wrapper(_rel, __VA_ARGS__)
+#define arch_xchg(...)		__xchg_wrapper( _mb, __VA_ARGS__)
+
+#define __CMPXCHG_GEN(sfx)							\
+static inline unsigned long __cmpxchg##sfx(volatile void *ptr,			\
+					   unsigned long old,			\
+					   unsigned long new,			\
+					   int size)				\
+{										\
+	switch (size) {								\
+	case 1:									\
+		return arch___cmpxchg_case##sfx##_1(ptr, (u8)old, new);		\
+	case 2:									\
+		return arch___cmpxchg_case##sfx##_2(ptr, (u16)old, new);	\
+	case 4:									\
+		return arch___cmpxchg_case##sfx##_4(ptr, old, new);		\
+	case 8:									\
+		return arch___cmpxchg_case##sfx##_8(ptr, old, new);		\
+	default:								\
+		BUILD_BUG();							\
+	}									\
+										\
+	unreachable();								\
 }
 
 __CMPXCHG_GEN()
@@ -154,18 +154,18 @@ __CMPXCHG_GEN(_mb)
 })
 
 /* cmpxchg */
-#define cmpxchg_relaxed(...)	__cmpxchg_wrapper(    , __VA_ARGS__)
-#define cmpxchg_acquire(...)	__cmpxchg_wrapper(_acq, __VA_ARGS__)
-#define cmpxchg_release(...)	__cmpxchg_wrapper(_rel, __VA_ARGS__)
-#define cmpxchg(...)		__cmpxchg_wrapper( _mb, __VA_ARGS__)
-#define cmpxchg_local		cmpxchg_relaxed
+#define arch_cmpxchg_relaxed(...)	__cmpxchg_wrapper(    , __VA_ARGS__)
+#define arch_cmpxchg_acquire(...)	__cmpxchg_wrapper(_acq, __VA_ARGS__)
+#define arch_cmpxchg_release(...)	__cmpxchg_wrapper(_rel, __VA_ARGS__)
+#define arch_cmpxchg(...)		__cmpxchg_wrapper( _mb, __VA_ARGS__)
+#define arch_cmpxchg_local		arch_cmpxchg_relaxed
 
 /* cmpxchg64 */
-#define cmpxchg64_relaxed	cmpxchg_relaxed
-#define cmpxchg64_acquire	cmpxchg_acquire
-#define cmpxchg64_release	cmpxchg_release
-#define cmpxchg64		cmpxchg
-#define cmpxchg64_local		cmpxchg_local
+#define arch_cmpxchg64_relaxed		arch_cmpxchg_relaxed
+#define arch_cmpxchg64_acquire		arch_cmpxchg_acquire
+#define arch_cmpxchg64_release		arch_cmpxchg_release
+#define arch_cmpxchg64			arch_cmpxchg
+#define arch_cmpxchg64_local		arch_cmpxchg_local
 
 /* cmpxchg_double */
 #define system_has_cmpxchg_double()     1
@@ -177,24 +177,28 @@ __CMPXCHG_GEN(_mb)
 	VM_BUG_ON((unsigned long *)(ptr2) - (unsigned long *)(ptr1) != 1);	\
 })
 
-#define cmpxchg_double(ptr1, ptr2, o1, o2, n1, n2) \
-({\
-	int __ret;\
-	__cmpxchg_double_check(ptr1, ptr2); \
-	__ret = !__cmpxchg_double_mb((unsigned long)(o1), (unsigned long)(o2), \
-				     (unsigned long)(n1), (unsigned long)(n2), \
-				     ptr1); \
-	__ret; \
+#define arch_cmpxchg_double(ptr1, ptr2, o1, o2, n1, n2)			\
+({									\
+	int __ret;							\
+	__cmpxchg_double_check(ptr1, ptr2);				\
+	__ret = !arch___cmpxchg_double_mb((unsigned long)(o1),		\
+					  (unsigned long)(o2),		\
+					  (unsigned long)(n1),		\
+					  (unsigned long)(n2),		\
+					  ptr1);			\
+	__ret;								\
 })
 
-#define cmpxchg_double_local(ptr1, ptr2, o1, o2, n1, n2) \
-({\
-	int __ret;\
-	__cmpxchg_double_check(ptr1, ptr2); \
-	__ret = !__cmpxchg_double((unsigned long)(o1), (unsigned long)(o2), \
-				  (unsigned long)(n1), (unsigned long)(n2), \
-				  ptr1); \
-	__ret; \
+#define arch_cmpxchg_double_local(ptr1, ptr2, o1, o2, n1, n2)		\
+({									\
+	int __ret;							\
+	__cmpxchg_double_check(ptr1, ptr2);				\
+	__ret = !arch___cmpxchg_double((unsigned long)(o1),		\
+				       (unsigned long)(o2),		\
+				       (unsigned long)(n1),		\
+				       (unsigned long)(n2),		\
+				       ptr1);				\
+	__ret;								\
 })
 
 #define __CMPWAIT_CASE(w, sz, name)					\
diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index 8262325e2fc6..70b7cd8b8d16 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -47,7 +47,7 @@ __asm__(".arch_extension	lse");
 #else	/* __ASSEMBLER__ */
 
 #define __LL_SC_INLINE		static inline
-#define __LL_SC_PREFIX(x)	x
+#define __LL_SC_PREFIX(x)	arch_##x
 #define __LL_SC_EXPORT(x)
 
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)	llsc
diff --git a/arch/arm64/include/asm/sync_bitops.h b/arch/arm64/include/asm/sync_bitops.h
index eee31a9f72a5..e9c1a02c2154 100644
--- a/arch/arm64/include/asm/sync_bitops.h
+++ b/arch/arm64/include/asm/sync_bitops.h
@@ -15,13 +15,13 @@
  * ops which are SMP safe even on a UP kernel.
  */
 
-#define sync_set_bit(nr, p)            set_bit(nr, p)
-#define sync_clear_bit(nr, p)          clear_bit(nr, p)
-#define sync_change_bit(nr, p)         change_bit(nr, p)
-#define sync_test_and_set_bit(nr, p)   test_and_set_bit(nr, p)
-#define sync_test_and_clear_bit(nr, p) test_and_clear_bit(nr, p)
-#define sync_test_and_change_bit(nr, p)        test_and_change_bit(nr, p)
-#define sync_test_bit(nr, addr)                test_bit(nr, addr)
-#define sync_cmpxchg                   cmpxchg
+#define sync_set_bit(nr, p)			set_bit(nr, p)
+#define sync_clear_bit(nr, p)			clear_bit(nr, p)
+#define sync_change_bit(nr, p)			change_bit(nr, p)
+#define sync_test_and_set_bit(nr, p)		test_and_set_bit(nr, p)
+#define sync_test_and_clear_bit(nr, p)		test_and_clear_bit(nr, p)
+#define sync_test_and_change_bit(nr, p)		test_and_change_bit(nr, p)
+#define sync_test_bit(nr, addr)			test_bit(nr, addr)
+#define arch_sync_cmpxchg			arch_cmpxchg
 
 #endif
-- 
2.11.0

