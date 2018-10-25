Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538B5ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141F420848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpuu4GnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141F420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeJYWs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbeJYWs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:27 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1401620883;
        Thu, 25 Oct 2018 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476931;
        bh=0HCbMVdpOWuYboyeNgudtmLbyMuE9dDw1id3ZbiHZ34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpuu4GnLmhKXFR331bh8pNoivBI/3baP13VzOemx/3wrgVst/fYq+kbYKjq7N4trl
         BR+LQtRZeVa3vIAObNmwYPnZil5urTt4Kk7TeiyuR+XiLOSKilo25eM9GQe85slpYn
         1Qvtr0km0czzoFclFtMKa9PmI3M0UThsnO5EQjGQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 45/98] net/mlx5: Fix driver load error flow when firmware is stuck
Date:   Thu, 25 Oct 2018 10:13:30 -0400
Message-Id: <20181025141423.213774-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gal Pressman <galp@mellanox.com>

[ Upstream commit 8ce59b16b4b6eacedaec1f7b652b4781cdbfe15f ]

When wait for firmware init fails, previous code would mistakenly
return success and cause inconsistency in the driver state.

Fixes: 6c780a0267b8 ("net/mlx5: Wait for FW readiness before initializing command interface")
Signed-off-by: Gal Pressman <galp@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 6698a3a07406..d676088512cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -957,7 +957,7 @@ static int mlx5_load_one(struct mlx5_core_dev *dev, struct mlx5_priv *priv,
 	if (err) {
 		dev_err(&dev->pdev->dev, "Firmware over %d MS in pre-initializing state, aborting\n",
 			FW_PRE_INIT_TIMEOUT_MILI);
-		goto out;
+		goto out_err;
 	}
 
 	err = mlx5_cmd_init(dev);
-- 
2.17.1

