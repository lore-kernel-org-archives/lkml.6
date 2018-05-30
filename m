Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeE3LHm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:07:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60683 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751925AbeE3LG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:58 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Eran Ben Elisha" <eranbe@mellanox.com>,
        "Tariq Toukan" <tariqt@mellanox.com>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.989076491@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 150/153] net/mlx4_en: Fix mixed PFC and Global pause
 user control requests
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eran Ben Elisha <eranbe@mellanox.com>

commit 6e8814ceb7e8f468659ef9253bd212c07ae19584 upstream.

Global pause and PFC configuration should be mutually exclusive (i.e. only
one of them at most can be set). However, once PFC was turned off,
driver automatically turned Global pause on. This is a bug.

Fix the driver behaviour to turn off PFC/Global once the user turned the
other on.

This also fixed a weird behaviour that at a current time, the profile
had both PFC and global pause configuration turned on, which is
Hardware-wise impossible and caused returning false positive indication
to query tools.

In addition, fix error code when setting global pause or PFC to change
metadata only upon successful change.

Also, removed useless debug print.

Fixes: af7d51852631 ("net/mlx4_en: Add DCB PFC support through CEE netlink commands")
Fixes: c27a02cd94d6 ("mlx4_en: Add driver for Mellanox ConnectX 10GbE NIC")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2:
 - Drop changes in en_dcb_nl.c
 - Don't call mlx4_en_update_pfc_stats_bitmap()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -362,21 +362,29 @@ static int mlx4_en_set_pauseparam(struct
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	struct mlx4_en_dev *mdev = priv->mdev;
+	u8 tx_pause, tx_ppp, rx_pause, rx_ppp;
 	int err;
 
 	if (pause->autoneg)
 		return -EINVAL;
 
-	priv->prof->tx_pause = pause->tx_pause != 0;
-	priv->prof->rx_pause = pause->rx_pause != 0;
+	tx_pause = !!(pause->tx_pause);
+	rx_pause = !!(pause->rx_pause);
+	rx_ppp = priv->prof->rx_ppp && !(tx_pause || rx_pause);
+	tx_ppp = priv->prof->tx_ppp && !(tx_pause || rx_pause);
+
 	err = mlx4_SET_PORT_general(mdev->dev, priv->port,
 				    priv->rx_skb_size + ETH_FCS_LEN,
-				    priv->prof->tx_pause,
-				    priv->prof->tx_ppp,
-				    priv->prof->rx_pause,
-				    priv->prof->rx_ppp);
-	if (err)
-		en_err(priv, "Failed setting pause params\n");
+				    tx_pause, tx_ppp, rx_pause, rx_ppp);
+	if (err) {
+		en_err(priv, "Failed setting pause params, err = %d\n", err);
+		return err;
+	}
+
+	priv->prof->tx_pause = tx_pause;
+	priv->prof->rx_pause = rx_pause;
+	priv->prof->tx_ppp = tx_ppp;
+	priv->prof->rx_ppp = rx_ppp;
 
 	return err;
 }
--- a/drivers/net/ethernet/mellanox/mlx4/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_main.c
@@ -112,9 +112,9 @@ static int mlx4_en_get_profile(struct ml
 		params->udp_rss = 0;
 	}
 	for (i = 1; i <= MLX4_MAX_PORTS; i++) {
-		params->prof[i].rx_pause = 1;
+		params->prof[i].rx_pause = !(pfcrx || pfctx);
 		params->prof[i].rx_ppp = pfcrx;
-		params->prof[i].tx_pause = 1;
+		params->prof[i].tx_pause = !(pfcrx || pfctx);
 		params->prof[i].tx_ppp = pfctx;
 		params->prof[i].tx_ring_size = MLX4_EN_DEF_TX_RING_SIZE;
 		params->prof[i].rx_ring_size = MLX4_EN_DEF_RX_RING_SIZE;
