Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9565CC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FBD20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FBD20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeGVHHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 03:07:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:37222 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbeGVHHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 03:07:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2018 23:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,388,1526367600"; 
   d="scan'208";a="218015873"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2018 23:11:21 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [RFC PATCH 05/10] iommu/vt-d: Setup DMA remapping for mediated devices
Date:   Sun, 22 Jul 2018 14:09:28 +0800
Message-Id: <1532239773-15325-6-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configures the second level page table when external components
request to allocate a domain for a mediated device.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 73 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 57ccfc4..b6e9ea8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2569,8 +2569,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev)
 		dev->archdata.iommu = info;
 
-	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
-		bool pass_through;
+	if (dev && sm_supported(iommu)) {
+		bool pass_through = hw_pass_through &&
+				domain_type_is_si(domain);
 
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
@@ -2579,12 +2580,21 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 			return NULL;
 		}
 
-		/* Setup the PASID entry for requests without PASID: */
-		pass_through = hw_pass_through && domain_type_is_si(domain);
 		spin_lock(&iommu->lock);
-		intel_pasid_setup_second_level(iommu, domain, dev,
-					       PASID_RID2PASID,
-					       pass_through);
+
+		/* Setup the PASID entry for requests without PASID: */
+		if (dev_is_pci(dev))
+			intel_pasid_setup_second_level(iommu, domain, dev,
+						       PASID_RID2PASID,
+						       pass_through);
+		/* Setup the PASID entry for mediated devices: */
+		else if (dev_is_mdev(dev))
+			intel_pasid_setup_second_level(iommu, domain, dev,
+						       domain->default_pasid,
+						       false);
+		else
+			pr_err("Unsupported device %s\n", dev_name(dev));
+
 		spin_unlock(&iommu->lock);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
@@ -4937,6 +4947,32 @@ static void domain_context_clear(struct intel_iommu *iommu, struct device *dev)
 	pci_for_each_dma_alias(to_pci_dev(dev), &domain_context_clear_one_cb, iommu);
 }
 
+static void
+iommu_flush_ext_iotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 gran)
+{
+	struct qi_desc desc;
+
+	desc.high = 0;
+	desc.low = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
+			QI_EIOTLB_GRAN(gran) | QI_EIOTLB_TYPE;
+
+	qi_submit_sync(&desc, iommu);
+}
+
+static void iommu_flush_pasid_dev_iotlb(struct intel_iommu *iommu,
+					struct device *dev, int sid, int pasid)
+{
+	struct qi_desc desc;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int qdep = pci_ats_queue_depth(pdev);
+
+	desc.low = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
+			QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE;
+	desc.high = QI_DEV_EIOTLB_ADDR(-1ULL >> 1) | QI_DEV_EIOTLB_SIZE;
+
+	qi_submit_sync(&desc, iommu);
+}
+
 static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 {
 	struct intel_iommu *iommu;
@@ -4949,6 +4985,29 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 
 	iommu = info->iommu;
 
+	if (dev_is_mdev(info->dev)) {
+		struct dmar_domain *domain = info->domain;
+		int did = domain->iommu_did[iommu->seq_id];
+		int sid = info->bus << 8 | info->devfn;
+		struct device *dev = info->dev;
+
+		intel_pasid_clear_entry(dev, domain->default_pasid);
+
+		/* Flush IOTLB including PASID Cache: */
+		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+
+		/*
+		 * Flush EIOTLB. The only way to flush global mappings within
+		 * a PASID is to use QI_GRAN_ALL_ALL.
+		 */
+		iommu_flush_ext_iotlb(iommu, did, domain->default_pasid,
+				      QI_GRAN_ALL_ALL);
+
+		/* Flush Dev TLB: */
+		iommu_flush_pasid_dev_iotlb(iommu, dev_mdev_parent(dev), sid,
+					    domain->default_pasid);
+	}
+
 	if (info->dev) {
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(iommu, info->dev);
-- 
2.7.4

