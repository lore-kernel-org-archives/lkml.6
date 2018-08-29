Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0795C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F95320659
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F95320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeH2PFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:05:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:40258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbeH2PFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:05:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46A8EAD49;
        Wed, 29 Aug 2018 11:08:59 +0000 (UTC)
Date:   Wed, 29 Aug 2018 13:08:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCHv3] lib/ratelimit: Lockless ratelimiting
Message-ID: <20180829110856.yhr5clf4y5o4a3wc@pathway.suse.cz>
References: <20180703225628.25684-1-dima@arista.com>
 <20180815151047.qgjam3t3ujyacmaf@pathway.suse.cz>
 <1534806875.30457.28.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534806875.30457.28.camel@arista.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-08-21 00:14:35, Dmitry Safonov wrote:
> Hi Petr, thanks for review,
> 
> On Wed, 2018-08-15 at 17:10 +0200, Petr Mladek wrote:
> > On Tue 2018-07-03 23:56:28, Dmitry Safonov wrote:
> > > Currently ratelimit_state is protected with spin_lock. If the .lock
> > > is
> > > taken at the moment of ___ratelimit() call, the message is
> > > suppressed to
> > > make ratelimiting robust.
> > > 
> > > That results in the following issue issue:
> > >       CPU0                          CPU1
> > > ------------------           ------------------
> > > printk_ratelimit()           printk_ratelimit()
> > >         |                             |
> > >   try_spin_lock()              try_spin_lock()
> > >         |                             |
> > > time_is_before_jiffies()          return 0; // suppress
> > > 
> > > So, concurrent call of ___ratelimit() results in silently
> > > suppressing
> > > one of the messages, regardless if the limit is reached or not.
> > > And rc->missed is not increased in such case so the issue is
> > > covered
> > > from user.
> > > 
> > > Convert ratelimiting to use atomic counters and drop spin_lock.
> > > 
> > > Note: That might be unexpected, but with the first interval of
> > > messages
> > > storm one can print up to burst*2 messages. So, it doesn't
> > > guarantee
> > > that in *any* interval amount of messages is lesser than burst.
> > > But, that differs lightly from previous behavior where one can
> > > start
> > > burst=5 interval and print 4 messages on the last milliseconds of
> > > interval + new 5 messages from new interval (totally 9 messages in
> > > lesser than interval value):
> > 
> > I am still confused by this paragraph. Does this patch change the
> > behavior? What is the original and what is the new one, please?
> 
> Yeah, I could be a bit cleaner about the change.
> Originally more than `burst` messages could be printed if the previous
> period hasn't ended:

I am even more confused now. What do you mean by "if the previous
period hasn't ended"?

I do not see any way how more than 'burst' messages might be
printed between upating rs->begin.

> > 
> > >    msg0              msg1-msg4 msg0-msg4
> > >     |                     |       |
> > >     |                     |       |
> > >  |--o---------------------o-|-----o--------------------|--> (t)
> > >                           <------->
> > >                        Lesser than burst

s/Lesser than burst/Lesser than rs->period/  ?

> But now, because I check:
> +       if (atomic_add_unless(&rs->printed, 1, rs->burst))
> +               return 1;
> 
> *before* checking the end of interval, the maximum number of
> *messages in the peak will be the same, burst*2 (burst*2 - 1
> in original).

This paragraph is very confusing as well. It says that the number
of messages will be the "same". Then it mentions
burst*2 vs. burst*2 - 1. What means the word "same"?

I understand that with the old code you might see "burst*2 -1"
messages within rc->period time frame when they are printed
close around updating rs->begin.

But I do not see how it might be "burst*2" with the new code.
rs->begin must never be updated faster than rs->period.
And rs->begin is always updated together with rs->printed.
I mean that the first msg0 is always printed at the very
beginning of the interval and therefore far from the end.
Or do I miss anything?


> Why do I check it before the end of interval?
> I thought it would be a nice optimization, making atomic_add_unless()
> the only called function on the fast-path (when we haven't hit the
> limit yet). If you want, I can move it into a separate patch..

ratelimit is basically used together with printk() that is
a slow path. Your optimization is not worth the complexity.

And this brings me to the question what is the motivation for
this patch, please? Did you have a real life problem with
the original behavior?

The main purpose of the function is to reduce the amount
of duplicated messages that would mess the log, overload
consoles and do not help anything. It is used in situations
where it is expected that some messages might get lost.

It might make sense to fix rc->missed counter and
also make sure that always the first Nth < burst messages
will get printed but only when the code stays readable.


