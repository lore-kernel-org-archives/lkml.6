Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D519AECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4AF2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjlRkwW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4AF2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeKIHh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbeKIHh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:26 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64B0D20818;
        Thu,  8 Nov 2018 21:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714397;
        bh=z+/JXib04T35HdBiAyAV3iElW6udOtIkqyKjaSWVF/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjlRkwW9jA03wxiWo04HgbLr5NDsN+HvObUCRkoz5+rqSbnlYD/M0+nLqX8pJBmBW
         zI/yGRmuahCJwfqrI45m9kAZEcu8RXClfMybki+aODv5+sKek4cN6AF71lguRFrlbc
         m4zOotGmYIIgAXhcM5t+wsFZyUXYbmiedI7IZPS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 056/114] net/mlx5e: Correctly handle RSS indirection table when changing number of channels
Date:   Thu,  8 Nov 2018 13:51:11 -0800
Message-Id: <20181108215106.188206690@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 85082dba0a5059c538cfa786d07f5ec5370d22fe ]

Upon changing num_channels, reset the RSS indirection table to
match the new value.

Fixes: 2d75b2bc8a8c ('net/mlx5e: Add ethtool RSS configuration options')
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  2 ++
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c  |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 15 +++++++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 22e72bf1ae48..7a716733d9ca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -586,6 +586,8 @@ int mlx5e_redirect_rqt(struct mlx5e_priv *priv, enum mlx5e_rqt_ix rqt_ix);
 
 int mlx5e_open_locked(struct net_device *netdev);
 int mlx5e_close_locked(struct net_device *netdev);
+void mlx5e_build_default_indir_rqt(u32 *indirection_rqt, int len,
+				   int num_channels);
 
 static inline void mlx5e_tx_notify_hw(struct mlx5e_sq *sq,
 				      struct mlx5e_tx_wqe *wqe, int bf_sz)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 7cc9df717323..7ee301310817 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -385,6 +385,8 @@ static int mlx5e_set_channels(struct net_device *dev,
 		mlx5e_close_locked(dev);
 
 	priv->params.num_channels = count;
+	mlx5e_build_default_indir_rqt(priv->params.indirection_rqt,
+				      MLX5E_INDIR_RQT_SIZE, count);
 
 	if (was_opened)
 		err = mlx5e_open_locked(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 765b069d6a90..26d25ecdca7e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1186,7 +1186,6 @@ static void mlx5e_fill_indir_rqt_rqns(struct mlx5e_priv *priv, void *rqtc)
 			ix = mlx5e_bits_invert(i, MLX5E_LOG_INDIR_RQT_SIZE);
 
 		ix = priv->params.indirection_rqt[ix];
-		ix = ix % priv->params.num_channels;
 		MLX5_SET(rqtc, rqtc, rq_num[i],
 			 test_bit(MLX5E_STATE_OPENED, &priv->state) ?
 			 priv->channel[ix]->rq.rqn :
@@ -1983,12 +1982,20 @@ u16 mlx5e_get_max_inline_cap(struct mlx5_core_dev *mdev)
 	       2 /*sizeof(mlx5e_tx_wqe.inline_hdr_start)*/;
 }
 
+void mlx5e_build_default_indir_rqt(u32 *indirection_rqt, int len,
+				   int num_channels)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		indirection_rqt[i] = i % num_channels;
+}
+
 static void mlx5e_build_netdev_priv(struct mlx5_core_dev *mdev,
 				    struct net_device *netdev,
 				    int num_channels)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
-	int i;
 
 	priv->params.log_sq_size           =
 		MLX5E_PARAMS_DEFAULT_LOG_SQ_SIZE;
@@ -2012,8 +2019,8 @@ static void mlx5e_build_netdev_priv(struct mlx5_core_dev *mdev,
 	netdev_rss_key_fill(priv->params.toeplitz_hash_key,
 			    sizeof(priv->params.toeplitz_hash_key));
 
-	for (i = 0; i < MLX5E_INDIR_RQT_SIZE; i++)
-		priv->params.indirection_rqt[i] = i % num_channels;
+	mlx5e_build_default_indir_rqt(priv->params.indirection_rqt,
+				      MLX5E_INDIR_RQT_SIZE, num_channels);
 
 	priv->params.lro_wqe_sz            =
 		MLX5E_PARAMS_DEFAULT_LRO_WQE_SZ;
-- 
2.17.1



