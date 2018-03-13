Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932511AbeCMRVR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:21:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41994 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbeCMRVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:21:15 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/3] irqchip/gic-v2: Reset APRn registers at boot time
Date: Tue, 13 Mar 2018 17:21:01 +0000
Message-Id: <20180313172103.24281-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180313172103.24281-1-marc.zyngier@arm.com>
References: <20180313172103.24281-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a crash kernel while in an interrupt handler is likely
to leave the Active Priority Registers with some state that
is not relevant to the new kernel, and is likely to lead
to erratic behaviours such as interrupts not firing as their
priority is already active.

As a sanity measure, wipe the APRs clean on startup.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 121af5cf688f..79801c24800b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -453,15 +453,26 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
 	return mask;
 }
 
+static bool gic_check_gicv2(void __iomem *base)
+{
+	u32 val = readl_relaxed(base + GIC_CPU_IDENT);
+	return (val & 0xff0fff) == 0x02043B;
+}
+
 static void gic_cpu_if_up(struct gic_chip_data *gic)
 {
 	void __iomem *cpu_base = gic_data_cpu_base(gic);
 	u32 bypass = 0;
 	u32 mode = 0;
+	int i;
 
 	if (gic == &gic_data[0] && static_key_true(&supports_deactivate))
 		mode = GIC_CPU_CTRL_EOImodeNS;
 
+	if (gic_check_gicv2(cpu_base))
+		for (i = 0; i < 4; i++)
+			writel_relaxed(0, cpu_base + GIC_CPU_ACTIVEPRIO + i * 4);
+
 	/*
 	* Preserve bypass disable bits to be written back later
 	*/
@@ -1264,12 +1275,6 @@ static int __init gicv2_force_probe_cfg(char *buf)
 }
 early_param("irqchip.gicv2_force_probe", gicv2_force_probe_cfg);
 
-static bool gic_check_gicv2(void __iomem *base)
-{
-	u32 val = readl_relaxed(base + GIC_CPU_IDENT);
-	return (val & 0xff0fff) == 0x02043B;
-}
-
 static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
 {
 	struct resource cpuif_res;
-- 
2.14.2
