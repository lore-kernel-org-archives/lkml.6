Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC97C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C431B21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfBKNeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:34:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39694 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfBKNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:34:20 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gtBiy-0006J5-2n; Mon, 11 Feb 2019 13:34:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/bnxt_re: fix or'ing of data into an uninitialized struct member
Date:   Mon, 11 Feb 2019 13:34:15 +0000
Message-Id: <20190211133415.9020-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The struct member comp_mask has not been initialized however a bit
pattern is being bitwise or'd into the member and hence other bit
fields in comp_mask may contain any garbage from the stack. Fix this
by making the bitwise or into an assignment.

Fixes: 95b86d1c91ad ("RDMA/bnxt_re: Update kernel user abi to pass chip context")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 1d7469e23cde..de5cb9a61a78 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3720,7 +3720,7 @@ struct ib_ucontext *bnxt_re_alloc_ucontext(struct ib_device *ibdev,
 	}
 	spin_lock_init(&uctx->sh_lock);
 
-	resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_CCTX;
+	resp.comp_mask = BNXT_RE_UCNTX_CMASK_HAVE_CCTX;
 	chip_met_rev_num = rdev->chip_ctx.chip_num;
 	chip_met_rev_num |= ((u32)rdev->chip_ctx.chip_rev & 0xFF) <<
 			     BNXT_RE_CHIP_ID0_CHIP_REV_SFT;
-- 
2.20.1

