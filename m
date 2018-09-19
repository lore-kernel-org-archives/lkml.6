Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406C6ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4902151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4902151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeISTNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:13:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51469 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730392AbeISTNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:13:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EEEC6208E7; Wed, 19 Sep 2018 15:35:10 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id BF73F208D9;
        Wed, 19 Sep 2018 15:35:00 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, yelena@marvell.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net] net: mvneta: fix the Rx desc buffer DMA unmapping
Date:   Wed, 19 Sep 2018 15:29:06 +0200
Message-Id: <20180919132906.26868-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_DMA_API_DEBUG enabled we now get a warning when using the
mvneta driver:

  mvneta d0030000.ethernet: DMA-API: device driver frees DMA memory with
  wrong function [device address=0x000000001165b000] [size=4096 bytes]
  [mapped as page] [unmapped as single]

This is because when using the s/w buffer management, the Rx descriptor
buffer is mapped with dma_map_page but unmapped with dma_unmap_single.
This patch fixes this by using the right unmapping function.

Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index bc80a678abc3..2db9708f2e24 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2008,8 +2008,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 				skb_add_rx_frag(rxq->skb, frag_num, page,
 						frag_offset, frag_size,
 						PAGE_SIZE);
-				dma_unmap_single(dev->dev.parent, phys_addr,
-						 PAGE_SIZE, DMA_FROM_DEVICE);
+				dma_unmap_page(dev->dev.parent, phys_addr,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
 				rxq->left_size -= frag_size;
 			}
 		} else {
-- 
2.17.1

