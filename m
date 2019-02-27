Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFA8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4753218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfB0Iny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:43:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:51744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726894AbfB0Iny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:43:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A432BAD62;
        Wed, 27 Feb 2019 08:43:51 +0000 (UTC)
Date:   Wed, 27 Feb 2019 09:30:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk/console: Do not suppress information about
 dropped messages
Message-ID: <20190227083043.j6nw7t6nqulim6t7@pathway.suse.cz>
References: <20190226124945.7078-1-pmladek@suse.com>
 <87k1hmzfam.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1hmzfam.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-26 17:26:57, John Ogness wrote:
> On 2019-02-26, Petr Mladek <pmladek@suse.com> wrote:
> > The warning about dropped messages gets lost when the current
> > message is above console_loglevel and suppressed.
> 
> Here you are reporting a bug. (More on this below.)

Yes.

> > The suppressed messages allow even slow consoles to caught up
> > with a flood of messages. The consoles must not get slowed
> > down by many warnings. Instead, the warning is delayed until
> > the next printable message.
> 
> Here you are introducing a new behavior. (Also discussed below.)
> Although the two are similar, they are really 2 different things.

No, I am replacing random behavior with a predictable one to fix
the bug. The above paragraph explains why the fix looks like it looks.
Maybe I should have written somethink like:

A solution would be to print the warning regardless the log level.
But it might cause loosing more important messages because of
delay caused by the warnings.

A better solution is to count all dropped messages until there
is a non-suppressed one. Then we could print the summary
together with the message.


> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index b4d26388bc62..c3f287422ef4 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2398,20 +2400,24 @@ void console_unlock(void)
> >  	for (;;) {
> >  		struct printk_log *msg;
> >  		size_t ext_len = 0;
> > -		size_t len;
> > +		size_t len = 0;
> >  
> >  		printk_safe_enter_irqsave(flags);
> >  		raw_spin_lock(&logbuf_lock);
> > +
> > +		/* Reset dropped msg count when switching to all consoles. */
> > +		if (unlikely(exclusive_console &&
> > +			     exclusive_console_stop_seq < log_first_seq)) {
> > +			console_dropped_cnt = 0;
> > +			console_seq = exclusive_console_stop_seq;
> > +		}
> > +
> 
> Wouldn't the fix to the bug be to move the "skip" target here?

No, the entire loop skiping suppressed messages is done under
the logbuf_lock. No old messages can be lost inside this loop.

> skip:
> 
> >  		if (console_seq < log_first_seq) {
> > -			len = sprintf(text,
> > -				      "** %llu printk messages dropped **\n",
> > -				      log_first_seq - console_seq);
> > +			console_dropped_cnt += log_first_seq - console_seq;
> >  
> >  			/* messages are gone, move to first one */
> >  			console_seq = log_first_seq;
> >  			console_idx = log_first_idx;
> > -		} else {
> > -			len = 0;
> >  		}
> >  skip:
> >  		if (console_seq == log_next_seq)
> > @@ -2435,6 +2441,13 @@ void console_unlock(void)
> >  			exclusive_console = NULL;
> >  		}
> >  
> > +		if (unlikely(console_dropped_cnt)) {
> > +			len = sprintf(text,
> > +				      "** %llu printk messages dropped **\n",
> > +				      console_dropped_cnt);
> > +			console_dropped_cnt = 0;
> > +		}
> > +
> 
> My only objection to this is that the "messages dropped" only comes if a
> non-supressed message comes. So information about dropped information
> may never get printed unless some task prints something non-supressed.
> 
> Imagine a situation where I am expecting a message to come, but don't
> see it because it was dropped. But if no more non-supressed messages
> come, I see neither the expected message nor the dropped message.

Good point! There is a simple fix for this. We could print the warning
also when all messages are proceed and we are about to leave
the for-cycle.

Best Regards,
Petr
