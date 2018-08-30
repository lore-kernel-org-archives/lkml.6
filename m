Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AFDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F0D2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F0D2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeH3IMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:12:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:20666 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbeH3IML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:12:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 21:10:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="68959954"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 21:10:54 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [RFC PATCH v2 04/10] iommu/vt-d: Enable/disable multiple domains per device
Date:   Thu, 30 Aug 2018 12:09:16 +0800
Message-Id: <20180830040922.30426-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830040922.30426-1-baolu.lu@linux.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iommu ops for enabling and disabling multiple domains
for a device.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 891ae70e7bf2..3606d25bc40c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2501,6 +2501,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->domain = domain;
 	info->iommu = iommu;
 	info->pasid_table = NULL;
+	info->auxd_enabled = 0;
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -5384,6 +5385,39 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 }
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
+static int intel_iommu_enable_auxd(struct device *dev)
+{
+	struct device_domain_info *info;
+	struct dmar_domain *domain;
+	unsigned long flags;
+
+	if (!scalable_mode_support())
+		return -ENODEV;
+
+	domain = get_valid_domain_for_dev(dev);
+	if (!domain)
+		return -ENODEV;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	info = dev->archdata.iommu;
+	info->auxd_enabled = 1;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return 0;
+}
+
+static void intel_iommu_disable_auxd(struct device *dev)
+{
+	struct device_domain_info *info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	info = dev->archdata.iommu;
+	if (!WARN_ON(!info))
+		info->auxd_enabled = 0;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5398,6 +5432,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= intel_iommu_put_resv_regions,
 	.device_group		= pci_device_group,
+	.enable_auxd		= intel_iommu_enable_auxd,
+	.disable_auxd		= intel_iommu_disable_auxd,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b34cf8b887a0..15981245796e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -487,6 +487,7 @@ struct device_domain_info {
 	u8 pri_enabled:1;
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
+	u8 auxd_enabled:1;	/* Multiple domains per device */
 	u8 ats_qdep;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
-- 
2.17.1

