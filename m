Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbeBSRLf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:11:35 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:38843 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753220AbeBSRLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:11:31 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, vbhadram@nvidia.com,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/7] net: stmmac: do not clear tx_skbuff entries in stmmac_xmit()/stmmac_tso_xmit()
Date: Mon, 19 Feb 2018 18:11:10 +0100
Message-Id: <20180219171116.15326-3-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180219171116.15326-1-niklas.cassel@axis.com>
References: <20180219171116.15326-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tx_skbuff is initialized to NULL in init_dma_tx_desc_rings(), which is
called from ndo_open().

stmmac_tx_clean() frees any non-NULL skb, and sets the tx_skbuff
entry to NULL. Hence, there is no need to set skbuff entries to NULL
in stmmac_xmit()/stmmac_tso_xmit(), and doing so falsely gives the
reader the impression that it is needed.
Do not clear tx_skbuff entries in stmmac_xmit()/stmmac_tso_xmit().

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d38bf38f12f5..24afe7733cde 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2927,7 +2927,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
 		tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_frag_size(frag);
-		tx_q->tx_skbuff[tx_q->cur_tx] = NULL;
 		tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = true;
 	}
 
@@ -3102,8 +3101,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (dma_mapping_error(priv->device, des))
 			goto dma_map_err; /* should reuse desc w/o issues */
 
-		tx_q->tx_skbuff[entry] = NULL;
-
 		tx_q->tx_skbuff_dma[entry].buf = des;
 		if (unlikely(priv->synopsys_id >= DWMAC_CORE_4_00))
 			desc->des0 = cpu_to_le32(des);
-- 
2.14.2
