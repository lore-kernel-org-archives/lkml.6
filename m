Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB4FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA67820880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfBTNns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:43:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:40210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbfBTNns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:43:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC465B173;
        Wed, 20 Feb 2019 13:43:45 +0000 (UTC)
Date:   Wed, 20 Feb 2019 14:43:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, stable@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v4] panic: Avoid the extra noise dmesg
Message-ID: <20190220134344.nnukjlxh3nkcqy4c@pathway.suse.cz>
References: <1544176279-77828-1-git-send-email-feng.tang@intel.com>
 <20181210131729.04b8e0d3@gandalf.local.home>
 <CAGXu5jJrC5J7YNJ24JNNkNTRr7qRfQa+x+dePC0OOrpcEJFwaA@mail.gmail.com>
 <20181211083230.x6s44wsgfgijl4ws@pathway.suse.cz>
 <20190215055654.gelhlfni5wboftdx@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215055654.gelhlfni5wboftdx@shbuild888>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-02-15 13:56:54, Feng Tang wrote:
> Hi all,
> 
> On Tue, Dec 11, 2018 at 09:32:30AM +0100, Petr Mladek wrote:
> > On Mon 2018-12-10 10:49:22, Kees Cook wrote:
> > > On Mon, Dec 10, 2018 at 10:17 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Fri,  7 Dec 2018 17:51:19 +0800
> > > > Feng Tang <feng.tang@intel.com> wrote:
> > > >
> > > > > When kernel panic happens, it will first print the panic call stack,
> > > > > then the ending msg like:
> > > > >
> > > > > [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> > > > > [   35.749975] ------------[ cut here ]------------
> > > > >
> > > > > The above message are very useful for debugging.
> > > > >
> > > > > But if system is configured to not reboot on panic, say the "panic_timeout"
> > > > > parameter equals 0, it will likely print out many noisy message like
> > > > > WARN() call stack for each and every CPU except the panic one, messages
> > > > > like below:
> 
> So currently, there are 2 proposals:
> 1. this v4 patch of "panic_keep_irq_on" flag (default off to be same
>    as the current kernel behavior)
> 2. Petr's suggestion of adding a flag to suppress printk after enterring
>    late panic phase (blinking time), while keeping the sysrq printk
>    working.
> 
> Following is the draft patch based on Petr's suggestion:
> 
> Please review, thanks. I'm fine with both solutions.
> 
> - Feng
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 1f03078..8921fed 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -528,6 +528,11 @@ void __handle_sysrq(int key, bool check_mask)
>  	struct sysrq_key_op *op_p;
>  	int orig_log_level;
>  	int i;
> +	int old_val;
> +
> +	/* save the old panic printk flag */

The comment is not needed. It is obvious.

> +	old_val = panic_suppress_printk;

s/old_val/orig_panic_suppress_printk/ to follow
the naming of orig_log_level.

> +	panic_suppress_printk = 1;

We want to enable the messages in sysrq. This should be:

	panic_suppress_printk = 0;


>  	rcu_sysrq_start();
>  	rcu_read_lock();
> @@ -574,6 +579,8 @@ void __handle_sysrq(int key, bool check_mask)
>  	}
>  	rcu_read_unlock();
>  	rcu_sysrq_end();
> +
> +	panic_suppress_printk = old_val;
>  }
>  
>  void handle_sysrq(int key)
> diff --git a/kernel/panic.c b/kernel/panic.c
> index f121e6b..0cd3a1b 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -326,6 +328,7 @@ void panic(const char *fmt, ...)
>  	}
>  #endif
>  	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);

/* Do not scroll important messages with errors from blinking code. */

> +	panic_suppress_printk = 1;
>  	local_irq_enable();
>  	for (i = 0; ; i += PANIC_TIMER_STEP) {
>  		touch_softlockup_watchdog();
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d3d1703..c27bbf5 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1987,6 +1987,9 @@ asmlinkage __visible int printk(const char *fmt, ...)
>  	va_list args;
>  	int r;

	/* Suppress messages from panic blinking code. */

> +	if (unlikely(panic_suppress_printk))
> +		return 0;

This should go to vprintk_emit() so that it works for all
printk() interfaces.

> +
>  	va_start(args, fmt);
>  	r = vprintk_func(fmt, args);
>  	va_end(args);

Best Regards,
Petr
