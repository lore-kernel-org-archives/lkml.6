Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id z6NXBVM9GVsKPwAAmS7hNA
	; Thu, 07 Jun 2018 14:12:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8AC28608B8; Thu,  7 Jun 2018 14:12:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B0E87608CE;
	Thu,  7 Jun 2018 14:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0E87608CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeFGOLx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:11:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39549 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933166AbeFGOJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:40 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbI-0005hL-Kq; Thu, 07 Jun 2018 15:09:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0003KJ-Jk; Thu, 07 Jun 2018 15:09:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tariq Toukan" <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eran Ben Elisha" <eranbe@mellanox.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.363472246@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 406/410] net/mlx4_en: Fix mixed PFC and Global pause
 user control requests
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16:
 - Drop changes to mlx4_en_dcbnl_set_all()
 - Don't call mlx4_en_update_pfc_stats_bitmap()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
@@ -162,6 +162,7 @@ static int mlx4_en_dcbnl_ieee_setpfc(str
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	struct mlx4_en_port_profile *prof = priv->prof;
 	struct mlx4_en_dev *mdev = priv->mdev;
+	u32 tx_pause, tx_ppp, rx_pause, rx_ppp;
 	int err;
 
 	en_dbg(DRV, priv, "cap: 0x%x en: 0x%x mbc: 0x%x delay: %d\n",
@@ -170,19 +171,23 @@ static int mlx4_en_dcbnl_ieee_setpfc(str
 			pfc->mbc,
 			pfc->delay);
 
-	prof->rx_pause = !pfc->pfc_en;
-	prof->tx_pause = !pfc->pfc_en;
-	prof->rx_ppp = pfc->pfc_en;
-	prof->tx_ppp = pfc->pfc_en;
+	rx_pause = prof->rx_pause && !pfc->pfc_en;
+	tx_pause = prof->tx_pause && !pfc->pfc_en;
+	rx_ppp = pfc->pfc_en;
+	tx_ppp = pfc->pfc_en;
 
 	err = mlx4_SET_PORT_general(mdev->dev, priv->port,
 				    priv->rx_skb_size + ETH_FCS_LEN,
-				    prof->tx_pause,
-				    prof->tx_ppp,
-				    prof->rx_pause,
-				    prof->rx_ppp);
-	if (err)
+				    tx_pause, tx_ppp, rx_pause, rx_ppp);
+	if (err) {
 		en_err(priv, "Failed setting pause params\n");
+		return err;
+	}
+
+	prof->tx_ppp = tx_ppp;
+	prof->rx_ppp = rx_ppp;
+	prof->rx_pause = rx_pause;
+	prof->tx_pause = tx_pause;
 
 	return err;
 }
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -474,21 +474,29 @@ static int mlx4_en_set_pauseparam(struct
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
@@ -137,9 +137,9 @@ static int mlx4_en_get_profile(struct ml
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
