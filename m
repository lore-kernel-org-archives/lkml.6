Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934022AbeEIIal (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:30:41 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36429 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933715AbeEIIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:30:38 -0400
X-Google-Smtp-Source: AB8JxZo5MMbSAc9DdLFst91ZICyWZw2l3854Zb28/PBWb9NQVspDIO4rbyfLTTWw71NK0089AX4OMf/L2dURW0ZGjF0=
MIME-Version: 1.0
In-Reply-To: <20180509080644.GA76874@joelaf.mtv.corp.google.com>
References: <1525704215-8683-1-git-send-email-claudio@evidence.eu.com>
 <20180508065435.bcht6dyb3rpp6gk5@vireshk-i7> <20180509045425.GA158882@joelaf.mtv.corp.google.com>
 <20180509064530.GA1681@localhost.localdomain> <20180509080644.GA76874@joelaf.mtv.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 May 2018 10:30:37 +0200
X-Google-Sender-Auth: -99m4c__4xk5QoO46oQ-0yx5xs0
Message-ID: <CAJZ5v0iFZ5+6BQCism-o8bnOxD8KveueJ5CT58F9uH_7_pYOXQ@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/cpufreq/schedutil: handling urgent frequency requests
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Joel Fernandes <joelaf@google.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 10:06 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Wed, May 09, 2018 at 08:45:30AM +0200, Juri Lelli wrote:
>> On 08/05/18 21:54, Joel Fernandes wrote:
>>
>> [...]
>>
>> > Just for discussion sake, is there any need for work_in_progress? If we can
>> > queue multiple work say kthread_queue_work can handle it, then just queuing
>> > works whenever they are available should be Ok and the kthread loop can
>> > handle them. __cpufreq_driver_target is also protected by the work lock if
>> > there is any concern that can have races... only thing is rate-limiting of
>> > the requests, but we are doing a rate limiting, just not for the "DL
>> > increased utilization" type requests (which I don't think we are doing at the
>> > moment for urgent DL requests anyway).
>> >
>> > Following is an untested diff to show the idea. What do you think?
>> >
>> > thanks,
>> >
>> > - Joel
>> >
>> > ----8<---
>> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> > index d2c6083304b4..862634ff4bf3 100644
>> > --- a/kernel/sched/cpufreq_schedutil.c
>> > +++ b/kernel/sched/cpufreq_schedutil.c
>> > @@ -38,7 +38,6 @@ struct sugov_policy {
>> >     struct                  mutex work_lock;
>> >     struct                  kthread_worker worker;
>> >     struct task_struct      *thread;
>> > -   bool                    work_in_progress;
>> >
>> >     bool                    need_freq_update;
>> >  };
>> > @@ -92,16 +91,8 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>> >         !cpufreq_can_do_remote_dvfs(sg_policy->policy))
>> >             return false;
>> >
>> > -   if (sg_policy->work_in_progress)
>> > -           return false;
>> > -
>> >     if (unlikely(sg_policy->need_freq_update)) {
>> >             sg_policy->need_freq_update = false;
>> > -           /*
>> > -            * This happens when limits change, so forget the previous
>> > -            * next_freq value and force an update.
>> > -            */
>> > -           sg_policy->next_freq = UINT_MAX;
>> >             return true;
>> >     }
>> >
>> > @@ -129,7 +120,6 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>> >             policy->cur = next_freq;
>> >             trace_cpu_frequency(next_freq, smp_processor_id());
>> >     } else {
>> > -           sg_policy->work_in_progress = true;
>> >             irq_work_queue(&sg_policy->irq_work);
>>
>> Isn't this potentially introducing unneeded irq pressure (and doing the
>> whole wakeup the kthread thing), while the already active kthread could
>> simply handle multiple back-to-back requests before going to sleep?
>
> How about this? Will use the latest request, and also doesn't do unnecessary
> irq_work_queue:
>
> (untested)
> -----8<--------
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index d2c6083304b4..6a3e42b01f52 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -38,7 +38,7 @@ struct sugov_policy {
>         struct                  mutex work_lock;
>         struct                  kthread_worker worker;
>         struct task_struct      *thread;
> -       bool                    work_in_progress;
> +       bool                    work_in_progress; /* Has kthread been kicked */
>
>         bool                    need_freq_update;
>  };
> @@ -92,9 +92,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>             !cpufreq_can_do_remote_dvfs(sg_policy->policy))
>                 return false;
>
> -       if (sg_policy->work_in_progress)
> -               return false;
> -

Why this change?

Doing the below is rather pointless if work_in_progress is set, isn't it?

You'll drop the results of it on the floor going forward anyway then AFAICS.

>         if (unlikely(sg_policy->need_freq_update)) {
>                 sg_policy->need_freq_update = false;
>                 /*
> @@ -129,8 +126,11 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>                 policy->cur = next_freq;
>                 trace_cpu_frequency(next_freq, smp_processor_id());
>         } else {
> -               sg_policy->work_in_progress = true;
> -               irq_work_queue(&sg_policy->irq_work);
> +               /* work_in_progress helps us not queue unnecessarily */
> +               if (!sg_policy->work_in_progress) {
> +                       sg_policy->work_in_progress = true;
> +                       irq_work_queue(&sg_policy->irq_work);
> +               }
>         }
>  }
>
> @@ -381,13 +381,23 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
>  static void sugov_work(struct kthread_work *work)
>  {
>         struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> +       unsigned int freq;
> +
> +       /*
> +        * Hold sg_policy->update_lock just enough to handle the case where:
> +        * if sg_policy->next_freq is updated before work_in_progress is set to
> +        * false, we may miss queueing the new update request since
> +        * work_in_progress would appear to be true.
> +        */
> +       raw_spin_lock(&sg_policy->update_lock);
> +       freq = sg_policy->next_freq;
> +       sg_policy->work_in_progress = false;
> +       raw_spin_unlock(&sg_policy->update_lock);
>
>         mutex_lock(&sg_policy->work_lock);
> -       __cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> +       __cpufreq_driver_target(sg_policy->policy, freq,
>                                 CPUFREQ_RELATION_L);
>         mutex_unlock(&sg_policy->work_lock);
> -
> -       sg_policy->work_in_progress = false;
>  }
>
>  static void sugov_irq_work(struct irq_work *irq_work)
