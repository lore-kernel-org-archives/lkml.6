Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1767C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2CA217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130631;
	bh=u25FUZk6VEy7TIP+B8vDg6j5taP8xKOB03A/gfl97Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Un0r0Ca22ueOQLhUBK93kgHQJZnR/wxhSvdfed7A1LeUxiEZcPTvWtjKeiynTl0Qh
	 WathVzk3MRCXJcGvJvXwSmQYz1832Q58jenqcmxiqtV9OuJ/PuT0evVTueG7CvjS1x
	 ZwNF2iZD878SmY/skBrRnxHl0fnSY2S5fsUWDgrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbfBYVhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732428AbfBYVhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:37:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF9CD217F5;
        Mon, 25 Feb 2019 21:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130628;
        bh=u25FUZk6VEy7TIP+B8vDg6j5taP8xKOB03A/gfl97Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbDBDGkE6vSFXockwvVuw7WZVA33iI9v54u5VCcV1ocgpwNt3DqLF0M5Yvda4EjUF
         A3JWncF3I1OtEf1RgkxT30JFpYsh/lHAZo7bfPzDbT87lXPR8Vgl0wCNfu8Zy2djsB
         PHHDXxJKMea83jZAitRTEqaw1qlmVwndxR4iE7EI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.20 144/183] net/mlx5e: XDP, fix redirect resources availability check
Date:   Mon, 25 Feb 2019 22:11:57 +0100
Message-Id: <20190225195119.168347948@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -636,6 +636,7 @@ enum {
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
@@ -2903,6 +2903,7 @@ void mlx5e_activate_priv_channels(struct
 
 	mlx5e_build_tx2sq_maps(priv);
 	mlx5e_activate_channels(&priv->channels);
+	mlx5e_xdp_tx_enable(priv);
 	netif_tx_start_all_queues(priv->netdev);
 
 	if (MLX5_ESWITCH_MANAGER(priv->mdev))
@@ -2924,6 +2925,7 @@ void mlx5e_deactivate_priv_channels(stru
 	 */
 	netif_tx_stop_all_queues(priv->netdev);
 	netif_tx_disable(priv->netdev);
+	mlx5e_xdp_tx_disable(priv);
 	mlx5e_deactivate_channels(&priv->channels);
 }
 


