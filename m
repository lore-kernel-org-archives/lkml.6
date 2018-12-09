Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637A3C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E4E20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E4E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeLIV5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:57:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36456 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbeLIVzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:44 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW737-0002pr-N9; Sun, 09 Dec 2018 21:55:42 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003Ts-RT; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steve Wise" <swise@opengridcomputing.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.590575248@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 194/328] iw_cxgb4: only allow 1 flush on user qps
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/cxgb4/qp.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1133,6 +1133,12 @@ static void flush_qp(struct c4iw_qp *qhp
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

