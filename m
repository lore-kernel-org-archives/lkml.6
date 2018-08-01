Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56351C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B96020862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B96020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbeHAUAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:00:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405667AbeHATIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B0E0713D9;
        Wed,  1 Aug 2018 17:16:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianchao Wang <jianchao.w.wang@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 089/246] nvme-rdma: stop admin queue before freeing it
Date:   Wed,  1 Aug 2018 18:49:59 +0200
Message-Id: <20180801165015.967427698@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianchao Wang <jianchao.w.wang@oracle.com>

[ Upstream commit 2e050f00a0f0e07467050cb4afae0234941e5bf3 ]

For any failure after nvme_rdma_start_queue in
nvme_rdma_configure_admin_queue, the admin queue will be freed with the
NVME_RDMA_Q_LIVE flag still set.  Once nvme_rdma_stop_queue is invoked,
that will cause a use-after-free.
BUG: KASAN: use-after-free in rdma_disconnect+0x1f/0xe0 [rdma_cm]

To fix it, call nvme_rdma_stop_queue for all the failed cases after
nvme_rdma_start_queue.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/rdma.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -796,7 +796,7 @@ static int nvme_rdma_configure_admin_que
 	if (error) {
 		dev_err(ctrl->ctrl.device,
 			"prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_queue;
+		goto out_stop_queue;
 	}
 
 	ctrl->ctrl.sqsize =
@@ -804,23 +804,25 @@ static int nvme_rdma_configure_admin_que
 
 	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_stop_queue;
 
 	ctrl->ctrl.max_hw_sectors =
 		(ctrl->max_fr_pages - 1) << (ilog2(SZ_4K) - 9);
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_stop_queue;
 
 	error = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
 			&ctrl->async_event_sqe, sizeof(struct nvme_command),
 			DMA_TO_DEVICE);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_stop_queue;
 
 	return 0;
 
+out_stop_queue:
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 out_cleanup_queue:
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.admin_q);


