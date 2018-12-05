Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779B9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4122087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1BldZZQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4122087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbeLEJos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:44:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbeLEJor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:44:47 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9E82133F;
        Wed,  5 Dec 2018 09:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003086;
        bh=+fLKdFTKr4fy8GTvZ8UuBoa/Iv+CBJoDlvl/93VD8hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1BldZZQZyB4xZCBuXASWma+qN2xWga3b4om+DigrRQlHdbxF/+u3yNcB7aNmBfPjL
         ZpWD0fe9lAqSxgnVMWS8kiKkGkVSiDBW0jdhWzYvRpRHLPsltzAqDxcXy7pZgXnuzY
         R6UUgAVPR1CDv3zTink3Dp5dl80Za3VhkQxziTcM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 25/69] RDMA/mlx5: Fix fence type for IB_WR_LOCAL_INV WR
Date:   Wed,  5 Dec 2018 04:42:03 -0500
Message-Id: <20181205094247.6556-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Majd Dibbiny <majd@mellanox.com>

[ Upstream commit 074fca3a18e7e1e0d4d7dcc9d7badc43b90232f4 ]

Currently, for IB_WR_LOCAL_INV WR, when the next fence is None, the
current fence will be SMALL instead of Normal Fence.

Without this patch krping doesn't work on CX-5 devices and throws
following error:

The error messages are from CX5 driver are: (from server side)
[ 710.434014] mlx5_0:dump_cqe:278:(pid 2712): dump error cqe
[ 710.434016] 00000000 00000000 00000000 00000000
[ 710.434016] 00000000 00000000 00000000 00000000
[ 710.434017] 00000000 00000000 00000000 00000000
[ 710.434018] 00000000 93003204 100000b8 000524d2
[ 710.434019] krping: cq completion failed with wr_id 0 status 4 opcode 128 vender_err 32

Fixed the logic to set the correct fence type.

Fixes: 6e8484c5cf07 ("RDMA/mlx5: set UMR wqe fence according to HCA cap")
Signed-off-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/qp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index dfc190055167..964c3a0bbf16 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3928,17 +3928,18 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 			goto out;
 		}
 
-		if (wr->opcode == IB_WR_LOCAL_INV ||
-		    wr->opcode == IB_WR_REG_MR) {
+		if (wr->opcode == IB_WR_REG_MR) {
 			fence = dev->umr_fence;
 			next_fence = MLX5_FENCE_MODE_INITIATOR_SMALL;
-		} else if (wr->send_flags & IB_SEND_FENCE) {
-			if (qp->next_fence)
-				fence = MLX5_FENCE_MODE_SMALL_AND_FENCE;
-			else
-				fence = MLX5_FENCE_MODE_FENCE;
-		} else {
-			fence = qp->next_fence;
+		} else  {
+			if (wr->send_flags & IB_SEND_FENCE) {
+				if (qp->next_fence)
+					fence = MLX5_FENCE_MODE_SMALL_AND_FENCE;
+				else
+					fence = MLX5_FENCE_MODE_FENCE;
+			} else {
+				fence = qp->next_fence;
+			}
 		}
 
 		switch (ibqp->qp_type) {
-- 
2.17.1

