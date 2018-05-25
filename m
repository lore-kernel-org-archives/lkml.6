Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966177AbeEYJuo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:50:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57602 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965702AbeEYJuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:40 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v4 18/26] irqchip/gic-v3: Do not overwrite PMR value
Date: Fri, 25 May 2018 10:49:24 +0100
Message-Id: <1527241772-48007-19-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the architecture is using ICC_PMR_EL1 to mask IRQs, do not overwrite
that value.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 13d283d..fc477e2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -226,6 +226,11 @@ static void gic_unmask_irq(struct irq_data *d)
 	gic_poke_irq(d, GICD_ISENABLER);
 }
 
+static inline bool arch_uses_gic_prios(void)
+{
+	return IS_ENABLED(CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS);
+}
+
 static int gic_irq_set_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool val)
 {
@@ -404,6 +409,9 @@ static u32 gic_get_pribits(void)
 static bool gic_has_group0(void)
 {
 	u32 val;
+	u32 old_pmr;
+
+	old_pmr = gic_read_pmr();
 
 	/*
 	 * Let's find out if Group0 is under control of EL3 or not by
@@ -419,6 +427,8 @@ static bool gic_has_group0(void)
 	gic_write_pmr(BIT(8 - gic_get_pribits()));
 	val = gic_read_pmr();
 
+	gic_write_pmr(old_pmr);
+
 	return val != 0;
 }
 
@@ -580,7 +590,8 @@ static void gic_cpu_sys_reg_init(void)
 	group0 = gic_has_group0();
 
 	/* Set priority mask register */
-	write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
+	if (!arch_uses_gic_prios())
+		write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
 
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
-- 
1.9.1
