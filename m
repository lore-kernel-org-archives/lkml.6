Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610FC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7F42098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrnHPLhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7F42098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbeJKXLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731020AbeJKXLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:11:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ED3B21476;
        Thu, 11 Oct 2018 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272618;
        bh=WSH8Jh9y/Ckdb/8mPpyLujjlFgV1xdgCWk1nkQGZm28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrnHPLhSE7vv6ixuU/fKsGN5Q4KEqSjIHRDW73jyVfC4PdXijBPHKXANSYqOzes8G
         6hDPmDizQDpBC5Bh0glRd0vzW10ZWKfA1mLbys8Nnts7gz+hX/2u2YsqajJHYubnXW
         Y1676s+KtpHWHEK0X1WreRljwvaJEWHSHyyXEfrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+cfe3c1e8ef634ba8964b@syzkaller.appspotmail.com,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH 4.9 25/35] ucma: fix a use-after-free in ucma_resolve_ip()
Date:   Thu, 11 Oct 2018 17:35:27 +0200
Message-Id: <20181011152521.180580326@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 5fe23f262e0548ca7f19fb79f89059a60d087d22 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1720,6 +1720,8 @@ static int ucma_close(struct inode *inod
 		mutex_lock(&mut);
 		if (!ctx->closing) {
 			mutex_unlock(&mut);
+			ucma_put_ctx(ctx);
+			wait_for_completion(&ctx->comp);
 			/* rdma_destroy_id ensures that no event handlers are
 			 * inflight for that id before releasing it.
 			 */


