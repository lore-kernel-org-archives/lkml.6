Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E53DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4461A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9DGFrns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4461A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeJYWrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbeJYWoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:13 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF7B2054F;
        Thu, 25 Oct 2018 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476677;
        bh=3qnM154ns53NrXPyFocqysseUqcJO2lWWxX6sYubi1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9DGFrnsfDnYrgEEmeGgH9NCYeGevt/UNvEEVqEtFEDcnIPVRdgQVzwYVmZoelMGK
         ytZTZzIzrkPK15e/9EmtQty7iiYXFGlQcsqmuMxYd0AZ4QMRz1L6cggqSVaNHlFige
         xSeDPGIHVe7jdoLJUIzdsA2wIwUKWFqgst1RUi9g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shay Agroskin <shayag@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 16/46] net/mlx5e: Refine ets validation function
Date:   Thu, 25 Oct 2018 10:10:23 -0400
Message-Id: <20181025141053.213330-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shay Agroskin <shayag@mellanox.com>

[ Upstream commit e279d634f3d57452eb106a0c0e99a6add3fba1a6 ]

Removed an error message received when configuring ETS total
bandwidth to be zero.
Our hardware doesn't support such configuration, so we shall
reject it in the driver. Nevertheless, we removed the error message
in order to eliminate error messages caused by old userspace tools
who try to pass such configuration.

Fixes: ff0891915cd7 ("net/mlx5e: Fix ETS BW check")
Signed-off-by: Shay Agroskin <shayag@mellanox.com>
Reviewed-by: Huy Nguyen <huyn@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_dcbnl.c  | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 9d64d0759ee9..a5dd99aaf321 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -257,7 +257,8 @@ int mlx5e_dcbnl_ieee_setets_core(struct mlx5e_priv *priv, struct ieee_ets *ets)
 }
 
 static int mlx5e_dbcnl_validate_ets(struct net_device *netdev,
-				    struct ieee_ets *ets)
+				    struct ieee_ets *ets,
+				    bool zero_sum_allowed)
 {
 	bool have_ets_tc = false;
 	int bw_sum = 0;
@@ -282,8 +283,9 @@ static int mlx5e_dbcnl_validate_ets(struct net_device *netdev,
 	}
 
 	if (have_ets_tc && bw_sum != 100) {
-		netdev_err(netdev,
-			   "Failed to validate ETS: BW sum is illegal\n");
+		if (bw_sum || (!bw_sum && !zero_sum_allowed))
+			netdev_err(netdev,
+				   "Failed to validate ETS: BW sum is illegal\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -298,7 +300,7 @@ static int mlx5e_dcbnl_ieee_setets(struct net_device *netdev,
 	if (!MLX5_CAP_GEN(priv->mdev, ets))
 		return -EOPNOTSUPP;
 
-	err = mlx5e_dbcnl_validate_ets(netdev, ets);
+	err = mlx5e_dbcnl_validate_ets(netdev, ets, false);
 	if (err)
 		return err;
 
@@ -477,12 +479,9 @@ static u8 mlx5e_dcbnl_setall(struct net_device *netdev)
 		ets.prio_tc[i]  = cee_cfg->prio_to_pg_map[i];
 	}
 
-	err = mlx5e_dbcnl_validate_ets(netdev, &ets);
-	if (err) {
-		netdev_err(netdev,
-			   "%s, Failed to validate ETS: %d\n", __func__, err);
+	err = mlx5e_dbcnl_validate_ets(netdev, &ets, true);
+	if (err)
 		goto out;
-	}
 
 	err = mlx5e_dcbnl_ieee_setets_core(priv, &ets);
 	if (err) {
-- 
2.17.1

