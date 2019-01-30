Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E831C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74E720857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+1VduTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbfA3NTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:19:02 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37122 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbfA3NTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:19:01 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so10411394iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANeoDmbUb0/8sfBPLXSO9VTANf6KaL0CAlPTKb85IhY=;
        b=O+1VduTU8SIV7R/owFlkvbSyLNgk4wSG1UWLtjayt3FHHoiS0yDasSfXaW5Zi09NcF
         I64aRLi22tdK7lmm5OdRLkFlyjZLM7BuC4OWPYo9pS1JhObF3ebmSIw8hw1jnir/sXov
         K/eyBOlOIpjz+6lPeDxiAegTHCTpQFAyNgYTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANeoDmbUb0/8sfBPLXSO9VTANf6KaL0CAlPTKb85IhY=;
        b=h6FmyuF/VGoUcmInTR95D9MlpsTfR4/nhXRnMzw+PQlVtXo8jSb9/mkUezzqQ1P6m+
         exR0pmnCP2YFQjeBq6EptvuVGeH3cERvTj4csjcfKZTujYQELrAp+sGEHlkUId4uYkSG
         tovTFtfJKv6BM02x66fkcl0uVFqbdo4gz9sJtzqdyyI8xLuj2+K/P/2VuEtBbYFGskqU
         ueLZvOQxYoo00fCVIBi519Wd9ys5k3OnYyOgpy1+XMcqEZPx1LzV4h4j+WutUcUWNIE0
         Q4fFSdpykj88bULvQPWL0S0gHKx8szuogkcTk2yIqo946tnsuqyYYZBq9VtET92wQouf
         KONA==
X-Gm-Message-State: AJcUukfXmrhqOQa3yuyc8Fogms43uZdDOcVjMEFNS9YyuUn3VYD1JfhJ
        VIlN5gA7TwAbs2uCwB+ucgTdAizq3tU58dHnxhSM8w==
X-Google-Smtp-Source: ALg8bN62J/QuGU0am7/BE/gEge7sczYQSEz/4n1yumxu6JS3Qag/8Pz+XpFV9jXdxAbQerhtFMwQAS6oPrmrbI7gDUA=
X-Received: by 2002:a02:6019:: with SMTP id i25mr19758965jac.137.1548854340418;
 Wed, 30 Jan 2019 05:19:00 -0800 (PST)
MIME-Version: 1.0
References: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org> <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
In-Reply-To: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Jan 2019 14:18:49 +0100
Message-ID: <CAKfTPtAO--5rkKAwExbKoKDz9pM7MApbEqe0R9pS1-1avv2Gzw@mail.gmail.com>
Subject: Re: [PATCH v2 ] PM-runtime: fix deadlock with ktime
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Ladislav Michl <ladis@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 at 14:06, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 30, 2019 at 12:16 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > The call path is:
> > change_clocksource
> >     ...
> >     write_seqcount_begin
> >     ...
> >     timekeeping_update
> >         ...
> >         sh_cmt_clocksource_enable
> >             ...
> >             rpm_resume
> >                 pm_runtime_mark_last_busy
> >                     ktime_get
> >                         do
> >                             read_seqcount_begin
> >                         while read_seqcount_retry
> >     ....
> >     write_seqcount_end
> >
> > Although we should be safe because we haven't yet changed the clocksource
> > at that time, we can't because of seqcount protection.
> >
> > Use ktime_get_mono_fast_ns() instead which is lock safe for such case
> >
> > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > monotonic across an update and as a result can goes backward. According to
> > update_fast_timekeeper() description: "In the worst case, this can
> > result is a slightly wrong timestamp (a few nanoseconds)". For
> > PM runtime autosuspend, this means only that the suspend decision can
> > be slightly sub optimal.
> >
> > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> I've queued this one up as a fix for 5.0, but unfortunately it clashes
> with the patch from Ladislav Michl at
> https://patchwork.kernel.org/patch/10755477/ which has been dropped
> now.

Thanks for adding Ladislav in this thread.
I'm sorry I forgot to add him in the loop.

>
> Can you or Ladislav please rebase that patch on top of this one and repost?

Ladislav,

Let me know if you prefer to rebase and repost your patch of if you
want me to do.

Regards,
Vincent

>
> > ---
> >
> > - v2: Updated commit message to explain the impact of using
> >   ktime_get_mono_fast_ns()
> >
> >  drivers/base/power/runtime.c | 10 +++++-----
> >  include/linux/pm_runtime.h   |  2 +-
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 457be03..708a13f 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -130,7 +130,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
> >  {
> >         int autosuspend_delay;
> >         u64 last_busy, expires = 0;
> > -       u64 now = ktime_to_ns(ktime_get());
> > +       u64 now = ktime_get_mono_fast_ns();
> >
> >         if (!dev->power.use_autosuspend)
> >                 goto out;
> > @@ -909,7 +909,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
> >          * If 'expires' is after the current time, we've been called
> >          * too early.
> >          */
> > -       if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
> > +       if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
> >                 dev->power.timer_expires = 0;
> >                 rpm_suspend(dev, dev->power.timer_autosuspends ?
> >                     (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
> > @@ -928,7 +928,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
> >  int pm_schedule_suspend(struct device *dev, unsigned int delay)
> >  {
> >         unsigned long flags;
> > -       ktime_t expires;
> > +       u64 expires;
> >         int retval;
> >
> >         spin_lock_irqsave(&dev->power.lock, flags);
> > @@ -945,8 +945,8 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
> >         /* Other scheduled or pending requests need to be canceled. */
> >         pm_runtime_cancel_pending(dev);
> >
> > -       expires = ktime_add(ktime_get(), ms_to_ktime(delay));
> > -       dev->power.timer_expires = ktime_to_ns(expires);
> > +       expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC);
> > +       dev->power.timer_expires = expires;
> >         dev->power.timer_autosuspends = 0;
> >         hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
> >
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index 54af4ee..fed5be7 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -105,7 +105,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
> >
> >  static inline void pm_runtime_mark_last_busy(struct device *dev)
> >  {
> > -       WRITE_ONCE(dev->power.last_busy, ktime_to_ns(ktime_get()));
> > +       WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
> >  }
> >
> >  static inline bool pm_runtime_is_irq_safe(struct device *dev)
> > --
> > 2.7.4
> >
