Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A9CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D5D20651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865329;
	bh=MhfcB6mnXryeOA4Z3OTjonNzgpP0i/gdibMScDJw/cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tdLOI7/KiRomnqqaqUgvksUsWKfCo5vlow5kUwyQCybBiT1gYvGapnvAFP/tiySVa
	 1341Jac+s7MFPantces0Jvc9PPrUSmhUDgwEW6UIvtZyGszHnZCY17qldMyBkgdoyl
	 T39SShZOCq9trwn+cAEKu0W8IFAetklahIfQEYn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfAGMsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbfAGMso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86D4D20651;
        Mon,  7 Jan 2019 12:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865324;
        bh=MhfcB6mnXryeOA4Z3OTjonNzgpP0i/gdibMScDJw/cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w89FThBsvxH910j/e925ybsnxzMOc4cBCGXBM8jpFZ3jGeFL9whhHidKrGTVm5t7l
         64xjy8GAx9JgRNgpkuKstdC3etSM3YVMMnnV9nd9I/sORztCKVwMDJFJTEfNEv0TVf
         vFKdn0PBv8IrSUCKNBJFTSRsfhxov7jGXsm8lVE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 055/170] net/mlx5e: RX, Fix wrong early return in receive queue poll
Date:   Mon,  7 Jan 2019 13:31:22 +0100
Message-Id: <20190107104459.608083651@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1150,7 +1150,7 @@ mpwrq_cqe_out:
 int mlx5e_poll_rx_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_rq *rq = container_of(cq, struct mlx5e_rq, cq);
-	struct mlx5e_xdpsq *xdpsq;
+	struct mlx5e_xdpsq *xdpsq = &rq->xdpsq;
 	struct mlx5_cqe64 *cqe;
 	int work_done = 0;
 
@@ -1161,10 +1161,11 @@ int mlx5e_poll_rx_cq(struct mlx5e_cq *cq
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
@@ -1179,6 +1180,7 @@ int mlx5e_poll_rx_cq(struct mlx5e_cq *cq
 		rq->handle_rx_cqe(rq, cqe);
 	} while ((++work_done < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
+out:
 	if (xdpsq->doorbell) {
 		mlx5e_xmit_xdp_doorbell(xdpsq);
 		xdpsq->doorbell = false;


