Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA59BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D46520881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D46520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbeIMTBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:01:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbeIMTBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:01:16 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D5E78D10;
        Thu, 13 Sep 2018 13:51:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 027/197] net/mlx5: Fix SQ offset in QPs with small RQ
Date:   Thu, 13 Sep 2018 15:29:36 +0200
Message-Id: <20180913131842.647142172@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

[ Upstream commit 639505d4397b8c654a8e2616f9cb70ece40c83f9 ]

Correct the formula for calculating the RQ page remainder,
which should be in byte granularity.  The result will be
non-zero only for RQs smaller than PAGE_SIZE, as an RQ size
is a power of 2.

Divide this by the SQ stride (MLX5_SEND_WQE_BB) to get the
SQ offset in strides granularity.

Fixes: d7037ad73daa ("net/mlx5: Fix QP fragmented buffer allocation")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/wq.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/wq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wq.c
@@ -139,14 +139,15 @@ int mlx5_wq_qp_create(struct mlx5_core_d
 		      struct mlx5_wq_ctrl *wq_ctrl)
 {
 	u32 sq_strides_offset;
+	u32 rq_pg_remainder;
 	int err;
 
 	mlx5_fill_fbc(MLX5_GET(qpc, qpc, log_rq_stride) + 4,
 		      MLX5_GET(qpc, qpc, log_rq_size),
 		      &wq->rq.fbc);
 
-	sq_strides_offset =
-		((wq->rq.fbc.frag_sz_m1 + 1) % PAGE_SIZE) / MLX5_SEND_WQE_BB;
+	rq_pg_remainder   = mlx5_wq_cyc_get_byte_size(&wq->rq) % PAGE_SIZE;
+	sq_strides_offset = rq_pg_remainder / MLX5_SEND_WQE_BB;
 
 	mlx5_fill_fbc_offset(ilog2(MLX5_SEND_WQE_BB),
 			     MLX5_GET(qpc, qpc, log_sq_size),


