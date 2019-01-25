Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B14C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A6120861
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfAYDMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:12:10 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57981 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfAYDMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:12:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TIxfUcd_1548385900;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TIxfUcd_1548385900)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Jan 2019 11:12:06 +0800
Subject: Re: [PATCH] sched/debug: Show intergroup and hierarchy sum wait time
 of a task group
To:     ufo19890607@gmail.com, mingo@redhat.com, peterz@infradead.org,
        yuzhoujian@didichuxing.com
Cc:     linux-kernel@vger.kernel.org
References: <1548236816-18712-1-git-send-email-ufo19890607@gmail.com>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <3680160f-a439-02a3-3d40-56de18096c4b@linux.alibaba.com>
Date:   Fri, 25 Jan 2019 11:11:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1548236816-18712-1-git-send-email-ufo19890607@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/23 下午5:46, ufo19890607@gmail.com wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> We can monitor the sum wait time of a task group since 'commit 3d6c50c27bd6
> ("sched/debug: Show the sum wait time of a task group")'. However this
> wait_sum just represents the confilct between different task groups, since
> it is simply sum the wait time of task_group's cfs_rq. And we still cannot
> evaluate the conflict between all the tasks within hierarchy of this group,
> so the hierarchy wait time is still needed.

Could you please give us a scene that we do need this hierarchy wait_sum,
despite the extra overhead?

Regards,
Michael Wang

> 
> Thus we introduce hierarchy wait_sum which summarizes the total wait sum of
> all the tasks in the hierarchy of a group.
> 
> The 'cpu.stat' is modified to show the statistic, like:
> 
> 	nr_periods 0
> 	nr_throttled 0
> 	throttled_time 0
> 	intergroup wait_sum 2842251984
> 	hierarchy wait_sum 6389509389332798
> 
>  From now on we can monitor both the wait_sum of intergroup and hierarchy,
> which will inevitably help a system administrator know how intense the CPU
> competition is within a task group and between different task groups. We
> can calculate the wait rate of a task group based on hierarchy wait_sum and
> cpuacct.usage.
> 
> For example:
> 	X% = (current_wait_sum - last_wait_sum) / ((current_usage -
> last_usage) + (current_wait_sum - last_wait_sum))
> 
> That means the task group paid X percentage of time on runqueue waiting
> for the CPU.
> 
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
>   kernel/sched/core.c  | 11 +++++++----
>   kernel/sched/fair.c  | 17 +++++++++++++++++
>   kernel/sched/sched.h |  3 +++
>   3 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ee77636..172e6fb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6760,13 +6760,16 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
>   	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
>   
>   	if (schedstat_enabled() && tg != &root_task_group) {
> -		u64 ws = 0;
> +		u64 inter_ws = 0, hierarchy_ws = 0;
>   		int i;
>   
> -		for_each_possible_cpu(i)
> -			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
> +		for_each_possible_cpu(i) {
> +			inter_ws += schedstat_val(tg->se[i]->statistics.wait_sum);
> +			hierarchy_ws += tg->cfs_rq[i]->hierarchy_wait_sum;
> +		}
>   
> -		seq_printf(sf, "wait_sum %llu\n", ws);
> +		seq_printf(sf, "intergroup wait_sum %llu\n", inter_ws);
> +		seq_printf(sf, "hierarchy wait_sum %llu\n", hierarchy_ws);
>   	}
>   
>   	return 0;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e2ff4b6..35e89ca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -858,6 +858,19 @@ static void update_curr_fair(struct rq *rq)
>   }
>   
>   static inline void
> +update_hierarchy_wait_sum(struct sched_entity *se,
> +			u64 delta_wait)
> +{
> +	for_each_sched_entity(se) {
> +		struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +		if (cfs_rq->tg != &root_task_group)
> +			__schedstat_add(cfs_rq->hierarchy_wait_sum,
> +					delta_wait);
> +	}
> +}
> +
> +static inline void
>   update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   {
>   	struct task_struct *p;
> @@ -880,6 +893,7 @@ static void update_curr_fair(struct rq *rq)
>   			return;
>   		}
>   		trace_sched_stat_wait(p, delta);
> +		update_hierarchy_wait_sum(se, delta);
>   	}
>   
>   	__schedstat_set(se->statistics.wait_max,
> @@ -10273,6 +10287,9 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>   #ifndef CONFIG_64BIT
>   	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
>   #endif
> +#ifdef CONFIG_SCHEDSTATS
> +	cfs_rq->hierarchy_wait_sum = 0;
> +#endif
>   #ifdef CONFIG_SMP
>   	raw_spin_lock_init(&cfs_rq->removed.lock);
>   #endif
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d27c1a5..c01ab99 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -496,6 +496,9 @@ struct cfs_rq {
>   #ifndef CONFIG_64BIT
>   	u64			min_vruntime_copy;
>   #endif
> +#ifdef CONFIG_SCHEDSTATS
> +	u64			hierarchy_wait_sum;
> +#endif
>   
>   	struct rb_root_cached	tasks_timeline;
>   
> 
