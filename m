Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E352C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D9B208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D9B208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933748AbeFUMOC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:14:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49410 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933714AbeFUMOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:14:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69E9015BE;
        Thu, 21 Jun 2018 05:14:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E68843F578;
        Thu, 21 Jun 2018 05:13:58 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>
Subject: [PATCHv4 13/18] atomics/riscv: define atomic64_fetch_add_unless()
Date:   Thu, 21 Jun 2018 13:13:16 +0100
Message-Id: <20180621121321.4761-14-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180621121321.4761-1-mark.rutland@arm.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
Acked-by Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
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

