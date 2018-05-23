Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933170AbeEWNgb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:36:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55390 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933039AbeEWNgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:36:20 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 07/13] atomics/alpha: define atomic64_fetch_add_unless()
Date: Wed, 23 May 2018 14:35:27 +0100
Message-Id: <20180523133533.1076-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180523133533.1076-1-mark.rutland@arm.com>
References: <20180523133533.1076-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step towards unifying the atomic/atomic64/atomic_long APIs, this
patch converts the arch/alpha implementation of atomic64_add_unless() into
an implementation of atomic64_fetch_add_unless().

A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
this, provided it is given a preprocessor definition.

No functional change is intended as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/atomic.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 4a800a3424a3..dcb7bbeeae02 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -238,35 +238,36 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #define atomic_fetch_add_unless atomic_fetch_add_unless
 
 /**
- * atomic64_add_unless - add unless the number is a given value
+ * atomic64_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
  *
  * Atomically adds @a to @v, so long as it was not @u.
- * Returns true iff @v was not @u.
+ * Returns the old value of @v.
  */
-static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
+static __inline__ int atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
 {
-	long c, tmp;
+	long c, new, old;
 	smp_mb();
 	__asm__ __volatile__(
-	"1:	ldq_l	%[tmp],%[mem]\n"
-	"	cmpeq	%[tmp],%[u],%[c]\n"
-	"	addq	%[tmp],%[a],%[tmp]\n"
+	"1:	ldq_l	%[old],%[mem]\n"
+	"	cmpeq	%[old],%[u],%[c]\n"
+	"	addq	%[old],%[a],%[new]\n"
 	"	bne	%[c],2f\n"
-	"	stq_c	%[tmp],%[mem]\n"
-	"	beq	%[tmp],3f\n"
+	"	stq_c	%[new],%[mem]\n"
+	"	beq	%[new],3f\n"
 	"2:\n"
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
-	: [tmp] "=&r"(tmp), [c] "=&r"(c)
+	: [old] "=&r"(old), [new] "=&r"(new), [c] "=&r"(c)
 	: [mem] "m"(*v), [a] "rI"(a), [u] "rI"(u)
 	: "memory");
 	smp_mb();
-	return !c;
+	return old;
 }
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
 /*
  * atomic64_dec_if_positive - decrement by 1 if old value positive
-- 
2.11.0
