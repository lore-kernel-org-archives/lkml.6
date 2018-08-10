Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4DDC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332B82240E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332B82240E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeHJNeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:34:01 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42191 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeHJNeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:34:00 -0400
Received: by mail-oi0-f66.google.com with SMTP id b16-v6so15058292oic.9;
        Fri, 10 Aug 2018 04:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyGU7xzaFvcu9E35VuLMhiZv5LFG4/nJK2dt4W2+eiQ=;
        b=MqmJIMc634fAk1mTJNwVxS9ghm2DVUZitSf+yD9SxTF/5REUUQvvIFu5JQ+t3g8G4B
         JXIdc2uzVmBeWRlA5qv5IsJ72yi79+vN3Qq+CA9BC2gp0WgCBZiYuzWuS9pa9mjPNlqo
         6RuuOhdnh5DynxrX6T/5QtXE4c+91UXZBvYqZayMbAQ43UAbKNZXp00ffkPQcJkKuTPW
         kfjTTxKp2+pCYeP5V4RiXJaMhsX1/dv5isLCw3YmY1OOCpB3axAhWEE7J/io4mikQmFT
         dmk1I8PoB5s8Vw6oyiqfyHaYtNqxxYWPKIMTuFVt7T+cybnsmUaVrsGY9xKXPiYVJsp0
         CSMQ==
X-Gm-Message-State: AOUpUlHGpt1FMS9V0+8oZqyrTiwBaXNs41+o0ma/gtRxaD6p9X/TaaBZ
        LlBQNu/FwhFqNLtY5knVN+7ZHLgqwBThDgaH3eYahg==
X-Google-Smtp-Source: AA+uWPwsmos5vfC4f9IanMcG+duijwT5WP8hzZtKaFws9byk6RNk6g0bLCrjRIGdtPzXjJDbUQYaI6HUIoO+T8KY0nY=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr6674819oie.233.1533899074616;
 Fri, 10 Aug 2018 04:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <1951009.1jlQfyrxio@aspire.rjw.lan> <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <20180810092034.GF11817@leoy-ThinkPad-X240s>
