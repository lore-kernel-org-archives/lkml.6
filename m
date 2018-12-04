Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F635C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0244420851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JBYGuptg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0244420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeLDBhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:37:04 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14288 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeLDBhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:37:01 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c05da000001>; Mon, 03 Dec 2018 17:36:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Dec 2018 17:37:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Dec 2018 17:37:00 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 01:37:00 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 01:37:00 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Dec 2018 01:37:00 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c05da3b0003>; Mon, 03 Dec 2018 17:36:59 -0800
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <avanbrunt@nvidia.com>, <thomasz@nvidia.com>,
        <olof@lixom.net>, <jtukkinen@nvidia.com>, <mperttunen@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v3 4/6] iommu/tegra194_smmu: Add Tegra194 SMMU driver
Date:   Mon, 3 Dec 2018 17:36:52 -0800
Message-ID: <1543887414-18209-5-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
References: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543887360; bh=rIZvAC1sl9qfrXg9Xiu6e6JAvlphVijY7Nwk+BRd0cA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=JBYGuptg9aBwS6vOXWfLxcM3t7GpcIwtHYj+PQMRVks2joMZIhscJohjpgWdU7++Z
         94kFeLOHl6ARLqrWALRzVVL+Ry3N22GSydniL73+53YP/3OyoOC4japrORrOmLeHi6
         2rtOsiafHrn8wNSi/DgtLKkHVbnLRpiKj7MogHu4Di3I50LevW6CBRJVpI2kcV5cQY
         d6TntCBeoFL+rJJ/ONyCflLTDGWYKSejdNJW2gHIGiTJ5LNcKj7OVsc9F/b2YFdfyk
         dFsbZ+YG7xbpJwk28LX573t2w6YBfjwCxLn1YbEZByjZE2QEbwOKCI6s+lWW7rTCYT
         6DmzbxOSN/C1Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 SMMU driver supports Dual ARM SMMU configuration
necessary for Tegra194 SOC.
The IOVA accesses from HW devices are interleaved across two
ARM SMMU devices transparently.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/Kconfig         |  11 ++
 drivers/iommu/Makefile        |   1 +
 drivers/iommu/tegra194-smmu.c | 394 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 406 insertions(+)
 create mode 100644 drivers/iommu/tegra194-smmu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d9a2571..2dc08c7 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -357,6 +357,17 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.
 
+config ARM_SMMU_TEGRA
+	bool "Dual ARM SMMU(MMU-500) support on Tegra"
+	depends on ARM64 && MMU && ARCH_TEGRA
+	select IOMMU_API
+	select IOMMU_IO_PGTABLE_LPAE
+	help
+	  Support for implementation of Dual ARM SMMU Instances as single
+	  SMMU Device on Tegra194. IOVA accesses from devices are interleaved
+	  across these two ARM SMMU Instances. Number of ARM SMMU Instances used
+	  in the SMMU device is not known to HW devices.
+
 config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index ea87cae..f1587bb 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU) += lib-arm-smmu.o
