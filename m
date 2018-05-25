Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966207AbeEYJuq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:50:46 -0400
Received: from foss.arm.com ([217.140.101.70]:57584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966133AbeEYJuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:37 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v4 17/26] irqchip/gic-v3: Factor group0 detection into functions
Date: Fri, 25 May 2018 10:49:23 +0100
Message-Id: <1527241772-48007-18-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to detect whether Linux has access to group0 interrupts can
prove useful in other parts of the driver.

Provide a separate function to do this.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 55 +++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0c58db3..13d283d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -389,6 +389,39 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	}
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
@@ -530,7 +563,7 @@ static void gic_cpu_sys_reg_init(void)
 	u64 mpidr = cpu_logical_map(cpu);
 	u64 need_rss = MPIDR_RS(mpidr);
 	bool group0;
-	u32 val, pribits;
+	u32 pribits;
 
 	/*
 	 * Need to check that the SRE bit has actually been set. If
@@ -542,25 +575,9 @@ static void gic_cpu_sys_reg_init(void)
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
