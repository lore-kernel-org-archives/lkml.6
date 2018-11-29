Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604CDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142152146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcL4YHYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142152146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389329AbeK3Bhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732374AbeK3Bhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:37:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646EB2145D;
        Thu, 29 Nov 2018 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501920;
        bh=2iIF1BYLCp8Fh9E9YwBd5Vfny2ApSprcdx/NrOneWu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcL4YHYetOEh9xSOzXPCbGVjliV3vTPSf8c3lnWYOdhQei5Gep0qIMgs0VD1KL9Ys
         gziUmJpwi4LDbApeSWfp9Z5EZEvFr8dtcxiVPiDNQ4XONEiDKmBWZTQgGk0I/2RxKW
         cB+IO6RAQhpZ8YzGundrkCE7NpHMhUqGmMC5sYEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mitko Haralanov <mitko.haralanov@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 062/110] IB/hfi1: Eliminate races in the SDMA send error path
Date:   Thu, 29 Nov 2018 15:12:33 +0100
Message-Id: <20181129135923.760004612@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit a0e0cb82804a6a21d9067022c2dfdf80d11da429 upstream.

pq_update() can only be called in two places: from the completion
function when the complete (npkts) sequence of packets has been
submitted and processed, or from setup function if a subset of the
packets were submitted (i.e. the error path).

Currently both paths can call pq_update() if an error occurrs.  This
race will cause the n_req value to go negative, hanging file_close(),
or cause a crash by freeing the txlist more than once.

Several variables are used to determine SDMA send state.  Most of
these are unnecessary, and have code inspectible races between the
setup function and the completion function, in both the send path and
the error path.

The request 'status' value can be set by the setup or by the
completion function.  This is code inspectibly racy.  Since the status
is not needed in the completion code or by the caller it has been
removed.

The request 'done' value races between usage by the setup and the
completion function.  The completion function does not need this.
When the number of processed packets matches npkts, it is done.

The 'has_error' value races between usage of the setup and the
completion function.  This can cause incorrect error handling and leave
the n_req in an incorrect value (i.e. negative).

Simplify the code by removing all of the unneeded state checks and
variables.

Clean up iovs node when it is freed.

Eliminate race conditions in the error path:

If all packets are submitted, the completion handler will set the
completion status correctly (ok or aborted).

If all packets are not submitted, the caller must wait until the
submitted packets have completed, and then set the completion status.

These two change eliminate the race condition in the error path.

Reviewed-by: Mitko Haralanov <mitko.haralanov@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/user_sdma.c |   85 ++++++++++++++-------------------
 drivers/infiniband/hw/hfi1/user_sdma.h |    3 -
 2 files changed, 38 insertions(+), 50 deletions(-)

