Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00343C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F0F20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbfA3Tjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:39:31 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:38660 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387587AbfA3Tjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:39:31 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992819AbfA3Tj05RT5K (ORCPT
        <rfc822;linux-renesas-soc@vger.kernel.org> + 3 others);
        Wed, 30 Jan 2019 20:39:26 +0100
Date:   Wed, 30 Jan 2019 20:39:25 +0100
From:   Ladislav Michl <ladis@linux-mips.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 ] PM-runtime: fix deadlock with ktime
Message-ID: <20190130193925.GA11090@lenoch>
References: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
 <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <CAKfTPtAO--5rkKAwExbKoKDz9pM7MApbEqe0R9pS1-1avv2Gzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAO--5rkKAwExbKoKDz9pM7MApbEqe0R9pS1-1avv2Gzw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 02:18:49PM +0100, Vincent Guittot wrote:
> On Wed, 30 Jan 2019 at 14:06, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Jan 30, 2019 at 12:16 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > > The call path is:
> > > change_clocksource
> > >     ...
> > >     write_seqcount_begin
> > >     ...
> > >     timekeeping_update
> > >         ...
> > >         sh_cmt_clocksource_enable
> > >             ...
> > >             rpm_resume
> > >                 pm_runtime_mark_last_busy
> > >                     ktime_get
> > >                         do
> > >                             read_seqcount_begin
> > >                         while read_seqcount_retry
> > >     ....
> > >     write_seqcount_end
> > >
> > > Although we should be safe because we haven't yet changed the clocksource
> > > at that time, we can't because of seqcount protection.
> > >
> > > Use ktime_get_mono_fast_ns() instead which is lock safe for such case
> > >
> > > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > > monotonic across an update and as a result can goes backward. According to
> > > update_fast_timekeeper() description: "In the worst case, this can
> > > result is a slightly wrong timestamp (a few nanoseconds)". For
> > > PM runtime autosuspend, this means only that the suspend decision can
> > > be slightly sub optimal.
> > >
> > > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > I've queued this one up as a fix for 5.0, but unfortunately it clashes
> > with the patch from Ladislav Michl at
> > https://patchwork.kernel.org/patch/10755477/ which has been dropped
> > now.
> 
> Thanks for adding Ladislav in this thread.
> I'm sorry I forgot to add him in the loop.
> 
> >
> > Can you or Ladislav please rebase that patch on top of this one and repost?
> 
> Ladislav,
> 
> Let me know if you prefer to rebase and repost your patch of if you
> want me to do.

I'll rebase it on top of Rafael's bleeding-edge branch.

Best regards,
	ladis

> Regards,
> Vincent
> 
> >
> > > ---
> > >
> > > - v2: Updated commit message to explain the impact of using
> > >   ktime_get_mono_fast_ns()
> > >
> > >  drivers/base/power/runtime.c | 10 +++++-----
> > >  include/linux/pm_runtime.h   |  2 +-
> > >  2 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 457be03..708a13f 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -130,7 +130,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
> > >  {
> > >         int autosuspend_delay;
> > >         u64 last_busy, expires = 0;
> > > -       u64 now = ktime_to_ns(ktime_get());
> > > +       u64 now = ktime_get_mono_fast_ns();
> > >
> > >         if (!dev->power.use_autosuspend)
> > >                 goto out;
> > > @@ -909,7 +909,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
> > >          * If 'expires' is after the current time, we've been called
> > >          * too early.
> > >          */
> > > -       if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
> > > +       if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
> > >                 dev->power.timer_expires = 0;
> > >                 rpm_suspend(dev, dev->power.timer_autosuspends ?
> > >                     (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
> > > @@ -928,7 +928,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
> > >  int pm_schedule_suspend(struct device *dev, unsigned int delay)
> > >  {
> > >         unsigned long flags;
> > > -       ktime_t expires;
> > > +       u64 expires;
> > >         int retval;
> > >
> > >         spin_lock_irqsave(&dev->power.lock, flags);
> > > @@ -945,8 +945,8 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
> > >         /* Other scheduled or pending requests need to be canceled. */
> > >         pm_runtime_cancel_pending(dev);
> > >
> > > -       expires = ktime_add(ktime_get(), ms_to_ktime(delay));
> > > -       dev->power.timer_expires = ktime_to_ns(expires);
> > > +       expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC);
> > > +       dev->power.timer_expires = expires;
> > >         dev->power.timer_autosuspends = 0;
> > >         hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
> > >
> > > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > > index 54af4ee..fed5be7 100644
> > > --- a/include/linux/pm_runtime.h
> > > +++ b/include/linux/pm_runtime.h
> > > @@ -105,7 +105,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
> > >
> > >  static inline void pm_runtime_mark_last_busy(struct device *dev)
> > >  {
> > > -       WRITE_ONCE(dev->power.last_busy, ktime_to_ns(ktime_get()));
> > > +       WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
> > >  }
> > >
> > >  static inline bool pm_runtime_is_irq_safe(struct device *dev)
> > > --
> > > 2.7.4
> > >
