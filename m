Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC27C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340E3214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864717;
	bh=cX9LLWazw/s31m7t0q81ePr35kI6KwgSQbAtjmvO8hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gD3/ZNy6E0uiBfjLtGmeKvWrv/KmR+owxIWBKltRb77uKaMjy897lD/VeFuE9AmRu
	 0ul5Lbzz4dvrwU+KlojutbH9dGg07blKckofmuMHgjgX4gG5ZLk6ehyHaxrXOhtzO1
	 SQq0NWm2LZrIs7d5Lz1ORrDdbCy6cz/Z/MAxQOPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeLZWv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbeLZWhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A919218FE;
        Wed, 26 Dec 2018 22:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863828;
        bh=cX9LLWazw/s31m7t0q81ePr35kI6KwgSQbAtjmvO8hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlBB9kIxy1uRi9TXKBNcNIts2YuI2LHnqZ1ovdFQPBAuc1ONhR6MqgT/CHJOIpLDl
         Xhz4Ax6JVKdpNmYKKGo3zr9qMlZ6w3Lwz54H8nyk+XiMx2jAz2kdlBx77I63u83RRe
         2CWudDlG5nda+7Pba11B/fsq+azzw+wPDzozUeTw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 43/97] net/mlx5e: RX, Verify MPWQE stride size is in range
Date:   Wed, 26 Dec 2018 17:35:03 -0500
Message-Id: <20181226223557.149329-43-sashal@kernel.org>
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

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit e1c15b62b7015119d3e5915cd2ae3b89d59c2576 ]

Add check of MPWQE stride size is within range supported by HW. In case
calculated MPWQE stride size exceed range, linear SKB can't be used and
we should use non linear MPWQE instead.

Fixes: 619a8f2a42f1 ("net/mlx5e: Use linear SKB in Striding RQ")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index faa84b45e20a..06c3902d1f94 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -128,6 +128,8 @@ static bool mlx5e_rx_is_linear_skb(struct mlx5_core_dev *mdev,
 	return !params->lro_en && frag_sz <= PAGE_SIZE;
 }
 
+#define MLX5_MAX_MPWQE_LOG_WQE_STRIDE_SZ ((BIT(__mlx5_bit_sz(wq, log_wqe_stride_size)) - 1) + \
+					  MLX5_MPWQE_LOG_STRIDE_SZ_BASE)
 static bool mlx5e_rx_mpwqe_is_linear_skb(struct mlx5_core_dev *mdev,
 					 struct mlx5e_params *params)
 {
@@ -138,6 +140,9 @@ static bool mlx5e_rx_mpwqe_is_linear_skb(struct mlx5_core_dev *mdev,
 	if (!mlx5e_rx_is_linear_skb(mdev, params))
 		return false;
 
+	if (order_base_2(frag_sz) > MLX5_MAX_MPWQE_LOG_WQE_STRIDE_SZ)
+		return false;
+
 	if (MLX5_CAP_GEN(mdev, ext_stride_num_range))
 		return true;
 
-- 
2.19.1

