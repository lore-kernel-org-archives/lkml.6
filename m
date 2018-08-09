Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D7EC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B811421537
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tu12F64J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B811421537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbeHIKUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:20:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B5aSOAqTV8ZGWLjWdd10TVf0oja9wDqzRp7s8mgOANM=; b=tu12F64JVH+jJ+m02FzR4PaIk
        MXeLCPMqIMoOB/Or+w0nNmjUbxcJtCeQN6B2Rj9RjtLx0w0PCRrHYezi76qVCTLQHqZXMLMMgLUPw
        klj/Xn44Os1+06ygiZq2nAkJY2aJg5epaO9dNGdQhcci8HvYDhw+nJgK5k9a60pJeM23FX2YRGX9M
        Op+hzrd7x4u3HDy9CCHR9abVERXa9oH+0w6fS9Ki7APhpjpIs40NZIxj5025wuVGjpt++WtrL+BwZ
        aCOqrAomfbLbQNrtUxdgZ72t5/3Sv+3eNHRXO1jmAkm1kdn/lsqCiQbV78AwhXv8ei3SWGK8dipqz
        IsDQcsVyw==;
Received: from clnet-b08-202.ikbnet.co.at ([83.175.123.202] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnfnx-00089d-TC; Thu, 09 Aug 2018 07:56:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH v4 3/3] irqchip: add a SiFive PLIC driver
Date:   Thu,  9 Aug 2018 09:56:02 +0200
Message-Id: <20180809075602.989-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809075602.989-1-hch@lst.de>
References: <20180809075602.989-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the SiFive implementation of the RISC-V Platform Level
Interrupt Controller (PLIC).  The PLIC connects global interrupt sources
to the local interrupt controller on each hart.

This driver is based on the driver in the RISC-V tree from Palmer Dabbelt,
but has been almost entirely rewritten since, and includes many fixes
from Atish Patra.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/configs/defconfig      |   1 +
 drivers/irqchip/Kconfig           |  12 ++
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-sifive-plic.c | 259 ++++++++++++++++++++++++++++++
 4 files changed, 273 insertions(+)
 create mode 100644 drivers/irqchip/irq-sifive-plic.c

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 07326466871b..36473d7dbaac 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -76,3 +76,4 @@ CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_SIFIVE_PLIC=y
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e9233db16e03..df345b878ac2 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -372,3 +372,15 @@ config QCOM_PDC
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
 endmenu
