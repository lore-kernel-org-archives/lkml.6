Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71F9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E41D208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E41D208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933493AbeFUMNg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:13:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49236 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932763AbeFUMNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:13:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD7B11529;
        Thu, 21 Jun 2018 05:13:33 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 793533F578;
        Thu, 21 Jun 2018 05:13:32 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCHv4 01/18] atomics/treewide: s/__atomic_add_unless/atomic_fetch_add_unless/
Date:   Thu, 21 Jun 2018 13:13:04 +0100
Message-Id: <20180621121321.4761-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180621121321.4761-1-mark.rutland@arm.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While __atomic_add_unless was originally intended as a building-block
for atomic_add_unless, it's now used in a number of places around the
kernel. It's the only common atomic operation named __atomic*(), rather
than atomic_*(), and for consistency it would be better named
atomic_fetch_add_unless().

This lack of consistency is slightly confusing, and gets in the way of
scripting atomics. Given that, let's clean things up and promote it to
an official part of the atomics API, in the form of
atomic_fetch_add_unless().

This patch converts definitions and invocations over to the new name,
including the instrumented version, using the following script:

----
git grep -w __atomic_add_unless | while read line; do
sed -i '{s/\<__atomic_add_unless\>/atomic_fetch_add_unless/}' "${line%%:*}";
done
git grep -w __arch_atomic_add_unless | while read line; do
sed -i '{s/\<__arch_atomic_add_unless\>/arch_atomic_fetch_add_unless/}' "${line%%:*}";
done
----

Note that we do not have atomic{64,_long}_fetch_add_unless(), which will
be introduced by later patches.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 arch/alpha/include/asm/atomic.h           | 4 ++--
 arch/arc/include/asm/atomic.h             | 4 ++--
 arch/arm/include/asm/atomic.h             | 4 ++--
 arch/arm64/include/asm/atomic.h           | 2 +-
 arch/h8300/include/asm/atomic.h           | 2 +-
 arch/hexagon/include/asm/atomic.h         | 4 ++--
 arch/ia64/include/asm/atomic.h            | 2 +-
 arch/m68k/include/asm/atomic.h            | 2 +-
 arch/mips/include/asm/atomic.h            | 4 ++--
 arch/openrisc/include/asm/atomic.h        | 4 ++--
 arch/parisc/include/asm/atomic.h          | 4 ++--
 arch/powerpc/include/asm/atomic.h         | 8 ++++----
 arch/riscv/include/asm/atomic.h           | 4 ++--
 arch/s390/include/asm/atomic.h            | 2 +-
 arch/sh/include/asm/atomic.h              | 4 ++--
 arch/sparc/include/asm/atomic_32.h        | 2 +-
 arch/sparc/include/asm/atomic_64.h        | 2 +-
 arch/sparc/lib/atomic32.c                 | 4 ++--
 arch/x86/include/asm/atomic.h             | 4 ++--
 arch/xtensa/include/asm/atomic.h          | 4 ++--
 drivers/block/rbd.c                       | 2 +-
 drivers/infiniband/core/rdma_core.c       | 2 +-
 fs/afs/rxrpc.c                            | 2 +-
 include/asm-generic/atomic-instrumented.h | 4 ++--
 include/asm-generic/atomic.h              | 4 ++--
 include/linux/atomic.h                    | 2 +-
 kernel/bpf/syscall.c                      | 4 ++--
 net/rxrpc/call_object.c                   | 2 +-
 net/rxrpc/conn_object.c                   | 4 ++--
 net/rxrpc/local_object.c                  | 2 +-
 net/rxrpc/peer_object.c                   | 2 +-
 31 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 767bfdd42992..392b15a4dd4f 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -206,7 +206,7 @@ ATOMIC_OPS(xor, xor)
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
- * __atomic_add_unless - add unless the number is a given value
+ * atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -214,7 +214,7 @@ ATOMIC_OPS(xor, xor)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
+static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, new, old;
 	smp_mb();
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 11859287c52a..67121b5ff3a3 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -309,7 +309,7 @@ ATOMIC_OPS(xor, ^=, CTOP_INST_AXOR_DI_R2_R2_R3)
 #undef ATOMIC_OP
 
 /**
- * __atomic_add_unless - add unless the number is a given value
+ * atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -317,7 +317,7 @@ ATOMIC_OPS(xor, ^=, CTOP_INST_AXOR_DI_R2_R2_R3)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v
  */
