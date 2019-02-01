Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F72C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4A3218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o92IzzYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfBAIs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:48:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfBAIsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O5KJ8GRlbczaBVxGOYcgqpq+hGPfEepfpWMZvixHPpI=; b=o92IzzYCttBzDcN4JdyXfmJaDz
        28GVjj4SAVJS3enTaCLsnn4HRN3Z+9HaU4ZDJRiq5Ci7NWwJUhvd1ywHZKJFiVmjgtlgwS9n4em4O
        Nybc3rcenwrkLadXp8GvB1bVLUsgbo3lS6hH/laqCd9FZhri+rR6Hl/ITNDkprYcyBW7zr4PfB0Kw
        2HwLCxbAFIkVSD+ZZ/Gf6INEjGPIo623cYKsqPQioYFMglk2kQIvNB4jCgKr5vYRXSnNeaOb0M5X/
        8Y2QqSkEh001eyP8LEh2Ngr3/hinZVxWireKYT0yt5Xo75dXCCdo/3sYutCok7E41thvSXRl/q0vc
        0gQqWRzA==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUUn-0001Pj-B8; Fri, 01 Feb 2019 08:48:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     iommu@lists.linux-foundation.org
Subject: [PATCH 07/18] pxa168_eth: pass struct device to DMA API functions
Date:   Fri,  1 Feb 2019 09:47:50 +0100
Message-Id: <20190201084801.10983-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Note that this driver seems to entirely lack dma_map_single error
handling, but that is left for another time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/marvell/pxa168_eth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index f8a6d6e3cb7a..35f2142aac5e 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -201,6 +201,7 @@ struct tx_desc {
 };
 
 struct pxa168_eth_private {
+	struct platform_device *pdev;
 	int port_num;		/* User Ethernet port number    */
 	int phy_addr;
 	int phy_speed;
@@ -331,7 +332,7 @@ static void rxq_refill(struct net_device *dev)
 		used_rx_desc = pep->rx_used_desc_q;
 		p_used_rx_desc = &pep->p_rx_desc_area[used_rx_desc];
 		size = skb_end_pointer(skb) - skb->data;
-		p_used_rx_desc->buf_ptr = dma_map_single(NULL,
+		p_used_rx_desc->buf_ptr = dma_map_single(&pep->pdev->dev,
 							 skb->data,
 							 size,
 							 DMA_FROM_DEVICE);
@@ -743,7 +744,7 @@ static int txq_reclaim(struct net_device *dev, int force)
 				netdev_err(dev, "Error in TX\n");
 			dev->stats.tx_errors++;
 		}
-		dma_unmap_single(NULL, addr, count, DMA_TO_DEVICE);
+		dma_unmap_single(&pep->pdev->dev, addr, count, DMA_TO_DEVICE);
 		if (skb)
 			dev_kfree_skb_irq(skb);
 		released++;
@@ -805,7 +806,7 @@ static int rxq_process(struct net_device *dev, int budget)
 		if (rx_next_curr_desc == rx_used_desc)
 			pep->rx_resource_err = 1;
 		pep->rx_desc_count--;
-		dma_unmap_single(NULL, rx_desc->buf_ptr,
+		dma_unmap_single(&pep->pdev->dev, rx_desc->buf_ptr,
 				 rx_desc->buf_size,
 				 DMA_FROM_DEVICE);
 		received_packets++;
@@ -1274,7 +1275,8 @@ pxa168_eth_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	length = skb->len;
 	pep->tx_skb[tx_index] = skb;
 	desc->byte_cnt = length;
-	desc->buf_ptr = dma_map_single(NULL, skb->data, length, DMA_TO_DEVICE);
+	desc->buf_ptr = dma_map_single(&pep->pdev->dev, skb->data, length,
+					DMA_TO_DEVICE);
 
 	skb_tx_timestamp(skb);
 
@@ -1528,6 +1530,7 @@ static int pxa168_eth_probe(struct platform_device *pdev)
 	if (err)
 		goto err_free_mdio;
 
+	pep->pdev = pdev;
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	pxa168_init_hw(pep);
 	err = register_netdev(dev);
-- 
2.20.1

