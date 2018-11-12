Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDD4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4471E21722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4471E21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbeKLQkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:40:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:53355 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbeKLQkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:40:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2018 22:48:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,494,1534834800"; 
   d="scan'208";a="88579722"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2018 22:48:07 -0800
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
Subject: [RFC PATCH 5/5] iommu/vt-d: Use global pasid allocator
Date:   Mon, 12 Nov 2018 14:45:01 +0800
Message-Id: <20181112064501.2290-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112064501.2290-1-baolu.lu@linux.intel.com>
References: <20181112064501.2290-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses global pasid allocator in the Intel iommu driver.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 20 +++++++++++++++-----
 drivers/iommu/intel-pasid.c | 36 ------------------------------------
 drivers/iommu/intel-pasid.h |  3 ---
 drivers/iommu/intel-svm.c   | 24 +++++++++++++-----------
 include/linux/intel-iommu.h |  3 +++
 5 files changed, 31 insertions(+), 55 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8dbd0c601dab..e15b81afcbbc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1698,7 +1698,11 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
 	}
+
+	iommu_pasid_exit(iommu->svm_pasid);
 #endif
+
+	iommu_pasid_exit(iommu->aux_pasid);
 }
 
 static struct dmar_domain *alloc_domain(int flags)
@@ -5050,7 +5054,7 @@ static void auxiliary_unlink_device(struct dmar_domain *domain,
 	domain->auxd_refcnt--;
 
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		intel_pasid_free_id(domain->default_pasid);
+		iommu_pasid_free(info->iommu->aux_pasid, domain->default_pasid);
 }
 
 static int domain_add_dev_auxd(struct dmar_domain *domain,
@@ -5067,9 +5071,10 @@ static int domain_add_dev_auxd(struct dmar_domain *domain,
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	if (domain->default_pasid <= 0) {
-		domain->default_pasid = intel_pasid_alloc_id(domain, PASID_MIN,
-				pci_max_pasids(to_pci_dev(dev)), GFP_ATOMIC);
-		if (domain->default_pasid < 0) {
+		ret = iommu_pasid_alloc(iommu->aux_pasid, PASID_MIN,
+					pci_max_pasids(to_pci_dev(dev)),
+					domain, &domain->default_pasid);
+		if (ret) {
 			pr_err("Can't allocate default pasid\n");
 			ret = -ENODEV;
 			goto pasid_failed;
@@ -5099,7 +5104,7 @@ static int domain_add_dev_auxd(struct dmar_domain *domain,
 attach_failed:
 	spin_unlock(&iommu->lock);
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		intel_pasid_free_id(domain->default_pasid);
+		iommu_pasid_free(iommu->aux_pasid, domain->default_pasid);
 pasid_failed:
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
@@ -5525,6 +5530,7 @@ static int intel_iommu_enable_auxd(struct device *dev)
 {
 	struct device_domain_info *info;
 	struct dmar_domain *domain;
+	struct intel_iommu *iommu;
 	unsigned long flags;
 
 	if (!scalable_mode_support())
@@ -5539,6 +5545,10 @@ static int intel_iommu_enable_auxd(struct device *dev)
 	info->auxd_enabled = 1;
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
+	iommu = info->iommu;
+	if (!iommu->aux_pasid)
+		iommu->aux_pasid = iommu_pasid_init(&pci_bus_type);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index fb42f0c2493e..68eaef3bd4fd 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -26,7 +26,6 @@
  */
 static DEFINE_SPINLOCK(pasid_lock);
 u32 intel_pasid_max_id = PASID_MAX;
-static DEFINE_IDR(pasid_idr);
 
 int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
 {
@@ -98,41 +97,6 @@ void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
 	}
 }
 
-int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
-{
-	int ret, min, max;
-
-	min = max_t(int, start, PASID_MIN);
-	max = min_t(int, end, intel_pasid_max_id);
-
-	WARN_ON(in_interrupt());
-	idr_preload(gfp);
-	spin_lock(&pasid_lock);
-	ret = idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
-	spin_unlock(&pasid_lock);
-	idr_preload_end();
-
-	return ret;
-}
-
-void intel_pasid_free_id(int pasid)
-{
-	spin_lock(&pasid_lock);
-	idr_remove(&pasid_idr, pasid);
-	spin_unlock(&pasid_lock);
-}
-
-void *intel_pasid_lookup_id(int pasid)
-{
-	void *p;
-
-	spin_lock(&pasid_lock);
-	p = idr_find(&pasid_idr, pasid);
-	spin_unlock(&pasid_lock);
-
-	return p;
-}
-
 /*
  * Per device pasid table management:
  */
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index c80787d02e2d..029f82ce9f4a 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -60,9 +60,6 @@ struct pasid_table {
 };
 
 extern u32 intel_pasid_max_id;
-int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
-void intel_pasid_free_id(int pasid);
-void *intel_pasid_lookup_id(int pasid);
 int intel_pasid_alloc_table(struct device *dev);
 void intel_pasid_free_table(struct device *dev);
 struct pasid_table *intel_pasid_get_table(struct device *dev);
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 27cf1963207d..bb57a024eae7 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -261,6 +261,9 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		BUG_ON(!mm);
 	}
 
+	if (!iommu->svm_pasid)
+		iommu->svm_pasid = iommu_pasid_init(&pci_bus_type);
+
 	mutex_lock(&pasid_mutex);
 	if (pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
 		struct intel_svm *t;
@@ -325,15 +328,14 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 			pasid_max = intel_pasid_max_id;
 
 		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
-		ret = intel_pasid_alloc_id(svm,
-					   !!cap_caching_mode(iommu->cap),
-					   pasid_max - 1, GFP_KERNEL);
-		if (ret < 0) {
+		ret = iommu_pasid_alloc(iommu->svm_pasid,
+					!!cap_caching_mode(iommu->cap),
+					pasid_max - 1, svm, &svm->pasid);
+		if (ret) {
 			kfree(svm);
 			kfree(sdev);
 			goto out;
 		}
-		svm->pasid = ret;
 		svm->notifier.ops = &intel_mmuops;
 		svm->mm = mm;
 		svm->flags = flags;
@@ -343,7 +345,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				intel_pasid_free_id(svm->pasid);
+				iommu_pasid_free(iommu->svm_pasid, svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -356,7 +358,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			intel_pasid_free_id(svm->pasid);
+			iommu_pasid_free(iommu->svm_pasid, svm->pasid);
 			kfree(svm);
 			kfree(sdev);
 			goto out;
@@ -389,7 +391,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!iommu)
 		goto out;
 
-	svm = intel_pasid_lookup_id(pasid);
+	svm = iommu_pasid_find(iommu->svm_pasid, pasid);
 	if (!svm)
 		goto out;
 
@@ -411,7 +413,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 				kfree_rcu(sdev, rcu);
 
 				if (list_empty(&svm->devs)) {
-					intel_pasid_free_id(svm->pasid);
+					iommu_pasid_free(iommu->svm_pasid, svm->pasid);
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
 
@@ -446,7 +448,7 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 	if (!iommu)
 		goto out;
 
-	svm = intel_pasid_lookup_id(pasid);
+	svm = iommu_pasid_find(iommu->svm_pasid, pasid);
 	if (!svm)
 		goto out;
 
@@ -545,7 +547,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 		if (!svm || svm->pasid != req->pasid) {
 			rcu_read_lock();
-			svm = intel_pasid_lookup_id(req->pasid);
+			svm = iommu_pasid_find(iommu->svm_pasid, req->pasid);
 			/* It *can't* go away, because the driver is not permitted
 			 * to unbind the mm while any page faults are outstanding.
 			 * So we only need RCU to protect the internal idr code. */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4605eef3686c..d79f99388293 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -552,6 +552,7 @@ struct intel_iommu {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	struct iommu_pasid *svm_pasid;	/* SVM PASID consumer */
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
@@ -564,6 +565,8 @@ struct intel_iommu {
 	struct iommu_device iommu;  /* IOMMU core code handle */
 	int		node;
 	u32		flags;      /* Software defined flags */
+
+	struct iommu_pasid *aux_pasid; /* Aux-domain pasid consumer */
 };
 
 /* PCI domain-device relationship */
-- 
2.17.1

