Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C17C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5859D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbfAOT6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732125AbfAOT6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:58:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D662320656;
        Tue, 15 Jan 2019 19:58:16 +0000 (UTC)
Date:   Tue, 15 Jan 2019 14:58:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH RT] printk: Shortcut out of waiter spinning on
 PREEMPT_RT
Message-ID: <20190115145815.13713791@gandalf.local.home>
In-Reply-To: <20190115185433.e7hmlpmjvpyqdyhc@linutronix.de>
References: <20190115123910.2b18df54@gandalf.local.home>
        <20190115185433.e7hmlpmjvpyqdyhc@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 19:54:33 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2019-01-15 12:39:10 [-0500], Steven Rostedt wrote:
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1742,6 +1742,13 @@ static int console_trylock_spinning(void)
> >  	if (console_trylock())
> >  		return 1;
> >  
> > +	/*
> > +	 * The consoles are preemptable in PREEMPT_RT, which can cause
> > +	 * spinning to deadlock.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> > +		return 0;
> > +
> >  	printk_safe_enter_irqsave(flags);
> >  
> >  	raw_spin_lock(&console_owner_lock);  
> 
> So my ("printk: Make rt aware") patch does:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 6553508ff3889..d983c509f74a2 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1617,6 +1617,7 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
>         return do_syslog(type, buf, len, SYSLOG_FROM_READER);
>  }
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  /*
>   * Special console_lock variants that help to reduce the risk of soft-lockups.
>   * They allow to pass console_lock to another printk() call using a busy wait.
> @@ -1757,6 +1758,15 @@ static int console_trylock_spinning(void)
>         return 1;
>  }
>  
> +#else
> +
> +static int console_trylock_spinning(void)
> +{
> +       return console_trylock();
> +}
> +
> +#endif
> +
>  /*
>   * Call the console drivers, asking them to write out
>   * log_buf[start] to log_buf[end - 1].
> 
> 
> So it never gets into the codepath where you try to avoid spinning.
> Right?
>

You right! Which appears to be missing from my 4.14, and I thought I
looked for that in 4.19-rt too, but I guess I was still looking at
4.14 :-/. OK, ignore. Sorry for the noise.

Well, it wasn't a total waste. I now know what to backport to 4.14-rt
;-)

-- Steve
