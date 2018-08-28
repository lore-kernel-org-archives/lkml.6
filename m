Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31672C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18C12084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18C12084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeH1Top (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:44:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41092 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1Too (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:44:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C9B980D;
        Tue, 28 Aug 2018 08:52:28 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 17EFC3F557;
        Tue, 28 Aug 2018 08:52:25 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v5 17/27] irqchip/gic-v3: Factor group0 detection into functions
Date:   Tue, 28 Aug 2018 16:51:27 +0100
Message-Id: <1535471497-38854-18-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to detect whether Linux has access to group0 interrupts can
prove useful in other parts of the driver.

Provide a separate function to do this.

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 55 +++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d5912f1..fef6688 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -392,6 +392,39 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	} while (irqnr != ICC_IAR1_EL1_SPURIOUS);
 }

+static u32 gic_get_pribits(void)
+{
+	u32 pribits;
+
+	pribits = gic_read_ctlr();
+	pribits &= ICC_CTLR_EL1_PRI_BITS_MASK;
+	pribits >>= ICC_CTLR_EL1_PRI_BITS_SHIFT;
+	pribits++;
+
+	return pribits;
+}
+
+static bool gic_has_group0(void)
+{
+	u32 val;
+
+	/*
+	 * Let's find out if Group0 is under control of EL3 or not by
+	 * setting the highest possible, non-zero priority in PMR.
+	 *
+	 * If SCR_EL3.FIQ is set, the priority gets shifted down in
+	 * order for the CPU interface to set bit 7, and keep the
+	 * actual priority in the non-secure range. In the process, it
+	 * looses the least significant bit and the actual priority
+	 * becomes 0x80. Reading it back returns 0, indicating that
+	 * we're don't have access to Group0.
+	 */
+	gic_write_pmr(BIT(8 - gic_get_pribits()));
+	val = gic_read_pmr();
+
+	return val != 0;
+}
+
 static void __init gic_dist_init(void)
 {
 	unsigned int i;
@@ -533,7 +566,7 @@ static void gic_cpu_sys_reg_init(void)
 	u64 mpidr = cpu_logical_map(cpu);
 	u64 need_rss = MPIDR_RS(mpidr);
 	bool group0;
-	u32 val, pribits;
+	u32 pribits;

 	/*
 	 * Need to check that the SRE bit has actually been set. If
@@ -545,25 +578,9 @@ static void gic_cpu_sys_reg_init(void)
 	if (!gic_enable_sre())
 		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");

-	pribits = gic_read_ctlr();
-	pribits &= ICC_CTLR_EL1_PRI_BITS_MASK;
-	pribits >>= ICC_CTLR_EL1_PRI_BITS_SHIFT;
-	pribits++;
+	pribits = gic_get_pribits();

-	/*
-	 * Let's find out if Group0 is under control of EL3 or not by
-	 * setting the highest possible, non-zero priority in PMR.
-	 *
-	 * If SCR_EL3.FIQ is set, the priority gets shifted down in
-	 * order for the CPU interface to set bit 7, and keep the
-	 * actual priority in the non-secure range. In the process, it
-	 * looses the least significant bit and the actual priority
-	 * becomes 0x80. Reading it back returns 0, indicating that
-	 * we're don't have access to Group0.
-	 */
-	write_gicreg(BIT(8 - pribits), ICC_PMR_EL1);
-	val = read_gicreg(ICC_PMR_EL1);
-	group0 = val != 0;
+	group0 = gic_has_group0();

 	/* Set priority mask register */
 	write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
--
1.9.1
