Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D8C05C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839DA20869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839DA20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbeFKSqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:46:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:37000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752122AbeFKSqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:46:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DF440ABCD;
        Mon, 11 Jun 2018 18:46:34 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 1/1] nvme: trace: add disk name to tracepoints
Date:   Mon, 11 Jun 2018 20:46:30 +0200
Message-Id: <20180611184630.3435-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add disk name to tracepoints so we can better distinguish between
individual disks in the trace output.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---

I'm not entirely sure if this adding the ctrl pointers to
nvme_complete_rq() and nvme_setup_cmd() is a good idea, it's the
fast-path after all.

Changes to v3:
* Fix compilation of nvme-fc.ko (kbuild robot)
* Fix compilation of nvme-loop.ko (kbuild robot)

Changes to v2:
* Pass nvme_ctrl to nvme_complete_rq() and nvme_setup_cmd()
* Fixed typo in commit message
* Dropped Sagi's R-b (it changed quite a lot since v2)
---
 drivers/nvme/host/core.c   | 12 ++++++------
 drivers/nvme/host/fc.c     |  4 ++--
 drivers/nvme/host/nvme.h   |  6 +++---
 drivers/nvme/host/pci.c    |  7 ++++---
 drivers/nvme/host/rdma.c   |  5 +++--
 drivers/nvme/host/trace.h  | 36 ++++++++++++++++++++++--------------
 drivers/nvme/target/loop.c |  5 +++--
 7 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index effb1309682e..dc65c6cf94d3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -229,11 +229,11 @@ static inline bool nvme_req_needs_retry(struct request *req)
 	return true;
 }
 
-void nvme_complete_rq(struct request *req)
+void nvme_complete_rq(struct nvme_ctrl *ctrl, struct request *req)
 {
 	blk_status_t status = nvme_error_status(req);
 
-	trace_nvme_complete_rq(req);
+	trace_nvme_complete_rq(ctrl->cntlid, req);
 
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
 		if (nvme_req_needs_failover(req, status)) {
@@ -622,8 +622,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	return 0;
 }
 
-blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
-		struct nvme_command *cmd)
+blk_status_t nvme_setup_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			    struct request *req, struct nvme_command *cmd)
 {
 	blk_status_t ret = BLK_STS_OK;
 
@@ -653,9 +653,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 
 	cmd->common.command_id = req->tag;
 	if (ns)
-		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
+		trace_nvme_setup_nvm_cmd(ns->disk->disk_name, req->q->id, cmd);
 	else
-		trace_nvme_setup_admin_cmd(cmd);
+		trace_nvme_setup_admin_cmd(ctrl->cntlid, cmd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0bad65803271..e7357124dc90 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2288,7 +2288,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(ret))
 		return ret;
 
-	ret = nvme_setup_cmd(ns, rq, sqe);
+	ret = nvme_setup_cmd(&ctrl->ctrl, ns, rq, sqe);
 	if (ret)
 		return ret;
 
@@ -2369,7 +2369,7 @@ nvme_fc_complete_rq(struct request *rq)
 	atomic_set(&op->state, FCPOP_STATE_IDLE);
 
 	nvme_fc_unmap_data(ctrl, rq, op);
-	nvme_complete_rq(rq);
+	nvme_complete_rq(&ctrl->ctrl, rq);
 	nvme_fc_ctrl_put(ctrl);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 34df07d44f80..ce5e08887960 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -386,7 +386,7 @@ static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)
 	put_device(ctrl->device);
 }
 
-void nvme_complete_rq(struct request *req);
+void nvme_complete_rq(struct nvme_ctrl *ctrl, struct request *req);
 void nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
@@ -421,8 +421,8 @@ int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set);
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
-blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
-		struct nvme_command *cmd);
+blk_status_t nvme_setup_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			    struct request *req, struct nvme_command *cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cd7aec58a301..250fa84ec011 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -877,7 +877,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(nvmeq->cq_vector < 0))
 		return BLK_STS_IOERR;
 
-	ret = nvme_setup_cmd(ns, req, &cmnd);
+	ret = nvme_setup_cmd(&dev->ctrl, ns, req, &cmnd);
 	if (ret)
 		return ret;
 
@@ -904,9 +904,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 static void nvme_pci_complete_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_dev *dev = iod->nvmeq->dev;
 
