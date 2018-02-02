Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeBBG4A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 01:56:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40468 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeBBGzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 01:55:32 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] nvme-pci: break up nvme_timeout and nvme_dev_disable
Date: Fri,  2 Feb 2018 14:54:50 +0800
Message-Id: <1517554492-7680-5-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517554492-7680-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1517554492-7680-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the complicated relationship between nvme_dev_disable
and nvme_timeout has become a devil that will introduce many
circular pattern which may trigger deadlock or IO hang. Let's
enumerate the tangles between them:
 - nvme_timeout has to invoke nvme_dev_disable to stop the
   controller doing DMA access before free the request.
 - nvme_dev_disable has to depend on nvme_timeout to complete
   adminq requests to set HMB or delete sq/cq when the controller
   has no response.
 - nvme_dev_disable will race with nvme_timeout when cancels the
   outstanding requests.

To break up them, let's first look at what's kind of requests
nvme_timeout has to handle.

RESETTING          previous adminq/IOq request
or shutdown        adminq requests from nvme_dev_disable

RECONNECTING       adminq requests from nvme_reset_work

nvme_timeout has to invoke nvme_dev_disable first before complete
all the expired request above. We avoid this as following.

For the previous adminq/IOq request:
use blk_abort_request to force all the outstanding requests expired
in nvme_dev_disable. In nvme_timeout, set NVME_REQ_CANCELLED and
return BLK_EH_NOT_HANDLED. Then the request will not be completed and
freed. We needn't invoke nvme_dev_disable any more.

blk_abort_request is safe when race with irq completion path.
we have been able to grab all the outstanding requests. This could
eliminate the race between nvme_timeout and nvme_dev_disable.

We use NVME_REQ_CANCELLED to identify them. After the controller is
totally disabled/shutdown, we invoke blk_mq_rq_update_aborted_gstate
to clear requests and invoke blk_mq_complete_request to complete them.

In addition, to identify the previous adminq/IOq request and adminq
requests from nvme_dev_disable, we introduce NVME_PCI_OUTSTANDING_GRABBING
and NVME_PCI_OUTSTANDING_GRABBED to let nvme_timeout be able to
distinguish them.

For the adminq requests from nvme_dev_disable/nvme_reset_work:
invoke nvme_disable_ctrl directly, then set NVME_REQ_CANCELLED and
return BLK_EH_HANDLED. nvme_dev_disable/nvme_reset_work will
see the error.

With this patch, we could avoid nvme_dev_disable to be invoked
by nvme_timeout and eliminate the race between nvme_timeout and
nvme_dev_disable on outstanding requests.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 146 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 123 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a7fa397..5b192b0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -70,6 +70,8 @@ struct nvme_queue;
 
 static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+#define NVME_PCI_OUTSTANDING_GRABBING 1
+#define NVME_PCI_OUTSTANDING_GRABBED 2
 
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
@@ -80,6 +82,7 @@ struct nvme_dev {
 	struct blk_mq_tag_set admin_tagset;
 	u32 __iomem *dbs;
 	struct device *dev;
+	int grab_flag;
 	struct dma_pool *prp_page_pool;
 	struct dma_pool *prp_small_pool;
 	unsigned online_queues;
@@ -1130,6 +1133,23 @@ static void abort_endio(struct request *req, blk_status_t error)
 	blk_mq_free_request(req);
 }
 
