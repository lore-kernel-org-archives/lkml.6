Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FE2C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C606F214DC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qstCj40e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C606F214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeJHWiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeJHWiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B8221479;
        Mon,  8 Oct 2018 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012363;
        bh=+8Qh4dVdB3qthxfRzsS+68thotYvhJ0TzkZBvV+T9es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qstCj40e2ezGLsPFZH6Vb67d5MyibqzEqPB3IEI2iFtEW+L+vW2yuo1U33oO7kbE1
         az4/+riiFZGoNiyJ+CQu78dZVsUQVz58li+eSE+fihVmaZMdkltu0fCV/L55+lf5lP
         CAN9zLkSFF8DSXz4yeirbjBBrwrnxkqRWXqtFPhc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Majd Dibbiny <majd@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 38/58] RDMA/uverbs: Fix validity check for modify QP
Date:   Mon,  8 Oct 2018 11:25:03 -0400
Message-Id: <20181008152523.70705-38-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Majd Dibbiny <majd@mellanox.com>

[ Upstream commit 4eeed3686981ff887bbdd7254139e2eca276534c ]

Uverbs shouldn't enforce QP state in the command unless the user set the QP
state bit in the attribute mask.

In addition, only copy qp attr fields which have the corresponding bit set
in the attribute mask over to the internal attr structure.

Fixes: 88de869bbe4f ("RDMA/uverbs: Ensure validity of current QP state value")
Fixes: bc38a6abdd5a ("[PATCH] IB uverbs: core implementation")
Signed-off-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 68 ++++++++++++++++++----------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 0e5eb0f547d3..b83348416885 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2048,33 +2048,55 @@ static int modify_qp(struct ib_uverbs_file *file,
 
 	if ((cmd->base.attr_mask & IB_QP_CUR_STATE &&
 	    cmd->base.cur_qp_state > IB_QPS_ERR) ||
-	    cmd->base.qp_state > IB_QPS_ERR) {
+	    (cmd->base.attr_mask & IB_QP_STATE &&
+	    cmd->base.qp_state > IB_QPS_ERR)) {
 		ret = -EINVAL;
 		goto release_qp;
 	}
 
-	attr->qp_state		  = cmd->base.qp_state;
-	attr->cur_qp_state	  = cmd->base.cur_qp_state;
-	attr->path_mtu		  = cmd->base.path_mtu;
-	attr->path_mig_state	  = cmd->base.path_mig_state;
-	attr->qkey		  = cmd->base.qkey;
-	attr->rq_psn		  = cmd->base.rq_psn;
-	attr->sq_psn		  = cmd->base.sq_psn;
-	attr->dest_qp_num	  = cmd->base.dest_qp_num;
-	attr->qp_access_flags	  = cmd->base.qp_access_flags;
-	attr->pkey_index	  = cmd->base.pkey_index;
-	attr->alt_pkey_index	  = cmd->base.alt_pkey_index;
-	attr->en_sqd_async_notify = cmd->base.en_sqd_async_notify;
-	attr->max_rd_atomic	  = cmd->base.max_rd_atomic;
-	attr->max_dest_rd_atomic  = cmd->base.max_dest_rd_atomic;
-	attr->min_rnr_timer	  = cmd->base.min_rnr_timer;
-	attr->port_num		  = cmd->base.port_num;
-	attr->timeout		  = cmd->base.timeout;
-	attr->retry_cnt		  = cmd->base.retry_cnt;
-	attr->rnr_retry		  = cmd->base.rnr_retry;
-	attr->alt_port_num	  = cmd->base.alt_port_num;
-	attr->alt_timeout	  = cmd->base.alt_timeout;
-	attr->rate_limit	  = cmd->rate_limit;
+	if (cmd->base.attr_mask & IB_QP_STATE)
+		attr->qp_state = cmd->base.qp_state;
+	if (cmd->base.attr_mask & IB_QP_CUR_STATE)
+		attr->cur_qp_state = cmd->base.cur_qp_state;
+	if (cmd->base.attr_mask & IB_QP_PATH_MTU)
+		attr->path_mtu = cmd->base.path_mtu;
+	if (cmd->base.attr_mask & IB_QP_PATH_MIG_STATE)
+		attr->path_mig_state = cmd->base.path_mig_state;
+	if (cmd->base.attr_mask & IB_QP_QKEY)
+		attr->qkey = cmd->base.qkey;
+	if (cmd->base.attr_mask & IB_QP_RQ_PSN)
+		attr->rq_psn = cmd->base.rq_psn;
+	if (cmd->base.attr_mask & IB_QP_SQ_PSN)
+		attr->sq_psn = cmd->base.sq_psn;
+	if (cmd->base.attr_mask & IB_QP_DEST_QPN)
+		attr->dest_qp_num = cmd->base.dest_qp_num;
+	if (cmd->base.attr_mask & IB_QP_ACCESS_FLAGS)
+		attr->qp_access_flags = cmd->base.qp_access_flags;
+	if (cmd->base.attr_mask & IB_QP_PKEY_INDEX)
+		attr->pkey_index = cmd->base.pkey_index;
+	if (cmd->base.attr_mask & IB_QP_EN_SQD_ASYNC_NOTIFY)
+		attr->en_sqd_async_notify = cmd->base.en_sqd_async_notify;
+	if (cmd->base.attr_mask & IB_QP_MAX_QP_RD_ATOMIC)
+		attr->max_rd_atomic = cmd->base.max_rd_atomic;
+	if (cmd->base.attr_mask & IB_QP_MAX_DEST_RD_ATOMIC)
+		attr->max_dest_rd_atomic = cmd->base.max_dest_rd_atomic;
+	if (cmd->base.attr_mask & IB_QP_MIN_RNR_TIMER)
+		attr->min_rnr_timer = cmd->base.min_rnr_timer;
+	if (cmd->base.attr_mask & IB_QP_PORT)
+		attr->port_num = cmd->base.port_num;
+	if (cmd->base.attr_mask & IB_QP_TIMEOUT)
+		attr->timeout = cmd->base.timeout;
+	if (cmd->base.attr_mask & IB_QP_RETRY_CNT)
+		attr->retry_cnt = cmd->base.retry_cnt;
+	if (cmd->base.attr_mask & IB_QP_RNR_RETRY)
+		attr->rnr_retry = cmd->base.rnr_retry;
+	if (cmd->base.attr_mask & IB_QP_ALT_PATH) {
+		attr->alt_port_num = cmd->base.alt_port_num;
+		attr->alt_timeout = cmd->base.alt_timeout;
+		attr->alt_pkey_index = cmd->base.alt_pkey_index;
+	}
+	if (cmd->base.attr_mask & IB_QP_RATE_LIMIT)
+		attr->rate_limit = cmd->rate_limit;
 
 	if (cmd->base.attr_mask & IB_QP_AV)
 		copy_ah_attr_from_uverbs(qp->device, &attr->ah_attr,
-- 
2.17.1

