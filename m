Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7A5C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64741214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HAGMAcVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbeL0GOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 01:14:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50422 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbeL0GOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 01:14:39 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBR6E5JJ027150;
        Thu, 27 Dec 2018 00:14:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545891245;
        bh=VeBiPjLQbXNjkK4tTIgPWXLbSnRZFfuHCJ6epqvdbaQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HAGMAcVfJxpXQS5xoGk9Fe2Dsr2ZpKelnBGun1kISAKJcmr+yMdCnBeLfifqh7PEA
         PivyoL4oAs70InNfBQll9AgIt4UqPLRfUJ7EyJJYyrKTijWb5xvjV3wptw2junj3Sq
         2+YLTvGPoLBUvSAbCXlOvZRJ1993opIldpU9brXs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBR6E5mD053225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Dec 2018 00:14:05 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 27
 Dec 2018 00:14:05 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 27 Dec 2018 00:14:05 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBR6DRrG026064;
        Thu, 27 Dec 2018 00:14:02 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [RFC PATCH v4 10/13] soc: ti: Add MSI domain support for K3 Interrupt Aggregator
Date:   Thu, 27 Dec 2018 11:43:10 +0530
Message-ID: <20181227061313.5451-10-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181227061313.5451-1-lokeshvutla@ti.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the system coprocessor managing the range allocation of the
inputs to Interrupt Aggregator, it is difficult to represent
the device IRQs from DT.

The suggestion is to use MSI in such cases where devices wants
to allocate and group interrupts dynamically.

Create a MSI domain bus layer that allocates and frees MSIs for
a device.

APIs that are implemented are:
- inta_msi_create_irq_domain() that creates a MSI domain
- inta_msi_domain_alloc_group_irqs() that creates MSIs for the
  specified device and source indexes. All these are expected to
  be grouped by the parent interrupt controller to MSI domain.
- inta_msi_domain_free_group_irqs() frees the grouped irqs.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---

- May be the same functionaly can be included in platform msi. But I would
  like to get a feedback on the approach.

 drivers/soc/ti/Kconfig             |   6 +
 drivers/soc/ti/Makefile            |   1 +
 drivers/soc/ti/k3_inta_msi.c       | 193 +++++++++++++++++++++++++++++
 include/linux/irqdomain.h          |   1 +
 include/linux/msi.h                |   6 +
 include/linux/soc/ti/k3_inta_msi.h |  22 ++++
 6 files changed, 229 insertions(+)
 create mode 100644 drivers/soc/ti/k3_inta_msi.c
 create mode 100644 include/linux/soc/ti/k3_inta_msi.h

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index be4570baad96..7640490c2a6a 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -73,4 +73,10 @@ config TI_SCI_PM_DOMAINS
 	  called ti_sci_pm_domains. Note this is needed early in boot before
 	  rootfs may be available.
 
+config K3_INTA_MSI_DOMAIN
+	bool
+	select GENERIC_MSI_IRQ_DOMAIN
+	help
+	  Driver to enable Interrupt Aggregator specific MSI Domain.
+
 endif # SOC_TI
diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
index a22edc0b258a..152b195273ee 100644
--- a/drivers/soc/ti/Makefile
+++ b/drivers/soc/ti/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
 obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
 obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
 obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
