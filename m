Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11934C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A525A206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TI/EZA3F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GctS6vfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A525A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJBNyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:54:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeJBNyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:54:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2D2A760C65; Tue,  2 Oct 2018 07:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538464378;
        bh=ggyTXjo+P0ftCf/XJz+SZ63OlHvrN/TxTPtpdPHPuGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TI/EZA3F4+cTnj2d7Vi/j3MiRVBL5dEnE+3XstIaL3cBcfDb9mWsBxzNgomcucHAY
         NGgz8GxXWe2YpevvMf3m5N+8/IURik/si5nOikhQ+1u4XvX4SlnaCeHBFhnByNSPA6
         bpjRoP9koEr6Zm6fYR17o+r/+4ug2wGkrKAIZes8=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1D0F60C1D;
        Tue,  2 Oct 2018 07:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538464376;
        bh=ggyTXjo+P0ftCf/XJz+SZ63OlHvrN/TxTPtpdPHPuGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GctS6vfTkl2Afbt+k0gVPsZzT9Yzkh457aNxwCgZtnWICzJ57nsoTRsnt1mv92FgJ
         pJphEyHwPJvNxEwoslw9HpXWbRu7P2mJca8Rk5xQ7OkXWyfW2Fe+qztXr6Brx+SYEt
         CkG/JvOe9m1Y2H2N0YlQWh1SF1GzZvBrc//+kv50=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1D0F60C1D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, rjw@rjwysocki.net,
        robin.murphy@arm.com, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        robdclark@gmail.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, freedreno@lists.freedesktop.org,
        sboyd@kernel.org, tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v17 2/5] iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
Date:   Tue,  2 Oct 2018 12:42:31 +0530
Message-Id: <20181002071231.9787-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <CAFp+6iFpm05Uu8HkYCC+O+gYwFwvxirc6=e6oOed+ZJk6QLDPw@mail.gmail.com>
References: <CAFp+6iFpm05Uu8HkYCC+O+gYwFwvxirc6=e6oOed+ZJk6QLDPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sricharan R <sricharan@codeaurora.org>

The smmu device probe/remove and add/remove master device callbacks
gets called when the smmu is not linked to its master, that is without
the context of the master device. So calling runtime apis in those places
separately.
Global locks are also initialized before enabling runtime pm as the
runtime_resume() calls device_reset() which does tlb_sync_global()
that ultimately requires locks to be initialized.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[vivek: Cleanup pm runtime calls]
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes since v16:
 - Rebased on Will's tree for arm-smmu updates [1].
 - Added rpm{get|put} calls to .flush_iotlb_all, and .iotlb_sync
   callbacks to take care of non-strict tlb flush queue updates.

 drivers/iommu/arm-smmu.c | 101 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 59d1430a9f2d..bf106688ab7a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -269,6 +269,20 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+{
+	if (pm_runtime_enabled(smmu->dev))
+		return pm_runtime_get_sync(smmu->dev);
+
+	return 0;
+}
+
+static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+{
+	if (pm_runtime_enabled(smmu->dev))
+		pm_runtime_put(smmu->dev);
+}
+
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
@@ -928,11 +942,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
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
@@ -947,6 +965,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
+
+	arm_smmu_rpm_put(smmu);
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -1228,10 +1248,15 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
@@ -1241,49 +1266,74 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		dev_err(dev,
 			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
 			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto rpm_put;
 	}
 
 	/* Looks ok, so add the device to the domain */
-	return arm_smmu_domain_add_master(smmu_domain, fwspec);
+	ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
+
+rpm_put:
+	arm_smmu_rpm_put(smmu);
+	return ret;
 }
 
 static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int prot)
 {
 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
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
+	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
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
 
 static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (smmu_domain->tlb_ops)
+	if (smmu_domain->tlb_ops) {
+		arm_smmu_rpm_get(smmu);
 		smmu_domain->tlb_ops->tlb_flush_all(smmu_domain);
+		arm_smmu_rpm_put(smmu);
+	}
 }
 
 static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (smmu_domain->tlb_ops)
+	if (smmu_domain->tlb_ops) {
+		arm_smmu_rpm_get(smmu);
 		smmu_domain->tlb_ops->tlb_sync(smmu_domain);
+		arm_smmu_rpm_put(smmu);
+	}
 }
 
 static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
@@ -1430,7 +1480,13 @@ static int arm_smmu_add_device(struct device *dev)
 	while (i--)
 		cfg->smendx[i] = INVALID_SMENDX;
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		goto out_cfg_free;
+
 	ret = arm_smmu_master_alloc_smes(dev);
+	arm_smmu_rpm_put(smmu);
+
 	if (ret)
 		goto out_cfg_free;
 
@@ -1450,7 +1506,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct arm_smmu_master_cfg *cfg;
 	struct arm_smmu_device *smmu;
-
+	int ret;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
@@ -1458,8 +1514,15 @@ static void arm_smmu_remove_device(struct device *dev)
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
@@ -2225,6 +2288,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
 
+	/*
+	 * We want to avoid touching dev->power.lock in fastpaths unless
+	 * it's really going to do something useful - pm_runtime_enabled()
+	 * can serve as an ideal proxy for that decision. So, conditionally
+	 * enable pm_runtime.
+	 */
+	if (dev->pm_domain) {
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
+
 	/*
 	 * For ACPI and generic DT bindings, an SMMU will be probed before
 	 * any device which might need it, so we want the bus ops in place
@@ -2260,10 +2334,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(&pdev->dev, "removing device with active domains!\n");
 
+	arm_smmu_rpm_get(smmu);
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	arm_smmu_rpm_put(smmu);
+
+	if (pm_runtime_enabled(smmu->dev))
+		pm_runtime_force_suspend(smmu->dev);
+	else
+		clk_bulk_disable(smmu->num_clks, smmu->clks);
 
-	clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
+	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
 
 	return 0;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

