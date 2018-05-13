Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeEMOHL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:07:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbeEMOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:07:10 -0400
Date: Sun, 13 May 2018 07:06:56 -0700
From: tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-505287525c24d5c78b662fd73721ad9900b91fcc@git.kernel.org>
Cc: robh@kernel.org, srinivas.kandagatla@linaro.org,
        thomas.petazzoni@bootlin.com, ard.biesheuvel@linaro.org,
        miquel.raynal@bootlin.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, jason@lakedaemon.net,
        hpa@zytor.com, marc.zyngier@arm.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, ard.biesheuvel@linaro.org,
        srinivas.kandagatla@linaro.org, thomas.petazzoni@bootlin.com,
        robh@kernel.org, marc.zyngier@arm.com, hpa@zytor.com,
        jason@lakedaemon.net
In-Reply-To: <20180508121438.11301-8-marc.zyngier@arm.com>
References: <20180508121438.11301-8-marc.zyngier@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] irqchip/gic-v3: Add support for Message Based
 Interrupts as an MSI controller
Git-Commit-ID: 505287525c24d5c78b662fd73721ad9900b91fcc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  505287525c24d5c78b662fd73721ad9900b91fcc
Gitweb:     https://git.kernel.org/tip/505287525c24d5c78b662fd73721ad9900b91fcc
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Tue, 8 May 2018 13:14:36 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:59:01 +0200

irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller

GICv3 offers the possibility to signal SPIs using a pair of doorbells
(SETPI, CLRSPI) under the name of Message Based Interrupts (MBI).
They can be used as either traditional (edge) MSIs, or the more exotic
level-triggered flavour.

Let's implement support for platform MSI, which is the original intent
for this feature.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lkml.kernel.org/r/20180508121438.11301-8-marc.zyngier@arm.com

---
 drivers/irqchip/Makefile           |   2 +-
 drivers/irqchip/irq-gic-v3-mbi.c   | 275 +++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c       |   6 +
 include/linux/irqchip/arm-gic-v3.h |   1 +
 4 files changed, 283 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 5ed465ab1c76..15f268f646bf 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_PM)		+= irq-gic-pm.o
 obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
-obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
+obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+= irq-gic-v3-its-pci-msi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
new file mode 100644
index 000000000000..2b3b767050aa
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 ARM Limited, All Rights Reserved.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#define pr_fmt(fmt) "GICv3: " fmt
+
+#include <linux/dma-iommu.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <linux/irqchip/arm-gic-v3.h>
+
+struct mbi_range {
+	u32			spi_start;
+	u32			nr_spis;
+	unsigned long		*bm;
+};
+
+static struct mutex		mbi_lock;
+static phys_addr_t		mbi_phys_base;
+static struct mbi_range		*mbi_ranges;
+static unsigned int		mbi_range_nr;
+
+static struct irq_chip mbi_irq_chip = {
+	.name			= "MBI",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static int mbi_irq_gic_domain_alloc(struct irq_domain *domain,
+				       unsigned int virq,
+				       irq_hw_number_t hwirq)
+{
+	struct irq_fwspec fwspec;
+	struct irq_data *d;
+	int err;
+
+	/*
+	 * Using ACPI? There is no MBI support in the spec, you
+	 * shouldn't even be here.
+	 */
+	if (!is_of_node(domain->parent->fwnode))
+		return -EINVAL;
+
+	/*
+	 * Let's default to edge. This is consistent with traditional
+	 * MSIs, and systems requiring level signaling will just
+	 * enforce the trigger on their own.
+	 */
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 3;
+	fwspec.param[0] = 0;
+	fwspec.param[1] = hwirq - 32;
+	fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (err)
+		return err;
+
+	d = irq_domain_get_irq_data(domain->parent, virq);
+	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
+}
+
+static void mbi_free_msi(struct mbi_range *mbi, unsigned int hwirq,
+			 int nr_irqs)
+{
+	mutex_lock(&mbi_lock);
+	bitmap_release_region(mbi->bm, hwirq - mbi->spi_start,
+			      get_count_order(nr_irqs));
+	mutex_unlock(&mbi_lock);
+}
+
+static int mbi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *args)
+{
+	struct mbi_range *mbi = NULL;
+	int hwirq, offset, i, err = 0;
+
+	mutex_lock(&mbi_lock);
+	for (i = 0; i < mbi_range_nr; i++) {
+		offset = bitmap_find_free_region(mbi_ranges[i].bm,
+						 mbi_ranges[i].nr_spis,
+						 get_count_order(nr_irqs));
+		if (offset >= 0) {
+			mbi = &mbi_ranges[i];
+			break;
+		}
+	}
+	mutex_unlock(&mbi_lock);
+
+	if (!mbi)
+		return -ENOSPC;
+
+	hwirq = mbi->spi_start + offset;
+
+	for (i = 0; i < nr_irqs; i++) {
+		err = mbi_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
+		if (err)
+			goto fail;
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &mbi_irq_chip, mbi);
+	}
+
+	return 0;
+
+fail:
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	mbi_free_msi(mbi, hwirq, nr_irqs);
+	return err;
+}
+
+static void mbi_irq_domain_free(struct irq_domain *domain,
+				unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct mbi_range *mbi = irq_data_get_irq_chip_data(d);
+
+	mbi_free_msi(mbi, d->hwirq, nr_irqs);
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static const struct irq_domain_ops mbi_domain_ops = {
+	.alloc			= mbi_irq_domain_alloc,
+	.free			= mbi_irq_domain_free,
+};
+
+static void mbi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	msg[0].address_hi = upper_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
+	msg[0].address_lo = lower_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
+	msg[0].data = data->parent_data->hwirq;
+
+	iommu_dma_map_msi_msg(data->irq, msg);
+}
+
+static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	mbi_compose_msi_msg(data, msg);
+
+	msg[1].address_hi = upper_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
+	msg[1].address_lo = lower_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
+	msg[1].data = data->parent_data->hwirq;
+
+	iommu_dma_map_msi_msg(data->irq, &msg[1]);
+}
+
+/* Platform-MSI specific irqchip */
+static struct irq_chip mbi_pmsi_irq_chip = {
+	.name			= "pMSI",
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_compose_msi_msg	= mbi_compose_mbi_msg,
+	.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
+};
+
+static struct msi_domain_ops mbi_pmsi_ops = {
+};
+
+static struct msi_domain_info mbi_pmsi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_LEVEL_CAPABLE),
+	.ops	= &mbi_pmsi_ops,
+	.chip	= &mbi_pmsi_irq_chip,
+};
+
+static int mbi_allocate_domains(struct irq_domain *parent)
+{
+	struct irq_domain *nexus_domain, *plat_domain;
+
+	nexus_domain = irq_domain_create_tree(parent->fwnode,
+					      &mbi_domain_ops, NULL);
+	if (!nexus_domain)
+		return -ENOMEM;
+
+	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
+	nexus_domain->parent = parent;
+
+	plat_domain = platform_msi_create_irq_domain(parent->fwnode,
+						     &mbi_pmsi_domain_info,
+						     nexus_domain);
+
+	if (!plat_domain) {
+		irq_domain_remove(plat_domain);
+		irq_domain_remove(nexus_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
+{
+	struct device_node *np;
+	const __be32 *reg;
+	int ret, n;
+
+	np = to_of_node(fwnode);
+
+	if (!of_property_read_bool(np, "msi-controller"))
+		return 0;
+
+	n = of_property_count_elems_of_size(np, "mbi-ranges", sizeof(u32));
+	if (n <= 0 || n % 2)
+		return -EINVAL;
+
+	mbi_range_nr = n / 2;
+	mbi_ranges = kcalloc(mbi_range_nr, sizeof(*mbi_ranges), GFP_KERNEL);
+	if (!mbi_ranges)
+		return -ENOMEM;
+
+	for (n = 0; n < mbi_range_nr; n++) {
+		ret = of_property_read_u32_index(np, "mbi-ranges", n * 2,
+						 &mbi_ranges[n].spi_start);
+		if (ret)
+			goto err_free_mbi;
+		ret = of_property_read_u32_index(np, "mbi-ranges", n * 2 + 1,
+						 &mbi_ranges[n].nr_spis);
+		if (ret)
+			goto err_free_mbi;
+
+		mbi_ranges[n].bm = kcalloc(BITS_TO_LONGS(mbi_ranges[n].nr_spis),
+					   sizeof(long), GFP_KERNEL);
+		if (!mbi_ranges[n].bm) {
+			ret = -ENOMEM;
+			goto err_free_mbi;
+		}
+		pr_info("MBI range [%d:%d]\n", mbi_ranges[n].spi_start,
+			mbi_ranges[n].spi_start + mbi_ranges[n].nr_spis - 1);
+	}
+
+	reg = of_get_property(np, "mbi-alias", NULL);
+	if (reg) {
+		mbi_phys_base = of_translate_address(np, reg);
+		if (mbi_phys_base == OF_BAD_ADDR) {
+			ret = -ENXIO;
+			goto err_free_mbi;
+		}
+	} else {
+		struct resource res;
+
+		if (of_address_to_resource(np, 0, &res)) {
+			ret = -ENXIO;
+			goto err_free_mbi;
+		}
+
+		mbi_phys_base = res.start;
+	}
+
+	pr_info("Using MBI frame %pa\n", &mbi_phys_base);
+
+	ret = mbi_allocate_domains(parent);
+	if (ret)
+		goto err_free_mbi;
+
+	return 0;
+
+err_free_mbi:
+	if (mbi_ranges) {
+		for (n = 0; n < mbi_range_nr; n++)
+			kfree(mbi_ranges[n].bm);
+		kfree(mbi_ranges);
+	}
+
+	return ret;
+}
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 94164d7b87a6..5a67ec084588 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1113,6 +1113,12 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	pr_info("Distributor has %sRange Selector support\n",
 		gic_data.has_rss ? "" : "no ");
 
+	if (typer & GICD_TYPER_MBIS) {
+		err = mbi_init(handle, gic_data.domain);
+		if (err)
+			pr_err("Failed to initialize MBIs\n");
+	}
+
 	set_handle_irq(gic_handle_irq);
 
 	gic_update_vlpi_properties();
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index f5af3b594e6e..cbb872c1b607 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -587,6 +587,7 @@ struct fwnode_handle;
 int its_cpu_init(void);
 int its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	     struct irq_domain *domain);
+int mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent);
 
 static inline bool gic_enable_sre(void)
 {