+obj-$(CONFIG_K3_INTA_MSI_DOMAIN)	+= k3_inta_msi.o
diff --git a/drivers/soc/ti/k3_inta_msi.c b/drivers/soc/ti/k3_inta_msi.c
new file mode 100644
index 000000000000..4658a9f9e1c4
--- /dev/null
+++ b/drivers/soc/ti/k3_inta_msi.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments' K3 Interrupt Aggregator driver MSI support
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ *	Lokesh Vutla <lokeshvutla@ti.com>
+ */
+
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/soc/ti/k3_inta_msi.h>
+
+#ifdef GENERIC_MSI_DOMAIN_OPS
+
+#define TI_SCI_DEV_ID_MASK	0xffff
+#define TI_SCI_DEV_ID_SHIFT	16
+#define TI_SCI_IRQ_ID_MASK	0xffff
+#define TI_SCI_IRQ_ID_SHIFT	0
+
+#define TO_HWIRQ(id, index)	(((id & TI_SCI_DEV_ID_MASK) << \
+				 TI_SCI_DEV_ID_SHIFT) | \
+				(index & TI_SCI_IRQ_ID_MASK))
+static void inta_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = TO_HWIRQ(desc->inta.dev_id, desc->inta.msi_index);
+}
+#else
+#define inta_msi_set_desc NULL
+#endif
+
+static void inta_msi_update_dom_ops(struct msi_domain_info *info)
+{
+	struct msi_domain_ops *ops = info->ops;
+
+	BUG_ON(!ops);
+
+	if (ops->set_desc == NULL)
+		ops->set_desc = inta_msi_set_desc;
+}
+
+static void inta_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
+{
+}
+
+static void inta_msi_compose_msi_msg(struct irq_data *data,
+				     struct msi_msg *msg)
+{
+}
+
+static void inta_msi_update_chip_ops(struct msi_domain_info *info)
+{
+	struct irq_chip *chip = info->chip;
+
+	BUG_ON(!chip);
+	if (!chip->irq_mask)
+		chip->irq_mask = irq_chip_mask_parent;
+	if (!chip->irq_unmask)
+		chip->irq_unmask = irq_chip_unmask_parent;
+	if (!chip->irq_eoi)
+		chip->irq_eoi = irq_chip_eoi_parent;
+	if (!chip->irq_set_affinity)
+		chip->irq_set_affinity = msi_domain_set_affinity;
+	if (!chip->irq_write_msi_msg)
+		chip->irq_write_msi_msg = inta_msi_write_msg;
+	if (!chip->irq_compose_msi_msg)
+		chip->irq_compose_msi_msg = inta_msi_compose_msi_msg;
+}
+
+struct irq_domain *inta_msi_create_irq_domain(struct fwnode_handle *fwnode,
+					      struct msi_domain_info *info,
+					      struct irq_domain *parent)
+{
+	struct irq_domain *domain;
+
+	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
+		inta_msi_update_dom_ops(info);
+	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
+		inta_msi_update_chip_ops(info);
+
+	domain = msi_create_irq_domain(fwnode, info, parent);
+	if (domain)
+		irq_domain_update_bus_token(domain, DOMAIN_BUS_K3_INTA_MSI);
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(inta_msi_create_irq_domain);
+
+static struct msi_desc *inta_msi_alloc_desc(struct device *dev, u32 dev_id,
+					    u32 index)
+{
+	struct msi_desc *msi_desc;
+
+	msi_desc = alloc_msi_entry(dev, 1, NULL);
+	if (!msi_desc) {
+		dev_err(dev, "Failed to allocate msi entry\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	msi_desc->inta.msi_index = index;
+	msi_desc->inta.dev_id = dev_id;
+	INIT_LIST_HEAD(&msi_desc->list);
+	list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
+
+	return msi_desc;
+}
+
+void inta_msi_domain_free_group_irqs(struct device *dev, u32 dev_id,
+				     int nr_irqs, u32 *arr_index)
+{
+	struct irq_domain *msi_domain;
+	struct msi_desc *desc, *tmp;
+	unsigned int i, virq = 0;
+
+	msi_domain = dev_get_msi_domain(dev);
+
+	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
+		for (i = 0; i < nr_irqs; i++) {
+			if (desc->inta.msi_index == arr_index[i] &&
+			    desc->inta.dev_id == dev_id) {
+				msi_domain_free_irq(desc);
+				/* HACK to get parent IRQ. Any elegant solution? */
+				if (!virq)
+					virq = desc->msg.data;
+				list_del(&desc->list);
+				free_msi_entry(desc);
+			}
+		}
+	}
+
+	msi_domain_unprepare_irqs(msi_domain, nr_irqs, (void *)&virq);
+}
+EXPORT_SYMBOL_GPL(inta_msi_domain_free_group_irqs);
+
+int inta_msi_domain_alloc_group_irqs(struct device *dev, u32 dev_id,
+				     int nr_irqs, u32 *arr_index, u32 type)
+{
+	struct irq_domain *msi_domain;
+	struct msi_desc *msi_desc;
+	struct irq_data *irq_data;
+	msi_alloc_info_t arg;
+	int ret, i;
+
+	msi_domain = dev_get_msi_domain(dev);
+	if (!msi_domain)
+		return -EINVAL;
+
+	if (nr_irqs < 1)
+		return -EINVAL;
+
+	ret = msi_domain_prepare_irqs(msi_domain, dev, nr_irqs, &arg);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		msi_desc = inta_msi_alloc_desc(dev, dev_id, arr_index[i]);
+		if (IS_ERR(msi_desc)) {
+			ret = PTR_ERR(msi_desc);
+			goto cleanup;
+		}
+
+		ret = msi_domain_alloc_irq(msi_domain, dev, msi_desc, &arg);
+		if (ret) {
+			dev_err(dev, "Failed to allocate IRQs\n");
+			goto cleanup;
+		}
+		irq_data = irq_get_irq_data(msi_desc->irq);
+		irqd_set_trigger_type(irq_data, type);
+	}
+	return 0;
+
+cleanup:
+	inta_msi_domain_free_group_irqs(dev, dev_id, i, arr_index);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(inta_msi_domain_alloc_group_irqs);
+
+unsigned int inta_msi_get_virq(struct device *dev, u32 dev_id, u32 index)
+{
+	struct msi_desc *desc;
+
+	for_each_msi_entry(desc, dev)
+		if (desc->inta.msi_index == index &&
+		    desc->inta.dev_id == dev_id)
+			return desc->irq;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(inta_msi_get_virq);
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 35965f41d7be..05afb25062cf 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -82,6 +82,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_NEXUS,
 	DOMAIN_BUS_IPI,
 	DOMAIN_BUS_FSL_MC_MSI,
+	DOMAIN_BUS_K3_INTA_MSI,
 };
 
 /**
diff --git a/include/linux/msi.h b/include/linux/msi.h
index f35dd19f6c69..f3b009221241 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -47,6 +47,11 @@ struct fsl_mc_msi_desc {
 	u16				msi_index;
 };
 
+struct inta_msi_desc {
+	u16	dev_id;
+	u16	msi_index;
+};
+
 /**
  * struct msi_desc - Descriptor structure for MSI based interrupts
  * @list:	List head for management
@@ -106,6 +111,7 @@ struct msi_desc {
 		 */
 		struct platform_msi_desc platform;
 		struct fsl_mc_msi_desc fsl_mc;
+		struct inta_msi_desc inta;
 	};
 };
 
diff --git a/include/linux/soc/ti/k3_inta_msi.h b/include/linux/soc/ti/k3_inta_msi.h
new file mode 100644
index 000000000000..9c20fad86930
--- /dev/null
+++ b/include/linux/soc/ti/k3_inta_msi.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Texas Instruments' K3 INTA MSI helper
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ *	Lokesh Vutla <lokeshvutla@ti.com>
+ */
+
+#ifndef __INCLUDE_LINUX_K3_INTA_MSI_H
+#define __INCLUDE_LINUX_K3_INTA_MSI_H
+
+#include <linux/msi.h>
+
+struct irq_domain *inta_msi_create_irq_domain(struct fwnode_handle *fwnode,
+					      struct msi_domain_info *info,
+					      struct irq_domain *parent);
+int inta_msi_domain_alloc_group_irqs(struct device *dev, u32 dev_id,
+				     int nr_irqs, u32 *arr_index, u32 flags);
+void inta_msi_domain_free_group_irqs(struct device *dev, u32 dev_id,
+				     int nr_irqs, u32 *arr_index);
+unsigned int inta_msi_get_virq(struct device *dev, u32 dev_id, u32 index);
+#endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */
-- 
2.19.2

