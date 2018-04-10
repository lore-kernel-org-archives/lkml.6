Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49J/1Ir9UoCVuWyW8QEn8woXyKrgBifPfJ7YOPiZbSidrUQhOTh/LvRUNUr7wp7izgogsaW
ARC-Seal: i=1; a=rsa-sha256; t=1523399622; cv=none;
        d=google.com; s=arc-20160816;
        b=M9n3RLoiBY6focblh+bnAQHUZcnUmy90H2t8ATr9nXMKMBmXxdnmSk+BnXTSSDL1zA
         tPzum3BHVly8PXeu4YtNMpKE/+sKUxQpVLVbL3U3arVr9hGGfBXMfAcfBWVsgohLz3wD
         LA9pTyWcpmCmyDi8ig6f5XPFZUvNGOeEvRtU4Z4ErojmEghohI5z6MNvLqZwgzk5YufA
         /tFN0avmcNzBQnQGjWQFbOoawCeCeCSYQ4a/J7JmWYitv+vHsYEo+ul8H2P22HDcPDMS
         kNn9cDElLEKNQp5HdaU9wmeJoFh0K2y2kjL2O8nnYGR8LOlmHyj4ksiRXoWSSMZCfeAP
         CDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=I2E8fPAvUyeXB9ilRRcrp0g0N8bfHsicIAZRFiziK78=;
        b=xbXGkEL/37JBfxxVkpY6kil454ceW1eh7u7JONoqYkwUUHoiReCLV9IxsmNK4WQX7v
         ZqfjM9LtI/oB3D2qYVt60NcgThACT2jJ6qwrXt21VQ0fgXKzBY9pAqMTlCR0AouPg9vF
         ZH4OcJ9w6f77GCEC5tqUhiiDzJhzB8s0Qsvcs2B3PX5FENQ95iQUPyXaE6KILWkC4CzP
         VpKVCEDB3u/9gIGWDCHv9n9j1r9aeO5q86/1R1SehINNLliBy9sLrNJGyn0g2/stsQTJ
         f/9YP8GVV8Ukz6FpIExQYnKqY9IVgBvK+tEeh+VaZYBA88bnXZQIU3wo5+r6i1+e28iN
         hnlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eran Ben Elisha <eranbe@mellanox.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 162/168] net/mlx4_en: Fix mixed PFC and Global pause user control requests
Date: Wed, 11 Apr 2018 00:25:04 +0200
Message-Id: <20180410212808.015923930@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400283001720607?=
X-GMAIL-MSGID: =?utf-8?q?1597400283001720607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eran Ben Elisha <eranbe@mellanox.com>


