Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F16C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9351223E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJOoeAp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9351223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeHJPBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:01:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37656 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeHJPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:01:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so1721766wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FiE5IGY323sVGK0udjVwlBPjl49o/lrmmVN6Z1JzxMI=;
        b=QJOoeAp609hXy1Py1B5E73nbzDAjiSwG+nt9UDLV9gVk7oZTx1I3zIqU2rGqL6t1U5
         /qAqIkd+BpMa40FvRzG6Q/JJEf4EeA9rUTUD1u2FFnjeZZXJv1RMUc9z75o/ZrCutg9f
         3qrQCIHx7461bd66TBfvZNJ4uSEu6PUgac4f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FiE5IGY323sVGK0udjVwlBPjl49o/lrmmVN6Z1JzxMI=;
        b=npPjW4nT53Y9/X6FD/IWHLFIEqdaWI9S47S7NSOEu6FfrvXd+S1/Mn2zajRFkrIX6F
         OMftG2MwhuFvqt+x6WPZkCU/WWzqkQObLSt5deZ97TCPrvWk23+xWYvu1Dzr2rSTVDGT
         m7Ou3sJEWDcq7Vc8qaVCPeEmEAqVVhn1wgOiGvCISDVfnij0fgGM+FOK/oMZIEhqS7x/
         gADc+e8ViztTU9kLikn911Vlccq2/cZYbHV4h+xEioSJTfLypP6i+/8Zm8nL+G7l86w2
         mdW4q3ThykZ7Dl+FyzDQ1lAOZGyZ7bii/XFn4HpmMQVS5wAR7PHP6VbM7pZYkzdnhdMW
         FPsw==
X-Gm-Message-State: AOUpUlE4pNkdDjP5rfYMGL+OqA2qPRHiDubafrYqYqA6bLCAJeOW9rAD
        4cFi6BOpKFQW4VyrjUOLTfQUPZVDlgM1qLFg
X-Google-Smtp-Source: AA+uWPzy9fV5KjTwVXiByoN8kVUHRLqCe/0IwsqN/+XPS77ZmuXefsogTJyESFaM2ctzl+HyJmNcNQ==
X-Received: by 2002:a1c:6f06:: with SMTP id k6-v6mr1358480wmc.1.1533904317297;
        Fri, 10 Aug 2018 05:31:57 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id w8-v6sm8510230wrp.72.2018.08.10.05.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 05:31:56 -0700 (PDT)
Date:   Fri, 10 Aug 2018 20:31:43 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2] cpuidle: menu: Handle stopped tick more aggressively
Message-ID: <20180810123143.GG11817@leoy-ThinkPad-X240s>
References: <1951009.1jlQfyrxio@aspire.rjw.lan>
 <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <20180810092034.GF11817@leoy-ThinkPad-X240s>
 <CAJZ5v0h8T99pqhNoj+V9Mb5yS621OT_=d05YbWtbCW5H362myA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h8T99pqhNoj+V9Mb5yS621OT_=d05YbWtbCW5H362myA@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 01:04:22PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 10, 2018 at 11:20 AM <leo.yan@linaro.org> wrote:
> >
> > On Fri, Aug 10, 2018 at 09:57:18AM +0200, Rafael J . Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Subject: [PATCH] cpuidle: menu: Handle stopped tick more aggressively
> > >
> > > Commit 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states
> > > with stopped tick) missed the case when the target residencies of
> > > deep idle states of CPUs are above the tick boundary which may cause
> > > the CPU to get stuck in a shallow idle state for a long time.
> > >
> > > Say there are two CPU idle states available: one shallow, with the
> > > target residency much below the tick boundary and one deep, with
> > > the target residency significantly above the tick boundary.  In
> > > that case, if the tick has been stopped already and the expected
> > > next timer event is relatively far in the future, the governor will
> > > assume the idle duration to be equal to TICK_USEC and it will select
> > > the idle state for the CPU accordingly.  However, that will cause the
> > > shallow state to be selected even though it would have been more
> > > energy-efficient to select the deep one.
> > >
> > > To address this issue, modify the governor to always assume idle
> > > duration to be equal to the time till the closest timer event if
> > > the tick is not running which will cause the selected idle states
> > > to always match the known CPU wakeup time.
> > >
> > > Also make it always indicate that the tick should be stopped in
> > > that case for consistency.
> > >
> > > Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> > > Reported-by: Leo Yan <leo.yan@linaro.org>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > -> v2: Initialize first_idx properly in the stopped tick case.
> > >
> > > ---
> > >  drivers/cpuidle/governors/menu.c |   55 +++++++++++++++++----------------------
> > >  1 file changed, 25 insertions(+), 30 deletions(-)
> > >
> > > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > > @@ -285,9 +285,8 @@ static int menu_select(struct cpuidle_dr
> > >  {
> > >       struct menu_device *data = this_cpu_ptr(&menu_devices);
> > >       int latency_req = cpuidle_governor_latency_req(dev->cpu);
> > > -     int i;
> > > -     int first_idx;
> > > -     int idx;
> > > +     int first_idx = 0;
> > > +     int idx, i;
> > >       unsigned int interactivity_req;
> > >       unsigned int expected_interval;
> > >       unsigned long nr_iowaiters, cpu_load;
> > > @@ -307,6 +306,18 @@ static int menu_select(struct cpuidle_dr
> > >       /* determine the expected residency time, round up */
> > >       data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
> > >
> > > +     /*
> > > +      * If the tick is already stopped, the cost of possible short idle
> > > +      * duration misprediction is much higher, because the CPU may be stuck
> > > +      * in a shallow idle state for a long time as a result of it.  In that
> > > +      * case say we might mispredict and use the known time till the closest
> > > +      * timer event for the idle state selection.
> > > +      */
> > > +     if (tick_nohz_tick_stopped()) {
> > > +             data->predicted_us = ktime_to_us(delta_next);
> > > +             goto select;
> > > +     }
> > > +
> >
> > This introduce two potential issues:
> >
> > - This will totally ignore the typical pattern in idle loop; I
> >   observed on the mmc driver can trigger multiple times (> 10 times)
> >   with consistent interval;
> 
> I'm not sure what you mean by "ignore".

You could see after move code from blow to this position, the typical
pattern interval will not be accounted; so if in the middle of idles
there have a bunch of interrupts with fix pattern, the upper code
cannot detect this pattern anymore.

[...]

> > > -     if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> > > -         expected_interval < TICK_USEC) {
> > > +     if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> > > +         expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
> >
> > I am not sure this logic is right... Why not use below checking, so
> > for POLLING state we will never ask to stop the tick?
> >
> >         if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING ||
> >             (expected_interval < TICK_USEC && !tick_nohz_tick_stopped())) {
> >
> 
> The only effect of it would be setting stop_tick to false, but why
> would that matter?

Please consider below situation, not sure if this case is existed or
not:

  step1: first time: enter one idle state with stopping tick;
  step2: second time: select POLLING state and tick_nohz_tick_stopped()
  is true;

So in step2, it cannot set stop_tick to false with below sentence.

> > >               unsigned int delta_next_us = ktime_to_us(delta_next);
> > >
> > >               *stop_tick = false;

[...]

Thanks,
Leo Yan
