Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52815C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1794E214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976833;
	bh=DWGJoATIIqVC6FQOgIArwgQGAOAFlVV3PBH6xjbDvT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A/eNDPsI+6kpx+x1kapHpyXZhObyB+cjVns5NXoU0bQltUG5qxrFaUKaq9YQsac1X
	 Y1tt7PCYG1tRzDpNm4zHjSaN3FHywPL1X4Akhjz7wG+qMoVGG8+vT2V5BVkZZTbvbw
	 yx4/FQCYuMy/0pjAy1K1Ce7m4OuO7JDsMRXw8vQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbfAHTcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731470AbfAHTcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6E5820827;
        Tue,  8 Jan 2019 19:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975969;
        bh=DWGJoATIIqVC6FQOgIArwgQGAOAFlVV3PBH6xjbDvT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovXASatRTziEKpiB/ZNkuCY0ojr4AXeWd8cX4rozOifznt2TwXfPVa4qs18O8WzgV
         QHaTpf3IlaX7J4/Ne10MoTt+wP2oPXyb0hQtdlr/ZwGby5QhXoM/2gY98NiNNaEESc
         GnV3F1wJDQIopH7TfZAVEVNjIVA4MTvnTisaT+2o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 14/53] rxe: IB_WR_REG_MR does not capture MR's iova field
Date:   Tue,  8 Jan 2019 14:31:42 -0500
Message-Id: <20190108193222.123316-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
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
index de853bcc2384..08ae4f3a6a37 100644
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

