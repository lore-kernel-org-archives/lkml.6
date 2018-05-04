Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeEDBup (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:50:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:35622 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeEDBum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:50:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="37326229"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 1/9] iommu/vt-d: Global PASID name space
Date: Fri,  4 May 2018 09:41:16 +0800
Message-Id: <1525398084-28815-2-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the system wide PASID name space for the PASID
allocation. Currently we are using per IOMMU PASID name
spaces which are not suitable for some use cases. For an
example, one application (associated with a PASID) might
talk to two physical devices simultaneously while the two
devices could reside behind two different IOMMU units.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/Makefile      |  2 +-
 drivers/iommu/intel-iommu.c | 13 ++++++++++
 drivers/iommu/intel-pasid.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h | 30 +++++++++++++++++++++++
 4 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/intel-pasid.c
 create mode 100644 drivers/iommu/intel-pasid.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb6958..0a190b4 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o
+obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 749d8f2..98c5ae9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -53,6 +53,7 @@
 #include <asm/iommu.h>
 
 #include "irq_remapping.h"
+#include "intel-pasid.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -3265,6 +3266,18 @@ static int __init init_dmars(void)
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
+			intel_pasid_max_id = min_t(u32, temp,
+						   intel_pasid_max_id);
+		}
+
 		g_iommus[iommu->seq_id] = iommu;
 
 		intel_iommu_init_qi(iommu);
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
new file mode 100644
index 0000000..0690f39
--- /dev/null
+++ b/drivers/iommu/intel-pasid.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * intel-pasid.c - PASID idr, table and entry manipulation
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu@linux.intel.com>
+ */
+
+#define pr_fmt(fmt)	"DMAR: " fmt
+
+#include <linux/dmar.h>
+#include <linux/intel-iommu.h>
+#include <linux/iommu.h>
+#include <linux/memory.h>
+#include <linux/spinlock.h>
+
+#include "intel-pasid.h"
+
+/*
+ * Intel IOMMU global PASID pool:
+ */
+static DEFINE_SPINLOCK(pasid_lock);
+u32 intel_pasid_max_id = PASID_MAX;
+static DEFINE_IDR(pasid_idr);
+
+int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
+{
+	int ret, min, max;
+
+	min = max_t(int, start, PASID_MIN);
+	max = min_t(int, end, intel_pasid_max_id);
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
+void intel_pasid_free_id(int pasid)
+{
+	spin_lock(&pasid_lock);
+	idr_remove(&pasid_idr, pasid);
+	spin_unlock(&pasid_lock);
+}
+
+void *intel_pasid_lookup_id(int pasid)
+{
+	void *p;
+
+	spin_lock(&pasid_lock);
+	p = idr_find(&pasid_idr, pasid);
+	spin_unlock(&pasid_lock);
+
+	return p;
+}
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
new file mode 100644
index 0000000..0c36af0
--- /dev/null
+++ b/drivers/iommu/intel-pasid.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * intel-pasid.h - PASID idr, table and entry header
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu@linux.intel.com>
+ */
+
+#ifndef __INTEL_PASID_H
+#define __INTEL_PASID_H
+
+/*
+ * Eventually I'm promised we will get a multi-level PASID table
+ * and it won't have to be physically contiguous. Until then,
+ * limit the size because 8MiB contiguous allocations can be hard
+ * to come by. The limit of 0x20000, which is 1MiB for each of
+ * the PASID and PASID-state tables, is somewhat arbitrary.
+ *
+ * PASID 0 is reserved in caching mode (virtualised IOMMU).
+ */
+#define PASID_MIN			0x1
+#define PASID_MAX			0x20000
+
+extern u32 intel_pasid_max_id;
+int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
+void intel_pasid_free_id(int pasid);
+void *intel_pasid_lookup_id(int pasid);
+
+#endif /* __INTEL_PASID_H */
-- 
2.7.4
