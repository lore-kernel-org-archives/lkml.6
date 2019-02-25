Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F86BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F01720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129951;
	bh=yvaeRC5JmANXwZ4xjMythNCdv+9zHc8g+jMOxXg6MzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dNq1OS+1ZBIXivYcV/tOgOEuddweeBFi13Ou8ej02qAq+n0tlYvJ3E3HCHhRK8h9T
	 ffxVwxnFY9LDfObhYDg7rh4pNN0g/hzBmBNh3IN2sUx174DUmfoVp8JKz8JeIZSEfw
	 2Xpt0rQ1/YKF4Phe1MkXhLwtEHaLxPeFulqCaDAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfBYVZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:25:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731452AbfBYVZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:25:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5B1A2084D;
        Mon, 25 Feb 2019 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129944;
        bh=yvaeRC5JmANXwZ4xjMythNCdv+9zHc8g+jMOxXg6MzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QuM57hdSOLYH17wqpSiCN0G5hnAL0CabLfkXKG7B52zyzux0rmx3tbCZuf1M/nMIy
         JclJl25/WyW1eESyaRJ50exk3rNmAlRbkJIcCGFjuUORcP7fy9Omn8TL9GXJ0v1xVF
         tn1EAcZen1HNiUNAZagLnExDrOVuRH5JwBnR3Rf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 118/152] net/mlx5e: XDP, fix redirect resources availability check
Date:   Mon, 25 Feb 2019 22:11:50 +0100
Message-Id: <20190225195051.208193649@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit 407e17b1a69a51ba9a512a04342da56c1f931df4 ]

Currently mlx5 driver creates xdp redirect hw queues unconditionally on
netdevice open, This is great until someone starts redirecting XDP traffic
via ndo_xdp_xmit on mlx5 device and changes the device configuration at
the same time, this might cause crashes, since the other device's napi
is not aware of the mlx5 state change (resources un-availability).

To fix this we must synchronize with other devices napi's on the system.
Added a new flag under mlx5e_priv to determine XDP TX resources are
available, set/clear it up when necessary and use synchronize_rcu()
when the flag is turned off, so other napi's are in-sync with it, before
we actually cleanup the hw resources.

The flag is tested prior to committing to transmit on mlx5e_xdp_xmit, and
it is sufficient to determine if it safe to transmit or not. The other
two internal flags (MLX5E_STATE_OPENED and MLX5E_SQ_STATE_ENABLED) become
unnecessary. Thus, they are removed from data path.

Fixes: 58b99ee3e3eb ("net/mlx5e: Add support for XDP_REDIRECT in device-out side")
Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c  |    6 ++----
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h  |   17 +++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |    2 ++
 4 files changed, 22 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -633,6 +633,7 @@ enum {
 	MLX5E_STATE_ASYNC_EVENTS_ENABLED,
 	MLX5E_STATE_OPENED,
 	MLX5E_STATE_DESTROYING,
+	MLX5E_STATE_XDP_TX_ENABLED,
 };
 
 struct mlx5e_rqt {
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -262,7 +262,8 @@ int mlx5e_xdp_xmit(struct net_device *de
 	int sq_num;
 	int i;
 
-	if (unlikely(!test_bit(MLX5E_STATE_OPENED, &priv->state)))
+	/* this flag is sufficient, no need to test internal sq state */
+	if (unlikely(!mlx5e_xdp_tx_is_enabled(priv)))
 		return -ENETDOWN;
 
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
@@ -275,9 +276,6 @@ int mlx5e_xdp_xmit(struct net_device *de
 
 	sq = &priv->channels.c[sq_num]->xdpsq;
 
-	if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state)))
-		return -ENETDOWN;
-
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
 		struct mlx5e_xdp_info xdpi;
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -49,6 +49,23 @@ bool mlx5e_xmit_xdp_frame(struct mlx5e_x
 int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 		   u32 flags);
 
+static inline void mlx5e_xdp_tx_enable(struct mlx5e_priv *priv)
+{
+	set_bit(MLX5E_STATE_XDP_TX_ENABLED, &priv->state);
+}
+
+static inline void mlx5e_xdp_tx_disable(struct mlx5e_priv *priv)
+{
+	clear_bit(MLX5E_STATE_XDP_TX_ENABLED, &priv->state);
+	/* let other device's napi(s) see our new state */
+	synchronize_rcu();
+}
+
+static inline bool mlx5e_xdp_tx_is_enabled(struct mlx5e_priv *priv)
+{
+	return test_bit(MLX5E_STATE_XDP_TX_ENABLED, &priv->state);
+}
+
 static inline void mlx5e_xmit_xdp_doorbell(struct mlx5e_xdpsq *sq)
 {
 	struct mlx5_wq_cyc *wq = &sq->wq;
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2890,6 +2890,7 @@ void mlx5e_activate_priv_channels(struct
 
 	mlx5e_build_tx2sq_maps(priv);
 	mlx5e_activate_channels(&priv->channels);
+	mlx5e_xdp_tx_enable(priv);
 	netif_tx_start_all_queues(priv->netdev);
 
 	if (MLX5_ESWITCH_MANAGER(priv->mdev))
@@ -2911,6 +2912,7 @@ void mlx5e_deactivate_priv_channels(stru
 	 */
 	netif_tx_stop_all_queues(priv->netdev);
 	netif_tx_disable(priv->netdev);
+	mlx5e_xdp_tx_disable(priv);
 	mlx5e_deactivate_channels(&priv->channels);
 }
 


