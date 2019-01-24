Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABE2C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56C321726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359408;
	bh=v3H7i8oot0R0Ai2nUcXlmvlyYJ9YMnpcF+FDLyavEpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j5JMG33gnSsTOdVGXhVOvnQpF/3EQWNm4KHayvTx3vdgi7GzHC5TrJ/oKwLw3yXEr
	 aSFtEUTs14XOIfPVhWlcMP8IFScrqhz6cMAytRZBt1hZgdtl0Iixq5p8yxCbkHEDEu
	 fdCph8hIUPR2l5X8VJWUGCO+w5voRrDNn95k5pP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfAXTkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387429AbfAXTkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:40:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AE1F20663;
        Thu, 24 Jan 2019 19:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358851;
        bh=v3H7i8oot0R0Ai2nUcXlmvlyYJ9YMnpcF+FDLyavEpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWmo5bN9wETkWn0pZ+TJXk71dQmAZEtwDoScHj0y/H2rAQDotFieREHm15UlFF+nI
         9okf1rTIIIEkN1n65+mLY4eLQVXay7D8YLXzZUp+rbFDdQKIa7au7XENnK/PgDiOiL
         s/AVaPAbIllZPpfowFzAyrOTTMKfnTSSoR957Z4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anna Schumaker <schumaker.anna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 049/127] rxe: IB_WR_REG_MR does not capture MRs iova field
Date:   Thu, 24 Jan 2019 20:19:55 +0100
Message-Id: <20190124190214.314603989@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 6c361d70d7cd..46f62f71cd28 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -643,6 +643,7 @@ next_wqe:
 			rmr->access = wqe->wr.wr.reg.access;
 			rmr->lkey = wqe->wr.wr.reg.key;
 			rmr->rkey = wqe->wr.wr.reg.key;
+			rmr->iova = wqe->wr.wr.reg.mr->iova;
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 		} else {
-- 
2.19.1



