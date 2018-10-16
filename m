Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0123BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01902098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBLOqQ07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01902098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbeJQBJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeJQBJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:09:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0FA2089E;
        Tue, 16 Oct 2018 17:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710280;
        bh=WuFK3JVrToevEogrBHPba/MZjBbua3kHCgtJU67UFW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBLOqQ07Vt034haOgo76m8ZWzTPtHnpnZOAOBjQFFsvFngPNXfNX+g8b8yLE5sVsU
         QhKhmDQUhOdpA7MGX+sthmPAGpGatE9mdekpjpoms+aYngtddpG0gv8u9FDNOU7DZj
         hz6oGEjW2YLuhKcWmm+qeG30uvvzdCCxhkjjCvT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <jpinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 4.14 026/109] net: stmmac: Fixup the tail addr setting in xmit path
Date:   Tue, 16 Oct 2018 19:04:54 +0200
Message-Id: <20181016170526.521519874@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2190,8 +2190,7 @@ static int stmmac_init_dma_engine(struct
 						    priv->plat->dma_cfg,
 						    tx_q->dma_tx_phy, chan);
 
-			tx_q->tx_tail_addr = tx_q->dma_tx_phy +
-				    (DMA_TX_SIZE * sizeof(struct dma_desc));
+			tx_q->tx_tail_addr = tx_q->dma_tx_phy;
 			priv->hw->dma->set_tx_tail_ptr(priv->ioaddr,
 						       tx_q->tx_tail_addr,
 						       chan);
@@ -2963,6 +2962,7 @@ static netdev_tx_t stmmac_tso_xmit(struc
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
+	tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * sizeof(*desc));
 	priv->hw->dma->set_tx_tail_ptr(priv->ioaddr, tx_q->tx_tail_addr,
 				       queue);
 
@@ -3178,9 +3178,11 @@ static netdev_tx_t stmmac_xmit(struct sk
 
 	if (priv->synopsys_id < DWMAC_CORE_4_00)
 		priv->hw->dma->enable_dma_transmission(priv->ioaddr);
-	else
+	else {
+		tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * sizeof(*desc));
 		priv->hw->dma->set_tx_tail_ptr(priv->ioaddr, tx_q->tx_tail_addr,
 					       queue);
+	}
 
 	return NETDEV_TX_OK;
 


