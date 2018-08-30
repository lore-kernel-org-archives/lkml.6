Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68A4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EA520647
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EA520647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeH3FgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:36:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:5367 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeH3FgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:36:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 18:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,305,1531810800"; 
   d="scan'208";a="79442223"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2018 18:36:34 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 01/12] iommu/vt-d: Enumerate the scalable mode capability
Date:   Thu, 30 Aug 2018 09:35:13 +0800
Message-Id: <20180830013524.28743-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830013524.28743-1-baolu.lu@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel vt-d spec rev3.0 introduces a new translation
mode called scalable mode, which enables PASID-granular
translations for first level, second level, nested and
pass-through modes. At the same time, the previous
Extended Context (ECS) mode is deprecated (no production
ever implements ECS).

This patch adds enumeration for Scalable Mode and removes
the deprecated ECS enumeration. It provides a boot time
option to disable scalable mode even hardware claims to
support it.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 .../admin-guide/kernel-parameters.txt         | 12 ++--
 drivers/iommu/intel-iommu.c                   | 64 +++++--------------
 include/linux/intel-iommu.h                   |  1 +
 3 files changed, 24 insertions(+), 53 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..5b971306a114 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1668,12 +1668,12 @@
 			By default, super page will be supported if Intel IOMMU
 			has the capability. With this option, super page will
 			not be supported.
-		ecs_off [Default Off]
-			By default, extended context tables will be supported if
-			the hardware advertises that it has support both for the
-			extended tables themselves, and also PASID support. With
-			this option set, extended tables will not be used even
-			on hardware which claims to support them.
+		sm_off [Default Off]
+			By default, scalable mode will be supported if the
+			hardware advertises that it has support for the scalable
+			mode translation. With this option set, scalable mode
+			will not be used even on hardware which claims to support
+			it.
 		tboot_noforce [Default Off]
 			Do not force the Intel IOMMU enabled under tboot.
 			By default, tboot will force Intel IOMMU on, which
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5f3f10cf9d9d..5845edf4dcf9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -430,38 +430,16 @@ static int dmar_map_gfx = 1;
 static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
-static int intel_iommu_ecs = 1;
-static int intel_iommu_pasid28;
+static int intel_iommu_sm = 1;
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
+#define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
+#define pasid_supported(iommu)	(sm_supported(iommu) &&			\
+				 ecap_pasid((iommu)->ecap))
 
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
@@ -541,15 +519,9 @@ static int __init intel_iommu_setup(char *str)
 		} else if (!strncmp(str, "sp_off", 6)) {
 			pr_info("Disable supported super page\n");
 			intel_iommu_superpage = 0;
-		} else if (!strncmp(str, "ecs_off", 7)) {
-			printk(KERN_INFO
-				"Intel-IOMMU: disable extended context table support\n");
-			intel_iommu_ecs = 0;
-		} else if (!strncmp(str, "pasid28", 7)) {
-			printk(KERN_INFO
-				"Intel-IOMMU: enable pre-production PASID support\n");
-			intel_iommu_pasid28 = 1;
-			iommu_identity_mapping |= IDENTMAP_GFX;
+		} else if (!strncmp(str, "sm_off", 6)) {
+			pr_info("Intel-IOMMU: disable scalable mode support\n");
+			intel_iommu_sm = 0;
 		} else if (!strncmp(str, "tboot_noforce", 13)) {
 			printk(KERN_INFO
 				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
@@ -796,7 +768,7 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
 	u64 *entry;
 
 	entry = &root->lo;
-	if (ecs_enabled(iommu)) {
+	if (sm_supported(iommu)) {
 		if (devfn >= 0x80) {
 			devfn -= 0x80;
 			entry = &root->hi;
@@ -938,7 +910,7 @@ static void free_context_table(struct intel_iommu *iommu)
 		if (context)
 			free_pgtable_page(context);
 
-		if (!ecs_enabled(iommu))
+		if (!sm_supported(iommu))
 			continue;
 
 		context = iommu_context_addr(iommu, i, 0x80, 0);
@@ -1290,8 +1262,6 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 	unsigned long flag;
 
 	addr = virt_to_phys(iommu->root_entry);
-	if (ecs_enabled(iommu))
-		addr |= DMA_RTADDR_RTT;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	dmar_writeq(iommu->reg + DMAR_RTADDR_REG, addr);
@@ -1780,7 +1750,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	free_context_table(iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_enabled(iommu)) {
+	if (pasid_supported(iommu)) {
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
 		intel_svm_exit(iommu);
@@ -2489,8 +2459,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		    dmar_find_matched_atsr_unit(pdev))
 			info->ats_supported = 1;
 
-		if (ecs_enabled(iommu)) {
-			if (pasid_enabled(iommu)) {
+		if (sm_supported(iommu)) {
+			if (pasid_supported(iommu)) {
 				int features = pci_pasid_features(pdev);
 				if (features >= 0)
 					info->pasid_supported = features | 1;
@@ -3302,7 +3272,7 @@ static int __init init_dmars(void)
 		 * We need to ensure the system pasid table is no bigger
 		 * than the smallest supported.
 		 */
-		if (pasid_enabled(iommu)) {
+		if (pasid_supported(iommu)) {
 			u32 temp = 2 << ecap_pss(iommu->ecap);
 
 			intel_pasid_max_id = min_t(u32, temp,
@@ -3363,7 +3333,7 @@ static int __init init_dmars(void)
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through = 0;
 #ifdef CONFIG_INTEL_IOMMU_SVM
-		if (pasid_enabled(iommu))
+		if (pasid_supported(iommu))
 			intel_svm_init(iommu);
 #endif
 	}
@@ -3467,7 +3437,7 @@ static int __init init_dmars(void)
 		iommu_flush_write_buffer(iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-		if (pasid_enabled(iommu) && ecap_prs(iommu->ecap)) {
+		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
 			ret = intel_svm_enable_prq(iommu);
 			if (ret)
 				goto free_iommu;
@@ -4358,7 +4328,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		goto out;
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_enabled(iommu))
+	if (pasid_supported(iommu))
 		intel_svm_init(iommu);
 #endif
 
@@ -4375,7 +4345,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	iommu_flush_write_buffer(iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_enabled(iommu) && ecap_prs(iommu->ecap)) {
+	if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
 		ret = intel_svm_enable_prq(iommu);
 		if (ret)
 			goto disable_iommu;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 28004d74ae04..2173ae35f1dc 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -115,6 +115,7 @@
  * Extended Capability Register
  */
 
+#define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
 #define ecap_pss(e)		((e >> 35) & 0x1f)
-- 
2.17.1

