Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF34C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B98020859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfAQT3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:29:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbfAQT3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:29:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD8DC7D0DF;
        Thu, 17 Jan 2019 19:29:15 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-117-84.phx2.redhat.com [10.3.117.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 964AF600C0;
        Thu, 17 Jan 2019 19:29:15 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu: amd: call free_iova_fast with pfn in map_sg
Date:   Thu, 17 Jan 2019 12:29:02 -0700
Message-Id: <20190117192902.15158-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 17 Jan 2019 19:29:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error path of map_sg, free_iova_fast is being called with
address instead of the pfn. This results in a bad value getting into
the rcache, and can result in hitting a BUG_ON when
iova_magazine_free_pfns is called.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 87ba23a75b38..418df8ff3e50 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2623,7 +2623,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	}
 
 out_free_iova:
-	free_iova_fast(&dma_dom->iovad, address, npages);
+	free_iova_fast(&dma_dom->iovad, address >> PAGE_SHIFT, npages);
 
 out_err:
 	return 0;
-- 
2.20.1.98.gecbdaf0899

