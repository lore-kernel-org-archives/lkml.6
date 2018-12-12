Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3EFC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3EE20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3EE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeLLQry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:47:54 -0500
Received: from foss.arm.com ([217.140.101.70]:44468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeLLQrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:47:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8341515BF;
        Wed, 12 Dec 2018 08:47:52 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 930B03F575;
        Wed, 12 Dec 2018 08:47:50 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v7 02/25] arm64: Remove unused daif related functions/macros
Date:   Wed, 12 Dec 2018 16:47:02 +0000
Message-Id: <1544633245-6036-3-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some helpers to modify PSR.[DAIF] bits that are not referenced
anywhere. The less these bits are available outside of local_irq_*
functions the better.

Get rid of those unused helpers.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h | 10 +---------
 arch/arm64/include/asm/daifflags.h | 10 ----------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6142402..6e76c8e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -60,16 +60,8 @@
 	.endm
 
 /*
- * Enable and disable interrupts.
+ * Save/restore interrupts.
  */
-	.macro	disable_irq
-	msr	daifset, #2
-	.endm
-
-	.macro	enable_irq
-	msr	daifclr, #2
-	.endm
-
 	.macro	save_and_disable_irq, flags
 	mrs	\flags, daif
 	msr	daifset, #2
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 8d91f22..546bc39 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -43,16 +43,6 @@ static inline unsigned long local_daif_save(void)
 	return flags;
 }
 
-static inline void local_daif_unmask(void)
-{
-	trace_hardirqs_on();
-	asm volatile(
-		"msr	daifclr, #0xf		// local_daif_unmask"
-		:
-		:
-		: "memory");
-}
-
 static inline void local_daif_restore(unsigned long flags)
 {
 	if (!arch_irqs_disabled_flags(flags))
-- 
1.9.1