In-Reply-To: <20180810092034.GF11817@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Aug 2018 13:04:22 +0200
Message-ID: <CAJZ5v0h8T99pqhNoj+V9Mb5yS621OT_=d05YbWtbCW5H362myA@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: menu: Handle stopped tick more aggressively
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:20 AM <leo.yan@linaro.org> wrote:
>
> On Fri, Aug 10, 2018 at 09:57:18AM +0200, Rafael J . Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] cpuidle: menu: Handle stopped tick more aggressively
> >
> > Commit 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states
> > with stopped tick) missed the case when the target residencies of
> > deep idle states of CPUs are above the tick boundary which may cause
> > the CPU to get stuck in a shallow idle state for a long time.
> >
> > Say there are two CPU idle states available: one shallow, with the
> > target residency much below the tick boundary and one deep, with
> > the target residency significantly above the tick boundary.  In
> > that case, if the tick has been stopped already and the expected
> > next timer event is relatively far in the future, the governor will
> > assume the idle duration to be equal to TICK_USEC and it will select
> > the idle state for the CPU accordingly.  However, that will cause the
> > shallow state to be selected even though it would have been more
> > energy-efficient to select the deep one.
> >
> > To address this issue, modify the governor to always assume idle
> > duration to be equal to the time till the closest timer event if
> > the tick is not running which will cause the selected idle states
> > to always match the known CPU wakeup time.
> >
> > Also make it always indicate that the tick should be stopped in
> > that case for consistency.
> >
> > Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> > Reported-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > -> v2: Initialize first_idx properly in the stopped tick case.
> >
> > ---
> >  drivers/cpuidle/governors/menu.c |   55 +++++++++++++++++----------------------
> >  1 file changed, 25 insertions(+), 30 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > @@ -285,9 +285,8 @@ static int menu_select(struct cpuidle_dr
> >  {
> >       struct menu_device *data = this_cpu_ptr(&menu_devices);
> >       int latency_req = cpuidle_governor_latency_req(dev->cpu);
> > -     int i;
> > -     int first_idx;
> > -     int idx;
> > +     int first_idx = 0;
> > +     int idx, i;
> >       unsigned int interactivity_req;
> >       unsigned int expected_interval;
> >       unsigned long nr_iowaiters, cpu_load;
> > @@ -307,6 +306,18 @@ static int menu_select(struct cpuidle_dr
> >       /* determine the expected residency time, round up */
> >       data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
> >
> > +     /*
> > +      * If the tick is already stopped, the cost of possible short idle
> > +      * duration misprediction is much higher, because the CPU may be stuck
> > +      * in a shallow idle state for a long time as a result of it.  In that
> > +      * case say we might mispredict and use the known time till the closest
> > +      * timer event for the idle state selection.
> > +      */
> > +     if (tick_nohz_tick_stopped()) {
> > +             data->predicted_us = ktime_to_us(delta_next);
> > +             goto select;
> > +     }
> > +
>
> This introduce two potential issues:
>
> - This will totally ignore the typical pattern in idle loop; I
>   observed on the mmc driver can trigger multiple times (> 10 times)
>   with consistent interval;

I'm not sure what you mean by "ignore".

>  but I have no strong opinion to not  use next timer event for this case.

OK

> - Will this break correction factors when the CPU exit from idle?
>   data->bucket is stale value ....

Good point.

I'll send a v3 with this addressed.

>
> >       get_iowait_load(&nr_iowaiters, &cpu_load);
> >       data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
> >
> > @@ -322,7 +333,6 @@ static int menu_select(struct cpuidle_dr
> >       expected_interval = get_typical_interval(data);
> >       expected_interval = min(expected_interval, data->next_timer_us);
> >
> > -     first_idx = 0;
> >       if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
> >               struct cpuidle_state *s = &drv->states[1];
> >               unsigned int polling_threshold;
> > @@ -344,29 +354,15 @@ static int menu_select(struct cpuidle_dr
> >        */
> >       data->predicted_us = min(data->predicted_us, expected_interval);
> >
> > -     if (tick_nohz_tick_stopped()) {
> > -             /*
> > -              * If the tick is already stopped, the cost of possible short
> > -              * idle duration misprediction is much higher, because the CPU
> > -              * may be stuck in a shallow idle state for a long time as a
> > -              * result of it.  In that case say we might mispredict and try
> > -              * to force the CPU into a state for which we would have stopped
> > -              * the tick, unless a timer is going to expire really soon
> > -              * anyway.
> > -              */
> > -             if (data->predicted_us < TICK_USEC)
> > -                     data->predicted_us = min_t(unsigned int, TICK_USEC,
> > -                                                ktime_to_us(delta_next));
> > -     } else {
> > -             /*
> > -              * Use the performance multiplier and the user-configurable
> > -              * latency_req to determine the maximum exit latency.
> > -              */
> > -             interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> > -             if (latency_req > interactivity_req)
> > -                     latency_req = interactivity_req;
> > -     }
> > +     /*
> > +      * Use the performance multiplier and the user-configurable latency_req
> > +      * to determine the maximum exit latency.
> > +      */
> > +     interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> > +     if (latency_req > interactivity_req)
> > +             latency_req = interactivity_req;
> >
> > +select:
> >       expected_interval = data->predicted_us;
> >       /*
> >        * Find the idle state with the lowest power while satisfying
> > @@ -403,14 +399,13 @@ static int menu_select(struct cpuidle_dr
> >        * Don't stop the tick if the selected state is a polling one or if the
> >        * expected idle duration is shorter than the tick period length.
> >        */
> > -     if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> > -         expected_interval < TICK_USEC) {
> > +     if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> > +         expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
>
> I am not sure this logic is right... Why not use below checking, so
> for POLLING state we will never ask to stop the tick?
>
>         if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING ||
>             (expected_interval < TICK_USEC && !tick_nohz_tick_stopped())) {
>

The only effect of it would be setting stop_tick to false, but why
would that matter?

> >               unsigned int delta_next_us = ktime_to_us(delta_next);
> >
> >               *stop_tick = false;
> >
> > -             if (!tick_nohz_tick_stopped() && idx > 0 &&
> > -                 drv->states[idx].target_residency > delta_next_us) {
> > +             if (idx > 0 && drv->states[idx].target_residency > delta_next_us) {
> >                       /*
> >                        * The tick is not going to be stopped and the target
> >                        * residency of the state to be returned is not within
> >
