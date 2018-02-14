Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161142AbeBNRYs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:24:48 -0500
Received: from botnar.kaiser.cx ([176.28.20.183]:51630 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033363AbeBNRYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:24:46 -0500
From: Martin Kaiser <martin@kaiser.cx>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] ARM: imx: avic: set low-power interrupt mask for imx25
Date: Wed, 14 Feb 2018 18:21:33 +0100
Message-Id: <1518628894-8328-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx25 contains two registers (LPIMR0 and 1) to define which interrupts
are enabled in low-power mode. As of today, those two registers are
configured to enable all interrupts. Before going to low-power mode, the
AVIC's INTENABLEH and INTENABLEL registers are configured to enable only
those interrupts which are used as wakeup sources.

It turned out that this approach is not sufficient if we want the imx25
to go into stop mode during suspend-to-ram. (Stop mode is the low-power
mode that consumes the least power. The peripheral master clock is
switched off in this mode). For stop mode to work, the LPIMR0 and 1
registers have to be configured with the set of interrupts that are
allowed in low-power mode. Fortunately, the bits in the LPIMR registers
are assigned to the same interrupts as the bits in INTENABLEH and
INTENABLEL. However, LPIMR uses 1 to mask an interrupt whereas the
INTENABLE registers use 1 to enable an interrupt.

This patch sets the LPIMR registers to the inverted bitmask of the
INTENABLE registers during suspend and goes back to "all interrupts
masked" when we wake up again. We also make this the default at startup.

As far as I know, the other supported imx architectures have no similar
mechanism. Since the LPIMR registers are part of the CCM module, we
query the device tree for an imx25 ccm node in order to detect if we're
running on imx25.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/mach-imx/avic.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 1afccae..0834769 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -22,6 +22,7 @@
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
@@ -51,7 +52,11 @@
 
 #define AVIC_NUM_IRQS 64
 
-static void __iomem *avic_base;
+/* low power interrupt mask registers */
+#define MX25_CCM_LPIMR0	0x68
+#define MX25_CCM_LPIMR1	0x6C
+
+static void __iomem *avic_base, *mx25_ccm_base;
 static struct irq_domain *domain;
 
 #ifdef CONFIG_FIQ
@@ -93,6 +98,17 @@ static void avic_irq_suspend(struct irq_data *d)
 
 	avic_saved_mask_reg[idx] = imx_readl(avic_base + ct->regs.mask);
 	imx_writel(gc->wake_active, avic_base + ct->regs.mask);
+	if (mx25_ccm_base) {
+		u8 offs = d->hwirq < AVIC_NUM_IRQS / 2 ?
+			MX25_CCM_LPIMR0 : MX25_CCM_LPIMR1;
+		/*
+		 * The interrupts which are still enabled will be used as wakeup
+		 * sources. Allow those interrupts in low-power mode.
+		 * The LPIMR registers use 0 to allow an interrupt, the AVIC
+		 * registers use 1.
+		 */
+		imx_writel(~gc->wake_active, mx25_ccm_base + offs);
+	}
 }
 
 static void avic_irq_resume(struct irq_data *d)
@@ -102,6 +118,12 @@ static void avic_irq_resume(struct irq_data *d)
 	int idx = d->hwirq >> 5;
 
 	imx_writel(avic_saved_mask_reg[idx], avic_base + ct->regs.mask);
+	if (mx25_ccm_base) {
+		u8 offs = d->hwirq < AVIC_NUM_IRQS / 2 ?
+			MX25_CCM_LPIMR0 : MX25_CCM_LPIMR1;
+
+		imx_writel(0xffffffff, mx25_ccm_base + offs);
+	}
 }
 
 #else
@@ -158,6 +180,18 @@ void __init mxc_init_irq(void __iomem *irqbase)
 
 	avic_base = irqbase;
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx25-ccm");
+	mx25_ccm_base = of_iomap(np, 0);
+
+	if (mx25_ccm_base) {
+		/*
+		 * By default, we mask all interrupts. We set the actual mask
+		 * before we go into low-power mode.
+		 */
+		imx_writel(0xffffffff, mx25_ccm_base + MX25_CCM_LPIMR0);
+		imx_writel(0xffffffff, mx25_ccm_base + MX25_CCM_LPIMR1);
+	}
+
 	/* put the AVIC into the reset value with
 	 * all interrupts disabled
 	 */
-- 
2.1.4
