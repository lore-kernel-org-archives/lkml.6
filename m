Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00AAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C788F222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbfBMEIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:08:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:20126 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387830AbfBMEIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 23:08:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 20:08:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,364,1544515200"; 
   d="scan'208";a="117475823"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 12 Feb 2019 20:08:39 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, xin.zeng@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 2/9] iommu/vt-d: Move enable pasid out of CONFIG_INTEL_IOMMU_SVM
Date:   Wed, 13 Feb 2019 12:02:54 +0800
Message-Id: <20190213040301.23021-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213040301.23021-1-baolu.lu@linux.intel.com>
References: <20190213040301.23021-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves intel_iommu_enable_pasid() out of the scope of
CONFIG_INTEL_IOMMU_SVM with more and more features requiring
pasid function.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 22 +++++++---------------
 drivers/iommu/intel-svm.c   | 19 ++++++++++++++++++-
 include/linux/intel-iommu.h |  2 +-
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index af23cfc2a05e..c4e0024c9736 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5295,8 +5295,7 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 	}
 }
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
-int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
+int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 {
 	struct device_domain_info *info;
 	struct context_entry *context;
@@ -5305,7 +5304,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	u64 ctx_lo;
 	int ret;
 
-	domain = get_valid_domain_for_dev(sdev->dev);
+	domain = get_valid_domain_for_dev(dev);
 	if (!domain)
 		return -EINVAL;
 
@@ -5313,7 +5312,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	spin_lock(&iommu->lock);
 
 	ret = -EINVAL;
-	info = sdev->dev->archdata.iommu;
+	info = dev->archdata.iommu;
 	if (!info || !info->pasid_supported)
 		goto out;
 
@@ -5322,15 +5321,13 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 		goto out;
 
 	ctx_lo = context[0].lo;
-
-	sdev->did = domain->iommu_did[iommu->seq_id];
-	sdev->sid = PCI_DEVID(info->bus, info->devfn);
-
 	if (!(ctx_lo & CONTEXT_PASIDE)) {
 		ctx_lo |= CONTEXT_PASIDE;
 		context[0].lo = ctx_lo;
 		wmb();
-		iommu->flush.flush_context(iommu, sdev->did, sdev->sid,
+		iommu->flush.flush_context(iommu,
+					   domain->iommu_did[iommu->seq_id],
+					   PCI_DEVID(info->bus, info->devfn),
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
 	}
@@ -5339,12 +5336,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	if (!info->pasid_enabled)
 		iommu_enable_dev_iotlb(info);
 
-	if (info->ats_enabled) {
-		sdev->dev_iotlb = 1;
-		sdev->qdep = info->ats_qdep;
-		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
-			sdev->qdep = 0;
-	}
 	ret = 0;
 
  out:
@@ -5354,6 +5345,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	return ret;
 }
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
 struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 {
 	struct intel_iommu *iommu;
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index c79540deaf00..ecc255ddf6ae 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -228,6 +228,7 @@ static LIST_HEAD(global_svm_list);
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct device_domain_info *info;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
 	struct mm_struct *mm = NULL;
@@ -291,13 +292,29 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	}
 	sdev->dev = dev;
 
-	ret = intel_iommu_enable_pasid(iommu, sdev);
+	ret = intel_iommu_enable_pasid(iommu, dev);
 	if (ret || !pasid) {
 		/* If they don't actually want to assign a PASID, this is
 		 * just an enabling check/preparation. */
 		kfree(sdev);
 		goto out;
 	}
+
+	info = dev->archdata.iommu;
+	if (!info || !info->pasid_supported) {
+		kfree(sdev);
+		goto out;
+	}
+
+	sdev->did = info->domain->iommu_did[iommu->seq_id];
+	sdev->sid = PCI_DEVID(info->bus, info->devfn);
+	if (info->ats_enabled) {
+		sdev->dev_iotlb = 1;
+		sdev->qdep = info->ats_qdep;
+		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
+			sdev->qdep = 0;
+	}
+
 	/* Finish the setup now we know we're keeping it */
 	sdev->users = 1;
 	sdev->ops = ops;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fa364de9db18..b7d1e2fbb9ca 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -650,6 +650,7 @@ struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
 int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 				     void *data), void *data);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
+int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
@@ -679,7 +680,6 @@ struct intel_svm {
 	struct list_head list;
 };
 
-extern int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev);
 extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
 #endif
 
-- 
2.17.1

