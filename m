Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FBAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DDB20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977265;
	bh=DUn12wfiKQMEqDSDhulqdI4ojZmqmeSkz/ZT6Qtsxjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nd1CG0X7lDqCDY+kM1c+K/upXP6gWYXv0zEbTFwz7hwaeuPg+13yYKDQ9WnmPS3kG
	 bTFHCNQOwukSj905RVRf55OpLKF83BP+d6vb1MtKAhiuDNIV0iIgKH2Xlq1Vb49ymr
	 J967JLU4jjADUnW1L3KWDA9b78nSva2v8alvPAvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfAHTyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:54:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730840AbfAHTam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B622070B;
        Tue,  8 Jan 2019 19:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975842;
        bh=DUn12wfiKQMEqDSDhulqdI4ojZmqmeSkz/ZT6Qtsxjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEGfo3LAgePRzN0uOpaLLEE77Sihmd2WwzQOKr8AjrfQr9a+rHjfqJd3gAVK+MNcJ
         lR1SrYdai4586KJGKm6pxYvdg3X+TTfRvHr0VeogeXzjOT5r71R0Rj/e8kAcdau+RR
         IjTRl3PBsoAl9DQJJuYeSvkSAk730ASfYZa271X0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 31/97] rxe: IB_WR_REG_MR does not capture MR's iova field
Date:   Tue,  8 Jan 2019 14:28:40 -0500
Message-Id: <20190108192949.122407-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit b024dd0eba6e6d568f69d63c5e3153aba94c23e3 ]

FRWR memory registration is done with a series of calls and WRs.
1. ULP invokes ib_dma_map_sg()
2. ULP invokes ib_map_mr_sg()
3. ULP posts an IB_WR_REG_MR on the Send queue

Step 2 generates an iova. It is permissible for ULPs to change this
iova (with certain restrictions) between steps 2 and 3.

rxe_map_mr_sg captures the MR's iova but later when rxe processes the
REG_MR WR, it ignores the MR's iova field. If a ULP alters the MR's iova
after step 2 but before step 3, rxe never captures that change.

When the remote sends an RDMA Read targeting that MR, rxe looks up the
R_key, but the altered iova does not match the iova stored in the MR,
causing the RDMA Read request to fail.

Reported-by: Anna Schumaker <schumaker.anna@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 8be27238a86e..fa98a5279647 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -640,6 +640,7 @@ int rxe_requester(void *arg)
 			rmr->access = wqe->wr.wr.reg.access;
 			rmr->lkey = wqe->wr.wr.reg.key;
 			rmr->rkey = wqe->wr.wr.reg.key;
+			rmr->iova = wqe->wr.wr.reg.mr->iova;
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 		} else {
-- 
2.19.1

