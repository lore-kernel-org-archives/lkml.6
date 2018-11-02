Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AA8C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B512084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4j+EoaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B512084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbeKCD7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbeKCD7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:59:06 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 902D62082D;
        Fri,  2 Nov 2018 18:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184651;
        bh=FYwT6zCgrc+yBDfp9Ob7X9kLpCrD9Gkgm/bnQL4lzEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4j+EoaRztj+wzXOJEZUSPyRR8moRIRvNueaV/neo9ZOYeO9xTwF+IujJAfpYZIFU
         o6KL9F/uM8uces+nGqmDD2rml7ouGUkCWmqawL9cYEyB5LMgfyd3ICbxiEythfL2Wp
         gFFIwP5ta4MZTZET5yIACpJvOoylsD/HVFgmlVWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 060/143] net/mlx5: Fix mlx5_get_vector_affinity function
Date:   Fri,  2 Nov 2018 19:34:05 +0100
Message-Id: <20181102182901.906765329@linuxfoundation.org>
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



