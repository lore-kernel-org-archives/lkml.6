Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B2AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B8320852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B8320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937109AbeFRKXu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:23:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59340 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934189AbeFRKTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:19:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 378A715B2;
        Mon, 18 Jun 2018 03:19:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 064823F25D;
        Mon, 18 Jun 2018 03:19:32 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com
Cc:     mingo@kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv3 02/18] atomics/treewide: remove redundant atomic_inc_not_zero() definitions
Date:   Mon, 18 Jun 2018 11:19:03 +0100
Message-Id: <20180618101919.51973-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180618101919.51973-1-mark.rutland@arm.com>
References: <20180618101919.51973-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When atomic_inc_not_zero(v) isn't defined, <linux/atomic.h> will define
it as falling back to atomic_add_unless((v), 1, 0), so there's no need
for arch code to do so.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
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

