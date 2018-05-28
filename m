Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163761AbeE1NMx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163771AbeE1KvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 221/496] RDMA/qedr: Fix iWARP write and send with immediate
Date: Mon, 28 May 2018 12:00:06 +0200
Message-Id: <20180528100329.225072501@linuxfoundation.org>
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

[ Upstream commit 551e1c67b4207455375a2e7a285dea1c7e8fc361 ]

iWARP does not support RDMA WRITE or SEND with immediate data.
Driver should check this before submitting to FW and return an
immediate error

Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/qedr/verbs.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2832,6 +2832,11 @@ static int __qedr_post_send(struct ib_qp
 
 	switch (wr->opcode) {
 	case IB_WR_SEND_WITH_IMM:
+		if (unlikely(rdma_protocol_iwarp(&dev->ibdev, 1))) {
+			rc = -EINVAL;
+			*bad_wr = wr;
+			break;
+		}
 		wqe->req_type = RDMA_SQ_REQ_TYPE_SEND_WITH_IMM;
 		swqe = (struct rdma_sq_send_wqe_1st *)wqe;
 		swqe->wqe_size = 2;
@@ -2873,6 +2878,11 @@ static int __qedr_post_send(struct ib_qp
 		break;
 
 	case IB_WR_RDMA_WRITE_WITH_IMM:
+		if (unlikely(rdma_protocol_iwarp(&dev->ibdev, 1))) {
+			rc = -EINVAL;
+			*bad_wr = wr;
+			break;
+		}
 		wqe->req_type = RDMA_SQ_REQ_TYPE_RDMA_WR_WITH_IMM;
 		rwqe = (struct rdma_sq_rdma_wqe_1st *)wqe;
 
