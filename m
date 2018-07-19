Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1583FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB46120671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB46120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeGSLAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:00:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54909 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeGSLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:00:06 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 559307ae5c49beaf; Thu, 19 Jul 2018 12:17:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v8 06/26] timer: Export next wakeup time of a CPU
Date:   Thu, 19 Jul 2018 12:15:57 +0200
Message-ID: <2046813.qdTUchafZm@aspire.rjw.lan>
In-Reply-To: <20180620172226.15012-7-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <20180620172226.15012-7-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 20, 2018 7:22:06 PM CEST Ulf Hansson wrote:
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
>  include/linux/tick.h     |  8 ++++++++
>  kernel/time/tick-sched.c | 10 ++++++++++
>  2 files changed, 18 insertions(+)
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
> index da9455a6b42b..f380bb4f0744 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1089,6 +1089,16 @@ unsigned long tick_nohz_get_idle_calls(void)
>  	return ts->idle_calls;
>  }
>  
> +/**
> + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
> + */

I'd add to the comment that this is to be invoked for idle CPUs only.

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


