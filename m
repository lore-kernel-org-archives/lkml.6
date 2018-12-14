Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFDFC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C5620892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790380;
	bh=AcqPGrwQiEAtNqaMP/p5O6Sgew5sJvT4qyINc9qRQdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SnndouJOhCmuifaIZTwbUPiSrRd4oKOUrNnB8GC7eoFg2x+ZQgBbI1eZObcJVJCyV
	 ek15FSHBLC9h01XQIa5+LidUNs/vq6QrYXQ6gs9OMmkQ7yoeulB0CmFCk7FmAYeQec
	 P11x2cjxUComxZngFakkDffWFdy/hHebONQAbduY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C5620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbeLNM0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:26:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730665AbeLNML6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:11:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 966B221473;
        Fri, 14 Dec 2018 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789518;
        bh=AcqPGrwQiEAtNqaMP/p5O6Sgew5sJvT4qyINc9qRQdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVkZLmx+047I/wzXofhSku8zdDA+OAMGKnEnBAtV2H8a8Y+pww5o5mPFMHpGmmow8
         +qJlxl7IQJDJfIu7G2TSGFvSGpJAagyucNpgeJyL/HAcwgC3RmAHI6dGRjoZIw1Mj3
         09eTnCg+fiqf1XH90ZKV16u80rN7jqvF1SpMdcBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 24/51] RDMA/mlx5: Fix fence type for IB_WR_LOCAL_INV WR
Date:   Fri, 14 Dec 2018 13:00:26 +0100
Message-Id: <20181214115715.592508868@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index f8f7a2191b98..f89489b28575 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3888,17 +3888,18 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
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
2.19.1



