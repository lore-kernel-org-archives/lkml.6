Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A395EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676FA20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676FA20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeH2SFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:05:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55372 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbeH2SFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:05:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC94080D;
        Wed, 29 Aug 2018 07:08:40 -0700 (PDT)
Received: from [10.4.12.120] (e107158-lin.Emea.Arm.com [10.4.12.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E34983F721;
        Wed, 29 Aug 2018 07:08:39 -0700 (PDT)
Subject: Re: [RFC PATCH 3/4] sched/topology: remove smt_gain
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
 <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
From:   Qais Yousef <qais.yousef@arm.com>
Message-ID: <ca95124f-db09-c38f-d96a-5240bfe8c024@arm.com>
Date:   Wed, 29 Aug 2018 15:08:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/18 14:19, Vincent Guittot wrote:
> smt_gain is used to compute the capacity of CPUs of a SMT core with the
> constraint 1 < smt_gain < 2 in order to be able to compute number of CPUs
> per core. The field has_free_capacity of struct numa_stat, which was the
> last user of this computation of number of CPUs per core, has been removed
> by :
>
>    commit 2d4056fafa19 ("sched/numa: Remove numa_has_capacity()")
>
> We can now remove this constraint on core capacity and use the defautl value
> SCHED_CAPACITY_SCALE for SMT CPUs. With this remove, SCHED_CAPACITY_SCALE
> becomes the maximum compute capacity of CPUs on every systems. This should
> help to simplify some code and remove fields like rd->max_cpu_capacity
>
> Furthermore, arch_scale_cpu_capacity() is used with a NULL sd in several other
> places in the code when it wants the capacity of a CPUs to scale
> some metrics like in pelt, deadline or schedutil. In case on SMT, the value
> returned is not the capacity of SMT CPUs but default SCHED_CAPACITY_SCALE.
>
> Remove the smt_gain field from sched_domain struct

You beat me to it, I got confused by smt_gain recently when I stumbled 
on it as I found out on ARM it's not used and had to spend sometime to 
convince myself it's not really necessary to use it.

It was hard to track the history of this and *why* it's needed.

The only 'theoretical' case I found smt_gain can be useful is when you 
have asymmetric system, for example:

Node_A: 1 Core 2 Threads
Node_B: 1 Core 4 Threads

Then with smt_gain the group_capacity at the core level will be limited 
to smt_gain. But without smt_gain Node_B will look twice as powerful as 
Node_A - which will affect balancing AFAICT causing Node_B's single core 
to be oversubscribed as the 4 threads will still have to share the same 
underlying hardware resources. I don't think in practice such systems 
exists, or even make sense, though.

So +1 from my side for the removal.

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: linux-kernel@vger.kernel.org (open list)
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   include/linux/sched/topology.h | 1 -
>   kernel/sched/sched.h           | 3 ---
>   kernel/sched/topology.c        | 2 --
>   3 files changed, 6 deletions(-)
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 2634774..212792b 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -89,7 +89,6 @@ struct sched_domain {
>   	unsigned int newidle_idx;
>   	unsigned int wake_idx;
>   	unsigned int forkexec_idx;
> -	unsigned int smt_gain;
>   
>   	int nohz_idle;			/* NOHZ IDLE status */
>   	int flags;			/* See SD_* */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4a2e8ca..b1715b8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1758,9 +1758,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
>   static __always_inline
>   unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
>   {
> -	if (sd && (sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
> -		return sd->smt_gain / sd->span_weight;
> -
>   	return SCHED_CAPACITY_SCALE;
>   }
>   #endif
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 56a0fed..069c924 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1129,7 +1129,6 @@ sd_init(struct sched_domain_topology_level *tl,
>   
>   		.last_balance		= jiffies,
>   		.balance_interval	= sd_weight,
> -		.smt_gain		= 0,
>   		.max_newidle_lb_cost	= 0,
>   		.next_decay_max_lb_cost	= jiffies,
>   		.child			= child,
> @@ -1155,7 +1154,6 @@ sd_init(struct sched_domain_topology_level *tl,
>   	if (sd->flags & SD_SHARE_CPUCAPACITY) {
>   		sd->flags |= SD_PREFER_SIBLING;
>   		sd->imbalance_pct = 110;
> -		sd->smt_gain = 1178; /* ~15% */
>   
>   	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
>   		sd->flags |= SD_PREFER_SIBLING;


-- 
Qais Yousef

