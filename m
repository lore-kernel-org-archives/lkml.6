Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97AAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF0921924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549663566;
	bh=CzpinGmSROMX+pW9hoaV8a4bSbtDnMp1TdI/3QiKmXI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=z8/DI3ZUIUiWfQerLoSx1gCHmru2/SsRNe2UTGNhTCJGTJpA6v8sARtbpiF4KIzEe
	 +/81uMRoilhyH0dqP3KaZc4FFkfb7mzaI9zGY6dz9i1oxeRiO7v/40MUVRZbph0A6N
	 fEY2Ww8vEH6w0wlxfH5DlfVz9fs0j8joXcDvEy4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfBHWGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:06:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfBHWGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:06:04 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F39721908;
        Fri,  8 Feb 2019 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549663562;
        bh=CzpinGmSROMX+pW9hoaV8a4bSbtDnMp1TdI/3QiKmXI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z1Gc2Tj/dYkGdBSidhsaHoNHBTyn8zH032VtgAlDNyKkCp53F2U+HEa3+qIKjIRa8
         Ey6J5N8nGQVXT8SsPSETWuk4uJeH08IvKxetvku6IDq44Z+uIbtGzhjYUzcPEPApIs
         iyjZA43gfYLJpA8JlscJbrERDDcZBY1v2P3eQJUI=
Subject: [PATCH v1 3/7] iommu/vt-d: Use dev_printk() when possible
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 16:06:00 -0600
Message-ID: <154966356075.132359.4070597928540213560.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
 drivers/iommu/intel-iommu.c |   54 +++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2bd9ac285c0d..81077803880f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -19,6 +19,7 @@
  */
 
 #define pr_fmt(fmt)     "DMAR: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
 
 #include <linux/init.h>
 #include <linux/bitmap.h>
@@ -1815,7 +1816,7 @@ static int dmar_init_reserved_ranges(void)
 					    IOVA_PFN(r->start),
 					    IOVA_PFN(r->end));
 			if (!iova) {
-				pr_err("Reserve iova failed\n");
+				pci_err(pdev, "Reserve iova for %pR failed\n", r);
 				return -ENODEV;
 			}
 		}
@@ -2544,8 +2545,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
-			pr_err("PASID table allocation for %s failed\n",
-			       dev_name(dev));
+			dev_err(dev, "PASID table allocation failed\n");
 			dmar_remove_one_dev_info(domain, dev);
 			return NULL;
 		}
@@ -2560,15 +2560,14 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 					dev, PASID_RID2PASID);
 		spin_unlock(&iommu->lock);
 		if (ret) {
-			pr_err("Setup RID2PASID for %s failed\n",
-			       dev_name(dev));
+			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(domain, dev);
 			return NULL;
 		}
 	}
 
 	if (dev && domain_context_mapping(domain, dev)) {
-		pr_err("Domain context map for %s failed\n", dev_name(dev));
+		dev_err(dev, "Domain context map failed\n");
 		dmar_remove_one_dev_info(domain, dev);
 		return NULL;
 	}
