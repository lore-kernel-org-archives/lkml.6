Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F0FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBA1217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297897;
	bh=G5b1ayP4DqY4gNdUN0MrK1ob1Adeyj75jVxspDedqZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UbKQeM5U1mRrV9kuyIK2+1Q0GqEk3tvB4pAQNlUPfMljlbpStyCKJNYcb1NT8hpQo
	 kwGvZxKJ/IDj1LegIVwMmxChVXu9x0JVvvxNN6XOSvDLXwj937tDLaAYPACgQcLVDN
	 et1IB4db+bHWPyzDTxKuanHhxCnqPofqpozsDf3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbeLTJY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:24:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbeLTJYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:24:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2BCF20656;
        Thu, 20 Dec 2018 09:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297893;
        bh=G5b1ayP4DqY4gNdUN0MrK1ob1Adeyj75jVxspDedqZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y56jJZqEfgmvwFfS+HYB9p2tWcP0WCKqvJw+4/O/9qKlC49SFZMsNzfD9NHgFKYfQ
         6V8dpxAKJyuiis4+1+dE8/FlUIhWSudWVeyJHVDA0JOuglP5kTTqwsv570Nxm84ks1
         vP9ybu+IdXBsoRSxS8gVO0TJ7nWMamJqN+18LJzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mitko Haralanov <mitko.haralanov@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 19/61] IB/hfi1: Remove race conditions in user_sdma send path
Date:   Thu, 20 Dec 2018 10:18:19 +0100
Message-Id: <20181220085844.508001228@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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

Cc: <stable@vger.kernel.org> # 4.9.0
Reviewed-by: Mitko Haralanov <mitko.haralanov@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/user_sdma.c | 28 +++++++++-----------------
 drivers/infiniband/hw/hfi1/user_sdma.h |  7 ++++++-
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 619475c7d761..4c111162d552 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -151,10 +151,6 @@ MODULE_PARM_DESC(sdma_comp_size, "Size of User SDMA completion ring. Default: 12
 #define SDMA_REQ_HAVE_AHG   1
 #define SDMA_REQ_HAS_ERROR  2
 
-#define SDMA_PKT_Q_INACTIVE BIT(0)
-#define SDMA_PKT_Q_ACTIVE   BIT(1)
-#define SDMA_PKT_Q_DEFERRED BIT(2)
-
 /*
  * Maximum retry attempts to submit a TX request
  * before putting the process to sleep.
@@ -408,7 +404,6 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt, struct file *fp)
 	pq->ctxt = uctxt->ctxt;
 	pq->subctxt = fd->subctxt;
 	pq->n_max_reqs = hfi1_sdma_comp_ring_size;
-	pq->state = SDMA_PKT_Q_INACTIVE;
 	atomic_set(&pq->n_reqs, 0);
 	init_waitqueue_head(&pq->wait);
 	atomic_set(&pq->n_locked, 0);
@@ -491,7 +486,7 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd)
 		/* Wait until all requests have been freed. */
 		wait_event_interruptible(
 			pq->wait,
-			(ACCESS_ONCE(pq->state) == SDMA_PKT_Q_INACTIVE));
+			!atomic_read(&pq->n_reqs));
 		kfree(pq->reqs);
 		kfree(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
@@ -527,6 +522,13 @@ static u8 dlid_to_selector(u16 dlid)
 	return mapping[hash];
 }
 
+/**
+ * hfi1_user_sdma_process_request() - Process and start a user sdma request
+ * @fp: valid file pointer
+ * @iovec: array of io vectors to process
+ * @dim: overall iovec array size
+ * @count: number of io vector array entries processed
+ */
 int hfi1_user_sdma_process_request(struct file *fp, struct iovec *iovec,
 				   unsigned long dim, unsigned long *count)
 {
@@ -768,20 +770,12 @@ int hfi1_user_sdma_process_request(struct file *fp, struct iovec *iovec,
 	}
 
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
@@ -1526,10 +1520,8 @@ static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status)
 
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
index 39001714f551..09dd843a13de 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -53,6 +53,11 @@
 
 extern uint extended_psn;
 
+enum pkt_q_sdma_state {
+	SDMA_PKT_Q_ACTIVE,
+	SDMA_PKT_Q_DEFERRED,
+};
+
 struct hfi1_user_sdma_pkt_q {
 	struct list_head list;
 	unsigned ctxt;
@@ -65,7 +70,7 @@ struct hfi1_user_sdma_pkt_q {
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



