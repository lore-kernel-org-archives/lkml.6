Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B66C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C30218EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C30218EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeHQMhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:37:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65266 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeHQMhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:37:01 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id f83553e21db57294; Fri, 17 Aug 2018 11:34:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been stopped
Date:   Fri, 17 Aug 2018 11:32:07 +0200
Message-ID: <10817203.8q7neLTJVD@aspire.rjw.lan>
In-Reply-To: <20180816132723.GA6010@lerouge>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan> <20180816132723.GA6010@lerouge>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 16, 2018 3:27:24 PM CEST Frederic Weisbecker wrote:
> On Thu, Aug 09, 2018 at 07:08:34PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If the tick has been stopped already, but the governor has not asked to
> > stop it (which it can do sometimes), the idle loop should invoke
> > tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
> > of this case properly.
> > 
> > Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  kernel/sched/idle.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-pm/kernel/sched/idle.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/idle.c
> > +++ linux-pm/kernel/sched/idle.c
> > @@ -190,7 +190,7 @@ static void cpuidle_idle_call(void)
> >  		 */
> >  		next_state = cpuidle_select(drv, dev, &stop_tick);
> >  
> > -		if (stop_tick)
> > +		if (stop_tick || tick_nohz_tick_stopped())
> >  			tick_nohz_idle_stop_tick();
> >  		else
> >  			tick_nohz_idle_retain_tick();
> 
> So what if tick_nohz_idle_stop_tick() sees no timer to schedule and
> cancels it, we may remain idle in a shallow state for a long while?

Yes, but the governor is expected to avoid using shallow states when the
tick is stopped already.

> Otherwise we can have something like this:
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index da9455a..408c985 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -806,6 +806,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  static void tick_nohz_retain_tick(struct tick_sched *ts)
>  {
>  	ts->timer_expires_base = 0;
> +
> +	if (ts->tick_stopped)
> +		tick_nohz_restart(ts, ktime_get());
>  }
>  
>  #ifdef CONFIG_NO_HZ_FULL
> 

We could do that, but my concern with that approach is that we may end up
stopping and starting the tick back and forth without exiting the loop
in do_idle() just because somebody uses a periodic timer behind our
back and the governor gets confused.

Besides, that would be a change in behavior, while the $subject patch
simply fixes a mistake in the original design.

Cheers,
Rafael

