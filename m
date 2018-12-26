Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C31C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D203214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864458;
	bh=VPwiNYXg+2XpLkdGgmm2Xw1KLLmkQ13aSYN+U9KYetY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xhZbohQWGXgox+gJklAe6aS8u3N17GSGcVwldJvfe6LNptfcQeVelM/icSJdfwxfS
	 66lL3dltotsbCz+qFLtHnVbalhOiNFyBHXWhsv5bXfsIh/W8jHp14KRnJ+uDZ5DacT
	 v9vT8K8xDwnWmchjN3O1pbPjhdBpNMwSaZ/dQQt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeLZWrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:47:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbeLZWiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74EAA2054F;
        Wed, 26 Dec 2018 22:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863899;
        bh=VPwiNYXg+2XpLkdGgmm2Xw1KLLmkQ13aSYN+U9KYetY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdruWp0kBDQYtcMDPH1tewYzHOsjcru5+o35B+afBBmbnbF++GUyxHng5MnAnVSUD
         f5A+IOaS/rrDPPGo3TDPd6Hui4RQQgU2GOhRF7P5PJyd/T7R1Fsk2g8mkW6MtJAEnx
         s7RC5VqVBeTnxO4gVTYXV/jrzQKrSu4hyhdA/BUo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 84/97] net/mlx5e: RX, Fix wrong early return in receive queue poll
Date:   Wed, 26 Dec 2018 17:35:44 -0500
Message-Id: <20181226223557.149329-84-sashal@kernel.org>
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

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit bfc698254ba97b3e3e4ebbfae0ffa1f7e2fa0717 ]

When the completion queue of the RQ is empty, do not immediately return.
If left-over decompressed CQEs (from the previous cycle) were processed,
need to go to the finalization part of the poll function.

Bug exists only when CQE compression is turned ON.

This solves the following issue:
mlx5_core 0000:82:00.1: mlx5_eq_int:544:(pid 0): CQ error on CQN 0xc08, syndrome 0x1
mlx5_core 0000:82:00.1 p4p2: mlx5e_cq_error_event: cqn=0x000c08 event=0x04

Fixes: 4b7dfc992514 ("net/mlx5e: Early-return on empty completion queues")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index d543a5cff049..8262f093fec4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1150,7 +1150,7 @@ void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 int mlx5e_poll_rx_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_rq *rq = container_of(cq, struct mlx5e_rq, cq);
-	struct mlx5e_xdpsq *xdpsq;
+	struct mlx5e_xdpsq *xdpsq = &rq->xdpsq;
 	struct mlx5_cqe64 *cqe;
 	int work_done = 0;
 
@@ -1161,10 +1161,11 @@ int mlx5e_poll_rx_cq(struct mlx5e_cq *cq, int budget)
 		work_done += mlx5e_decompress_cqes_cont(rq, cq, 0, budget);
 
 	cqe = mlx5_cqwq_get_cqe(&cq->wq);
-	if (!cqe)
+	if (!cqe) {
+		if (unlikely(work_done))
+			goto out;
 		return 0;
-
-	xdpsq = &rq->xdpsq;
+	}
 
 	do {
 		if (mlx5_get_cqe_format(cqe) == MLX5_COMPRESSED) {
@@ -1179,6 +1180,7 @@ int mlx5e_poll_rx_cq(struct mlx5e_cq *cq, int budget)
 		rq->handle_rx_cqe(rq, cqe);
 	} while ((++work_done < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
+out:
 	if (xdpsq->doorbell) {
 		mlx5e_xmit_xdp_doorbell(xdpsq);
 		xdpsq->doorbell = false;
-- 
2.19.1

