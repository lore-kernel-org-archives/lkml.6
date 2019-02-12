Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E22C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACBE206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MzSRwCjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfBLHoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:44:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40384 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfBLHn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:43:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C7hbmP005402;
        Tue, 12 Feb 2019 01:43:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549957417;
        bh=cLFSJbtEF080CABAE546omquJje2oJ1MPGnKrPKE10E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MzSRwCjLIHj44PNCYsFSVjdaMpRBc/zWKrOukOOz4Tdh5ikj7VlPZ4sA79bX+SG/V
         Y05VkGIIz3F5ph440+JMz5V2FzL6whoD3IxWogKwNlvb/6OUuSpQiUbaj3MfU9g9aP
         VJAI3VDv1WCrGjOdmJiV/cgCLtZvnPISDIM8An20=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C7hbXJ058279
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 01:43:37 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 01:43:37 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 01:43:37 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C7gss5000385;
        Tue, 12 Feb 2019 01:43:33 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <marc.zyngier@arm.com>, Tony Lindgren <tony@atomide.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 09/10] soc: ti: Add MSI domain support for K3 Interrupt Aggregator
Date:   Tue, 12 Feb 2019 13:12:36 +0530
Message-ID: <20190212074237.2875-10-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190212074237.2875-1-lokeshvutla@ti.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
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
- inta_msi_domain_alloc_irqs() that creates MSIs for the
  specified device and source indexes.
- inta_msi_domain_free_irqs() frees the grouped irqs.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v4:
- Dropped support for creating allocation of single MSI.
- Use the existing MSI apis for allocating IRQs

 drivers/soc/ti/Kconfig             |   6 ++
 drivers/soc/ti/Makefile            |   1 +
 drivers/soc/ti/k3_inta_msi.c       | 143 +++++++++++++++++++++++++++++
 include/linux/irqdomain.h          |   1 +
 include/linux/msi.h                |   7 ++
 include/linux/soc/ti/k3_inta_msi.h |  21 +++++
 6 files changed, 179 insertions(+)
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
index 000000000000..ffce1a7541e2
--- /dev/null
+++ b/drivers/soc/ti/k3_inta_msi.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments' K3 Interrupt Aggregator MSI bus
+ *
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
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
+static void inta_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	/* Nothing to do */
+}
+
+static void inta_msi_compose_msi_msg(struct irq_data *data,
+				     struct msi_msg *msg)
+{
+	/* Nothing to do */
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
+static void inta_msi_free_descs(struct device *dev)
+{
+	struct msi_desc *desc, *tmp;
+
+	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
+		list_del(&desc->list);
+		free_msi_entry(desc);
+	}
+}
+
+static int inta_msi_alloc_descs(struct device *dev, u32 dev_id, int nvec,
+				u32 *arr_index, bool share)
+{
+	struct msi_desc *msi_desc;
+	int i;
+
+	for (i = 0; i < nvec; i++) {
+		msi_desc = alloc_msi_entry(dev, 1, NULL);
+		if (!msi_desc)
+			break;
+
+		msi_desc->inta.index = arr_index[i];
+		msi_desc->inta.dev_id = dev_id;
+		msi_desc->inta.share = share;
+		INIT_LIST_HEAD(&msi_desc->list);
+		list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
+	};
+
+	if (i != nvec) {
+		inta_msi_free_descs(dev);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int inta_msi_domain_alloc_irqs(struct device *dev, u32 dev_id, int nvec,
+			       u32 *arr_index, bool share)
+{
+	struct irq_domain *msi_domain;
+	int ret;
+
+	msi_domain = dev_get_msi_domain(dev);
+	if (!msi_domain)
+		return -EINVAL;
+
+	ret = inta_msi_alloc_descs(dev, dev_id, nvec, arr_index, share);
+	if (ret)
+		return ret;
+
+	ret = msi_domain_alloc_irqs(msi_domain, dev, nvec);
+	if (ret) {
+		dev_err(dev, "Failed to allocate IRQs\n");
+		goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	inta_msi_free_descs(dev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(inta_msi_domain_alloc_irqs);
+
+void inta_msi_domain_free_irqs(struct device *dev)
+{
+	msi_domain_free_irqs(dev->msi_domain, dev);
+	inta_msi_free_descs(dev);
+}
+EXPORT_SYMBOL_GPL(inta_msi_domain_free_irqs);
+
+unsigned int inta_msi_get_virq(struct device *dev, u32 dev_id, u32 index)
+{
+	struct msi_desc *desc;
+
+	for_each_msi_entry(desc, dev)
+		if (desc->inta.index == index && desc->inta.dev_id == dev_id)
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
index 784fb52b9900..7e8a8786308e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -47,6 +47,12 @@ struct fsl_mc_msi_desc {
 	u16				msi_index;
 };
 
+struct inta_msi_desc {
+	u16	dev_id;
+	u16	index;
+	bool share;
+};
+
 /**
  * struct msi_desc - Descriptor structure for MSI based interrupts
  * @list:	List head for management
@@ -106,6 +112,7 @@ struct msi_desc {
 		 */
 		struct platform_msi_desc platform;
 		struct fsl_mc_msi_desc fsl_mc;
+		struct inta_msi_desc inta;
 	};
 };
 
diff --git a/include/linux/soc/ti/k3_inta_msi.h b/include/linux/soc/ti/k3_inta_msi.h
new file mode 100644
index 000000000000..7fc8c9946cdc
--- /dev/null
+++ b/include/linux/soc/ti/k3_inta_msi.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Texas Instruments' K3 INTA MSI helper
+ *
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
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
+int inta_msi_domain_alloc_irqs(struct device *dev, u32 dev_id, int nvec,
+			       u32 *arr_index, bool share);
+void inta_msi_domain_free_irqs(struct device *dev);
+unsigned int inta_msi_get_virq(struct device *dev, u32 dev_id, u32 index);
+#endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */
-- 
2.19.2

