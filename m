Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeEDFRY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 01:17:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:30967 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751417AbeEDFRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 01:17:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,361,1520924400";
   d="scan'208";a="48196466"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/4] iommu/vt-d: Clean up pasid quirk for pre-production devices
Date: Fri,  4 May 2018 13:08:18 +0800
Message-Id: <1525410499-18632-4-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
References: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pasid28 quirk is needed only for some pre-production devices.
Remove it to make the code concise.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 32 ++------------------------------
 include/linux/intel-iommu.h |  1 -
 2 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9064607..10bce33 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -485,37 +485,14 @@ static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
 static int intel_iommu_ecs = 1;
-static int intel_iommu_pasid28;
 static int iommu_identity_mapping;
 
 #define IDENTMAP_ALL		1
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-/* Broadwell and Skylake have broken ECS support — normal so-called "second
- * level" translation of DMA requests-without-PASID doesn't actually happen
- * unless you also set the NESTE bit in an extended context-entry. Which of
- * course means that SVM doesn't work because it's trying to do nested
- * translation of the physical addresses it finds in the process page tables,
- * through the IOVA->phys mapping found in the "second level" page tables.
- *
- * The VT-d specification was retroactively changed to change the definition
- * of the capability bits and pretend that Broadwell/Skylake never happened...
- * but unfortunately the wrong bit was changed. It's ECS which is broken, but
- * for some reason it was the PASID capability bit which was redefined (from
- * bit 28 on BDW/SKL to bit 40 in future).
- *
- * So our test for ECS needs to eschew those implementations which set the old
- * PASID capabiity bit 28, since those are the ones on which ECS is broken.
- * Unless we are working around the 'pasid28' limitations, that is, by putting
- * the device into passthrough mode for normal DMA and thus masking the bug.
- */
-#define ecs_enabled(iommu) (intel_iommu_ecs && ecap_ecs(iommu->ecap) && \
-			    (intel_iommu_pasid28 || !ecap_broken_pasid(iommu->ecap)))
-/* PASID support is thus enabled if ECS is enabled and *either* of the old
- * or new capability bits are set. */
-#define pasid_enabled(iommu) (ecs_enabled(iommu) &&			\
-			      (ecap_pasid(iommu->ecap) || ecap_broken_pasid(iommu->ecap)))
+#define ecs_enabled(iommu)	(intel_iommu_ecs && ecap_ecs(iommu->ecap))
+#define pasid_enabled(iommu)	(ecs_enabled(iommu) && ecap_pasid(iommu->ecap))
 
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
@@ -578,11 +555,6 @@ static int __init intel_iommu_setup(char *str)
 			printk(KERN_INFO
 				"Intel-IOMMU: disable extended context table support\n");
 			intel_iommu_ecs = 0;
-		} else if (!strncmp(str, "pasid28", 7)) {
-			printk(KERN_INFO
-				"Intel-IOMMU: enable pre-production PASID support\n");
-			intel_iommu_pasid28 = 1;
-			iommu_identity_mapping |= IDENTMAP_GFX;
 		} else if (!strncmp(str, "tboot_noforce", 13)) {
 			printk(KERN_INFO
 				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ef169d6..1df9401 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -121,7 +121,6 @@
 #define ecap_srs(e)		((e >> 31) & 0x1)
 #define ecap_ers(e)		((e >> 30) & 0x1)
 #define ecap_prs(e)		((e >> 29) & 0x1)
-#define ecap_broken_pasid(e)	((e >> 28) & 0x1)
 #define ecap_dis(e)		((e >> 27) & 0x1)
 #define ecap_nest(e)		((e >> 26) & 0x1)
 #define ecap_mts(e)		((e >> 25) & 0x1)
-- 
2.7.4
