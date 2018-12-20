Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B581C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2161120989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298474;
	bh=G3fCGwj6TeHq12lcpz/ufwmBr5A/U6Ao9630AG2/Ypw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vaeFRrusTzrk2kImzF2KGIpCJCbvnqJlVYFjKhQR3v2Drx9k99srLQZra4J1eomMR
	 YozRCyoDr0Nce+mOc/fzCCu7GJvetzpDrFWM/8DTqLqWMv3znTeq5X1NwdMVeQpiZ4
	 Ll2bwjI6Dz/lJoWfvp62ndE6Cj4w/z7ILUmI+5I0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbeLTJed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:34:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731832AbeLTJ3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE02120989;
        Thu, 20 Dec 2018 09:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298160;
        bh=G3fCGwj6TeHq12lcpz/ufwmBr5A/U6Ao9630AG2/Ypw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pL6TZUHp6D4bNDEpQBIBV+71Ri5PzKydvs7vSdSCutgPwI0cgod4E/LOche3Plt7A
         8k5PoxNT1jKk0B2EthpKOzTWJ3uUzXo3EJGO5PeQdl7Y2W2lATrrjYW6wLSsn47BZG
         +lBdsrfcqjlYvuDN1gYZfNrgWTybXUYstfkcofhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mitko Haralanov <mitko.haralanov@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 03/67] IB/hfi1: Remove race conditions in user_sdma send path
Date:   Thu, 20 Dec 2018 10:18:15 +0100
Message-Id: <20181220085903.702233696@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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

Cc: <stable@vger.kernel.org> # 4.19.x
Reviewed-by: Mitko Haralanov <mitko.haralanov@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/user_sdma.c | 24 ++++++++++--------------
 drivers/infiniband/hw/hfi1/user_sdma.h |  9 +++++----
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 39134dd305f5..51831bfbf90f 100644
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
-			(READ_ONCE(pq->state) == SDMA_PKT_Q_INACTIVE));
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
@@ -1409,10 +1407,8 @@ static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status)
 
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
index 0ae06456c868..91c343f91776 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -105,9 +105,10 @@ static inline int ahg_header_set(u32 *arr, int idx, size_t array_size,
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
@@ -133,7 +134,7 @@ struct hfi1_user_sdma_pkt_q {
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



