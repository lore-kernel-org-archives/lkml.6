Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D01C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FAB20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FAB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937261AbeFSF1Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:27:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:14970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752308AbeFSF1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:27:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 22:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="50424314"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 22:27:19 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 3/9] iommu/vt-d: Apply global PASID in SVA
Date:   Tue, 19 Jun 2018 13:17:23 +0800
Message-Id: <1529385449-25649-4-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
References: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies the global pasid name space in the shared
virtual address (SVA) implementation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-svm.c   | 22 +++++++++++-----------
 include/linux/intel-iommu.h |  1 -
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 36cc1d1..56e65d0 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -26,6 +26,8 @@
 #include <linux/interrupt.h>
 #include <asm/page.h>
 
+#include "intel-pasid.h"
+
 #define PASID_ENTRY_P		BIT_ULL(0)
 #define PASID_ENTRY_FLPM_5LP	BIT_ULL(9)
 #define PASID_ENTRY_SRE		BIT_ULL(11)
@@ -85,8 +87,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 				iommu->name);
 	}
 
-	idr_init(&iommu->pasid_idr);
-
 	return 0;
 }
 
@@ -102,7 +102,7 @@ int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
 		free_pages((unsigned long)iommu->pasid_state_table, order);
 		iommu->pasid_state_table = NULL;
 	}
-	idr_destroy(&iommu->pasid_idr);
+
 	return 0;
 }
 
@@ -392,9 +392,9 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 			pasid_max = iommu->pasid_max;
 
 		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
-		ret = idr_alloc(&iommu->pasid_idr, svm,
-				!!cap_caching_mode(iommu->cap),
-				pasid_max - 1, GFP_KERNEL);
+		ret = intel_pasid_alloc_id(svm,
+					   !!cap_caching_mode(iommu->cap),
+					   pasid_max - 1, GFP_KERNEL);
 		if (ret < 0) {
 			kfree(svm);
 			kfree(sdev);
@@ -410,7 +410,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+				intel_pasid_free_id(svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -460,7 +460,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!iommu || !iommu->pasid_table)
 		goto out;
 
-	svm = idr_find(&iommu->pasid_idr, pasid);
+	svm = intel_pasid_lookup_id(pasid);
 	if (!svm)
 		goto out;
 
@@ -485,7 +485,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 					svm->iommu->pasid_table[svm->pasid].val = 0;
 					wmb();
 
-					idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+					intel_pasid_free_id(svm->pasid);
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
 
@@ -520,7 +520,7 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 	if (!iommu || !iommu->pasid_table)
 		goto out;
 
-	svm = idr_find(&iommu->pasid_idr, pasid);
+	svm = intel_pasid_lookup_id(pasid);
 	if (!svm)
 		goto out;
 
@@ -618,7 +618,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 		if (!svm || svm->pasid != req->pasid) {
 			rcu_read_lock();
-			svm = idr_find(&iommu->pasid_idr, req->pasid);
+			svm = intel_pasid_lookup_id(req->pasid);
 			/* It *can't* go away, because the driver is not permitted
 			 * to unbind the mm while any page faults are outstanding.
 			 * So we only need RCU to protect the internal idr code. */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 06f04e2..0cfac9d 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -417,7 +417,6 @@ struct intel_iommu {
 	struct pasid_state_entry *pasid_state_table;
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
-	struct idr pasid_idr;
 	u32 pasid_max;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
-- 
2.7.4

