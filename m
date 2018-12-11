Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DEDC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBFD20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBFD20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeLKMTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:19:39 -0500
Received: from 8bytes.org ([81.169.241.247]:53134 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeLKMTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:19:14 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B045E533; Tue, 11 Dec 2018 13:19:12 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4/9] iommu/dma: Use helper functions to access dev->iommu_fwspec
Date:   Tue, 11 Dec 2018 13:19:05 +0100
Message-Id: <20181211121910.5604-5-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211121910.5604-1-joro@8bytes.org>
References: <20181211121910.5604-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b04753b204..2b1c6912fbcc 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -177,7 +177,7 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 
-	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode))
+	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
 
 }
-- 
2.17.1

