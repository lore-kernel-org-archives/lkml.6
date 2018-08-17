Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14B8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5B6218DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdCQVGgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5B6218DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeHQRQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbeHQRQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:16:29 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A232185A;
        Fri, 17 Aug 2018 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534515176;
        bh=HJmL29St/mHSM6P+CFgoRIekoTpw97xpECKpi+mpA8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GdCQVGgn6rP4RCdGZw0/MTUaNW1EZVOe/pyZx4M1EZhtmbvFAbNG0+Sz1DFQVa+Yw
         T9puvJwQQYJiaQcdpcYGKQILYK6F1oo+1mIfsbADYYR65Kr74P5opr8vLFklWqaRax
         zV6Krhot5JzeIUmICgnXmwH/UImy3766H6jLmrrk=
Date:   Fri, 17 Aug 2018 16:12:54 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been
 stopped
Message-ID: <20180817141252.GA12426@lerouge>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan>
 <20180816132723.GA6010@lerouge>
 <10817203.8q7neLTJVD@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10817203.8q7neLTJVD@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 11:32:07AM +0200, Rafael J. Wysocki wrote:
> On Thursday, August 16, 2018 3:27:24 PM CEST Frederic Weisbecker wrote:
> > On Thu, Aug 09, 2018 at 07:08:34PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > If the tick has been stopped already, but the governor has not asked to
> > > stop it (which it can do sometimes), the idle loop should invoke
> > > tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
> > > of this case properly.
> > > 
> > > Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  kernel/sched/idle.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Index: linux-pm/kernel/sched/idle.c
> > > ===================================================================
> > > --- linux-pm.orig/kernel/sched/idle.c
> > > +++ linux-pm/kernel/sched/idle.c
> > > @@ -190,7 +190,7 @@ static void cpuidle_idle_call(void)
> > >  		 */
> > >  		next_state = cpuidle_select(drv, dev, &stop_tick);
> > >  
> > > -		if (stop_tick)
> > > +		if (stop_tick || tick_nohz_tick_stopped())
> > >  			tick_nohz_idle_stop_tick();
> > >  		else
> > >  			tick_nohz_idle_retain_tick();
> > 
> > So what if tick_nohz_idle_stop_tick() sees no timer to schedule and
> > cancels it, we may remain idle in a shallow state for a long while?
> 
> Yes, but the governor is expected to avoid using shallow states when the
> tick is stopped already.

So what kind of sleep do we enter to when an idle tick fires and we go
back to idle? Is it always deep?

I believe that ts->tick_stopped == 1 shouldn't be too relevant for the governor.
We can definetly have scenarios where the idle tick is stopped for a long while,
then it fires and schedules the next timer at NOW() + TICK_NSEC (as if the tick
had been restarted). This can even repeat that way for some time, because
ts->tick_stopped == 1 only implies that the tick has been stopped once since
we entered the idle loop. After that we may well have a periodic tick behaviour.
In that case we probably don't want deep idle state. Especially if we have:

              idle_loop() {
                  tick_stop (scheduled several seconds forward)
                  deep_idle_sleep()
                  //several seconds later
                  tick()
                  tick_stop (scheduled TICK_NSEC forward)
                  deep_idle_sleep()
                  tick() {
                      set_need_resched()
                  }
                  exit idle loop
              }

Here the last deep idle state isn't necessary.

> 
> > Otherwise we can have something like this:
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index da9455a..408c985 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -806,6 +806,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> >  static void tick_nohz_retain_tick(struct tick_sched *ts)
> >  {
> >  	ts->timer_expires_base = 0;
> > +
> > +	if (ts->tick_stopped)
> > +		tick_nohz_restart(ts, ktime_get());
> >  }
> >  
> >  #ifdef CONFIG_NO_HZ_FULL
> > 
> 
> We could do that, but my concern with that approach is that we may end up
> stopping and starting the tick back and forth without exiting the loop
> in do_idle() just because somebody uses a periodic timer behind our
> back and the governor gets confused.
> 
> Besides, that would be a change in behavior, while the $subject patch
> simply fixes a mistake in the original design.

Ok, let's take the safe approach for now as this is a fix and it should even be
routed to stable.

But then in the longer term, perhaps cpuidle_select() should think that
through.

Thanks.