+static void nvme_pci_disable_ctrl_directly(struct nvme_dev *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	u32 csts;
+	bool dead;
+
+	if (!pci_is_enabled(pdev))
+		return;
+
+	csts = readl(dev->bar + NVME_REG_CSTS);
+	dead = !!((csts & NVME_CSTS_CFS) ||
+			!(csts & NVME_CSTS_RDY) ||
+			pdev->error_state  != pci_channel_io_normal);
+	if (!dead)
+		nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
+}
+
 static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 {
 
@@ -1191,12 +1211,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 
 	/*
 	 * Reset immediately if the controller is failed
+	 * nvme_dev_disable will take over the expired requests.
 	 */
 	if (nvme_should_reset(dev, csts)) {
+		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		nvme_warn_reset(dev, csts);
-		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
-		return BLK_EH_HANDLED;
+		return BLK_EH_NOT_HANDLED;
 	}
 
 	/*
@@ -1210,38 +1231,51 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 
 	/*
-	 * Shutdown immediately if controller times out while starting. The
-	 * reset work will see the pci device disabled when it gets the forced
-	 * cancellation error. All outstanding requests are completed on
-	 * shutdown, so we return BLK_EH_HANDLED.
+	 * The previous outstanding requests on adminq and ioq have been
+	 * grabbed or drained for RECONNECTING state, so it must be admin
+	 * request from the nvme_dev_disable or  nvme_reset_work.
+	 * - stop the controller directly
+	 * - set NVME_REQ_CANCELLED, nvme_dev_disable or nvme_reset_work
+	 *   could see this error and stop.
+	 * - return BLK_EH_HANDLED
 	 */
-	if (dev->ctrl.state == NVME_CTRL_RESETTING) {
-		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, disable controller\n",
-			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
+	if ((READ_ONCE(dev->grab_flag) == NVME_PCI_OUTSTANDING_GRABBED) ||
+		(dev->ctrl.state == NVME_CTRL_RECONNECTING)) {
+		nvme_pci_disable_ctrl_directly(dev);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_HANDLED;
 	}
 
 	/*
- 	 * Shutdown the controller immediately and schedule a reset if the
- 	 * command was already aborted once before and still hasn't been
- 	 * returned to the driver, or if this is the admin queue.
+	 * nvme_dev_disable is grabbing all the outstanding requests.
+	 * Just set NVME_REQ_CANCELLED and return BLK_EH_NOT_HANDLED.
+	 * The nvme_dev_disable will take over all the things.
+	 */
+	if (READ_ONCE(dev->grab_flag) == NVME_PCI_OUTSTANDING_GRABBING) {
+		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		return BLK_EH_NOT_HANDLED;
+	}
+
+	/*
+	 * If the controller is DELETING, needn't to do any recovery,
+	 */
+	if (dev->ctrl.state == NVME_CTRL_DELETING) {
+		nvme_pci_disable_ctrl_directly(dev);
+		nvme_req(req)->status = NVME_SC_ABORT_REQ;
+		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		return BLK_EH_HANDLED;
+	}
+	/*
+	 * Just set NVME_REQ_CANCELLED and return BLK_EH_NOT_HANDLED,
+	 * The nvme_dev_disable will take over all the things.
 	 */
 	if (!nvmeq->qid || iod->aborted) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
-
-		/*
-		 * Mark the request as handled, since the inline shutdown
-		 * forces all outstanding requests to complete.
-		 */
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		return BLK_EH_HANDLED;
+		return BLK_EH_NOT_HANDLED;
 	}
 
 	if (atomic_dec_return(&dev->ctrl.abort_limit) < 0) {
@@ -2162,6 +2196,66 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
+static void nvme_pci_abort_rq(struct request *req, void *data, bool reserved)
+{
+	if (!blk_mq_request_started(req))
+		return;
+
+	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
+				"Abort I/O %d", req->tag);
+
+	nvme_req(req)->status = NVME_SC_ABORT_REQ;
+	blk_abort_request(req);
+}
+/*
+ * Now the controller has been disabled, no interrupt will race with us,
+ * so it is safe to complete them
+ *  - IO requests will be requeued.
+ *  - adminq requests will be failed, the tags will also be freed.
+ */
+static void nvme_pci_cancel_rq(struct request *req, void *data, bool reserved)
+{
+	if (!blk_mq_request_started(req))
+		return;
+
+	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
+				"Cancel I/O %d", req->tag);
+
+	/* controller has been disabled/shtdown, it is safe here to clear
+	 * the aborted_gstate and complete request.
+	 */
+	if (nvme_req(req)->flags | NVME_REQ_CANCELLED)
+		blk_mq_rq_update_aborted_gstate(req, 0);
+	blk_mq_complete_request(req);
+}
+
+
+static void nvme_pci_sync_timeout_work(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	/* ensure the timeout_work is queued */
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		kblockd_schedule_work(&ns->queue->timeout_work);
+
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		flush_work(&ns->queue->timeout_work);
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+
+static void nvme_pci_grab_outstanding(struct nvme_dev *dev)
+{
+	blk_mq_tagset_busy_iter(&dev->tagset, nvme_pci_abort_rq, &dev->ctrl);
+	blk_mq_tagset_busy_iter(&dev->admin_tagset,
+			nvme_pci_abort_rq, &dev->ctrl);
+	nvme_pci_sync_timeout_work(&dev->ctrl);
+	/* All the outstanding requests have been grabbed. They are forced to be
+	 * expired, neither irq completion path nor timeout path could take them
+	 * away.
+	 */
+}
+
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	int i;
@@ -2191,6 +2285,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	nvme_stop_queues(&dev->ctrl);
 
+	WRITE_ONCE(dev->grab_flag, NVME_PCI_OUTSTANDING_GRABBING);
+	nvme_pci_grab_outstanding(dev);
+	WRITE_ONCE(dev->grab_flag, NVME_PCI_OUTSTANDING_GRABBED);
+
 	if (!dead) {
 		/*
 		 * If the controller is still alive tell it to stop using the
@@ -2208,9 +2306,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	nvme_pci_disable(dev);
 
-	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
-	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
+	blk_mq_tagset_busy_iter(&dev->tagset, nvme_pci_cancel_rq, &dev->ctrl);
+	blk_mq_tagset_busy_iter(&dev->admin_tagset,
+			nvme_pci_cancel_rq, &dev->ctrl);
 
+	WRITE_ONCE(dev->grab_flag, 0);
 	/*
 	 * For shutdown case, controller will not be setup again soon. If any
 	 * residual requests here, the controller must have go wrong. Drain and
-- 
2.7.4