-	nvme_unmap_data(iod->nvmeq->dev, req);
-	nvme_complete_rq(req);
+	nvme_unmap_data(dev, req);
+	nvme_complete_rq(&dev->ctrl, req);
 }
 
 /* We read the CQE phase first to check if the rest of the entry is valid */
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2aba03876d84..b3af36684150 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1627,7 +1627,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ib_dma_sync_single_for_cpu(dev, sqe->dma,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
-	ret = nvme_setup_cmd(ns, rq, c);
+	ret = nvme_setup_cmd(&queue->ctrl->ctrl, ns, rq, c);
 	if (ret)
 		return ret;
 
@@ -1684,9 +1684,10 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
 	nvme_rdma_unmap_data(req->queue, rq);
-	nvme_complete_rq(rq);
+	nvme_complete_rq(ctrl, rq);
 }
 
 static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 01390f0e1671..f252afb02426 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -76,9 +76,10 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 	nvme_trace_parse_nvm_cmd(p, opcode, cdw10)
 
 TRACE_EVENT(nvme_setup_admin_cmd,
-	    TP_PROTO(struct nvme_command *cmd),
-	    TP_ARGS(cmd),
+	    TP_PROTO(int ctrl_id, struct nvme_command *cmd),
+	    TP_ARGS(ctrl_id, cmd),
 	    TP_STRUCT__entry(
+		    __field(int, ctrl_id)
 		    __field(u8, opcode)
 		    __field(u8, flags)
 		    __field(u16, cid)
@@ -86,6 +87,7 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
+		    __entry->ctrl_id = ctrl_id;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -93,17 +95,19 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk(" cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->cid, __entry->flags, __entry->metadata,
+	    TP_printk("nvme%d: cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->ctrl_id, __entry->cid, __entry->flags,
+		      __entry->metadata,
 		      show_admin_opcode_name(__entry->opcode),
 		      __parse_nvme_admin_cmd(__entry->opcode, __entry->cdw10))
 );
 
 
 TRACE_EVENT(nvme_setup_nvm_cmd,
-	    TP_PROTO(int qid, struct nvme_command *cmd),
-	    TP_ARGS(qid, cmd),
+	    TP_PROTO(char *disk_name, int qid, struct nvme_command *cmd),
+	    TP_ARGS(disk_name, qid, cmd),
 	    TP_STRUCT__entry(
+		    __string(name, disk_name)
 		    __field(int, qid)
 		    __field(u8, opcode)
 		    __field(u8, flags)
@@ -113,6 +117,7 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
+		    __assign_str(name, disk_name);
 		    __entry->qid = qid;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
@@ -122,17 +127,18 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->qid, __entry->nsid, __entry->cid,
-		      __entry->flags, __entry->metadata,
+	    TP_printk("%s: qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __get_str(name), __entry->qid, __entry->nsid,
+		      __entry->cid, __entry->flags, __entry->metadata,
 		      show_opcode_name(__entry->opcode),
 		      __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
 );
 
 TRACE_EVENT(nvme_complete_rq,
-	    TP_PROTO(struct request *req),
-	    TP_ARGS(req),
+	    TP_PROTO(int ctrl_id, struct request *req),
+	    TP_ARGS(ctrl_id, req),
 	    TP_STRUCT__entry(
+		    __field(int, ctrl_id)
 		    __field(int, qid)
 		    __field(int, cid)
 		    __field(u64, result)
@@ -141,6 +147,7 @@ TRACE_EVENT(nvme_complete_rq,
 		    __field(u16, status)
 	    ),
 	    TP_fast_assign(
+		    __entry->ctrl_id = ctrl_id;
 		    __entry->qid = req->q->id;
 		    __entry->cid = req->tag;
 		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
@@ -148,9 +155,10 @@ TRACE_EVENT(nvme_complete_rq,
 		    __entry->flags = nvme_req(req)->flags;
 		    __entry->status = nvme_req(req)->status;
 	    ),
-	    TP_printk("qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
-		      __entry->qid, __entry->cid, __entry->result,
-		      __entry->retries, __entry->flags, __entry->status)
+	    TP_printk("nvme%d: qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __entry->ctrl_id, __entry->qid, __entry->cid,
+		      __entry->result, __entry->retries, __entry->flags,
+		      __entry->status)
 
 );
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 1304ec3a7ede..8598ba0402ff 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -83,10 +83,11 @@ static inline int nvme_loop_queue_idx(struct nvme_loop_queue *queue)
 static void nvme_loop_complete_rq(struct request *req)
 {
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_ctrl *ctrl = &iod->queue->ctrl->ctrl;
 
 	nvme_cleanup_cmd(req);
 	sg_free_table_chained(&iod->sg_table, true);
-	nvme_complete_rq(req);
+	nvme_complete_rq(ctrl, req);
 }
 
 static struct blk_mq_tags *nvme_loop_tagset(struct nvme_loop_queue *queue)
@@ -165,7 +166,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(ret))
 		return ret;
 
-	ret = nvme_setup_cmd(ns, req, &iod->cmd);
+	ret = nvme_setup_cmd(&queue->ctrl->ctrl, ns, req, &iod->cmd);
 	if (ret)
 		return ret;
 
-- 
2.16.4

