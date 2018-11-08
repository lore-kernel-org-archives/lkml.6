Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219EC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588E220844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaZeAR+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588E220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeKIHhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730201AbeKIHhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:19 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B192146E;
        Thu,  8 Nov 2018 21:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714391;
        bh=XxOfmgCzmOkJ0Urq4aL12+m9+6VvRGsZhZynZUEKqM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RaZeAR+K5XDlvRN0Kt9sfrP8ozN9YL+kWBCPgbDQQ6vaI63XN6vI9QRdMGBTzvg5J
         2UmZrxDH49YFCFvbt9RdEThOUkszjMTZO27dGLi+jCxo7HcaHsXD8WrdoRn3wCNi+x
         E4ei+KfGH5SBshBTK+434nXS6QoTyJFQbGXoOyv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 055/114] net/mlx5e: Fix LRO modify
Date:   Thu,  8 Nov 2018 13:51:10 -0800
Message-Id: <20181108215106.095773567@linuxfoundation.org>
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



