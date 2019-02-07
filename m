Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA116C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EE22175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfBGSpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:45:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:3813 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfBGSpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:45:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 10:45:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="131855755"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Feb 2019 10:45:41 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     joro@8bytes.org, dwmw2@infradead.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1 1/1] iommu/vt-d: Enable PRI only if the device enables PASID.
Date:   Thu,  7 Feb 2019 10:44:19 -0800
Message-Id: <142748f6a00153f9926fe2a9dc30cf3cd89164cd.1549408090.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Intel IOMMU Page Request Services (PRS) only works with devices which
supports/uses PASID. So enable PRI only if the device also enables
PASID support. For more details, Please check the implementation of PRQ
handler(prq_event_thread()) in intel-svm driver.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1457f931218e..ef1a646e0993 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1402,7 +1402,8 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-	if (info->pri_supported && !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
+	if (info->pri_supported && info->pasid_enabled &&
+	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
 		info->pri_enabled = 1;
 #endif
 	if (!pdev->untrusted && info->ats_supported &&
-- 
2.20.1

