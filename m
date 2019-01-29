Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CEC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AD721738
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfA2A7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:59:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfA2A7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:59:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AC317AE95;
        Tue, 29 Jan 2019 00:59:40 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-77.phx2.redhat.com [10.3.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46C5062662;
        Tue, 29 Jan 2019 00:59:40 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/amd: print reason for iommu_map_page failure in map_sg
Date:   Mon, 28 Jan 2019 17:59:37 -0700
Message-Id: <20190129005937.32487-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 29 Jan 2019 00:59:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there are multiple possible failures in iommu_map_page
it would be useful to know which case is being hit when the
error message is printed in map_sg. While here, fix up checkpatch
complaint about using function name in a string instead of
__func__.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 87ba23a75b38..675f7027aa04 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2562,6 +2562,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *s;
 	unsigned long address;
 	u64 dma_mask;
+	int ret;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
@@ -2584,7 +2585,6 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 
 		for (j = 0; j < pages; ++j) {
 			unsigned long bus_addr, phys_addr;
-			int ret;
 
 			bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
 			phys_addr = (sg_phys(s) & PAGE_MASK) + (j << PAGE_SHIFT);
@@ -2605,8 +2605,8 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	return nelems;
 
 out_unmap:
-	pr_err("%s: IOMMU mapping error in map_sg (io-pages: %d)\n",
-	       dev_name(dev), npages);
+	pr_err("%s: IOMMU mapping error in %s (io-pages: %d) reason: %d\n",
+	       dev_name(dev), __func__, npages, ret);
 
 	for_each_sg(sglist, s, nelems, i) {
 		int j, pages = iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
-- 
2.20.1.98.gecbdaf0899

