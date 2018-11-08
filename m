Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4049C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7942F20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq2Wbj6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7942F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbeKIICQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727288AbeKIHm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9074E20989;
        Thu,  8 Nov 2018 22:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714699;
        bh=upGFQ+S3+I1cB6q89x5oeGL+4RyKWMx2lbOSJwOy70w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uq2Wbj6qNS4IxxfnJ72IC+F9abt09jhq7DrJQ2jRH27cpV9ei8sYaTOqe0og6yhUo
         6itrAQ5J07oPYxYy2s8S4tdbtmwIkG5WOnZVdV/Z0qLOw/KBx91omzZlpPVwnz7qF3
         BGzYrC1xDCnjjFSjBesGnwl+Bb416gj8x8sS9KAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@163.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 048/171] rxe: Fix a sleep-in-atomic bug in post_one_send
Date:   Thu,  8 Nov 2018 13:50:18 -0800
Message-Id: <20181108215130.994228651@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