-#define __atomic_add_unless(v, a, u)					\
+#define atomic_fetch_add_unless(v, a, u)					\
 ({									\
 	int c, old;							\
 									\
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 66d0e215a773..9d56d0727c9b 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -130,7 +130,7 @@ static inline int atomic_cmpxchg_relaxed(atomic_t *ptr, int old, int new)
 }
 #define atomic_cmpxchg_relaxed		atomic_cmpxchg_relaxed
 
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int oldval, newval;
 	unsigned long tmp;
@@ -215,7 +215,7 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return ret;
 }
 
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
 
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index c0235e0ff849..264d20339f74 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -125,7 +125,7 @@
 #define atomic_dec_and_test(v)		(atomic_dec_return(v) == 0)
 #define atomic_sub_and_test(i, v)	(atomic_sub_return((i), (v)) == 0)
 #define atomic_add_negative(i, v)	(atomic_add_return((i), (v)) < 0)
-#define __atomic_add_unless(v, a, u)	___atomic_add_unless(v, a, u,)
+#define atomic_fetch_add_unless(v, a, u)	___atomic_add_unless(v, a, u,)
 #define atomic_andnot			atomic_andnot
 
 /*
diff --git a/arch/h8300/include/asm/atomic.h b/arch/h8300/include/asm/atomic.h
index 941e7554e886..4465cfc30a3a 100644
--- a/arch/h8300/include/asm/atomic.h
+++ b/arch/h8300/include/asm/atomic.h
@@ -94,7 +94,7 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return ret;
 }
 
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
 	h8300flags flags;
diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index fb3dfb2a667e..287aa9f394f3 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -164,7 +164,7 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP
 
 /**
- * __atomic_add_unless - add unless the number is a given value
+ * atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer to value
  * @a: amount to add
  * @u: unless value is equal to u
@@ -173,7 +173,7 @@ ATOMIC_OPS(xor)
  *
  */
 
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int __oldval;
 	register int tmp;
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index 2524fb60fbc2..9d2ddde5f9d5 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -215,7 +215,7 @@ ATOMIC64_FETCH_OP(xor, ^)
 	(cmpxchg(&((v)->counter), old, new))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
-static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
+static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
 	c = atomic_read(v);
diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
index e993e2860ee1..8022d9ea1213 100644
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -211,7 +211,7 @@ static inline int atomic_add_negative(int i, atomic_t *v)
 	return c != 0;
 }
 
-static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
+static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
 	c = atomic_read(v);
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 0ab176bdb8e8..02fc1553cf9b 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -275,7 +275,7 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 #define atomic_xchg(v, new) (xchg(&((v)->counter), (new)))
 
 /**
- * __atomic_add_unless - add unless the number is a given value
+ * atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -283,7 +283,7 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
+static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
 	c = atomic_read(v);
diff --git a/arch/openrisc/include/asm/atomic.h b/arch/openrisc/include/asm/atomic.h
index 146e1660f00e..b589fac39b92 100644
--- a/arch/openrisc/include/asm/atomic.h
+++ b/arch/openrisc/include/asm/atomic.h
@@ -100,7 +100,7 @@ ATOMIC_OP(xor)
  *
  * This is often used through atomic_inc_not_zero()
  */
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int old, tmp;
 
@@ -119,7 +119,7 @@ static inline int __atomic_add_unless(atomic_t *v, int a, int u)
 
 	return old;
 }
-#define __atomic_add_unless	__atomic_add_unless
+#define atomic_fetch_add_unless	atomic_fetch_add_unless
 
 #include <asm-generic/atomic.h>
 
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index 88bae6676c9b..7748abced766 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -78,7 +78,7 @@ static __inline__ int atomic_read(const atomic_t *v)
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
- * __atomic_add_unless - add unless the number is a given value
+ * atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -86,7 +86,7 @@ static __inline__ int atomic_read(const atomic_t *v)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
+static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
 	c = atomic_read(v);
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 682b3e6a1e21..1483261080a1 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -218,7 +218,7 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
 #define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
 /**
- * __atomic_add_unless - add unless the number is a given value
+ * atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -226,13 +226,13 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
+static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int t;
 
 	__asm__ __volatile__ (
 	PPC_ATOMIC_ENTRY_BARRIER
-"1:	lwarx	%0,0,%1		# __atomic_add_unless\n\
+"1:	lwarx	%0,0,%1		# atomic_fetch_add_unless\n\
 	cmpw	0,%0,%3 \n\
 	beq	2f \n\
 	add	%0,%2,%0 \n"
@@ -538,7 +538,7 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 
 	__asm__ __volatile__ (
 	PPC_ATOMIC_ENTRY_BARRIER
-"1:	ldarx	%0,0,%1		# __atomic_add_unless\n\
+"1:	ldarx	%0,0,%1		# atomic_fetch_add_unless\n\
 	cmpd	0,%0,%3 \n\
 	beq	2f \n\
 	add	%0,%2,%0 \n"
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 855115ace98c..739e810c857e 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -332,7 +332,7 @@ ATOMIC_OP(dec_and_test, dec, ==, 0, 64)
 #undef ATOMIC_OP
 
 /* This is required to provide a full barrier on success. */
