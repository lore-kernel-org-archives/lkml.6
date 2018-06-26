Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67075C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB9A26B24
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB9A26B24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935837AbeFZNvt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:51:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935437AbeFZNvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:51:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 479D8ACC6;
        Tue, 26 Jun 2018 13:51:46 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] nvme: cache struct nvme_ctrl reference to struct nvme_request
Date:   Tue, 26 Jun 2018 15:51:40 +0200
Message-Id: <20180626135141.14088-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180626135141.14088-1-jthumshirn@suse.de>
References: <20180626135141.14088-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

We will need to reference the controller in the setup and completion
time for tracing and future traffic based keep alive support.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c   | 6 ++++--
 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/nvme.h   | 5 +++--
 drivers/nvme/host/pci.c    | 2 +-
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/target/loop.c | 2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e541fe268bcf..62602af9eb77 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -390,6 +390,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		nvme_req(req)->retries = 0;
 		nvme_req(req)->flags = 0;
+		nvme_req(req)->ctrl = NULL;
 		req->rq_flags |= RQF_DONTPREP;
 	}
 }
@@ -622,8 +623,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	return 0;
 }
 
-blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
-		struct nvme_command *cmd)
+blk_status_t nvme_setup_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			    struct request *req, struct nvme_command *cmd)
 {
 	blk_status_t ret = BLK_STS_OK;
 
@@ -652,6 +653,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	}
 
 	cmd->common.command_id = req->tag;
+	nvme_req(req)->ctrl = ctrl;
 	if (ns)
 		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
 	else
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 41d45a1b5c62..afde86f3ac6e 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2274,7 +2274,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	    !nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvmf_fail_nonready_command(rq);
 
-	ret = nvme_setup_cmd(ns, rq, sqe);
+	ret = nvme_setup_cmd(&ctrl->ctrl, ns, rq, sqe);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0c4a33df3b2f..6fb9dcec6d93 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -102,6 +102,7 @@ struct nvme_request {
 	u8			retries;
 	u8			flags;
 	u16			status;
+	struct nvme_ctrl	*ctrl;
 };
 
 /*
@@ -420,8 +421,8 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
-blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
-		struct nvme_command *cmd);
+blk_status_t nvme_setup_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			    struct request *req, struct nvme_command *cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba943f211687..a3750205da69 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -883,7 +883,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(nvmeq->cq_vector < 0))
 		return BLK_STS_IOERR;
 
-	ret = nvme_setup_cmd(ns, req, &cmnd);
+	ret = nvme_setup_cmd(&dev->ctrl, ns, req, &cmnd);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9f5fc7b7fd7f..fefa661f89a0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1685,7 +1685,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ib_dma_sync_single_for_cpu(dev, sqe->dma,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
-	ret = nvme_setup_cmd(ns, rq, c);
+	ret = nvme_setup_cmd(&queue->ctrl->ctrl, ns, rq, c);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d8d91f04bd7e..888bd3fefc4d 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -164,7 +164,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!nvmf_check_ready(&queue->ctrl->ctrl, req, queue_ready))
 		return nvmf_fail_nonready_command(req);
 
-	ret = nvme_setup_cmd(ns, req, &iod->cmd);
+	ret = nvme_setup_cmd(&queue->ctrl->ctrl, ns, req, &iod->cmd);
 	if (ret)
 		return ret;
 
-- 
2.16.4

