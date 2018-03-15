Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeCOCqZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:46:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:43990 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbeCOCqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:46:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,308,1517904000";
   d="scan'208";a="24171120"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/3] iommu/vt-d: Global PASID name space
Date: Thu, 15 Mar 2018 10:38:19 +0800
Message-Id: <1521081501-30119-2-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521081501-30119-1-git-send-email-baolu.lu@linux.intel.com>
References: <1521081501-30119-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the algorithm to maintain a system wide PASID name space
for the PASID allocation. Previously we maintained a per IOMMU unit
PASID name space which is not suitable for some use cases. For an
example, one application (associated with one PASID) might talk to
two physical devices simultaneously where two devices could reside
behind two different IOMMU units.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel-iommu.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  5 ++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 582fd01..2a81936 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -518,6 +518,58 @@ static int iommu_identity_mapping;
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
+/*
+ * Intel IOMMU global PASID pool:
+ *
+ * Eventually I'm promised we will get a multi-level PASID table
+ * and it won't have to be physically contiguous. Until then,
+ * limit the size because 8MiB contiguous allocations can be hard
+ * to come by. The limit of 0x20000, which is 1MiB for each of
+ * the PASID and PASID-state tables, is somewhat arbitrary.
+ *
+ * PASID 0 is reserved in caching mode (virtualised IOMMU).
+ */
+#define PASID_MIN	0x1
+#define PASID_MAX	0x20000
+static DEFINE_SPINLOCK(pasid_lock);
+u32 intel_iommu_pasid_max = PASID_MAX;
+static DEFINE_IDR(pasid_idr);
+
+int intel_iommu_alloc_pasid(void *ptr, int start, int end, gfp_t gfp)
+{
+	int ret, min, max;
+
+	min = max_t(int, start, PASID_MIN);
+	max = min_t(int, end, intel_iommu_pasid_max);
+
+	WARN_ON(in_interrupt());
+	idr_preload(gfp);
+	spin_lock(&pasid_lock);
+	ret = idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
+	spin_unlock(&pasid_lock);
+	idr_preload_end();
+
+	return ret;
+}
+
+void intel_iommu_free_pasid(int pasid)
+{
+	spin_lock(&pasid_lock);
+	idr_remove(&pasid_idr, pasid);
+	spin_unlock(&pasid_lock);
+}
+
+void *intel_iommu_lookup_pasid(int pasid)
+{
+	void *p;
+
+	spin_lock(&pasid_lock);
+	p = idr_find(&pasid_idr, pasid);
+	spin_unlock(&pasid_lock);
+
+	return p;
+}
+
 #define DUMMY_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-1))
 static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
@@ -3263,6 +3315,18 @@ static int __init init_dmars(void)
 	}
 
 	for_each_active_iommu(iommu, drhd) {
+		/*
+		 * Find the max pasid size of all IOMMU's in the system.
+		 * we need to ensure the system pasid table is no bigger
+		 * than the smallest supported.
+		 */
+		if (pasid_enabled(iommu)) {
+			u32 temp = 2 << ecap_pss(iommu->ecap);
+
+			intel_iommu_pasid_max = min_t(u32, temp,
+						      intel_iommu_pasid_max);
+		}
+
 		g_iommus[iommu->seq_id] = iommu;
 
 		intel_iommu_init_qi(iommu);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8dad3dd..bf83073 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -494,4 +494,9 @@ extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
 
 extern const struct attribute_group *intel_iommu_groups[];
 
+extern u32 intel_iommu_pasid_max;
+int intel_iommu_alloc_pasid(void *ptr, int start, int end, gfp_t gfp);
+void intel_iommu_free_pasid(int pasid);
+void *intel_iommu_lookup_pasid(int pasid);
+
 #endif
-- 
2.7.4
