Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A618C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F72120849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675907;
	bh=lN6HldHUMDFnqLgpJF+GR8BQy7JBX3djF8DaYQGUfYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Or8eNHrfg0Sn3OTpsly66nUzt26nQwVLAQXAZLX4AeQSs2JFkZpzZWcG90gnkqRmI
	 bPbYrpiW67HRG3opIidKUGSaI1jvNcbEb6nzhYRXzNa+Zq1f4yK5Epnd9eUzUNpoZh
	 hL4QNeHrH9S/YhtP4DHA6wjun3MZ8PFVk1tNr+1Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F72120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeLMEi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbeLMEc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD1B020882;
        Thu, 13 Dec 2018 04:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675577;
        bh=lN6HldHUMDFnqLgpJF+GR8BQy7JBX3djF8DaYQGUfYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7m83FAUcpdqvmHPeZvrJxBiua8/3wmxqRn7ZhiKInoykRvcqvzmOHWTHkjVraXiV
         NHQJx71IXVQTHHcayMBl4kxUKH46FiMH3PHSWYl5HUM/5LOiBkRgVo05FN4ZnoBGQs
         pnZXdJlGHDYjDFl7E//tFKmkjLj0hcbXhccJPQBQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Israel Rukshin <israelr@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 33/34] nvmet-rdma: fix response use after free
Date:   Wed, 12 Dec 2018 23:31:59 -0500
Message-Id: <20181213043200.76295-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
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

