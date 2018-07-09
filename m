Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFECC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F5020877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F5020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754425AbeGIJMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:12:49 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:32794 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752914AbeGIJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:12:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T4HBdjG_1531127553;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0T4HBdjG_1531127553)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Jul 2018 17:12:34 +0800
Subject: Re: [PATCH v2] tg: show the sum wait time of an task group
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <5c4c978d-e8fb-4bcb-b942-3c6d3dcfc13e@linux.alibaba.com>
 <b9e74571-87d0-ef27-3f14-ebd21d72ee15@linux.alibaba.com>
 <ff7dae3b-e5f9-7157-1caa-ff02c6b23dc1@linux.alibaba.com>
Message-ID: <81d051ee-c428-5360-b459-a4902904d237@linux.alibaba.com>
Date:   Mon, 9 Jul 2018 17:12:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ff7dae3b-e5f9-7157-1caa-ff02c6b23dc1@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/4 上午11:27, 王贇 wrote:
> Although we can rely on cpuacct to present the cpu usage of task
> group, it is hard to tell how intense the competition is between
> these groups on cpu resources.
> 
> Monitoring the wait time of each process or sched_debug could cost
> too much, and there is no good way to accurately represent the
> conflict with these info, we need the wait time on group dimension.
> 
> Thus we introduced group's wait_sum represent the conflict between
> task groups, which is simply sum the wait time of group's cfs_rq.
> 
> The 'cpu.stat' is modified to show the statistic, like:
> 
>    nr_periods 0
>    nr_throttled 0
>    throttled_time 0
>    wait_sum 2035098795584
> 
> Now we can monitor the changing on wait_sum to tell how suffering
> a task group is in the fight of cpu resources.
> 
> For example:
>    (wait_sum - last_wait_sum) * 100 / (nr_cpu * period_ns) == X%
> 
> means the task group paid X percentage of period on waiting
> for the cpu.

Hi, Peter

How do you think about this proposal?

There are situation that tasks in some group suffered much more
than others, will be good to have some way to easily locate them.

Regards,
Michael Wang

> 
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
> 
> Since v1:
>    Use schedstat_val to avoid compile error
>    Check and skip root_task_group
> 
>   kernel/sched/core.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 78d8fac..80ab995 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6781,6 +6781,8 @@ static int __cfs_schedulable(struct task_group *tg, u64 period, u64 quota)
> 
>   static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
>   {
> +    int i;
> +    u64 ws = 0;
>       struct task_group *tg = css_tg(seq_css(sf));
>       struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
> 
> @@ -6788,6 +6790,12 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
>       seq_printf(sf, "nr_throttled %d\n", cfs_b->nr_throttled);
>       seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
> 
> +    if (schedstat_enabled() && tg != &root_task_group) {
> +        for_each_possible_cpu(i)
> +            ws += schedstat_val(tg->se[i]->statistics.wait_sum);
> +        seq_printf(sf, "wait_sum %llu\n", ws);
> +    }
> +
>       return 0;
>   }
>   #endif /* CONFIG_CFS_BANDWIDTH */
