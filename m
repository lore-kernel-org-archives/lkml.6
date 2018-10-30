Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07358C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BD52075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJvgYkyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BD52075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeJ3WUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbeJ3WUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:20:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A65822075D;
        Tue, 30 Oct 2018 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906036;
        bh=UEQ33jLgt5zC9RovDK5d0XbS8fluiB8GM4ynci80Rco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJvgYkywwBqlSgqXjEpsj1+owTzX7JLMfdAvdBdmpArA9HUjJFbd1S4XViz+33PvF
         itzRLMO1BzPwqXwyz37csZTNkk3cNT9dL7e/v3gfT3U8uEo64T0eQKoySx0uv7K3mg
         vfHdEnzkv3mf7cd8g4t1sDeQSZ1VGcL5ZBolE/7c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Talat Batheesh <talatb@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 06/33] net/mlx5: Fix memory leak when setting fpga ipsec caps
Date:   Tue, 30 Oct 2018 09:26:30 -0400
Message-Id: <20181030132657.217970-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Talat Batheesh <talatb@mellanox.com>

[ Upstream commit fd7e848077c1a466b9187537adce16658f7cb94b ]

Allocated memory for context should be freed once
finished working with it.

Fixes: d6c4f0298cec ("net/mlx5: Refactor accel IPSec code")
Signed-off-by: Talat Batheesh <talatb@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
index 5645a4facad2..b8ee9101c506 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
@@ -245,7 +245,7 @@ static void *mlx5_fpga_ipsec_cmd_exec(struct mlx5_core_dev *mdev,
 		return ERR_PTR(res);
 	}
 
-	/* Context will be freed by wait func after completion */
+	/* Context should be freed by the caller after completion. */
 	return context;
 }
 
@@ -418,10 +418,8 @@ static int mlx5_fpga_ipsec_set_caps(struct mlx5_core_dev *mdev, u32 flags)
 	cmd.cmd = htonl(MLX5_FPGA_IPSEC_CMD_OP_SET_CAP);
 	cmd.flags = htonl(flags);
 	context = mlx5_fpga_ipsec_cmd_exec(mdev, &cmd, sizeof(cmd));
-	if (IS_ERR(context)) {
-		err = PTR_ERR(context);
-		goto out;
-	}
+	if (IS_ERR(context))
+		return PTR_ERR(context);
 
 	err = mlx5_fpga_ipsec_cmd_wait(context);
 	if (err)
@@ -435,6 +433,7 @@ static int mlx5_fpga_ipsec_set_caps(struct mlx5_core_dev *mdev, u32 flags)
 	}
 
 out:
+	kfree(context);
 	return err;
 }
 
-- 
2.17.1

