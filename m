Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90139ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5428420C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5428420C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbeIXU7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:59:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42887 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbeIXU7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:59:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 38598208B0; Mon, 24 Sep 2018 16:56:37 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id 098B8207CA;
        Mon, 24 Sep 2018 16:56:27 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, yelena@marvell.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net] net: mvneta: fix the remaining Rx descriptor unmapping issues
Date:   Mon, 24 Sep 2018 16:56:13 +0200
Message-Id: <20180924145613.27307-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_DMA_API_DEBUG enabled we get DMA unmapping warning in
various places of the mvneta driver, for example when putting down an
interface while traffic is passing through.

The issue is when using s/w buffer management, the Rx buffers are mapped
using dma_map_page but unmapped with dma_unmap_single. This patch fixes
this by using the right unmapping function.

Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 2db9708f2e24..b4ed7d394d07 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1890,8 +1890,8 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
 		if (!data || !(rx_desc->buf_phys_addr))
 			continue;
 
-		dma_unmap_single(pp->dev->dev.parent, rx_desc->buf_phys_addr,
-				 MVNETA_RX_BUF_SIZE(pp->pkt_size), DMA_FROM_DEVICE);
+		dma_unmap_page(pp->dev->dev.parent, rx_desc->buf_phys_addr,
+			       PAGE_SIZE, DMA_FROM_DEVICE);
 		__free_page(data);
 	}
 }
@@ -2039,9 +2039,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 						frag_offset, frag_size,
 						PAGE_SIZE);
 
-				dma_unmap_single(dev->dev.parent, phys_addr,
-						 PAGE_SIZE,
-						 DMA_FROM_DEVICE);
+				dma_unmap_page(dev->dev.parent, phys_addr,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
 
 				rxq->left_size -= frag_size;
 			}
-- 
2.17.1

