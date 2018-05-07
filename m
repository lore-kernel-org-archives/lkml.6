Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeEGNh1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:37:27 -0400
Received: from nbd.name ([46.4.11.11]:48184 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeEGNh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:37:26 -0400
From: John Crispin <john@phrozen.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH] irqchip/irq-ath79-intc: add irq cascade driver for QCA9556 SoCs
Date: Mon,  7 May 2018 15:37:14 +0200
Message-Id: <20180507133714.17384-1-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QCA ATH79 MIPS target is being converted to pure OF. Right now the
platform code will setup the IRQ cascade found on the QCA9556 and newer
SoCs and uses fixed IRQ numbers for the peripherals attached to the
cascade. This patch adds a proper driver based on the code previously
located inside arch/mips/ath79/irq.c.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-ath79-intc.c | 108 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 drivers/irqchip/irq-ath79-intc.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d27e3e3619e0..f63c94a92e25 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
 obj-$(CONFIG_ALPINE_MSI)		+= irq-alpine-msi.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
+obj-$(CONFIG_ATH79)			+= irq-ath79-intc.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
diff --git a/drivers/irqchip/irq-ath79-intc.c b/drivers/irqchip/irq-ath79-intc.c
new file mode 100644
index 000000000000..ba15b1ac98b3
--- /dev/null
+++ b/drivers/irqchip/irq-ath79-intc.c
@@ -0,0 +1,108 @@
+/*
+ *  Atheros QCA955X specific interrupt cascade handling
+ *
+ *  Copyright (C) 2018 John Crispin <john@phrozen.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+
+#define ATH79_MAX_INTC_CASCADE	3
+
+struct ath79_intc {
+	struct irq_chip chip;
+	u32 irq;
+	u32 pending_mask;
+	u32 irq_mask[ATH79_MAX_INTC_CASCADE];
+};
+
+static void ath79_intc_irq_handler(struct irq_desc *desc)
+{
+	struct irq_domain *domain = irq_desc_get_handler_data(desc);
+	struct ath79_intc *intc = domain->host_data;
+	u32 pending;
+
+	pending = ath79_reset_rr(QCA955X_RESET_REG_EXT_INT_STATUS);
+	pending &= intc->pending_mask;
+
+	if (pending) {
+		int i;
+
+		for (i = 0; i < domain->hwirq_max; i++)
+			if (pending & intc->irq_mask[i])
+				generic_handle_irq(irq_find_mapping(domain, i));
+	} else {
+		spurious_interrupt();
+	}
+}
+
+static void ath79_intc_irq_unmask(struct irq_data *d)
+{
+}
+
+static void ath79_intc_irq_mask(struct irq_data *d)
+{
+}
+
+static int ath79_intc_map(struct irq_domain *d, unsigned int irq,
+			  irq_hw_number_t hw)
+{
+	struct ath79_intc *intc = d->host_data;
+
+	irq_set_chip_and_handler(irq, &intc->chip, handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops ath79_irq_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = ath79_intc_map,
+};
+
+static int __init qca9556_intc_of_init(
+	struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *domain;
+	struct ath79_intc *intc;
+	int cnt, i;
+
+	cnt = of_property_count_u32_elems(node, "qcom,pending-bits");
+	if (cnt > ATH79_MAX_INTC_CASCADE)
+		panic("Too many INTC pending bits\n");
+
+	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
+	if (!intc)
+		panic("Failed to allocate INTC memory\n");
+	intc->chip.name = "INTC";
+	intc->chip.irq_unmask = ath79_intc_irq_unmask,
+	intc->chip.irq_mask = ath79_intc_irq_mask,
+
+	of_property_read_u32_array(node, "qcom,pending-bits", intc->irq_mask,
+				   cnt);
+	for (i = 0; i < cnt; i++)
+		intc->pending_mask |= intc->irq_mask[i];
+
+	intc->irq = irq_of_parse_and_map(node, 0);
+	if (!intc->irq)
+		panic("Failed to get INTC IRQ");
+
+	domain = irq_domain_add_linear(node, cnt, &ath79_irq_domain_ops,
+				       intc);
+	irq_set_chained_handler_and_data(intc->irq, ath79_intc_irq_handler,
+					 domain);
+
+	return 0;
+}
+IRQCHIP_DECLARE(qca9556_intc, "qcom,qca9556-intc",
+		qca9556_intc_of_init);
-- 
2.11.0
