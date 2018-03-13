Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbeCMRVW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:21:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42026 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbeCMRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:21:18 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/3] irqchip/gic-v3: Allow LPIs to be disabled from the command line
Date: Tue, 13 Mar 2018 17:21:03 +0000
Message-Id: <20180313172103.24281-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180313172103.24281-1-marc.zyngier@arm.com>
References: <20180313172103.24281-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For most GICv3 implementations, enabling LPIs is a one way switch.
Once they're on, there is no turning back, which completely kills
kexec (pending tables will always be live, and we can't tell the
secondary kernel where they are).

This is really annoying if you plan to use Linux as a bootloader,
as it pretty much guarantees that the secondary kernel won't be
able to use MSIs, and may even see some memory corruption. Bad.

A workaround for this unfortunate situation is to allow the kernel
not to enable LPIs, even if the feature is present in the HW. This
would allow Linux-as-a-bootloader to leave LPIs alone, and let the
secondary kernel to do whatever it wants with them.

Let's introduce a boolean "irqchip.gicv3_nolpi" command line option
that serves that purpose.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 drivers/irqchip/irq-gic-v3.c                    | 10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f85ddd..60130231db3b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1743,6 +1743,14 @@
 			of a GICv2 controller even if the memory range
 			exposed by the device tree is too small.
 
+	irqchip.gicv3_nolpi=
+			[ARM, ARM64]
+			Force the kernel to ignore the availability of
+			LPIs (and by consequence ITSs). Intended for system
+			that use the kernel as a bootloader, and thus want
+			to let secondary kernels in charge of setting up
+			LPIs.
+
 	irqfixup	[HW]
 			When an interrupt is not handled search all handlers
 			for it. Intended to get systems with badly broken
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0ea02504115d..3e9eeb6cb294 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -613,9 +613,17 @@ static void gic_cpu_sys_reg_init(void)
 		pr_crit_once("RSS is required but GICD doesn't support it\n");
 }
 
+static bool gicv3_nolpi;
+
+static int __init gicv3_nolpi_cfg(char *buf)
+{
+	return strtobool(buf, &gicv3_nolpi);
+}
+early_param("irqchip.gicv3_nolpi", gicv3_nolpi_cfg);
+
 static int gic_dist_supports_lpis(void)
 {
-	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS);
+	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) && !gicv3_nolpi;
 }
 
 static void gic_cpu_init(void)
-- 
2.14.2
