Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeDFXs0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 19:48:26 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:51612 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeDFXsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 19:48:25 -0400
X-Google-Smtp-Source: AIpwx482a0zJ+4o3LnUf3ph4uNuc0jDOCx+1+UYNf3r4qvrY/Q0m6hNS2KaL/hWmuVIHKZ+DPkWjtKF59bgYeduV2Hc=
MIME-Version: 1.0
In-Reply-To: <20180406172835.20078-1-patrick.bellasi@arm.com>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 6 Apr 2018 16:48:22 -0700
Message-ID: <CAJWu+or7OeTELc=yUuTw=vRKvU6VaCyeHp5gA1UJsLSFonYz0w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info available
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 10:28 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> Schedutil is not properly updated when the first FAIR task wakes up on a
> CPU and when a RQ is (un)throttled. This is mainly due to the current
> integration strategy, which relies on updates being triggered implicitly
> each time a cfs_rq's utilization is updated.

To me that's not implicit, but is explicitly done when the util is
updated. It seems that's the logical place..

>
> Those updates are currently provided (mainly) via
>    cfs_rq_util_change()
> which is used in:
>  - update_cfs_rq_load_avg()
>    when the utilization of a cfs_rq is updated
>  - {attach,detach}_entity_load_avg()
> This is done based on the idea that "we should callback schedutil
> frequently enough" to properly update the CPU frequency at every

This also I didn't get, its not called "frequently enough" but at the
right time (when the util is updated).

> utilization change.
>
> Since this recent schedutil update:
>
>   commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")
>
> we use additional RQ information to properly account for FAIR tasks
> utilization. Specifically, cfs_rq::h_nr_running has to be non-zero
> in sugov_aggregate_util() to sum up the cfs_rq's utilization.
>
> However, cfs_rq::h_nr_running is usually updated as:
>
>     enqueue_entity()
>        ...
>        update_load_avg()
>           ...
>           cfs_rq_util_change ==> trigger schedutil update
>     ...
>     cfs_rq->h_nr_running += number_of_tasks
>
> both in enqueue_task_fair() as well as in unthrottle_cfs_rq().
> A similar pattern is used also in dequeue_task_fair() and
> throttle_cfs_rq() to remove tasks.

Maybe this should be fixed then? It seems broken to begin with...

>
> This means that we are likely to see a zero cfs_rq utilization when we
> enqueue a task on an empty CPU, or a non-zero cfs_rq utilization when
> instead, for example, we are throttling all the FAIR tasks of a CPU.
>
> While the second issue is less important, since we are less likely to

Actually I wanted behavior like the second issue, because that means
frequency will not be dropped if CPU is about to idle which is similar
to a patch I sent long time ago (skip freq update if CPU about to
idle).

> reduce frequency when CPU utilization decreases, the first issue can
> instead impact performance. Indeed, we potentially introduce a not desired

This issue would be fixed by just fixing the h_nr_running bug right?

> latency between a task enqueue on a CPU and its frequency increase.
>
> Another possible unwanted side effect is the iowait boosting of a CPU
> when we enqueue a task into a throttled cfs_rq.

Probably very very rare.

> Moreover, the current schedutil integration has these other downsides:
>
>  - schedutil updates are triggered by RQ's load updates, which makes
>    sense in general but it does not allow to know exactly which other RQ
>    related information has been updated (e.g. h_nr_running).

It seems broken that all information that schedutil needs isn't
updated _before_ the cpufreq update request, so that should be fixed
instead?

>
>  - increasing the chances to update schedutil does not always correspond
>    to provide the most accurate information for a proper frequency
>    selection, thus we can skip some updates.

Again IMO its just updated at the right time already, not just
frequently enough...

>
>  - we don't know exactly at which point a schedutil update is triggered,
>    and thus potentially a frequency change started, and that's because
>    the update is a side effect of cfs_rq_util_changed instead of an
>    explicit call from the most suitable call path.
>
>  - cfs_rq_util_change() is mainly a wrapper function for an already
>    existing "public API", cpufreq_update_util(), to ensure we actually
>    update schedutil only when we are updating a root RQ. Thus, especially
>    when task groups are in use, most of the calls to this wrapper
>    function are really not required.
>
>  - the usage of a wrapper function is not completely consistent across
>    fair.c, since we still need sometimes additional explicit calls to
>    cpufreq_update_util(), for example to support the IOWAIT boot flag in
>    the wakeup path
>
>  - it makes it hard to integrate new features since it could require to
>    change other function prototypes just to pass in an additional flag,
>    as it happened for example here:
>
>       commit ea14b57e8a18 ("sched/cpufreq: Provide migration hint")
>
> All the above considered, let's try to make schedutil updates more
> explicit in fair.c by:
>
>  - removing the cfs_rq_util_change() wrapper function to use the
>    cpufreq_update_util() public API only when root cfs_rq is updated
>
>  - remove indirect and side-effect (sometimes not required) schedutil
>    updates when the cfs_rq utilization is updated
>
>  - call cpufreq_update_util() explicitly in the few call sites where it
>    really makes sense and all the required information has been updated
>
> By doing so, this patch mainly removes code and adds explicit calls to
> schedutil only when we:
>  - {enqueue,dequeue}_task_fair() a task to/from the root cfs_rq
>  - (un)throttle_cfs_rq() a set of tasks up to the root cfs_rq
>  - task_tick_fair() to update the utilization of the root cfs_rq

About the "update for root" thingy, we're already doing rq->cfs ==
cfs_rq in cfs_rq_util_change so its already covered?

Also, I feel if you can shorten the commit message a little and only
include the best reasons for this patch that'll be nice so its easier
to review.

>
> All the other code paths, currently _indirectly_ covered by a call to
> update_load_avg(), are also covered by the above three calls.

I would rather we do it in as few places as possible (when util is
updated for root) than spreading it around and making it "explicit". I
hope I didn't miss something but I feel its explicit enough already...

thanks!

- Joel
