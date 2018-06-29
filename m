Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6600AC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FDC27C1D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FDC27C1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937299AbeF2UAt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:00:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:19117 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932396AbeF2UAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:00:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 13:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="241791986"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2018 13:00:46 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 1/4] nvme: cache struct nvme_ctrl reference to struct nvme_request
Date:   Fri, 29 Jun 2018 13:59:57 -0600
Message-Id: <20180629200000.16171-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180629200000.16171-1-keith.busch@intel.com>
References: <20180629200000.16171-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

We will need to reference the controller in the setup and completion
time for tracing and future traffic based keep alive support.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fc.c     | 1 +
 drivers/nvme/host/nvme.h   | 1 +
 drivers/nvme/host/pci.c    | 2 ++
 drivers/nvme/host/rdma.c   | 1 +
 drivers/nvme/target/loop.c | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 41d45a1b5c62..9cc33752539a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1737,6 +1737,7 @@ nvme_fc_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
 	struct nvme_fc_queue *queue = &ctrl->queues[queue_idx];
 
+	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	return __nvme_fc_init_request(ctrl, queue, op, rq, queue->rqcnt++);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0c4a33df3b2f..f2249387b60d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -102,6 +102,7 @@ struct nvme_request {
 	u8			retries;
 	u8			flags;
 	u16			status;
+	struct nvme_ctrl	*ctrl;
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba943f211687..8dcae11bbf3a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -418,6 +418,8 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
 
 	BUG_ON(!nvmeq);
 	iod->nvmeq = nvmeq;
+
+	nvme_req(req)->ctrl = &dev->ctrl;
 	return 0;
 }
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9544625c0b7d..ade55977d432 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -286,6 +286,7 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 	struct ib_device *ibdev = dev->dev;
 	int ret;
 
+	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	ret = nvme_rdma_alloc_qe(ibdev, &req->sqe, sizeof(struct nvme_command),
 			DMA_TO_DEVICE);
 	if (ret)
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d8d91f04bd7e..af7fbf4132b0 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -227,6 +227,7 @@ static int nvme_loop_init_request(struct blk_mq_tag_set *set,
 {
 	struct nvme_loop_ctrl *ctrl = set->driver_data;
 
+	nvme_req(req)->ctrl = &ctrl->ctrl;
 	return nvme_loop_init_iod(ctrl, blk_mq_rq_to_pdu(req),
 			(set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
 }
-- 
2.14.3

