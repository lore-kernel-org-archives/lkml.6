Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B59C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415BA20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tO73A4LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415BA20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeGYKsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:48:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbeGYKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HB3Nzw62Go+iT3Fn+VGKT/KImHQ1FIRkQ9d+R8PHQFA=; b=tO73A4LXE9IBpXdMsn9TnxJ5f
        aEAc8kwS2reZjoQyuUUnMmNsj1l4DrAauzjK4VMBHKKdagO1kTb10lghId7hVIJHyLUKAGU3zITvZ
        KXhZQkWf7IWQ01it2aZQQY2YqnLAsz41+7O0WeXBYjhyQmCbecHF1fo4UfVM1h1dqfoWT0h1yPgwf
        u1rFiRy9ESYLVnighuiWkx/aiujZH9YTpcywCt5NX8blouxWRRmEuh6M9oCLLiIocisje9aGxZFzm
        SrxnqZRri9BO89R68SmBPA3GWNY9e0IHgdQukaHDobTdqazT4/xhre7Fr+slcY4FOMxFcxOjGkTnL
        x3FuI1D/A==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiGEA-0005Gu-R1; Wed, 25 Jul 2018 09:37:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
Date:   Wed, 25 Jul 2018 11:36:46 +0200
Message-Id: <20180725093649.32332-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725093649.32332-1-hch@lst.de>
References: <20180725093649.32332-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@dabbelt.com>

This patch adds a driver that manages the local interrupts on each
RISC-V hart, as specifiec by the RISC-V supervisor level ISA manual.
The local interrupt controller manages software interrupts, timer
interrupts, and hardware interrupts (which are routed via the
platform level interrupt controller).  Per-hart local interrupt
controllers are found on all RISC-V systems.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
[hch: Kconfig simplifications, various cleanups]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/irqchip/Kconfig          |   4 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-riscv-intc.c | 197 +++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-intc.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e9233db16e03..8460fdcecc2c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -372,3 +372,7 @@ config QCOM_PDC
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
 endmenu
