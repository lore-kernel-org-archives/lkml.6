Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9354DC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D622075A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D622075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeHRSIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:08:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbeHRSIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:08:14 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 885C8E10D9A5D;
        Sat, 18 Aug 2018 23:00:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Sat, 18 Aug 2018 23:00:10 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <jeffrey.t.kirsher@intel.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ethernet: Use dma_zalloc_coherent to replace dma_alloc_coherent + memset
Date:   Sat, 18 Aug 2018 22:48:19 +0800
Message-ID: <1534603699-10120-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_zalloc_coherent has implemented the dma_alloc_coherent() + memset (),
We prefer to dma_zalloc_coherent instead of open-codeing.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ethernet/intel/ixgb/ixgb_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_main.c b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
index 43664ad..d3e72d0 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_main.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
@@ -771,14 +771,13 @@ static pci_ers_result_t ixgb_io_error_detected (struct pci_dev *pdev,
 	rxdr->size = rxdr->count * sizeof(struct ixgb_rx_desc);
 	rxdr->size = ALIGN(rxdr->size, 4096);
 
-	rxdr->desc = dma_alloc_coherent(&pdev->dev, rxdr->size, &rxdr->dma,
-					GFP_KERNEL);
+	rxdr->desc = dma_zalloc_coherent(&pdev->dev, rxdr->size, &rxdr->dma,
+					 GFP_KERNEL);
 
 	if (!rxdr->desc) {
 		vfree(rxdr->buffer_info);
 		return -ENOMEM;
 	}
-	memset(rxdr->desc, 0, rxdr->size);
 
 	rxdr->next_to_clean = 0;
 	rxdr->next_to_use = 0;
-- 
1.7.12.4

