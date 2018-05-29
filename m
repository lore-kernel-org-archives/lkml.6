Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936858AbeE2PrJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:47:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43490 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936829AbeE2PoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:44:25 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>
Subject: [PATCHv2 11/16] atomics/riscv: define atomic64_fetch_add_unless()
Date: Tue, 29 May 2018 16:43:41 +0100
Message-Id: <20180529154346.3168-12-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180529154346.3168-1-mark.rutland@arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step towards unifying the atomic/atomic64/atomic_long APIs, this
patch converts the arch/riscv implementation of atomic64_add_unless()
into an implementation of atomic64_fetch_add_unless().

A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
this, provided it is given a preprocessor definition.

No functional change is intended as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>
---
 arch/riscv/include/asm/atomic.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 5f161daefcd2..d959bbaaad41 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -352,7 +352,7 @@ static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #define atomic_fetch_add_unless atomic_fetch_add_unless
 
 #ifndef CONFIG_GENERIC_ATOMIC64
-static __always_inline long __atomic64_add_unless(atomic64_t *v, long a, long u)
+static __always_inline long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
 {
        long prev, rc;
 
@@ -369,11 +369,7 @@ static __always_inline long __atomic64_add_unless(atomic64_t *v, long a, long u)
 		: "memory");
 	return prev;
 }
-
-static __always_inline int atomic64_add_unless(atomic64_t *v, long a, long u)
-{
-	return __atomic64_add_unless(v, a, u) != u;
-}
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
 #endif
 
 /*
-- 
2.11.0
