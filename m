Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5057C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889CF20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSbrNdRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889CF20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeJ3WUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeJ3WUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:20:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8429620838;
        Tue, 30 Oct 2018 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906044;
        bh=kqQVZ5RKYfYQWWd0x9VoZ3sgmrCqD1q5O5fOd+ESQ/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSbrNdRHt4vGCCRsviSHLIhBuz1oCxusP8SUayhrXcZqEFxapWvvmCaJV+ECqLNCv
         RT/PqFYvT29ctXOL/gl9iFKFUZTRqQQOhF5dKQoxPfSWzMy7mvBX1TWmlPVqTLE4lf
         E2hm608dqrkLe6LcbH8tl03aXnl9n6govE4I/WfE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 08/33] net/mlx5: WQ, fixes for fragmented WQ buffers API
Date:   Tue, 30 Oct 2018 09:26:32 -0400
Message-Id: <20181030132657.217970-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit 37fdffb217a45609edccbb8b407d031143f551c0 ]

mlx5e netdevice used to calculate fragment edges by a call to
mlx5_wq_cyc_get_frag_size(). This calculation did not give the correct
indication for queues smaller than a PAGE_SIZE, (broken by default on
PowerPC, where PAGE_SIZE == 64KB).  Here it is replaced by the correct new
calls/API.

Since (TX/RX) Work Queues buffers are fragmented, here we introduce
changes to the API in core driver, so that it gets a stride index and
returns the index of last stride on same fragment, and an additional
wrapping function that returns the number of physically contiguous
strides that can be written contiguously to the work queue.

This obsoletes the following API functions, and their buggy
usage in EN driver:
* mlx5_wq_cyc_get_frag_size()
* mlx5_wq_cyc_ctr2fragix()

The new API improves modularity and hides the details of such
calculation for mlx5e netdevice and mlx5_ib rdma drivers.

New calculation is also more efficient, and improves performance
as follows:

Packet rate test: pktgen, UDP / IPv4, 64byte, single ring, 8K ring size.

Before: 16,477,619 pps
After:  17,085,793 pps

3.7% improvement

