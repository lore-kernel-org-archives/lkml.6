Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbeEWNip (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:38:45 -0400
Received: from foss.arm.com ([217.140.101.70]:55400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933142AbeEWNgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:36:22 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 08/13] atomics/arc: define atomic64_fetch_add_unless()
Date: Wed, 23 May 2018 14:35:28 +0100
Message-Id: <20180523133533.1076-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180523133533.1076-1-mark.rutland@arm.com>
References: <20180523133533.1076-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step towards unifying the atomic/atomic64/atomic_long APIs, this
patch converts the arch/arc implementation of atomic64_add_unless() into
an implementation of atomic64_fetch_add_unless().

A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
this, provided it is given a preprocessor definition.

No functional change is intended as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic.h | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 60da80481c5d..335ddc21ed03 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -531,41 +531,40 @@ static inline long long atomic64_dec_if_positive(atomic64_t *v)
 }
 
 /**
- * atomic64_add_unless - add unless the number is a given value
+ * atomic64_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
  *
- * if (v != u) { v += a; ret = 1} else {ret = 0}
- * Returns 1 iff @v was not @u (i.e. if add actually happened)
+ * Atomically adds @a to @v, so long as it was not @u.
+ * Returns the old value of @v
  */
-static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
+static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
+						  long long u)
 {
-	long long val;
-	int op_done;
+	long long old, temp;
 
 	smp_mb();
 
 	__asm__ __volatile__(
 	"1:	llockd  %0, [%2]	\n"
-	"	mov	%1, 1		\n"
 	"	brne	%L0, %L4, 2f	# continue to add since v != u \n"
 	"	breq.d	%H0, %H4, 3f	# return since v == u \n"
-	"	mov	%1, 0		\n"
 	"2:				\n"
-	"	add.f   %L0, %L0, %L3	\n"
-	"	adc     %H0, %H0, %H3	\n"
-	"	scondd  %0, [%2]	\n"
+	"	add.f   %L1, %L0, %L3	\n"
+	"	adc     %H1, %H0, %H3	\n"
+	"	scondd  %1, [%2]	\n"
 	"	bnz     1b		\n"
 	"3:				\n"
-	: "=&r"(val), "=&r" (op_done)
+	: "=&r"(old), "=&r" (temp)
 	: "r"(&v->counter), "r"(a), "r"(u)
 	: "cc");	/* memory clobber comes from smp_mb() */
 
 	smp_mb();
 
-	return op_done;
+	return old;
 }
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
 #define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
-- 
2.11.0
