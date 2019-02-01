Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE98CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E34821726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="axF0SJy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfBAIsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:48:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfBAIsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YxHcnjYJIyN9dSw5XNTjzAkmGK4z/ENOgPTYk1FGBZI=; b=axF0SJy/rQePO2MdOwLhL4wPZm
        kUGopL49AOrSRzl7zCnocUs7dIHDJws07LpYoYsPTEyFk14KXaLkViehcpaVs2szWBv5z+Hj/AbNO
        P5fJbWvTN15cCZwf5Cv2GtV37plJ7YSdmW1UYy/S4PYgS04+9pbR+hiAfMCkVimPtvL9a+/xoBo65
        Ydnho+Kwb4CoNb/R+G7dECObMxocnY/6bQDDlwgPwEO4D0z+HZR6FK7CDPBfdRD/ww0KFQfYv2WTx
        XLnnEYImVHE298dffp2Q9L2pnQeB+3NhqHvTFs64TCXXrr3S6xQyZNcX9F+Y5bJqePrQd6frh+fcP
        ttlTkpsA==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUUi-0001OX-3c; Fri, 01 Feb 2019 08:48:16 +0000
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
Subject: [PATCH 05/18] macb_main: pass struct device to DMA API functions
Date:   Fri,  1 Feb 2019 09:47:48 +0100
Message-Id: <20190201084801.10983-6-hch@lst.de>
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
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2b2882615e8b..61a27963f1d1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3673,9 +3673,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		/* Store packet information (to free when Tx completed) */
 		lp->skb = skb;
 		lp->skb_length = skb->len;
-		lp->skb_physaddr = dma_map_single(NULL, skb->data, skb->len,
-							DMA_TO_DEVICE);
-		if (dma_mapping_error(NULL, lp->skb_physaddr)) {
+		lp->skb_physaddr = dma_map_single(&lp->pdev->dev, skb->data,
+						  skb->len, DMA_TO_DEVICE);
+		if (dma_mapping_error(&lp->pdev->dev, lp->skb_physaddr)) {
 			dev_kfree_skb_any(skb);
 			dev->stats.tx_dropped++;
 			netdev_err(dev, "%s: DMA mapping error\n", __func__);
@@ -3765,7 +3765,7 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 		if (lp->skb) {
 			dev_kfree_skb_irq(lp->skb);
 			lp->skb = NULL;
-			dma_unmap_single(NULL, lp->skb_physaddr,
+			dma_unmap_single(&lp->pdev->dev, lp->skb_physaddr,
 					 lp->skb_length, DMA_TO_DEVICE);
 			dev->stats.tx_packets++;
 			dev->stats.tx_bytes += lp->skb_length;
-- 
2.20.1

