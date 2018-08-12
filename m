Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE778C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD3221A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD3221A2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeHLMp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:45:28 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39368 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeHLMp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:45:27 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so22715724oib.6;
        Sun, 12 Aug 2018 03:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqIzaENkmWg2Rx3Fb6mkv+IXi0FXckw+8nIblZ2uPS8=;
        b=sQ8ebS/CtSuZCfwJRx1lz34FUY3TUvCKsqhyBm9nfceZ4scDg2NAVmHyzIl0L8WsyT
         YihpOFcXfUy1AQVjB8Pf0+UIF5AVe997ZzDP88n14OARyosG0x04fcrCeF4qOuF3sM72
         PyXxTN/zACh343eCXKHpzv5ceDrjqvwpOxInQTFAFMYCZ3ZmA4x4iqb6t9SnWhOk0l5k
         PCcujSqo501+xxDBTfPx840IvX5qn+fuYSppHZMpRNomj52VTYMd2SpjOPXqTO3DMK7N
         JxuIYW/JqoeCNtgYgt6zQOKK7l4ufUsjuONlfLuwn1fkWuG6MB7i8S9CgVtx6E1uaxYq
         mq3Q==
X-Gm-Message-State: AOUpUlHIJb5t2yWElxfWWtVnb0J545yOylSe3z6pipqUjrOqID5UMZZe
        +9fyWlxMirHb+E4Ah8THMSAFFzHh7v2eWXPSW04=
X-Google-Smtp-Source: AA+uWPxZzflbd4dXsAGI5/9bIgz3y6VOeJq9i/9kqlMVnTh2qcSGJGs7hNH3HaU23GndNra2ukUB9ZoZ0gaBxURTGFc=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr12416283oia.154.1534068476525;
 Sun, 12 Aug 2018 03:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <1951009.1jlQfyrxio@aspire.rjw.lan> <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <20180810092034.GF11817@leoy-ThinkPad-X240s> <CAJZ5v0h8T99pqhNoj+V9Mb5yS621OT_=d05YbWtbCW5H362myA@mail.gmail.com>
 <20180810123143.GG11817@leoy-ThinkPad-X240s>
In-Reply-To: <20180810123143.GG11817@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 12 Aug 2018 12:07:45 +0200
Message-ID: <CAJZ5v0h5XWES6ye152MjijWKqTWBVO2mjo5Jz3MmMn+=7tRqWA@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: menu: Handle stopped tick more aggressively
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 2:31 PM <leo.yan@linaro.org> wrote:
>
> On Fri, Aug 10, 2018 at 01:04:22PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 10, 2018 at 11:20 AM <leo.yan@linaro.org> wrote:
> > >
> > > On Fri, Aug 10, 2018 at 09:57:18AM +0200, Rafael J . Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Subject: [PATCH] cpuidle: menu: Handle stopped tick more aggressively
> > > >
> > > > Commit 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states
> > > > with stopped tick) missed the case when the target residencies of
> > > > deep idle states of CPUs are above the tick boundary which may cause
> > > > the CPU to get stuck in a shallow idle state for a long time.
> > > >
> > > > Say there are two CPU idle states available: one shallow, with the
> > > > target residency much below the tick boundary and one deep, with
> > > > the target residency significantly above the tick boundary.  In
> > > > that case, if the tick has been stopped already and the expected
> > > > next timer event is relatively far in the future, the governor will
> > > > assume the idle duration to be equal to TICK_USEC and it will select
> > > > the idle state for the CPU accordingly.  However, that will cause the
> > > > shallow state to be selected even though it would have been more
> > > > energy-efficient to select the deep one.
> > > >
> > > > To address this issue, modify the governor to always assume idle
> > > > duration to be equal to the time till the closest timer event if
> > > > the tick is not running which will cause the selected idle states
> > > > to always match the known CPU wakeup time.
> > > >
> > > > Also make it always indicate that the tick should be stopped in
> > > > that case for consistency.
> > > >
> > > > Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> > > > Reported-by: Leo Yan <leo.yan@linaro.org>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > -> v2: Initialize first_idx properly in the stopped tick case.
> > > >
> > > > ---
> > > >  drivers/cpuidle/governors/menu.c |   55 +++++++++++++++++----------------------
> > > >  1 file changed, 25 insertions(+), 30 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > > > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > > > @@ -285,9 +285,8 @@ static int menu_select(struct cpuidle_dr
> > > >  {
> > > >       struct menu_device *data = this_cpu_ptr(&menu_devices);
> > > >       int latency_req = cpuidle_governor_latency_req(dev->cpu);
> > > > -     int i;
> > > > -     int first_idx;
> > > > -     int idx;
> > > > +     int first_idx = 0;
> > > > +     int idx, i;
> > > >       unsigned int interactivity_req;
> > > >       unsigned int expected_interval;
> > > >       unsigned long nr_iowaiters, cpu_load;
> > > > @@ -307,6 +306,18 @@ static int menu_select(struct cpuidle_dr
> > > >       /* determine the expected residency time, round up */
> > > >       data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
> > > >
> > > > +     /*
> > > > +      * If the tick is already stopped, the cost of possible short idle
> > > > +      * duration misprediction is much higher, because the CPU may be stuck
> > > > +      * in a shallow idle state for a long time as a result of it.  In that
> > > > +      * case say we might mispredict and use the known time till the closest
> > > > +      * timer event for the idle state selection.
> > > > +      */
> > > > +     if (tick_nohz_tick_stopped()) {
> > > > +             data->predicted_us = ktime_to_us(delta_next);
> > > > +             goto select;
> > > > +     }
> > > > +
> > >
> > > This introduce two potential issues:
> > >
> > > - This will totally ignore the typical pattern in idle loop; I
> > >   observed on the mmc driver can trigger multiple times (> 10 times)
> > >   with consistent interval;
> >
> > I'm not sure what you mean by "ignore".
>
> You could see after move code from blow to this position, the typical
> pattern interval will not be accounted; so if in the middle of idles
> there have a bunch of interrupts with fix pattern, the upper code
> cannot detect this pattern anymore.

I'm not really following you here.

The part of the code skipped for tick_nohz_tick_stopped() doesn't
update the data at all AFAICS.  It only computes some values that
would be discarded later anyway, so I'm not sure what the point of
running that computation is.

The statistics are updated by menu_update() and that still runs and it
will take the actual wakeup events into account, won't it?

> [...]
>
> > > > -     if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> > > > -         expected_interval < TICK_USEC) {
> > > > +     if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> > > > +         expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
> > >
> > > I am not sure this logic is right... Why not use below checking, so
> > > for POLLING state we will never ask to stop the tick?
> > >
> > >         if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING ||
> > >             (expected_interval < TICK_USEC && !tick_nohz_tick_stopped())) {
> > >
> >
> > The only effect of it would be setting stop_tick to false, but why
> > would that matter?
>
> Please consider below situation, not sure if this case is existed or
> not:
>
>   step1: first time: enter one idle state with stopping tick;
>   step2: second time: select POLLING state and tick_nohz_tick_stopped()
>   is true;
>
> So in step2, it cannot set stop_tick to false with below sentence.
>
> > > >               unsigned int delta_next_us = ktime_to_us(delta_next);
> > > >
> > > >               *stop_tick = false;

But setting *stop_tick has no effect as far as the current code is
concerned (up to the bug fixed by the other patch).

Also the POLLING state can only be selected if there are no other
states matching delta_next available in that case which means that
there will be a timer to break the polling loop soon enough (and BTW
the polling has a built-in timeout too), so I don't really see a
problem here.
