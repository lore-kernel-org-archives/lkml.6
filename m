Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3478CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C409820852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C409820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbeGWO5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387801AbeGWO5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:57:16 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF0C20852;
        Mon, 23 Jul 2018 13:55:52 +0000 (UTC)
Date:   Mon, 23 Jul 2018 09:55:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Snild Dolkow <snild@sony.com>
Cc:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Yoshitaka Seto <yoshitaka.seto@sony.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH RESEND] kthread, tracing: Don't expose half-written comm
 when creating kthreads
Message-ID: <20180723095550.08203a24@gandalf.local.home>
In-Reply-To: <20180723134210.54013-1-snild@sony.com>
References: <20180723134210.54013-1-snild@sony.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 15:42:10 +0200
Snild Dolkow <snild@sony.com> wrote:

> There was a window for racing when task->comm was being written. The
> vsnprintf function writes 16 bytes, then counts the rest, then null
> terminates. In the meantime, other threads could see the non-terminated
> comm value. In our case, it got into the trace system's saved cmdlines
> and could cause stack corruption when strcpy'd out of there.
> 
> The workaround in e09e28671 (use strlcpy in __trace_find_cmdline) was
> likely needed because of this bug.
> 
> Solved by vsnprintf:ing to a local buffer, then using set_task_comm().
> 
> Signed-off-by: Snild Dolkow <snild@sony.com>
> ---
>  kernel/kthread.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 481951bf091d..28874afbf747 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -319,8 +319,10 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
>  	task = create->result;
>  	if (!IS_ERR(task)) {
>  		static const struct sched_param param = { .sched_priority = 0 };
> +		char name[TASK_COMM_LEN];
>  
> -		vsnprintf(task->comm, sizeof(task->comm), namefmt, args);

Can you add a comment here stating something to the affect of:

		/* task is now visible to other tasks */

-- Steve

> +		vsnprintf(name, sizeof(name), namefmt, args);
> +		set_task_comm(task, name);
>  		/*
>  		 * root may have changed our (kthreadd's) priority or CPU mask.
>  		 * The kernel thread should not inherit these properties.

