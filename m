Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF222C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90236208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gsKoB1Eb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nV9KBEet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90236208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbeLDGWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:22:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59468 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbeLDGWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:22:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D3EF612F8; Tue,  4 Dec 2018 06:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543904566;
        bh=7lx9zsTnsxEPmQ/RU01xD6XY9LlU8TDPHAyHhplfmN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsKoB1EbXI0YZ4UZ+B2uB+enLUImF1FW+HRUJZl76DDTsxPNiQxPYOPJ64i+3dMRQ
         Xygpc/sVP1OFJhcnsDDLR4wZu5FSV4Lxipy10KEs1lkyrQ4dAv6ntwoFqHCFtPFTb7
         mrbt2oRdoCk7alcEqpa7wsJdyh40Ewoe2fPPHjRI=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC4B460C4D;
        Tue,  4 Dec 2018 06:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543904564;
        bh=7lx9zsTnsxEPmQ/RU01xD6XY9LlU8TDPHAyHhplfmN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nV9KBEetgjRb+ZILfWHjCWUYx3onlpgQqg+K/kzFttKsG4iSWF29vQqKhp7T6e3Aa
         jt/bzBeBd/ie2OLLq9meKidl2u/nCggb2tvOBsv/Yyy+JZUEaIWPFZSNPpGU+5vHNE
         7t4SjTQxzICp6hAodzDl0JMLZfc+vq5pRqCNcyvE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC4B460C4D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        thor.thayer@linux.intel.com,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v19 2/5] iommu/arm-smmu: Invoke pm_runtime across the driver
Date:   Tue,  4 Dec 2018 11:52:10 +0530
Message-Id: <20181204062213.6875-3-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20181204062213.6875-1-vivek.gautam@codeaurora.org>
References: <20181204062213.6875-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sricharan R <sricharan@codeaurora.org>

Enable pm-runtime on devices that implement a pm domain. Then,
add pm runtime hooks to several iommu_ops to power cycle the
smmu device for explicit TLB invalidation requests, and
register space accesses, etc.
We need these hooks when the smmu, linked to its master through
device links, has to be powered-up without the master device
being in context.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[vivek: Cleanup pm runtime calls]
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes since v18:
 None.

 drivers/iommu/arm-smmu.c | 108 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 602b67d4f2d6..1917d214c4d9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -270,6 +270,20 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
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
@@ -929,11 +943,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
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
@@ -948,6 +966,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
+
+	arm_smmu_rpm_put(smmu);
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -1229,10 +1249,15 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
@@ -1242,49 +1267,74 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
@@ -1299,6 +1349,11 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	u32 tmp;
 	u64 phys;
 	unsigned long va, flags;
+	int ret;
+
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return 0;
 
 	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
 
@@ -1327,6 +1382,8 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 		return 0;
 	}
 
+	arm_smmu_rpm_put(smmu);
+
 	return (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
 }
 
@@ -1431,7 +1488,13 @@ static int arm_smmu_add_device(struct device *dev)
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
 
@@ -1451,7 +1514,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct arm_smmu_master_cfg *cfg;
 	struct arm_smmu_device *smmu;
-
+	int ret;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
@@ -1459,8 +1522,15 @@ static void arm_smmu_remove_device(struct device *dev)
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
@@ -2213,6 +2283,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
@@ -2248,10 +2329,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
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