> > > Dropped dev/random patch since v1 version:
> > > lkml.kernel.org/r/<20180510125211.12583-1-dima@arista.com>
> > > 
> > > Dropped `name' in as it's unused in RATELIMIT_STATE_INIT()
> > > 
> > > diff --git a/lib/ratelimit.c b/lib/ratelimit.c
> > > index d01f47135239..d9b749d40108 100644
> > > --- a/lib/ratelimit.c
> > > +++ b/lib/ratelimit.c
> > > @@ -13,6 +13,18 @@
> > >  #include <linux/jiffies.h>
> > >  #include <linux/export.h>
> > >  
> > > +static void ratelimit_end_interval(struct ratelimit_state *rs,
> > > const char *func)
> > > +{
> > > +	rs->begin = jiffies;
> > > +
> > > +	if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
> > > +		unsigned int missed = atomic_xchg(&rs->missed, 0);
> > > +
> > > +		if (missed)
> > > +			pr_warn("%s: %u callbacks suppressed\n",
> > > func, missed);
> > > +	}
> > > +}
> > > +
> > >  /*
> > >   * __ratelimit - rate limiting
> > >   * @rs: ratelimit_state data
> > > @@ -27,45 +39,30 @@
> > >   */
> > >  int ___ratelimit(struct ratelimit_state *rs, const char *func)
> > >  {
> > > -	unsigned long flags;
> > > -	int ret;
> > > -
> > >  	if (!rs->interval)
> > >  		return 1;
> > >  
> > > -	/*
> > > -	 * If we contend on this state's lock then almost
> > > -	 * by definition we are too busy to print a message,
> > > -	 * in addition to the one that will be printed by
> > > -	 * the entity that is holding the lock already:
> > > -	 */
> > > -	if (!raw_spin_trylock_irqsave(&rs->lock, flags))
> > > +	if (unlikely(!rs->burst)) {
> > > +		atomic_add_unless(&rs->missed, 1, -1);
> > > +		if (time_is_before_jiffies(rs->begin + rs-
> > > >interval))
> > > +			ratelimit_end_interval(rs, func);
> > 
> > This is racy. time_is_before_jiffies() might be valid on two
> > CPUs in parallel. They would both call ratelimit_end_interval().
> > This is not longer atomic context. Therefore one might get scheduled
> > and set rs->begin = jiffies seconds later. I am sure that there might
> > be more crazy scenarios.
> 
> That's the case with rs->burst == 0.
> So, in this situation all the messages will be suppressed.
> And the only reason to call ratelimit_end_interval() is to update the
> start time and number of messages not printed.
> I didn't want to add any complexion for this case - the worst will be
> the count of messages suppressed will be imprecise for rs->burst == 0
> case. Not a big deal, huh?

Ah, I see, I have missed the check !rs->burst. Well, it does not make
much sense to use this value in the real life. IMHO, it is not worth
any optimization and extra code complexity if the rest of the code
might handle this situation correctly.


> > I wonder if the following code would do the job (not even compile
> > tested!):
> > 
> > static void ratelimit_end_interval(struct ratelimit_state *rs, const
> > char *func)
> > {
> > 	rs->begin = jiffies;
> > 
> > 	if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
> > 		unsigned int missed = atomic_xchg(&rs->missed, 0);
> > 
> > 		if (missed)
> > 			pr_warn("%s: %u callbacks suppressed\n", func,
> > missed);
> > 	}
> > 
> > 	atomic_xchg(&rs->printed, 0);
> > }
> > 
> > /*
> >  * __ratelimit - rate limiting
> >  * @rs: ratelimit_state data
> >  * @func: name of calling function
> >  *
> >  * This enforces a rate limit: not more than @rs->burst callbacks
> >  * in every @rs->interval
> >  *
> >  * RETURNS:
> >  * 0 means callbacks will be suppressed.
> >  * 1 means go ahead and do it.
> >  */
> > int ___ratelimit(struct ratelimit_state *rs, const char *func)
> > {
> > 	unsigned long begin, old_begin = rs->begin;
> > 
> > 	if (!rs->interval)
> > 		return 1;
> > 
> > 	if (time_is_before_jiffies(rs->begin + rs->interval) &&
> > 	    cmpxchg(&rs->begin, begin, begin + rs->interval) == begin) 
> 
> Probably, cmpxchg(&rs->begin, begin, jiffies)?
> Otherwise hitting it later will be buggy.
> Also `begin` might be uninitialized? (if cmpxchg() fails)

Yup, I messed this a bit. We could remove begin variable and
use:

	cmpxchg(&rs->begin, old_begin, jiffies)


Best Regards,
Petr
