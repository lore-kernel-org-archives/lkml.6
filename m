Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELujdpsFz1knZDg8A4ifTRYD/NSLpWQIdWAavDgGKa6PCjQVBtkbyKqsM8gqtgSlxcoe4wG1
ARC-Seal: i=1; a=rsa-sha256; t=1520452099; cv=none;
        d=google.com; s=arc-20160816;
        b=EOcc7Ol7hJfmBlghP+Q/NJNcnZSKKVwFWrzZ+e4H5pXJsetbPBUN+QHQ3cNx+W6VPL
         9lbybedUWSkfDEXvZAoSLwu2kwG9/2ptGkHs4E8rf5CM6HHfq94EjikHO1TYJIfqCog0
         4N8IwICj/l11dUNLegehuxLSj9bRGtzBO8KjLB7N+7fnGbkmizNV9EW53JPuIheHxvtR
         G0iu0fTDvCBa8Gmv3Hn+g6U1fQkAacZ/wrnIkAxJn19ykoXjX5NkKD42P+/RLt+ZxJWK
         lA+D6UA5zh8Qg3jL5RogdbFPiPfFgf4jZb3MwvZrIQx+2ZDsbGDKJGQqJhKttwatsFz1
         2fEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=89uPqjCWyjjvzGb+6urYYcKFQQMDUjdn5xOfwQV2RI0=;
        b=slAg+UozBGyLK492YZEdit56IJ9jHckVaukkWwJXC3WmezDfdLG1PbIRVXThr7yoJa
         yMFj9reUbKkPLPNE01my9Moya3g0slmL3+3zBjzNBtBhKWWPgVmuxgu2DnRw0UTwdzL4
         mNGfAr+OsOVibD/imC2i5Sazxdp5khBTPFUgpX1P59IAbuu4vkd5D8+kQfe2A2E209G8
         zGtwRC0n7MxhB4x25+/k+u+4WmAmUGOvmZuDawCX1kBt2EfKlm4Pvof/OURYkC0c+Sah
         6ZGcufAWLt2rGdcUfRPHXZ9lDk+g0yHj+1VES4BRcbJAJ7x4Xg/H3yMwYxNpdSIWxr85
         HoSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <maxg@mellanox.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.14 110/110] nvme-rdma: dont suppress send completions
Date: Wed,  7 Mar 2018 11:39:33 -0800
Message-Id: <20180307191054.072161192@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309581307081973?=
X-GMAIL-MSGID: =?utf-8?q?1594309581307081973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

commit b4b591c87f2b0f4ebaf3a68d4f13873b241aa584 upstream.

The entire completions suppress mechanism is currently broken because the
HCA might retry a send operation (due to dropped ack) after the nvme
transaction has completed.

