Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D504F21927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198238;
	bh=nea4Wn8nOz0hjIBBYZWzQYPhtp1Y7vTYjTgDb096TvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wBu9f/HG3Jlw9DpU5hiLpWpZ2scn0KimvBMUHhfM1AGvinBx5NpBU7B/yqjw0RkdP
	 meCB6foydSHRius6hpnlxoEs+zMTGTnPTLnPP2FFbN4jlKehjfQclKLAAjG8Urzq0s
	 BsUY3jA0jipbwAz47j2j7E6WoVO+djHjjfRM8PMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389071AbfBOChR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:37:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390619AbfBOCKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 770FC222D4;
        Fri, 15 Feb 2019 02:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196635;
        bh=nea4Wn8nOz0hjIBBYZWzQYPhtp1Y7vTYjTgDb096TvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwTqway9V501o+w7Eq5QXvAeUxXOA9nf04GtX1QNFV0nyQzh9jWkn27HeGbycPNvq
         yPIntcyTcqpGRK+mkNTSaTGeQ9I0HkH1I4dVxdUAArSpguUsBvCmh164qMCL/gt/ZM
         FJcGpMR+fbPQ1OEX0Rm5DV/6g1361L4CF1zJH1Do=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 60/77] nvme-rdma: fix timeout handler
Date:   Thu, 14 Feb 2019 21:08:38 -0500
Message-Id: <20190215020855.176727-60-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 4c174e6366746ae8d49f9cc409f728eebb7a9ac9 ]

Currently, we have several problems with the timeout
handler:
1. If we timeout on the controller establishment flow, we will hang
because we don't execute the error recovery (and we shouldn't because
the create_ctrl flow needs to fail and cleanup on its own)
2. We might also hang if we get a disconnet on a queue while the
controller is already deleting. This racy flow can cause the controller
disable/shutdown admin command to hang.

We cannot complete a timed out request from the timeout handler without
mutual exclusion from the teardown flow (e.g. nvme_rdma_error_recovery_work).
So we serialize it in the timeout handler and teardown io and admin
queues to guarantee that no one races with us from completing the
request.

Reported-by: Jaesoo Lee <jalee@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ab6ec7295bf9..6e24b20304b5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1679,18 +1679,28 @@ static enum blk_eh_timer_return
 nvme_rdma_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_queue *queue = req->queue;
+	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 
-	dev_warn(req->queue->ctrl->ctrl.device,
-		 "I/O %d QID %d timeout, reset controller\n",
-		 rq->tag, nvme_rdma_queue_idx(req->queue));
+	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
+		 rq->tag, nvme_rdma_queue_idx(queue));
 
-	/* queue error recovery */
-	nvme_rdma_error_recovery(req->queue->ctrl);
+	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
+		/*
+		 * Teardown immediately if controller times out while starting
+		 * or we are already started error recovery. all outstanding
+		 * requests are completed on shutdown, so we return BLK_EH_DONE.
+		 */
+		flush_work(&ctrl->err_work);
+		nvme_rdma_teardown_io_queues(ctrl, false);
+		nvme_rdma_teardown_admin_queue(ctrl, false);
+		return BLK_EH_DONE;
+	}
 
-	/* fail with DNR on cmd timeout */
-	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
+	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
+	nvme_rdma_error_recovery(ctrl);
 
-	return BLK_EH_DONE;
+	return BLK_EH_RESET_TIMER;
 }
 
 static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
-- 
2.19.1

