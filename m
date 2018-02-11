Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeBKJju (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 04:39:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbeBKJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 04:39:46 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] nvme-pci: break up nvme_timeout and nvme_dev_disable
Date: Sun, 11 Feb 2018 17:38:39 +0800
Message-Id: <1518341920-1060-9-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8801 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802110127
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
   previous outstanding requests.
2nd case is necessary. This patch is to break up 1st and 3th case.

To achieve this:
Use blk_abort_request to force all the previous outstanding requests
expired in nvme_dev_disable. Set NVME_REQ_CANCELLED and return
BLK_EH_NOT_HANDLED in nvme_timeout. Then the request will not be
completed and freed. We needn't invoke nvme_dev_disable any more.

We use NVME_REQ_CANCELLED to identify them. After the controller is
totally disabled/shutdown, we invoke blk_mq_rq_update_aborted_gstate
to clear requests and invoke blk_mq_complete_request to complete them.
In addition, to identify the previous adminq/IOq request and adminq
requests from nvme_dev_disable, we introduce
NVME_PCI_OUTSTANDING_GRABBING and NVME_PCI_OUTSTANDING_GRABBED to
let nvme_timeout be able to distinguish them.

For the adminq requests from nvme_dev_disable/nvme_reset_work:
invoke nvme_disable_ctrl directly, then set NVME_REQ_CANCELLED and
return BLK_EH_HANDLED. nvme_dev_disable/nvme_reset_work will
see the error.

With this patch, we could avoid nvme_dev_disable to be invoked
by nvme_timeout and implementat synchronization between them.

Suggested-by: Keith Busch <keith.busch@intel.com>
(If IO requests timeout in RECONNECTING state, fail them and kill the
 controller)
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 192 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 157 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f3e0eae..a0ff18e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -70,6 +70,9 @@ struct nvme_queue;
 
 static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+static void nvme_pci_free_and_disable(struct nvme_dev *dev);
+#define NVME_PCI_OUTSTANDING_GRABBING 1
+#define NVME_PCI_OUTSTANDING_GRABBED 2
 
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
@@ -80,6 +83,7 @@ struct nvme_dev {
 	struct blk_mq_tag_set admin_tagset;
 	u32 __iomem *dbs;
 	struct device *dev;
+	int grab_flag;
 	struct dma_pool *prp_page_pool;
 	struct dma_pool *prp_small_pool;
 	unsigned online_queues;
@@ -1130,6 +1134,24 @@ static void abort_endio(struct request *req, blk_status_t error)
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
+	nvme_pci_free_and_disable(dev);
+}
+
 static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 {
 
@@ -1191,12 +1213,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 
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
@@ -1210,38 +1233,59 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 
 	/*
-	 * Shutdown immediately if controller times out while starting. The
-	 * reset work will see the pci device disabled when it gets the forced
-	 * cancellation error. All outstanding requests are completed on
-	 * shutdown, so we return BLK_EH_HANDLED.
+	 * The previous outstanding requests on adminq and ioq have been
+	 * grabbed by nvme_dev_disable, so it must be admin request from
+	 * the nvme_dev_disable.
 	 */
-	if (dev->ctrl.state == NVME_CTRL_RESETTING) {
-		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, disable controller\n",
-			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
+	if ((READ_ONCE(dev->grab_flag) == NVME_PCI_OUTSTANDING_GRABBED)) {
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
+	 * There could IO request timeout during RECONNECTING state. It is
+	 * due to the wait freeze in nvme_reset_work. Plus the adminq request
+	 * timeout, don't try to requeue them and change state to DELETING to
+	 * prevent reset work from moving forward.
+	 */
+	if (dev->ctrl.state == NVME_CTRL_RECONNECTING) {
+		nvme_pci_disable_ctrl_directly(dev);
+		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		nvme_req(req)->status |= NVME_SC_DNR;
+		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
+		return BLK_EH_HANDLED;
+	}
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
@@ -2149,25 +2193,97 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 	pci_release_mem_regions(to_pci_dev(dev->dev));
 }
 
-static void nvme_pci_disable(struct nvme_dev *dev)
+static void nvme_pci_abort_rq(struct request *req, void *data, bool reserved)
 {
+	if (!blk_mq_request_started(req))
+		return;
+
+	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
+				"Abort I/O %d", req->tag);
+
+	nvme_req(req)->status = NVME_SC_ABORT_REQ;
+	blk_abort_request(req);
+}
+
+/*
+ * nvme_pci_grab_outstanding and shutdown_lock ensure will be
+ * only one nvme_pci_free_and_disable running at one moment.
+ */
+static void nvme_pci_free_and_disable(struct nvme_dev *dev)
+{
+	int onlines, i;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
+	if (!pci_is_enabled(pdev))
+		return;
+
+	onlines = dev->online_queues;
+	for (i = onlines - 1; i >= 0; i--)
+		nvme_suspend_queue(&dev->queues[i]);
+
 	nvme_release_cmb(dev);
 	pci_free_irq_vectors(pdev);
 
-	if (pci_is_enabled(pdev)) {
-		pci_disable_pcie_error_reporting(pdev);
-		pci_disable_device(pdev);
-	}
+	pci_disable_pcie_error_reporting(pdev);
+	pci_disable_device(pdev);
+}
+
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
+	/* ensure the timeout_work is queued */
+	kblockd_schedule_work(&ctrl->admin_q->timeout_work);
+	flush_work(&ctrl->admin_q->timeout_work);
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		kblockd_schedule_work(&ns->queue->timeout_work);
+
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		flush_work(&ns->queue->timeout_work);
+	up_read(&ctrl->namespaces_rwsem);
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
 }
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
-	int i;
 	bool dead = true;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int onlines;
 
 	mutex_lock(&dev->shutdown_lock);
 	if (pci_is_enabled(pdev)) {
@@ -2192,6 +2308,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	nvme_stop_queues(&dev->ctrl);
 
+	WRITE_ONCE(dev->grab_flag, NVME_PCI_OUTSTANDING_GRABBING);
+	nvme_pci_grab_outstanding(dev);
+	WRITE_ONCE(dev->grab_flag, NVME_PCI_OUTSTANDING_GRABBED);
+	/*
+	 * All the previous outstanding requests have been grabbed and
+	 * nvme_timeout path is guaranteed to be drained.
+	 */
+
 	if (!dead) {
 		/*
 		 * If the controller is still alive tell it to stop using the
@@ -2205,18 +2329,16 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 
-	onlines = dev->online_queues;
-	for (i = onlines - 1; i >= 0; i--)
-		nvme_suspend_queue(&dev->queues[i]);
-
 	if (dev->ctrl.admin_q)
 		blk_mq_quiesce_queue(dev->ctrl.admin_q);
 
-	nvme_pci_disable(dev);
+	nvme_pci_free_and_disable(dev);
 
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
