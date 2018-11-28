Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3517AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CE62081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CE62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeK1O6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:58:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:51653 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeK1O6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:58:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 19:58:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,289,1539673200"; 
   d="scan'208";a="113554399"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga002.fm.intel.com with ESMTP; 27 Nov 2018 19:58:03 -0800
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
Subject: [PATCH v5 07/12] iommu/vt-d: Setup pasid entry for RID2PASID support
Date:   Wed, 28 Nov 2018 11:54:44 +0800
Message-Id: <20181128035449.10226-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128035449.10226-1-baolu.lu@linux.intel.com>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
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
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 19 +++++++++++++++++++
 drivers/iommu/intel-pasid.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 373fda89aaa4..a63aa01a2e88 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2457,6 +2457,21 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 			spin_unlock_irqrestore(&device_domain_lock, flags);
 			return NULL;
 		}
+
+		/* Setup the PASID entry for requests without PASID: */
+		spin_lock(&iommu->lock);
+		if (hw_pass_through && domain_type_is_si(domain))
+			ret = intel_pasid_setup_pass_through(iommu, domain,
+					dev, PASID_RID2PASID);
+		else
+			ret = intel_pasid_setup_second_level(iommu, domain,
+					dev, PASID_RID2PASID);
+		spin_unlock(&iommu->lock);
+		if (ret) {
+			__dmar_remove_one_dev_info(info);
+			spin_unlock_irqrestore(&device_domain_lock, flags);
+			return NULL;
+		}
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
@@ -4821,6 +4836,10 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	iommu = info->iommu;
 
 	if (info->dev) {
+		if (dev_is_pci(info->dev) && sm_supported(iommu))
+			intel_pasid_tear_down_entry(iommu, info->dev,
+					PASID_RID2PASID);
+
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(iommu, info->dev);
 		intel_pasid_free_table(info->dev);
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 3c70522091d3..d6f4fead4491 100644
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