+obj-$(CONFIG_ARM_SMMU_TEGRA) += tegra194-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
diff --git a/drivers/iommu/tegra194-smmu.c b/drivers/iommu/tegra194-smmu.c
new file mode 100644
index 0000000..7b21670
--- /dev/null
+++ b/drivers/iommu/tegra194-smmu.c
@@ -0,0 +1,394 @@
+/*
+ * Copyright (c) 2018, NVIDIA Corporation
+ * Author: Krishna Reddy <vdumpa@nvidia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#define pr_fmt(fmt) "tegra194-smmu: " fmt
+
+#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
+#include <linux/atomic.h>
+#include <linux/delay.h>
+#include <linux/dma-iommu.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_iommu.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <linux/amba/bus.h>
+#include <linux/fsl/mc.h>
+
+#include "io-pgtable.h"
+#include "arm-smmu-regs.h"
+#include "lib-arm-smmu.h"
+
+static int force_stage;
+module_param(force_stage, int, S_IRUGO);
+MODULE_PARM_DESC(force_stage,
+	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
+static bool disable_bypass;
+module_param(disable_bypass, bool, S_IRUGO);
+MODULE_PARM_DESC(disable_bypass,
+	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
+
+static struct platform_driver tegra194_smmu_driver;
+static struct iommu_ops tegra194_smmu_ops;
+
+static struct iommu_domain *tegra194_smmu_domain_alloc(unsigned int type)
+{
+	return arm_smmu_domain_alloc_common(type, true);
+}
+
+static int tegra194_smmu_attach_dev(struct iommu_domain *domain,
+				    struct device *dev)
+{
+	return arm_smmu_attach_dev_common(domain, dev, &tegra194_smmu_ops);
+}
+
+static int tegra194_smmu_match_node(struct device *dev, void *data)
+{
+	return dev->fwnode == data;
+}
+
+static
+struct arm_smmu_device *tegra194_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct device *dev = driver_find_device(&tegra194_smmu_driver.driver,
+					NULL, fwnode, tegra194_smmu_match_node);
+	put_device(dev);
+	return dev ? dev_get_drvdata(dev) : NULL;
+}
+
+static int tegra194_smmu_add_device(struct device *dev)
+{
+	struct arm_smmu_device *smmu;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+
+	if (fwspec && fwspec->ops == &tegra194_smmu_ops)
+		smmu = tegra194_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+	else
+		return -ENODEV;
+
+	return arm_smmu_add_device_common(dev, smmu);
+}
+
+static void tegra194_smmu_remove_device(struct device *dev)
+{
+	return arm_smmu_remove_device_common(dev, &tegra194_smmu_ops);
+}
+
+static struct iommu_ops tegra194_smmu_ops = {
+	.capable		= arm_smmu_capable,
+	.domain_alloc		= tegra194_smmu_domain_alloc,
+	.domain_free		= arm_smmu_domain_free,
+	.attach_dev		= tegra194_smmu_attach_dev,
+	.map			= arm_smmu_map,
+	.unmap			= arm_smmu_unmap,
+	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
+	.iotlb_sync		= arm_smmu_iotlb_sync,
+	.iova_to_phys		= arm_smmu_iova_to_phys,
+	.add_device		= tegra194_smmu_add_device,
+	.remove_device		= tegra194_smmu_remove_device,
+	.device_group		= arm_smmu_device_group,
+	.domain_get_attr	= arm_smmu_domain_get_attr,
+	.domain_set_attr	= arm_smmu_domain_set_attr,
+	.of_xlate		= arm_smmu_of_xlate,
+	.get_resv_regions	= arm_smmu_get_resv_regions,
+	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
+};
+
+static int tegra194_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
+{
+	return arm_smmu_device_cfg_probe_common(smmu,
+		&tegra194_smmu_ops, NULL, force_stage);
+}
+
+struct tegra194_smmu_match_data {
+	enum arm_smmu_arch_version version;
+	enum arm_smmu_implementation model;
+};
+
+#define TEGRA194_SMMU_MATCH_DATA(name, ver, imp)	\
+static struct tegra194_smmu_match_data name = { .version = ver, .model = imp }
+
+TEGRA194_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
+
+static const struct of_device_id tegra194_smmu_of_match[] = {
+	{ .compatible = "tegra194,arm,mmu-500", .data = &arm_mmu500 },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tegra194_smmu_of_match);
+
+#ifdef CONFIG_ACPI
+static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
+{
+	int ret = 0;
+
+	switch (model) {
+	case ACPI_IORT_SMMU_CORELINK_MMU500:
+		smmu->version = ARM_SMMU_V2;
+		smmu->model = ARM_MMU500;
+		break;
+	default:
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+
+static int tegra194_smmu_device_acpi_probe(struct platform_device *pdev,
+				      struct arm_smmu_device *smmu)
+{
+	struct device *dev = smmu->dev;
+	struct acpi_iort_node *node =
+		*(struct acpi_iort_node **)dev_get_platdata(dev);
+	struct acpi_iort_smmu *iort_smmu;
+	int ret;
+
+	/* Retrieve SMMU1/2 specific data */
+	iort_smmu = (struct acpi_iort_smmu *)node->node_data;
+
+	ret = acpi_smmu_get_data(iort_smmu->model, smmu);
+	if (ret < 0)
+		return ret;
+
+	/* Ignore the configuration access interrupt */
+	smmu->num_global_irqs = 1;
+
+	if (iort_smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK)
+		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
+
+	return 0;
+}
+#else
+static inline int tegra194_smmu_device_acpi_probe(struct platform_device *pdev,
+					     struct arm_smmu_device *smmu)
+{
+	return -ENODEV;
+}
+#endif
+
+static int tegra194_smmu_device_dt_probe(struct platform_device *pdev,
+				    struct arm_smmu_device *smmu)
+{
+	const struct tegra194_smmu_match_data *data;
+	struct device *dev = &pdev->dev;
+
+	if (of_property_read_u32(dev->of_node, "#global-interrupts",
+				 &smmu->num_global_irqs)) {
+		dev_err(dev, "missing #global-interrupts property\n");
+		return -ENODEV;
+	}
+
+	data = of_device_get_match_data(dev);
+	smmu->version = data->version;
+	smmu->model = data->model;
+
+	if (of_dma_is_coherent(dev->of_node))
+		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
+
+	return 0;
+}
+
+static void tegra194_smmu_bus_init(void)
+{
+	/* Oh, for a proper bus abstraction */
+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type, &tegra194_smmu_ops);
+#ifdef CONFIG_ARM_AMBA
+	if (!iommu_present(&amba_bustype))
+		bus_set_iommu(&amba_bustype, &tegra194_smmu_ops);
+#endif
+#ifdef CONFIG_PCI
+	if (!iommu_present(&pci_bus_type)) {
+		pci_request_acs();
+		bus_set_iommu(&pci_bus_type, &tegra194_smmu_ops);
+	}
+#endif
+#ifdef CONFIG_FSL_MC_BUS
+	if (!iommu_present(&fsl_mc_bus_type))
+		bus_set_iommu(&fsl_mc_bus_type, &tegra194_smmu_ops);
+#endif
+}
+
+static int tegra194_smmu_device_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	resource_size_t ioaddr;
+	struct arm_smmu_device *smmu;
+	struct device *dev = &pdev->dev;
+	int num_irqs, i, err;
+
+	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
+	if (!smmu) {
+		dev_err(dev, "failed to allocate arm_smmu_device\n");
+		return -ENOMEM;
+	}
+	smmu->dev = dev;
+	smmu->num_smmus = 2;
+	smmu->bases = devm_kzalloc(dev, sizeof(*smmu->bases) * smmu->num_smmus,
+				   GFP_KERNEL);
+	if (!smmu->bases)
+		return -ENOMEM;
+
+	if (dev->of_node)
+		err = tegra194_smmu_device_dt_probe(pdev, smmu);
+	else
+		err = tegra194_smmu_device_acpi_probe(pdev, smmu);
+
+	if (err)
+		return err;
+
+	for (i = 0; i < smmu->num_smmus; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		ioaddr = res->start;
+		smmu->bases[i] = devm_ioremap_resource(dev, res);
+		if (IS_ERR(smmu->bases[i]))
+			return PTR_ERR(smmu->bases[i]);
+		if (i == 0) {
+			smmu->base = smmu->bases[i];
+			smmu->cb_base = smmu->base + resource_size(res) / 2;
+		}
+	}
+
+	num_irqs = 0;
+	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
+		num_irqs++;
+		if (num_irqs > smmu->num_global_irqs)
+			smmu->num_context_irqs++;
+	}
+
+	if (!smmu->num_context_irqs) {
+		dev_err(dev, "found %d interrupts but expected at least %d\n",
+			num_irqs, smmu->num_global_irqs + 1);
+		return -ENODEV;
+	}
+
+	smmu->irqs = devm_kcalloc(dev, num_irqs, sizeof(*smmu->irqs),
+				  GFP_KERNEL);
+	if (!smmu->irqs) {
+		dev_err(dev, "failed to allocate %d irqs\n", num_irqs);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_irqs; ++i) {
+		int irq = platform_get_irq(pdev, i);
+
+		if (irq < 0) {
+			dev_err(dev, "failed to get irq index %d\n", i);
+			return -ENODEV;
+		}
+		smmu->irqs[i] = irq;
+	}
+
+	err = tegra194_smmu_device_cfg_probe(smmu);
+	if (err)
+		return err;
+
+	if (smmu->version == ARM_SMMU_V2) {
+		if (smmu->num_context_banks > smmu->num_context_irqs) {
+			dev_err(dev,
+			      "found only %d context irq(s) but %d required\n",
+			      smmu->num_context_irqs, smmu->num_context_banks);
+			return -ENODEV;
+		}
+
+		/* Ignore superfluous interrupts */
+		smmu->num_context_irqs = smmu->num_context_banks;
+	}
+
+	for (i = 0; i < smmu->num_global_irqs; ++i) {
+		err = devm_request_irq(smmu->dev, smmu->irqs[i],
+				       arm_smmu_global_fault,
+				       IRQF_SHARED,
+				       "arm-smmu global fault",
+				       smmu);
+		if (err) {
+			dev_err(dev, "failed to request global IRQ %d (%u)\n",
+				i, smmu->irqs[i]);
+			return err;
+		}
+	}
+
+	err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
+				     "smmu.%pa", &ioaddr);
+	if (err) {
+		dev_err(dev, "Failed to register iommu in sysfs\n");
+		return err;
+	}
+
+	iommu_device_set_ops(&smmu->iommu, &tegra194_smmu_ops);
+	iommu_device_set_fwnode(&smmu->iommu, dev->fwnode);
+
+	err = iommu_device_register(&smmu->iommu);
+	if (err) {
+		dev_err(dev, "Failed to register iommu\n");
+		return err;
+	}
+
+	platform_set_drvdata(pdev, smmu);
+	arm_smmu_device_reset(smmu);
+	arm_smmu_test_smr_masks(smmu);
+
+	/*
+	 * For ACPI and generic DT bindings, an SMMU will be probed before
+	 * any device which might need it, so we want the bus ops in place
+	 * ready to handle default domain setup as soon as any SMMU exists.
+	 */
+	tegra194_smmu_bus_init();
+
+	return 0;
+}
+
+static void tegra194_smmu_device_shutdown(struct platform_device *pdev)
+{
+	arm_smmu_device_remove(pdev);
+}
+
+static int __maybe_unused tegra194_smmu_pm_resume(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	arm_smmu_device_reset(smmu);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tegra194_smmu_pm_ops, NULL, tegra194_smmu_pm_resume);
+
+static struct platform_driver tegra194_smmu_driver = {
+	.driver	= {
+		.name		= "tegra194-smmu",
+		.of_match_table	= of_match_ptr(tegra194_smmu_of_match),
+		.pm		= &tegra194_smmu_pm_ops,
+	},
+	.probe	= tegra194_smmu_device_probe,
+	.remove	= arm_smmu_device_remove,
+	.shutdown = tegra194_smmu_device_shutdown,
+};
+module_platform_driver(tegra194_smmu_driver);
+
+MODULE_DESCRIPTION("Tegra194 SMMU Driver");
+MODULE_AUTHOR("Krishna Reddy <vdumpa@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

