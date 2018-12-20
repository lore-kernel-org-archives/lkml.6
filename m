Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C729CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884ED21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298104;
	bh=+RrqGmZz7aew2GY6efOMTn5wOYn9Ds9yHoIPVWVgHog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cChIH1xWEpuFA+a94yl3fXH3tw0zllBrALYem3nDuS0OyNYHHmfs001eN2STNQhye
	 Gh8vRNqaRXbxj+WiwVyW6+ceqZBnl0XtE12fYI/z7IqpQq7t7zwWWrfjdn+8bdHaqf
	 CAzWZEIkkqbgIXESrlkf6uJ0sHiLj3JzGYxWim2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeLTJ2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732463AbeLTJ2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:28:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCDFD20989;
        Thu, 20 Dec 2018 09:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298099;
        bh=+RrqGmZz7aew2GY6efOMTn5wOYn9Ds9yHoIPVWVgHog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMyyvFEE1Xx/T2/Q6Wm3fWkB/eCkos3lgJP+Hc+ifI6DTgtbn2JTQuBnT/afxwPqD
         dg0dJP009BrXYLVCj2OOSKU3p/GnOZMUtW9rBUaOnohb0MFs7SanVlyV2MK2uypsOd
         zxpFl8NRYdHGBTdCfbdF6x1DWUeKpf1Vqmw9mTm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mitko Haralanov <mitko.haralanov@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 34/72] IB/hfi1: Remove race conditions in user_sdma send path
Date:   Thu, 20 Dec 2018 10:18:33 +0100
Message-Id: <20181220085923.683529406@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 28a9a9e83ceae2cee25b9af9ad20d53aaa9ab951 upstream

Packet queue state is over used to determine SDMA descriptor
availablitity and packet queue request state.

cpu 0  ret = user_sdma_send_pkts(req, pcount);
cpu 0  if (atomic_read(&pq->n_reqs))
cpu 1  IRQ user_sdma_txreq_cb calls pq_update() (state to _INACTIVE)
cpu 0        xchg(&pq->state, SDMA_PKT_Q_ACTIVE);

At this point pq->n_reqs == 0 and pq->state is incorrectly
SDMA_PKT_Q_ACTIVE.  The close path will hang waiting for the state
to return to _INACTIVE.

This can also change the state from _DEFERRED to _ACTIVE.  However,
this is a mostly benign race.

Remove the racy code path.

Use n_reqs to determine if a packet queue is active or not.

Cc: <stable@vger.kernel.org> # 4.14.0>
Reviewed-by: Mitko Haralanov <mitko.haralanov@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/user_sdma.c | 24 ++++++++++--------------
 drivers/infiniband/hw/hfi1/user_sdma.h |  9 +++++----
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index c14ec04f2a89..cbe5ab26d95b 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -187,7 +187,6 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 	pq->ctxt = uctxt->ctxt;
 	pq->subctxt = fd->subctxt;
 	pq->n_max_reqs = hfi1_sdma_comp_ring_size;
-	pq->state = SDMA_PKT_Q_INACTIVE;
 	atomic_set(&pq->n_reqs, 0);
 	init_waitqueue_head(&pq->wait);
 	atomic_set(&pq->n_locked, 0);
@@ -276,7 +275,7 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 		/* Wait until all requests have been freed. */
 		wait_event_interruptible(
 			pq->wait,
-			(ACCESS_ONCE(pq->state) == SDMA_PKT_Q_INACTIVE));
+			!atomic_read(&pq->n_reqs));
 		kfree(pq->reqs);
 		kfree(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
@@ -312,6 +311,13 @@ static u8 dlid_to_selector(u16 dlid)
 	return mapping[hash];
 }
 
+/**
+ * hfi1_user_sdma_process_request() - Process and start a user sdma request
+ * @fd: valid file descriptor
+ * @iovec: array of io vectors to process
+ * @dim: overall iovec array size
+ * @count: number of io vector array entries processed
+ */
 int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 				   struct iovec *iovec, unsigned long dim,
 				   unsigned long *count)
@@ -560,20 +566,12 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		req->ahg_idx = sdma_ahg_alloc(req->sde);
 
 	set_comp_state(pq, cq, info.comp_idx, QUEUED, 0);
+	pq->state = SDMA_PKT_Q_ACTIVE;
 	/* Send the first N packets in the request to buy us some time */
 	ret = user_sdma_send_pkts(req, pcount);
 	if (unlikely(ret < 0 && ret != -EBUSY))
 		goto free_req;
 
-	/*
-	 * It is possible that the SDMA engine would have processed all the
-	 * submitted packets by the time we get here. Therefore, only set
-	 * packet queue state to ACTIVE if there are still uncompleted
-	 * requests.
-	 */
-	if (atomic_read(&pq->n_reqs))
-		xchg(&pq->state, SDMA_PKT_Q_ACTIVE);
-
 	/*
 	 * This is a somewhat blocking send implementation.
 	 * The driver will block the caller until all packets of the
@@ -1391,10 +1389,8 @@ static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status)
 
 static inline void pq_update(struct hfi1_user_sdma_pkt_q *pq)
 {
-	if (atomic_dec_and_test(&pq->n_reqs)) {
-		xchg(&pq->state, SDMA_PKT_Q_INACTIVE);
+	if (atomic_dec_and_test(&pq->n_reqs))
 		wake_up(&pq->wait);
-	}
 }
 
 static void user_sdma_free_request(struct user_sdma_request *req, bool unpin)
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
index 5af52334b7dc..2b5326d6db53 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -94,9 +94,10 @@
 #define TXREQ_FLAGS_REQ_ACK   BIT(0)      /* Set the ACK bit in the header */
 #define TXREQ_FLAGS_REQ_DISABLE_SH BIT(1) /* Disable header suppression */
 
-#define SDMA_PKT_Q_INACTIVE BIT(0)
-#define SDMA_PKT_Q_ACTIVE   BIT(1)
-#define SDMA_PKT_Q_DEFERRED BIT(2)
+enum pkt_q_sdma_state {
+	SDMA_PKT_Q_ACTIVE,
+	SDMA_PKT_Q_DEFERRED,
+};
 
 /*
  * Maximum retry attempts to submit a TX request
@@ -124,7 +125,7 @@ struct hfi1_user_sdma_pkt_q {
 	struct user_sdma_request *reqs;
 	unsigned long *req_in_use;
 	struct iowait busy;
-	unsigned state;
+	enum pkt_q_sdma_state state;
 	wait_queue_head_t wait;
 	unsigned long unpinned;
 	struct mmu_rb_handler *handler;
-- 
2.19.1



