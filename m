Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5741C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 06:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6238120843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 06:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6238120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeIAKgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 06:36:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:29305 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbeIAKgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 06:36:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 23:25:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,314,1531810800"; 
   d="scan'208";a="67610403"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2018 23:25:30 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Handle memory shortage on pasid table allocation
Date:   Sat,  1 Sep 2018 14:24:16 +0800
Message-Id: <20180901062416.6107-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pasid table memory allocation could return failure due to memory
shortage. Limit the pasid table size to 1MiB because current 8MiB
contiguous physical memory allocation can be hard to come by. W/o
a PASID table, the device could continue to work with only shared
virtual memory impacted. So, let's go ahead with context mapping
even the memory allocation for pasid table failed.

Fixes: cc580e41260d ("iommu/vt-d: Per PCI device pasid table interfaces")
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Reported-and-tested-by: Pelton Kyle D <kyle.d.pelton@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 6 +++---
 drivers/iommu/intel-pasid.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5f3f10cf9d9d..bedc801b06a0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2540,9 +2540,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev) && info->pasid_supported) {
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
-			__dmar_remove_one_dev_info(info);
-			spin_unlock_irqrestore(&device_domain_lock, flags);
-			return NULL;
+			pr_warn("No pasid table for %s, pasid disabled\n",
+				dev_name(dev));
+			info->pasid_supported = 0;
 		}
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 1c05ed6fc5a5..1fb5e12b029a 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -11,7 +11,7 @@
 #define __INTEL_PASID_H
 
 #define PASID_MIN			0x1
-#define PASID_MAX			0x100000
+#define PASID_MAX			0x20000
 
 struct pasid_entry {
 	u64 val;
-- 
2.17.1

