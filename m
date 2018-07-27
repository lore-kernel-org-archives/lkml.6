Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD58C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473BD2089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473BD2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbeG0LJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:09:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51624 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbeG0LJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:09:13 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 713D6BB6;
        Fri, 27 Jul 2018 09:48:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shay Agroskin <shayag@mellanox.com>,
        Huy Nguyen <huyn@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.17 29/66] net/mlx5e: Refine ets validation function
Date:   Fri, 27 Jul 2018 11:45:22 +0200
Message-Id: <20180727093812.423545322@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -272,7 +272,8 @@ int mlx5e_dcbnl_ieee_setets_core(struct
 }
 
 static int mlx5e_dbcnl_validate_ets(struct net_device *netdev,
-				    struct ieee_ets *ets)
+				    struct ieee_ets *ets,
+				    bool zero_sum_allowed)
 {
 	bool have_ets_tc = false;
 	int bw_sum = 0;
@@ -297,8 +298,9 @@ static int mlx5e_dbcnl_validate_ets(stru
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
@@ -313,7 +315,7 @@ static int mlx5e_dcbnl_ieee_setets(struc
 	if (!MLX5_CAP_GEN(priv->mdev, ets))
 		return -EOPNOTSUPP;
 
-	err = mlx5e_dbcnl_validate_ets(netdev, ets);
+	err = mlx5e_dbcnl_validate_ets(netdev, ets, false);
 	if (err)
 		return err;
 
@@ -613,12 +615,9 @@ static u8 mlx5e_dcbnl_setall(struct net_
 			  ets.prio_tc[i]);
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


