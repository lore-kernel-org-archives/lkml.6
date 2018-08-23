Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2223AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81B12077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81B12077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbeHWMRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:17:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbeHWMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:17:12 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CE4DE941;
        Thu, 23 Aug 2018 08:48:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 072/324] nvme-rdma: fix possible double free condition when failing to create a controller
Date:   Thu, 23 Aug 2018 09:52:18 +0200
Message-Id: <20180823074959.547338555@linuxfoundation.org>
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 3d0641015bf73aaa1cb54c936674959e7805070f ]

Failures after nvme_init_ctrl will defer resource cleanups to .free_ctrl
when the reference is released, hence we should not free the controller
queues for these failures.

Fix that by moving controller queues allocation before controller
initialization and correctly freeing them for failures before
initialization and skip them for failures after initialization.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/rdma.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -888,9 +888,9 @@ static void nvme_rdma_free_ctrl(struct n
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-	kfree(ctrl->queues);
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	kfree(ctrl->queues);
 	kfree(ctrl);
 }
 
@@ -1916,11 +1916,6 @@ static struct nvme_ctrl *nvme_rdma_creat
 		goto out_free_ctrl;
 	}
 
-	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
-				0 /* no quirks, we're perfect! */);
-	if (ret)
-		goto out_free_ctrl;
-
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
@@ -1934,14 +1929,19 @@ static struct nvme_ctrl *nvme_rdma_creat
 	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
 				GFP_KERNEL);
 	if (!ctrl->queues)
-		goto out_uninit_ctrl;
+		goto out_free_ctrl;
+
+	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
+				0 /* no quirks, we're perfect! */);
+	if (ret)
+		goto out_kfree_queues;
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
 	WARN_ON_ONCE(!changed);
 
 	ret = nvme_rdma_configure_admin_queue(ctrl, true);
 	if (ret)
-		goto out_kfree_queues;
+		goto out_uninit_ctrl;
 
 	/* sanity check icdoff */
 	if (ctrl->ctrl.icdoff) {
@@ -1997,14 +1997,14 @@ static struct nvme_ctrl *nvme_rdma_creat
 
 out_remove_admin_queue:
 	nvme_rdma_destroy_admin_queue(ctrl, true);
-out_kfree_queues:
-	kfree(ctrl->queues);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
+out_kfree_queues:
+	kfree(ctrl->queues);
 out_free_ctrl:
 	kfree(ctrl);
 	return ERR_PTR(ret);


