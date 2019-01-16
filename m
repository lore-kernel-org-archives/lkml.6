Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924C3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0E520840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYTAD8m1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbfAPH6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:58:25 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44272 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388167AbfAPH6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:58:24 -0500
Received: by mail-ua1-f66.google.com with SMTP id d19so1847860uaq.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 23:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+PBc3wsOLctO6i6bccsq2QFl7l9psdui1/+ZOVxUEM=;
        b=jYTAD8m1/DkSLKYtrAzSwVvdl9mfCR8qA8ML+IIJwSd7DI0OCWjV05urTPESb2X6E/
         ZNrqD47CbCCwqOEPPKmk9qw9NfQ8K80zPdOG3JVX/k4JlemeQjTddLS6hzPLfX762hBY
         /tsdG6HOhUsVtJjXyXm+DMJWtOQr3lw1VE8yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+PBc3wsOLctO6i6bccsq2QFl7l9psdui1/+ZOVxUEM=;
        b=uiZZZGMdj3kaaTIimi3vr9Qj+O4F4fhoH9vzmiaxGPH6rtdpiAE+Q0sx2bsbUQnc+q
         PkLkGqQYi3GE48IPJTfCsvTik68SqgyKdjO6m0UX0Yj9oyQAHk7CVwthEIYZwoxp1LrR
         lEyKz2LllpgzYHPNw6oija6uOpCCiOeFauWv0nPZ49SwigbTkqcrKsoq6olEzURK5XeC
         tiQDYaJa8MEi58AuIDyCICD50VdDAwwDj+U1plXo+D0QxkAhRbJaFj/r5T/+earvSjkE
         MFjFYxkruuxDpH0WsTptqqyPvSrL/zlg3CmR7SbM+IZSQAyx+hrs509+3842BjIOtyim
         clcA==
X-Gm-Message-State: AJcUukeXvjFNaIrR77zNPiqIIXPGnw+H4Q+l0WCPHJ1KKrqIvO0Vj86L
        13ff4MABJCzbIyT5jJtyZqiiG9iMUheFt9621pf7uA==
X-Google-Smtp-Source: ALg8bN4rtG8ud2W0ismXvPf+MRmbFTrLr5uztZNN+2jHC2FBHHEEK3jGixQC6GPkhL4qkleNuQsOfAUH1TcASTHfsQM=
X-Received: by 2002:ab0:526:: with SMTP id 35mr3213259uax.25.1547625503417;
 Tue, 15 Jan 2019 23:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-4-ulf.hansson@linaro.org> <119031115.C8gHTGbYmQ@aspire.rjw.lan>
In-Reply-To: <119031115.C8gHTGbYmQ@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Jan 2019 08:57:46 +0100
Message-ID: <CAPDyKFqQQnMKFNpGyi_dkP_Rm8qo-1WjPfVkp2unOxyXRa2wbA@mail.gmail.com>
Subject: Re: [PATCH v10 03/27] timer: Export next wakeup time of a CPU
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
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

On Fri, 11 Jan 2019 at 12:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, November 29, 2018 6:46:36 PM CET Ulf Hansson wrote:
> > From: Lina Iyer <lina.iyer@linaro.org>
> >
> > Knowing the sleep duration of CPUs, is known to be needed while selecting
> > the most energy efficient idle state for a CPU or a group of CPUs.
> >
> > However, to be able to compute the sleep duration, we need to know at what
> > time the next expected wakeup is for the CPU. Therefore, let's export this
> > information via a new function, tick_nohz_get_next_wakeup(). Following
> > changes make use of it.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Updated function header of tick_nohz_get_next_wakeup().
> >
> > ---
> >  include/linux/tick.h     |  8 ++++++++
> >  kernel/time/tick-sched.c | 13 +++++++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index 55388ab45fd4..e48f6b26b425 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -125,6 +125,7 @@ extern bool tick_nohz_idle_got_tick(void);
> >  extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
> >  extern unsigned long tick_nohz_get_idle_calls(void);
> >  extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
> > +extern ktime_t tick_nohz_get_next_wakeup(int cpu);
> >  extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
> >  extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
> >
> > @@ -151,6 +152,13 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
> >       *delta_next = TICK_NSEC;
> >       return *delta_next;
> >  }
> > +
> > +static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
> > +{
> > +     /* Next wake up is the tick period, assume it starts now */
> > +     return ktime_add(ktime_get(), TICK_NSEC);
> > +}
> > +
> >  static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
> >  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
> >
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 69e673b88474..7a9166506503 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -1089,6 +1089,19 @@ unsigned long tick_nohz_get_idle_calls(void)
> >       return ts->idle_calls;
> >  }
> >
> > +/**
> > + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
> > + * @cpu: the particular CPU to get next wake up for
> > + *
> > + * Called for idle CPUs only.
> > + */
> > +ktime_t tick_nohz_get_next_wakeup(int cpu)
> > +{
> > +     struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
> > +
> > +     return dev->next_event;
> > +}
> > +
> >  static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
> >  {
> >  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> >
>
> Well, I have concerns regarding this one.
>
> I don't believe it is valid to call this new function for non-idle CPUs and
> the kerneldoc kind of says so, but the next patch doesn't actually prevent
> it from being called for a non-idle CPU (at the time it is called in there
> the target CPU may not be idle any more AFAICS).

You are correct, but let me clarify things.

We are calling this new API from the new genpd governor, which may
have a cpumask indicating there is more than one CPU attached to its
PM domain+sub-PM domains. In other words, we may call the API for
another CPU than the one we are executing on.

When the new genpd governor is called, all CPUs in the cpumask of the
genpd in question, are already runtime suspended and will remain so
throughout the decisions made by the governor.

However, because of the race condition, which needs to be manged by
the genpd backend driver and its corresponding FW, one of the CPU in
the genpd cpumask could potentially wake up from idle when the genpd
governor runs. However, as a part of exiting from idle, that CPU needs
to wait for the call to pm_runtime_get_sync() to return before
completing the exit patch of idle. This also means waiting for the
genpd governor to finish.

The point is, no matter what decision the governor takes under these
circumstances, the genpd backend driver and its FW must manage this
race condition during the last man standing. For PSCI OSI mode, it
means that if a cluster idle state is suggested by Linux during these
circumstances, it must be prevented and aborted.

>
> In principle, the cpuidle core can store this value, say in struct
> cpuidle_device of the given CPU, and expose a helper to access it from
> genpd, but that would be extra overhead totally unnecessary on everthing
> that doesn't use genpd for cpuidle.
>
> So maybe the driver could store it in its ->enter callback?  After all,
> the driver knows that genpd is going to be used later.

This would work, but it wouldn't really change much when it comes to
the race condition described above. Of course it would turn the code
into being more cpuidle specific, which seems reasonable to me.

Anyway, if I understand your suggestion, in principle it means
changing $subject patch in such way that the API should not take "int
cpu" as an in-parameter, but instead only use __this_cpu() to read out
the next event for current idle CPU.

Additionally, we need another new cpuidle API, which genpd can call to
retrieve a new per CPU "next event data" stored by the cpuidle driver
from its ->enter() callback. Is this a correct interpretation of your
suggestion?

Kind regards
Uffe
