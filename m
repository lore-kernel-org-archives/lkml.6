Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964876AbeE2Poh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:44:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43476 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964815AbeE2PoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:44:23 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCHv2 10/16] atomics/powerpc: define atomic64_fetch_add_unless()
Date: Tue, 29 May 2018 16:43:40 +0100
Message-Id: <20180529154346.3168-11-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180529154346.3168-1-mark.rutland@arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com>
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
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
