Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164317AbeE1M7v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164204AbeE1Kxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 278/496] RDMA/qedr: Fix QP state initialization race
Date: Mon, 28 May 2018 12:01:03 +0200
Message-Id: <20180528100331.566934911@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Kalderon, Michal" <Michal.Kalderon@cavium.com>

[ Upstream commit caf61b1b8b88ccf1451f7321a176393797e8d292 ]

Once the FW is transitioned to error, FLUSH cqes can be received.
We want the driver to be aware of the fact that QP is already in error.

Without this fix, a user may see false error messages in the dmesg log,
mentioning that a FLUSH cqe was received while QP is not in error state.

Fixes: cecbcddf ("qedr: Add support for QP verbs")
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/qedr/verbs.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1663,14 +1663,15 @@ static void qedr_reset_qp_hwq_info(struc
 
 static int qedr_update_qp_state(struct qedr_dev *dev,
 				struct qedr_qp *qp,
+				enum qed_roce_qp_state cur_state,
 				enum qed_roce_qp_state new_state)
 {
 	int status = 0;
 
-	if (new_state == qp->state)
+	if (new_state == cur_state)
 		return 0;
 
-	switch (qp->state) {
+	switch (cur_state) {
 	case QED_ROCE_QP_STATE_RESET:
 		switch (new_state) {
 		case QED_ROCE_QP_STATE_INIT:
@@ -1774,6 +1775,7 @@ int qedr_modify_qp(struct ib_qp *ibqp, s
 	struct qedr_dev *dev = get_qedr_dev(&qp->dev->ibdev);
 	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
 	enum ib_qp_state old_qp_state, new_qp_state;
+	enum qed_roce_qp_state cur_state;
 	int rc = 0;
 
 	DP_DEBUG(dev, QEDR_MSG_QP,
@@ -1992,13 +1994,25 @@ int qedr_modify_qp(struct ib_qp *ibqp, s
 		qp->dest_qp_num = attr->dest_qp_num;
 	}
 
+	cur_state = qp->state;
+
+	/* Update the QP state before the actual ramrod to prevent a race with
+	 * fast path. Modifying the QP state to error will cause the device to
+	 * flush the CQEs and while polling the flushed CQEs will considered as
+	 * a potential issue if the QP isn't in error state.
+	 */
+	if ((attr_mask & IB_QP_STATE) && qp->qp_type != IB_QPT_GSI &&
+	    !udata && qp_params.new_state == QED_ROCE_QP_STATE_ERR)
+		qp->state = QED_ROCE_QP_STATE_ERR;
+
 	if (qp->qp_type != IB_QPT_GSI)
 		rc = dev->ops->rdma_modify_qp(dev->rdma_ctx,
 					      qp->qed_qp, &qp_params);
 
 	if (attr_mask & IB_QP_STATE) {
 		if ((qp->qp_type != IB_QPT_GSI) && (!udata))
-			rc = qedr_update_qp_state(dev, qp, qp_params.new_state);
+			rc = qedr_update_qp_state(dev, qp, cur_state,
+						  qp_params.new_state);
 		qp->state = qp_params.new_state;
 	}
 
