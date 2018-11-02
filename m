Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4590BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1935720847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBysLHkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1935720847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbeKCD7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbeKCD7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:59:31 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E85D620848;
        Fri,  2 Nov 2018 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184676;
        bh=eEgUi93P7AwMPmrqPCoXaURcQwA2ho5I0ebFbZdAqrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBysLHkmJM1LkNBVxnv5ZmJdyRWzzy10NU7r1+rBbhCX5LQYBXsHJjQScJu6DEYtS
         5/HJl1ZCg+WrL0nguGXeLeaChjXVgtNd8Ng1jM8vJA942TA0JobcPKK0E2IHMiMglG
         Cxl3ICI/cqDeRW0MgthxXNc7FT39mjJtH4zsmW40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shay Agroskin <shayag@mellanox.com>,
        Huy Nguyen <huyn@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 065/143] net/mlx5e: Refine ets validation function
Date:   Fri,  2 Nov 2018 19:34:10 +0100
Message-Id: <20181102182902.353102140@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



