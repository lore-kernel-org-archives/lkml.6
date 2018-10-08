Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8A6C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAABD21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yk033Km1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAABD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeJHWi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbeJHWi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 488832152C;
        Mon,  8 Oct 2018 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012403;
        bh=0oT4eQ4n+zgCRePU63+KqZPiXvdgSd6Yp5plr43+F40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yk033Km1+lKKdsZXKYBaSnYF4XK9D5hkCQjv4zpR8cxyYcXbnnltKbNWdnFNcwvIy
         nHDosfkSSQTSvzVcSNbbfrTFXYx0RrXGWZJNlXqo+cFPpY/kO7SHbSq5g0gfl+F524
         8zss2w8KTgvyq8S7FhMZRdWYabk2ZpJywLelXfsc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 13/32] ucma: fix a use-after-free in ucma_resolve_ip()
Date:   Mon,  8 Oct 2018 11:26:10 -0400
Message-Id: <20181008152629.70812-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 5fe23f262e0548ca7f19fb79f89059a60d087d22 ]

There is a race condition between ucma_close() and ucma_resolve_ip():

CPU0				CPU1
ucma_resolve_ip():		ucma_close():

ctx = ucma_get_ctx(file, cmd.id);

        list_for_each_entry_safe(ctx, tmp, &file->ctx_list, list) {
                mutex_lock(&mut);
                idr_remove(&ctx_idr, ctx->id);
                mutex_unlock(&mut);
		...
                mutex_lock(&mut);
                if (!ctx->closing) {
                        mutex_unlock(&mut);
                        rdma_destroy_id(ctx->cm_id);
		...
                ucma_free_ctx(ctx);

ret = rdma_resolve_addr();
ucma_put_ctx(ctx);

Before idr_remove(), ucma_get_ctx() could still find the ctx
and after rdma_destroy_id(), rdma_resolve_addr() may still
access id_priv pointer. Also, ucma_put_ctx() may use ctx after
ucma_free_ctx() too.

ucma_close() should call ucma_put_ctx() too which tests the
refcnt and waits for the last one releasing it. The similar
pattern is already used by ucma_destroy_id().

Reported-and-tested-by: syzbot+da2591e115d57a9cbb8b@syzkaller.appspotmail.com
Reported-by: syzbot+cfe3c1e8ef634ba8964b@syzkaller.appspotmail.com
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/ucma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index a22b992cde38..c1a7ed6306bd 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1736,6 +1736,8 @@ static int ucma_close(struct inode *inode, struct file *filp)
 		mutex_lock(&mut);
 		if (!ctx->closing) {
 			mutex_unlock(&mut);
+			ucma_put_ctx(ctx);
+			wait_for_completion(&ctx->comp);
 			/* rdma_destroy_id ensures that no event handlers are
 			 * inflight for that id before releasing it.
 			 */
-- 
2.17.1

