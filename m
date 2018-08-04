Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A25C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F1A208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F1A208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbeHDLDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:03:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeHDLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:03:33 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 078F3BC6;
        Sat,  4 Aug 2018 09:03:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.17 26/31] RDMA/uverbs: Expand primary and alt AV port checks
Date:   Sat,  4 Aug 2018 11:01:01 +0200
Message-Id: <20180804082634.130902560@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082632.304529527@linuxfoundation.org>
References: <20180804082632.304529527@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

commit addb8a6559f0f8b5a37582b7ca698358445a55bf upstream.

The commit cited below checked that the port numbers provided in the
primary and alt AVs are legal.

That is sufficient to prevent a kernel panic. However, it is not
sufficient for correct operation.

In Linux, AVs (both primary and alt) must be completely self-described.
We do not accept an AV from userspace without an embedded port number.
(This has been the case since kernel 3.14 commit dbf727de7440
("IB/core: Use GID table in AH creation and dmac resolution")).

For the primary AV, this embedded port number must match the port number
specified with IB_QP_PORT.

We also expect the port number embedded in the alt AV to match the
alt_port_num value passed by the userspace driver in the modify_qp command
base structure.

Add these checks to modify_qp.

Cc: <stable@vger.kernel.org> # 4.16
Fixes: 5d4c05c3ee36 ("RDMA/uverbs: Sanitize user entered port numbers prior to access it")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/uverbs_cmd.c |   59 ++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1984,15 +1984,64 @@ static int modify_qp(struct ib_uverbs_fi
 		goto release_qp;
 	}
 
-	if ((cmd->base.attr_mask & IB_QP_AV) &&
-	    !rdma_is_port_valid(qp->device, cmd->base.dest.port_num)) {
-		ret = -EINVAL;
-		goto release_qp;
+	if ((cmd->base.attr_mask & IB_QP_AV)) {
+		if (!rdma_is_port_valid(qp->device, cmd->base.dest.port_num)) {
+			ret = -EINVAL;
+			goto release_qp;
+		}
+
+		if (cmd->base.attr_mask & IB_QP_STATE &&
+		    cmd->base.qp_state == IB_QPS_RTR) {
+		/* We are in INIT->RTR TRANSITION (if we are not,
+		 * this transition will be rejected in subsequent checks).
+		 * In the INIT->RTR transition, we cannot have IB_QP_PORT set,
+		 * but the IB_QP_STATE flag is required.
+		 *
+		 * Since kernel 3.14 (commit dbf727de7440), the uverbs driver,
+		 * when IB_QP_AV is set, has required inclusion of a valid
+		 * port number in the primary AV. (AVs are created and handled
+		 * differently for infiniband and ethernet (RoCE) ports).
+		 *
+		 * Check the port number included in the primary AV against
+		 * the port number in the qp struct, which was set (and saved)
+		 * in the RST->INIT transition.
+		 */
+			if (cmd->base.dest.port_num != qp->real_qp->port) {
+				ret = -EINVAL;
+				goto release_qp;
+			}
+		} else {
+		/* We are in SQD->SQD. (If we are not, this transition will
+		 * be rejected later in the verbs layer checks).
+		 * Check for both IB_QP_PORT and IB_QP_AV, these can be set
+		 * together in the SQD->SQD transition.
+		 *
+		 * If only IP_QP_AV was set, add in IB_QP_PORT as well (the
+		 * verbs layer driver does not track primary port changes
+		 * resulting from path migration. Thus, in SQD, if the primary
+		 * AV is modified, the primary port should also be modified).
+		 *
+		 * Note that in this transition, the IB_QP_STATE flag
+		 * is not allowed.
+		 */
+			if (((cmd->base.attr_mask & (IB_QP_AV | IB_QP_PORT))
+			     == (IB_QP_AV | IB_QP_PORT)) &&
+			    cmd->base.port_num != cmd->base.dest.port_num) {
+				ret = -EINVAL;
+				goto release_qp;
+			}
+			if ((cmd->base.attr_mask & (IB_QP_AV | IB_QP_PORT))
+			    == IB_QP_AV) {
+				cmd->base.attr_mask |= IB_QP_PORT;
+				cmd->base.port_num = cmd->base.dest.port_num;
+			}
+		}
 	}
 
 	if ((cmd->base.attr_mask & IB_QP_ALT_PATH) &&
 	    (!rdma_is_port_valid(qp->device, cmd->base.alt_port_num) ||
-	    !rdma_is_port_valid(qp->device, cmd->base.alt_dest.port_num))) {
+	    !rdma_is_port_valid(qp->device, cmd->base.alt_dest.port_num) ||
+	    cmd->base.alt_port_num != cmd->base.alt_dest.port_num)) {
 		ret = -EINVAL;
 		goto release_qp;
 	}