--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -328,7 +328,6 @@ int hfi1_user_sdma_process_request(struc
 	u8 opcode, sc, vl;
 	u16 pkey;
 	u32 slid;
-	int req_queued = 0;
 	u16 dlid;
 	u32 selector;
 
@@ -392,7 +391,6 @@ int hfi1_user_sdma_process_request(struc
 	req->data_len  = 0;
 	req->pq = pq;
 	req->cq = cq;
-	req->status = -1;
 	req->ahg_idx = -1;
 	req->iov_idx = 0;
 	req->sent = 0;
@@ -400,12 +398,14 @@ int hfi1_user_sdma_process_request(struc
 	req->seqcomp = 0;
 	req->seqsubmitted = 0;
 	req->tids = NULL;
-	req->done = 0;
 	req->has_error = 0;
 	INIT_LIST_HEAD(&req->txps);
 
 	memcpy(&req->info, &info, sizeof(info));
 
+	/* The request is initialized, count it */
+	atomic_inc(&pq->n_reqs);
+
 	if (req_opcode(info.ctrl) == EXPECTED) {
 		/* expected must have a TID info and at least one data vector */
 		if (req->data_iovs < 2) {
@@ -500,7 +500,6 @@ int hfi1_user_sdma_process_request(struc
 		ret = pin_vector_pages(req, &req->iovs[i]);
 		if (ret) {
 			req->data_iovs = i;
-			req->status = ret;
 			goto free_req;
 		}
 		req->data_len += req->iovs[i].iov.iov_len;
@@ -561,14 +560,10 @@ int hfi1_user_sdma_process_request(struc
 		req->ahg_idx = sdma_ahg_alloc(req->sde);
 
 	set_comp_state(pq, cq, info.comp_idx, QUEUED, 0);
-	atomic_inc(&pq->n_reqs);
-	req_queued = 1;
 	/* Send the first N packets in the request to buy us some time */
 	ret = user_sdma_send_pkts(req, pcount);
-	if (unlikely(ret < 0 && ret != -EBUSY)) {
-		req->status = ret;
+	if (unlikely(ret < 0 && ret != -EBUSY))
 		goto free_req;
-	}
 
 	/*
 	 * It is possible that the SDMA engine would have processed all the
@@ -588,14 +583,8 @@ int hfi1_user_sdma_process_request(struc
 	while (req->seqsubmitted != req->info.npkts) {
 		ret = user_sdma_send_pkts(req, pcount);
 		if (ret < 0) {
-			if (ret != -EBUSY) {
-				req->status = ret;
-				WRITE_ONCE(req->has_error, 1);
-				if (READ_ONCE(req->seqcomp) ==
-				    req->seqsubmitted - 1)
-					goto free_req;
-				return ret;
-			}
+			if (ret != -EBUSY)
+				goto free_req;
 			wait_event_interruptible_timeout(
 				pq->busy.wait_dma,
 				(pq->state == SDMA_PKT_Q_ACTIVE),
@@ -606,10 +595,19 @@ int hfi1_user_sdma_process_request(struc
 	*count += idx;
 	return 0;
 free_req:
-	user_sdma_free_request(req, true);
-	if (req_queued)
+	/*
+	 * If the submitted seqsubmitted == npkts, the completion routine
+	 * controls the final state.  If sequbmitted < npkts, wait for any
+	 * outstanding packets to finish before cleaning up.
+	 */
+	if (req->seqsubmitted < req->info.npkts) {
+		if (req->seqsubmitted)
+			wait_event(pq->busy.wait_dma,
+				   (req->seqcomp == req->seqsubmitted - 1));
+		user_sdma_free_request(req, true);
 		pq_update(pq);
-	set_comp_state(pq, cq, info.comp_idx, ERROR, req->status);
+		set_comp_state(pq, cq, info.comp_idx, ERROR, ret);
+	}
 	return ret;
 }
 
@@ -917,7 +915,6 @@ dosend:
 	ret = sdma_send_txlist(req->sde, &pq->busy, &req->txps, &count);
 	req->seqsubmitted += count;
 	if (req->seqsubmitted == req->info.npkts) {
-		WRITE_ONCE(req->done, 1);
 		/*
 		 * The txreq has already been submitted to the HW queue
 		 * so we can free the AHG entry now. Corruption will not
@@ -1365,11 +1362,15 @@ static int set_txreq_header_ahg(struct u
 	return idx;
 }
 
-/*
- * SDMA tx request completion callback. Called when the SDMA progress
- * state machine gets notification that the SDMA descriptors for this
- * tx request have been processed by the DMA engine. Called in
- * interrupt context.
+/**
+ * user_sdma_txreq_cb() - SDMA tx request completion callback.
+ * @txreq: valid sdma tx request
+ * @status: success/failure of request
+ *
+ * Called when the SDMA progress state machine gets notification that
+ * the SDMA descriptors for this tx request have been processed by the
+ * DMA engine. Called in interrupt context.
+ * Only do work on completed sequences.
  */
 static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status)
 {
@@ -1378,7 +1379,7 @@ static void user_sdma_txreq_cb(struct sd
 	struct user_sdma_request *req;
 	struct hfi1_user_sdma_pkt_q *pq;
 	struct hfi1_user_sdma_comp_q *cq;
-	u16 idx;
+	enum hfi1_sdma_comp_state state = COMPLETE;
 
 	if (!tx->req)
 		return;
@@ -1391,31 +1392,19 @@ static void user_sdma_txreq_cb(struct sd
 		SDMA_DBG(req, "SDMA completion with error %d",
 			 status);
 		WRITE_ONCE(req->has_error, 1);
+		state = ERROR;
 	}
 
 	req->seqcomp = tx->seqnum;
 	kmem_cache_free(pq->txreq_cache, tx);
-	tx = NULL;
 
-	idx = req->info.comp_idx;
-	if (req->status == -1 && status == SDMA_TXREQ_S_OK) {
-		if (req->seqcomp == req->info.npkts - 1) {
-			req->status = 0;
-			user_sdma_free_request(req, false);
-			pq_update(pq);
-			set_comp_state(pq, cq, idx, COMPLETE, 0);
-		}
-	} else {
-		if (status != SDMA_TXREQ_S_OK)
-			req->status = status;
-		if (req->seqcomp == (READ_ONCE(req->seqsubmitted) - 1) &&
-		    (READ_ONCE(req->done) ||
-		     READ_ONCE(req->has_error))) {
-			user_sdma_free_request(req, false);
-			pq_update(pq);
-			set_comp_state(pq, cq, idx, ERROR, req->status);
-		}
-	}
+	/* sequence isn't complete?  We are done */
+	if (req->seqcomp != req->info.npkts - 1)
+		return;
+
+	user_sdma_free_request(req, false);
+	set_comp_state(pq, cq, req->info.comp_idx, state, status);
+	pq_update(pq);
 }
 
 static inline void pq_update(struct hfi1_user_sdma_pkt_q *pq)
@@ -1448,6 +1437,8 @@ static void user_sdma_free_request(struc
 		if (!node)
 			continue;
 
+		req->iovs[i].node = NULL;
+
 		if (unpin)
 			hfi1_mmu_rb_remove(req->pq->handler,
 					   &node->rb);
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -205,8 +205,6 @@ struct user_sdma_request {
 	/* Writeable fields shared with interrupt */
 	u64 seqcomp ____cacheline_aligned_in_smp;
 	u64 seqsubmitted;
-	/* status of the last txreq completed */
-	int status;
 
 	/* Send side fields */
 	struct list_head txps ____cacheline_aligned_in_smp;
@@ -228,7 +226,6 @@ struct user_sdma_request {
 	u16 tididx;
 	/* progress index moving along the iovs array */
 	u8 iov_idx;
-	u8 done;
 	u8 has_error;
 
 	struct user_sdma_iovec iovs[MAX_VECTORS_PER_REQ];


