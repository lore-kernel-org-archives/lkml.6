Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44AAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7778D206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfAHOIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:08:07 -0500
Received: from foss.arm.com ([217.140.101.70]:52144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728790AbfAHOIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:08:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85F0A15AD;
        Tue,  8 Jan 2019 06:08:02 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92DC43F70D;
        Tue,  8 Jan 2019 06:08:00 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v8 02/26] arm64: Remove unused daif related functions/macros
Date:   Tue,  8 Jan 2019 14:07:20 +0000
Message-Id: <1546956464-48825-3-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
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

