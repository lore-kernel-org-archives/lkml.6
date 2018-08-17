Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862AFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B712188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B712188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeHQNIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:08:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34786 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeHQNIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:08:23 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so13097971ois.1;
        Fri, 17 Aug 2018 03:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pPePN0ohmipkH5CoJdE8tix8JvpZf7xQYsOCJA9FMgU=;
        b=o0Czhw+9V9a6YbeLXMkVuMCQ7k9y5LtUEXbi8ByU5w07grGwPyjN7oxb+fxmRHhZbM
         /TR6jBOvN3daRMs0k4fGBGwTGON4lj5bkNj8E4VFqgl7Y4wKps1gboNsKOEuF5G2iVjF
         5+08iguu6/eq6o3hPqIGwmE4mgmie6dnUnTw6Og7aTnbWoRQjvL5zwFGRz1irHMEJCJx
         zSMrG85xxejRXu6TcKREERq0ykqvTtPVzbxObdG0Z43+Gb2J/w7Ra7EHPst1kyQ27SdU
         yJ9lxJWdhH5859jkAXlXIMUYfzFff4vkS0KcQdWlFd/Eo5UFc+4YR2uXeHWi4gN9vch7
         Oa/w==
X-Gm-Message-State: AOUpUlF6xCXDMErgGdUcyiDHCONSKMhZRxxyD+Yx0pOrsPC02a1PujwA
        j7ySenp8RtjZwwEAuUoJUT3TbB16AI5gudGYoWQ=
X-Google-Smtp-Source: AA+uWPwMXtacaFWFFRNBvotuBTQHkKQlwx6gFYVHHnugpa9BnLkqEJIkjahL/Eh3rjPHp8fhlgQZz6fjo/YXYIwXNYY=
X-Received: by 2002:aca:37c2:: with SMTP id e185-v6mr1879632oia.326.1534500334376;
 Fri, 17 Aug 2018 03:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <2161372.IsD4PDzmmY@aspire.rjw.lan> <20180816132723.GA6010@lerouge>
 <10817203.8q7neLTJVD@aspire.rjw.lan>
In-Reply-To: <10817203.8q7neLTJVD@aspire.rjw.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Aug 2018 12:05:22 +0200
Message-ID: <CAJZ5v0jtQnickEdWamyqVyiS_Q12f9dsfA_d7QM93oS5LxF76g@mail.gmail.com>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been stopped
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 11:34 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
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
> > >              */
> > >             next_state = cpuidle_select(drv, dev, &stop_tick);
> > >
> > > -           if (stop_tick)
> > > +           if (stop_tick || tick_nohz_tick_stopped())
> > >                     tick_nohz_idle_stop_tick();
> > >             else
> > >                     tick_nohz_idle_retain_tick();
> >
> > So what if tick_nohz_idle_stop_tick() sees no timer to schedule and
> > cancels it, we may remain idle in a shallow state for a long while?
>
> Yes, but the governor is expected to avoid using shallow states when the
> tick is stopped already.
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
> >       ts->timer_expires_base = 0;
> > +
> > +     if (ts->tick_stopped)
> > +             tick_nohz_restart(ts, ktime_get());
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

Anyway, I'm sort of divided here.

We need to do something, this way or another, because the current code
is not strictly correct.

If there are no concerns about the possible extra overhead related to
restarting the tick, I'd just add a tick_nohz_idle_restart_tick() to
the tick_nohz_idle_retain_tick() branch in cpuidle_idle_call() (it
would do what's needed in there without affecting any other places).

Then, of course, governors would not need to worry about leaving the
tick stopped, so menu could be simplified somewhat, which may be a
good thing after all.

Cheers,
Rafael
