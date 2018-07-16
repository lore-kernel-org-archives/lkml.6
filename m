Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DC7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7FE20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7FE20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeGPH0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:26:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:45301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeGPH0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:26:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 00:00:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="72647248"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2018 00:00:14 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 01/10] iommu/vt-d: Enumerate the scalable mode capability
Date:   Mon, 16 Jul 2018 14:49:44 +0800
Message-Id: <1531723793-14607-2-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
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
option to disable scalable mode in case it's required as
a chicken bit option.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 35 ++++++++++++++++-------------------
 include/linux/intel-iommu.h |  1 +
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fed67c6..0a7362b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -429,15 +429,15 @@ static int dmar_map_gfx = 1;
 static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
-static int intel_iommu_ecs = 1;
+static int intel_iommu_sm = 1;
 static int iommu_identity_mapping;
 
 #define IDENTMAP_ALL		1
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-#define ecs_enabled(iommu)	(intel_iommu_ecs && ecap_ecs(iommu->ecap))
-#define pasid_enabled(iommu)	(ecs_enabled(iommu) && ecap_pasid(iommu->ecap))
+#define sm_supported(iu)	(intel_iommu_sm && ecap_smts((iu)->ecap))
+#define pasid_supported(iu)	(sm_supported(iu) && ecap_pasid((iu)->ecap))
 
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
@@ -517,10 +517,9 @@ static int __init intel_iommu_setup(char *str)
 		} else if (!strncmp(str, "sp_off", 6)) {
 			pr_info("Disable supported super page\n");
 			intel_iommu_superpage = 0;
-		} else if (!strncmp(str, "ecs_off", 7)) {
-			printk(KERN_INFO
-				"Intel-IOMMU: disable extended context table support\n");
-			intel_iommu_ecs = 0;
+		} else if (!strncmp(str, "sm_off", 6)) {
+			pr_info("Intel-IOMMU: disable scalable mode support\n");
+			intel_iommu_sm = 0;
 		} else if (!strncmp(str, "tboot_noforce", 13)) {
 			printk(KERN_INFO
 				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
@@ -767,7 +766,7 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
 	u64 *entry;
 
 	entry = &root->lo;
-	if (ecs_enabled(iommu)) {
+	if (sm_supported(iommu)) {
 		if (devfn >= 0x80) {
 			devfn -= 0x80;
 			entry = &root->hi;
@@ -909,7 +908,7 @@ static void free_context_table(struct intel_iommu *iommu)
 		if (context)
 			free_pgtable_page(context);
 
-		if (!ecs_enabled(iommu))
+		if (!sm_supported(iommu))
 			continue;
 
 		context = iommu_context_addr(iommu, i, 0x80, 0);
@@ -1261,8 +1260,6 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 	unsigned long flag;
 
 	addr = virt_to_phys(iommu->root_entry);
-	if (ecs_enabled(iommu))
-		addr |= DMA_RTADDR_RTT;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	dmar_writeq(iommu->reg + DMAR_RTADDR_REG, addr);
@@ -1739,7 +1736,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	free_context_table(iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_enabled(iommu)) {
+	if (pasid_supported(iommu)) {
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
 		intel_svm_exit(iommu);
@@ -2418,8 +2415,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		    dmar_find_matched_atsr_unit(pdev))
 			info->ats_supported = 1;
 
-		if (ecs_enabled(iommu)) {
-			if (pasid_enabled(iommu)) {
+		if (sm_supported(iommu)) {
+			if (pasid_supported(iommu)) {
 				int features = pci_pasid_features(pdev);
 				if (features >= 0)
 					info->pasid_supported = features | 1;
@@ -3231,7 +3228,7 @@ static int __init init_dmars(void)
 		 * We need to ensure the system pasid table is no bigger
 		 * than the smallest supported.
 		 */
-		if (pasid_enabled(iommu)) {
+		if (pasid_supported(iommu)) {
 			u32 temp = 2 << ecap_pss(iommu->ecap);
 
 			intel_pasid_max_id = min_t(u32, temp,
@@ -3292,7 +3289,7 @@ static int __init init_dmars(void)
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through = 0;
 #ifdef CONFIG_INTEL_IOMMU_SVM
-		if (pasid_enabled(iommu))
+		if (pasid_supported(iommu))
 			intel_svm_init(iommu);
 #endif
 	}
@@ -3396,7 +3393,7 @@ static int __init init_dmars(void)
 		iommu_flush_write_buffer(iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-		if (pasid_enabled(iommu) && ecap_prs(iommu->ecap)) {
+		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
 			ret = intel_svm_enable_prq(iommu);
 			if (ret)
 				goto free_iommu;
@@ -4300,7 +4297,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		goto out;
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_enabled(iommu))
+	if (pasid_supported(iommu))
 		intel_svm_init(iommu);
 #endif
 
@@ -4317,7 +4314,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	iommu_flush_write_buffer(iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_enabled(iommu) && ecap_prs(iommu->ecap)) {
+	if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
 		ret = intel_svm_enable_prq(iommu);
 		if (ret)
 			goto disable_iommu;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 398defb..4124cd9 100644
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
2.7.4

