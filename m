Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA1AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FB6208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FB6208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeHWA1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:27:50 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39229 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeHWA1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:27:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so5585508oig.6;
        Wed, 22 Aug 2018 14:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0L5E7TaaOy4i6U+TsDbyuvuPp/fP6snswDj8ZGW4IXs=;
        b=G49c1aMFnc/oy1WVjnfzjGlwJaP38tKgV1ksyM+KxLubmNN9V4yrJjJ16UnXpJM5xC
         hUDvXPbFW42PibGl7qRFPqTYRqCsiYGrSNYP4X5bvxLhcKTw1pzda5a7p9Hha467la2Z
         f9k8cvzQ7XNjNCyZZ5Yr8zESjmiE1i9lJ15r4HOK71mcjBorlS2E+0PwHJuMc1vG4CeV
         Bb+GZgLaRXSJy58ArtvIRZE0huBBDWuiYcOZtg3D9pStJH3Au1Ckjs+IpsJG0CpZCb+R
         yn1WdW6vKQQRyR+f8o1UG7JyX+01Is6ykl61AcgQRWLSuDT4Qab34dlYomnc68l9icoV
         4LdA==
X-Gm-Message-State: APzg51DKSwQMgxwKIrATxfcWM+vJM1GH3DE05QxAl/uj0H19Bs/jrRKA
        g3qKIlVlgBhktiZwXp9KcjKka+OJUT6YSSM6TEM=
X-Google-Smtp-Source: ANB0VdalbEqHsF0YMcAGsvnl18okCPnMH8QMFvcoK24Jqnh7RTfziDjqTuI7mwxHddE7HeR40Uk11YcvntYv3/zv8yQ=
X-Received: by 2002:aca:aa06:: with SMTP id t6-v6mr5874781oie.152.1534971680809;
 Wed, 22 Aug 2018 14:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <34910476.pgRhNDWo5t@aspire.rjw.lan> <20180822120200.GA8949@leoy-ThinkPad-X240s>
In-Reply-To: <20180822120200.GA8949@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Aug 2018 23:01:09 +0200
Message-ID: <CAJZ5v0haxngVxKtj=HWYoEJYf8F7=ZEsGuQpqpaJsAMW=BxeMw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: menu: Retain tick when shallow state is selected
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 2:02 PM <leo.yan@linaro.org> wrote:
>
> On Tue, Aug 21, 2018 at 10:44:10AM +0200, Rafael J . Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The case addressed by commit 5ef499cd571c (cpuidle: menu: Handle
> > stopped tick more aggressively) in the stopped tick case is present
> > when the tick has not been stopped yet too.  Namely, if only two CPU
> > idle states, shallow state A with target residency significantly
> > below the tick boundary and deep state B with target residency
> > significantly above it, are available and the predicted idle
> > duration is above the tick boundary, but below the target residency
> > of state B, state A will be selected and the CPU may spend indefinite
> > amount of time in it, which is not quite energy-efficient.
> >
> > However, if the tick has not been stopped yet and the governor is
> > about to select a shallow idle state for the CPU even though the idle
> > duration predicted by it is above the tick boundary, it should be
> > fine to wake up the CPU early, so the tick can be retained then and
> > the governor will have a chance to select a deeper state when it runs
> > next time.
> >
> > [Note that when this really happens, it will make the idle duration
> >  predictor believe that the CPU might be idle longer than predicted,
> >  which will make it more likely to predict longer idle durations going
> >  forward, but that will also cause deeper idle states to be selected
> >  going forward, on average, which is what's needed here.]
> >
> > Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> > Reported-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Commit 5ef499cd571c (cpuidle: menu: Handle stopped tick more aggressively) is
> > in linux-next only at this point.
> >
> > ---
> >  drivers/cpuidle/governors/menu.c |   13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > @@ -379,9 +379,20 @@ static int menu_select(struct cpuidle_dr
> >               if (idx == -1)
> >                       idx = i; /* first enabled state */
> >               if (s->target_residency > data->predicted_us) {
> > -                     if (!tick_nohz_tick_stopped())
> > +                     if (data->predicted_us < TICK_USEC)
>
> With this change, for tick has been stopped, it might introduce
> regression to select a shallow state and it's conflict with the effect
> of patch "cpuidle: menu: Handle stopped tick more aggressively".

How so?

If the tick has been stopped already, predicted_us cannot be less than
TICK_USEC unless it is equal to delta_next (in usec), but if it is
equal to delta_next, s->target_residency cannot be less than or equal
to the latter, because it is greater than predicted_us, so idx would
not be updated even without this change.  I don't see a change in
behavior in the stopped tick case resulting from this patch.

> >                               break;
> >
> > +                     if (!tick_nohz_tick_stopped()) {
> > +                             /*
> > +                              * If the state selected so far is shallow,
> > +                              * waking up early won't hurt, so retain the
> > +                              * tick in that case and let the governor run
> > +                              * again in the next iteration of the loop.
> > +                              */
> > +                             expected_interval = drv->states[idx].target_residency;
> > +                             break;
> > +                     }
> > +
>
> This is reliable, how we can rely on a shallow idle state target
> residency to decide if need to stop a tick or not?

If the target residency of this state is beyond the tick boundary, it
obviously is necessary to stop the tick in order to use it.
Conversely, if its target residency is within the tick boundary, there
is no reason to stop the tick (the state is not the deepest one
available and its target residency is short enough).  This is
analogous to the case in which the loop is terminated for latency
reasons.

> >                       /*
> >                        * If the state selected so far is shallow and this
> >                        * state's target residency matches the time till the
> >
