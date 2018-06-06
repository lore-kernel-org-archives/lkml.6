Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQA2uOTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1ACF605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeFFFKg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 01:10:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45493 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeFFFKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 01:10:34 -0400
X-Google-Smtp-Source: ADUXVKL7cqDItFDoYO2C9XOc9r3qDSbIKB8y2FRaLD1oFxQN7VhtfW9tWdR7Y91oQlOBZVqa8i62FA==
Date: Wed, 6 Jun 2018 14:10:29 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180606051029.GA19211@tigerII.localdomain>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/05/18 14:47), Petr Mladek wrote:
[..]
> Grr, the ABBA deadlock is still there. NMIs are not sent to the other
> CPUs atomically. Even if we detect that logbuf_lock is available
> in printk_nmi_enter() on some CPUs, it might still get locked on
> another CPU before the other CPU gets NMI.

Can we do something about "B"? :) I mean - any chance we can rework
locking in nmi_cpu_backtrace()?

> By other words, any check in printk_safe_enter() is racy and not
> sufficient

I suppose you meant printk_nmi_enter().

>   => I suggest to revert the commit 719f6a7040f1bdaf96fcc70
>      "printk: Use the main logbuf in NMI when logbuf_lock is available"
>      for-4.18 and stable until we get a better solution.

Just random thoughts.

May be we need to revert it, but let's not "panic". I think [but don't
insist on it] that the patch in question is *probably* "good enough". It
addresses a bug report after all.
How often do we have arch_trigger_cpumask_backtrace() on all CPUs these
days? I tend to think that it used to be much more popular in the past,
because we had a loops_per_jiffy based spin_lock lockup detection which
would trigger NMI backtracase, but this functionality has gone, see
bc88c10d7e6900916f5e1ba3829d66a9de92b633 for details. I'm not saying
that the race condition that you found is unrealistic, I'm just saying
that _it seems_ that nmi_panic()->printk() on a single CPU is more common
now, so having that nmi_printk()->printk_deferred() might be quite
valuable at the end of the day.

May be I'm wrong!

> The only safe solution seems to be a trylock() in NMI in
> vprintk_emit() and fallback to vprintk_safe() when the lock
> is not taken. I mean something like:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 247808333ba4..4a5a0bf221b3 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1845,7 +1845,13 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	printk_delay();
>  
>  	/* This stops the holder of console_sem just where we want him */
> -	logbuf_lock_irqsave(flags);
> +	printk_safe_enter_irqsave(flags);
> +	if (in_nmi() && !raw_spin_trylock(&logbuf_lock)) {
> +		vprintk_nmi(fmt, args);
> +		printk_safe_exit_irqrestore(flags);
> +		return;
> +	} else
> +		raw_spin_lock(&logbuf_lock);
>  	/*
>  	 * The printf needs to come first; we need the syslog
>  	 * prefix which might be passed-in as a parameter.

I need some time to think about it.

> Sigh, this looks like a material for-4.19.

Agreed.

> We might need to revisit if printk_context still makes sense, ...

What do you mean by this?

> PS: I realized this when writing the pull request for-4.18.
> I removed this patch from the pull request.

Yep. Good job!

	-ss
