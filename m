Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C6AC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C092089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqIIEVrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C092089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJHWiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbeJHWiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 775522089D;
        Mon,  8 Oct 2018 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012352;
        bh=F+ECAOT6aYPdsOB/wj0MyeryCyaGuDke5UA2ORJDJVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqIIEVrLifdSkGD3yo1CWneWR9+kgQistfsNXzG+70YihCJgo/vNXc9iQVOBeMJ5x
         YXLPoP8zPbHsxRhHdkOHpb/0svWdB6kMZEdtc3+nB4eE+9hLsBmtvFsSDzNfU/5z6l
         ILVnHKdBNNgGPGF2fVCs3dAxZ1s1mSWKEnhAuCek=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Joao Pinto <jpinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 26/58] net: stmmac: Fixup the tail addr setting in xmit path
Date:   Mon,  8 Oct 2018 11:24:51 -0400
Message-Id: <20181008152523.70705-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 0431100b3d82c509729ece1ab22ada2484e209c1 ]

Currently we are always setting the tail address of descriptor list to
the end of the pre-allocated list.

According to databook this is not correct. Tail address should point to
the last available descriptor + 1, which means we have to update the
tail address everytime we call the xmit function.

This should make no impact in older versions of MAC but in newer
versions there are some DMA features which allows the IP to fetch
descriptors in advance and in a non sequential order so its critical
that we set the tail address correctly.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Fixes: f748be531d70 ("stmmac: support new GMAC4")
Cc: David S. Miller <davem@davemloft.net>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 04de46601c87..1c6ba74e294b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2186,8 +2186,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 		stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 				    tx_q->dma_tx_phy, chan);
 
-		tx_q->tx_tail_addr = tx_q->dma_tx_phy +
-			    (DMA_TX_SIZE * sizeof(struct dma_desc));
+		tx_q->tx_tail_addr = tx_q->dma_tx_phy;
 		stmmac_set_tx_tail_ptr(priv, priv->ioaddr,
 				       tx_q->tx_tail_addr, chan);
 	}
@@ -2982,6 +2981,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
+	tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * sizeof(*desc));
 	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, queue);
 
 	return NETDEV_TX_OK;
@@ -3189,6 +3189,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr);
 
+	tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * sizeof(*desc));
 	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, queue);
 
 	return NETDEV_TX_OK;
-- 
2.17.1

