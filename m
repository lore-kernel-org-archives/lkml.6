Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeBILOv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:14:51 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45239 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeBILOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:14:47 -0500
X-Google-Smtp-Source: AH8x224pIJH2EgQ8JtyOhUQ6XN8HxYPH912GK3aPvA7e3K/+hq25h8rfeq31RI8DnJKWUdsuWK/ycutkdsmsT1jMhkc=
MIME-Version: 1.0
In-Reply-To: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
References: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Feb 2018 12:14:45 +0100
X-Google-Sender-Auth: XTAGXR5wjFdvXxBdDIc4fFwXkPw
Message-ID: <CAJZ5v0h25d9CCOBzU30mDggTSwbJ7UVnUbRD773UXhhAanqCdg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 6:01 PM, Claudio Scordino
<claudio@evidence.eu.com> wrote:
> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
> we should not wait for the rate limit, otherwise we may miss some deadline.
>
> Tests using rt-app on Exynos5422 have shown reductions of about 10% of deadline
> misses for tasks with low RT periods.
>
> The patch applies on top of the one recently proposed by Peter to drop the
> SCHED_CPUFREQ_* flags.
>
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> CC: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
> CC: Patrick Bellasi <patrick.bellasi@arm.com>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Morten Rasmussen <morten.rasmussen@arm.com>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Todd Kjos <tkjos@android.com>
> CC: Joel Fernandes <joelaf@google.com>
> CC: linux-pm@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  kernel/sched/cpufreq_schedutil.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index b0bd77d..d8dcba2 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -74,7 +74,10 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>
>  /************************ Governor internals ***********************/
>
> -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> +static bool sugov_should_update_freq(struct sugov_policy *sg_policy,
> +                                    u64 time,
> +                                    struct sugov_cpu *sg_cpu_old,
> +                                    struct sugov_cpu *sg_cpu_new)

This looks somewhat excessive for using just one field from each of these.

>  {
>         s64 delta_ns;
>
> @@ -111,6 +114,10 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>                 return true;
>         }
>
> +       /* Ignore rate limit when DL increased utilization. */
> +       if (sg_cpu_new->util_dl > sg_cpu_old->util_dl)
> +               return true;
> +
>         delta_ns = time - sg_policy->last_freq_update_time;
>         return delta_ns >= sg_policy->freq_update_delay_ns;
>  }
> @@ -271,6 +278,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>                                 unsigned int flags)
>  {
>         struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> +       struct sugov_cpu sg_cpu_old = *sg_cpu;

And here you copy the entire struct to pass a pointer to the copy to a
helper function so that it can access one field.

That doesn't look particularly straightforward to me, let alone the overhead.

I guess you may do the check before calling sugov_should_update_freq()
and set sg_policy->need_freq_update if its true, as you know upfront
that the previous sg_policy->next_freq value isn't going to be used
anyway in that case.
