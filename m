Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F64C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3508821726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kPHcfP0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfBAIsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:48:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfBAIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jvXh2nGWWDi+i97GyziQAoz/cRdsHOCxPPGJzQv4Lzs=; b=kPHcfP0xs6RjXXDCs6UAZv01hT
        fs4kz/psbq6xjiMLPEmNEiprZdYKLWI19K1N/XLD5pkb6yD5mp7kjpZkr1KNj+lpZ+ZghM8kfVc3V
        kGg77BqmYfbSgMYzMAIcNy991S+Z/Lq0VVMRfqP8z7WwPXYZlcZk6Mn8Qj+MTsjRHx0IGoQ8zLGCP
        9nl189pv9ng2b5oSxj7i2ldJZLTXzyrm9qSnheSDWWjUHxOjbsdWVMn/AdN8S7u0g8WOTdA0AE1/q
        34R5JbVilnFazJiI/iRgSOzmQlnPS38gz1Ehbivx4pxPkuqMtSwO1Q0RpTnYMZ7ky4vwgwozRP1ez
        Az2+f4nA==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUUv-0001Rh-AG; Fri, 01 Feb 2019 08:48:29 +0000
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
Subject: [PATCH 10/18] smc911x: pass struct device to DMA API functions
Date:   Fri,  1 Feb 2019 09:47:53 +0100
Message-Id: <20190201084801.10983-11-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/smsc/smc911x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
index 8355dfbb8ec3..b550e624500d 100644
--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -1188,7 +1188,7 @@ smc911x_tx_dma_irq(void *data)
 
 	DBG(SMC_DEBUG_TX | SMC_DEBUG_DMA, dev, "TX DMA irq handler\n");
 	BUG_ON(skb == NULL);
-	dma_unmap_single(NULL, tx_dmabuf, tx_dmalen, DMA_TO_DEVICE);
+	dma_unmap_single(lp->dev, tx_dmabuf, tx_dmalen, DMA_TO_DEVICE);
 	netif_trans_update(dev);
 	dev_kfree_skb_irq(skb);
 	lp->current_tx_skb = NULL;
@@ -1219,7 +1219,7 @@ smc911x_rx_dma_irq(void *data)
 
 	DBG(SMC_DEBUG_FUNC, dev, "--> %s\n", __func__);
 	DBG(SMC_DEBUG_RX | SMC_DEBUG_DMA, dev, "RX DMA irq handler\n");
-	dma_unmap_single(NULL, rx_dmabuf, rx_dmalen, DMA_FROM_DEVICE);
+	dma_unmap_single(lp->dev, rx_dmabuf, rx_dmalen, DMA_FROM_DEVICE);
 	BUG_ON(skb == NULL);
 	lp->current_rx_skb = NULL;
 	PRINT_PKT(skb->data, skb->len);
-- 
2.20.1

