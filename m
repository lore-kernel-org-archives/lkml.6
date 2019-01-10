Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65BEC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8114C21738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfAJDEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:04:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:11615 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfAJDEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:04:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 19:04:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,459,1539673200"; 
   d="scan'208";a="115608387"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2019 19:04:48 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, Zeng@vger.kernel.org,
        Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 2/8] iommu/vt-d: Add per-device IOMMU feature ops entries
Date:   Thu, 10 Jan 2019 11:00:21 +0800
Message-Id: <20190110030027.31447-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110030027.31447-1-baolu.lu@linux.intel.com>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the iommu ops entries for aux-domain per-device
feature query and enable/disable.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 86 +++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  1 +
 2 files changed, 87 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2bd9ac285c0d..ee8832d26f7e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2481,6 +2481,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->domain = domain;
 	info->iommu = iommu;
 	info->pasid_table = NULL;
+	info->auxd_enabled = 0;
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -5215,6 +5216,24 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
+static inline bool scalable_mode_support(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	bool ret = true;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!sm_supported(iommu)) {
+			ret = false;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static bool intel_iommu_capable(enum iommu_cap cap)
 {
 	if (cap == IOMMU_CAP_CACHE_COHERENCY)
@@ -5379,6 +5398,70 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
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
+static int intel_iommu_disable_auxd(struct device *dev)
+{
+	struct device_domain_info *info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	info = dev->archdata.iommu;
+	if (!WARN_ON(!info))
+		info->auxd_enabled = 0;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return 0;
+}
+
+static bool
+intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	struct device_domain_info *info = dev->archdata.iommu;
+
+	if (feat == IOMMU_DEV_FEAT_AUX)
+		return scalable_mode_support() && info && info->auxd_enabled;
+
+	return false;
+}
+
+static int
+intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	if (feat == IOMMU_DEV_FEAT_AUX)
+		return intel_iommu_enable_auxd(dev);
+
+	return -ENODEV;
+}
+
+static int
+intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	if (feat == IOMMU_DEV_FEAT_AUX)
+		return intel_iommu_disable_auxd(dev);
+
+	return -ENODEV;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5393,6 +5476,9 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= intel_iommu_put_resv_regions,
 	.device_group		= pci_device_group,
+	.dev_has_feat		= intel_iommu_dev_has_feat,
+	.dev_enable_feat	= intel_iommu_dev_enable_feat,
+	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 0605f3bf6e79..7cf9f7f3724a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -571,6 +571,7 @@ struct device_domain_info {
 	u8 pri_enabled:1;
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
+	u8 auxd_enabled:1;	/* Multiple domains per device */
 	u8 ats_qdep;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
-- 
2.17.1

