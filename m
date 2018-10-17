Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AEEECDE3D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA75213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA75213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJRHxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:53:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbeJRHxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:53:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D58C307D858;
        Wed, 17 Oct 2018 23:55:34 +0000 (UTC)
Received: from sky.random (ovpn-120-228.rdu2.redhat.com [10.10.120.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B034C1779A;
        Wed, 17 Oct 2018 23:55:33 +0000 (UTC)
Date:   Wed, 17 Oct 2018 19:55:32 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     syzbot <syzbot+5b1df0420c523b45a953@syzkaller.appspotmail.com>,
        bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: Re: possible deadlock in aio_poll
Message-ID: <20181017235532.GC4568@redhat.com>
References: <000000000000cbb35d05757f7a3a@google.com>
 <20180910165317.GA3237@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910165317.GA3237@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 17 Oct 2018 23:55:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 09:53:17AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 10, 2018 at 12:41:05AM -0700, syzbot wrote:
> > =====================================================
> > WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> > 4.19.0-rc2+ #229 Not tainted
> > -----------------------------------------------------
> > syz-executor2/9399 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> > 00000000126506e0 (&ctx->fd_wqh){+.+.}, at: spin_lock
> > include/linux/spinlock.h:329 [inline]
> > 00000000126506e0 (&ctx->fd_wqh){+.+.}, at: aio_poll+0x760/0x1420
> > fs/aio.c:1747
> > 
> > and this task is already holding:
> > 000000002bed6bf6 (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq
> > include/linux/spinlock.h:354 [inline]
> > 000000002bed6bf6 (&(&ctx->ctx_lock)->rlock){..-.}, at: aio_poll+0x738/0x1420
> > fs/aio.c:1746
> > which would create a new lock dependency:
> >  (&(&ctx->ctx_lock)->rlock){..-.} -> (&ctx->fd_wqh){+.+.}
> 
> ctx->fd_wqh seems to only exist in userfaultfd, which indeed seems
> to do strange open coded waitqueue locking, and seems to fail to disable
> irqs.  Something like this should fix it:
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index bfa0ec69f924..356d2b8568c1 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1026,7 +1026,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
>  	struct userfaultfd_ctx *fork_nctx = NULL;
>  
>  	/* always take the fd_wqh lock before the fault_pending_wqh lock */
> -	spin_lock(&ctx->fd_wqh.lock);
> +	spin_lock_irq(&ctx->fd_wqh.lock);
>  	__add_wait_queue(&ctx->fd_wqh, &wait);
>  	for (;;) {
>  		set_current_state(TASK_INTERRUPTIBLE);
> @@ -1112,13 +1112,13 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
>  			ret = -EAGAIN;
>  			break;
>  		}
> -		spin_unlock(&ctx->fd_wqh.lock);
> +		spin_unlock_irq(&ctx->fd_wqh.lock);
>  		schedule();
> -		spin_lock(&ctx->fd_wqh.lock);
> +		spin_lock_irq(&ctx->fd_wqh.lock);
>  	}
>  	__remove_wait_queue(&ctx->fd_wqh, &wait);
>  	__set_current_state(TASK_RUNNING);
> -	spin_unlock(&ctx->fd_wqh.lock);
> +	spin_unlock_irq(&ctx->fd_wqh.lock);
>  
>  	if (!ret && msg->event == UFFD_EVENT_FORK) {
>  		ret = resolve_userfault_fork(ctx, fork_nctx, msg);
> 

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

This is lock inversion with userfaultfd_poll that takes the fq_wqh
after the irqsafe aio lock. And the aio lock can be taken from softirq
(so potentially for interrupts) leading to a potential lock inversion
deadlock.

I suggest to add a comment about the above in the code before the
first spin_lock_irq to explain why it needs to be _irq or it's not
obvious.

c430d1e848ff1240d126e79780f3c26208b8aed9 was just a false positive
instead.

I didn't comment on c430d1e848ff1240d126e79780f3c26208b8aed9 because I
was too busy with the speculative execution issues at the time and it
was just fine to drop the microoptimization, but while at it can we
look in how to add a spin_acquire or find a way to teach lockdep in
another way, so it's happy even if we restore the microoptimization?

If we do that, in addition we should also initialize the
ctx->fault_wqh spinlock to locked in the same patch (a spin_lock
during uffd ctx creation will do) to be sure nobody takes it as
further robustness feature against future modification (it gets more
self documenting too that it's not supposed to be taken and the
fault_pending_wq.lock has to be taken instead).

Thanks,
Andrea
