Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2A1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609DD20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609DD20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbeGTNql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:46:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387878AbeGTNP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:15:56 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 22E21C7A;
        Fri, 20 Jul 2018 12:27:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 09/31] bcm63xx_enet: do not write to random DMA channel on BCM6345
Date:   Fri, 20 Jul 2018 14:13:39 +0200
Message-Id: <20180720121340.494128055@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121340.158484922@linuxfoundation.org>
References: <20180720121340.158484922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

commit d6213c1f2ad54a964b77471690264ed685718928 upstream.

The DMA controller regs actually point to DMA channel 0, so the write to
ENETDMA_CFG_REG will actually modify a random DMA channel.

Since DMA controller registers do not exist on BCM6345, guard the write
with the usual check for dma_has_sram.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1063,7 +1063,8 @@ static int bcm_enet_open(struct net_devi
 	val = enet_readl(priv, ENET_CTL_REG);
 	val |= ENET_CTL_ENABLE_MASK;
 	enet_writel(priv, val, ENET_CTL_REG);
-	enet_dma_writel(priv, ENETDMA_CFG_EN_MASK, ENETDMA_CFG_REG);
+	if (priv->dma_has_sram)
+		enet_dma_writel(priv, ENETDMA_CFG_EN_MASK, ENETDMA_CFG_REG);
 	enet_dmac_writel(priv, priv->dma_chan_en_mask,
 			 ENETDMAC_CHANCFG, priv->rx_chan);
 


