Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D9EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208EA20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676121;
	bh=fYd7U/krjEaFMe2GCwqLaSlLYAJxE4qnH/SoLvS4yBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OIuM4fSdBZTXkj5ndUkaDIMbezTK5ZX1Jq5PUX0IzOiAt6WY++UFR1lXoonb8zKGE
	 EbMil/5XPWb0oq+YauuI4E+MPDT4xHPQloZ5cny2ph/dY9MCs6nR5GiPTQ5gmQWuVo
	 sC32kLiinHdMSob51C1s/PZaAy8pXQSCdIPLBkb4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208EA20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbeLMEl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbeLMEb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EDA220672;
        Thu, 13 Dec 2018 04:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675518;
        bh=fYd7U/krjEaFMe2GCwqLaSlLYAJxE4qnH/SoLvS4yBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7PDK3IvE39CzjhPHtH2uf4qv0IVZxzgqLU1Pd479tip0B9BreXaCEHhClj8s5Xo0
         9CVkG+d0QEL5mO7INI0B9KK1DSK9+AAqqoeocu3ehFJv4VzSu1GKRpZGGbYpZ3kdEu
         g+fBbVXTu+rameBcJf8lTBr64uB3NdxHk5uZXXKA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Israel Rukshin <israelr@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 40/41] nvmet-rdma: fix response use after free
Date:   Wed, 12 Dec 2018 23:30:53 -0500
Message-Id: <20181213043054.75891-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

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
index a70b3d24936d..5d8140e58f6f 100644
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