+
+config SIFIVE_PLIC
+	bool "SiFive Platform-Level Interrupt Controller"
+	depends on RISCV
+	help
+	   This enables support for the PLIC chip found in SiFive (and
+	   potentially other) RISC-V systems.  The PLIC controls devices
+	   interrupts and connects them to each core's local interrupt
+	   controller.  Aside from timer and software interrupts, all other
+	   interrupt sources are subordinate to the PLIC.
+
+	   If you don't know what to do here, say Y.
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 15f268f646bf..fbd1ec8070ef 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
+obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
new file mode 100644
index 000000000000..298685e56676
--- /dev/null
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 SiFive
+ * Copyright (C) 2018 Christoph Hellwig
+ */
+#define pr_fmt(fmt) "plic: " fmt
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+/*
+ * This driver implements a version of the RISC-V PLIC with the actual layout
+ * specified in chapter 8 of the SiFive U5 Coreplex Series Manual:
+ *
+ *     https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf
+ *
+ * The largest number supported by devices marked as 'riscv,plic0', is 1024, of
+ * which device 0 is defined as non-existent by the RISC-V Privileged Spec.
+ */
+
+#define MAX_DEVICES			1024
+#define MAX_CONTEXTS			15872
+
+/*
+ * Each interrupt source has a priority register associated with it.
+ * We always hardwire it to one in Linux.
+ */
+#define PRIORITY_BASE			0
+#define     PRIORITY_PER_ID		4
+
+/*
+ * Each hart context has a vector of interrupt enable bits associated with it.
+ * There's one bit for each interrupt source.
+ */
+#define ENABLE_BASE			0x2000
+#define     ENABLE_PER_HART		0x80
+
+/*
+ * Each hart context has a set of control registers associated with it.  Right
+ * now there's only two: a source priority threshold over which the hart will
+ * take an interrupt, and a register to claim interrupts.
+ */
+#define CONTEXT_BASE			0x200000
+#define     CONTEXT_PER_HART		0x1000
+#define     CONTEXT_THRESHOLD		0x00
+#define     CONTEXT_CLAIM		0x04
+
+static void __iomem *plic_regs;
+
+struct plic_handler {
+	bool			present;
+	int			ctxid;
+};
+static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
+
+static inline void __iomem *plic_hart_offset(int ctxid)
+{
+	return plic_regs + CONTEXT_BASE + ctxid * CONTEXT_PER_HART;
+}
+
+static inline u32 __iomem *plic_enable_base(int ctxid)
+{
+	return plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART;
+}
+
+/*
+ * Protect mask operations on the registers given that we can't assume that
+ * atomic memory operations work on them.
+ */
+static DEFINE_RAW_SPINLOCK(plic_toggle_lock);
+
+static inline void plic_toggle(int ctxid, int hwirq, int enable)
+{
+	u32 __iomem *reg = plic_enable_base(ctxid) + (hwirq / 32);
+	u32 hwirq_mask = 1 << (hwirq % 32);
+
+	raw_spin_lock(&plic_toggle_lock);
+	if (enable)
+		writel(readl(reg) | hwirq_mask, reg);
+	else
+		writel(readl(reg) & ~hwirq_mask, reg);
+	raw_spin_unlock(&plic_toggle_lock);
+}
+
+static inline void plic_irq_toggle(struct irq_data *d, int enable)
+{
+	int cpu;
+
+	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
+	for_each_cpu(cpu, irq_data_get_affinity_mask(d)) {
+		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
+
+		if (handler->present)
+			plic_toggle(handler->ctxid, d->hwirq, enable);
+	}
+}
+
+static void plic_irq_enable(struct irq_data *d)
+{
+	plic_irq_toggle(d, 1);
+}
+
+static void plic_irq_disable(struct irq_data *d)
+{
+	plic_irq_toggle(d, 0);
+}
+
+static struct irq_chip plic_chip = {
+	.name		= "SiFive PLIC",
+	/*
+	 * There is no need to mask/unmask PLIC interrupts.  They are "masked"
+	 * by reading claim and "unmasked" when writing it back.
+	 */
+	.irq_enable	= plic_irq_enable,
+	.irq_disable	= plic_irq_disable,
+};
+
+static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &plic_chip, handle_simple_irq);
+	irq_set_chip_data(irq, NULL);
+	irq_set_noprobe(irq);
+	return 0;
+}
+
+static const struct irq_domain_ops plic_irqdomain_ops = {
+	.map		= plic_irqdomain_map,
+	.xlate		= irq_domain_xlate_onecell,
+};
+
+static struct irq_domain *plic_irqdomain;
+
+/*
+ * Handling an interrupt is a two-step process: first you claim the interrupt
+ * by reading the claim register, then you complete the interrupt by writing
+ * that source ID back to the same claim register.  This automatically enables
+ * and disables the interrupt, so there's nothing else to do.
+ */
+static void plic_handle_irq(struct pt_regs *regs)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	void __iomem *claim = plic_hart_offset(handler->ctxid) + CONTEXT_CLAIM;
+	irq_hw_number_t hwirq;
+
+	WARN_ON_ONCE(!handler->present);
+
+	csr_clear(sie, SIE_SEIE);
+	while ((hwirq = readl(claim))) {
+		int irq = irq_find_mapping(plic_irqdomain, hwirq);
+
+		if (unlikely(irq <= 0))
+			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
+					hwirq);
+		else
+			generic_handle_irq(irq);
+		writel(hwirq, claim);
+	}
+	csr_set(sie, SIE_SEIE);
+}
+
+/*
+ * Walk up the DT tree until we find an active RISC-V core (HART) node and
+ * extract the cpuid from it.
+ */
+static int plic_find_hart_id(struct device_node *node)
+{
+	for (; node; node = node->parent) {
+		if (of_device_is_compatible(node, "riscv"))
+			return riscv_of_processor_hart(node);
+	}
+
+	return -1;
+}
+
+static int __init plic_init(struct device_node *node,
+		struct device_node *parent)
+{
+	int error = 0, nr_handlers, nr_mapped = 0, i;
+	u32 nr_irqs;
+
+	if (plic_regs) {
+		pr_warn("PLIC already present.\n");
+		return -ENXIO;
+	}
+
+	plic_regs = of_iomap(node, 0);
+	if (WARN_ON(!plic_regs))
+		return -EIO;
+
+	error = -EINVAL;
+	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
+	if (WARN_ON(!nr_irqs))
+		goto out_iounmap;
+
+	nr_handlers = of_irq_count(node);
+	if (WARN_ON(!nr_handlers))
+		goto out_iounmap;
+	if (WARN_ON(nr_handlers < num_possible_cpus()))
+		goto out_iounmap;
+
+	error = -ENOMEM;
+	plic_irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
+			&plic_irqdomain_ops, NULL);
+	if (WARN_ON(!plic_irqdomain))
+		goto out_iounmap;
+
+	for (i = 0; i < nr_handlers; i++) {
+		struct of_phandle_args parent;
+		struct plic_handler *handler;
+		irq_hw_number_t hwirq;
+		int cpu;
+
+		if (of_irq_parse_one(node, i, &parent)) {
+			pr_err("failed to parse parent for context %d.\n", i);
+			continue;
+		}
+
+		/* skip context holes */
+		if (parent.args[0] == -1)
+			continue;
+
+		cpu = plic_find_hart_id(parent.np);
+		if (cpu < 0) {
+			pr_warn("failed to parse hart ID for context %d.\n", i);
+			continue;
+		}
+
+		handler = per_cpu_ptr(&plic_handlers, cpu);
+		handler->present = true;
+		handler->ctxid = i;
+
+		/* priority must be > threshold to trigger an interrupt */
+		writel(0, plic_hart_offset(i) + CONTEXT_THRESHOLD);
+		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
+			plic_toggle(i, hwirq, 0);
+		nr_mapped++;
+	}
+
+	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
+		nr_irqs, nr_mapped, nr_handlers);
+	set_handle_irq(plic_handle_irq);
+	return 0;
+
+out_iounmap:
+	iounmap(plic_regs);
+	return error;
+}
+
+IRQCHIP_DECLARE(sifive_plic, "sifive,plic", plic_init);
+IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
-- 
2.18.0

