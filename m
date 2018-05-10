Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757040AbeEJJlu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:41:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45376 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeEJJlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:41:49 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] nvme-rdma: fix double free in nvme_rdma_free_queue
Date: Thu, 10 May 2018 17:42:08 +0800
Message-Id: <1525945328-1908-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100095
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: KASAN: double-free or invalid-free in nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [nvme_rdma]
Call Trace:
 dump_stack+0x91/0xeb
 print_address_description+0x6b/0x290
 kasan_report_invalid_free+0x55/0x80
 __kasan_slab_free+0x176/0x190
 kfree+0xeb/0x310
 nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
 nvme_rdma_configure_admin_queue+0x1a3/0x4d0 [nvme_rdma]
 nvme_rdma_reset_ctrl_work+0x4e/0xd0 [nvme_rdma]
 process_one_work+0x3ca/0xaa0
 worker_thread+0x4e2/0x6c0
 kthread+0x18d/0x1e0
 ret_from_fork+0x24/0x30

The double free is on ctrl->async_event_sqe.
If any case fails before ctrl->async_event_sqe is allocated in
nvme_rdma_configure_admin_queue, nvme_rdma_free_queue will be
invoked. However, at the moment, the ctrl->async_event_sqe has
not been allocated because it has been freed in
nvme_rdma_reset_ctrl_work
  -> nvme_rdma_shutdown_ctrl
    ->nvme_rdma_destroy_admin_queue
      -> nvme_rdma_free_queue

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---

V2:
handle it in nvme_rdma_free_queue and add some comment to explain it.

 drivers/nvme/host/rdma.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 966e0dd..fa5cf87 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -561,9 +561,18 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 		return;
 
 	if (nvme_rdma_queue_idx(queue) == 0) {
-		nvme_rdma_free_qe(queue->device->dev,
-			&queue->ctrl->async_event_sqe,
-			sizeof(struct nvme_command), DMA_TO_DEVICE);
+		/*
+		 * async_event_sqe is not allocated in nvme_rdma_alloc_queue.
+		 * so there are cases where NVME_RDMA_Q_ALLOCATED is set, but
+		 * async_event_sqe is not allocated. To avoid double free, set
+		 * async_event_sqe.data to NULL to indicate it has been freed.
+		 */
+		if (queue->ctrl->async_event_sqe.data) {
+			nvme_rdma_free_qe(queue->device->dev,
+				&queue->ctrl->async_event_sqe,
+				sizeof(struct nvme_command), DMA_TO_DEVICE);
+			queue->ctrl->async_event_sqe.data = NULL;
+		}
 	}
 
 	nvme_rdma_destroy_queue_ib(queue);
-- 
2.7.4
