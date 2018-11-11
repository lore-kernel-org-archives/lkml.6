Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47ADC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F0820839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/IaSuFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F0820839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbeKLJn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:43:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732772AbeKLISZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:25 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C91223C8;
        Sun, 11 Nov 2018 22:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975308;
        bh=QvcDQzhI8A2/jmo+CR28PtPOoxprpg8HPU7GlMGA430=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/IaSuFIhavH15RPbvmXXQQTY8Lv9hwA/v2gJtP3/R+4jEE7by15VGPWPk4CZ6HJZ
         5sbQAoKHJjd3tE+9clf7bnpNHj+moOR2mfRA9F2OV4gAv6cq5/x2yADW01gS7k6PFu
         b0tDpXgQl+9iKTRS70W9lT8lGgONZX5qraSj2WDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 249/361] userfaultfd: disable irqs when taking the waitqueue lock
Date:   Sun, 11 Nov 2018 14:19:56 -0800
Message-Id: <20181111221653.034748085@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit ae62c16e105a869524afcf8a07ee85c5ae5d0479 upstream.

userfaultfd contains howe-grown locking of the waitqueue lock, and does
not disable interrupts.  This relies on the fact that no one else takes it
from interrupt context and violates an invariat of the normal waitqueue
locking scheme.  With aio poll it is easy to trigger other locks that
disable interrupts (or are called from interrupt context).

Link: http://lkml.kernel.org/r/20181018154101.18750-1-hch@lst.de
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org>	[4.19.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/userfaultfd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1026,7 +1026,7 @@ static ssize_t userfaultfd_ctx_read(stru
 	struct userfaultfd_ctx *fork_nctx = NULL;
 
 	/* always take the fd_wqh lock before the fault_pending_wqh lock */
-	spin_lock(&ctx->fd_wqh.lock);
+	spin_lock_irq(&ctx->fd_wqh.lock);
 	__add_wait_queue(&ctx->fd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1112,13 +1112,13 @@ static ssize_t userfaultfd_ctx_read(stru
 			ret = -EAGAIN;
 			break;
 		}
-		spin_unlock(&ctx->fd_wqh.lock);
+		spin_unlock_irq(&ctx->fd_wqh.lock);
 		schedule();
-		spin_lock(&ctx->fd_wqh.lock);
+		spin_lock_irq(&ctx->fd_wqh.lock);
 	}
 	__remove_wait_queue(&ctx->fd_wqh, &wait);
 	__set_current_state(TASK_RUNNING);
-	spin_unlock(&ctx->fd_wqh.lock);
+	spin_unlock_irq(&ctx->fd_wqh.lock);
 
 	if (!ret && msg->event == UFFD_EVENT_FORK) {
 		ret = resolve_userfault_fork(ctx, fork_nctx, msg);


