Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeCVQ1V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:27:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33784 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeCVQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:27:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8331760F6C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers on weakly-ordered archs #2
Date: Thu, 22 Mar 2018 12:26:49 -0400
Message-Id: <1521736009-23387-4-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521736009-23387-1-git-send-email-okaya@codeaurora.org>
References: <1521736009-23387-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code includes wmb() followed by writel() in multiple places. writel()
already has a barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/infiniband/hw/qedr/verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 53f00db..d6bd950 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -860,7 +860,7 @@ static void doorbell_cq(struct qedr_cq *cq, u32 cons, u8 flags)
 	wmb();
 	cq->db.data.agg_flags = flags;
 	cq->db.data.value = cpu_to_le32(cons);
-	writeq(cq->db.raw, cq->db_addr);
+	writeq_relaxed(cq->db.raw, cq->db_addr);
 
 	/* Make sure write would stick */
 	mmiowb();
@@ -3338,7 +3338,7 @@ int qedr_post_recv(struct ib_qp *ibqp, struct ib_recv_wr *wr,
 
 		qp->rq.db_data.data.value++;
 
-		writel(qp->rq.db_data.raw, qp->rq.db);
+		writel_relaxed(qp->rq.db_data.raw, qp->rq.db);
 
 		/* Make sure write sticks */
 		mmiowb();
-- 
2.7.4
