Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D41FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F145B222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896918;
	bh=UFKjV4ai0ILYYqeJXiUrKwtAo1MGnP+JmjOpPn+UVRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xCdxSmfABfBKl8Hwregh8xVfuN49Qu0lCJJMULgu1EayM8r7PHki8D7+mrhiyw1xL
	 EI+MzBclTl/1Vhpe+ThFFcObd+dPqsm9UaJOk20COdjpdAtnzNqlEDVKQL0yXm1BYk
	 +AuLD51zGeiKVBfEhGoNuqeK8d8E/Upo/xiRlHHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbfBKOzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388536AbfBKOzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:55:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B62B222A1;
        Mon, 11 Feb 2019 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896911;
        bh=UFKjV4ai0ILYYqeJXiUrKwtAo1MGnP+JmjOpPn+UVRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjK1gBiYTqr9ElEzTUXdpm+WiV9S6XtQYOXp8mJJoaVnKgMCRjsU2lM9+y0t1bMwe
         4+UbYLFnseJb5UacMdGAojAgPIEzyqosF4ZRIDWkf0P8Kd2zrHBOkMO7VFZvHEKB7R
         LrM2Q0b93hJsoFsoT/OHGltzPS57XnaZo8Ue/Y7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 029/205] net/mlx5: EQ, Use the right place to store/read IRQ affinity hint
Date:   Mon, 11 Feb 2019 15:17:07 +0100
Message-Id: <20190211141829.685918147@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index bf34264c734b..14bab8a5550d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1605,7 +1605,7 @@ static void mlx5e_close_cq(struct mlx5e_cq *cq)
 
 static int mlx5e_get_cpu(struct mlx5e_priv *priv, int ix)
 {
-	return cpumask_first(priv->mdev->priv.irq_info[ix].mask);
+	return cpumask_first(priv->mdev->priv.irq_info[ix + MLX5_EQ_VEC_COMP_BASE].mask);
 }
 
 static int mlx5e_open_tx_cqs(struct mlx5e_channel *c,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index e99f1382a4f0..558fc6a05e2a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -619,18 +619,19 @@ u64 mlx5_read_internal_timer(struct mlx5_core_dev *dev)
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
@@ -638,11 +639,12 @@ static int mlx5_irq_set_affinity_hint(struct mlx5_core_dev *mdev, int i)
 
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
index fb677e4f902d..88f0c530fe9c 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1195,7 +1195,7 @@ enum {
 static inline const struct cpumask *
 mlx5_get_vector_affinity_hint(struct mlx5_core_dev *dev, int vector)
 {
-	return dev->priv.irq_info[vector].mask;
+	return dev->priv.irq_info[vector + MLX5_EQ_VEC_COMP_BASE].mask;
 }
 
 #endif /* MLX5_DRIVER_H */
-- 
2.19.1



