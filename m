Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933217AbeEWNjC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:39:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55376 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933130AbeEWNgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:36:18 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 06/13] atomics/generic: define atomic64_fetch_add_unless()
Date: Wed, 23 May 2018 14:35:26 +0100
Message-Id: <20180523133533.1076-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180523133533.1076-1-mark.rutland@arm.com>
References: <20180523133533.1076-1-mark.rutland@arm.com>
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
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
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
