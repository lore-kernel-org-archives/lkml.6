Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933184AbeEWNge (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:36:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55410 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933050AbeEWNgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:36:24 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 09/13] atomics/arm: define atomic64_fetch_add_unless()
Date: Wed, 23 May 2018 14:35:29 +0100
Message-Id: <20180523133533.1076-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180523133533.1076-1-mark.rutland@arm.com>
References: <20180523133533.1076-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step towards unifying the atomic/atomic64/atomic_long APIs, this
patch converts the arch/arm implementation of atomic64_add_unless() into
an implementation of atomic64_fetch_add_unless().

A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
this, provided it is given a preprocessor definition.

No functional change is intended as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/include/asm/atomic.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 74460aa00fa0..852e1fee72b0 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -486,11 +486,11 @@ static inline long long atomic64_dec_if_positive(atomic64_t *v)
 	return result;
 }
 
-static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
+static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
+						  long long u)
 {
-	long long val;
+	long long oldval, newval;
 	unsigned long tmp;
-	int ret = 1;
 
 	smp_mb();
 	prefetchw(&v->counter);
@@ -499,23 +499,23 @@ static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
 "1:	ldrexd	%0, %H0, [%4]\n"
 "	teq	%0, %5\n"
 "	teqeq	%H0, %H5\n"
-"	moveq	%1, #0\n"
 "	beq	2f\n"
-"	adds	%Q0, %Q0, %Q6\n"
-"	adc	%R0, %R0, %R6\n"
-"	strexd	%2, %0, %H0, [%4]\n"
+"	adds	%Q1, %Q0, %Q6\n"
+"	adc	%R1, %R0, %R6\n"
+"	strexd	%2, %1, %H1, [%4]\n"
 "	teq	%2, #0\n"
 "	bne	1b\n"
 "2:"
-	: "=&r" (val), "+r" (ret), "=&r" (tmp), "+Qo" (v->counter)
+	: "=&r" (oldval), "=&r" (newval), "=&r" (tmp), "+Qo" (v->counter)
 	: "r" (&v->counter), "r" (u), "r" (a)
 	: "cc");
 
-	if (ret)
+	if (oldval != u)
 		smp_mb();
 
-	return ret;
+	return oldval;
 }
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
 #define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
-- 
2.11.0
