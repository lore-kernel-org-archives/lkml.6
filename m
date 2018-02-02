Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225LzE7Zn/sC49UNsNJtwTBpOEnaVzWfPPCfX0jTnx9t7azB6TXvgRPr2z2SEqu5nMR0Nn4B
ARC-Seal: i=1; a=rsa-sha256; t=1517590980; cv=none;
        d=google.com; s=arc-20160816;
        b=fqK/frx1sP/GEAzfLbQZJd1erWqGcNFSLvQNTJIxkAFoSvCvwoeRUa9Ii5EGQip6H7
         hZhvkEUbQOv/37N48QFcXYzkgJr27AUvGl60tuI/wRRXt1WOK3cvUaOLWVm7IAgQ7XJG
         6UqcT6sMuRAGhpPCssL7KdfBHcIIk/LdQ9Fsm1F7eVVNp5AFpAgNGdXxGhDJq7M3cS/I
         xfBvJyq1ZR5ki/BCTcUSxHwSjSiHvtjrzYx+xQLS4D2QgXX5Bqd9TCNNSOwPa0HTYL9v
         ft+UnGpclIyvEpnB/lQDo6FbS14h43motrYBjwtzxkVnj7L0qigdFF1/p1ea9dfWDzWX
         jgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tbR6UolOcWSeO76m/LtHUennWEhYxgM1xEWGaRzeArE=;
        b=K+iD74mvYagwiijxILeu6xeY+8dSdqTSqnOToRn7lKoQmTHvIMFfLH9+D1FOh6htZO
         395hE+Lv1WW9FvpY8NMUPitJaUKeO03h27xbP6P7ygH/enlBSx1sdcT1/t0mYF6fwLon
         5X0Ow42nudnaz+Tx9YxPB3bfh+L8m2SWXV4QmuAy95u/wwm0JFSJnh0jEtlQDLq8j1/p
         5RvbVKRbt9CVWft5a52Ou9bQPlnlkc1bYnwyVolwBdgUclleyQV0uvjOfZv5llF1M/rJ
         3gI74GTqFM5fftNTXhSe4/HN0nRZJEJuTQQwydmCjdLOCFN1NK1wT90g+MaSb0GdvjqN
         bYsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Max Gurtovoy <maxg@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Doug Ledford <dledford@redhat.com>,
	Marta Rybczynska <mrybczyn@kalray.eu>
Subject: [PATCH 4.9 03/86] RDMA/mlx5: set UMR wqe fence according to HCA cap
Date: Fri,  2 Feb 2018 17:57:23 +0100
Message-Id: <20180202140822.986849143@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309479798331234?=
X-GMAIL-MSGID: =?utf-8?q?1591309479798331234?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Gurtovoy <maxg@mellanox.com>

commit 6e8484c5cf07c7ee632587e98c1a12d319dacb7c upstream.

Cache the needed umr_fence and set the wqe ctrl segmennt
accordingly.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Acked-by: Leon Romanovsky <leon@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Cc: Marta Rybczynska <mrybczyn@kalray.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/main.c    |   14 ++++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |    3 +
 drivers/infiniband/hw/mlx5/qp.c      |   59 +++++++++++++----------------------
 3 files changed, 39 insertions(+), 37 deletions(-)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2575,6 +2575,18 @@ error_0:
 	return ret;
 }
 
