Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4934C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829BE20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829BE20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeJNXNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:13:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36406 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728261AbeJNXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:07 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLu-0004cS-5v; Sun, 14 Oct 2018 16:30:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000UM-Fi; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steve Wise" <swise@opengridcomputing.com>,
        "Bharat Potnuri" <bharat@chelsio.com>,
        "Doug Ledford" <dledford@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.730857965@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 242/366] iw_cxgb4: Atomically flush per QP HW CQEs
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bharat Potnuri <bharat@chelsio.com>

commit 2df19e19ae90d94fd8724083f161f368a2797537 upstream.

When a CQ is shared by multiple QPs, c4iw_flush_hw_cq() needs to acquire
corresponding QP lock before moving the CQEs into its corresponding SW
queue and accessing the SQ contents for completing a WR.
Ignore CQEs if corresponding QP is already flushed.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/cxgb4/cq.c       | 11 ++++++++++-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  2 +-
 drivers/infiniband/hw/cxgb4/qp.c       |  4 ++--
 3 files changed, 13 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -331,7 +331,7 @@ static void advance_oldest_read(struct t
  * Deal with out-of-order and/or completions that complete
  * prior unsignalled WRs.
  */
-void c4iw_flush_hw_cq(struct c4iw_cq *chp)
+void c4iw_flush_hw_cq(struct c4iw_cq *chp, struct c4iw_qp *flush_qhp)
 {
 	struct t4_cqe *hw_cqe, *swcqe, read_cqe;
 	struct c4iw_qp *qhp;
@@ -355,6 +355,13 @@ void c4iw_flush_hw_cq(struct c4iw_cq *ch
 		if (qhp == NULL)
 			goto next_cqe;
 
+		if (flush_qhp != qhp) {
+			spin_lock(&qhp->lock);
+
+			if (qhp->wq.flushed == 1)
+				goto next_cqe;
+		}
+
 		if (CQE_OPCODE(hw_cqe) == FW_RI_TERMINATE)
 			goto next_cqe;
 
@@ -406,6 +413,8 @@ void c4iw_flush_hw_cq(struct c4iw_cq *ch
 next_cqe:
 		t4_hwcq_consume(&chp->cq);
 		ret = t4_next_hw_cqe(&chp->cq, &hw_cqe);
+		if (qhp && flush_qhp != qhp)
+			spin_unlock(&qhp->lock);
 	}
 }
 
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -977,7 +977,7 @@ void c4iw_pblpool_free(struct c4iw_rdev
 u32 c4iw_ocqp_pool_alloc(struct c4iw_rdev *rdev, int size);
 void c4iw_ocqp_pool_free(struct c4iw_rdev *rdev, u32 addr, int size);
 int c4iw_ofld_send(struct c4iw_rdev *rdev, struct sk_buff *skb);
-void c4iw_flush_hw_cq(struct c4iw_cq *chp);
+void c4iw_flush_hw_cq(struct c4iw_cq *chp, struct c4iw_qp *flush_qhp);
 void c4iw_count_rcqes(struct t4_cq *cq, struct t4_wq *wq, int *count);
 int c4iw_ep_disconnect(struct c4iw_ep *ep, int abrupt, gfp_t gfp);
 int c4iw_flush_rq(struct t4_wq *wq, struct t4_cq *cq, int count);
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1082,7 +1082,7 @@ static void __flush_qp(struct c4iw_qp *q
 	}
 	qhp->wq.flushed = 1;
 
-	c4iw_flush_hw_cq(rchp);
+	c4iw_flush_hw_cq(rchp, qhp);
 	c4iw_count_rcqes(&rchp->cq, &qhp->wq, &count);
 	flushed = c4iw_flush_rq(&qhp->wq, &rchp->cq, count);
 	spin_unlock(&qhp->lock);
@@ -1097,7 +1097,7 @@ static void __flush_qp(struct c4iw_qp *q
 	spin_lock_irqsave(&schp->lock, flag);
 	spin_lock(&qhp->lock);
 	if (schp != rchp)
-		c4iw_flush_hw_cq(schp);
+		c4iw_flush_hw_cq(schp, qhp);
 	flushed = c4iw_flush_sq(qhp);
 	spin_unlock(&qhp->lock);
 	spin_unlock_irqrestore(&schp->lock, flag);

