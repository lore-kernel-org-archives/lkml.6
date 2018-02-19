Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeBSRLu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:11:50 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:38888 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeBSRLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:11:48 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, vbhadram@nvidia.com,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/7] net: stmmac: call correct function in stmmac_mac_config_rx_queues_routing()
Date: Mon, 19 Feb 2018 18:11:13 +0100
Message-Id: <20180219171116.15326-6-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180219171116.15326-1-niklas.cassel@axis.com>
References: <20180219171116.15326-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stmmac_mac_config_rx_queues_routing() incorrectly calls rx_queue_prio()
instead of rx_queue_routing().

This looks like a copy paste issue, since
stmmac_mac_config_rx_queues_prio() already calls rx_queue_prio(),
and both stmmac_mac_config_rx_queues_routing() and
stmmac_mac_config_rx_queues_prio() are very similar in structure.

Fixes: abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9881df126227..c8d86d77e03d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2432,7 +2432,7 @@ static void stmmac_mac_config_rx_queues_routing(struct stmmac_priv *priv)
 			continue;
 
 		packet = priv->plat->rx_queues_cfg[queue].pkt_route;
-		priv->hw->mac->rx_queue_prio(priv->hw, packet, queue);
+		priv->hw->mac->rx_queue_routing(priv->hw, packet, queue);
 	}
 }
 
-- 
2.14.2
