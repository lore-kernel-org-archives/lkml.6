Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123E3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4A220865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4A220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeIJNsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:48:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbeIJNsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:48:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36A2D2637B;
        Mon, 10 Sep 2018 08:55:49 +0000 (UTC)
Received: from [10.36.117.149] (ovpn-117-149.ams2.redhat.com [10.36.117.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A2882166BA3;
        Mon, 10 Sep 2018 08:55:48 +0000 (UTC)
Subject: Re: [RFC] pipe: prevent compiler reordering in pipe_poll
To:     Eric Wong <normalperson@yhbt.net>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180824225431.tpaxuck7idgnj3b7@dcvr>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <817dd145-fba5-d5e8-26b8-746b9bab4dd9@redhat.com>
Date:   Mon, 10 Sep 2018 10:55:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824225431.tpaxuck7idgnj3b7@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 10 Sep 2018 08:55:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 10 Sep 2018 08:55:49 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pbonzini@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2018 00:54, Eric Wong wrote:
> The pipe_poll function does not use locks, and adding an entry
> to the waitqueue is not guaranteed to happen before pipe->nrbufs
> (or other fields) are read, leading to missed wakeups.
> 
> Looking at Ruby CI build logs and backtraces, I've noticed
> occasional instances where processes are stuck in select(2) or
> ppoll(2) with a pipe.
> 
> I don't have access to the systems where this is happening to
> test/reproduce the problem, and haven't been able to reproduce
> it locally on less-powerful hardware, either.  However, it seems
> like a problem based on similar comments in
> fs/eventfd.c::eventfd_poll made by Paolo.

The documentation change can be useful, but if you add a compiler
barrier you should also mention why reordering at the processor level is
okay.  In this case, processor-level reordering is okay because (just
like in fs/eventfd.c) poll_wait acts as an acquire barrier.

*However* I would be surprised if the scenario (even the one in
fs/eventfd.c) can actually happen, and I don't think the compiler
barrier is useful; there's no reason why the compiler should think that
it can hoist the reads above poll_wait.

In fact, there is a big difference between READ_ONCE() and barrier() for
whoever reads the code, which makes the code after your patch worse than
before.  READ_ONCE() means "I know I am accessing this variable outside
a lock".  barrier() means one of two things: 1) "I know what I am doing
can trick the compiler, and I don't want that to happen"; 2) "I am
synchronizing against other things happening on this CPU" such as
interrupts.  In this case you are not doing any of the two.

Paolo


> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  fs/pipe.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 39d6f431da83..1a904d941cf1 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -509,7 +509,7 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	}
>  }
>  
> -/* No kernel lock held - fine */
> +/* No kernel lock held - fine, but a compiler barrier is required */
>  static __poll_t
>  pipe_poll(struct file *filp, poll_table *wait)
>  {
> @@ -519,7 +519,35 @@ pipe_poll(struct file *filp, poll_table *wait)
>  
>  	poll_wait(filp, &pipe->wait, wait);
>  
> -	/* Reading only -- no need for acquiring the semaphore.  */
> +	/*
> +	 * Reading only -- no need for acquiring the semaphore, but
> +	 * we need a compiler barrier to ensure the compiler does
> +	 * not reorder reads to pipe->nrbufs, pipe->writers,
> +	 * pipe->readers, filp->f_version, pipe->w_counter, and
> +	 * pipe->buffers before poll_wait to avoid missing wakeups
> +	 * from compiler reordering.  In other words, we need to
> +	 * prevent the following situation:
> +	 *
> +	 * pipe_poll                          pipe_write
> +	 * -----------------                  ------------
> +	 * nrbufs = pipe->nrbufs (INVALID!)
> +	 *
> +	 *                                    __pipe_lock
> +	 *                                    pipe->nrbufs = ++bufs;
> +	 *                                    __pipe_unlock
> +	 *                                    wake_up_interruptible_sync_poll
> +	 *                                      pipe->wait is empty, no wakeup
> +	 *
> +	 * lock pipe->wait.lock (in poll_wait)
> +	 * __add_wait_queue
> +	 * unlock pipe->wait.lock
> +	 *
> +	 *  // pipe->nrbufs should be read here, NOT above
> +	 *
> +	 * pipe_poll returns 0 (WRONG)
> +	 */
> +	barrier();
> +
>  	nrbufs = pipe->nrbufs;
>  	mask = 0;
>  	if (filp->f_mode & FMODE_READ) {
> 

