Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13304C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69D520896
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfATBbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 20:31:31 -0500
Received: from www.osadl.org ([62.245.132.105]:53349 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbfATBba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 20:31:30 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x0K1V3HF022664;
        Sun, 20 Jan 2019 02:31:04 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Steve Wise <swise@chelsio.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH RFC] iw_cxgb4: drop check - dead code
Date:   Sun, 20 Jan 2019 02:27:13 +0100
Message-Id: <1547947633-10515-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmalloc is called with  | __GFP_NOFAIL  so there is no point in
checking the return value - it either returns valid storage or it would
hang/terminate there. But it is not possible to say if the use of
__GFP_NOFAIL is really needed and the check should be removed or
vice-versa (use of __GFP_NOFAIL should be only in exceptional
cases as I understand it and alloc_srq_queue() is called in quite
a few places)
In either way it would need fixing.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 6a0b6174d35a ("rdma/cxgb4: Add support for kernel mode SRQ's")
---

Found during code review

Patch was compile tested with: x86_64_defconfig + INFINIBAND=y,
INFINIBAND_USER_ACCESS=y, CHELSIO_T4=y, INFINIBAND_CXGB4=y
(with some unrelated sparse warnings)

Q:This also has an interesting dependency with no effect:
  Depends on:... (INFINIBAND_USER_ACCESS [=n] || !INFINIBAND_USER_ACCESS [=n])
  I assume htat INFINIBAND_USER_ACCESS=y should be required here ?

Patch is against 5.0-rc2 (localversion-next is next-20190118)

 drivers/infiniband/hw/cxgb4/qp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index 917ce5c..c2a12ba 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2597,8 +2597,6 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
 	wr_len = sizeof(*res_wr) + sizeof(*res);
 
 	skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
-	if (!skb)
-		goto err_free_queue;
 	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
 
 	res_wr = (struct fw_ri_res_wr *)__skb_put(skb, wr_len);
-- 
2.1.4

