Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBD9C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6DD20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6DD20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeLIWFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:05:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36924 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbeLIWFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:05:19 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW737-0002ic-SB; Sun, 09 Dec 2018 21:55:42 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003Tn-Ps; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Doug Ledford" <dledford@redhat.com>,
        "Steve Wise" <swise@opengridcomputing.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.365120982@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 193/328] iw_cxgb4: atomically flush the qp
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

commit bc52e9ca74b9a395897bb640c6671b2cbf716032 upstream.

__flush_qp() has a race condition where during the flush operation,
the qp lock is released allowing another thread to possibly post a WR,
which corrupts the queue state, possibly causing crashes.  The lock was
released to preserve the cq/qp locking hierarchy of cq first, then qp.
However releasing the qp lock is not necessary; both RQ and SQ CQ locks
can be acquired first, followed by the qp lock, and then the RQ and SQ
flushing can be done w/o unlocking.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/cxgb4/qp.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1071,31 +1071,34 @@ static void __flush_qp(struct c4iw_qp *q
 
 	PDBG("%s qhp %p rchp %p schp %p\n", __func__, qhp, rchp, schp);
 
-	/* locking hierarchy: cq lock first, then qp lock. */
+	/* locking hierarchy: cqs lock first, then qp lock. */
 	spin_lock_irqsave(&rchp->lock, flag);
+	if (schp != rchp)
+		spin_lock(&schp->lock);
 	spin_lock(&qhp->lock);
 
 	if (qhp->wq.flushed) {
 		spin_unlock(&qhp->lock);
+		if (schp != rchp)
+			spin_unlock(&schp->lock);
 		spin_unlock_irqrestore(&rchp->lock, flag);
 		return;
 	}
 	qhp->wq.flushed = 1;
+	t4_set_wq_in_error(&qhp->wq);
 
 	c4iw_flush_hw_cq(rchp, qhp);
 	c4iw_count_rcqes(&rchp->cq, &qhp->wq, &count);
 	rq_flushed = c4iw_flush_rq(&qhp->wq, &rchp->cq, count);
-	spin_unlock(&qhp->lock);
-	spin_unlock_irqrestore(&rchp->lock, flag);
 
-	/* locking hierarchy: cq lock first, then qp lock. */
-	spin_lock_irqsave(&schp->lock, flag);
-	spin_lock(&qhp->lock);
 	if (schp != rchp)
 		c4iw_flush_hw_cq(schp, qhp);
 	sq_flushed = c4iw_flush_sq(qhp);
+
 	spin_unlock(&qhp->lock);
-	spin_unlock_irqrestore(&schp->lock, flag);
+	if (schp != rchp)
+		spin_unlock(&schp->lock);
+	spin_unlock_irqrestore(&rchp->lock, flag);
 
 	if (schp == rchp) {
 		if (t4_clear_cq_armed(&rchp->cq) &&
@@ -1129,8 +1132,8 @@ static void flush_qp(struct c4iw_qp *qhp
 	rchp = to_c4iw_cq(qhp->ibqp.recv_cq);
 	schp = to_c4iw_cq(qhp->ibqp.send_cq);
 
-	t4_set_wq_in_error(&qhp->wq);
 	if (qhp->ibqp.uobject) {
+		t4_set_wq_in_error(&qhp->wq);
 		t4_set_cq_in_error(&rchp->cq);
 		spin_lock_irqsave(&rchp->comp_handler_lock, flag);
 		(*rchp->ibcq.comp_handler)(&rchp->ibcq, rchp->ibcq.cq_context);

