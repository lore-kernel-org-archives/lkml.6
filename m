Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB75C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094362152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094362152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeI0Pdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:33:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeI0Pdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:33:44 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34F661117;
        Thu, 27 Sep 2018 09:16:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Wise <swise@opengridcomputing.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.18 88/88] iw_cxgb4: only allow 1 flush on user qps
Date:   Thu, 27 Sep 2018 11:04:09 +0200
Message-Id: <20180927090311.287793777@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve Wise <swise@opengridcomputing.com>

commit 308aa2b8f7b7db3332a7d41099fd37851fb793b2 upstream.

Once the qp has been flushed, it cannot be flushed again.  The user qp
flush logic wasn't enforcing it however.  The bug can cause
touch-after-free crashes like:

Unable to handle kernel paging request for data at address 0x000001ec
Faulting instruction address: 0xc008000016069100
Oops: Kernel access of bad area, sig: 11 [#1]
...
NIP [c008000016069100] flush_qp+0x80/0x480 [iw_cxgb4]
LR [c00800001606cd6c] c4iw_modify_qp+0x71c/0x11d0 [iw_cxgb4]
Call Trace:
[c00800001606cd6c] c4iw_modify_qp+0x71c/0x11d0 [iw_cxgb4]
[c00800001606e868] c4iw_ib_modify_qp+0x118/0x200 [iw_cxgb4]
[c0080000119eae80] ib_security_modify_qp+0xd0/0x3d0 [ib_core]
[c0080000119c4e24] ib_modify_qp+0xc4/0x2c0 [ib_core]
[c008000011df0284] iwcm_modify_qp_err+0x44/0x70 [iw_cm]
[c008000011df0fec] destroy_cm_id+0xcc/0x370 [iw_cm]
[c008000011ed4358] rdma_destroy_id+0x3c8/0x520 [rdma_cm]
[c0080000134b0540] ucma_close+0x90/0x1b0 [rdma_ucm]
[c000000000444da4] __fput+0xe4/0x2f0

So fix flush_qp() to only flush the wq once.

Cc: stable@vger.kernel.org
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/infiniband/hw/cxgb4/qp.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1388,6 +1388,12 @@ static void flush_qp(struct c4iw_qp *qhp
 	schp = to_c4iw_cq(qhp->ibqp.send_cq);
 
 	if (qhp->ibqp.uobject) {
+
+		/* for user qps, qhp->wq.flushed is protected by qhp->mutex */
+		if (qhp->wq.flushed)
+			return;
+
+		qhp->wq.flushed = 1;
 		t4_set_wq_in_error(&qhp->wq);
 		t4_set_cq_in_error(&rchp->cq);
 		spin_lock_irqsave(&rchp->comp_handler_lock, flag);


