Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeDQDNe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 23:13:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:3585 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752850AbeDQDMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 23:12:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,461,1517904000";
   d="scan'208";a="48447685"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 7/9] iommu/vt-d: Calculate PTS value
Date: Tue, 17 Apr 2018 11:03:20 +0800
Message-Id: <1523934202-21669-8-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate PTS (PASID Table Size) value for the extended
context entry from the real size of the PASID table for
a domain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 99c643b..d4f9cea 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5146,22 +5146,16 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 #define MAX_NR_PASID_BITS (20)
-static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
+static inline unsigned long intel_iommu_get_pts(struct dmar_domain *domain)
 {
-	/*
-	 * Convert ecap_pss to extend context entry pts encoding, also
-	 * respect the soft pasid_max value set by the iommu.
-	 * - number of PASID bits = ecap_pss + 1
-	 * - number of PASID table entries = 2^(pts + 5)
-	 * Therefore, pts = ecap_pss - 4
-	 * e.g. KBL ecap_pss = 0x13, PASID has 20 bits, pts = 15
-	 */
-	if (ecap_pss(iommu->ecap) < 5)
+	int pts;
+
+	pts = find_first_bit((unsigned long *)&domain->max_pasid,
+			     MAX_NR_PASID_BITS);
+	if (pts < 5)
 		return 0;
 
-	/* pasid_max is encoded as actual number of entries not the bits */
-	return find_first_bit((unsigned long *)&iommu->pasid_max,
-			MAX_NR_PASID_BITS) - 5;
+	return pts - 5;
 }
 
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
@@ -5198,7 +5192,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 		if (iommu->pasid_state_table)
 			context[1].hi = (u64)virt_to_phys(iommu->pasid_state_table);
 		context[1].lo = (u64)virt_to_phys(iommu->pasid_table) |
-			intel_iommu_get_pts(iommu);
+			intel_iommu_get_pts(domain);
 
 		wmb();
 		/* CONTEXT_TT_MULTI_LEVEL and CONTEXT_TT_DEV_IOTLB are both
-- 
2.7.4
