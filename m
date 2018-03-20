Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeCTCtl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:49:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56062 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbeCTCsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:48:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00F3A60FA9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers on weakly-ordered archs
Date: Mon, 19 Mar 2018 22:47:46 -0400
Message-Id: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code includes wmb() followed by writel(). writel() already has a barrier on
some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/infiniband/hw/cxgb4/t4.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/t4.h b/drivers/infiniband/hw/cxgb4/t4.h
index 8369c7c..6e5658a 100644
--- a/drivers/infiniband/hw/cxgb4/t4.h
+++ b/drivers/infiniband/hw/cxgb4/t4.h
@@ -457,7 +457,7 @@ static inline void pio_copy(u64 __iomem *dst, u64 *src)
 	int count = 8;
 
 	while (count) {
-		writeq(*src, dst);
+		writeq_relaxed(*src, dst);
 		src++;
 		dst++;
 		count--;
@@ -477,15 +477,15 @@ static inline void t4_ring_sq_db(struct t4_wq *wq, u16 inc, union t4_wr *wqe)
 				 (u64 *)wqe);
 		} else {
 			pr_debug("DB wq->sq.pidx = %d\n", wq->sq.pidx);
-			writel(PIDX_T5_V(inc) | QID_V(wq->sq.bar2_qid),
-			       wq->sq.bar2_va + SGE_UDB_KDOORBELL);
+			writel_relaxed(PIDX_T5_V(inc) | QID_V(wq->sq.bar2_qid),
+				       wq->sq.bar2_va + SGE_UDB_KDOORBELL);
 		}
 
 		/* Flush user doorbell area writes. */
 		wmb();
 		return;
 	}
-	writel(QID_V(wq->sq.qid) | PIDX_V(inc), wq->db);
+	writel_relaxed(QID_V(wq->sq.qid) | PIDX_V(inc), wq->db);
 }
 
 static inline void t4_ring_rq_db(struct t4_wq *wq, u16 inc,
@@ -502,15 +502,15 @@ static inline void t4_ring_rq_db(struct t4_wq *wq, u16 inc,
 				 (void *)wqe);
 		} else {
 			pr_debug("DB wq->rq.pidx = %d\n", wq->rq.pidx);
-			writel(PIDX_T5_V(inc) | QID_V(wq->rq.bar2_qid),
-			       wq->rq.bar2_va + SGE_UDB_KDOORBELL);
+			writel_relaxed(PIDX_T5_V(inc) | QID_V(wq->rq.bar2_qid),
+				       wq->rq.bar2_va + SGE_UDB_KDOORBELL);
 		}
 
 		/* Flush user doorbell area writes. */
 		wmb();
 		return;
 	}
-	writel(QID_V(wq->rq.qid) | PIDX_V(inc), wq->db);
+	writel_relaxed(QID_V(wq->rq.qid) | PIDX_V(inc), wq->db);
 }
 
 static inline int t4_wq_in_error(struct t4_wq *wq)
-- 
2.7.4
