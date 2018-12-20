Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17E3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F26B20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298784;
	bh=r9tr2YHiMUZkh3ZMWW1wBGDjAIHR0d0nXrGamgKaPms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zKNIx/qC33KQpxIzoqDBqQx336Cwflag1pCX/qAMCxHVuz3wGTxJVimNz8lVQYhU/
	 DGxlvGUB18x3hrwmI4lZjQL379o5CPjNBWBUPTbUDj5mjhg2v0lB60BZuiLhJt2EAx
	 enD4ltMpKdzT7cuqpiKAycKUIn73TKri2YxSUIkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbeLTJjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:39:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbeLTJZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1E4E20656;
        Thu, 20 Dec 2018 09:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297920;
        bh=r9tr2YHiMUZkh3ZMWW1wBGDjAIHR0d0nXrGamgKaPms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=COZTzltq8zyhNDHjle9r6ve1VAqDyAN31xKIAYcCoztmKjdsWmkjvrbej2pwjm1z8
         w5LR8XlIGULbIr5FEyhOE8ay7uXVZxwg51I2QiktE/a+MwXNg0Dn5xovXAoPiaOisc
         u99A+l0jZCiv+jswVqEmR4FrG/1TdVDn6xZzKssU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Israel Rukshin <israelr@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 59/61] nvmet-rdma: fix response use after free
Date:   Thu, 20 Dec 2018 10:18:59 +0100
Message-Id: <20181220085846.127580491@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d7dcdf9d4e15189ecfda24cc87339a3425448d5c ]

nvmet_rdma_release_rsp() may free the response before using it at error
flow.

Fixes: 8407879 ("nvmet-rdma: fix possible bogus dereference under heavy load")
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 2dfd877974d7..486393fa4f3e 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -524,6 +524,7 @@ static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_rsp *rsp =
 		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, send_cqe);
+	struct nvmet_rdma_queue *queue = cq->cq_context;
 
 	nvmet_rdma_release_rsp(rsp);
 
@@ -531,7 +532,7 @@ static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
 		     wc->status != IB_WC_WR_FLUSH_ERR)) {
 		pr_err("SEND for CQE 0x%p failed with status %s (%d).\n",
 			wc->wr_cqe, ib_wc_status_msg(wc->status), wc->status);
-		nvmet_rdma_error_comp(rsp->queue);
+		nvmet_rdma_error_comp(queue);
 	}
 }
 
-- 
2.19.1



