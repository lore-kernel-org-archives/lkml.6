Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68437ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4C221486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4C221486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbeIXS3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:29:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732305AbeIXS3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:29:08 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B11E3108B;
        Mon, 24 Sep 2018 12:27:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.18 015/235] net/mlx5: Use u16 for Work Queue buffer fragment size
Date:   Mon, 24 Sep 2018 13:50:01 +0200
Message-Id: <20180924113106.028019927@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

[ Upstream commit 8d71e818506718e8d7032ce824b5c74a17d4f7a5 ]

Minimal stride size is 16.
Hence, the number of strides in a fragment (of PAGE_SIZE)
is <= PAGE_SIZE / 16 <= 4K.

u16 is sufficient to represent this.

Fixes: 388ca8be0037 ("IB/mlx5: Implement fragmented completion queue (CQ)")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/wq.c |    4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/wq.h |    2 +-
 include/linux/mlx5/driver.h                  |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/wq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wq.c
@@ -39,9 +39,9 @@ u32 mlx5_wq_cyc_get_size(struct mlx5_wq_
 	return (u32)wq->fbc.sz_m1 + 1;
 }
 
-u32 mlx5_wq_cyc_get_frag_size(struct mlx5_wq_cyc *wq)
+u16 mlx5_wq_cyc_get_frag_size(struct mlx5_wq_cyc *wq)
 {
-	return (u32)wq->fbc.frag_sz_m1 + 1;
+	return wq->fbc.frag_sz_m1 + 1;
 }
 
 u32 mlx5_cqwq_get_size(struct mlx5_cqwq *wq)
--- a/drivers/net/ethernet/mellanox/mlx5/core/wq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wq.h
@@ -80,7 +80,7 @@ int mlx5_wq_cyc_create(struct mlx5_core_
 		       void *wqc, struct mlx5_wq_cyc *wq,
 		       struct mlx5_wq_ctrl *wq_ctrl);
 u32 mlx5_wq_cyc_get_size(struct mlx5_wq_cyc *wq);
-u32 mlx5_wq_cyc_get_frag_size(struct mlx5_wq_cyc *wq);
+u16 mlx5_wq_cyc_get_frag_size(struct mlx5_wq_cyc *wq);
 
 int mlx5_wq_qp_create(struct mlx5_core_dev *mdev, struct mlx5_wq_param *param,
 		      void *qpc, struct mlx5_wq_qp *wq,
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -357,7 +357,7 @@ struct mlx5_frag_buf {
 struct mlx5_frag_buf_ctrl {
 	struct mlx5_frag_buf	frag_buf;
 	u32			sz_m1;
-	u32			frag_sz_m1;
+	u16			frag_sz_m1;
 	u32			strides_offset;
 	u8			log_sz;
 	u8			log_stride;


