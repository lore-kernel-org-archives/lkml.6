Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57993C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E03621780
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdeNUVay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E03621780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbeKLIUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388390AbeKLIUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:09 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F45216FD;
        Sun, 11 Nov 2018 22:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975411;
        bh=786esyUBKOyQw849EvrCadjJIXjM4xY/ae7rSS3OmrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HdeNUVay/ipCh7On4DA51NTTywr5qC1N+DzjStohGmI7iftGlPUvvFWeoLzD8WUhI
         fyCuzIY20jiJBcFUnxToMuXBTvR2WRHDxMEbeQay8GwtOLcTtpyxAk0uzP1nPiUAe8
         4pS1nLFDdQVWF71D+oWKP5xafwIgk/F/Tgx1tqF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 090/350] nvmet-rdma: use a private workqueue for delete
Date:   Sun, 11 Nov 2018 14:19:14 -0800
Message-Id: <20181111221710.879282379@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 2acf70ade79d26b97611a8df52eb22aa33814cd4 ]

Queue deletion is done asynchronous when the last reference on the queue
is dropped.  Thus, in order to make sure we don't over allocate under a
connect/disconnect storm, we let queue deletion complete before making
forward progress.

However, given that we flush the system_wq from rdma_cm context which
runs from a workqueue context, we can have a circular locking complaint
[1]. Fix that by using a private workqueue for queue deletion.

[1]:
======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc4-dbg+ #3 Not tainted
------------------------------------------------------
kworker/5:0/39 is trying to acquire lock:
00000000a10b6db9 (&id_priv->handler_mutex){+.+.}, at: rdma_destroy_id+0x6f/0x440 [rdma_cm]

but task is already holding lock:
00000000331b4e2c ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3ed/0xa20

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 ((work_completion)(&queue->release_work)){+.+.}:
       process_one_work+0x474/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #2 ((wq_completion)"events"){+.+.}:
       flush_workqueue+0xf3/0x970
       nvmet_rdma_cm_handler+0x133d/0x1734 [nvmet_rdma]
       cma_ib_req_handler+0x72f/0xf90 [rdma_cm]
       cm_process_work+0x2e/0x110 [ib_cm]
       cm_req_handler+0x135b/0x1c30 [ib_cm]
       cm_work_handler+0x2b7/0x38cd [ib_cm]
       process_one_work+0x4ae/0xa20
nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: disconnected (10): status 0 id 0000000040357082
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30
nvme nvme0: Reconnecting in 10 seconds...

-> #1 (&id_priv->handler_mutex/1){+.+.}:
       __mutex_lock+0xfe/0xbe0
       mutex_lock_nested+0x1b/0x20
       cma_ib_req_handler+0x6aa/0xf90 [rdma_cm]
       cm_process_work+0x2e/0x110 [ib_cm]
       cm_req_handler+0x135b/0x1c30 [ib_cm]
       cm_work_handler+0x2b7/0x38cd [ib_cm]
       process_one_work+0x4ae/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #0 (&id_priv->handler_mutex){+.+.}:
       lock_acquire+0xc5/0x200
       __mutex_lock+0xfe/0xbe0
       mutex_lock_nested+0x1b/0x20
       rdma_destroy_id+0x6f/0x440 [rdma_cm]
       nvmet_rdma_release_queue_work+0x8e/0x1b0 [nvmet_rdma]
       process_one_work+0x4ae/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

Fixes: 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown")
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Bart Van Assche <bvanassche@acm.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>

Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/rdma.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -119,6 +119,7 @@ struct nvmet_rdma_device {
 	struct list_head	entry;
 };
 
+struct workqueue_struct *nvmet_rdma_delete_wq;
 static bool nvmet_rdma_use_srq;
 module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
 MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
@@ -1169,12 +1170,12 @@ static int nvmet_rdma_queue_connect(stru
 
 	if (queue->host_qid == 0) {
 		/* Let inflight controller teardown complete */
-		flush_scheduled_work();
+		flush_workqueue(nvmet_rdma_delete_wq);
 	}
 
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
 	if (ret) {
-		schedule_work(&queue->release_work);
+		queue_work(nvmet_rdma_delete_wq, &queue->release_work);
 		/* Destroying rdma_cm id is not needed here */
 		return 0;
 	}
@@ -1239,7 +1240,7 @@ static void __nvmet_rdma_queue_disconnec
 
 	if (disconnect) {
 		rdma_disconnect(queue->cm_id);
-		schedule_work(&queue->release_work);
+		queue_work(nvmet_rdma_delete_wq, &queue->release_work);
 	}
 }
 
@@ -1269,7 +1270,7 @@ static void nvmet_rdma_queue_connect_fai
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 
 	pr_err("failed to connect queue %d\n", queue->idx);
-	schedule_work(&queue->release_work);
+	queue_work(nvmet_rdma_delete_wq, &queue->release_work);
 }
 
 /**
@@ -1543,8 +1544,17 @@ static int __init nvmet_rdma_init(void)
 	if (ret)
 		goto err_ib_client;
 
+	nvmet_rdma_delete_wq = alloc_workqueue("nvmet-rdma-delete-wq",
+			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	if (!nvmet_rdma_delete_wq) {
+		ret = -ENOMEM;
+		goto err_unreg_transport;
+	}
+
 	return 0;
 
+err_unreg_transport:
+	nvmet_unregister_transport(&nvmet_rdma_ops);
 err_ib_client:
 	ib_unregister_client(&nvmet_rdma_ib_client);
 	return ret;
@@ -1552,6 +1562,7 @@ err_ib_client:
 
 static void __exit nvmet_rdma_exit(void)
 {
+	destroy_workqueue(nvmet_rdma_delete_wq);
 	nvmet_unregister_transport(&nvmet_rdma_ops);
 	ib_unregister_client(&nvmet_rdma_ib_client);
 	WARN_ON_ONCE(!list_empty(&nvmet_rdma_queue_list));


