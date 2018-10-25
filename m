Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FBCC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2787F20856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA4OjXiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2787F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeJYXR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeJYWoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:06 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CB22083E;
        Thu, 25 Oct 2018 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476670;
        bh=4qo/YMrltvhL4vKdd3OLpzUXkvc6d/exEyH1AAOHmM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QA4OjXiyxOo7TnaJwlIy8aDxUY4o6mjmznsw7X3/Rn45m4FNE9Lr11mM1gJHd2yjt
         rJLzxrYkHpdI+joiVd11LVLXQQIsUnmVI4uU/0+sxYfK2Wjmv4e+hH0sV4Ps65Uyfc
         P/qnSJELsE9ljqAVJLjg3ZY0nkNus/ebsSANrrfg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Israel Rukshin <israelr@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 11/46] net/mlx5: Fix mlx5_get_vector_affinity function
Date:   Thu, 25 Oct 2018 10:10:18 -0400
Message-Id: <20181025141053.213330-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

[ Upstream commit 6082d9c9c94a408d7409b5f2e4e42ac9e8b16d0d ]

Adding the vector offset when calling to mlx5_vector2eqn() is wrong.
This is because mlx5_vector2eqn() checks if EQ index is equal to vector number
and the fact that the internal completion vectors that mlx5 allocates
don't get an EQ index.

The second problem here is that using effective_affinity_mask gives the same
CPU for different vectors.
This leads to unmapped queues when calling it from blk_mq_rdma_map_queues().
This doesn't happen when using affinity_hint mask.

Fixes: 2572cf57d75a ("mlx5: fix mlx5_get_vector_affinity to start from completion vector 0")
Fixes: 05e0cc84e00c ("net/mlx5: Fix get vector affinity helper function")
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/main.c |  2 +-
 include/linux/mlx5/driver.h       | 12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index ab70194a73db..c3a4f5d92391 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3911,7 +3911,7 @@ mlx5_ib_get_vector_affinity(struct ib_device *ibdev, int comp_vector)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
 
-	return mlx5_get_vector_affinity(dev->mdev, comp_vector);
+	return mlx5_get_vector_affinity_hint(dev->mdev, comp_vector);
 }
 
 static void *mlx5_ib_add(struct mlx5_core_dev *mdev)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index c4d19e77fea8..5eff332092bc 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1193,25 +1193,19 @@ enum {
 };
 
 static inline const struct cpumask *
-mlx5_get_vector_affinity(struct mlx5_core_dev *dev, int vector)
+mlx5_get_vector_affinity_hint(struct mlx5_core_dev *dev, int vector)
 {
-	const struct cpumask *mask;
 	struct irq_desc *desc;
 	unsigned int irq;
 	int eqn;
 	int err;
 
-	err = mlx5_vector2eqn(dev, MLX5_EQ_VEC_COMP_BASE + vector, &eqn, &irq);
+	err = mlx5_vector2eqn(dev, vector, &eqn, &irq);
 	if (err)
 		return NULL;
 
 	desc = irq_to_desc(irq);
-#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
-	mask = irq_data_get_effective_affinity_mask(&desc->irq_data);
-#else
-	mask = desc->irq_common_data.affinity;
-#endif
-	return mask;
+	return desc->affinity_hint;
 }
 
 #endif /* MLX5_DRIVER_H */
-- 
2.17.1

