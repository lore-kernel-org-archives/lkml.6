Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939088AbeE1NK6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163763AbeE1KvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 227/496] qed: Free RoCE ILT Memory on rmmod qedr
Date: Mon, 28 May 2018 12:00:12 +0200
Message-Id: <20180528100329.471167715@linuxfoundation.org>
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

From: Michal Kalderon <Michal.Kalderon@cavium.com>

[ Upstream commit 9de506a547c0d172d13a91d69b1a399e6a2c0efa ]

Rdma requires ILT Memory to be allocated for it's QPs.
Each ILT entry points to a page used by several Rdma QPs.
To avoid allocating all the memory in advance, the rdma
implementation dynamically allocates memory as more QPs are
added, however it does not dynamically free the memory.
The memory should have been freed on rmmod qedr, but isn't.
This patch adds the memory freeing on rmmod qedr (currently
it will be freed with qed is removed).

An outcome of this bug, is that if qedr is unloaded and loaded
without unloaded qed, there will be no more RoCE traffic.

The reason these are related, is that the logic of detecting the
first QP ever opened is by asking whether ILT memory for RoCE has
been allocated.

In addition, this patch modifies freeing of the Task context to
always use the PROTOCOLID_ROCE and not the protocol passed,
this is because task context for iWARP and ROCE both use the
ROCE protocol id, as opposed to the connection context.

Fixes: dbb799c39717 ("qed: Initialize hardware for new protocols")
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c  |    5 ++++-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -2471,7 +2471,10 @@ int qed_cxt_free_proto_ilt(struct qed_hw
 	if (rc)
 		return rc;
 
-	/* Free Task CXT */
+	/* Free Task CXT ( Intentionally RoCE as task-id is shared between
+	 * RoCE and iWARP )
+	 */
+	proto = PROTOCOLID_ROCE;
 	rc = qed_cxt_free_ilt_range(p_hwfn, QED_ELEM_TASK, 0,
 				    qed_cxt_get_proto_tid_count(p_hwfn, proto));
 	if (rc)
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -360,6 +360,7 @@ static void qed_rdma_free(struct qed_hwf
 	DP_VERBOSE(p_hwfn, QED_MSG_RDMA, "Freeing RDMA\n");
 
 	qed_rdma_resc_free(p_hwfn);
+	qed_cxt_free_proto_ilt(p_hwfn, p_hwfn->p_rdma_info->proto);
 }
 
 static void qed_rdma_get_guid(struct qed_hwfn *p_hwfn, u8 *guid)
