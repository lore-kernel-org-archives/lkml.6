Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194C3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8677218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mwqj67wJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfBKNVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:21:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfBKNUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N5mJ1AAxytGZodzOo16w91XOhAp4pN9n448U5bQziBY=; b=Mwqj67wJgan1J6nUt6Zp2mgZnH
        JQSXDejpHzOsb8T2ktK/gSg3a23tEJiMAvbV5tNe2eQzWYjK4u+ZGzE+0ech3JhilirxXT83TaFi7
        KHQJcE6p0ry9B/b+Oa6m6FW5RHyUWqF4dESA/L1ttr+qtN+xaMr9WRguy1aNHG+L3+hCLTBofU7kS
        c23gtmE9D26IiptGJbItQ9WRfOqyJmKez24Xbe1e49nzuO4qKeIFTbXbh2cOxr2zriZlLBWRmUpWV
        uDx6ojSQwmF4lA/gWkso+7aQRW2LFelKcufXiEeOTzhgn09TdTG31RAre1ZEWMfQ8uC+J+rRjJLhd
        yz+LP8NQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBVY-0000W6-7G; Mon, 11 Feb 2019 13:20:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] moxart_ether: pass struct device to DMA API functions
Date:   Mon, 11 Feb 2019 14:20:02 +0100
Message-Id: <20190211132004.29143-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211132004.29143-1-hch@lst.de>
References: <20190211132004.29143-1-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/moxa/moxart_ether.c | 11 +++++++----
 drivers/net/ethernet/moxa/moxart_ether.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index b34055ac476f..00dec0ffb11b 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -81,11 +81,13 @@ static void moxart_mac_free_memory(struct net_device *ndev)
 				 priv->rx_buf_size, DMA_FROM_DEVICE);
 
 	if (priv->tx_desc_base)
-		dma_free_coherent(NULL, TX_REG_DESC_SIZE * TX_DESC_NUM,
+		dma_free_coherent(&priv->pdev->dev,
+				  TX_REG_DESC_SIZE * TX_DESC_NUM,
 				  priv->tx_desc_base, priv->tx_base);
 
 	if (priv->rx_desc_base)
-		dma_free_coherent(NULL, RX_REG_DESC_SIZE * RX_DESC_NUM,
+		dma_free_coherent(&priv->pdev->dev,
+				  RX_REG_DESC_SIZE * RX_DESC_NUM,
 				  priv->rx_desc_base, priv->rx_base);
 
 	kfree(priv->tx_buf_base);
@@ -476,6 +478,7 @@ static int moxart_mac_probe(struct platform_device *pdev)
 
 	priv = netdev_priv(ndev);
 	priv->ndev = ndev;
+	priv->pdev = pdev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ndev->base_addr = res->start;
@@ -491,7 +494,7 @@ static int moxart_mac_probe(struct platform_device *pdev)
 	priv->tx_buf_size = TX_BUF_SIZE;
 	priv->rx_buf_size = RX_BUF_SIZE;
 
-	priv->tx_desc_base = dma_alloc_coherent(NULL, TX_REG_DESC_SIZE *
+	priv->tx_desc_base = dma_alloc_coherent(&pdev->dev, TX_REG_DESC_SIZE *
 						TX_DESC_NUM, &priv->tx_base,
 						GFP_DMA | GFP_KERNEL);
 	if (!priv->tx_desc_base) {
@@ -499,7 +502,7 @@ static int moxart_mac_probe(struct platform_device *pdev)
 		goto init_fail;
 	}
 
-	priv->rx_desc_base = dma_alloc_coherent(NULL, RX_REG_DESC_SIZE *
+	priv->rx_desc_base = dma_alloc_coherent(&pdev->dev, RX_REG_DESC_SIZE *
 						RX_DESC_NUM, &priv->rx_base,
 						GFP_DMA | GFP_KERNEL);
 	if (!priv->rx_desc_base) {
diff --git a/drivers/net/ethernet/moxa/moxart_ether.h b/drivers/net/ethernet/moxa/moxart_ether.h
index bee608b547d1..bf4c3029cd0c 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.h
+++ b/drivers/net/ethernet/moxa/moxart_ether.h
@@ -292,6 +292,7 @@
 #define LINK_STATUS		0x4
 
 struct moxart_mac_priv_t {
+	struct platform_device *pdev;
 	void __iomem *base;
 	unsigned int reg_maccr;
 	unsigned int reg_imr;
-- 
2.20.1

