Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5153C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601F620870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OM2DVv0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601F620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeIJVsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:48:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeIJVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9Eznk4kjbNQVr49np7GzRXYgriwfG704dexZsXT65Qs=; b=OM2DVv0MShb7UWNPlx5E1u/jn
        BUiN7E6R8HJyt8Uq7KhDZkkBXdCpj6CGZMl5cXvd5qqAdATGyeqa4/8zfQyGuzHzLVSvqpDfDOwje
        FBtTlpW4rJapiz7cP+1DIfIlFxP2rDGMmjkD3gRsV2IBr+VpM0EiJd4M9luL3agOArvEhNbe3wfKE
        1RHXMcbUAYtNXJAhkfqFQxExEy/EuJhRJyiCL5EGYG32h7sAPpIy58RkJBylU0Yn2C1Sagz7QjsTB
        iDtQTOIlW75nMQwcdXAMA3qhhHSGlKGVSJodg5NHKiQzeUjHqjsINdFDUQV9Vpxq0sJqH5lYCzvah
        UysLmD4Hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzPR7-0002ok-8s; Mon, 10 Sep 2018 16:53:17 +0000
Date:   Mon, 10 Sep 2018 09:53:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     syzbot <syzbot+5b1df0420c523b45a953@syzkaller.appspotmail.com>
Cc:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, Andrea Arcangeli <aarcange@redhat.com>,
        akpm@linux-foundation.org
Subject: Re: possible deadlock in aio_poll
Message-ID: <20180910165317.GA3237@infradead.org>
References: <000000000000cbb35d05757f7a3a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000cbb35d05757f7a3a@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:41:05AM -0700, syzbot wrote:
> =====================================================
> WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> 4.19.0-rc2+ #229 Not tainted
> -----------------------------------------------------
> syz-executor2/9399 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> 00000000126506e0 (&ctx->fd_wqh){+.+.}, at: spin_lock
> include/linux/spinlock.h:329 [inline]
> 00000000126506e0 (&ctx->fd_wqh){+.+.}, at: aio_poll+0x760/0x1420
> fs/aio.c:1747
> 
> and this task is already holding:
> 000000002bed6bf6 (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq
> include/linux/spinlock.h:354 [inline]
> 000000002bed6bf6 (&(&ctx->ctx_lock)->rlock){..-.}, at: aio_poll+0x738/0x1420
> fs/aio.c:1746
> which would create a new lock dependency:
>  (&(&ctx->ctx_lock)->rlock){..-.} -> (&ctx->fd_wqh){+.+.}

ctx->fd_wqh seems to only exist in userfaultfd, which indeed seems
to do strange open coded waitqueue locking, and seems to fail to disable
irqs.  Something like this should fix it:

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index bfa0ec69f924..356d2b8568c1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1026,7 +1026,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 	struct userfaultfd_ctx *fork_nctx = NULL;
 
 	/* always take the fd_wqh lock before the fault_pending_wqh lock */
-	spin_lock(&ctx->fd_wqh.lock);
+	spin_lock_irq(&ctx->fd_wqh.lock);
 	__add_wait_queue(&ctx->fd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1112,13 +1112,13 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
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