[ Upstream commit 6e8814ceb7e8f468659ef9253bd212c07ae19584 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c  |   72 +++++++++++++-----------
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |   33 ++++++-----
 drivers/net/ethernet/mellanox/mlx4/en_main.c    |    4 -
 3 files changed, 62 insertions(+), 47 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
@@ -156,57 +156,63 @@ static int mlx4_en_dcbnl_getnumtcs(struc
 static u8 mlx4_en_dcbnl_set_all(struct net_device *netdev)
 {
 	struct mlx4_en_priv *priv = netdev_priv(netdev);
+	struct mlx4_en_port_profile *prof = priv->prof;
 	struct mlx4_en_dev *mdev = priv->mdev;
+	u8 tx_pause, tx_ppp, rx_pause, rx_ppp;
 
 	if (!(priv->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
 		return 1;
 
 	if (priv->cee_config.pfc_state) {
 		int tc;
+		rx_ppp = prof->rx_ppp;
+		tx_ppp = prof->tx_ppp;
 
-		priv->prof->rx_pause = 0;
-		priv->prof->tx_pause = 0;
 		for (tc = 0; tc < CEE_DCBX_MAX_PRIO; tc++) {
 			u8 tc_mask = 1 << tc;
 
 			switch (priv->cee_config.dcb_pfc[tc]) {
 			case pfc_disabled:
-				priv->prof->tx_ppp &= ~tc_mask;
-				priv->prof->rx_ppp &= ~tc_mask;
+				tx_ppp &= ~tc_mask;
+				rx_ppp &= ~tc_mask;
 				break;
 			case pfc_enabled_full:
-				priv->prof->tx_ppp |= tc_mask;
-				priv->prof->rx_ppp |= tc_mask;
+				tx_ppp |= tc_mask;
+				rx_ppp |= tc_mask;
 				break;
 			case pfc_enabled_tx:
-				priv->prof->tx_ppp |= tc_mask;
-				priv->prof->rx_ppp &= ~tc_mask;
+				tx_ppp |= tc_mask;
+				rx_ppp &= ~tc_mask;
 				break;
 			case pfc_enabled_rx:
-				priv->prof->tx_ppp &= ~tc_mask;
-				priv->prof->rx_ppp |= tc_mask;
+				tx_ppp &= ~tc_mask;
+				rx_ppp |= tc_mask;
 				break;
 			default:
 				break;
 			}
 		}
-		en_dbg(DRV, priv, "Set pfc on\n");
+		rx_pause = !!(rx_ppp || tx_ppp) ? 0 : prof->rx_pause;
+		tx_pause = !!(rx_ppp || tx_ppp) ? 0 : prof->tx_pause;
 	} else {
-		priv->prof->rx_pause = 1;
-		priv->prof->tx_pause = 1;
-		en_dbg(DRV, priv, "Set pfc off\n");
+		rx_ppp = 0;
+		tx_ppp = 0;
+		rx_pause = prof->rx_pause;
+		tx_pause = prof->tx_pause;
 	}
 
 	if (mlx4_SET_PORT_general(mdev->dev, priv->port,
 				  priv->rx_skb_size + ETH_FCS_LEN,
-				  priv->prof->tx_pause,
-				  priv->prof->tx_ppp,
-				  priv->prof->rx_pause,
-				  priv->prof->rx_ppp)) {
+				  tx_pause, tx_ppp, rx_pause, rx_ppp)) {
 		en_err(priv, "Failed setting pause params\n");
 		return 1;
 	}
 
+	prof->tx_ppp = tx_ppp;
+	prof->rx_ppp = rx_ppp;
+	prof->tx_pause = tx_pause;
+	prof->rx_pause = rx_pause;
+
 	return 0;
 }
 
@@ -408,6 +414,7 @@ static int mlx4_en_dcbnl_ieee_setpfc(str
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	struct mlx4_en_port_profile *prof = priv->prof;
 	struct mlx4_en_dev *mdev = priv->mdev;
+	u32 tx_pause, tx_ppp, rx_pause, rx_ppp;
 	int err;
 
 	en_dbg(DRV, priv, "cap: 0x%x en: 0x%x mbc: 0x%x delay: %d\n",
@@ -416,23 +423,26 @@ static int mlx4_en_dcbnl_ieee_setpfc(str
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
-	else
-		mlx4_en_update_pfc_stats_bitmap(mdev->dev, &priv->stats_bitmap,
-						prof->rx_ppp, prof->rx_pause,
-						prof->tx_ppp, prof->tx_pause);
+		return err;
+	}
+
+	mlx4_en_update_pfc_stats_bitmap(mdev->dev, &priv->stats_bitmap,
+					rx_ppp, rx_pause, tx_ppp, tx_pause);
+
+	prof->tx_ppp = tx_ppp;
+	prof->rx_ppp = rx_ppp;
+	prof->rx_pause = rx_pause;
+	prof->tx_pause = tx_pause;
 
 	return err;
 }
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1046,27 +1046,32 @@ static int mlx4_en_set_pauseparam(struct
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
-	else
-		mlx4_en_update_pfc_stats_bitmap(mdev->dev, &priv->stats_bitmap,
-						priv->prof->rx_ppp,
-						priv->prof->rx_pause,
-						priv->prof->tx_ppp,
-						priv->prof->tx_pause);
+				    tx_pause, tx_ppp, rx_pause, rx_ppp);
+	if (err) {
+		en_err(priv, "Failed setting pause params, err = %d\n", err);
+		return err;
+	}
+
+	mlx4_en_update_pfc_stats_bitmap(mdev->dev, &priv->stats_bitmap,
+					rx_ppp, rx_pause, tx_ppp, tx_pause);
+
+	priv->prof->tx_pause = tx_pause;
+	priv->prof->rx_pause = rx_pause;
+	priv->prof->tx_ppp = tx_ppp;
+	priv->prof->rx_ppp = rx_ppp;
 
 	return err;
 }
--- a/drivers/net/ethernet/mellanox/mlx4/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_main.c
@@ -163,9 +163,9 @@ static void mlx4_en_get_profile(struct m
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
