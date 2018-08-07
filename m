Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F62C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA82A2157F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA82A2157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbeHGLrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:47:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51598 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbeHGLrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:47:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C36E880D;
        Tue,  7 Aug 2018 02:33:43 -0700 (PDT)
Received: from approximate.Emea.Arm.com (approximate.Emea.Arm.com [10.4.13.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D82A63F2EA;
        Tue,  7 Aug 2018 02:33:42 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] arm64: Trap WFI executed in userspace
Date:   Tue,  7 Aug 2018 10:33:26 +0100
Message-Id: <20180807093326.5090-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It recently came to light that userspace can execute WFI, and that
the arm64 kernel doesn trap this event. This sounds rather benign,
but the kernel should decide when it wants to wait for an interrupt,
and not userspace.

Let's trap WFI and treat it as a way to yield the CPU to another
process.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/esr.h    |  4 ++++
 arch/arm64/include/asm/sysreg.h |  4 ++--
 arch/arm64/kernel/entry.S       |  1 +
 arch/arm64/kernel/traps.c       | 12 ++++++++++++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index ce70c3ffb993..9a2b6cee4e2b 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -137,6 +137,7 @@
 #define ESR_ELx_CV		(UL(1) << 24)
 #define ESR_ELx_COND_SHIFT	(20)
 #define ESR_ELx_COND_MASK	(UL(0xF) << ESR_ELx_COND_SHIFT)
+#define ESR_ELx_WFx_ISS_WFI	(UL(0) << 0)
 #define ESR_ELx_WFx_ISS_WFE	(UL(1) << 0)
 #define ESR_ELx_xVC_IMM_MASK	((1UL << 16) - 1)
 
@@ -148,6 +149,9 @@
 #define DISR_EL1_ESR_MASK	(ESR_ELx_AET | ESR_ELx_EA | ESR_ELx_FSC)
 
 /* ESR value templates for specific events */
+#define ESR_ELx_WFx_MASK	(ESR_ELx_EC_MASK | 1)
+#define ESR_ELx_WFx_WFI_VAL	((ESR_ELx_EC_WFx << ESR_ELx_EC_SHIFT) |	\
+				 ESR_ELx_WFx_ISS_WFI)
 
 /* BRK instruction trap from AArch64 state */
 #define ESR_ELx_VAL_BRK64(imm)					\
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 98af0b37fb31..56bcf0408dbb 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -485,12 +485,12 @@
 
 #define SCTLR_EL1_SET	(SCTLR_ELx_M    | SCTLR_ELx_C    | SCTLR_ELx_SA   |\
 			 SCTLR_EL1_SA0  | SCTLR_EL1_SED  | SCTLR_ELx_I    |\
-			 SCTLR_EL1_DZE  | SCTLR_EL1_UCT  | SCTLR_EL1_NTWI |\
+			 SCTLR_EL1_DZE  | SCTLR_EL1_UCT  |		   \
 			 SCTLR_EL1_NTWE | SCTLR_ELx_IESB | SCTLR_EL1_SPAN |\
 			 ENDIAN_SET_EL1 | SCTLR_EL1_UCI  | SCTLR_EL1_RES1)
 #define SCTLR_EL1_CLEAR	(SCTLR_ELx_A   | SCTLR_EL1_CP15BEN | SCTLR_EL1_ITD    |\
 			 SCTLR_EL1_UMA | SCTLR_ELx_WXN     | ENDIAN_CLEAR_EL1 |\
-			 SCTLR_EL1_RES0)
+			 SCTLR_EL1_NTWI | SCTLR_EL1_RES0)
 
 /* Check all the bits are accounted for */
 #define SCTLR_EL1_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != ~0)
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 28ad8799406f..4c01c0ba81aa 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -675,6 +675,7 @@ el0_sync:
 	cmp	x24, #ESR_ELx_EC_FP_EXC64	// FP/ASIMD exception
 	b.eq	el0_fpsimd_exc
 	cmp	x24, #ESR_ELx_EC_SYS64		// configurable trap
+	ccmp	x24, #ESR_ELx_EC_WFx, #4, ne
 	b.eq	el0_sys
 	cmp	x24, #ESR_ELx_EC_SP_ALIGN	// stack alignment exception
 	b.eq	el0_sp_pc
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d399d459397b..2e4b389a6c8f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -496,6 +496,12 @@ static void cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 }
 
+static void wfi_handler(unsigned int esr, struct pt_regs *regs)
+{
+	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+	schedule();
+}
+
 struct sys64_hook {
 	unsigned int esr_mask;
 	unsigned int esr_val;
@@ -526,6 +532,12 @@ static struct sys64_hook sys64_hooks[] = {
 		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTFRQ,
 		.handler = cntfrq_read_handler,
 	},
+	{
+		/* Trap WFI instructions executed in userspace */
+		.esr_mask = ESR_ELx_WFx_MASK,
+		.esr_val = ESR_ELx_WFx_WFI_VAL,
+		.handler = wfi_handler,
+	},
 	{},
 };
 
-- 
2.18.0

