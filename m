Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934278AbeEJJmM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:42:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48222 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757061AbeEJJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:42:10 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] nvme-rdma: stop queue first before free it in config admin queue
Date: Thu, 10 May 2018 17:42:27 +0800
Message-Id: <1525945347-1964-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100095
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When any of cases after nvme_rdma_start_queue in
nvme_rdma_configure_admin_queue fails, the ctrl->queues[0] will be
freed but the NVME_RDMA_Q_LIVE is still set. If nvme_rdma_stop_queue
is invoked, we will incur use-after-free which will cause memory
corruption.
BUG: KASAN: use-after-free in rdma_disconnect+0x1f/0xe0 [rdma_cm]
Read of size 8 at addr ffff8801dc3969c0 by task kworker/u16:3/9304

CPU: 3 PID: 9304 Comm: kworker/u16:3 Kdump: loaded Tainted: G        W         4.17.0-rc3+ #20
Workqueue: nvme-delete-wq nvme_delete_ctrl_work
Call Trace:
 dump_stack+0x91/0xeb
 print_address_description+0x6b/0x290
 kasan_report+0x261/0x360
 rdma_disconnect+0x1f/0xe0 [rdma_cm]
 nvme_rdma_stop_queue+0x25/0x40 [nvme_rdma]
 nvme_rdma_shutdown_ctrl+0xf3/0x150 [nvme_rdma]
 nvme_delete_ctrl_work+0x98/0xe0
 process_one_work+0x3ca/0xaa0
 worker_thread+0x4e2/0x6c0
 kthread+0x18d/0x1e0
 ret_from_fork+0x24/0x30

To fix it, call nvme_rdma_stop_queue for all the failed cases after
nvme_rdma_start_queue.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---

V2:
based on Sagi's suggestion, add out_stop_queue lable and invoke
nvme_rdma_stop_queue in all the failed cases after nvme_rdma_start_queue

 drivers/nvme/host/rdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a0ead1d..966e0dd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -777,7 +777,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error) {
 		dev_err(ctrl->ctrl.device,
 			"prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_queue;
+		goto out_stop_queue;
 	}
 
 	ctrl->ctrl.sqsize =
@@ -785,23 +785,25 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
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
-- 
2.7.4
