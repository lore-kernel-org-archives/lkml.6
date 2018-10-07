Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E05C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 05:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981C120895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 05:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981C120895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeJGMhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 08:37:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:15198 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbeJGMhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 08:37:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2018 22:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,351,1534834800"; 
   d="scan'208";a="89845329"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga003.jf.intel.com with ESMTP; 06 Oct 2018 22:31:26 -0700
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
Subject: [PATCH v3 07/12] iommu/vt-d: Setup pasid entry for RID2PASID support
Date:   Sun,  7 Oct 2018 13:28:48 +0800
Message-Id: <20181007052853.25940-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181007052853.25940-1-baolu.lu@linux.intel.com>
References: <20181007052853.25940-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when the scalable mode is enabled, there is no second level
page translation pointer in the context entry any more (for
DMA request without PASID). Instead, a new RID2PASID field
is introduced in the context entry. Software can choose any
PASID value to set RID2PASID and then setup the translation
in the corresponding PASID entry. Upon receiving a DMA request
without PASID, hardware will firstly look at this RID2PASID
field and then treat this request as a request with a pasid
value specified in RID2PASID field.

Though software is allowed to use any PASID for the RID2PASID,
we will always use the PASID 0 as a sort of design decision.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 20 ++++++++++++++++++++
 drivers/iommu/intel-pasid.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index dac1296b3a5d..2762b076eee6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2451,12 +2451,27 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
+		bool pass_through;
+
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
 			__dmar_remove_one_dev_info(info);
 			spin_unlock_irqrestore(&device_domain_lock, flags);
 			return NULL;
 		}
+
+		/* Setup the PASID entry for requests without PASID: */
+		pass_through = hw_pass_through && domain_type_is_si(domain);
+		spin_lock(&iommu->lock);
+		ret = intel_pasid_setup_second_level(iommu, domain, dev,
+						     PASID_RID2PASID,
+						     pass_through);
+		spin_unlock(&iommu->lock);
+		if (ret) {
+			__dmar_remove_one_dev_info(info);
+			spin_unlock_irqrestore(&device_domain_lock, flags);
+			return NULL;
+		}
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
@@ -4823,6 +4838,11 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	iommu = info->iommu;
 
 	if (info->dev) {
+		if (dev_is_pci(info->dev) && sm_supported(iommu))
+			intel_pasid_tear_down_second_level(iommu,
+					info->domain, info->dev,
+					PASID_RID2PASID);
+
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(iommu, info->dev);
 		intel_pasid_free_table(info->dev);
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 85b158a1826a..dda578b8f18e 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -10,6 +10,7 @@
 #ifndef __INTEL_PASID_H
 #define __INTEL_PASID_H
 
+#define PASID_RID2PASID			0x0
 #define PASID_MIN			0x1
 #define PASID_MAX			0x100000
 #define PASID_PTE_MASK			0x3F
-- 
2.17.1