-static __always_inline int __atomic_add_unless(atomic_t *v, int a, int u)
+static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
        int prev, rc;
 
@@ -381,7 +381,7 @@ static __always_inline int atomic64_add_unless(atomic64_t *v, long a, long u)
  */
 static __always_inline int atomic_inc_not_zero(atomic_t *v)
 {
-        return __atomic_add_unless(v, 1, 0);
+        return atomic_fetch_add_unless(v, 1, 0);
 }
 
 #ifndef CONFIG_GENERIC_ATOMIC64
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index 4b55532f15c4..c2858cdd8c29 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -90,7 +90,7 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return __atomic_cmpxchg(&v->counter, old, new);
 }
 
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
 	c = atomic_read(v);
diff --git a/arch/sh/include/asm/atomic.h b/arch/sh/include/asm/atomic.h
index 0fd0099f43cc..ef45931ebac5 100644
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -46,7 +46,7 @@
 #define atomic_cmpxchg(v, o, n)		(cmpxchg(&((v)->counter), (o), (n)))
 
 /**
- * __atomic_add_unless - add unless the number is a given value
+ * atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -54,7 +54,7 @@
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
 	c = atomic_read(v);
diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index d13ce517f4b9..a58f4b43bcc7 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -27,7 +27,7 @@ int atomic_fetch_or(int, atomic_t *);
 int atomic_fetch_xor(int, atomic_t *);
 int atomic_cmpxchg(atomic_t *, int, int);
 int atomic_xchg(atomic_t *, int);
-int __atomic_add_unless(atomic_t *, int, int);
+int atomic_fetch_add_unless(atomic_t *, int, int);
 void atomic_set(atomic_t *, int);
 
 #define atomic_set_release(v, i)	atomic_set((v), (i))
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index 28db058d471b..f416fd3d2708 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -89,7 +89,7 @@ static inline int atomic_xchg(atomic_t *v, int new)
 	return xchg(&v->counter, new);
 }
 
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
 	c = atomic_read(v);
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 465a901a0ada..281fa634bb1a 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -95,7 +95,7 @@ int atomic_cmpxchg(atomic_t *v, int old, int new)
 }
 EXPORT_SYMBOL(atomic_cmpxchg);
 
-int __atomic_add_unless(atomic_t *v, int a, int u)
+int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
 	unsigned long flags;
@@ -107,7 +107,7 @@ int __atomic_add_unless(atomic_t *v, int a, int u)
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 	return ret;
 }
-EXPORT_SYMBOL(__atomic_add_unless);
+EXPORT_SYMBOL(atomic_fetch_add_unless);
 
 /* Atomic operations are already serializing */
 void atomic_set(atomic_t *v, int i)
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 0db6bec95489..84ed0bd76aef 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -254,7 +254,7 @@ static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 }
 
 /**
- * __arch_atomic_add_unless - add unless the number is already a given value
+ * arch_atomic_fetch_add_unless - add unless the number is already a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -262,7 +262,7 @@ static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
  * Atomically adds @a to @v, so long as @v was not already @u.
  * Returns the old value of @v.
  */
-static __always_inline int __arch_atomic_add_unless(atomic_t *v, int a, int u)
+static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c = arch_atomic_read(v);
 
