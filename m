Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeFDMYH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:24:07 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36257 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbeFDMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:24:06 -0400
X-Google-Smtp-Source: ADUXVKI2Dy8NLU/XUZf5gA+bJA4kFlFpRpcGX4+DJeHCzR9YSLCxBEfnLswvlGCg01ycGKiRKDkt3b+wN+FnhlcfhRs=
MIME-Version: 1.0
In-Reply-To: <20180604115830.18781-1-quentin.perret@arm.com>
References: <20180604115830.18781-1-quentin.perret@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 4 Jun 2018 14:23:42 +0200
Message-ID: <CAKfTPtA6L7_UnP-FG4vtKNzC+Dy0HA3g+q=cwjuKs=FFvAgnzg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix util_avg of new tasks for asymmetric systems
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yuyang Du <yuyang.du@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 June 2018 at 13:58, Quentin Perret <quentin.perret@arm.com> wrote:
> When a new task wakes-up for the first time, its initial utilization
> is set to half of the spare capacity of its CPU. The current
> implementation of post_init_entity_util_avg() uses SCHED_CAPACITY_SCALE
> directly as a capacity reference. As a result, on a big.LITTLE system, a
> new task waking up on an idle little CPU will be given ~512 of util_avg,
> even if the CPU's capacity is significantly less than that.
>
> Fix this by computing the spare capacity with arch_scale_cpu_capacity().
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e497c05aab7f..f19432c17017 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -735,11 +735,12 @@ static void attach_entity_cfs_rq(struct sched_entity *se);
>   * To solve this problem, we also cap the util_avg of successive tasks to
>   * only 1/2 of the left utilization budget:
>   *
> - *   util_avg_cap = (1024 - cfs_rq->avg.util_avg) / 2^n
> + *   util_avg_cap = (cpu_scale - cfs_rq->avg.util_avg) / 2^n
>   *
> - * where n denotes the nth task.
> + * where n denotes the nth task and cpu_scale the CPU capacity.
>   *
> - * For example, a simplest series from the beginning would be like:
> + * For example, for a CPU with 1024 of capacity, a simplest series from
> + * the beginning would be like:
>   *
>   *  task  util_avg: 512, 256, 128,  64,  32,   16,    8, ...
>   * cfs_rq util_avg: 512, 768, 896, 960, 992, 1008, 1016, ...
> @@ -751,7 +752,8 @@ void post_init_entity_util_avg(struct sched_entity *se)
>  {
>         struct cfs_rq *cfs_rq = cfs_rq_of(se);
>         struct sched_avg *sa = &se->avg;
> -       long cap = (long)(SCHED_CAPACITY_SCALE - cfs_rq->avg.util_avg) / 2;
> +       long cpu_scale = arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
> +       long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
>
>         if (cap > 0) {
>                 if (cfs_rq->avg.util_avg != 0) {
> --
> 2.17.0
>
