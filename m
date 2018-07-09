Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4428C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE5E208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE5E208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754623AbeGIFdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:33:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:52091 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754551AbeGIFdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:33:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 22:33:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="243653303"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2018 22:33:14 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 7/9] iommu/vt-d: Allocate and free pasid table
Date:   Mon,  9 Jul 2018 13:22:56 +0800
Message-Id: <1531113778-28238-8-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allocates a PASID table for a PCI device at the time
when the dmar dev_info is attached to dev->archdata.iommu, and
free it in the opposite case.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a930918..baad27a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2508,6 +2508,15 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	list_add(&info->global, &device_domain_list);
 	if (dev)
 		dev->archdata.iommu = info;
+
+	if (dev && dev_is_pci(dev) && info->pasid_supported) {
+		ret = intel_pasid_alloc_table(dev);
+		if (ret) {
+			__dmar_remove_one_dev_info(info);
+			spin_unlock_irqrestore(&device_domain_lock, flags);
+			return NULL;
+		}
+	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	if (dev && domain_context_mapping(domain, dev)) {
@@ -4873,6 +4882,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	if (info->dev) {
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(iommu, info->dev);
+		intel_pasid_free_table(info->dev);
 	}
 
 	unlink_domain_info(info);
-- 
2.7.4