Fixes: 3a2f70331226 ("net/mlx5: Use order-0 allocations for all WQ types")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 12 +++++-----
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 22 +++++++++----------
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.h |  5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/wq.c  |  5 -----
 drivers/net/ethernet/mellanox/mlx5/core/wq.h  | 11 +++++-----
 include/linux/mlx5/driver.h                   |  8 +++++++
 6 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index d3a1dd20e41d..549e926265b6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -429,10 +429,9 @@ static inline u16 mlx5e_icosq_wrap_cnt(struct mlx5e_icosq *sq)
 
 static inline void mlx5e_fill_icosq_frag_edge(struct mlx5e_icosq *sq,
 					      struct mlx5_wq_cyc *wq,
-					      u16 pi, u16 frag_pi)
+					      u16 pi, u16 nnops)
 {
 	struct mlx5e_sq_wqe_info *edge_wi, *wi = &sq->db.ico_wqe[pi];
-	u8 nnops = mlx5_wq_cyc_get_frag_size(wq) - frag_pi;
 
 	edge_wi = wi + nnops;
 
@@ -451,15 +450,14 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	struct mlx5_wq_cyc *wq = &sq->wq;
 	struct mlx5e_umr_wqe *umr_wqe;
 	u16 xlt_offset = ix << (MLX5E_LOG_ALIGNED_MPWQE_PPW - 1);
-	u16 pi, frag_pi;
+	u16 pi, contig_wqebbs_room;
 	int err;
 	int i;
 
 	pi = mlx5_wq_cyc_ctr2ix(wq, sq->pc);
-	frag_pi = mlx5_wq_cyc_ctr2fragix(wq, sq->pc);
-
-	if (unlikely(frag_pi + MLX5E_UMR_WQEBBS > mlx5_wq_cyc_get_frag_size(wq))) {
-		mlx5e_fill_icosq_frag_edge(sq, wq, pi, frag_pi);
+	contig_wqebbs_room = mlx5_wq_cyc_get_contig_wqebbs(wq, pi);
+	if (unlikely(contig_wqebbs_room < MLX5E_UMR_WQEBBS)) {
+		mlx5e_fill_icosq_frag_edge(sq, wq, pi, contig_wqebbs_room);
 		pi = mlx5_wq_cyc_ctr2ix(wq, sq->pc);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index f29deb44bf3b..1e774d979c85 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -287,10 +287,9 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 
 static inline void mlx5e_fill_sq_frag_edge(struct mlx5e_txqsq *sq,
 					   struct mlx5_wq_cyc *wq,
-					   u16 pi, u16 frag_pi)
+					   u16 pi, u16 nnops)
 {
 	struct mlx5e_tx_wqe_info *edge_wi, *wi = &sq->db.wqe_info[pi];
-	u8 nnops = mlx5_wq_cyc_get_frag_size(wq) - frag_pi;
 
 	edge_wi = wi + nnops;
 
@@ -345,8 +344,8 @@ netdev_tx_t mlx5e_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	struct mlx5e_tx_wqe_info *wi;
 
 	struct mlx5e_sq_stats *stats = sq->stats;
+	u16 headlen, ihs, contig_wqebbs_room;
 	u16 ds_cnt, ds_cnt_inl = 0;
-	u16 headlen, ihs, frag_pi;
 	u8 num_wqebbs, opcode;
 	u32 num_bytes;
 	int num_dma;
@@ -383,9 +382,9 @@ netdev_tx_t mlx5e_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	}
 
 	num_wqebbs = DIV_ROUND_UP(ds_cnt, MLX5_SEND_WQEBB_NUM_DS);
-	frag_pi = mlx5_wq_cyc_ctr2fragix(wq, sq->pc);
-	if (unlikely(frag_pi + num_wqebbs > mlx5_wq_cyc_get_frag_size(wq))) {
-		mlx5e_fill_sq_frag_edge(sq, wq, pi, frag_pi);
+	contig_wqebbs_room = mlx5_wq_cyc_get_contig_wqebbs(wq, pi);
+	if (unlikely(contig_wqebbs_room < num_wqebbs)) {
+		mlx5e_fill_sq_frag_edge(sq, wq, pi, contig_wqebbs_room);
 		mlx5e_sq_fetch_wqe(sq, &wqe, &pi);
 	}
 
@@ -629,7 +628,7 @@ netdev_tx_t mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	struct mlx5e_tx_wqe_info *wi;
 
 	struct mlx5e_sq_stats *stats = sq->stats;
-	u16 headlen, ihs, pi, frag_pi;
+	u16 headlen, ihs, pi, contig_wqebbs_room;
 	u16 ds_cnt, ds_cnt_inl = 0;
 	u8 num_wqebbs, opcode;
 	u32 num_bytes;
@@ -665,13 +664,14 @@ netdev_tx_t mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	}
 
 	num_wqebbs = DIV_ROUND_UP(ds_cnt, MLX5_SEND_WQEBB_NUM_DS);
-	frag_pi = mlx5_wq_cyc_ctr2fragix(wq, sq->pc);
-	if (unlikely(frag_pi + num_wqebbs > mlx5_wq_cyc_get_frag_size(wq))) {
+	pi = mlx5_wq_cyc_ctr2ix(wq, sq->pc);
+	contig_wqebbs_room = mlx5_wq_cyc_get_contig_wqebbs(wq, pi);
+	if (unlikely(contig_wqebbs_room < num_wqebbs)) {
+		mlx5e_fill_sq_frag_edge(sq, wq, pi, contig_wqebbs_room);
 		pi = mlx5_wq_cyc_ctr2ix(wq, sq->pc);
-		mlx5e_fill_sq_frag_edge(sq, wq, pi, frag_pi);
 	}
 
-	mlx5i_sq_fetch_wqe(sq, &wqe, &pi);
+	mlx5i_sq_fetch_wqe(sq, &wqe, pi);
 
 	/* fill wqe */
 	wi       = &sq->db.wqe_info[pi];
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
index 08eac92fc26c..0982c579ec74 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
@@ -109,12 +109,11 @@ struct mlx5i_tx_wqe {
 
 static inline void mlx5i_sq_fetch_wqe(struct mlx5e_txqsq *sq,
 				      struct mlx5i_tx_wqe **wqe,
-				      u16 *pi)
+				      u16 pi)
 {
 	struct mlx5_wq_cyc *wq = &sq->wq;
 
-	*pi  = mlx5_wq_cyc_ctr2ix(wq, sq->pc);
-	*wqe = mlx5_wq_cyc_get_wqe(wq, *pi);
+	*wqe = mlx5_wq_cyc_get_wqe(wq, pi);
 	memset(*wqe, 0, sizeof(**wqe));
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wq.c b/drivers/net/ethernet/mellanox/mlx5/core/wq.c
index d838af9539b1..9046475c531c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wq.c
@@ -39,11 +39,6 @@ u32 mlx5_wq_cyc_get_size(struct mlx5_wq_cyc *wq)
 	return (u32)wq->fbc.sz_m1 + 1;
 }
 
-u16 mlx5_wq_cyc_get_frag_size(struct mlx5_wq_cyc *wq)
-{
-	return wq->fbc.frag_sz_m1 + 1;
-}
-
 u32 mlx5_cqwq_get_size(struct mlx5_cqwq *wq)
 {
 	return wq->fbc.sz_m1 + 1;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wq.h b/drivers/net/ethernet/mellanox/mlx5/core/wq.h
index 16476cc1a602..311256554520 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wq.h
@@ -80,7 +80,6 @@ int mlx5_wq_cyc_create(struct mlx5_core_dev *mdev, struct mlx5_wq_param *param,
 		       void *wqc, struct mlx5_wq_cyc *wq,
 		       struct mlx5_wq_ctrl *wq_ctrl);
 u32 mlx5_wq_cyc_get_size(struct mlx5_wq_cyc *wq);
-u16 mlx5_wq_cyc_get_frag_size(struct mlx5_wq_cyc *wq);
 
 int mlx5_wq_qp_create(struct mlx5_core_dev *mdev, struct mlx5_wq_param *param,
 		      void *qpc, struct mlx5_wq_qp *wq,
@@ -140,11 +139,6 @@ static inline u16 mlx5_wq_cyc_ctr2ix(struct mlx5_wq_cyc *wq, u16 ctr)
 	return ctr & wq->fbc.sz_m1;
 }
 
-static inline u16 mlx5_wq_cyc_ctr2fragix(struct mlx5_wq_cyc *wq, u16 ctr)
-{
-	return ctr & wq->fbc.frag_sz_m1;
-}
-
 static inline u16 mlx5_wq_cyc_get_head(struct mlx5_wq_cyc *wq)
 {
 	return mlx5_wq_cyc_ctr2ix(wq, wq->wqe_ctr);
@@ -160,6 +154,11 @@ static inline void *mlx5_wq_cyc_get_wqe(struct mlx5_wq_cyc *wq, u16 ix)
 	return mlx5_frag_buf_get_wqe(&wq->fbc, ix);
 }
 
+static inline u16 mlx5_wq_cyc_get_contig_wqebbs(struct mlx5_wq_cyc *wq, u16 ix)
+{
+	return mlx5_frag_buf_get_idx_last_contig_stride(&wq->fbc, ix) - ix + 1;
+}
+
 static inline int mlx5_wq_cyc_cc_bigger(u16 cc1, u16 cc2)
 {
 	int equal   = (cc1 == cc2);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 64f450593b54..b49bfc8e68b0 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1022,6 +1022,14 @@ static inline void *mlx5_frag_buf_get_wqe(struct mlx5_frag_buf_ctrl *fbc,
 		((fbc->frag_sz_m1 & ix) << fbc->log_stride);
 }
 
+static inline u32
+mlx5_frag_buf_get_idx_last_contig_stride(struct mlx5_frag_buf_ctrl *fbc, u32 ix)
+{
+	u32 last_frag_stride_idx = (ix + fbc->strides_offset) | fbc->frag_sz_m1;
+
+	return min_t(u32, last_frag_stride_idx - fbc->strides_offset, fbc->sz_m1);
+}
+
 int mlx5_cmd_init(struct mlx5_core_dev *dev);
 void mlx5_cmd_cleanup(struct mlx5_core_dev *dev);
 void mlx5_cmd_use_events(struct mlx5_core_dev *dev);
-- 
2.17.1

