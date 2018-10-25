Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD89ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BAF20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqD8liXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BAF20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeJYWrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbeJYWrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:48 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FDEC20854;
        Thu, 25 Oct 2018 14:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476892;
        bh=zrPH1wC9WtalHNIKJhYdScHOCKQIqSXzX2bMfVQJkss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqD8liXfHE5QB3q4j2lFvP18xhsA+TCEei0qIrLHgiin7GIR1YNXQuJgyNRWT3f7E
         aDFCj1/CXrlEFAFZ7REs0fmCuzsCZaxMj695RFlr3w2a9sbsNSKbMV5Hid/JwI7I1R
         lXbVFK3v8zNtet3lH2pDg5MOKA0+5aoHFOGdl+w4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@163.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 17/98] rxe: Fix a sleep-in-atomic bug in post_one_send
Date:   Thu, 25 Oct 2018 10:13:02 -0400
Message-Id: <20181025141423.213774-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@163.com>

[ Upstream commit 07d432bb97f19dd5e784175152f9fce3b2646133 ]

The driver may sleep under a spin lock, and the function call path is:
post_one_send (acquire the lock by spin_lock_irqsave)
  init_send_wqe
    copy_from_user --> may sleep

There is no flow that makes "qp->is_user" true, and copy_from_user may
cause bug when a non-user pointer is used. So the lines of copy_from_user
and check of "qp->is_user" are removed.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Acked-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index ced416f5dffb..ef13082d6ca1 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -729,13 +729,8 @@ static int init_send_wqe(struct rxe_qp *qp, struct ib_send_wr *ibwr,
 
 		sge = ibwr->sg_list;
 		for (i = 0; i < num_sge; i++, sge++) {
-			if (qp->is_user && copy_from_user(p, (__user void *)
-					    (uintptr_t)sge->addr, sge->length))
-				return -EFAULT;
-
-			else if (!qp->is_user)
-				memcpy(p, (void *)(uintptr_t)sge->addr,
-				       sge->length);
+			memcpy(p, (void *)(uintptr_t)sge->addr,
+					sge->length);
 
 			p += sge->length;
 		}
-- 
2.17.1

