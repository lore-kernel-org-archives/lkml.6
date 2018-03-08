Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965975AbeCHGUg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 01:20:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39114 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935361AbeCHGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 01:20:29 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/5] nvme: add helper interface to flush in-flight requests
Date: Thu,  8 Mar 2018 14:19:28 +0800
Message-Id: <1520489971-31174-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=790
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we use nvme_cancel_request to complete the request
forcedly. This has following defects:
 - It is not safe to race with the normal completion path.
   blk_mq_complete_request is ok to race with timeout path,
   but not with itself.
 - Cannot ensure all the requests have been handled. The timeout
   path may grab some expired requests, blk_mq_complete_request
   cannot touch them.

add two helper interface to flush in-flight requests more safely.
- nvme_abort_requests_sync
use nvme_abort_req to timeout all the in-flight requests and wait
until timeout work and irq completion path completes. More details
please refer to the comment of this interface.
- nvme_flush_aborted_requests
complete the requests 'aborted' by nvme_abort_requests_sync. It will
be invoked after the controller is disabled/shutdown.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/core.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 +-
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7b8df47..e26759b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3567,6 +3567,102 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+static void nvme_abort_req(struct request *req, void *data, bool reserved)
+{
+	if (!blk_mq_request_started(req))
+		return;
+
+	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
+				"Abort I/O %d", req->tag);
+
+	/* The timeout path need identify this flag and return
+	 * BLK_EH_NOT_HANDLED, then the request will not be completed.
+	 * we will defer the completion after the controller is disabled or
+	 * shutdown.
+	 */
+	set_bit(NVME_REQ_ABORTED, &nvme_req(req)->flags);
+	blk_abort_request(req);
+}
+
+/*
+ * This function will ensure all the in-flight requests on the
+ * controller to be handled by timeout path or irq completion path.
+ * It has to pair with nvme_flush_aborted_requests which will be
+ * invoked after the controller has been disabled/shutdown and
+ * complete the requests 'aborted' by nvme_abort_req.
+ *
+ * Note, the driver layer will not be quiescent before disable
+ * controller, because the requests aborted by blk_abort_request
+ * are still active and the irq will fire at any time, but it can
+ * not enter into completion path, because the request has been
+ * timed out.
+ */
+void nvme_abort_requests_sync(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	blk_mq_tagset_busy_iter(ctrl->tagset, nvme_abort_req, ctrl);
+	blk_mq_tagset_busy_iter(ctrl->admin_tagset, nvme_abort_req, ctrl);
+	/*
+	 * ensure the timeout_work is queued, thus needn't to sync
+	 * the timer
+	 */
+	kblockd_schedule_work(&ctrl->admin_q->timeout_work);
+
+	down_read(&ctrl->namespaces_rwsem);
+
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		kblockd_schedule_work(&ns->queue->timeout_work);
+
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		flush_work(&ns->queue->timeout_work);
+
+	up_read(&ctrl->namespaces_rwsem);
+	/* This will ensure all the nvme irq completion path have exited */
+	synchronize_sched();
+}
+EXPORT_SYMBOL_GPL(nvme_abort_requests_sync);
+
+static void nvme_comp_req(struct request *req, void *data, bool reserved)
+{
+	struct nvme_ctrl *ctrl = (struct nvme_ctrl *)data;
+
+	if (!test_bit(NVME_REQ_ABORTED, &nvme_req(req)->flags))
+		return;
+
+	WARN_ON(!blk_mq_request_started(req));
+
+	if (ctrl->tagset && ctrl->tagset->ops->complete) {
+		clear_bit(NVME_REQ_ABORTED, &nvme_req(req)->flags);
+		/*
+		 * We set the status to NVME_SC_ABORT_REQ, then ioq request
+		 * will be requeued and adminq one will be failed.
+		 */
+		nvme_req(req)->status = NVME_SC_ABORT_REQ;
+		/*
+		 * For ioq request, blk_mq_requeue_request should be better
+		 * here. But the nvme code will still setup the cmd even if
+		 * the RQF_DONTPREP is set. We have to use .complete to free
+		 * the cmd and then requeue it.
+		 *
+		 * For adminq request, invoking .complete directly will miss
+		 * blk_mq_sched_completed_request, but this is ok because we
+		 * won't have io scheduler for adminq.
+		 */
+		ctrl->tagset->ops->complete(req);
+	}
+}
+
+/*
+ * Should pair with nvme_abort_requests_sync
+ */
+void nvme_flush_aborted_requests(struct nvme_ctrl *ctrl)
+{
+	blk_mq_tagset_busy_iter(ctrl->tagset, nvme_comp_req, ctrl);
+	blk_mq_tagset_busy_iter(ctrl->admin_tagset, nvme_comp_req, ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_flush_aborted_requests);
+
 int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
 {
 	if (!ctrl->ops->reinit_request)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 02097e8..3c71c73 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -104,6 +104,7 @@ struct nvme_request {
 
 enum {
 	NVME_REQ_CANCELLED		= 0,
+	NVME_REQ_ABORTED,            /* cmd is aborted by nvme_abort_request */
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -381,7 +382,8 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set);
-
+void nvme_abort_requests_sync(struct nvme_ctrl *ctrl);
+void nvme_flush_aborted_requests(struct nvme_ctrl *ctrl);
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
-- 
2.7.4
