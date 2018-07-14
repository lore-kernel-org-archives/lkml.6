Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAF5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008F5208A3
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008F5208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeGNIPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 04:15:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:11970 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbeGNIPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 04:15:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2018 00:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,351,1526367600"; 
   d="scan'208";a="54966328"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2018 00:57:08 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 2/9] iommu/vt-d: Avoid using idr_for_each_entry()
Date:   Sat, 14 Jul 2018 15:46:55 +0800
Message-Id: <1531554422-6874-3-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
References: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_for_each_entry() is used to iteratte over idr elements
of a given type. It isn't suitable for the globle pasid idr
since the pasid idr consumer could specify different types
of pointers to bind with a pasid.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-svm.c   | 14 ++++++++++----
 include/linux/intel-iommu.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 2cc0aac..36cc1d1 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -298,6 +298,7 @@ static const struct mmu_notifier_ops intel_mmuops = {
 };
 
 static DEFINE_MUTEX(pasid_mutex);
+static LIST_HEAD(global_svm_list);
 
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
@@ -329,13 +330,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 
 	mutex_lock(&pasid_mutex);
 	if (pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
-		int i;
+		struct intel_svm *t;
 
-		idr_for_each_entry(&iommu->pasid_idr, svm, i) {
-			if (svm->mm != mm ||
-			    (svm->flags & SVM_FLAG_PRIVATE_PASID))
+		list_for_each_entry(t, &global_svm_list, list) {
+			if (t->mm != mm || (t->flags & SVM_FLAG_PRIVATE_PASID))
 				continue;
 
+			svm = t;
 			if (svm->pasid >= pasid_max) {
 				dev_warn(dev,
 					 "Limited PASID width. Cannot use existing PASID %d\n",
@@ -404,6 +405,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		svm->mm = mm;
 		svm->flags = flags;
 		INIT_LIST_HEAD_RCU(&svm->devs);
+		INIT_LIST_HEAD(&svm->list);
 		ret = -ENOMEM;
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
@@ -430,6 +432,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		 */
 		if (cap_caching_mode(iommu->cap))
 			intel_flush_pasid_dev(svm, sdev, svm->pasid);
+
+		list_add_tail(&svm->list, &global_svm_list);
 	}
 	list_add_rcu(&sdev->list, &svm->devs);
 
@@ -485,6 +489,8 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
 
+					list_del(&svm->list);
+
 					/* We mandate that no page faults may be outstanding
 					 * for the PASID when intel_svm_unbind_mm() is called.
 					 * If that is not obeyed, subtle errors will happen.
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6692b40..e1e1938 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -487,6 +487,7 @@ struct intel_svm {
 	int flags;
 	int pasid;
 	struct list_head devs;
+	struct list_head list;
 };
 
 extern int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev);
-- 
2.7.4

