Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16726C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8BC208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8BC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933645AbeFUMQx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:16:53 -0400
Received: from foss.arm.com ([217.140.101.70]:49278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933522AbeFUMNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:13:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9F7D15BF;
        Thu, 21 Jun 2018 05:13:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85D6D3F578;
        Thu, 21 Jun 2018 05:13:38 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCHv4 04/18] atomics: make conditional ops return bool
Date:   Thu, 21 Jun 2018 13:13:07 +0100
Message-Id: <20180621121321.4761-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180621121321.4761-1-mark.rutland@arm.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the atomics return a status value, which is a boolean value
describing whether the operation was performed. To make it clear that
this is a boolean value, let's update the common fallbacks to return
bool, fixing up the return values and comments likewise.

At the same time, let's simplify the description of the operations in
their respective comments.

The instrumented atomics and generic atomic64 implementation are updated
accordingly.

Note that atomic64_dec_if_positive() doesn't follow the usual test op
pattern, and returns the would-be decremented value. This is not
changed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/asm-generic/atomic-instrumented.h |  2 +-
 include/asm-generic/atomic64.h            |  3 ++-
 include/linux/atomic.h                    | 24 +++++++++++++-----------
 lib/atomic64.c                            |  6 +++---
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index b8b14cc2df6c..497faa4a05e3 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -205,7 +205,7 @@ static __always_inline s64 atomic64_dec_return(atomic64_t *v)
 	return arch_atomic64_dec_return(v);
 }
 
-static __always_inline s64 atomic64_inc_not_zero(atomic64_t *v)
+static __always_inline bool atomic64_inc_not_zero(atomic64_t *v)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_not_zero(v);
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 8d28eb010d0d..a951a721e1bb 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -11,6 +11,7 @@
  */
 #ifndef _ASM_GENERIC_ATOMIC64_H
 #define _ASM_GENERIC_ATOMIC64_H
+#include <linux/types.h>
 
 typedef struct {
 	long long counter;
@@ -52,7 +53,7 @@ ATOMIC64_OPS(xor)
 extern long long atomic64_dec_if_positive(atomic64_t *v);
 extern long long atomic64_cmpxchg(atomic64_t *v, long long o, long long n);
 extern long long atomic64_xchg(atomic64_t *v, long long new);
-extern int	 atomic64_add_unless(atomic64_t *v, long long a, long long u);
+extern bool	 atomic64_add_unless(atomic64_t *v, long long a, long long u);
 
 #define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 5c5620ae5a35..307a7f6d619a 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -2,6 +2,8 @@
 /* Atomic operations usable in machine independent code */
 #ifndef _LINUX_ATOMIC_H
 #define _LINUX_ATOMIC_H
+#include <linux/types.h>
+
 #include <asm/atomic.h>
 #include <asm/barrier.h>
 
@@ -525,10 +527,10 @@
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
  *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns non-zero if @v was not @u, and zero otherwise.
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns true if the addition was done.
  */
-static inline int atomic_add_unless(atomic_t *v, int a, int u)
+static inline bool atomic_add_unless(atomic_t *v, int a, int u)
 {
 	return atomic_fetch_add_unless(v, a, u) != u;
 }
@@ -537,8 +539,8 @@ static inline int atomic_add_unless(atomic_t *v, int a, int u)
  * atomic_inc_not_zero - increment unless the number is zero
  * @v: pointer of type atomic_t
  *
- * Atomically increments @v by 1, so long as @v is non-zero.
- * Returns non-zero if @v was non-zero, and zero otherwise.
+ * Atomically increments @v by 1, if @v is non-zero.
+ * Returns true if the increment was done.
  */
 #ifndef atomic_inc_not_zero
 #define atomic_inc_not_zero(v)		atomic_add_unless((v), 1, 0)
@@ -572,28 +574,28 @@ static inline int atomic_fetch_andnot_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_inc_unless_negative
-static inline int atomic_inc_unless_negative(atomic_t *p)
+static inline bool atomic_inc_unless_negative(atomic_t *p)
 {
 	int v, v1;
 	for (v = 0; v >= 0; v = v1) {
 		v1 = atomic_cmpxchg(p, v, v + 1);
 		if (likely(v1 == v))
-			return 1;
+			return true;
 	}
-	return 0;
+	return false;
 }
 #endif
 
 #ifndef atomic_dec_unless_positive
-static inline int atomic_dec_unless_positive(atomic_t *p)
+static inline bool atomic_dec_unless_positive(atomic_t *p)
 {
 	int v, v1;
 	for (v = 0; v <= 0; v = v1) {
 		v1 = atomic_cmpxchg(p, v, v - 1);
 		if (likely(v1 == v))
-			return 1;
+			return true;
 	}
-	return 0;
+	return false;
 }
 #endif
 
diff --git a/lib/atomic64.c b/lib/atomic64.c
index 53c2d5edc826..4230f4b8906c 100644
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -178,16 +178,16 @@ long long atomic64_xchg(atomic64_t *v, long long new)
 }
 EXPORT_SYMBOL(atomic64_xchg);
 
-int atomic64_add_unless(atomic64_t *v, long long a, long long u)
+bool atomic64_add_unless(atomic64_t *v, long long a, long long u)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
-	int ret = 0;
+	bool ret = false;
 
 	raw_spin_lock_irqsave(lock, flags);
 	if (v->counter != u) {
 		v->counter += a;
-		ret = 1;
+		ret = true;
 	}
 	raw_spin_unlock_irqrestore(lock, flags);
 	return ret;
-- 
2.11.0

