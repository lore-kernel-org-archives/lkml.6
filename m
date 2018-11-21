Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EAEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B4E2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B4E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390558AbeKVKEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:04:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:12257 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388174AbeKVKEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:04:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 15:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,262,1539673200"; 
   d="scan'208";a="98106183"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Nov 2018 15:28:21 -0800
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Handle domain agaw being less than iommu agaw
Date:   Wed, 21 Nov 2018 15:29:33 -0800
Message-Id: <20181121232933.158582-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel IOMMU driver opportunistically skips a few top level page
tables from the domain paging directory while programming the IOMMU
context entry. However there is an implicit assumption in the code that
domain's adjusted guest address width (agaw) would always be greater
than IOMMU's agaw.

The IOMMU capabilities in an upcoming platform cause the domain's agaw
to be lower than IOMMU's agaw. The issue is seen when the IOMMU supports
both 4-level and 5-level paging. The domain builds a 4-level page table
based on agaw of 2. However the IOMMU's agaw is set as 3 (5-level). In
this case the code incorrectly tries to skip page page table levels.
This causes the IOMMU driver to avoid programming the context entry. The
fix handles this case and programs the context entry accordingly.

Fixes: de24e55395698 ("iommu/vt-d: Simplify domain_context_mapping_one")
Cc: <stable@vger.kernel.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reported-by: Ramos Falcon, Ernesto R <ernesto.r.ramos.falcon@intel.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f3ccf025108b..fdf79baf1d79 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2044,7 +2044,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	 * than default.  Unnecessary for PT mode.
 	 */
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
-		for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
+		for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
 			ret = -ENOMEM;
 			pgd = phys_to_virt(dma_pte_addr(pgd));
 			if (!dma_pte_present(pgd))
@@ -2058,7 +2058,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 			translation = CONTEXT_TT_MULTI_LEVEL;
 
 		context_set_address_root(context, virt_to_phys(pgd));
-		context_set_address_width(context, iommu->agaw);
+		context_set_address_width(context, agaw);
 	} else {
 		/*
 		 * In pass through mode, AW must be programmed to
-- 
2.19.0