diff --git a/arch/xtensa/include/asm/atomic.h b/arch/xtensa/include/asm/atomic.h
index e7a23f2a519a..4188e56c06c9 100644
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -275,7 +275,7 @@ ATOMIC_OPS(xor)
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
- * __atomic_add_unless - add unless the number is a given value
+ * atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -283,7 +283,7 @@ ATOMIC_OPS(xor)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
+static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
 	c = atomic_read(v);
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fa0729c1e776..d81c653b9bf6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -61,7 +61,7 @@ static int atomic_inc_return_safe(atomic_t *v)
 {
 	unsigned int counter;
 
-	counter = (unsigned int)__atomic_add_unless(v, 1, 0);
+	counter = (unsigned int)atomic_fetch_add_unless(v, 1, 0);
 	if (counter <= (unsigned int)INT_MAX)
 		return (int)counter;
 
diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index a6e904973ba8..475910ffbcb6 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -121,7 +121,7 @@ static int uverbs_try_lock_object(struct ib_uobject *uobj, bool exclusive)
 	 * this lock.
 	 */
 	if (!exclusive)
-		return __atomic_add_unless(&uobj->usecnt, 1, -1) == -1 ?
+		return atomic_fetch_add_unless(&uobj->usecnt, 1, -1) == -1 ?
 			-EBUSY : 0;
 
 	/* lock is either WRITE or DESTROY - should be exclusive */
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index a1b18082991b..183cc5418722 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -648,7 +648,7 @@ static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
 	trace_afs_notify_call(rxcall, call);
 	call->need_attention = true;
 
-	u = __atomic_add_unless(&call->usage, 1, 0);
+	u = atomic_fetch_add_unless(&call->usage, 1, 0);
 	if (u != 0) {
 		trace_afs_call(call, afs_call_trace_wake, u,
 			       atomic_read(&call->net->nr_outstanding_calls),
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index ec07f23678ea..b8b14cc2df6c 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -84,10 +84,10 @@ static __always_inline bool atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 ne
 }
 #endif
 
-static __always_inline int __atomic_add_unless(atomic_t *v, int a, int u)
+static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	kasan_check_write(v, sizeof(*v));
-	return __arch_atomic_add_unless(v, a, u);
+	return arch_atomic_fetch_add_unless(v, a, u);
 }
 
 
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index abe6dd9ca2a8..10051ed6d088 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -221,8 +221,8 @@ static inline void atomic_dec(atomic_t *v)
 #define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
 
-#ifndef __atomic_add_unless
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+#ifndef atomic_fetch_add_unless
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
 	c = atomic_read(v);
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 01ce3997cb42..9cc982936675 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -530,7 +530,7 @@
  */
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
-	return __atomic_add_unless(v, a, u) != u;
+	return atomic_fetch_add_unless(v, a, u) != u;
 }
 
 /**
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fa20624707f..bee4e7617594 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -575,7 +575,7 @@ static struct bpf_map *bpf_map_inc_not_zero(struct bpf_map *map,
 {
 	int refold;
 
-	refold = __atomic_add_unless(&map->refcnt, 1, 0);
+	refold = atomic_fetch_add_unless(&map->refcnt, 1, 0);
 
 	if (refold >= BPF_MAX_REFCNT) {
 		__bpf_map_put(map, false);
@@ -1147,7 +1147,7 @@ struct bpf_prog *bpf_prog_inc_not_zero(struct bpf_prog *prog)
 {
 	int refold;
 
-	refold = __atomic_add_unless(&prog->aux->refcnt, 1, 0);
+	refold = atomic_fetch_add_unless(&prog->aux->refcnt, 1, 0);
 
 	if (refold >= BPF_MAX_REFCNT) {
 		__bpf_prog_put(prog, false);
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index f6734d8cb01a..9486293fef5c 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -415,7 +415,7 @@ void rxrpc_incoming_call(struct rxrpc_sock *rx,
 bool rxrpc_queue_call(struct rxrpc_call *call)
 {
 	const void *here = __builtin_return_address(0);
-	int n = __atomic_add_unless(&call->usage, 1, 0);
+	int n = atomic_fetch_add_unless(&call->usage, 1, 0);
 	if (n == 0)
 		return false;
 	if (rxrpc_queue_work(&call->processor))
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 4c77a78a252a..77440a356b14 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -266,7 +266,7 @@ void rxrpc_kill_connection(struct rxrpc_connection *conn)
 bool rxrpc_queue_conn(struct rxrpc_connection *conn)
 {
 	const void *here = __builtin_return_address(0);
-	int n = __atomic_add_unless(&conn->usage, 1, 0);
+	int n = atomic_fetch_add_unless(&conn->usage, 1, 0);
 	if (n == 0)
 		return false;
 	if (rxrpc_queue_work(&conn->processor))
@@ -309,7 +309,7 @@ rxrpc_get_connection_maybe(struct rxrpc_connection *conn)
 	const void *here = __builtin_return_address(0);
 
 	if (conn) {
-		int n = __atomic_add_unless(&conn->usage, 1, 0);
+		int n = atomic_fetch_add_unless(&conn->usage, 1, 0);
 		if (n > 0)
 			trace_rxrpc_conn(conn, rxrpc_conn_got, n + 1, here);
 		else
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index b493e6b62740..777c3ed4cfc0 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -305,7 +305,7 @@ struct rxrpc_local *rxrpc_get_local_maybe(struct rxrpc_local *local)
 	const void *here = __builtin_return_address(0);
 
 	if (local) {
-		int n = __atomic_add_unless(&local->usage, 1, 0);
+		int n = atomic_fetch_add_unless(&local->usage, 1, 0);
 		if (n > 0)
 			trace_rxrpc_local(local, rxrpc_local_got, n + 1, here);
 		else
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 1b7e8107b3ae..1cf3b408017a 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -406,7 +406,7 @@ struct rxrpc_peer *rxrpc_get_peer_maybe(struct rxrpc_peer *peer)
 	const void *here = __builtin_return_address(0);
 
 	if (peer) {
-		int n = __atomic_add_unless(&peer->usage, 1, 0);
+		int n = atomic_fetch_add_unless(&peer->usage, 1, 0);
 		if (n > 0)
 			trace_rxrpc_peer(peer, rxrpc_peer_got, n + 1, here);
 		else
-- 
2.11.0

