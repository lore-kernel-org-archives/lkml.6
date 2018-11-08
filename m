Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7445AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB5B2089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHCWAC6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB5B2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeKIHdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbeKIHdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:38 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3647621104;
        Thu,  8 Nov 2018 21:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714170;
        bh=VirZwrLd6KwzxlPyBRfgeerhEFpSwo5yxcuPYdN+DAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHCWAC6TRbdb1tvvZznRqmrOEYAdrXTU1mK8lNLH4kc6dbQ3aFdn77bZuMNddfUlj
         xGb3sBy7dbHQkdvodtWOwNUyDvzFxJsEBwLOmv5H2u4I+Mu3IeZeQ7m//xgCzDtpar
         3bDbKBLzjWLixJvRYmxrRsLMWTK5FEDSDAtzd0Jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 092/144] iommu/vt-d: Fix VM domain ID leak
Date:   Thu,  8 Nov 2018 13:51:03 -0800
Message-Id: <20181108215102.527593662@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 46ebb7af7b93792de65e124e1ab8b89a108a41f2 ]

This continues the attempt to fix commit fb170fb4c548 ("iommu/vt-d:
Introduce helper functions to make code symmetric for readability").
The previous attempt in commit 71684406905f ("iommu/vt-d: Detach
domain *only* from attached iommus") overlooked the fact that
dmar_domain.iommu_bmp gets cleared for VM domains when devices are
detached:

intel_iommu_detach_device
  domain_remove_one_dev_info
    domain_detach_iommu

The domain is detached from the iommu, but the iommu is still attached
to the domain, for whatever reason.  Thus when we get to domain_exit(),
we can't rely on iommu_bmp for VM domains to find the active iommus,
we must check them all.  Without that, the corresponding bit in
intel_iommu.domain_ids doesn't get cleared and repeated VM domain
creation and destruction will run out of domain IDs.  Meanwhile we
still can't call iommu_detach_domain() on arbitrary non-VM domains or
we risk clearing in-use domain IDs, as 71684406905f attempted to
address.

It's tempting to modify iommu_detach_domain() to test the domain
iommu_bmp, but the call ordering from domain_remove_one_dev_info()
prevents it being able to work as fb170fb4c548 seems to have intended.
Caching of unused VM domains on the iommu object seems to be the root
of the problem, but this code is far too fragile for that kind of
rework to be proposed for stable, so we simply revert this chunk to
its state prior to fb170fb4c548.

Fixes: fb170fb4c548 ("iommu/vt-d: Introduce helper functions to make
                      code symmetric for readability")
Fixes: 71684406905f ("iommu/vt-d: Detach domain *only* from attached
                      iommus")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: stable@vger.kernel.org # v3.17+
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 351da1da814f..2068cb59f7ed 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1759,8 +1759,9 @@ static int domain_init(struct dmar_domain *domain, int guest_width)
 
 static void domain_exit(struct dmar_domain *domain)
 {
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
 	struct page *freelist = NULL;
-	int i;
 
 	/* Domain 0 is reserved, so dont process it */
 	if (!domain)
@@ -1780,8 +1781,10 @@ static void domain_exit(struct dmar_domain *domain)
 
 	/* clear attached or cached domains */
 	rcu_read_lock();
-	for_each_set_bit(i, domain->iommu_bmp, g_num_of_iommus)
-		iommu_detach_domain(domain, g_iommus[i]);
+	for_each_active_iommu(iommu, drhd)
+		if (domain_type_is_vm(domain) ||
+		    test_bit(iommu->seq_id, domain->iommu_bmp))
+			iommu_detach_domain(domain, iommu);
 	rcu_read_unlock();
 
 	dma_free_pagelist(freelist);
-- 
2.17.1



