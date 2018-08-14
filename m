Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6C1C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F2B21728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F2B21728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbeHNUPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:15:10 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39157 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388032AbeHNUPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:15:09 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so35075914oib.6;
        Tue, 14 Aug 2018 10:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXyZOrz5e1uZi5nXP6kjm4ly1UTSD/ZM9t2cSSD9+8w=;
        b=iIUQOz67WIIkHUqmZKODTPnlyyBL9soadjG1+tNfFRmGQLVZtKBfHvpkAVqrg0BNwD
         uR1CHRuDeUsQ7wmMERk7Kp3scR/5e6/EyxYwYnHh3EvmrESqXMn/Xp9Xfdq22sOkYruv
         UfkOfGprYF0s4oZCSqJra6YkjWSEQfpV7thh1TWVYIVHist6xZdEcomq0kf4VbBmoZe+
         tCxpykTjI34pDOo/tKNFnxFM5JIkz/I8y7pc+bC3CSeR3AXgATJIO2uHRrCa5NiAGKba
         vOa1+FneaslrMErz2urMSiivdX68SJU4mI0+d5iUWlYUcukLy84W8xycg2CmsM/3n0ZR
         GzWg==
X-Gm-Message-State: AOUpUlG9hC7STQ9zASuvokf3zIRDJtvjZ8+SueVzWfaZR6OTfvZ89ugZ
        z1LtiQaeKkVacY4F7bNTN3IH7+ZPcW7x4cyE1yOIxw==
X-Google-Smtp-Source: AA+uWPyxgQpTkqmTzdOUnl+gCYFhwx7bHYmI0P1f4NRCEIYiN2Pt/CiS2yJtwxMFgfcblsvLkEZGWsaQcQbI/+9ACiU=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr23844776oie.174.1534267622572;
 Tue, 14 Aug 2018 10:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <1951009.1jlQfyrxio@aspire.rjw.lan> <1754612.IcCR94pSYR@aspire.rjw.lan>
 <1582055.9b67urWYFa@aspire.rjw.lan> <1572343.jWaXB8XNF1@aspire.rjw.lan> <20180814154441.GA13920@leoy-ThinkPad-X240s>
In-Reply-To: <20180814154441.GA13920@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Aug 2018 19:26:50 +0200
Message-ID: <CAJZ5v0gUCLUe-Hz02upZTti3RUDd7fZNpzEOAJEdLW95OgzL1Q@mail.gmail.com>
Subject: Re: [PATCH v5] cpuidle: menu: Handle stopped tick more aggressively
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

On Tue, Aug 14, 2018 at 5:44 PM <leo.yan@linaro.org> wrote:
>
> On Tue, Aug 14, 2018 at 12:34:40PM +0200, Rafael J . Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
> > To address this issue, modify the governor to always use the time
> > till the closest timer event instead of the predicted idle duration
> > if the latter is less than the tick period length and the tick has
> > been stopped already.  Also make it extend the search for a matching
> > idle state if the tick is stopped to avoid settling on a shallow
> > state if deep states with target residencies above the tick period
> > length are available.
> >
> > In addition, make it always indicate that the tick should be stopped
> > if it has been stopped already for consistency.
> >
> > Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> > Reported-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > -> v2: Initialize first_idx properly in the stopped tick case.
> >
> > v2 -> v3: Compute data->bucket before checking whether or not the tick has been
> >           stopped already to prevent it from becoming stale.
> >
> > v3 -> v4: Allow the usual state selection to be carried out if the tick has been
> >           stopped in case the predicted idle duration is greater than the tick
> >           period length and a matching state can be found without overriding
> >           the prediction result.
> >
> > v4 -> v5: Rework code to be more straightforward.  Functionally, it should
> >           behave like the v4.
> > ---
> >  drivers/cpuidle/governors/menu.c |   36 ++++++++++++++++++++++++------------
> >  1 file changed, 24 insertions(+), 12 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > @@ -349,14 +349,12 @@ static int menu_select(struct cpuidle_dr
> >                * If the tick is already stopped, the cost of possible short
> >                * idle duration misprediction is much higher, because the CPU
> >                * may be stuck in a shallow idle state for a long time as a
> > -              * result of it.  In that case say we might mispredict and try
> > -              * to force the CPU into a state for which we would have stopped
> > -              * the tick, unless a timer is going to expire really soon
> > -              * anyway.
> > +              * result of it.  In that case say we might mispredict and use
> > +              * the known time till the closest timer event for the idle
> > +              * state selection.
> >                */
> >               if (data->predicted_us < TICK_USEC)
> > -                     data->predicted_us = min_t(unsigned int, TICK_USEC,
> > -                                                ktime_to_us(delta_next));
> > +                     data->predicted_us = ktime_to_us(delta_next);
> >       } else {
> >               /*
> >                * Use the performance multiplier and the user-configurable
> > @@ -381,8 +379,22 @@ static int menu_select(struct cpuidle_dr
> >                       continue;
> >               if (idx == -1)
> >                       idx = i; /* first enabled state */
> > -             if (s->target_residency > data->predicted_us)
> > -                     break;
> > +             if (s->target_residency > data->predicted_us) {
> > +                     if (!tick_nohz_tick_stopped())
> > +                             break;
> > +
> > +                     /*
> > +                      * If the state selected so far is shallow and this
> > +                      * state's target residency matches the time till the
> > +                      * closest timer event, select this one to avoid getting
> > +                      * stuck in the shallow one for too long.
> > +                      */
> > +                     if (drv->states[idx].target_residency < TICK_USEC &&
> > +                         s->target_residency <= ktime_to_us(delta_next))
> > +                             idx = i;
>
> I took some time to understand v4 and v5; now I understand you want to
> prompt to deeper idle state if the prediction falls in the range
> between [TICK_USEC..max_target_residency).  This seems to me is a
> huristics method but not general enough and IMHO this is more difficult
> for code readable.
>
> I agree this patch can resolve the issue you mentioned in the commit
> log, but this patch will be fragile for below case, so it will select
> state1 but not state2, how about you think for this case?

It is OK to select state1 in this case IMO, because if the tick had
not been stopped already, it would have been stopped after selecting
state1 anyway (it is not a "polling" state and expected_interval is
not below TICK_USEC).

> Idle_state0::
> target_residency   TICK_USEC   Prediction
>     |                 |       /
>     V                 V      /
> -----------------------------------------------------> Time length
>                                 ^                 ^
>                                 |                 |
>                             Idle_state1:       Idle_state2:
>                             target_residency   target_residency
>

Basically, the idea is to avoid getting stuck in the idle states for
which the tick would not have been stopped, had it been still running.
