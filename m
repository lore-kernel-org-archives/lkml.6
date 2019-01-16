Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355CFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCCE20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547636397;
	bh=qg+6lweRac2Nq1qrjxTGUxFWRsVQLzHvJI7LdOqgpZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mplsuSvP9wJCLCrZVMy1kK6mcPINGDR6+iRBlSUD6+tZPm2dF7aCmj2tV/12leVI0
	 Gpf0pBJIKMjKtAdE1Pj1Yz9usCG3uZh+NUyCTcH8cd3QBZ97CsHhtQZ2Kw0W1wgTMy
	 HmWDuqM4a4v8Pyv9lb4X5p+XsRbgT+8S7FM3jNT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404187AbfAPK7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:59:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42694 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfAPK7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:59:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id v23so6474608otk.9;
        Wed, 16 Jan 2019 02:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHfR6MSspEZgGbVRpl1BDS/NjahXMFlvuCYMnyKhzDE=;
        b=i6i/bqT3Q1VdCMzF9TEPnLqa7CVZrpww01+hfyBsnSRoB6whv/xi1KNb162Gb9TCGM
         yzPJ+CIgT2Q+NjemOFNOC5L2VnaAJX1Om5vF9lXtgdfrrEJVSzu8I6Dw8Itdi/v6hn1c
         BRU9KlBhAhw1iN7vPJkTP1xvC4aY8LU0KY42QYiDBbJIfz4RZ6EN0Ys4aFLwh3uBH07W
         WzN6RIjQRtCbYjytm1e3pWZc9c/2/lvZraKn4O0YeYFpAH+F80AitLT78zr7+wGBUdKv
         QaZwDAq18s/ogc0+PKk4L4oTtyTZz0Zqld6Tl1VXWZAMvnX1btPyGG2UOHX8GlNxPyDx
         suKg==
X-Gm-Message-State: AJcUukdYTm8cTGuY8fCr4RteJw1Bw5VtOdngu2kcCUdpH1tAUeXzHzi4
        6kfih6ZwlCFzgFgkXvTDK/Jnf226Mj4qkjqLInM=
X-Google-Smtp-Source: ALg8bN6Emiluo7F53vP8uR1p7jmx9ZaKwvhOHY4+2Xcl4gnUA1ou+D8pFSxvpXfAIOaE89/hc1dTBtE9o2Md2OTZ2Xg=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr5359631otg.139.1547636391974;
 Wed, 16 Jan 2019 02:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-4-ulf.hansson@linaro.org> <119031115.C8gHTGbYmQ@aspire.rjw.lan>
 <CAPDyKFqQQnMKFNpGyi_dkP_Rm8qo-1WjPfVkp2unOxyXRa2wbA@mail.gmail.com>
