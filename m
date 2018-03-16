Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeCPEjh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:39:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:43220 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbeCPEjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:39:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000";
   d="scan'208";a="24519130"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Sankaran Rajesh <rajesh.sankaran@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Use real PASID for flush in caching mode
Date: Fri, 16 Mar 2018 12:31:36 +0800
Message-Id: <1521174696-22495-1-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If caching mode is supported, the hardware will cache
none-present or erroneous translation entries. Hence,
software should explicitly invalidate the PASID cache
after a PASID table entry becomes present. We should
issue such invalidation with the PASID value that we
have changed. PASID 0 is not reserved for this case.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Sankaran Rajesh <rajesh.sankaran@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 99bc9bd..b7b88b5 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -422,17 +422,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		iommu->pasid_table[svm->pasid].val = pasid_entry_val;
 
 		wmb();
-		/* In caching mode, we still have to flush with PASID 0 when
-		 * a PASID table entry becomes present. Not entirely clear
-		 * *why* that would be the case — surely we could just issue
-		 * a flush with the PASID value that we've changed? The PASID
-		 * is the index into the table, after all. It's not like domain
-		 * IDs in the case of the equivalent context-entry change in
-		 * caching mode. And for that matter it's not entirely clear why
-		 * a VMM would be in the business of caching the PASID table
-		 * anyway. Surely that can be left entirely to the guest? */
+
+		/*
+		 * Flush PASID cache when a PASID table entry becomes
+		 * present.
+		 */
 		if (cap_caching_mode(iommu->cap))
-			intel_flush_pasid_dev(svm, sdev, 0);
+			intel_flush_pasid_dev(svm, sdev, svm->pasid);
 	}
 	list_add_rcu(&sdev->list, &svm->devs);
 
-- 
2.7.4
