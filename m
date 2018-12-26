Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E031AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32F6214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864707;
	bh=c9rZo9mwoOprsVxQnvM5hprEsBqTWgNi6FxBMLIqd+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m7qrS0PJANR7nCCTLx6vX56VAJvf+TOvUz2gRgM4cwg80iqXBmcnYlBRw8mwajufI
	 UzUjKm74LK+qS2dAaqTbsGK7rD6DlgY55ZVltZU7Iyudibd2qVMDlUthkIbZPZOvXi
	 4G8RTCB7uRUMYLWl6QchGNdwy6QbgTDjOFlgLXU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbeLZWvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:51:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbeLZWhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8262121901;
        Wed, 26 Dec 2018 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863829;
        bh=c9rZo9mwoOprsVxQnvM5hprEsBqTWgNi6FxBMLIqd+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0n8+5vKooiuQIiBMzcJMn71SSDHiocGLS3SgLc0cjWNFrdeSara5GCowNgfMs/QL
         bi2reyDcbF/Vrx3G2UtDylihYU/oFdXn5gjM4HMiwE4nNp1RiH7vb8Q83kijEfW92p
         mzmc6yAhIcPe9JZ2S8qL3fJudoODHShemy77+Rhc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 44/97] net/mlx5e: Cancel DIM work on close SQ
Date:   Wed, 26 Dec 2018 17:35:04 -0500
Message-Id: <20181226223557.149329-44-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tal Gilboa <talgi@mellanox.com>

[ Upstream commit fa2bf86bab4bbc61e5678a42a14e40075093a98f ]

TXQ SQ closure is followed by closing the corresponding CQ. A pending
DIM work would try to modify the now non-existing CQ.
This would trigger an error:
[85535.835926] mlx5_core 0000:af:00.0: mlx5_cmd_check:769:(pid 124399):
MODIFY_CQ(0x403) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x1d7771)

Fix by making sure to cancel any pending DIM work before destroying the SQ.

Fixes: cbce4f444798 ("net/mlx5e: Enable adaptive-TX moderation")
Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 06c3902d1f94..7365899c3ac9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1388,6 +1388,7 @@ static void mlx5e_close_txqsq(struct mlx5e_txqsq *sq)
 	struct mlx5_core_dev *mdev = c->mdev;
 	struct mlx5_rate_limit rl = {0};
 
+	cancel_work_sync(&sq->dim.work);
 	mlx5e_destroy_sq(mdev, sq->sqn);
 	if (sq->rate_limit) {
 		rl.rate = sq->rate_limit;
-- 
2.19.1

