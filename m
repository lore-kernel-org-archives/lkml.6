Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D0C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A23D20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791163;
	bh=7Sa1VPahd8a6Xp1wgb3m1D8REU58OfnfV4SUCME38iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TY09EnI9T21mRUgWcxuNAx21sOTMRRf0s7YRygR29Vevk6ZFxtVwq4dci4ul267VZ
	 Ks4xhvUN1PMa4WWUyu/WzuvxXr9sgNs5a/w3g9DIFj6URTy4EDodq/5HL1wB17c9j0
	 7OiVxnDaTJFBFk9X2IkgmiPmv04+tg//YyOOXhgI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A23D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbeLNMjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730564AbeLNME7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8840F21486;
        Fri, 14 Dec 2018 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789099;
        bh=7Sa1VPahd8a6Xp1wgb3m1D8REU58OfnfV4SUCME38iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRINOetlxgddW3tXFUnKiRgZzwSJ/Kve+KBHMbZt2Tj4+8sl69f5ye0pvfRnHcRTe
         zUQ1o7DVR8WGPAywho1hiD5LuvGKQfZxqOKzyEqd/4vwWKLunfNACzgtXRKwjWqBXW
         ysIUzXmy+f2MV6YSlCTXJ2gAkxRAjyol/CqFdL1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/142] RDMA/mlx5: Fix fence type for IB_WR_LOCAL_INV WR
Date:   Fri, 14 Dec 2018 12:59:16 +0100
Message-Id: <20181214115749.903324049@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index d53d954ac8af..183fe5c8ceb7 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4413,17 +4413,18 @@ static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
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



