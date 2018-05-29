Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936901AbeE2Prq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:47:46 -0400
Received: from foss.arm.com ([217.140.101.70]:43434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936801AbeE2PoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:44:15 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv2 06/16] atomics/generic: define atomic64_fetch_add_unless()
Date: Tue, 29 May 2018 16:43:36 +0100
Message-Id: <20180529154346.3168-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180529154346.3168-1-mark.rutland@arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step towards unifying the atomic/atomic64/atomic_long APIs, this
patch converts the generic implementation of atomic64_add_unless() into
a generic implementation of atomic64_fetch_add_unless().

A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
this, provided it is given a preprocessor definition.

No functional change is intended as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/atomic64.h |  3 ++-
 lib/atomic64.c                 | 13 ++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index e9a94b7a4d0a..b0aa425361ad 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -52,7 +52,8 @@ ATOMIC64_OPS(xor)
 extern long long atomic64_dec_if_positive(atomic64_t *v);
 extern long long atomic64_cmpxchg(atomic64_t *v, long long o, long long n);
 extern long long atomic64_xchg(atomic64_t *v, long long new);
-extern int	 atomic64_add_unless(atomic64_t *v, long long a, long long u);
+extern long long atomic64_fetch_add_unless(atomic64_t *v, long long a, long long u);
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
 #define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
diff --git a/lib/atomic64.c b/lib/atomic64.c
index 53c2d5edc826..fb2a38af5ae8 100644
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -178,18 +178,17 @@ long long atomic64_xchg(atomic64_t *v, long long new)
 }
 EXPORT_SYMBOL(atomic64_xchg);
 
-int atomic64_add_unless(atomic64_t *v, long long a, long long u)
+long long atomic64_fetch_add_unless(atomic64_t *v, long long a, long long u)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
-	int ret = 0;
+	long long val;
 
 	raw_spin_lock_irqsave(lock, flags);
-	if (v->counter != u) {
+	val = v->counter;
+	if (val != u)
 		v->counter += a;
-		ret = 1;
-	}
 	raw_spin_unlock_irqrestore(lock, flags);
-	return ret;
+	return val;
 }
-EXPORT_SYMBOL(atomic64_add_unless);
+EXPORT_SYMBOL(atomic64_fetch_add_unless);
-- 
2.11.0
