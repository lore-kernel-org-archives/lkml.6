Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B88BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A372146E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A372146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeHQPYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:24:50 -0400
Received: from foss.arm.com ([217.140.101.70]:46724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeHQPYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:24:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 437427A9;
        Fri, 17 Aug 2018 05:21:35 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F30083F5BD;
        Fri, 17 Aug 2018 05:21:26 -0700 (PDT)
Subject: Re: [PATCH v3 08/14] sched/core: uclamp: extend cpu's cgroup
 controller
To:     Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-9-patrick.bellasi@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <82db1123-339f-0dbf-9332-7e37ee9e4f20@arm.com>
Date:   Fri, 17 Aug 2018 14:21:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806163946.28380-9-patrick.bellasi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 06:39 PM, Patrick Bellasi wrote:

[...]

> Give the above mechanisms, it is now possible to extend the cpu
> controller to specify what is the minimum (or maximum) utilization which
> a task is expected (or allowed) to generate.
> Constraints on minimum and maximum utilization allowed for tasks in a
> CPU cgroup can improve the control on the actual amount of CPU bandwidth
> consumed by tasks.

I assume this is covered by the s/bandwidth/capacity/ you had w/ Juri on 
01/14.

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ff76b000bbe8..2ba55a4afffb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1211,6 +1211,74 @@ static inline void uclamp_group_get(struct task_struct *p,
>   	uclamp_group_put(clamp_id, prev_group_id);
>   }
>   
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +/**
> + * init_uclamp_sched_group: initialize data structures required for TG's
> + *                          utilization clamping
> + */
> +static inline void init_uclamp_sched_group(void)
> +{
> +	struct uclamp_map *uc_map;
> +	struct uclamp_se *uc_se;
> +	int group_id;
> +	int clamp_id;
> +
> +	/* Root TG's is statically assigned to the first clamp group */
> +	group_id = 0;
> +
> +	/* Initialize root TG's to default (none) clamp values */
> +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +		uc_map = &uclamp_maps[clamp_id][0];
> +
> +		/* Map root TG's clamp value */
> +		uclamp_group_init(clamp_id, group_id, uclamp_none(clamp_id));
> +
> +		/* Init root TG's clamp group */
> +		uc_se = &root_task_group.uclamp[clamp_id];
> +		uc_se->value = uclamp_none(clamp_id);
> +		uc_se->group_id = group_id;
> +
> +		/* Attach root TG's clamp group */
> +		uc_map[group_id].se_count = 1;
> +	}
> +}

Can you not save some lines here:

  static inline void init_uclamp_sched_group(void)
  {
-       struct uclamp_map *uc_map;
         struct uclamp_se *uc_se;
         int group_id;
         int clamp_id;
@@ -1228,8 +1227,6 @@ static inline void init_uclamp_sched_group(void)

         /* Initialize root TG's to default (none) clamp values */
         for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
-               uc_map = &uclamp_maps[clamp_id][0];
-
                 /* Map root TG's clamp value */
                 uclamp_group_init(clamp_id, group_id, 
uclamp_none(clamp_id));

@@ -1239,7 +1236,7 @@ static inline void init_uclamp_sched_group(void)
                 uc_se->group_id = group_id;

                 /* Attach root TG's clamp group */
-               uc_map[group_id].se_count = 1;
+               uclamp_maps[clamp_id][group_id].se_count = 1;
         }

This would also make uclamp_group_available() smaller.

[...]

