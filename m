Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933241AbeEWNiE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:38:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55418 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933156AbeEWNg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:36:28 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 10/13] atomics/powerpc: define atomic64_fetch_add_unless()
Date: Wed, 23 May 2018 14:35:30 +0100
Message-Id: <20180523133533.1076-11-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180523133533.1076-1-mark.rutland@arm.com>
References: <20180523133533.1076-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step towards unifying the atomic/atomic64/atomic_long APIs, this
patch converts the arch/powerpc implementation of atomic64_add_unless()
into an implementation of atomic64_fetch_add_unless().

A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
this, provided it is given a preprocessor definition.

No functional change is intended as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/atomic.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index b5646c079c16..233dbf31911c 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -525,7 +525,7 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 #define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
 /**
- * atomic64_add_unless - add unless the number is a given value
+ * atomic64_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -533,13 +533,13 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
+static __inline__ long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
 {
 	long t;
 
 	__asm__ __volatile__ (
 	PPC_ATOMIC_ENTRY_BARRIER
-"1:	ldarx	%0,0,%1		# atomic_fetch_add_unless\n\
+"1:	ldarx	%0,0,%1		# atomic64_fetch_add_unless\n\
 	cmpd	0,%0,%3 \n\
 	beq	2f \n\
 	add	%0,%2,%0 \n"
@@ -552,8 +552,9 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 	: "r" (&v->counter), "r" (a), "r" (u)
 	: "cc", "memory");
 
-	return t != u;
+	return t;
 }
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
 /**
  * atomic_inc64_not_zero - increment unless the number is zero
-- 
2.11.0
