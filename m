Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5498C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916862177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbfAKLHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:07:07 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55766 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfAKLHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:07:05 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 87e8267296bcc0e4; Fri, 11 Jan 2019 12:07:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lina Iyer <lina.iyer@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v10 03/27] timer: Export next wakeup time of a CPU
Date:   Fri, 11 Jan 2019 12:06:15 +0100
Message-ID: <119031115.C8gHTGbYmQ@aspire.rjw.lan>
In-Reply-To: <20181129174700.16585-4-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org> <20181129174700.16585-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 29, 2018 6:46:36 PM CET Ulf Hansson wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
> 
> Knowing the sleep duration of CPUs, is known to be needed while selecting
> the most energy efficient idle state for a CPU or a group of CPUs.
> 
> However, to be able to compute the sleep duration, we need to know at what
> time the next expected wakeup is for the CPU. Therefore, let's export this
> information via a new function, tick_nohz_get_next_wakeup(). Following
> changes make use of it.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v10:
> 	- Updated function header of tick_nohz_get_next_wakeup().
> 
> ---
>  include/linux/tick.h     |  8 ++++++++
>  kernel/time/tick-sched.c | 13 +++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 55388ab45fd4..e48f6b26b425 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -125,6 +125,7 @@ extern bool tick_nohz_idle_got_tick(void);
>  extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
>  extern unsigned long tick_nohz_get_idle_calls(void);
>  extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
> +extern ktime_t tick_nohz_get_next_wakeup(int cpu);
>  extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
>  extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
>  
> @@ -151,6 +152,13 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
>  	*delta_next = TICK_NSEC;
>  	return *delta_next;
>  }
> +
> +static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
> +{
> +	/* Next wake up is the tick period, assume it starts now */
> +	return ktime_add(ktime_get(), TICK_NSEC);
> +}
> +
>  static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
>  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
>  
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 69e673b88474..7a9166506503 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1089,6 +1089,19 @@ unsigned long tick_nohz_get_idle_calls(void)
>  	return ts->idle_calls;
>  }
>  
> +/**
> + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
> + * @cpu: the particular CPU to get next wake up for
> + *
> + * Called for idle CPUs only.
> + */
> +ktime_t tick_nohz_get_next_wakeup(int cpu)
> +{
> +	struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
> +
> +	return dev->next_event;
> +}
> +
>  static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
>  {
>  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> 

Well, I have concerns regarding this one.

I don't believe it is valid to call this new function for non-idle CPUs and
the kerneldoc kind of says so, but the next patch doesn't actually prevent
it from being called for a non-idle CPU (at the time it is called in there
the target CPU may not be idle any more AFAICS).

In principle, the cpuidle core can store this value, say in struct
cpuidle_device of the given CPU, and expose a helper to access it from
genpd, but that would be extra overhead totally unnecessary on everthing
that doesn't use genpd for cpuidle.

So maybe the driver could store it in its ->enter callback?  After all,
the driver knows that genpd is going to be used later.

