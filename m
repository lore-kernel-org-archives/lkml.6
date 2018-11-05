Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C5DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E7620827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E7620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbeKEQzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:55:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:47529 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbeKEQzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:55:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 23:37:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="88618116"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga006.jf.intel.com with ESMTP; 04 Nov 2018 23:36:57 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 3/8] iommu/vt-d: Enable/disable multiple domains per device
Date:   Mon,  5 Nov 2018 15:34:03 +0800
Message-Id: <20181105073408.21815-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105073408.21815-1-baolu.lu@linux.intel.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iommu ops for enabling and disabling multiple domains per
device.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 65 ++++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  1 +
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 298f7a3fafe8..2c86ac71c774 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2476,6 +2476,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->domain = domain;
 	info->iommu = iommu;
 	info->pasid_table = NULL;
+	info->auxd_enabled = 0;
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -5353,13 +5354,74 @@ static int intel_iommu_get_dev_attr(struct device *dev,
 				    enum iommu_dev_attr attr, void *data)
 {
 	int ret = 0;
-	bool *auxd_capable;
+	struct device_domain_info *info;
+	bool *auxd_capable, *auxd_enabled;
 
 	switch (attr) {
 	case IOMMU_DEV_ATTR_AUXD_CAPABILITY:
 		auxd_capable = data;
 		*auxd_capable = scalable_mode_support();
 		break;
+	case IOMMU_DEV_ATTR_AUXD_ENABLED:
+		auxd_enabled = data;
+		info = dev->archdata.iommu;
+		*auxd_enabled = info && info->auxd_enabled;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
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
+static int intel_iommu_set_dev_attr(struct device *dev,
+				    enum iommu_dev_attr attr, void *data)
+{
+	int ret = 0;
+
+	switch (attr) {
+	case IOMMU_DEV_ATTR_AUXD_ENABLE:
+		ret = intel_iommu_enable_auxd(dev);
+		break;
+	case IOMMU_DEV_ATTR_AUXD_DISABLE:
+		ret = intel_iommu_disable_auxd(dev);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -5383,6 +5445,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.put_resv_regions	= intel_iommu_put_resv_regions,
 	.device_group		= pci_device_group,
 	.get_dev_attr		= intel_iommu_get_dev_attr,
+	.set_dev_attr		= intel_iommu_set_dev_attr,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d174724e131f..6b198e13e75e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -552,6 +552,7 @@ struct device_domain_info {
 	u8 pri_enabled:1;
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
+	u8 auxd_enabled:1;	/* Multiple domains per device */
 	u8 ats_qdep;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
-- 
2.17.1

