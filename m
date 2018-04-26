Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeDZDwX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 23:52:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeDZDwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 23:52:21 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: monis@mellanox.com, dledford@redhat.com, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/rxe: add RXE_START_MASK for rxe_opcode IB_OPCODE_RC_SEND_ONLY_INV
Date: Thu, 26 Apr 2018 11:52:39 +0800
Message-Id: <1524714759-14654-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=625
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260037
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

w/o RXE_START_MASK, the last_psn of IB_OPCODE_RC_SEND_ONLY_INV
will not be updated in update_wqe_psn, and the corresponding
wqe will not be acked in rxe_completer due to its last_psn is
zero. Finally, the other wqe will also not be able to be acked,
because the wqe of IB_OPCODE_RC_SEND_ONLY_INV with last_psn 0
is still there. This causes large amount of io timeout when
nvmeof is over rxe.

Add RXE_START_MASK for IB_OPCODE_RC_SEND_ONLY_INV to fix this.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 61927c1..4cf1106 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -390,7 +390,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_RC_SEND_ONLY_INV",
 		.mask	= RXE_IETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK
 				| RXE_COMP_MASK | RXE_RWR_MASK | RXE_SEND_MASK
-				| RXE_END_MASK,
+				| RXE_END_MASK  | RXE_START_MASK,
 		.length = RXE_BTH_BYTES + RXE_IETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
-- 
2.7.4
