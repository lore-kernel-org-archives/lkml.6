Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB467C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B010E20837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpRxjvu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B010E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbeKCDyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbeKCDyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:54:02 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D04EF20847;
        Fri,  2 Nov 2018 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184348;
        bh=fcuIIN3Mx5bHG6hyvMhW7gUIo0i2geU5z8N/znldOjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpRxjvu0aVYJs5vTXCbCOp6I1HzUSG9y2Rdggh4r+x+e7umOuDTegeN+9vYR0v46p
         aKkohgDKS7PSbY1oE2qPBc/ZqY7XgSbPGNpXKIPnhymhjtixhFap97ggVATSLs4cBw
         SlJGozLXe5kF33407t9MZJKFoUrwirV38MR9zx64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.18 140/150] net/mlx5: WQ, fixes for fragmented WQ buffers API
Date:   Fri,  2 Nov 2018 19:35:02 +0100
Message-Id: <20181102182912.289480580@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c       |   12 ++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c       |   22 +++++++++---------
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h |    5 +---
 drivers/net/ethernet/mellanox/mlx5/core/wq.c          |    5 ----
 drivers/net/ethernet/mellanox/mlx5/core/wq.h          |   11 ++++-----
 include/linux/mlx5/driver.h                           |    8 ++++++
 6 files changed, 31 insertions(+), 32 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -429,10 +429,9 @@ static inline u16 mlx5e_icosq_wrap_cnt(s
 
 static inline void mlx5e_fill_icosq_frag_edge(struct mlx5e_icosq *sq,
 					      struct mlx5_wq_cyc *wq,
-					      u16 pi, u16 frag_pi)
+					      u16 pi, u16 nnops)
 {
 	struct mlx5e_sq_wqe_info *edge_wi, *wi = &sq->db.ico_wqe[pi];
-	u8 nnops = mlx5_wq_cyc_get_frag_size(wq) - frag_pi;
 
 	edge_wi = wi + nnops;
 
@@ -451,15 +450,14 @@ static int mlx5e_alloc_rx_mpwqe(struct m
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
 
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -287,10 +287,9 @@ dma_unmap_wqe_err:
 
 static inline void mlx5e_fill_sq_frag_edge(struct mlx5e_txqsq *sq,
 					   struct mlx5_wq_cyc *wq,
-					   u16 pi, u16 frag_pi)
+					   u16 pi, u16 nnops)
 {
 	struct mlx5e_tx_wqe_info *edge_wi, *wi = &sq->db.wqe_info[pi];
-	u8 nnops = mlx5_wq_cyc_get_frag_size(wq) - frag_pi;
 
 	edge_wi = wi + nnops;
 
@@ -345,8 +344,8 @@ netdev_tx_t mlx5e_sq_xmit(struct mlx5e_t
 	struct mlx5e_tx_wqe_info *wi;
 
 	struct mlx5e_sq_stats *stats = sq->stats;
+	u16 headlen, ihs, contig_wqebbs_room;
 	u16 ds_cnt, ds_cnt_inl = 0;
-	u16 headlen, ihs, frag_pi;
 	u8 num_wqebbs, opcode;
 	u32 num_bytes;
 	int num_dma;
@@ -383,9 +382,9 @@ netdev_tx_t mlx5e_sq_xmit(struct mlx5e_t
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
 
@@ -629,7 +628,7 @@ netdev_tx_t mlx5i_sq_xmit(struct mlx5e_t
 	struct mlx5e_tx_wqe_info *wi;
 
 	struct mlx5e_sq_stats *stats = sq->stats;
-	u16 headlen, ihs, pi, frag_pi;
+	u16 headlen, ihs, pi, contig_wqebbs_room;
 	u16 ds_cnt, ds_cnt_inl = 0;
 	u8 num_wqebbs, opcode;
 	u32 num_bytes;
@@ -665,13 +664,14 @@ netdev_tx_t mlx5i_sq_xmit(struct mlx5e_t
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
 
--- a/drivers/net/ethernet/mellanox/mlx5/core/wq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wq.c
@@ -39,11 +39,6 @@ u32 mlx5_wq_cyc_get_size(struct mlx5_wq_
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
--- a/drivers/net/ethernet/mellanox/mlx5/core/wq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wq.h
@@ -80,7 +80,6 @@ int mlx5_wq_cyc_create(struct mlx5_core_
 		       void *wqc, struct mlx5_wq_cyc *wq,
 		       struct mlx5_wq_ctrl *wq_ctrl);
 u32 mlx5_wq_cyc_get_size(struct mlx5_wq_cyc *wq);
-u16 mlx5_wq_cyc_get_frag_size(struct mlx5_wq_cyc *wq);
 
 int mlx5_wq_qp_create(struct mlx5_core_dev *mdev, struct mlx5_wq_param *param,
 		      void *qpc, struct mlx5_wq_qp *wq,
@@ -140,11 +139,6 @@ static inline u16 mlx5_wq_cyc_ctr2ix(str
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
@@ -160,6 +154,11 @@ static inline void *mlx5_wq_cyc_get_wqe(
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
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1022,6 +1022,14 @@ static inline void *mlx5_frag_buf_get_wq
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


