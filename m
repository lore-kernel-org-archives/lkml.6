Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1407C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACC72089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1CaS4WY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACC72089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeJQBDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbeJQBDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:02 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91DB920866;
        Tue, 16 Oct 2018 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709900;
        bh=tluQO4r6Stv0h+yJD4NHbZFGJrnctxU07puSqs+enKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1CaS4WYgFxmfOGA9NjG6RXo2ZTrOKqvL6Sbj1Q2xFy5J7Ht4fhQfVxPvt1QH9rzs
         0YkHcoLIbplc99HWd7YQucReFpZrvYPMMWZTNyYXrtDoCx010TvfVwux8XjORk/8WO
         QPnlcGFymVXetleyisQBl3A9D43PLXba+UB5TGAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <jpinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 4.18 033/135] net: stmmac: Fixup the tail addr setting in xmit path
Date:   Tue, 16 Oct 2018 19:04:23 +0200
Message-Id: <20181016170517.290499992@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2193,8 +2193,7 @@ static int stmmac_init_dma_engine(struct
 		stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 				    tx_q->dma_tx_phy, chan);
 
-		tx_q->tx_tail_addr = tx_q->dma_tx_phy +
-			    (DMA_TX_SIZE * sizeof(struct dma_desc));
+		tx_q->tx_tail_addr = tx_q->dma_tx_phy;
 		stmmac_set_tx_tail_ptr(priv, priv->ioaddr,
 				       tx_q->tx_tail_addr, chan);
 	}
@@ -2971,6 +2970,7 @@ static netdev_tx_t stmmac_tso_xmit(struc
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
+	tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * sizeof(*desc));
 	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, queue);
 
 	return NETDEV_TX_OK;
@@ -3178,6 +3178,8 @@ static netdev_tx_t stmmac_xmit(struct sk
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+
+	tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * sizeof(*desc));
 	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, queue);
 
 	return NETDEV_TX_OK;