In-Reply-To: <CAPDyKFqQQnMKFNpGyi_dkP_Rm8qo-1WjPfVkp2unOxyXRa2wbA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Jan 2019 11:59:40 +0100
Message-ID: <CAJZ5v0iY7j5SThQhtq5xP+g5yNiHQ+cMWxq-tdVh3t5wJ_s3Tw@mail.gmail.com>
Subject: Re: [PATCH v10 03/27] timer: Export next wakeup time of a CPU
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 8:58 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 11 Jan 2019 at 12:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Thursday, November 29, 2018 6:46:36 PM CET Ulf Hansson wrote:
> > > From: Lina Iyer <lina.iyer@linaro.org>
> > >
> > > Knowing the sleep duration of CPUs, is known to be needed while selecting
> > > the most energy efficient idle state for a CPU or a group of CPUs.
> > >
> > > However, to be able to compute the sleep duration, we need to know at what
> > > time the next expected wakeup is for the CPU. Therefore, let's export this
> > > information via a new function, tick_nohz_get_next_wakeup(). Following
> > > changes make use of it.
> > >
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Cc: Lina Iyer <ilina@codeaurora.org>
> > > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > > Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v10:
> > >       - Updated function header of tick_nohz_get_next_wakeup().
> > >
> > > ---
> > >  include/linux/tick.h     |  8 ++++++++
> > >  kernel/time/tick-sched.c | 13 +++++++++++++
> > >  2 files changed, 21 insertions(+)
> > >
> > > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > > index 55388ab45fd4..e48f6b26b425 100644
> > > --- a/include/linux/tick.h
> > > +++ b/include/linux/tick.h
> > > @@ -125,6 +125,7 @@ extern bool tick_nohz_idle_got_tick(void);
> > >  extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
> > >  extern unsigned long tick_nohz_get_idle_calls(void);
> > >  extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
> > > +extern ktime_t tick_nohz_get_next_wakeup(int cpu);
> > >  extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
> > >  extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
> > >
> > > @@ -151,6 +152,13 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
> > >       *delta_next = TICK_NSEC;
> > >       return *delta_next;
> > >  }
> > > +
> > > +static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
> > > +{
> > > +     /* Next wake up is the tick period, assume it starts now */
> > > +     return ktime_add(ktime_get(), TICK_NSEC);
> > > +}
> > > +
> > >  static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
> > >  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
> > >
> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > index 69e673b88474..7a9166506503 100644
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -1089,6 +1089,19 @@ unsigned long tick_nohz_get_idle_calls(void)
> > >       return ts->idle_calls;
> > >  }
> > >
> > > +/**
> > > + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
> > > + * @cpu: the particular CPU to get next wake up for
> > > + *
> > > + * Called for idle CPUs only.
> > > + */
> > > +ktime_t tick_nohz_get_next_wakeup(int cpu)
> > > +{
> > > +     struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
> > > +
> > > +     return dev->next_event;
> > > +}
> > > +
> > >  static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
> > >  {
> > >  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> > >
> >
> > Well, I have concerns regarding this one.
> >
> > I don't believe it is valid to call this new function for non-idle CPUs and
> > the kerneldoc kind of says so, but the next patch doesn't actually prevent
> > it from being called for a non-idle CPU (at the time it is called in there
> > the target CPU may not be idle any more AFAICS).
>
> You are correct, but let me clarify things.
>
> We are calling this new API from the new genpd governor, which may
> have a cpumask indicating there is more than one CPU attached to its
> PM domain+sub-PM domains. In other words, we may call the API for
> another CPU than the one we are executing on.
>
> When the new genpd governor is called, all CPUs in the cpumask of the
> genpd in question, are already runtime suspended and will remain so
> throughout the decisions made by the governor.
>
> However, because of the race condition, which needs to be manged by
> the genpd backend driver and its corresponding FW, one of the CPU in
> the genpd cpumask could potentially wake up from idle when the genpd
> governor runs. However, as a part of exiting from idle, that CPU needs
> to wait for the call to pm_runtime_get_sync() to return before
> completing the exit patch of idle. This also means waiting for the
> genpd governor to finish.

OK, so the CPU spins on a spin lock inside of the idle loop with interrupts off.

> The point is, no matter what decision the governor takes under these
> circumstances, the genpd backend driver and its FW must manage this
> race condition during the last man standing. For PSCI OSI mode, it
> means that if a cluster idle state is suggested by Linux during these
> circumstances, it must be prevented and aborted.

I would suggest putting a comment to explain that somewhere as it is
not really obvious.

> >
> > In principle, the cpuidle core can store this value, say in struct
> > cpuidle_device of the given CPU, and expose a helper to access it from
> > genpd, but that would be extra overhead totally unnecessary on everthing
> > that doesn't use genpd for cpuidle.
> >
> > So maybe the driver could store it in its ->enter callback?  After all,
> > the driver knows that genpd is going to be used later.
>
> This would work, but it wouldn't really change much when it comes to
> the race condition described above.

No, it wouldn't make the race go away.

> Of course it would turn the code
> into being more cpuidle specific, which seems reasonable to me.
>
> Anyway, if I understand your suggestion, in principle it means
> changing $subject patch in such way that the API should not take "int
> cpu" as an in-parameter, but instead only use __this_cpu() to read out
> the next event for current idle CPU.

Yes.

> Additionally, we need another new cpuidle API, which genpd can call to
> retrieve a new per CPU "next event data" stored by the cpuidle driver
> from its ->enter() callback. Is this a correct interpretation of your
> suggestion?

Yes, it is.

Generally, something like "cpuidle, give me the wakeup time of this
CPU".  And it may very well give you 0 if the CPU has woken up
already. :-)
