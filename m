Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B51C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601FB20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601FB20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeGZDGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:06:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48353 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728352AbeGZDGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:06:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7B28779709790;
        Thu, 26 Jul 2018 09:51:39 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Thu, 26 Jul 2018
 09:51:31 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <thomas.lendacky@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] amd-xgbe: use dma_mapping_error to check map errors
Date:   Thu, 26 Jul 2018 09:51:27 +0800
Message-ID: <20180726015127.8740-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma_mapping_error() returns true or false, but we want
to return -ENOMEM if there was an error.

Fixes: 174fd2597b0b ("amd-xgbe: Implement split header receive support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
index cc1e4f8..5330942 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
@@ -289,7 +289,7 @@ static int xgbe_alloc_pages(struct xgbe_prv_data *pdata,
 	struct page *pages = NULL;
 	dma_addr_t pages_dma;
 	gfp_t gfp;
-	int order, ret;
+	int order;
 
 again:
 	order = alloc_order;
@@ -316,10 +316,9 @@ static int xgbe_alloc_pages(struct xgbe_prv_data *pdata,
 	/* Map the pages */
 	pages_dma = dma_map_page(pdata->dev, pages, 0,
 				 PAGE_SIZE << order, DMA_FROM_DEVICE);
-	ret = dma_mapping_error(pdata->dev, pages_dma);
-	if (ret) {
+	if (dma_mapping_error(pdata->dev, pages_dma)) {
 		put_page(pages);
-		return ret;
+		return -ENOMEM;
 	}
 
 	pa->pages = pages;
-- 
2.7.0


