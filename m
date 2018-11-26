Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C157C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6391F20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErVL781I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6391F20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeKZVwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbeKZVwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:52:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9A620817;
        Mon, 26 Nov 2018 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229930;
        bh=SDhrV7A39LIHQjt1QjccrpLOOhWyKZvW5rqCnXcYiAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErVL781ILNEhfeLNyUjNuM5ntWWebZHR2OU8Z0l74Ia9R31nd+FdM8XSLRBh6SzD9
         uhzvY7ByUbyHua8tCat95qZ82FlnuRcVDZgN9kTkOrnWKNSX7Qwnh2+kh/D6Ov6aDo
         1b14tpIn3+1bSaxN77EfOErycWhQlaaiU1ODTcVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 33/46] Revert "media: videobuf2-core: dont call memop finish when queueing"
Date:   Mon, 26 Nov 2018 11:51:22 +0100
Message-Id: <20181126105049.243773279@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
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

This reverts commit 9ac47200b51cb09d2f15dbefa67e0412741d98aa.

This commit fixes a bug in upstream commit a136f59c0a1f ("vb2: Move
buffer cache synchronisation to prepare from queue") which isn't
present in 4.9.

So as a result you get an UNBALANCED message in the kernel log if
this patch is applied:

vb2:   counters for queue ffffffc0f3687478, buffer 3: UNBALANCED!
vb2:     buf_init: 1 buf_cleanup: 1 buf_prepare: 805 buf_finish: 805
vb2:     buf_queue: 806 buf_done: 806
vb2:     alloc: 0 put: 0 prepare: 806 finish: 805 mmap: 0
vb2:     get_userptr: 0 put_userptr: 0
vb2:     attach_dmabuf: 1 detach_dmabuf: 1 map_dmabuf: 805 unmap_dmabuf: 805
vb2:     get_dmabuf: 0 num_users: 1609 vaddr: 0 cookie: 805

Reverting this patch solves this regression.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/videobuf2-core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-core/videobuf2-core.c
index f7ca1fab4808..4df4a1f402be 100644
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -914,12 +914,9 @@ void vb2_buffer_done(struct vb2_buffer *vb, enum vb2_buffer_state state)
 	dprintk(4, "done processing on buffer %d, state: %d\n",
 			vb->index, state);
 
-	if (state != VB2_BUF_STATE_QUEUED &&
-	    state != VB2_BUF_STATE_REQUEUEING) {
-		/* sync buffers */
-		for (plane = 0; plane < vb->num_planes; ++plane)
-			call_void_memop(vb, finish, vb->planes[plane].mem_priv);
-	}
+	/* sync buffers */
+	for (plane = 0; plane < vb->num_planes; ++plane)
+		call_void_memop(vb, finish, vb->planes[plane].mem_priv);
 
 	spin_lock_irqsave(&q->done_lock, flags);
 	if (state == VB2_BUF_STATE_QUEUED ||
-- 
2.17.1



