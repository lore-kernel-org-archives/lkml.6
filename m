Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CA6217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130274;
	bh=Yk1fAl1Jx3MOx+KYLcvHGe2koIrk+/noMIpcjfp4sVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y7fxwgIc2n1RtXAUCQdUQe9QrHDBthDOXkQVfJY16VqBJF5R+keVa46PXtLB1uGKc
	 n4O3Y6bhU96R2lu9FeZLKntREER9Crpi2Un+30wXyOvZudc1cYfcJcX+/1GsC6zk3C
	 Z4mLMNo2J0LzrobyoB2e9WKBM2OBcgwnu0xjPwUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbfBYVbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:31:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731836AbfBYVbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:31:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC0421841;
        Mon, 25 Feb 2019 21:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130268;
        bh=Yk1fAl1Jx3MOx+KYLcvHGe2koIrk+/noMIpcjfp4sVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KltXKEx+x82H8mB6AxVWSJNJsOTinLwIZVywGkQp6vH+64BVwG0PKy2vg5RVyejQo
         bUhOHXZElfXsss/QAiJncBk4fpWia0AVuJ+YpKExL2MspcBHycuVEKIzs2jgOMBJYf
         mY8h8de07QZfdg5MdeO6YV3R/GDxkF0+1uuDVaoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Murashkin <AlexanderMurashkin@msn.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 068/183] RDMA/mthca: Clear QP objects during their allocation
Date:   Mon, 25 Feb 2019 22:10:41 +0100
Message-Id: <20190225195106.005092881@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9d9f59b4204bc41896c866b3e5856e5b416aa199 ]

As part of audit process to update drivers to use rdma_restrack_add()
ensure that QP objects is cleared before access. Such change fixes the
crash observed with uninitialized non zero sgid attr accessed by
ib_destroy_qp().

CPU: 3 PID: 74 Comm: kworker/u16:1 Not tainted 4.19.10-300.fc29.x86_64
Workqueue: ipoib_wq ipoib_cm_tx_reap [ib_ipoib]
RIP: 0010:rdma_put_gid_attr+0x9/0x30 [ib_core]
RSP: 0018:ffffb7ad819dbde8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff8d1bdf5a2e00 RCX: 0000000000002699
RDX: 206c656e72656af8 RSI: ffff8d1bf7ae6160 RDI: 206c656e72656b20
RBP: 0000000000000000 R08: 0000000000026160 R09: ffffffffc06b45bf
R10: ffffe849887da000 R11: 0000000000000002 R12: ffff8d1be30cb400
R13: ffff8d1bdf681800 R14: ffff8d1be2272400 R15: ffff8d1be30ca000
FS:  0000000000000000(0000) GS:ffff8d1bf7ac0000(0000)
knlGS:0000000000000000
Trace:
 ib_destroy_qp+0xc9/0x240 [ib_core]
 ipoib_cm_tx_reap+0x1f9/0x4e0 [ib_ipoib]
 process_one_work+0x1a1/0x3a0
 worker_thread+0x30/0x380
 ? pwq_unbound_release_workfn+0xd0/0xd0
 kthread+0x112/0x130
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x22/0x40

Reported-by: Alexander Murashkin <AlexanderMurashkin@msn.com>
Tested-by: Alexander Murashkin <AlexanderMurashkin@msn.com>
Fixes: 1a1f460ff151 ("RDMA: Hold the sgid_attr inside the struct ib_ah/qp")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mthca/mthca_provider.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 691c6f0489386..2428c7d89c6be 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -533,7 +533,7 @@ static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
 	{
 		struct mthca_ucontext *context;
 
-		qp = kmalloc(sizeof *qp, GFP_KERNEL);
+		qp = kzalloc(sizeof(*qp), GFP_KERNEL);
 		if (!qp)
 			return ERR_PTR(-ENOMEM);
 
@@ -599,7 +599,7 @@ static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
 		if (pd->uobject)
 			return ERR_PTR(-EINVAL);
 
-		qp = kmalloc(sizeof (struct mthca_sqp), GFP_KERNEL);
+		qp = kzalloc(sizeof(struct mthca_sqp), GFP_KERNEL);
 		if (!qp)
 			return ERR_PTR(-ENOMEM);
 
-- 
2.19.1



