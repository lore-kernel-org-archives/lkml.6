Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4178C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F09E2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F09E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeH1Tod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:44:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41028 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1Tod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:44:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DC1BED1;
        Tue, 28 Aug 2018 08:52:16 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF97B3F557;
        Tue, 28 Aug 2018 08:52:14 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v5 12/27] arm64: Unmask PMR before going idle
Date:   Tue, 28 Aug 2018 16:51:22 +0100
Message-Id: <1535471497-38854-13-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU does not received signals for interrupts with a priority masked by
ICC_PMR_EL1. This means the CPU might not come back from a WFI
instruction.

Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/proc.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 03646e6..cc1caf7 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -20,6 +20,7 @@

 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
@@ -53,10 +54,27 @@
  *	cpu_do_idle()
  *
  *	Idle the processor (wait for interrupt).
+ *
+ *	If the CPU supports priority masking we must do additional work to
+ *	ensure that interrupts are not masked at the PMR (because the core will
+ *	not wake up if we block the wake up signal in the interrupt controller).
  */
 ENTRY(cpu_do_idle)
+alternative_if_not ARM64_HAS_IRQ_PRIO_MASKING
+	dsb	sy				// WFI may enter a low-power mode
+	wfi
+	ret
+alternative_else
+	mrs	x0, daif			// save I bit
+	msr	daifset, #2			// set I bit
+	mrs_s	x1, SYS_ICC_PMR_EL1		// save PMR
+alternative_endif
+	mov	x2, #ICC_PMR_EL1_UNMASKED
+	msr_s	SYS_ICC_PMR_EL1, x2		// unmask at PMR
 	dsb	sy				// WFI may enter a low-power mode
 	wfi
+	msr_s	SYS_ICC_PMR_EL1, x1		// restore PMR
+	msr	daif, x0			// restore I bit
 	ret
 ENDPROC(cpu_do_idle)

--
1.9.1