@@ -2723,13 +2722,12 @@ static int domain_prepare_identity_map(struct device *dev,
 	   range which is reserved in E820, so which didn't get set
 	   up to start with in si_domain */
 	if (domain == si_domain && hw_pass_through) {
-		pr_warn("Ignoring identity map for HW passthrough device %s [0x%Lx - 0x%Lx]\n",
-			dev_name(dev), start, end);
+		dev_warn(dev, "Ignoring identity map for HW passthrough [0x%Lx - 0x%Lx]\n",
+			 start, end);
 		return 0;
 	}
 
-	pr_info("Setting identity map for device %s [0x%Lx - 0x%Lx]\n",
-		dev_name(dev), start, end);
+	dev_info(dev, "Setting identity map [0x%Lx - 0x%Lx]\n", start, end);
 
 	if (end < start) {
 		WARN(1, "Your BIOS is broken; RMRR ends before it starts!\n"
@@ -3016,8 +3014,8 @@ static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw
 
 	ret = domain_add_dev_info(si_domain, dev);
 	if (!ret)
-		pr_info("%s identity mapping for device %s\n",
-			hw ? "Hardware" : "Software", dev_name(dev));
+		dev_info(dev, "%s identity mapping\n",
+			 hw ? "Hardware" : "Software");
 	else if (ret == -ENODEV)
 		/* device not associated with an iommu */
 		ret = 0;
@@ -3550,8 +3548,7 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
 				   IOVA_PFN(dma_mask), true);
 	if (unlikely(!iova_pfn)) {
-		pr_err("Allocating %ld-page iova for %s failed",
-		       nrpages, dev_name(dev));
+		dev_err(dev, "Allocating %ld-page iova failed", nrpages);
 		return 0;
 	}
 
@@ -3599,7 +3596,7 @@ struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 out:
 
 	if (!domain)
-		pr_err("Allocating domain for %s failed\n", dev_name(dev));
+		dev_err(dev, "Allocating domain failed\n");
 
 
 	return domain;
@@ -3626,8 +3623,7 @@ static int iommu_no_mapping(struct device *dev)
 			 * to non-identity mapping.
 			 */
 			dmar_remove_one_dev_info(si_domain, dev);
-			pr_info("32bit %s uses non-identity mapping\n",
-				dev_name(dev));
+			dev_info(dev, "32bit DMA uses non-identity mapping\n");
 			return 0;
 		}
 	} else {
@@ -3639,8 +3635,7 @@ static int iommu_no_mapping(struct device *dev)
 			int ret;
 			ret = domain_add_dev_info(si_domain, dev);
 			if (!ret) {
-				pr_info("64bit %s uses identity mapping\n",
-					dev_name(dev));
+				dev_info(dev, "64bit DMA uses identity mapping\n");
 				return 1;
 			}
 		}
@@ -3705,8 +3700,8 @@ static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
 error:
 	if (iova_pfn)
 		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
-	pr_err("Device %s request: %zx@%llx dir %d --- failed\n",
-		dev_name(dev), size, (unsigned long long)paddr, dir);
+	dev_err(dev, "Device request: %zx@%llx dir %d --- failed\n",
+		size, (unsigned long long)paddr, dir);
 	return DMA_MAPPING_ERROR;
 }
 
@@ -3741,8 +3736,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	start_pfn = mm_to_dma_pfn(iova_pfn);
 	last_pfn = start_pfn + nrpages - 1;
 
-	pr_debug("Device %s unmapping: pfn %lx-%lx\n",
-		 dev_name(dev), start_pfn, last_pfn);
+	dev_dbg(dev, "Device unmapping: pfn %lx-%lx\n", start_pfn, last_pfn);
 
 	freelist = domain_unmap(domain, start_pfn, last_pfn);
 
@@ -5096,9 +5090,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		addr_width = cap_mgaw(iommu->cap);
 
 	if (dmar_domain->max_addr > (1LL << addr_width)) {
-		pr_err("%s: iommu width (%d) is not "
-		       "sufficient for the mapped address (%llx)\n",
-		       __func__, addr_width, dmar_domain->max_addr);
+		dev_err(dev, "%s: iommu width (%d) is not "
+		        "sufficient for the mapped address (%llx)\n",
+		        __func__, addr_width, dmar_domain->max_addr);
 		return -EFAULT;
 	}
 	dmar_domain->gaw = addr_width;
@@ -5399,7 +5393,7 @@ const struct iommu_ops intel_iommu_ops = {
 static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
 {
 	/* G4x/GM45 integrated gfx dmar support is totally busted. */
-	pr_info("Disabling IOMMU for graphics on this chipset\n");
+	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
 	dmar_map_gfx = 0;
 }
 
@@ -5417,7 +5411,7 @@ static void quirk_iommu_rwbf(struct pci_dev *dev)
 	 * Mobile 4 Series Chipset neglects to set RWBF capability,
 	 * but needs it. Same seems to hold for the desktop versions.
 	 */
-	pr_info("Forcing write-buffer flush capability\n");
+	pci_info(dev, "Forcing write-buffer flush capability\n");
 	rwbf_quirk = 1;
 }
 
@@ -5447,11 +5441,11 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 		return;
 
 	if (!(ggc & GGC_MEMORY_VT_ENABLED)) {
-		pr_info("BIOS has allocated no shadow GTT; disabling IOMMU for graphics\n");
+		pci_info(dev, "BIOS has allocated no shadow GTT; disabling IOMMU for graphics\n");
 		dmar_map_gfx = 0;
 	} else if (dmar_map_gfx) {
 		/* we have to ensure the gfx device is idle before we flush */
-		pr_info("Disabling batched IOTLB flush on Ironlake\n");
+		pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
 		intel_iommu_strict = 1;
        }
 }

