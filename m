Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163524AbeE1Kt1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163126AbeE1KtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Devesh Sharma <devesh.sharma@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 183/496] RDMA/bnxt_re: Unconditionly fence non wire memory operations
Date: Mon, 28 May 2018 11:59:28 +0200
Message-Id: <20180528100327.671046031@linuxfoundation.org>
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

From: Devesh Sharma <devesh.sharma@broadcom.com>

[ Upstream commit a45bc17b360d75fac9ced85e99fda14bf38b4dc3 ]

HW requires an unconditonal fence for all non-wire memory operations
through SQ. This guarantees the completions of these memory operations.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1963,10 +1963,13 @@ static int bnxt_re_build_inv_wqe(struct
 	wqe->type = BNXT_QPLIB_SWQE_TYPE_LOCAL_INV;
 	wqe->local_inv.inv_l_key = wr->ex.invalidate_rkey;
 
+	/* Need unconditional fence for local invalidate
+	 * opcode to work as expected.
+	 */
+	wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_UC_FENCE;
+
 	if (wr->send_flags & IB_SEND_SIGNALED)
 		wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_SIGNAL_COMP;
-	if (wr->send_flags & IB_SEND_FENCE)
-		wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_UC_FENCE;
 	if (wr->send_flags & IB_SEND_SOLICITED)
 		wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_SOLICIT_EVENT;
 
@@ -1987,8 +1990,12 @@ static int bnxt_re_build_reg_wqe(struct
 	wqe->frmr.levels = qplib_frpl->hwq.level + 1;
 	wqe->type = BNXT_QPLIB_SWQE_TYPE_REG_MR;
 
-	if (wr->wr.send_flags & IB_SEND_FENCE)
-		wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_UC_FENCE;
+	/* Need unconditional fence for reg_mr
+	 * opcode to function as expected.
+	 */
+
+	wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_UC_FENCE;
+
 	if (wr->wr.send_flags & IB_SEND_SIGNALED)
 		wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_SIGNAL_COMP;
 
