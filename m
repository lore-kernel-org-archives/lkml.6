Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936949AbeE2Psm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:48:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43376 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936450AbeE2PoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:44:06 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCHv2 02/16] atomics/treewide: remove redundant atomic_inc_not_zero() definitions
Date: Tue, 29 May 2018 16:43:32 +0100
Message-Id: <20180529154346.3168-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180529154346.3168-1-mark.rutland@arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When atomic_inc_not_zero(v) isn't defined, <linux/atomic.h> will define
it as falling back to atomic_add_unless((v), 1, 0), so there's no need
for arch code to do so.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arc/include/asm/atomic.h     | 2 --
 arch/hexagon/include/asm/atomic.h | 2 --
 arch/riscv/include/asm/atomic.h   | 9 ---------
 3 files changed, 13 deletions(-)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 67121b5ff3a3..cecdf3403caf 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -336,8 +336,6 @@ ATOMIC_OPS(xor, ^=, CTOP_INST_AXOR_DI_R2_R2_R3)
 	c;								\
 })
 
-#define atomic_inc_not_zero(v)		atomic_add_unless((v), 1, 0)
-
 #define atomic_inc(v)			atomic_add(1, v)
 #define atomic_dec(v)			atomic_sub(1, v)
 
diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 287aa9f394f3..d2feeba93c44 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -197,8 +197,6 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	return __oldval;
 }
 
-#define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
-
 #define atomic_inc(v) atomic_add(1, (v))
 #define atomic_dec(v) atomic_sub(1, (v))
 
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 739e810c857e..0e27e050ba14 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -375,15 +375,6 @@ static __always_inline int atomic64_add_unless(atomic64_t *v, long a, long u)
 }
 #endif
 
-/*
- * The extra atomic operations that are constructed from one of the core
- * LR/SC-based operations above.
- */
-static __always_inline int atomic_inc_not_zero(atomic_t *v)
-{
-        return atomic_fetch_add_unless(v, 1, 0);
-}
-
 #ifndef CONFIG_GENERIC_ATOMIC64
 static __always_inline long atomic64_inc_not_zero(atomic64_t *v)
 {
-- 
2.11.0
