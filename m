Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B808AC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E6B20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E6B20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeLIWP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:15:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38190 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727187AbeLIWP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:15:26 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002io-7C; Sun, 09 Dec 2018 21:55:42 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003Ti-OE; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Roland Dreier" <roland@purestorage.com>,
        "Steve Wise" <swise@opengridcomputing.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.449281016@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 192/328] RDMA/cxgb4: Only call CQ completion handler
 if it is armed
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Steve Wise <swise@opengridcomputing.com>

commit 678ea9b5baab6800692b249bdba77c3c07261d61 upstream.

The function __flush_qp() always calls the ULP's CQ completion handler
functions even if the CQ was not armed.  This can crash the system if
the function pointer is NULL. The iSER ULP behaves this way: no
completion handler and never arm the CQ for notification.  So now we
track whether the CQ is armed at flush time and only call the
completion handlers if their CQs were armed.

Also, if the RCQ and SCQ are the same CQ, the completion handler is
getting called twice.  It should only be called once after all SQ and
RQ WRs are flushed from the QP.  So rearrange the logic to fix this.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Roland Dreier <roland@purestorage.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/cxgb4/ev.c |  1 +
 drivers/infiniband/hw/cxgb4/qp.c | 37 +++++++++++++++++++++-----------
 drivers/infiniband/hw/cxgb4/t4.h | 11 ++++++++++
 3 files changed, 37 insertions(+), 12 deletions(-)

--- a/drivers/infiniband/hw/cxgb4/ev.c
+++ b/drivers/infiniband/hw/cxgb4/ev.c
@@ -182,6 +182,7 @@ int c4iw_ev_handler(struct c4iw_dev *dev
 
 	chp = get_chp(dev, qid);
 	if (chp) {
+		t4_clear_cq_armed(&chp->cq);
 		spin_lock_irqsave(&chp->comp_handler_lock, flag);
 		(*chp->ibcq.comp_handler)(&chp->ibcq, chp->ibcq.cq_context);
 		spin_unlock_irqrestore(&chp->comp_handler_lock, flag);
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1066,7 +1066,7 @@ static void __flush_qp(struct c4iw_qp *q
 		       struct c4iw_cq *schp)
 {
 	int count;
-	int flushed;
+	int rq_flushed, sq_flushed;
 	unsigned long flag;
 
 	PDBG("%s qhp %p rchp %p schp %p\n", __func__, qhp, rchp, schp);
@@ -1084,27 +1084,40 @@ static void __flush_qp(struct c4iw_qp *q
 
 	c4iw_flush_hw_cq(rchp, qhp);
 	c4iw_count_rcqes(&rchp->cq, &qhp->wq, &count);
-	flushed = c4iw_flush_rq(&qhp->wq, &rchp->cq, count);
+	rq_flushed = c4iw_flush_rq(&qhp->wq, &rchp->cq, count);
 	spin_unlock(&qhp->lock);
 	spin_unlock_irqrestore(&rchp->lock, flag);
-	if (flushed) {
-		spin_lock_irqsave(&rchp->comp_handler_lock, flag);
-		(*rchp->ibcq.comp_handler)(&rchp->ibcq, rchp->ibcq.cq_context);
-		spin_unlock_irqrestore(&rchp->comp_handler_lock, flag);
-	}
 
 	/* locking hierarchy: cq lock first, then qp lock. */
 	spin_lock_irqsave(&schp->lock, flag);
 	spin_lock(&qhp->lock);
 	if (schp != rchp)
 		c4iw_flush_hw_cq(schp, qhp);
-	flushed = c4iw_flush_sq(qhp);
+	sq_flushed = c4iw_flush_sq(qhp);
 	spin_unlock(&qhp->lock);
 	spin_unlock_irqrestore(&schp->lock, flag);
-	if (flushed) {
-		spin_lock_irqsave(&schp->comp_handler_lock, flag);
-		(*schp->ibcq.comp_handler)(&schp->ibcq, schp->ibcq.cq_context);
-		spin_unlock_irqrestore(&schp->comp_handler_lock, flag);
+
+	if (schp == rchp) {
+		if (t4_clear_cq_armed(&rchp->cq) &&
+		    (rq_flushed || sq_flushed)) {
+			spin_lock_irqsave(&rchp->comp_handler_lock, flag);
+			(*rchp->ibcq.comp_handler)(&rchp->ibcq,
+						   rchp->ibcq.cq_context);
+			spin_unlock_irqrestore(&rchp->comp_handler_lock, flag);
+		}
+	} else {
+		if (t4_clear_cq_armed(&rchp->cq) && rq_flushed) {
+			spin_lock_irqsave(&rchp->comp_handler_lock, flag);
+			(*rchp->ibcq.comp_handler)(&rchp->ibcq,
+						   rchp->ibcq.cq_context);
+			spin_unlock_irqrestore(&rchp->comp_handler_lock, flag);
+		}
+		if (t4_clear_cq_armed(&schp->cq) && sq_flushed) {
+			spin_lock_irqsave(&schp->comp_handler_lock, flag);
+			(*schp->ibcq.comp_handler)(&schp->ibcq,
+						   schp->ibcq.cq_context);
+			spin_unlock_irqrestore(&schp->comp_handler_lock, flag);
+		}
 	}
 }
 
--- a/drivers/infiniband/hw/cxgb4/t4.h
+++ b/drivers/infiniband/hw/cxgb4/t4.h
@@ -531,6 +531,10 @@ static inline int t4_wq_db_enabled(struc
 	return !wq->rq.queue[wq->rq.size].status.db_off;
 }
 
+enum t4_cq_flags {
+	CQ_ARMED	= 1,
+};
+
 struct t4_cq {
 	struct t4_cqe *queue;
 	dma_addr_t dma_addr;
@@ -551,12 +555,19 @@ struct t4_cq {
 	u16 cidx_inc;
 	u8 gen;
 	u8 error;
+	unsigned long flags;
 };
 
+static inline int t4_clear_cq_armed(struct t4_cq *cq)
+{
+	return test_and_clear_bit(CQ_ARMED, &cq->flags);
+}
+
 static inline int t4_arm_cq(struct t4_cq *cq, int se)
 {
 	u32 val;
 
+	set_bit(CQ_ARMED, &cq->flags);
 	while (cq->cidx_inc > CIDXINC_MASK) {
 		val = SEINTARM(0) | CIDXINC(CIDXINC_MASK) | TIMERREG(7) |
 		      INGRESSQID(cq->cqid);

