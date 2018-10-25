Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C4FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE17220848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="psvWZ1lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE17220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeJYWrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbeJYWrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:52 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272132085A;
        Thu, 25 Oct 2018 14:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476896;
        bh=fpvHzjiypylW1HR/O/IGKN+C3WoLRhzi+u8tB7bTkyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=psvWZ1ljUWQWCuECnJUjbv+XcFByrBc7pFWzaSUIL79IM2B0X0GfK2Os+wGm3fSCC
         kiq52r1Afi8rT92uSBXxxt2Yaun/PWjoMswuCutDaiOpwpzVqlgebVVK2d4WK2FsOf
         9oNgLuAVrjMtp06LP4eEMsGYiHbEgZ0u/B5Ls1Ew=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moshe Shemesh <moshe@mellanox.com>, kernel-team@fb.com,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 20/98] net/mlx5: Fix command completion after timeout access invalid structure
Date:   Thu, 25 Oct 2018 10:13:05 -0400
Message-Id: <20181025141423.213774-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit 061870800efb4e3d1ad4082a2569363629bdfcfc ]

Completion on timeout should not free the driver command entry structure
as it will need to access it again once real completion event from FW
will occur.

Fixes: 73dd3a4839c1 ('net/mlx5: Avoid using pending command interface slots')
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Cc: kernel-team@fb.com
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 9680c8805178..1d5263c46eee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -965,7 +965,7 @@ static int mlx5_cmd_invoke(struct mlx5_core_dev *dev, struct mlx5_cmd_msg *in,
 
 	err = wait_func(dev, ent);
 	if (err == -ETIMEDOUT)
-		goto out_free;
+		goto out;
 
 	ds = ent->ts2 - ent->ts1;
 	op = MLX5_GET(mbox_in, in->first.data, opcode);
@@ -1428,6 +1428,7 @@ void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool forced)
 					mlx5_core_err(dev, "Command completion arrived after timeout (entry idx = %d).\n",
 						      ent->idx);
 					free_ent(cmd, ent->idx);
+					free_cmd(ent);
 				}
 				continue;
 			}
@@ -1486,7 +1487,8 @@ void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool forced)
 				free_msg(dev, ent->in);
 
 				err = err ? err : ent->status;
-				free_cmd(ent);
+				if (!forced)
+					free_cmd(ent);
 				callback(err, context);
 			} else {
 				complete(&ent->done);
-- 
2.17.1

