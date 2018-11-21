Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC0FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58ECF214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO3eaeJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58ECF214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbeKVFmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387645AbeKVFmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF0A5214F1;
        Wed, 21 Nov 2018 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827224;
        bh=kLdP5YfUsPgxP4U2ULreQF8QzxeoCezlAy58rvQgEcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SO3eaeJoxhQ30c4rJt2xvRCnKH+9dgShKqjcYFPhq+EvNuvRA+nFkcR9z4pbcMdhK
         Eix1FoJSZlTK/5pTiLk6CUkgtyb1DNE9W0EwGJtYSbbLNbXqHJ4P+pk/NjdIwjJlV/
         ypjfBfPy5ZwTgoEafJ0+NV1MUCuqTCP8dzzse4Pg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 21/42] net/mlx5e: RX, verify received packet size in Linear Striding RQ
Date:   Wed, 21 Nov 2018 20:05:57 +0100
Message-Id: <20181121183148.934564642@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit 0073c8f72736b423aade8a817587a5f3e4df4ad8 ]

In case of striding RQ, we use  MPWRQ (Multi Packet WQE RQ), which means
that WQE (RX descriptor) can be used for many packets and so the WQE is
much bigger than MTU.  In virtualization setups where the port mtu can
be larger than the vf mtu, if received packet is bigger than MTU, it
won't be dropped by HW on too small receive WQE. If we use linear SKB in
striding RQ, since each stride has room for mtu size payload and skb
info, an oversized packet can lead to crash for crossing allocated page
boundary upon the call to build_skb. So driver needs to check packet
size and drop it.

Introduce new SW rx counter, rx_oversize_pkts_sw_drop, which counts the
number of packets dropped by the driver for being too large.

As a new field is added to the RQ struct, re-open the channels whenever
this field is being used in datapath (i.e., in the case of linear
Striding RQ).

Fixes: 619a8f2a42f1 ("net/mlx5e: Use linear SKB in Striding RQ")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |    4 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |    6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |    3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |    2 ++
 5 files changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -566,6 +566,7 @@ struct mlx5e_rq {
 
 	unsigned long          state;
 	int                    ix;
+	unsigned int           hw_mtu;
 
 	struct net_dim         dim; /* Dynamic Interrupt Moderation */
 
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -492,6 +492,7 @@ static int mlx5e_alloc_rq(struct mlx5e_c
 	rq->channel = c;
 	rq->ix      = c->ix;
 	rq->mdev    = mdev;
+	rq->hw_mtu  = MLX5E_SW2HW_MTU(params, params->sw_mtu);
 	rq->stats   = &c->priv->channel_stats[c->ix].rq;
 
 	rq->xdp_prog = params->xdp_prog ? bpf_prog_inc(params->xdp_prog) : NULL;
@@ -3758,10 +3759,11 @@ int mlx5e_change_mtu(struct net_device *
 	}
 
 	if (params->rq_wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ) {
+		bool is_linear = mlx5e_rx_mpwqe_is_linear_skb(priv->mdev, &new_channels.params);
 		u8 ppw_old = mlx5e_mpwqe_log_pkts_per_wqe(params);
 		u8 ppw_new = mlx5e_mpwqe_log_pkts_per_wqe(&new_channels.params);
 
-		reset = reset && (ppw_old != ppw_new);
+		reset = reset && (is_linear || (ppw_old != ppw_new));
 	}
 
 	if (!reset) {
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1064,6 +1064,12 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct m
 	u32 frag_size;
 	bool consumed;
 
+	/* Check packet size. Note LRO doesn't use linear SKB */
+	if (unlikely(cqe_bcnt > rq->hw_mtu)) {
+		rq->stats->oversize_pkts_sw_drop++;
+		return NULL;
+	}
+
 	va             = page_address(di->page) + head_offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt32);
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -82,6 +82,7 @@ static const struct counter_desc sw_stat
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_wqe_err) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_mpwqe_filler_cqes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_mpwqe_filler_strides) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_oversize_pkts_sw_drop) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_buff_alloc_err) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_cqe_compress_blks) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_cqe_compress_pkts) },
@@ -158,6 +159,7 @@ void mlx5e_grp_sw_update_stats(struct ml
 		s->rx_wqe_err   += rq_stats->wqe_err;
 		s->rx_mpwqe_filler_cqes    += rq_stats->mpwqe_filler_cqes;
 		s->rx_mpwqe_filler_strides += rq_stats->mpwqe_filler_strides;
+		s->rx_oversize_pkts_sw_drop += rq_stats->oversize_pkts_sw_drop;
 		s->rx_buff_alloc_err += rq_stats->buff_alloc_err;
 		s->rx_cqe_compress_blks += rq_stats->cqe_compress_blks;
 		s->rx_cqe_compress_pkts += rq_stats->cqe_compress_pkts;
@@ -1148,6 +1150,7 @@ static const struct counter_desc rq_stat
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, wqe_err) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, mpwqe_filler_cqes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, mpwqe_filler_strides) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, oversize_pkts_sw_drop) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, buff_alloc_err) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, cqe_compress_blks) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, cqe_compress_pkts) },
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -95,6 +95,7 @@ struct mlx5e_sw_stats {
 	u64 rx_wqe_err;
 	u64 rx_mpwqe_filler_cqes;
 	u64 rx_mpwqe_filler_strides;
+	u64 rx_oversize_pkts_sw_drop;
 	u64 rx_buff_alloc_err;
 	u64 rx_cqe_compress_blks;
 	u64 rx_cqe_compress_pkts;
@@ -190,6 +191,7 @@ struct mlx5e_rq_stats {
 	u64 wqe_err;
 	u64 mpwqe_filler_cqes;
 	u64 mpwqe_filler_strides;
+	u64 oversize_pkts_sw_drop;
 	u64 buff_alloc_err;
 	u64 cqe_compress_blks;
 	u64 cqe_compress_pkts;


