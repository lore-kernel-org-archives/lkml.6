Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DEAC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AE221726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KN5jdBes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfBAIsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:48:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfBAIsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JrHN5I49NV0qZtB9rpJexCxtdUcm7mEw+htvncP4Mps=; b=KN5jdBesGBbJzuiSAKnjYbrS45
        jODfuCNRFto1xnUgIKRdZiGl4x/76/4HKEhHe+2xeySDEe7hc+Sn6NwVl7L9Uz8yXNjYp2Uz+1Cyl
        Bqp8C1969QjzJ4W/YVeMp4gCwp2yw5g8YZY2uc7s14UmlaKk3H71QpO6+N/r76jTc65/IlaRlLMWv
        4QIUGeb1mSRZUEy+N5ridjhswONjwrG/FeMPTD/haxpa9+Lf2mHTkjTQUEA2lUTO1XaygyHNublia
        MXcYmuatFdhwP/tojkXqXgN68ynEMHrXTNjlZvAlOCexrtAYHCVlSbwPcDdUWc/vo1kTlMS4kwtXW
        cHrdkCiw==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUUk-0001P5-Pk; Fri, 01 Feb 2019 08:48:19 +0000
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
Subject: [PATCH 06/18] lantiq_etop: pass struct device to DMA API functions
Date:   Fri,  1 Feb 2019 09:47:49 +0100
Message-Id: <20190201084801.10983-7-hch@lst.de>
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

Note this driver seems to lack dma_unmap_* calls entirely, but fixing
that is left for another time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/lantiq_etop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 32ac9045cdae..f9bb890733b5 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -112,10 +112,12 @@ struct ltq_etop_priv {
 static int
 ltq_etop_alloc_skb(struct ltq_etop_chan *ch)
 {
+	struct ltq_etop_priv *priv = netdev_priv(ch->netdev);
+
 	ch->skb[ch->dma.desc] = netdev_alloc_skb(ch->netdev, MAX_DMA_DATA_LEN);
 	if (!ch->skb[ch->dma.desc])
 		return -ENOMEM;
-	ch->dma.desc_base[ch->dma.desc].addr = dma_map_single(NULL,
+	ch->dma.desc_base[ch->dma.desc].addr = dma_map_single(&priv->pdev->dev,
 		ch->skb[ch->dma.desc]->data, MAX_DMA_DATA_LEN,
 		DMA_FROM_DEVICE);
 	ch->dma.desc_base[ch->dma.desc].addr =
@@ -487,7 +489,7 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
 	netif_trans_update(dev);
 
 	spin_lock_irqsave(&priv->lock, flags);
-	desc->addr = ((unsigned int) dma_map_single(NULL, skb->data, len,
+	desc->addr = ((unsigned int) dma_map_single(&priv->pdev->dev, skb->data, len,
 						DMA_TO_DEVICE)) - byte_offset;
 	wmb();
 	desc->ctl = LTQ_DMA_OWN | LTQ_DMA_SOP | LTQ_DMA_EOP |
-- 
2.20.1

