Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07940C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFA5218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfAaO7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:59:24 -0500
Received: from foss.arm.com ([217.140.101.70]:45470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730283AbfAaO7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:59:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2C421596;
        Thu, 31 Jan 2019 06:59:20 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E95FD3F59C;
        Thu, 31 Jan 2019 06:59:18 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v10 02/25] arm64: Remove unused daif related functions/macros
Date:   Thu, 31 Jan 2019 14:58:40 +0000
Message-Id: <1548946743-38979-3-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
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
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h | 10 +---------
 arch/arm64/include/asm/daifflags.h | 10 ----------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 4feb611..7acf243 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -62,16 +62,8 @@
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

