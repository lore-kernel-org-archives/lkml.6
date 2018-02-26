Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeBZG1Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 01:27:16 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44197 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeBZG1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 01:27:15 -0500
X-Google-Smtp-Source: AH8x226mKPHhtQ4q2hTvsq0mW3cwJjMVPrIghTxsBIDPs8cloZcOJDkyN1j37rpnPORLGoGxj6Y5HQ==
Date: Mon, 26 Feb 2018 15:27:10 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] printk: Relocate wake_klogd check close to the end of
 console_unlock()
Message-ID: <20180226062710.GB12539@jagdpanzerIV>
References: <20180208130402.15157-1-pmladek@suse.com>
 <20180219155817.yfo7yrnz4vyzxerx@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219155817.yfo7yrnz4vyzxerx@pathway.suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for the delay. Could not reply sooner.


On (02/19/18 16:58), Petr Mladek wrote:
[..]
> > @@ -2417,12 +2413,17 @@ void console_unlock(void)
> >  	up_console_sem();
> >  
> >  	/*
> > -	 * Someone could have filled up the buffer again, so re-check if there's
> > -	 * something to flush. In case we cannot trylock the console_sem again,
> > -	 * there's a new owner and the console_unlock() from them will do the
> > -	 * flush, no worries.
> > +	 * Check whether userland needs notification.  Also, someone could
> > +	 * have filled up the buffer again, so re-check if there's
> > +	 * something to flush. In case we cannot trylock the console_sem
> > +	 * again, there's a new owner and the console_unlock() from them
> > +	 * will do the flush, no worries.
> >  	 */
> >  	raw_spin_lock(&logbuf_lock);
> > +	if (seen_seq != log_next_seq) {
> > +		wake_klogd = true;
> > +		seen_seq = log_next_seq;
> 
> Sigh, there is actually still a race with console_trylock_spinning().

I see what you are talking about. Good catch.

> The simplest solution seems to be to do this only when !retry.

Yeah, offloading makes any "internal state" flags almost impossible to
use. We either need to upgrade those "internal state" flags to "global
state" flags, or to add more complex checks/race conditions workarounds
and so on. So I think that !retry should work. But, honestly, the whole
wakeup_klogd thing is getting too complex to like it.

	-ss
