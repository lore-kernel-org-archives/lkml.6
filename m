Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A14CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E65208A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E65208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbeHBDhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbeHBDhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:37:40 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B61208A3;
        Thu,  2 Aug 2018 01:48:56 +0000 (UTC)
Date:   Wed, 1 Aug 2018 21:48:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCHv3] lib/ratelimit: Lockless ratelimiting
Message-ID: <20180801214855.3ae1abb9@vmware.local.home>
In-Reply-To: <1532100816.18720.44.camel@arista.com>
References: <20180703225628.25684-1-dima@arista.com>
        <1531789154.18720.3.camel@arista.com>
        <CAHp75VdmQ1YLzWpYb7878zKOCCyOEicdLAtpohbmY2hL1h1RNg@mail.gmail.com>
        <20180720150948.nv57fjmmrmo2r7rx@pathway.suse.cz>
        <1532100816.18720.44.camel@arista.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 16:33:36 +0100
Dmitry Safonov <dima@arista.com> wrote:

> On Fri, 2018-07-20 at 17:09 +0200, Petr Mladek wrote:
> > > > On Tue, 2018-07-03 at 23:56 +0100, Dmitry Safonov wrote:  
> > > > > Currently ratelimit_state is protected with spin_lock. If the
> > > > > .lock
> > > > > is
> > > > > taken at the moment of ___ratelimit() call, the message is
> > > > > suppressed
> > > > > to
> > > > > make ratelimiting robust.
> > > > > 
> > > > > That results in the following issue issue:
> > > > >       CPU0                          CPU1
> > > > > ------------------           ------------------
> > > > > printk_ratelimit()           printk_ratelimit()
> > > > >         |                             |
> > > > >   try_spin_lock()              try_spin_lock()
> > > > >         |                             |
> > > > > time_is_before_jiffies()          return 0; // suppress
> > > > > 
> > > > > So, concurrent call of ___ratelimit() results in silently
> > > > > suppressing
> > > > > one of the messages, regardless if the limit is reached or not.
> > > > > And rc->missed is not increased in such case so the issue is
> > > > > covered
> > > > > from user.
> > > > > 
> > > > > Convert ratelimiting to use atomic counters and drop spin_lock.
> > > > > 
> > > > > Note: That might be unexpected, but with the first interval of
> > > > > messages
> > > > > storm one can print up to burst*2 messages. So, it doesn't
> > > > > guarantee
> > > > > that in *any* interval amount of messages is lesser than burst.
> > > > > But, that differs lightly from previous behavior where one can
> > > > > start
> > > > > burst=5 interval and print 4 messages on the last milliseconds
> > > > > of
> > > > > interval + new 5 messages from new interval (totally 9 messages
> > > > > in
> > > > > lesser than interval value):
> > > > > 
> > > > >    msg0              msg1-msg4 msg0-msg4
> > > > >     |                     |       |
> > > > >     |                     |       |
> > > > >  |--o---------------------o-|-----o--------------------|--> (t)
> > > > >                           <------->
> > > > >                        Lesser than burst
> > > > >   
> > 
> > I am a bit confused. Does this patch fix two problems?
> > 
> >    + Lost rc->missed update when try_spin_lock() fails
> >    + printing up to burst*2 messages in a give interval  
> 
> What I tried to solve here (maybe I could better point it in the commit
> message): is the situation where ratelimit::burst haven't been hit yet
> and there are calls for __ratelimit() from different CPUs.
> So, neither of the messages should be suppressed, but as the spinlock
> is taken already - one of them is dropped and even without updating
> missed counter.
> 
> > It would make the review much easier if you split it into more
> > patches and fix the problems separately.  
> 
> Hmm, not really sure: the patch changes spinlock to atomics and I'm not
> sure it make much sense to add atomics before removing the spinlock..
> 
> > Otherwise, it looks promissing...
> > 
> > Best Regards,
> > Petr
> > 
> > PS: I have vacation the following two weeks. Anyway, please, CC me
> > if you send any new version.  
> 
> Surely, thanks for your attention to the patch (and time).
> 

I'm just catching up from my vacation. What about making rs->missed
into an atomic, and have:

	if (!raw_spin_trylock_irqsave(&rs->lock, flags)) {
		atomic_inc(&rs->missed);
		return 0;
	}

?

You would also need to do:

	if (time_is_before_jiffies(rs->begin + rs->interval)) {
		int missed = atomic_xchg(&rs->missed, 0);
		if (missed) {

So that you don't have a race between checking rs->missed and setting it
to zero.

-- Steve
