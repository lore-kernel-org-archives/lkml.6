Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C63C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D0C2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfASRiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:38:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbfASRiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 12:38:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67F0989AE6;
        Sat, 19 Jan 2019 17:38:08 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-12.phx2.redhat.com [10.3.116.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F26F7100190B;
        Sat, 19 Jan 2019 17:38:07 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/amd: unmap all mapped pages in error path of map_sg
Date:   Sat, 19 Jan 2019 10:38:05 -0700
Message-Id: <20190119173805.1753-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 19 Jan 2019 17:38:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error path of map_sg there is an incorrect if condition
for breaking out of the loop that searches the scatterlist
for mapped pages to unmap. Instead of breaking out of the
loop once all the pages that were mapped have been unmapped,
it will break out of the loop after it has unmapped 1 page.
Fix the condition, so it breaks out of the loop only after
all the mapped pages have been unmapped.

Fixes: 80187fd39dcb ("iommu/amd: Optimize map_sg and unmap_sg")
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0416cf..aeeca479f914 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2548,7 +2548,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 			bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
 			iommu_unmap_page(domain, bus_addr, PAGE_SIZE);
 
-			if (--mapped_pages)
+			if (--mapped_pages == 0)
 				goto out_free_iova;
 		}
 	}
-- 
2.20.1.98.gecbdaf0899