+static u8 mlx5_get_umr_fence(u8 umr_fence_cap)
+{
+	switch (umr_fence_cap) {
+	case MLX5_CAP_UMR_FENCE_NONE:
+		return MLX5_FENCE_MODE_NONE;
+	case MLX5_CAP_UMR_FENCE_SMALL:
+		return MLX5_FENCE_MODE_INITIATOR_SMALL;
+	default:
+		return MLX5_FENCE_MODE_STRONG_ORDERING;
+	}
+}
+
 static int create_dev_resources(struct mlx5_ib_resources *devr)
 {
 	struct ib_srq_init_attr attr;
@@ -3101,6 +3113,8 @@ static void *mlx5_ib_add(struct mlx5_cor
 
 	mlx5_ib_internal_fill_odp_caps(dev);
 
+	dev->umr_fence = mlx5_get_umr_fence(MLX5_CAP_GEN(mdev, umr_fence));
+
 	if (MLX5_CAP_GEN(mdev, imaicl)) {
 		dev->ib_dev.alloc_mw		= mlx5_ib_alloc_mw;
 		dev->ib_dev.dealloc_mw		= mlx5_ib_dealloc_mw;
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -345,7 +345,7 @@ struct mlx5_ib_qp {
 	struct mlx5_ib_wq	rq;
 
 	u8			sq_signal_bits;
-	u8			fm_cache;
+	u8			next_fence;
 	struct mlx5_ib_wq	sq;
 
 	/* serialize qp state modifications
@@ -643,6 +643,7 @@ struct mlx5_ib_dev {
 	struct list_head	qp_list;
 	/* Array with num_ports elements */
 	struct mlx5_ib_port	*port;
+	u8			umr_fence;
 };
 
 static inline struct mlx5_ib_cq *to_mibcq(struct mlx5_core_cq *mcq)
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3755,24 +3755,6 @@ static void mlx5_bf_copy(u64 __iomem *ds
 	}
 }
 
-static u8 get_fence(u8 fence, struct ib_send_wr *wr)
-{
-	if (unlikely(wr->opcode == IB_WR_LOCAL_INV &&
-		     wr->send_flags & IB_SEND_FENCE))
-		return MLX5_FENCE_MODE_STRONG_ORDERING;
-
-	if (unlikely(fence)) {
-		if (wr->send_flags & IB_SEND_FENCE)
-			return MLX5_FENCE_MODE_SMALL_AND_FENCE;
-		else
-			return fence;
-	} else if (unlikely(wr->send_flags & IB_SEND_FENCE)) {
-		return MLX5_FENCE_MODE_FENCE;
-	}
-
-	return 0;
-}
-
 static int begin_wqe(struct mlx5_ib_qp *qp, void **seg,
 		     struct mlx5_wqe_ctrl_seg **ctrl,
 		     struct ib_send_wr *wr, unsigned *idx,
@@ -3801,8 +3783,7 @@ static int begin_wqe(struct mlx5_ib_qp *
 static void finish_wqe(struct mlx5_ib_qp *qp,
 		       struct mlx5_wqe_ctrl_seg *ctrl,
 		       u8 size, unsigned idx, u64 wr_id,
-		       int nreq, u8 fence, u8 next_fence,
-		       u32 mlx5_opcode)
+		       int nreq, u8 fence, u32 mlx5_opcode)
 {
 	u8 opmod = 0;
 
@@ -3810,7 +3791,6 @@ static void finish_wqe(struct mlx5_ib_qp
 					     mlx5_opcode | ((u32)opmod << 24));
 	ctrl->qpn_ds = cpu_to_be32(size | (qp->trans_qp.base.mqp.qpn << 8));
 	ctrl->fm_ce_se |= fence;
-	qp->fm_cache = next_fence;
 	if (unlikely(qp->wq_sig))
 		ctrl->signature = wq_sig(ctrl);
 
@@ -3870,7 +3850,6 @@ int mlx5_ib_post_send(struct ib_qp *ibqp
 			goto out;
 		}
 
-		fence = qp->fm_cache;
 		num_sge = wr->num_sge;
 		if (unlikely(num_sge > qp->sq.max_gs)) {
 			mlx5_ib_warn(dev, "\n");
@@ -3887,6 +3866,19 @@ int mlx5_ib_post_send(struct ib_qp *ibqp
 			goto out;
 		}
 
+		if (wr->opcode == IB_WR_LOCAL_INV ||
+		    wr->opcode == IB_WR_REG_MR) {
+			fence = dev->umr_fence;
+			next_fence = MLX5_FENCE_MODE_INITIATOR_SMALL;
+		} else if (wr->send_flags & IB_SEND_FENCE) {
+			if (qp->next_fence)
+				fence = MLX5_FENCE_MODE_SMALL_AND_FENCE;
+			else
+				fence = MLX5_FENCE_MODE_FENCE;
+		} else {
+			fence = qp->next_fence;
+		}
+
 		switch (ibqp->qp_type) {
 		case IB_QPT_XRC_INI:
 			xrc = seg;
@@ -3913,7 +3905,6 @@ int mlx5_ib_post_send(struct ib_qp *ibqp
 				goto out;
 
 			case IB_WR_LOCAL_INV:
-				next_fence = MLX5_FENCE_MODE_INITIATOR_SMALL;
 				qp->sq.wr_data[idx] = IB_WR_LOCAL_INV;
 				ctrl->imm = cpu_to_be32(wr->ex.invalidate_rkey);
 				set_linv_wr(qp, &seg, &size);
@@ -3921,7 +3912,6 @@ int mlx5_ib_post_send(struct ib_qp *ibqp
 				break;
 
 			case IB_WR_REG_MR:
-				next_fence = MLX5_FENCE_MODE_INITIATOR_SMALL;
 				qp->sq.wr_data[idx] = IB_WR_REG_MR;
 				ctrl->imm = cpu_to_be32(reg_wr(wr)->key);
 				err = set_reg_wr(qp, reg_wr(wr), &seg, &size);
@@ -3944,9 +3934,8 @@ int mlx5_ib_post_send(struct ib_qp *ibqp
 					goto out;
 				}
 
-				finish_wqe(qp, ctrl, size, idx, wr->wr_id,
-					   nreq, get_fence(fence, wr),
-					   next_fence, MLX5_OPCODE_UMR);
+				finish_wqe(qp, ctrl, size, idx, wr->wr_id, nreq,
+					   fence, MLX5_OPCODE_UMR);
 				/*
 				 * SET_PSV WQEs are not signaled and solicited
 				 * on error
@@ -3971,9 +3960,8 @@ int mlx5_ib_post_send(struct ib_qp *ibqp
 					goto out;
 				}
 
-				finish_wqe(qp, ctrl, size, idx, wr->wr_id,
-					   nreq, get_fence(fence, wr),
-					   next_fence, MLX5_OPCODE_SET_PSV);
+				finish_wqe(qp, ctrl, size, idx, wr->wr_id, nreq,
+					   fence, MLX5_OPCODE_SET_PSV);
 				err = begin_wqe(qp, &seg, &ctrl, wr,
 						&idx, &size, nreq);
 				if (err) {
@@ -3983,7 +3971,6 @@ int mlx5_ib_post_send(struct ib_qp *ibqp
 					goto out;
 				}
 
-				next_fence = MLX5_FENCE_MODE_INITIATOR_SMALL;
 				err = set_psv_wr(&sig_handover_wr(wr)->sig_attrs->wire,
 						 mr->sig->psv_wire.psv_idx, &seg,
 						 &size);
@@ -3993,9 +3980,9 @@ int mlx5_ib_post_send(struct ib_qp *ibqp
 					goto out;
 				}
 
-				finish_wqe(qp, ctrl, size, idx, wr->wr_id,
-					   nreq, get_fence(fence, wr),
-					   next_fence, MLX5_OPCODE_SET_PSV);
+				finish_wqe(qp, ctrl, size, idx, wr->wr_id, nreq,
+					   fence, MLX5_OPCODE_SET_PSV);
+				qp->next_fence = MLX5_FENCE_MODE_INITIATOR_SMALL;
 				num_sge = 0;
 				goto skip_psv;
 
@@ -4100,8 +4087,8 @@ int mlx5_ib_post_send(struct ib_qp *ibqp
 			}
 		}
 
-		finish_wqe(qp, ctrl, size, idx, wr->wr_id, nreq,
-			   get_fence(fence, wr), next_fence,
+		qp->next_fence = next_fence;
+		finish_wqe(qp, ctrl, size, idx, wr->wr_id, nreq, fence,
 			   mlx5_ib_opcode[wr->opcode]);
 skip_psv:
 		if (0)
