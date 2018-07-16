Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E99ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D9B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D9B20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbeGPH03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:26:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:45301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeGPH02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:26:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 00:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="72647365"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2018 00:00:32 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 10/10] iommu/vt-d: Remove deferred invalidation
Date:   Mon, 16 Jul 2018 14:49:53 +0800
Message-Id: <1531723793-14607-11-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred invalidation is an ECS specific feature. It will not be
supported when IOMMU works in scalable mode. As we deprecated the
ECS support, remove deferred invalidation and cleanup the code.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c |  1 -
 drivers/iommu/intel-svm.c   | 45 ---------------------------------------------
 include/linux/intel-iommu.h |  8 --------
 3 files changed, 54 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 88ec860..0b0209e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1698,7 +1698,6 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	if (pasid_supported(iommu)) {
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
-		intel_svm_exit(iommu);
 	}
 #endif
 }
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index a16a421..da16a74 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -30,15 +30,8 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-struct pasid_state_entry {
-	u64 val;
-};
-
 int intel_svm_init(struct intel_iommu *iommu)
 {
-	struct page *pages;
-	int order;
-
 	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
 			!cap_fl1gp_support(iommu->cap))
 		return -EINVAL;
@@ -47,39 +40,6 @@ int intel_svm_init(struct intel_iommu *iommu)
 			!cap_5lp_support(iommu->cap))
 		return -EINVAL;
 
-	/* Start at 2 because it's defined as 2^(1+PSS) */
-	iommu->pasid_max = 2 << ecap_pss(iommu->ecap);
-
-	/* Eventually I'm promised we will get a multi-level PASID table
-	 * and it won't have to be physically contiguous. Until then,
-	 * limit the size because 8MiB contiguous allocations can be hard
-	 * to come by. The limit of 0x20000, which is 1MiB for each of
-	 * the PASID and PASID-state tables, is somewhat arbitrary. */
-	if (iommu->pasid_max > 0x20000)
-		iommu->pasid_max = 0x20000;
-
-	order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
-	if (ecap_dis(iommu->ecap)) {
-		pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
-		if (pages)
-			iommu->pasid_state_table = page_address(pages);
-		else
-			pr_warn("IOMMU: %s: Failed to allocate PASID state table\n",
-				iommu->name);
-	}
-
-	return 0;
-}
-
-int intel_svm_exit(struct intel_iommu *iommu)
-{
-	int order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
-
-	if (iommu->pasid_state_table) {
-		free_pages((unsigned long)iommu->pasid_state_table, order);
-		iommu->pasid_state_table = NULL;
-	}
-
 	return 0;
 }
 
@@ -197,11 +157,6 @@ static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
 {
 	struct intel_svm_dev *sdev;
 
-	/* Try deferred invalidate if available */
-	if (svm->iommu->pasid_state_table &&
-	    !cmpxchg64(&svm->iommu->pasid_state_table[svm->pasid].val, 0, 1ULL << 63))
-		return;
-
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list)
 		intel_flush_svm_range_dev(svm, sdev, address, pages, ih, gl);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4b58946..9fbd1a7 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -451,15 +451,8 @@ struct intel_iommu {
 	struct iommu_flush flush;
 #endif
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	/* These are large and need to be contiguous, so we allocate just
-	 * one for now. We'll maybe want to rethink that if we truly give
-	 * devices away to userspace processes (e.g. for DPDK) and don't
-	 * want to trust that userspace will use *only* the PASID it was
-	 * told to. But while it's all driver-arbitrated, we're fine. */
-	struct pasid_state_entry *pasid_state_table;
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
-	u32 pasid_max;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
@@ -573,7 +566,6 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
-int intel_svm_exit(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 
-- 
2.7.4

