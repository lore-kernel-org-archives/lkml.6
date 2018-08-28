Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93A7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2A22084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2A22084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeH1ToR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:44:17 -0400
Received: from foss.arm.com ([217.140.101.70]:40950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1ToQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:44:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70542168F;
        Tue, 28 Aug 2018 08:52:00 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 78C983F557;
        Tue, 28 Aug 2018 08:51:58 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v5 05/27] arm64: Use daifflag_restore after bp_hardening
Date:   Tue, 28 Aug 2018 16:51:15 +0100
Message-Id: <1535471497-38854-6-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For EL0 entries requiring bp_hardening, daif status is kept at
DAIF_PROCCTX_NOIRQ until after hardening has been done. Then interrupts
are enabled through local_irq_enable().

Before using local_irq_* functions, daifflags should be properly restored
to a state where IRQs are enabled.

Enable IRQs by restoring DAIF_PROCCTX state after bp hardening.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/mm/fault.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 50b30ff..dfa2c43 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -37,6 +37,7 @@
 #include <asm/cmpxchg.h>
 #include <asm/cpufeature.h>
 #include <asm/exception.h>
+#include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
 #include <asm/sysreg.h>
@@ -771,7 +772,7 @@ asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 	if (addr > TASK_SIZE)
 		arm64_apply_bp_hardening();
 
-	local_irq_enable();
+	local_daif_restore(DAIF_PROCCTX);
 	do_mem_abort(addr, esr, regs);
 }
 
@@ -785,7 +786,7 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 	if (user_mode(regs)) {
 		if (instruction_pointer(regs) > TASK_SIZE)
 			arm64_apply_bp_hardening();
-		local_irq_enable();
+		local_daif_restore(DAIF_PROCCTX);
 	}
 
 	clear_siginfo(&info);
-- 
1.9.1

