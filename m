Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29318C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA322081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA322081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbeKGIM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:12:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:30626 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbeKGIM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:12:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 14:45:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,473,1534834800"; 
   d="scan'208";a="105990754"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 06 Nov 2018 14:45:26 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v2] iommu/vt-d: respect max guest address width in agaw
Date:   Tue,  6 Nov 2018 14:47:15 -0800
Message-Id: <1541544435-52624-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supported guest address witdh (SGAW) only indicates
what the iommu's capabilities are wrt page table levels
for second level page-tables. IOMMU should pick the
right level depending on the Maximum Guest Address Width
(MGAW).

For pass-through translation type, address width must be
programmed with the largest AGAW supported by the HW.

Reported-by: Ramos Falcon, Ernesto R <ernesto.r.ramos.falcon@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 140d6ab..f16db3b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -719,7 +719,11 @@ int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
  */
 int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
-	return __iommu_calculate_agaw(iommu, DEFAULT_DOMAIN_ADDRESS_WIDTH);
+	unsigned long mgaw;
+
+	/* Respect Max Guest Address Width */
+	mgaw = min(cap_mgaw(iommu->cap), DEFAULT_DOMAIN_ADDRESS_WIDTH);
+	return __iommu_calculate_agaw(iommu, mgaw);
 }
 
 /* This functionin only returns single iommu in a domain */
-- 
2.7.4

