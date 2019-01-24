Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDCCC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0232621905
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358524;
	bh=2cVKVcd6O18QnN2NFIeOTZYCqjLxt6iOEh58IeV4+3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z/sX9UnerxaYKbiuRU4S5dFWaWjYE/M0Jo2wES2NWOMVnuMF9ClsyKC/GorJ2w6MJ
	 QNs69iEhXV3HcjVLXb3sAIDUDifMNLepMBw//0aosOXr91VYq7RoSlaUs0CN5BBPDL
	 4kNrBiI7EyTpqAk8tMzVe61YFKnP25pSAcXMte88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbfAXTfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731737AbfAXTfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:35:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39941218FC;
        Thu, 24 Jan 2019 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358518;
        bh=2cVKVcd6O18QnN2NFIeOTZYCqjLxt6iOEh58IeV4+3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bh2h2SLuLKtP35BAMWiMoJbTMj09ctkbSlXXfTy2opxEpFPr/gXN9yDAuHB4XG7CF
         wAT/2dth6ubVyw/se7SW6RkyE3lHsbL/w+VoqNG02bGPt8yVcz6d/nXYNgDNjiGGgm
         GR+wXTXnG32BzR3DtOkA5iBEM9F0jFwzqk29OTuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anna Schumaker <schumaker.anna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 037/106] rxe: IB_WR_REG_MR does not capture MRs iova field
Date:   Thu, 24 Jan 2019 20:19:54 +0100
Message-Id: <20190124190208.754772772@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -640,6 +640,7 @@ next_wqe:
 			rmr->access = wqe->wr.wr.reg.access;
 			rmr->lkey = wqe->wr.wr.reg.key;
 			rmr->rkey = wqe->wr.wr.reg.key;
+			rmr->iova = wqe->wr.wr.reg.mr->iova;
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 		} else {
-- 
2.19.1



