Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21FEC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7834B20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7834B20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeJAIMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 04:12:20 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52799 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727656AbeJAIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 04:12:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437523|-1;CH=green;FP=13789597321273297130|1|1|12|0|-1|-1|-1;HT=e02c03291;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.Cy2q0HE_1538357804;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cy2q0HE_1538357804)
          by smtp.aliyun-inc.com(10.147.42.16);
          Mon, 01 Oct 2018 09:36:44 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        daniel.lezcano@linaro.org, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, f.fainelli@gmail.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V9 6/8] irqchip: add C-SKY APB bus interrupt controller
Date:   Mon,  1 Oct 2018 09:36:01 +0800
Message-Id: <3d39aa0dc9b32b0bb36916fbdb4680b1298ac33c.1538355281.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1538355281.git.ren_guo@c-sky.com>
References: <cover.1538355281.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538355281.git.ren_guo@c-sky.com>
References: <cover.1538355281.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - irq-csky-apb-intc is a simple SOC interrupt controller which is
   used in a lot of C-SKY CPU SOC products.

Changelog:
 - use "bool ret" instead of "int ret"
 - add support-pulse-signal in irq-csky-apb-intc.c
 - change name with upstream feed-back
 - add INTC_IFR to clear irq-pending
 - remove CSKY_VECIRQ_LEGENCY
 - change to generic irq chip framework
 - add License and Copyright
 - use irq_domain_add_linear instead of leagcy

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/irqchip/Kconfig             |   8 ++
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-csky-apb-intc.c | 260 ++++++++++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 drivers/irqchip/irq-csky-apb-intc.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 92e1c20..bf12549 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -379,6 +379,14 @@ config CSKY_MPINTC
 	  for C-SKY SMP system. In fact it's not mmio map and it use ld/st
 	  to visit the controller's register inside CPU.
 
+config CSKY_APB_INTC
+	bool "C-SKY APB Interrupt Controller"
+	depends on CSKY
+	help
+	  Say yes here to enable C-SKY APB interrupt controller driver used
+	  by C-SKY single core SOC system. It use mmio map apb-bus to visit
+	  the controller's register.
+
 endmenu
 
 config SIFIVE_PLIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 6b739ea..72eaf53 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -88,4 +88,5 @@ obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
+obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
new file mode 100644
index 0000000..cfe32a7
--- /dev/null
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+
+#define INTC_IRQS		64
+
+#define CK_INTC_ICR		0x00
+#define CK_INTC_PEN31_00	0x14
+#define CK_INTC_PEN63_32	0x2c
+#define CK_INTC_NEN31_00	0x10
+#define CK_INTC_NEN63_32	0x28
+#define CK_INTC_SOURCE		0x40
+#define CK_INTC_DUAL_BASE	0x100
+
+#define GX_INTC_PEN31_00	0x00
+#define GX_INTC_PEN63_32	0x04
+#define GX_INTC_NEN31_00	0x40
+#define GX_INTC_NEN63_32	0x44
+#define GX_INTC_NMASK31_00	0x50
+#define GX_INTC_NMASK63_32	0x54
+#define GX_INTC_SOURCE		0x60
+
+static void __iomem *reg_base;
+static struct irq_domain *root_domain;
+
+static int nr_irq = INTC_IRQS;
+
+/*
+ * When controller support pulse signal, the PEN_reg will hold on signal
+ * without software trigger.
+ *
+ * So, to support pulse signal we need to clear IFR_reg and the address of
+ * IFR_offset is NEN_offset - 8.
+ */
+static void irq_ck_mask_set_bit(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	unsigned long ifr = ct->regs.mask - 8;
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	*ct->mask_cache |= mask;
+	irq_reg_writel(gc, *ct->mask_cache, ct->regs.mask);
+	irq_reg_writel(gc, irq_reg_readl(gc, ifr) & ~mask, ifr);
+	irq_gc_unlock(gc);
+}
+
+static void __init ck_set_gc(struct device_node *node, void __iomem *reg_base,
+			     u32 mask_reg, u32 irq_base)
+{
+	struct irq_chip_generic *gc;
+
+	gc = irq_get_domain_generic_chip(root_domain, irq_base);
+	gc->reg_base = reg_base;
+	gc->chip_types[0].regs.mask = mask_reg;
+	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
+	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
+
+	if (of_find_property(node, "csky,support-pulse-signal", NULL))
+		gc->chip_types[0].chip.irq_unmask = irq_ck_mask_set_bit;
+}
+
+static inline u32 build_channel_val(u32 idx, u32 magic)
+{
+	u32 res;
+
+	/*
+	 * Set the same index for each channel
+	 */
+	res = idx | (idx << 8) | (idx << 16) | (idx << 24);
+
+	/*
+	 * Set the channel magic number in descending order.
+	 * The magic is 0x00010203 for ck-intc
+	 * The magic is 0x03020100 for gx6605s-intc
+	 */
+	return res | magic;
+}
+
+static inline void setup_irq_channel(u32 magic, void __iomem *reg_addr)
+{
+	u32 i;
+
+	/* Setup 64 channel slots */
+	for (i = 0; i < INTC_IRQS; i += 4) {
+		writel_relaxed(build_channel_val(i, magic), reg_addr + i);
+	}
+}
+
+static int __init
+ck_intc_init_comm(struct device_node *node, struct device_node *parent)
+{
+	int ret;
+
+	if (parent) {
+		pr_err("C-SKY Intc not a root irq controller\n");
+		return -EINVAL;
+	}
+
+	reg_base = of_iomap(node, 0);
+	if (!reg_base) {
+		pr_err("C-SKY Intc unable to map: %p.\n", node);
+		return -EINVAL;
+	}
+
+	root_domain = irq_domain_add_linear(node, nr_irq, &irq_generic_chip_ops, NULL);
+	if (!root_domain) {
+		pr_err("C-SKY Intc irq_domain_add failed.\n");
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(root_domain, 32, 1,
+					     "csky_intc", handle_level_irq,
+					     IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN,
+					     0, 0);
+	if (ret) {
+		pr_err("C-SKY Intc irq_alloc_gc failed.\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static inline bool handle_irq_perbit(struct pt_regs *regs, u32 hwirq, u32 irq_base)
+{
+	u32 irq;
+
+	if (hwirq == 0) return 0;
+
+	while (hwirq) {
+		irq = __ffs(hwirq);
+		hwirq &= ~BIT(irq);
+		handle_domain_irq(root_domain, irq_base + irq, regs);
+	}
+
+	return 1;
+}
+
+/* gx6605s 64 irqs interrupt controller */
+static void gx_irq_handler(struct pt_regs *regs)
+{
+	bool ret;
+
+	do {
+		ret  = handle_irq_perbit(regs ,readl_relaxed(reg_base + GX_INTC_PEN31_00), 0);
+		ret |= handle_irq_perbit(regs ,readl_relaxed(reg_base + GX_INTC_PEN63_32), 32);
+	} while(ret);
+}
+
+static int __init
+gx_intc_init(struct device_node *node, struct device_node *parent)
+{
+	int ret;
+
+	ret = ck_intc_init_comm(node, parent);
+	if (ret)
+		return ret;
+
+	/* Initial enable reg to disable all interrupts */
+	writel_relaxed(0x0, reg_base + GX_INTC_NEN31_00);
+	writel_relaxed(0x0, reg_base + GX_INTC_NEN63_32);
+
+	/* Initial mask reg with all unmasked, becasue we only use enalbe reg */
+	writel_relaxed(0x0, reg_base + GX_INTC_NMASK31_00);
+	writel_relaxed(0x0, reg_base + GX_INTC_NMASK63_32);
+
+	setup_irq_channel(0x03020100, reg_base + GX_INTC_SOURCE);
+
+	ck_set_gc(node, reg_base, GX_INTC_NEN31_00, 0);
+	ck_set_gc(node, reg_base, GX_INTC_NEN63_32, 32);
+
+	set_handle_irq(gx_irq_handler);
+
+	return 0;
+}
+IRQCHIP_DECLARE(csky_gx6605s_intc, "csky,gx6605s-intc", gx_intc_init);
+
+/* C-SKY simple 64 irqs interrupt controller, dual-together could support 128 irqs */
+static void ck_irq_handler(struct pt_regs *regs)
+{
+	bool ret;
+
+	do {
+		/* handle 0 - 31 irqs */
+		ret  = handle_irq_perbit(regs, readl_relaxed(reg_base + CK_INTC_PEN31_00), 0);
+		ret |= handle_irq_perbit(regs, readl_relaxed(reg_base + CK_INTC_PEN63_32), 32);
+
+		if (nr_irq == INTC_IRQS) continue;
+
+		/* handle 64 - 127 irqs */
+		ret |= handle_irq_perbit(regs,
+			   readl_relaxed(reg_base + CK_INTC_PEN31_00 + CK_INTC_DUAL_BASE), 64);
+		ret |= handle_irq_perbit(regs,
+			   readl_relaxed(reg_base + CK_INTC_PEN63_32 + CK_INTC_DUAL_BASE), 96);
+	} while(ret);
+}
+
+static int __init
+ck_intc_init(struct device_node *node, struct device_node *parent)
+{
+	int ret;
+
+	ret = ck_intc_init_comm(node, parent);
+	if (ret)
+		return ret;
+
+	/* Initial enable reg to disable all interrupts */
+	writel_relaxed(0, reg_base + CK_INTC_NEN31_00);
+	writel_relaxed(0, reg_base + CK_INTC_NEN63_32);
+
+	/* Enable irq intc */
+	writel_relaxed(BIT(31), reg_base + CK_INTC_ICR);
+
+	ck_set_gc(node, reg_base, CK_INTC_NEN31_00, 0);
+	ck_set_gc(node, reg_base, CK_INTC_NEN63_32, 32);
+
+	setup_irq_channel(0x00010203, reg_base + CK_INTC_SOURCE);
+
+	set_handle_irq(ck_irq_handler);
+
+	return 0;
+}
+IRQCHIP_DECLARE(ck_intc, "csky,apb-intc", ck_intc_init);
+
+static int __init
+ck_dual_intc_init(struct device_node *node, struct device_node *parent)
+{
+	int ret;
+
+	/* dual-apb-intc up to 128 irq sources*/
+	nr_irq = INTC_IRQS * 2;
+
+	ret = ck_intc_init(node, parent);
+	if (ret)
+		return ret;
+
+	/* Initial enable reg to disable all interrupts */
+	writel_relaxed(0, reg_base + CK_INTC_NEN31_00 + CK_INTC_DUAL_BASE);
+	writel_relaxed(0, reg_base + CK_INTC_NEN63_32 + CK_INTC_DUAL_BASE);
+
+	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN31_00, 64);
+	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN63_32, 96);
+
+	setup_irq_channel(0x00010203, reg_base + CK_INTC_SOURCE + CK_INTC_DUAL_BASE);
+
+	return 0;
+}
+IRQCHIP_DECLARE(ck_dual_intc, "csky,dual-apb-intc", ck_dual_intc_init);
-- 
2.7.4

