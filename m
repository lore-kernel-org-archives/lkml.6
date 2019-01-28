Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21351C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E312175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690349;
	bh=Y9+3cvLAcP94C/jHGHeoWt85uu3nn3+9PQvNbLtybvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pKhrlZVzau8OGKMfEB7u+13ahEscLqa/5L8pO5f+aQcJnqOBNbL7Xvx9ViQVQyTKY
	 m24hR9UqC6tDB5xLkw1QKPo6bIc5Mq0SffHrUF4KbUJolZ1yft2FNkwyy1/SnbXT9T
	 CBaLOx30Hf2AhRpzl2dckYYrbOV0lmk7A7NXQ4ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfA1Ppr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:45:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfA1Ppo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF16920880;
        Mon, 28 Jan 2019 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690343;
        bh=Y9+3cvLAcP94C/jHGHeoWt85uu3nn3+9PQvNbLtybvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wTiNjx8lZxjQnAH2SHG3S8hj7veT9FQEFChMNjnzaWxalkYMRTfTkOfJQHRQraKyA
         22HAKZdXWdBcObkSGJ5k5VX5PPyRlqqW2Uv4Si2FQujMQXGqtvQROsrLfVfb7YW1e6
         J0xMzOBn0ovTprFmKB4gL2zfE3RWC5jq8mTe3qtg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 058/304] net/mlx5: EQ, Use the right place to store/read IRQ affinity hint
Date:   Mon, 28 Jan 2019 10:39:35 -0500
Message-Id: <20190128154341.47195-58-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit 1e86ace4c140fd5a693e266c9b23409358f25381 ]

Currently the cpu affinity hint mask for completion EQs is stored and
read from the wrong place, since reading and storing is done from the
same index, there is no actual issue with that, but internal irq_info
for completion EQs stars at MLX5_EQ_VEC_COMP_BASE offset in irq_info
array, this patch changes the code to use the correct offset to store
and read the IRQ affinity hint.

Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c    | 14 ++++++++------
 include/linux/mlx5/driver.h                       |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b70cb6fd164c..9577d0657839 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1771,7 +1771,7 @@ static void mlx5e_close_cq(struct mlx5e_cq *cq)
 
 static int mlx5e_get_cpu(struct mlx5e_priv *priv, int ix)
 {
-	return cpumask_first(priv->mdev->priv.irq_info[ix].mask);
+	return cpumask_first(priv->mdev->priv.irq_info[ix + MLX5_EQ_VEC_COMP_BASE].mask);
 }
 
 static int mlx5e_open_tx_cqs(struct mlx5e_channel *c,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 28132c7dc05f..d5cea0a36e6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -640,18 +640,19 @@ u64 mlx5_read_internal_timer(struct mlx5_core_dev *dev)
 static int mlx5_irq_set_affinity_hint(struct mlx5_core_dev *mdev, int i)
 {
 	struct mlx5_priv *priv  = &mdev->priv;
-	int irq = pci_irq_vector(mdev->pdev, MLX5_EQ_VEC_COMP_BASE + i);
+	int vecidx = MLX5_EQ_VEC_COMP_BASE + i;
+	int irq = pci_irq_vector(mdev->pdev, vecidx);
 
-	if (!zalloc_cpumask_var(&priv->irq_info[i].mask, GFP_KERNEL)) {
+	if (!zalloc_cpumask_var(&priv->irq_info[vecidx].mask, GFP_KERNEL)) {
 		mlx5_core_warn(mdev, "zalloc_cpumask_var failed");
 		return -ENOMEM;
 	}
 
 	cpumask_set_cpu(cpumask_local_spread(i, priv->numa_node),
-			priv->irq_info[i].mask);
+			priv->irq_info[vecidx].mask);
 
 	if (IS_ENABLED(CONFIG_SMP) &&
-	    irq_set_affinity_hint(irq, priv->irq_info[i].mask))
+	    irq_set_affinity_hint(irq, priv->irq_info[vecidx].mask))
 		mlx5_core_warn(mdev, "irq_set_affinity_hint failed, irq 0x%.4x", irq);
 
 	return 0;
@@ -659,11 +660,12 @@ static int mlx5_irq_set_affinity_hint(struct mlx5_core_dev *mdev, int i)
 
 static void mlx5_irq_clear_affinity_hint(struct mlx5_core_dev *mdev, int i)
 {
+	int vecidx = MLX5_EQ_VEC_COMP_BASE + i;
 	struct mlx5_priv *priv  = &mdev->priv;
-	int irq = pci_irq_vector(mdev->pdev, MLX5_EQ_VEC_COMP_BASE + i);
+	int irq = pci_irq_vector(mdev->pdev, vecidx);
 
 	irq_set_affinity_hint(irq, NULL);
-	free_cpumask_var(priv->irq_info[i].mask);
+	free_cpumask_var(priv->irq_info[vecidx].mask);
 }
 
 static int mlx5_irq_set_affinity_hints(struct mlx5_core_dev *mdev)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index aa5963b5d38e..7d4ed995b4ce 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1309,7 +1309,7 @@ enum {
 static inline const struct cpumask *
 mlx5_get_vector_affinity_hint(struct mlx5_core_dev *dev, int vector)
 {
-	return dev->priv.irq_info[vector].mask;
+	return dev->priv.irq_info[vector + MLX5_EQ_VEC_COMP_BASE].mask;
 }
 
 #endif /* MLX5_DRIVER_H */
-- 
2.19.1

