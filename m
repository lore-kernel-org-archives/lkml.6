Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426239AbeCBKL0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:11:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46928 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426224AbeCBKLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:11:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D46260316
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, robin.murphy@arm.com, will.deacon@arm.com,
        robdclark@gmail.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tfiga@chromium.org, jcrouse@codeaurora.org, sboyd@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        vivek.gautam@codeaurora.org
Subject: [PATCH v8 3/5] iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
Date: Fri,  2 Mar 2018 15:40:48 +0530
Message-Id: <20180302101050.6191-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sricharan R <sricharan@codeaurora.org>

The smmu device probe/remove and add/remove master device callbacks
gets called when the smmu is not linked to its master, that is without
the context of the master device. So calling runtime apis in those places
separately.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[vivek: Cleanup pm runtime calls]
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 96 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c8b16f53f597..3d6a1875431f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -209,6 +209,8 @@ struct arm_smmu_device {
 	struct clk_bulk_data		*clks;
 	int				num_clks;
 
+	bool				rpm_supported;
+
 	u32				cavium_id_base; /* Specific to Cavium */
 
 	spinlock_t			global_sync_lock;
@@ -268,6 +270,20 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+{
+	if (smmu->rpm_supported)
+		return pm_runtime_get_sync(smmu->dev);
+
+	return 0;
+}
+
+static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+{
+	if (smmu->rpm_supported)
+		pm_runtime_put(smmu->dev);
+}
+
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
@@ -913,11 +929,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	int irq;
+	int ret, irq;
 
 	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return;
+
 	/*
 	 * Disable the context bank and free the page tables before freeing
 	 * it.
@@ -932,6 +952,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
+
+	arm_smmu_rpm_put(smmu);
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -1213,10 +1235,15 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -ENODEV;
 
 	smmu = fwspec_smmu(fwspec);
+
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return ret;
+
 	/* Ensure that the domain is finalised */
 	ret = arm_smmu_init_domain_context(domain, smmu);
 	if (ret < 0)
-		return ret;
+		goto rpm_put;
 
 	/*
 	 * Sanity check the domain. We don't support domains across
@@ -1231,10 +1258,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	/* Looks ok, so add the device to the domain */
-	return arm_smmu_domain_add_master(smmu_domain, fwspec);
+	ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
+
+	arm_smmu_rpm_put(smmu);
+
+	return ret;
 
 destroy_domain:
 	arm_smmu_destroy_domain_context(domain);
+rpm_put:
+	arm_smmu_rpm_put(smmu);
+
 	return ret;
 }
 
@@ -1242,22 +1276,36 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int prot)
 {
 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	int ret;
 
 	if (!ops)
 		return -ENODEV;
 
-	return ops->map(ops, iova, paddr, size, prot);
+	arm_smmu_rpm_get(smmu);
+	ret = ops->map(ops, iova, paddr, size, prot);
+	arm_smmu_rpm_put(smmu);
+
+	return ret;
 }
 
 static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			     size_t size)
 {
 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	size_t ret;
 
 	if (!ops)
 		return 0;
 
-	return ops->unmap(ops, iova, size);
+	arm_smmu_rpm_get(smmu);
+	ret = ops->unmap(ops, iova, size);
+	arm_smmu_rpm_put(smmu);
+
+	return ret;
 }
 
 static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
@@ -1412,14 +1460,22 @@ static int arm_smmu_add_device(struct device *dev)
 	while (i--)
 		cfg->smendx[i] = INVALID_SMENDX;
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		goto out_cfg_free;
+
 	ret = arm_smmu_master_alloc_smes(dev);
 	if (ret)
-		goto out_cfg_free;
+		goto out_rpm_put;
 
 	iommu_device_link(&smmu->iommu, dev);
 
+	arm_smmu_rpm_put(smmu);
+
 	return 0;
 
+out_rpm_put:
+	arm_smmu_rpm_put(smmu);
 out_cfg_free:
 	kfree(cfg);
 out_free:
@@ -1432,7 +1488,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct arm_smmu_master_cfg *cfg;
 	struct arm_smmu_device *smmu;
-
+	int ret;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
@@ -1440,8 +1496,15 @@ static void arm_smmu_remove_device(struct device *dev)
 	cfg  = fwspec->iommu_priv;
 	smmu = cfg->smmu;
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return;
+
 	iommu_device_unlink(&smmu->iommu, dev);
 	arm_smmu_master_free_smes(fwspec);
+
+	arm_smmu_rpm_put(smmu);
+
 	iommu_group_remove_device(dev);
 	kfree(fwspec->iommu_priv);
 	iommu_fwspec_free(dev);
@@ -1907,6 +1970,7 @@ struct arm_smmu_match_data {
 	enum arm_smmu_implementation model;
 	const char * const *clks;
 	int num_clks;
+	bool rpm_supported;
 };
 
 #define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
@@ -2029,6 +2093,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	smmu->version = data->version;
 	smmu->model = data->model;
 	smmu->num_clks = data->num_clks;
+	smmu->rpm_supported = data->rpm_supported;
 
 	arm_smmu_fill_clk_data(smmu, data->clks);
 
@@ -2129,6 +2194,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	platform_set_drvdata(pdev, smmu);
+
 	err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
 	if (err)
 		return err;
@@ -2137,6 +2204,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	if (smmu->rpm_supported)
+		pm_runtime_enable(dev);
+
+	err = arm_smmu_rpm_get(smmu);
+	if (err < 0)
+		return err;
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2178,10 +2252,11 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
 
+	arm_smmu_rpm_put(smmu);
+
 	/*
 	 * For ACPI and generic DT bindings, an SMMU will be probed before
 	 * any device which might need it, so we want the bus ops in place
@@ -2217,9 +2292,14 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(&pdev->dev, "removing device with active domains!\n");
 
+	arm_smmu_rpm_get(smmu);
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 
+	arm_smmu_rpm_put(smmu);
+	if (smmu->rpm_supported)
+		pm_runtime_disable(smmu->dev);
+
 	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
 
 	return 0;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
