Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFCCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AB121908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549663559;
	bh=RuHAVu0gOCLm5Zf+yBEO8Vvfj1eA87/HOZkE07AZZZc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=RUN917XYq9gvUV4D4R25lDxcPW8OOFAD8g4uTyuzUwK1b7nCT583zRhiLDhiVeqN+
	 mZUFaUCJkGx77sce9+8018SNlMgo5GdYqsFR8G1G4kFmR03+ry306kKhyARg4cny+O
	 6NMtfGe3lxMHQI7vLK0VuJgpg8+XZ8epe7cRZZ2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBHWF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbfBHWF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:05:56 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BC7621908;
        Fri,  8 Feb 2019 22:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549663555;
        bh=RuHAVu0gOCLm5Zf+yBEO8Vvfj1eA87/HOZkE07AZZZc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=K04LPluzi3G5wlTlYQ9F/4eH3/ttfcHWHiC/5o8J4Z89AKurf3xSK0A8s+G5I9Ysa
         0VBc4nI2FAJdSY16iylrn+7mEXfxFr+LIOX7v6r7+ZA74rK1JJ+qikV3HfQYNH5NW1
         jXLgX6San9+Epx01v6vqDHNz/m/PyJ+11ly8uRms=
Subject: [PATCH v1 2/7] iommu/amd: Use dev_printk() when possible
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 16:05:53 -0600
Message-ID: <154966355299.132359.9681240291578714185.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use dev_printk() when possible so the IOMMU messages are more consistent
with other messages related to the device.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/amd_iommu.c      |   25 +++++++++++--------------
 drivers/iommu/amd_iommu_init.c |   20 ++++++++++----------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 87ba23a75b38..fee9c9049d7a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -18,6 +18,7 @@
  */
 
 #define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
 
 #include <linux/ratelimit.h>
 #include <linux/pci.h>
@@ -279,10 +280,10 @@ static u16 get_alias(struct device *dev)
 		return pci_alias;
 	}
 
-	pr_info("Using IVRS reported alias %02x:%02x.%d "
-		"for device %s[%04x:%04x], kernel reported alias "
+	pci_info(pdev, "Using IVRS reported alias %02x:%02x.%d "
+		"for device [%04x:%04x], kernel reported alias "
 		"%02x:%02x.%d\n", PCI_BUS_NUM(ivrs_alias), PCI_SLOT(ivrs_alias),
-		PCI_FUNC(ivrs_alias), dev_name(dev), pdev->vendor, pdev->device,
+		PCI_FUNC(ivrs_alias), pdev->vendor, pdev->device,
 		PCI_BUS_NUM(pci_alias), PCI_SLOT(pci_alias),
 		PCI_FUNC(pci_alias));
 
@@ -293,9 +294,8 @@ static u16 get_alias(struct device *dev)
 	if (pci_alias == devid &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
 		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
-		pr_info("Added PCI DMA alias %02x.%d for %s\n",
-			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias),
-			dev_name(dev));
+		pci_info(pdev, "Added PCI DMA alias %02x.%d\n",
+			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias));
 	}
 
 	return ivrs_alias;
@@ -545,7 +545,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 		dev_data = get_dev_data(&pdev->dev);
 
 	if (dev_data && __ratelimit(&dev_data->rs)) {
-		dev_err(&pdev->dev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
+		pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
 			domain_id, address, flags);
 	} else if (printk_ratelimit()) {
 		pr_err("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
@@ -2251,8 +2251,7 @@ static int amd_iommu_add_device(struct device *dev)
 	ret = iommu_init_device(dev);
 	if (ret) {
 		if (ret != -ENOTSUPP)
-			pr_err("Failed to initialize device %s - trying to proceed anyway\n",
-				dev_name(dev));
+			dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 
 		iommu_ignore_device(dev);
 		dev->dma_ops = NULL;
@@ -2605,8 +2604,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	return nelems;
 
 out_unmap:
-	pr_err("%s: IOMMU mapping error in map_sg (io-pages: %d)\n",
-	       dev_name(dev), npages);
+	dev_err(dev, "IOMMU mapping error in map_sg (io-pages: %d)\n", npages);
 
 	for_each_sg(sglist, s, nelems, i) {
 		int j, pages = iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
@@ -2800,7 +2798,7 @@ static int init_reserved_iova_ranges(void)
 					   IOVA_PFN(r->start),
 					   IOVA_PFN(r->end));
 			if (!val) {
-				pr_err("Reserve pci-resource range failed\n");
+				pci_err(pdev, "Reserve pci-resource range %pR failed\n", r);
 				return -ENOMEM;
 			}
 		}
@@ -3170,8 +3168,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 						 length, prot,
 						 IOMMU_RESV_DIRECT);
 		if (!region) {
-			pr_err("Out of memory allocating dm-regions for %s\n",
-				dev_name(dev));
+			dev_err(dev, "Out of memory allocating dm-regions\n");
 			return;
 		}
 		list_add_tail(&region->list, head);
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 66123b911ec8..f773792d77fd 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -18,6 +18,7 @@
  */
 
 #define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
 
 #include <linux/pci.h>
 #include <linux/acpi.h>
@@ -1457,8 +1458,7 @@ static void amd_iommu_erratum_746_workaround(struct amd_iommu *iommu)
 	pci_write_config_dword(iommu->dev, 0xf0, 0x90 | (1 << 8));
 
 	pci_write_config_dword(iommu->dev, 0xf4, value | 0x4);
-	pr_info("Applying erratum 746 workaround for IOMMU at %s\n",
-		dev_name(&iommu->dev->dev));
+	pci_info(iommu->dev, "Applying erratum 746 workaround\n");
 
 	/* Clear the enable writing bit */
 	pci_write_config_dword(iommu->dev, 0xf0, 0x90);
@@ -1488,8 +1488,7 @@ static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
 	/* Set L2_DEBUG_3[AtsIgnoreIWDis] = 1 */
 	iommu_write_l2(iommu, 0x47, value | BIT(0));
 
-	pr_info("Applying ATS write check workaround for IOMMU at %s\n",
-		dev_name(&iommu->dev->dev));
+	pci_info(iommu->dev, "Applying ATS write check workaround\n");
 }
 
 /*
@@ -1665,6 +1664,7 @@ static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
+	struct pci_dev *pdev = iommu->dev;
 	u64 val = 0xabcd, val2 = 0;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
@@ -1676,12 +1676,12 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
 	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
 	    (val != val2)) {
-		pr_err("Unable to write to IOMMU perf counter.\n");
+		pci_err(pdev, "Unable to write to IOMMU perf counter.\n");
 		amd_iommu_pc_present = false;
 		return;
 	}
 
-	pr_info("IOMMU performance counters supported\n");
+	pci_info(pdev, "IOMMU performance counters supported\n");
 
 	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
 	iommu->max_banks = (u8) ((val >> 12) & 0x3f);
@@ -1840,14 +1840,14 @@ static void print_iommu_info(void)
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
+		struct pci_dev *pdev = iommu->dev;
 		int i;
 
-		pr_info("Found IOMMU at %s cap 0x%hx\n",
-			dev_name(&iommu->dev->dev), iommu->cap_ptr);
+		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
 
 		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
-			pr_info("Extended features (%#llx):\n",
-				iommu->features);
+			pci_info(pdev, "Extended features (%#llx):\n",
+				 iommu->features);
 			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
 				if (iommu_feature(iommu, (1ULL << i)))
 					pr_cont(" %s", feat_str[i]);

