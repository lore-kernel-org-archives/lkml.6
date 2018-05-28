Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161595AbeE1Keg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161880AbeE1Ke0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:34:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amit Radzi <Amit.Radzi@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 181/329] RDMA/qedr: Fix kernel panic when running fio over NFSoRDMA
Date: Mon, 28 May 2018 12:01:50 +0200
Message-Id: <20180528100257.401086388@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Kalderon, Michal" <Michal.Kalderon@cavium.com>

[ Upstream commit e3fd112cbf21d049faf64ba1471d72b93c22109a ]

Race in qedr_poll_cq, lastest_cqe wasn't protected by lock,
leading to a case where two context's accessing poll_cq at
the same time lead to one of them having a pointer to an old
latest_cqe and reading an invalid cqe element

Signed-off-by: Amit Radzi <Amit.Radzi@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/qedr/verbs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -3467,7 +3467,7 @@ int qedr_poll_cq(struct ib_cq *ibcq, int
 {
 	struct qedr_dev *dev = get_qedr_dev(ibcq->device);
 	struct qedr_cq *cq = get_qedr_cq(ibcq);
-	union rdma_cqe *cqe = cq->latest_cqe;
+	union rdma_cqe *cqe;
 	u32 old_cons, new_cons;
 	unsigned long flags;
 	int update = 0;
@@ -3477,6 +3477,7 @@ int qedr_poll_cq(struct ib_cq *ibcq, int
 		return qedr_gsi_poll_cq(ibcq, num_entries, wc);
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
+	cqe = cq->latest_cqe;
 	old_cons = qed_chain_get_cons_idx_u32(&cq->pbl);
 	while (num_entries && is_valid_cqe(cq, cqe)) {
 		struct qedr_qp *qp;
