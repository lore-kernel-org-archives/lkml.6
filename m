Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30A8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391C820657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391C820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeJaQRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 12:17:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36570 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeJaQRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 12:17:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8F4C80D;
        Wed, 31 Oct 2018 00:20:48 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 716323F557;
        Wed, 31 Oct 2018 00:20:46 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Morten.Rasmussen@arm.com,
        patrick.bellasi@arm.com, pjt@google.com, bsegall@google.com,
        thara.gopinath@linaro.org, pkondeti@codeaurora.org
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6d0b324e-5e26-a510-9bcd-97f475e515ed@arm.com>
Date:   Wed, 31 Oct 2018 08:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 6:11 PM, Vincent Guittot wrote:

[...]

>   static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
>   static unsigned long task_h_load(struct task_struct *p);
> @@ -764,7 +763,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
>   			 * such that the next switched_to_fair() has the
>   			 * expected state.
>   			 */
> -			se->avg.last_update_time = cfs_rq_clock_task(cfs_rq);
> +			se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
>   			return;
>   		}
>   	}

There is this 1/cpu scaling of se->avg.util_sum (running_sum) in 
update_tg_cfs_runnable() so it can be used to calculate 
se->avg.runnable_load_sum (runnable_sum). I guess with your approach 
this should be removed.

> @@ -3466,7 +3465,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>   /* Update task and its cfs_rq load average */
>   static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   {
> -	u64 now = cfs_rq_clock_task(cfs_rq);
> +	u64 now = cfs_rq_clock_pelt(cfs_rq);
>   	struct rq *rq = rq_of(cfs_rq);
>   	int cpu = cpu_of(rq);
>   	int decayed;
> @@ -6694,6 +6693,12 @@ done: __maybe_unused;
>   	if (new_tasks > 0)
>   		goto again;
>   
> +	/*
> +	 * rq is about to be idle, check if we need to update the
> +	 * lost_idle_time of clock_pelt
> +	 */
> +	update_idle_rq_clock_pelt(rq);
> +
>   	return NULL;
>   }

[...]
