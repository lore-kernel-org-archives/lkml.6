Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89759C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5016020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5016020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755908AbeFSF10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:27:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:14970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755816AbeFSF1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:27:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 22:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="50424276"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 22:27:14 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 1/9] iommu/vt-d: Global PASID name space
Date:   Tue, 19 Jun 2018 13:17:21 +0800
Message-Id: <1529385449-25649-2-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
References: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
 drivers/iommu/intel-pasid.h | 21 ++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)
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
index 14e4b37..3653ebc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -53,6 +53,7 @@
 #include <asm/iommu.h>
 
 #include "irq_remapping.h"
+#include "intel-pasid.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -3277,6 +3278,18 @@ static int __init init_dmars(void)
 	}
 
 	for_each_active_iommu(iommu, drhd) {
+		/*
+		 * Find the max pasid size of all IOMMU's in the system.
+		 * We need to ensure the system pasid table is no bigger
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
index 0000000..e918fe0
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
+ * Intel IOMMU system wide PASID name space:
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
index 0000000..d5feb3d
--- /dev/null
+++ b/drivers/iommu/intel-pasid.h
@@ -0,0 +1,21 @@
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

