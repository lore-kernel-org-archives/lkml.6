Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91EFECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9852B21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KurtyGcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9852B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeJSB7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbeJSB7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:59:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551BF21473;
        Thu, 18 Oct 2018 17:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885462;
        bh=Wq+tcVeq0WWjMCmCgQ/ynKNfS+9YUAe3PXg7P8wpVQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KurtyGcbPrirXNiJt42WNc4x/cGb+hz8/IMznXh9uxoxhdWiQ9jBhbHtGDzyFbQYC
         SozlLel9GYOHN4esXV/wxDfnF7JuhjZOuRkf9HfVu2UfFlmw7LZGK73w+ZmMgMqsLT
         oT3QryWMm/Q8Qnxub3lvOmIUlqRUDAcvUZYYP/gA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Majd Dibbiny <majd@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 31/53] RDMA/uverbs: Fix validity check for modify QP
Date:   Thu, 18 Oct 2018 19:54:24 +0200
Message-Id: <20181018175422.258900545@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/uverbs_cmd.c |   68 +++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 23 deletions(-)

--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2048,33 +2048,55 @@ static int modify_qp(struct ib_uverbs_fi
 
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


