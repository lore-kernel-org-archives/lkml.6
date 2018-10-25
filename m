Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BE4C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BB62085A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ9tvoTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BB62085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbeJYWvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbeJYWvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:04 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D375220868;
        Thu, 25 Oct 2018 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477087;
        bh=o94BwEvcOJLlnMCT5U+h9xh9AnU1BQoF3rWzk/dbDsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZ9tvoTdE+cRO337Tq8oqBJ4ROtYNVYD6WeAo83nTouDl2qJxmBA51EmCvrMy3pqE
         pZk08VvH+nfSvoUx2jxY/iCasLZcLL+/N7uoWq+Sd6JcgbSYQovHoKZE7RQsW1DvvG
         IePJh4DoxaDaq7fRItA4ao5rkcWeei8oOrZWHe3k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 37/65] net/mlx5e: Fix LRO modify
Date:   Thu, 25 Oct 2018 10:16:37 -0400
Message-Id: <20181025141705.213937-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit ab0394fe2c258fdb5086c51a251b28f8ee7ab35c ]

Ethtool LRO enable/disable is broken, as of today we only modify TCP
TIRs in order to apply the requested configuration.

Hardware requires that all TIRs pointing to the same RQ should share the
same LRO configuration. For that all other TIRs' LRO fields must be
modified as well.

Fixes: 5c50368f3831 ('net/mlx5e: Light-weight netdev open/stop')
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 90e876ecc720..765b069d6a90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1304,7 +1304,7 @@ static void mlx5e_build_tir_ctx_lro(void *tirc, struct mlx5e_priv *priv)
 			      lro_timer_supported_periods[2]));
 }
 
-static int mlx5e_modify_tir_lro(struct mlx5e_priv *priv, int tt)
+static int mlx5e_modify_tirs_lro(struct mlx5e_priv *priv)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 
@@ -1312,6 +1312,7 @@ static int mlx5e_modify_tir_lro(struct mlx5e_priv *priv, int tt)
 	void *tirc;
 	int inlen;
 	int err;
+	int tt;
 
 	inlen = MLX5_ST_SZ_BYTES(modify_tir_in);
 	in = mlx5_vzalloc(inlen);
@@ -1323,7 +1324,11 @@ static int mlx5e_modify_tir_lro(struct mlx5e_priv *priv, int tt)
 
 	mlx5e_build_tir_ctx_lro(tirc, priv);
 
-	err = mlx5_core_modify_tir(mdev, priv->tirn[tt], in, inlen);
+	for (tt = 0; tt < MLX5E_NUM_TT; tt++) {
+		err = mlx5_core_modify_tir(mdev, priv->tirn[tt], in, inlen);
+		if (err)
+			break;
+	}
 
 	kvfree(in);
 
@@ -1870,8 +1875,10 @@ static int mlx5e_set_features(struct net_device *netdev,
 			mlx5e_close_locked(priv->netdev);
 
 		priv->params.lro_en = !!(features & NETIF_F_LRO);
-		mlx5e_modify_tir_lro(priv, MLX5E_TT_IPV4_TCP);
-		mlx5e_modify_tir_lro(priv, MLX5E_TT_IPV6_TCP);
+		err = mlx5e_modify_tirs_lro(priv);
+		if (err)
+			mlx5_core_warn(priv->mdev, "lro modify failed, %d\n",
+				       err);
 
 		if (was_opened)
 			err = mlx5e_open_locked(priv->netdev);
-- 
2.17.1

