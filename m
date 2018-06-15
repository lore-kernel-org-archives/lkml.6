Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 31B7AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC240208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC240208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755995AbeFOLxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:53:04 -0400
Received: from foss.arm.com ([217.140.101.70]:41664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755650AbeFOLxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:53:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 849B21529;
        Fri, 15 Jun 2018 04:53:02 -0700 (PDT)
Received: from [192.168.1.17] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16A733F557;
        Fri, 15 Jun 2018 04:52:58 -0700 (PDT)
Subject: Re: [PATCH v6 03/11] sched/rt: add rt_rq utilization tracking
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, juri.lelli@redhat.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com,
        patrick.bellasi@arm.com, joel@joelfernandes.org,
        daniel.lezcano@linaro.org, quentin.perret@arm.com,
        Ingo Molnar <mingo@redhat.com>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-4-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <00f701a4-8ea6-82cb-6c76-5597ffcc9f11@arm.com>
Date:   Fri, 15 Jun 2018 13:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528459794-13066-4-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 02:09 PM, Vincent Guittot wrote:
> schedutil governor relies on cfs_rq's util_avg to choose the OPP when cfs
> tasks are running. When the CPU is overloaded by cfs and rt tasks, cfs tasks
> are preempted by rt tasks and in this case util_avg reflects the remaining
> capacity but not what cfs want to use. In such case, schedutil can select a
> lower OPP whereas the CPU is overloaded. In order to have a more accurate
> view of the utilization of the CPU, we track the utilization of rt tasks.
> 
> rt_rq uses rq_clock_task and cfs_rq uses cfs_rq_clock_task but they are
> the same at the root group level, so the PELT windows of the util_sum are
> aligned.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

[...]

;
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 4174582..81c0d7e 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -307,3 +307,25 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
>   
>   	return 0;
>   }
> +
> +/*
> + * rt_rq:
> + *
> + *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
> + *   util_sum = cpu_scale * load_sum
> + *   runnable_load_sum = load_sum
> + *
> + */
> +
> +int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
> +{
> +	if (___update_load_sum(now, rq->cpu, &rq->avg_rt,
> +				running,
> +				running,
> +				running)) {

The patch clearly says that this is about utilization but what happens
to load and runnable load for the rt rq part when you call
___update_load_sum() with load=[0,1] and runnable=[0,1]?

It looks like that the math would require 1024 instead of 1 for load and
runnable so that we would see a load_avg or runnable_load_avg != 0.

1594.075128: bprint: update_rt_rq_load_avg: now=1593937228087 cpu=4 running=1
1594.075129: bprint: update_rt_rq_load_avg: delta=3068 cpu=4 load=1 runnable=1 running=1 scale_freq=1024 scale_cpu=1024 periods=2
1594.075130: bprint: update_rt_rq_load_avg: load_sum=23927 +2879 runnable_load_sum=23927 +2879 util_sum=24506165 +2948096
1594.075130: bprint: update_rt_rq_load_avg: load_avg=0 runnable_load_avg=0 util_avg=513

IMHO, the patch should say whether load and runnable load are supported as well or not. 

[...]
