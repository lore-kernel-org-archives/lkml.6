Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C4AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0EC240F4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0EC240F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeGEHxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:53:54 -0400
Received: from foss.arm.com ([217.140.101.70]:45876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753021AbeGEHxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:53:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 358DA18A;
        Thu,  5 Jul 2018 00:53:53 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4EC23F5AD;
        Thu,  5 Jul 2018 00:53:51 -0700 (PDT)
Date:   Thu, 5 Jul 2018 08:53:50 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        patrick.bellasi@arm.com
Subject: Re: [PATCH v2] sched/fair: Fix util_avg of new tasks for asymmetric
 systems
Message-ID: <20180705075349.GC9366@e108498-lin.cambridge.arm.com>
References: <20180612112215.25448-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612112215.25448-1-quentin.perret@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 12 Jun 2018 at 12:22:15 (+0100), Quentin Perret wrote:
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
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> 
> ---
> v2: added "Acked-by: Vincent Guittot <vincent.guittot@linaro.org>"
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
>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  	struct sched_avg *sa = &se->avg;
> -	long cap = (long)(SCHED_CAPACITY_SCALE - cfs_rq->avg.util_avg) / 2;
> +	long cpu_scale = arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
> +	long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
>  
>  	if (cap > 0) {
>  		if (cfs_rq->avg.util_avg != 0) {
> -- 
> 2.17.1
> 

Is there anything else I should do for this patch ?

Thanks,
Quentin