In order to handle this, we signal all send completions and introduce a
separate done handler for async events as they will be handled differently
(as they don't include in-capsule data by definition).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/nvme/host/rdma.c |   54 ++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 40 deletions(-)

--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -88,7 +88,6 @@ enum nvme_rdma_queue_flags {
 
 struct nvme_rdma_queue {
 	struct nvme_rdma_qe	*rsp_ring;
-	atomic_t		sig_count;
 	int			queue_size;
 	size_t			cmnd_capsule_len;
 	struct nvme_rdma_ctrl	*ctrl;
@@ -521,7 +520,6 @@ static int nvme_rdma_alloc_queue(struct
 		queue->cmnd_capsule_len = sizeof(struct nvme_command);
 
 	queue->queue_size = queue_size;
-	atomic_set(&queue->sig_count, 0);
 
 	queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
 			RDMA_PS_TCP, IB_QPT_RC);
@@ -1232,21 +1230,9 @@ static void nvme_rdma_send_done(struct i
 		nvme_end_request(rq, req->status, req->result);
 }
 
-/*
- * We want to signal completion at least every queue depth/2.  This returns the
- * largest power of two that is not above half of (queue size + 1) to optimize
- * (avoid divisions).
- */
-static inline bool nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
-{
-	int limit = 1 << ilog2((queue->queue_size + 1) / 2);
-
-	return (atomic_inc_return(&queue->sig_count) & (limit - 1)) == 0;
-}
-
 static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
 		struct nvme_rdma_qe *qe, struct ib_sge *sge, u32 num_sge,
-		struct ib_send_wr *first, bool flush)
+		struct ib_send_wr *first)
 {
 	struct ib_send_wr wr, *bad_wr;
 	int ret;
@@ -1255,31 +1241,12 @@ static int nvme_rdma_post_send(struct nv
 	sge->length = sizeof(struct nvme_command),
 	sge->lkey   = queue->device->pd->local_dma_lkey;
 
-	qe->cqe.done = nvme_rdma_send_done;
-
 	wr.next       = NULL;
 	wr.wr_cqe     = &qe->cqe;
 	wr.sg_list    = sge;
 	wr.num_sge    = num_sge;
 	wr.opcode     = IB_WR_SEND;
-	wr.send_flags = 0;
-
-	/*
-	 * Unsignalled send completions are another giant desaster in the
-	 * IB Verbs spec:  If we don't regularly post signalled sends
-	 * the send queue will fill up and only a QP reset will rescue us.
-	 * Would have been way to obvious to handle this in hardware or
-	 * at least the RDMA stack..
-	 *
-	 * Always signal the flushes. The magic request used for the flush
-	 * sequencer is not allocated in our driver's tagset and it's
-	 * triggered to be freed by blk_cleanup_queue(). So we need to
-	 * always mark it as signaled to ensure that the "wr_cqe", which is
-	 * embedded in request's payload, is not freed when __ib_process_cq()
-	 * calls wr_cqe->done().
-	 */
-	if (nvme_rdma_queue_sig_limit(queue) || flush)
-		wr.send_flags |= IB_SEND_SIGNALED;
+	wr.send_flags = IB_SEND_SIGNALED;
 
 	if (first)
 		first->next = &wr;
@@ -1329,6 +1296,12 @@ static struct blk_mq_tags *nvme_rdma_tag
 	return queue->ctrl->tag_set.tags[queue_idx - 1];
 }
 
+static void nvme_rdma_async_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	if (unlikely(wc->status != IB_WC_SUCCESS))
+		nvme_rdma_wr_error(cq, wc, "ASYNC");
+}
+
 static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(arg);
@@ -1350,10 +1323,12 @@ static void nvme_rdma_submit_async_event
 	cmd->common.flags |= NVME_CMD_SGL_METABUF;
 	nvme_rdma_set_sg_null(cmd);
 
+	sqe->cqe.done = nvme_rdma_async_done;
+
 	ib_dma_sync_single_for_device(dev, sqe->dma, sizeof(*cmd),
 			DMA_TO_DEVICE);
 
-	ret = nvme_rdma_post_send(queue, sqe, &sge, 1, NULL, false);
+	ret = nvme_rdma_post_send(queue, sqe, &sge, 1, NULL);
 	WARN_ON_ONCE(ret);
 }
 
@@ -1639,7 +1614,6 @@ static blk_status_t nvme_rdma_queue_rq(s
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_qe *sqe = &req->sqe;
 	struct nvme_command *c = sqe->data;
-	bool flush = false;
 	struct ib_device *dev;
 	blk_status_t ret;
 	int err;
@@ -1668,13 +1642,13 @@ static blk_status_t nvme_rdma_queue_rq(s
 		goto err;
 	}
 
+	sqe->cqe.done = nvme_rdma_send_done;
+
 	ib_dma_sync_single_for_device(dev, sqe->dma,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
-	if (req_op(rq) == REQ_OP_FLUSH)
-		flush = true;
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
-			req->mr->need_inval ? &req->reg_wr.wr : NULL, flush);
+			req->mr->need_inval ? &req->reg_wr.wr : NULL);
 	if (unlikely(err)) {
 		nvme_rdma_unmap_data(queue, rq);
 		goto err;
