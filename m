Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9EEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE182084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE182084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeH1Ton (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:44:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41076 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1Tom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:44:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC74915BF;
        Tue, 28 Aug 2018 08:52:25 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE7143F557;
        Tue, 28 Aug 2018 08:52:23 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v5 16/27] arm64: daifflags: Include PMR in daifflags restore operations
Date:   Tue, 28 Aug 2018 16:51:26 +0100
Message-Id: <1535471497-38854-17-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addition of PMR should not bypass the semantics of daifflags.

When DA_F are set, I bit is also set as no interrupts (even of higher
priority) is allowed.

When DA_F are cleared, I bit is cleared and interrupt enabling/disabling
goes through ICC_PMR_EL1.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/daifflags.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 8d91f22..ccd95e8 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -18,8 +18,14 @@
 
 #include <linux/irqflags.h>
 
-#define DAIF_PROCCTX		0
-#define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
+#include <asm/arch_gicv3.h>
+
+#define DAIF_PROCCTX	MAKE_ARCH_FLAGS(0, ICC_PMR_EL1_UNMASKED)
+
+#define DAIF_PROCCTX_NOIRQ						\
+	(gic_prio_masking_enabled() ?					\
+		MAKE_ARCH_FLAGS(0, ICC_PMR_EL1_MASKED) :		\
+		MAKE_ARCH_FLAGS(PSR_I_BIT, ICC_PMR_EL1_UNMASKED))
 
 /* mask/save/unmask/restore all exceptions, including interrupts. */
 static inline void local_daif_mask(void)
@@ -51,6 +57,10 @@ static inline void local_daif_unmask(void)
 		:
 		:
 		: "memory");
+
+	/* Unmask IRQs in PMR if needed */
+	if (gic_prio_masking_enabled())
+		arch_local_irq_enable();
 }
 
 static inline void local_daif_restore(unsigned long flags)
-- 
1.9.1

