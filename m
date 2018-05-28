Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162117AbeE1Kfq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162072AbeE1Kfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:35:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 210/329] RDMA/qedr: fix QPs ack timeout configuration
Date: Mon, 28 May 2018 12:02:19 +0200
Message-Id: <20180528100259.687794860@linuxfoundation.org>
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

[ Upstream commit c3594f22302cca5e924e47ec1cc8edd265708f41 ]

QPs that were configured with ack timeout value lower than 1
msec will not implement re-transmission timeout.
This means that if a packet / ACK were dropped, the QP
will not retransmit this packet.

This can lead to an application hang.

Fixes: cecbcddf6 ("qedr: Add support for QP verbs")
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/qedr/verbs.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1888,18 +1888,23 @@ int qedr_modify_qp(struct ib_qp *ibqp, s
 		SET_FIELD(qp_params.modify_flags,
 			  QED_ROCE_MODIFY_QP_VALID_ACK_TIMEOUT, 1);
 
-		qp_params.ack_timeout = attr->timeout;
-		if (attr->timeout) {
-			u32 temp;
-
-			temp = 4096 * (1UL << attr->timeout) / 1000 / 1000;
-			/* FW requires [msec] */
-			qp_params.ack_timeout = temp;
-		} else {
-			/* Infinite */
+		/* The received timeout value is an exponent used like this:
+		 *    "12.7.34 LOCAL ACK TIMEOUT
+		 *    Value representing the transport (ACK) timeout for use by
+		 *    the remote, expressed as: 4.096 * 2^timeout [usec]"
+		 * The FW expects timeout in msec so we need to divide the usec
+		 * result by 1000. We'll approximate 1000~2^10, and 4.096 ~ 2^2,
+		 * so we get: 2^2 * 2^timeout / 2^10 = 2^(timeout - 8).
+		 * The value of zero means infinite so we use a 'max_t' to make
+		 * sure that sub 1 msec values will be configured as 1 msec.
+		 */
+		if (attr->timeout)
+			qp_params.ack_timeout =
+					1 << max_t(int, attr->timeout - 8, 0);
+		else
 			qp_params.ack_timeout = 0;
-		}
 	}
+
 	if (attr_mask & IB_QP_RETRY_CNT) {
 		SET_FIELD(qp_params.modify_flags,
 			  QED_ROCE_MODIFY_QP_VALID_RETRY_CNT, 1);
