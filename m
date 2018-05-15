Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeEOKMp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:12:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52278 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeEOKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:12:43 -0400
X-Google-Smtp-Source: AB8JxZoFy8V4mo0ExsffoXxKsNl4HQ0qoGYzR8mf/1Q7Taxp/JsK7rNxy5NEiQFhe8ZuPU3MX99zhjSR74BK7ESOYlQ=
MIME-Version: 1.0
In-Reply-To: <20180511131509.16275-4-patrick.bellasi@arm.com>
References: <20180511131509.16275-1-patrick.bellasi@arm.com> <20180511131509.16275-4-patrick.bellasi@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 15 May 2018 12:12:22 +0200
Message-ID: <CAKfTPtCF5bJcJ_qdy-VDP1t9CRP1fwcCdvneX36GQe-pzCz_gQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/fair: schedutil: explicit update only when required
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On 11 May 2018 at 15:15, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> Schedutil updates for FAIR tasks are triggered implicitly each time a
> cfs_rq's utilization is updated via cfs_rq_util_change(), currently
> called by update_cfs_rq_load_avg(), when the utilization of a cfs_rq has
> changed, and {attach,detach}_entity_load_avg().
>
> This design is based on the idea that "we should callback schedutil
> frequently enough" to properly update the CPU frequency at every
> utilization change. However, such an integration strategy has also
> some downsides:
>
>  - schedutil updates are triggered by RQ's load updates, which makes
>    sense in general but it does not allow to know exactly which other RQ
>    related information have been updated.
>    Recently, for example, we had issues due to schedutil dependencies on
>    cfs_rq->h_nr_running and estimated utilization updates.
>
>  - cfs_rq_util_change() is mainly a wrapper function for an already
>    existing "public API", cpufreq_update_util(), which is required
>    just to ensure we actually update schedutil only when we are updating
>    a root cfs_rq.
>    Thus, especially when task groups are in use, most of the calls to
>    this wrapper function are not required.
>
>  - the usage of a wrapper function is not completely consistent across
>    fair.c, since we could still need additional explicit calls to
>    cpufreq_update_util().
>    For example this already happens to report the IOWAIT boot flag in
>    the wakeup path.
>
>  - it makes it hard to integrate new features since it could require to
>    change other function prototypes just to pass in an additional flag,
>    as it happened for example in commit:
>
>       commit ea14b57e8a18 ("sched/cpufreq: Provide migration hint")
>
> All the above considered, let's make schedutil updates more explicit in
> fair.c by removing the cfs_rq_util_change() wrapper function in favour
> of the existing cpufreq_update_util() public API.

removing the wrapper makes sense

> This can be done by calling cpufreq_update_util() explicitly in the few
> call sites where it really makes sense and when all the (potentially)
> required cfs_rq's information have been updated.
>
> This patch mainly removes code and adds explicit schedutil updates
> only when we:
>  - {enqueue,dequeue}_task_fair() a task to/from the root cfs_rq

The task's utilization is added during attach/detach and not during
the enqueue/dequeue.

>  - (un)throttle_cfs_rq() a set of tasks up to the root cfs_rq
>  - task_tick_fair() to update the utilization of the root cfs_rq
>
> All the other code paths, currently _indirectly_ covered by a call to
> update_load_avg(), are still covered. Indeed, some paths already imply
> enqueue/dequeue calls:
>  - switch_{to,from}_fair()
>  - sched_move_task()
> while others are followed by enqueue/dequeue calls:
>  - cpu_cgroup_fork() and
>    post_init_entity_util_avg():
>      are used at wakeup_new_task() time and thus already followed by an
>      enqueue_task_fair()
>  - migrate_task_rq_fair():
>      updates the removed utilization but not the actual cfs_rq
>      utilization, which is updated by a following sched event

The removed utilization will be applied during next call to
update_cfs_rq_load_avg() which means at next call to update_load_avg()
or update_blocked_averages()

I'm going to continue on the longer reply that you made to Joel

>
> This new proposal allows also to better aggregate schedutil related
> flags, which are required only at enqueue_task_fair() time.
> IOWAIT and MIGRATION flags are now requested only when a task is
> actually visible at the root cfs_rq level.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
>
> ---
