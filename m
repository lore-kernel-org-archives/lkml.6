Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2197BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF55A2172C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRLSHYJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF55A2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeHTR6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeHTR6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:58:50 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 280C721722;
        Mon, 20 Aug 2018 14:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534776173;
        bh=mj6ZRM7vj8mc4GZMoCz9wyZd0wHJc3CvlZTL3PTeb2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRLSHYJO8w9Kvxegbn6whOpyK6OpfC4e/19jpsEXFfy7K//ifW1tjsYliusXTcrjQ
         XtfD6JokiNcnWTAN+p9Xd7PtyVgUH2kM6MeO9evIlBi5RKEpl5jJpgarN6UD6ug+4D
         QjE5FMvN9uC2qXGOkORPpq+ZL5Hga0RYX83ws9Ck=
Date:   Mon, 20 Aug 2018 16:42:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been
 stopped
Message-ID: <20180820144249.GA9770@lerouge>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan>
 <20180816132723.GA6010@lerouge>
 <10817203.8q7neLTJVD@aspire.rjw.lan>
 <20180817141252.GA12426@lerouge>
 <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 11:57:00PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 17, 2018 at 4:12 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > On Fri, Aug 17, 2018 at 11:32:07AM +0200, Rafael J. Wysocki wrote:
> > > On Thursday, August 16, 2018 3:27:24 PM CEST Frederic Weisbecker wrote:
> > > > On Thu, Aug 09, 2018 at 07:08:34PM +0200, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > If the tick has been stopped already, but the governor has not asked to
> > > > > stop it (which it can do sometimes), the idle loop should invoke
> > > > > tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
> > > > > of this case properly.
> > > > >
> > > > > Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >  kernel/sched/idle.c |    2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > Index: linux-pm/kernel/sched/idle.c
> > > > > ===================================================================
> > > > > --- linux-pm.orig/kernel/sched/idle.c
> > > > > +++ linux-pm/kernel/sched/idle.c
> > > > > @@ -190,7 +190,7 @@ static void cpuidle_idle_call(void)
> > > > >            */
> > > > >           next_state = cpuidle_select(drv, dev, &stop_tick);
> > > > >
> > > > > -         if (stop_tick)
> > > > > +         if (stop_tick || tick_nohz_tick_stopped())
> > > > >                   tick_nohz_idle_stop_tick();
> > > > >           else
> > > > >                   tick_nohz_idle_retain_tick();
> > > >
> > > > So what if tick_nohz_idle_stop_tick() sees no timer to schedule and
> > > > cancels it, we may remain idle in a shallow state for a long while?
> > >
> > > Yes, but the governor is expected to avoid using shallow states when the
> > > tick is stopped already.
> >
> > So what kind of sleep do we enter to when an idle tick fires and we go
> > back to idle? Is it always deep?
> 
> No, it isn't.
> 
> The state to select must always fit the time till the closest timer
> event and that may be shorter than the tick period.

Ah ok, so that's fine then.

> 
> If there's a non-tick timer to wake the CPU up, we don't need to worry
> about restarting the tick, though. :-)

Ok.

> 
> > I believe that ts->tick_stopped == 1 shouldn't be too relevant for the governor.
> > We can definetly have scenarios where the idle tick is stopped for a long while,
> > then it fires and schedules the next timer at NOW() + TICK_NSEC (as if the tick
> > had been restarted). This can even repeat that way for some time, because
> > ts->tick_stopped == 1 only implies that the tick has been stopped once since
> > we entered the idle loop. After that we may well have a periodic tick behaviour.
> > In that case we probably don't want deep idle state. Especially if we have:
> >
> >               idle_loop() {
> >                   tick_stop (scheduled several seconds forward)
> >                   deep_idle_sleep()
> >                   //several seconds later
> >                   tick()
> >                   tick_stop (scheduled TICK_NSEC forward)
> >                   deep_idle_sleep()
> >                   tick() {
> >                       set_need_resched()
> >                   }
> >                   exit idle loop
> >               }
> >
> > Here the last deep idle state isn't necessary.
> 
> No, it isn't.
> 
> However, that is not relevant for the question of whether or not to
> restart the tick before entering the idle state IMO (see the
> considerations below).

Yes indeed.

> > But then in the longer term, perhaps cpuidle_select() should think that
> > through.
> 
> So I have given more consideration to this and my conclusion is that
> restarting the tick between cpuidle_select() and call_cpuidle() is a
> bad idea.
> 
> First off, if need_resched() is "false", the primary reason for
> running the tick on the given CPU is not there, so it only might be
> useful as a "backup" timer to wake up the CPU from an inadequate idle
> state.
> 
> Now, in general, there are two reasons for the idle governor (whatever
> it is) to select an idle state with a target residency below the tick
> period length.  The first reason is when the governor knows that the
> closest timer event is going to occur in this time frame, but in that
> case (as stated above), it is not necessary to worry about the tick,
> because the other timer will trigger soon enough anyway.  The second
> reason is when the governor predicts a wakeup which is not by a timer
> in this time frame and it is quite arguable what the governor should
> do then.  IMO it at least is not unreasonable to throw the prediction
> away and still go for the closest timer event in that case (which is
> the current approach).

Then in this case, when you say you throw away that prediction, does it
mean you select an idle state that only takes the next timer event into
consideration?

So for example we predict a wake up event TICK_NSEC ahead but the next
timer event is a few seconds, you're going to select an idle state
according to that "few seconds" ahead next event, right? (which in
practice is likely to be deep I guess).

I guess so but, just want to be sure I understand you correctly.

> 
> There's more, though.  Restarting the tick between cpuidle_select()
> and call_cpuidle() might introduce quite a bit of latency into that
> point and that would mess up with the idle state selection (e.g.
> selecting a very shallow idle state might not make a lot of sense if
> that latency was high enough, because the expected wakeup might very
> well take place when the tick was being restarted), so it should
> rather be avoided IMO.

Yes indeed.

Thanks.