+
+config RISCV_INTC
+	def_bool y
+	depends on RISCV
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 15f268f646bf..74e333cc274c 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
+obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
new file mode 100644
index 000000000000..883efaa154b8
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ */
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+#include <asm/sbi.h>
+
+#define NR_RISCV_IRQS (8 * sizeof(uintptr_t))
+
+/*
+ * Possible interrupt causes:
+ */
+#define INTERRUPT_CAUSE_SOFTWARE    1
+#define INTERRUPT_CAUSE_TIMER       5
+#define INTERRUPT_CAUSE_EXTERNAL    9
+
+/*
+ * The high order bit of the trap cause register is always set for
+ * interrupts, which allows us to differentiate them from exceptions
+ * quickly.  The INTERRUPT_CAUSE_* macros don't contain that bit, so we
+ * need to mask it off.
+ */
+#define INTERRUPT_CAUSE_MASK	(1UL << (NR_RISCV_IRQS - 1))
+
+struct riscv_irq_data {
+	struct irq_chip		chip;
+	struct irq_domain	*domain;
+	int			hart;
+	char			name[20];
+};
+
+static DEFINE_PER_CPU(struct riscv_irq_data, riscv_irq_data);
+
+static void riscv_intc_irq(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	unsigned long cause = csr_read(scause);
+	struct irq_domain *domain;
+
+	WARN_ON((cause & INTERRUPT_CAUSE_MASK) == 0);
+	cause &= ~INTERRUPT_CAUSE_MASK;
+
+	irq_enter();
+
+	/*
+	 * There are three classes of interrupt: timer, software, and
+	 * external devices.  We dispatch between them here.  External
+	 * device interrupts use the generic IRQ mechanisms.
+	 */
+	switch (cause) {
+	case INTERRUPT_CAUSE_TIMER:
+		riscv_timer_interrupt();
+		break;
+	case INTERRUPT_CAUSE_SOFTWARE:
+		riscv_software_interrupt();
+		break;
+	default:
+		domain = per_cpu(riscv_irq_data, smp_processor_id()).domain;
+		generic_handle_irq(irq_find_mapping(domain, cause));
+		break;
+	}
+
+	irq_exit();
+	set_irq_regs(old_regs);
+}
+
+static int riscv_irqdomain_map(struct irq_domain *d, unsigned int irq,
+			       irq_hw_number_t hwirq)
+{
+	struct riscv_irq_data *data = d->host_data;
+
+	irq_set_chip_and_handler(irq, &data->chip, handle_simple_irq);
+	irq_set_chip_data(irq, data);
+	irq_set_noprobe(irq);
+	irq_set_affinity(irq, cpumask_of(data->hart));
+	return 0;
+}
+
+static const struct irq_domain_ops riscv_irqdomain_ops = {
+	.map	= riscv_irqdomain_map,
+	.xlate	= irq_domain_xlate_onecell,
+};
+
+/*
+ * On RISC-V systems local interrupts are masked or unmasked by writing the SIE
+ * (Supervisor Interrupt Enable) CSR.  As CSRs can only be written on the local
+ * hart, these functions can only be called on the hart that corresponds to the
+ * IRQ chip.  They are only called internally to this module, so they BUG_ON if
+ * this condition is violated rather than attempting to handle the error by
+ * forwarding to the target hart, as that's already expected to have been done.
+ */
+static void riscv_irq_mask(struct irq_data *d)
+{
+	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
+
+	BUG_ON(smp_processor_id() != data->hart);
+	csr_clear(sie, 1 << d->hwirq);
+}
+
+static void riscv_irq_unmask(struct irq_data *d)
+{
+	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
+
+	BUG_ON(smp_processor_id() != data->hart);
+	csr_set(sie, 1 << d->hwirq);
+}
+
+/* Callbacks for twiddling SIE on another hart. */
+static void riscv_irq_enable_helper(void *d)
+{
+	riscv_irq_unmask(d);
+}
+
+static void riscv_irq_disable_helper(void *d)
+{
+	riscv_irq_mask(d);
+}
+
+static void riscv_remote_ctrl(unsigned int cpu, void (*fn)(void *d),
+			      struct irq_data *data)
+{
+	smp_call_function_single(cpu, fn, data, true);
+}
+
+static void riscv_irq_enable(struct irq_data *d)
+{
+	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
+
+	/*
+	 * It's only possible to write SIE on the current hart.  This jumps
+	 * over to the target hart if it's not the current one.  It's invalid
+	 * to write SIE on a hart that's not currently running.
+	 */
+	if (data->hart == smp_processor_id())
+		riscv_irq_unmask(d);
+	else if (cpu_online(data->hart))
+		riscv_remote_ctrl(data->hart, riscv_irq_enable_helper, d);
+	else
+		WARN_ON_ONCE(1);
+}
+
+static void riscv_irq_disable(struct irq_data *d)
+{
+	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
+
+	/*
+	 * It's only possible to write SIE on the current hart.  This jumps
+	 * over to the target hart if it's not the current one.  It's invalid
+	 * to write SIE on a hart that's not currently running.
+	 */
+	if (data->hart == smp_processor_id())
+		riscv_irq_mask(d);
+	else if (cpu_online(data->hart))
+		riscv_remote_ctrl(data->hart, riscv_irq_disable_helper, d);
+	else
+		WARN_ON_ONCE(1);
+}
+
+static int __init riscv_intc_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	struct riscv_irq_data *data;
+	int hart;
+
+	hart = riscv_of_processor_hart(node->parent);
+	if (hart < 0)
+		return -EIO;
+
+	data = &per_cpu(riscv_irq_data, hart);
+	snprintf(data->name, sizeof(data->name), "riscv,cpu_intc,%d", hart);
+	data->hart = hart;
+	data->chip.name = data->name;
+	data->chip.irq_mask = riscv_irq_mask;
+	data->chip.irq_unmask = riscv_irq_unmask;
+	data->chip.irq_enable = riscv_irq_enable;
+	data->chip.irq_disable = riscv_irq_disable;
+	data->domain = irq_domain_add_linear(node, NR_RISCV_IRQS,
+			&riscv_irqdomain_ops, data);
+	if (!data->domain)
+		goto error_add_linear;
+
+	set_handle_irq(&riscv_intc_irq);
+	pr_info("%s: %lu local interrupts mapped\n", data->name, NR_RISCV_IRQS);
+	return 0;
+
+error_add_linear:
+	pr_warn("%s: unable to add IRQ domain\n", data->name);
+	return -ENXIO;
+}
+
+IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
-- 
2.18.0

