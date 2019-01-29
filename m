Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D41C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A1621871
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762441;
	bh=6QOlXpnjtRiOWiAC8dT3S7r/GwQBkltFX0FTOkx48nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AIiFQ3vZr7iZW8phAbhOvhFjyt5Kii+A4qBbprwMYr5qyzn8KHclO7oo1H9K0FEdB
	 3GGZ2fQbruCL2TFML+zQgKM1OGrS7dYS/3jP3+a5DupFGYK1ts0LHOGQ80lIBt0Zg+
	 Dx/Q56fJ8Y1Kdg/4Ej/qUnFcOgugR4Zng2VGzc28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbfA2LrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:47:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730763AbfA2LrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49F7721852;
        Tue, 29 Jan 2019 11:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762435;
        bh=6QOlXpnjtRiOWiAC8dT3S7r/GwQBkltFX0FTOkx48nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+5JOuHkaiLBDdEtfTNvOcMwdp6cAYU6OqVB/jOD1liTjXVWRuy1pnYXVheOh3S+2
         Zh9dB/Y4cBO0ElJ6Otj02vUDoNZZedcTX3BJw0UTt0gfJXdJEj9xEfiN47+nRqPjlc
         QY2sweXCGb24E99PQc9YBJFMQx12hZ1Y15y3S2F8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
        Raju Rangoju <rajur@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 100/103] nvmet-rdma: fix null dereference under heavy load
Date:   Tue, 29 Jan 2019 12:36:17 +0100
Message-Id: <20190129113207.500254853@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

From: Raju Rangoju <rajur@chelsio.com>

commit 5cbab6303b4791a3e6713dfe2c5fda6a867f9adc upstream.

Under heavy load if we don't have any pre-allocated rsps left, we
dynamically allocate a rsp, but we are not actually allocating memory
for nvme_completion (rsp->req.rsp). In such a case, accessing pointer
fields (req->rsp->status) in nvmet_req_init() will result in crash.

To fix this, allocate the memory for nvme_completion by calling
nvmet_rdma_alloc_rsp()

Fixes: 8407879c("nvmet-rdma:fix possible bogus dereference under heavy load")

Cc: <stable@vger.kernel.org>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Raju Rangoju <rajur@chelsio.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/target/rdma.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -139,6 +139,10 @@ static void nvmet_rdma_recv_done(struct
 static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_qp_event(struct ib_event *event, void *priv);
 static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
+static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
+				struct nvmet_rdma_rsp *r);
+static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
+				struct nvmet_rdma_rsp *r);
 
 static const struct nvmet_fabrics_ops nvmet_rdma_ops;
 
@@ -182,9 +186,17 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_que
 	spin_unlock_irqrestore(&queue->rsps_lock, flags);
 
 	if (unlikely(!rsp)) {
-		rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
+		int ret;
+
+		rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
 		if (unlikely(!rsp))
 			return NULL;
+		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp);
+		if (unlikely(ret)) {
+			kfree(rsp);
+			return NULL;
+		}
+
 		rsp->allocated = true;
 	}
 
@@ -197,6 +209,7 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp
 	unsigned long flags;
 
 	if (unlikely(rsp->allocated)) {
+		nvmet_rdma_free_rsp(rsp->queue->dev, rsp);
 		kfree(rsp);
 		return;
 	}


