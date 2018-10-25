Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A06FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C003A20856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1zMxzdJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C003A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeJYWoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbeJYWoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:17 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1BDB20848;
        Thu, 25 Oct 2018 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476681;
        bh=LHHX4W1Cjw2bXCkCJStdF7Qks4/K2X/nA/+6jSmQJ4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zMxzdJBrbBy7WLHfAmUq2/CBsGswnfnDM5w0j2D51Dyn8Hcxv4ILr8zyot/xbp4X
         Zb0/scMnmBRI1rnyRh+yYiTNbQ46pHYJN0TrTpdK9QoKXTQblxYX6lQUmci7tr7+H3
         /ERpz6VluW0TDDHn8nzsSCZrskifNlOzgKFaMDT4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Noa Osherovich <noaos@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 19/46] IB/mlx5: Avoid passing an invalid QP type to firmware
Date:   Thu, 25 Oct 2018 10:10:26 -0400
Message-Id: <20181025141053.213330-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noa Osherovich <noaos@mellanox.com>

[ Upstream commit e7b169f34403becd3c9fd3b6e46614ab788f2187 ]

During QP creation, the mlx5 driver translates the QP type to an
internal value which is passed on to FW. There was no check to make
sure that the translated value is valid, and -EINVAL was coerced into
the mailbox command.

Current firmware refuses this as an invalid QP type, but future/past
firmware may do something else.

Fixes: 09a7d9eca1a6c ('{net,IB}/mlx5: QP/XRCD commands via mlx5 ifc')
Reviewed-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/qp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index ef9ee6c328a1..dfc190055167 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1527,6 +1527,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 	struct mlx5_ib_create_qp ucmd;
 	struct mlx5_ib_qp_base *base;
+	int mlx5_st;
 	void *qpc;
 	u32 *in;
 	int err;
@@ -1535,6 +1536,10 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	spin_lock_init(&qp->sq.lock);
 	spin_lock_init(&qp->rq.lock);
 
+	mlx5_st = to_mlx5_st(init_attr->qp_type);
+	if (mlx5_st < 0)
+		return -EINVAL;
+
 	if (init_attr->rwq_ind_tbl) {
 		if (!udata)
 			return -ENOSYS;
@@ -1688,7 +1693,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
 
-	MLX5_SET(qpc, qpc, st, to_mlx5_st(init_attr->qp_type));
+	MLX5_SET(qpc, qpc, st, mlx5_st);
 	MLX5_SET(qpc, qpc, pm_state, MLX5_QP_PM_MIGRATED);
 
 	if (init_attr->qp_type != MLX5_IB_QPT_REG_UMR)
-- 
2.17.1

