Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933403AbeCNDUm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 23:20:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43230 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933384AbeCNDUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 23:20:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89BC66081A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] RDMA/qedr: eliminate duplicate barriers on weakly-ordered archs
Date: Tue, 13 Mar 2018 23:20:24 -0400
Message-Id: <1520997629-17361-3-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
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
index 53f00db..ccd55f4 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1870,7 +1870,7 @@ static int qedr_update_qp_state(struct qedr_dev *dev,
 
 			if (rdma_protocol_roce(&dev->ibdev, 1)) {
 				wmb();
-				writel(qp->rq.db_data.raw, qp->rq.db);
+				writel_relaxed(qp->rq.db_data.raw, qp->rq.db);
 				/* Make sure write takes effect */
 				mmiowb();
 			}
@@ -3247,7 +3247,7 @@ int qedr_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 	 * redundant doorbell.
 	 */
 	wmb();
-	writel(qp->sq.db_data.raw, qp->sq.db);
+	writel_relaxed(qp->sq.db_data.raw, qp->sq.db);
 
 	/* Make sure write sticks */
 	mmiowb();
-- 
2.7.4
