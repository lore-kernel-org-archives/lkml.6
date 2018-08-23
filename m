Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3521C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6210E2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6210E2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbeHWMRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:17:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733048AbeHWMRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:17:16 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34B06BC1;
        Thu, 23 Aug 2018 08:48:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 073/324] nvme-rdma: Fix command completion race at error recovery
Date:   Thu, 23 Aug 2018 09:52:19 +0200
Message-Id: <20180823074959.590702917@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Israel Rukshin <israelr@mellanox.com>

[ Upstream commit c947657b15379505a9bba36a02005882b66abe57 ]

The race is between completing the request at error recovery work and
rdma completions.  If we cancel the request before getting the good
rdma completion we get a NULL deref of the request MR at
nvme_rdma_process_nvme_rsp().

When Canceling the request we return its mr to the mr pool (set mr to
NULL) and also unmap its data.  Canceling the requests while the rdma
queues are active is not safe.  Because rdma queues are active and we
get good rdma completions that can use the mr pointer which may be NULL.
Completing the request too soon may lead also to performing DMA to/from
user buffers which might have been already unmapped.

The commit fixes the race by draining the QP before starting the abort
commands mechanism.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/rdma.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -734,7 +734,6 @@ out:
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
 		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
@@ -819,7 +818,6 @@ out_free_queue:
 static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
-	nvme_rdma_stop_io_queues(ctrl);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
@@ -949,6 +947,7 @@ static void nvme_rdma_reconnect_ctrl_wor
 	return;
 
 destroy_admin:
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_rdma_destroy_admin_queue(ctrl, false);
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
@@ -965,12 +964,14 @@ static void nvme_rdma_error_recovery_wor
 
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, false);
 	}
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl, false);
@@ -1720,6 +1721,7 @@ static void nvme_rdma_shutdown_ctrl(stru
 {
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, shutdown);
@@ -1731,6 +1733,7 @@ static void nvme_rdma_shutdown_ctrl(stru
 		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
@@ -1996,6 +1999,7 @@ static struct nvme_ctrl *nvme_rdma_creat
 	return &ctrl->ctrl;
 
 out_remove_admin_queue:
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_rdma_destroy_admin_queue(ctrl, true);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);


