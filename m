Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C2BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC5D2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC5D2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJQQxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:53:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:54777 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeJQQxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:53:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 01:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,391,1534834800"; 
   d="scan'208";a="99931705"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 17 Oct 2018 01:57:54 -0700
Received: from [10.125.252.14] (abudanko-mobl.ccr.corp.intel.com [10.125.252.14])
        by linux.intel.com (Postfix) with ESMTP id 88D6E580444;
        Wed, 17 Oct 2018 01:57:51 -0700 (PDT)
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        mark.rutland@arm.com, megha.dey@intel.com, frederic@kernel.org
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f12f2d18-2e25-1879-fe34-227c82618abd@linux.intel.com>
Date:   Wed, 17 Oct 2018 11:57:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10.10.2018 13:45, Peter Zijlstra wrote:
<SNIP>
> -static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
> +/*
> + * XXX somewhat completely buggered; this is in cpu_pmu_context, but we need
> + * event_pmu_context for rotations. We also need event_pmu_context specific
> + * scheduling routines. ARGH
> + *
> + *  - fixed the cpu_pmu_context vs event_pmu_context thingy
> + *    (cpu_pmu_context embeds an event_pmu_context)
> + *
> + *  - need nr_events/nr_active in epc to do per epc rotation
> + *    (done)
> + *
> + *  - need cpu and task pmu ctx together...
> + *    (cpc->task_epc)
> + */
> +static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)

Since it reduces to single cpu context (and single task context) at all times, 
ideally, it would probably be coded as simple as this: 

	perf_rotate_context()
	{
            cpu = this_cpu_ptr(&cpu_context)
            for_every_pmu(pmu, cpu)
                    for_every_event_ctx(event_ctx, pmu)
	                    rotate(event_ctx, pmu)
	}

so rotate(event_ctx, pmu) would operate on common events objects semantics 
and memory layout, and PMU specific code handle SW/HW programming differences.
Implementing that implies this data relations:

                                      cpu (struct perf_cpu_context)
                                       |
                                       v
      cpu_context ---> cpu_0->cpu_1->cpu_2->cpu_3
                         |      |      |      |
                         v      v      v      v
    pmu0 (struct pmu)  pmu00  pmu01  pmu02  pmu03    
                         |      |      |      | 
                         v      v      v      v
    pmu1               pmu10  pmu11  pmu12  pmu13
                         |      |      |      |
                         v      v      v      v
    pmu2               pmu20  pmu21 *pmu22* pmu23  <- pmu (struct perf_cpu_pmu_context)


                                            event_ctx
                                               |
                                               v
    *pmu22* (struct perf_cpu_pmu_context) -> ctx22_0 -> ctx22_1
                                               |          |
                                               v          v
                                             event00    event01
                                               |          |
                                               v          v
                                            *event10*   event11   <- event
                                               |          |
                                               v          v
                                             event20    event21

In new schema that would result in one more link on the right:

                                                         cpu_context[NR_CPUS] 
                                                                  |
                                                                  v
  task_struct::perf_event_ctxp -> perf_event_context <- perf_cpu_context -----,
       ^                                 |    ^ ^                             |
       `---------------------------------'    | |                             |
                                              | `--> perf_event_pmu_context   | <- link
                                              |       ^           ^           |
                                              |       |           |           |
                                              | ,-----'           v           |
                                              | |      perf_cpu_pmu_context <-' 
                                              | |                 ^
                                              | |                 |
                                              v v                 v
                                         perf_event ---> pmu[,cpu_pmu_ctx[NR_CPUS],]

Thanks,
Alexey

>  {
> +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
> +	struct perf_event_pmu_context *cpu_epc, *task_epc = NULL;
>  	struct perf_event *cpu_event = NULL, *task_event = NULL;
>  	bool cpu_rotate = false, task_rotate = false;
>  	struct perf_event_context *ctx = NULL;
> +	struct pmu *pmu;
>  
>  	/*
>  	 * Since we run this from IRQ context, nobody can install new
>  	 * events, thus the event count values are stable.
>  	 */
>  
> -	if (cpuctx->ctx.nr_events) {
> -		if (cpuctx->ctx.nr_events != cpuctx->ctx.nr_active)
> -			cpu_rotate = true;
> -	}
> +	cpu_epc = &cpc->epc;
> +	pmu = cpu_epc->pmu;
>  
> -	ctx = cpuctx->task_ctx;
> -	if (ctx && ctx->nr_events) {
> -		if (ctx->nr_events != ctx->nr_active)
> +	if (cpu_epc->nr_events && cpu_epc->nr_events != cpu_epc->nr_active)
> +		cpu_rotate = true;
> +
> +	task_epc = cpc->task_epc;
> +	if (task_epc) {
> +		WARN_ON_ONCE(task_epc->pmu != pmu);
> +		if (task_epc->nr_events && task_epc->nr_events != task_epc->nr_active)
>  			task_rotate = true;
>  	}
>  
>  	if (!(cpu_rotate || task_rotate))
>  		return false;
>  
> -	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> -	perf_pmu_disable(cpuctx->ctx.pmu);
> +	perf_ctx_lock(cpuctx, ctx);
> +	perf_pmu_disable(pmu);
>  
>  	if (task_rotate)
> -		task_event = ctx_first_active(ctx);
> +		task_event = ctx_first_active(task_epc);
> +
>  	if (cpu_rotate)
> -		cpu_event = ctx_first_active(&cpuctx->ctx);
> +		cpu_event = ctx_first_active(cpu_epc);
>  
>  	/*
>  	 * As per the order given at ctx_resched() first 'pop' task flexible
>  	 * and then, if needed CPU flexible.
>  	 */
> -	if (task_event || (ctx && cpu_event))
> -		ctx_sched_out(ctx, cpuctx, EVENT_FLEXIBLE);
> -	if (cpu_event)
> -		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
> +	if (task_event || (task_epc && cpu_event)) {
> +		update_context_time(ctx);
> +		__pmu_ctx_sched_out(task_epc, EVENT_FLEXIBLE);
> +	}
> +
> +	if (cpu_event) {
> +		update_context_time(&cpuctx->ctx);
> +		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
> +		rotate_ctx(&cpuctx->ctx, cpu_event);
> +		__pmu_ctx_sched_in(&cpuctx->ctx, pmu);
> +	}
>  
>  	if (task_event)
>  		rotate_ctx(ctx, task_event);
> -	if (cpu_event)
> -		rotate_ctx(&cpuctx->ctx, cpu_event);
>  
> -	perf_event_sched_in(cpuctx, ctx, current);
> +	if (task_event || (task_epc && cpu_event))
> +		__pmu_ctx_sched_in(ctx, pmu);
>  
> -	perf_pmu_enable(cpuctx->ctx.pmu);
> -	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> +	perf_pmu_enable(pmu);
> +	perf_ctx_unlock(cpuctx, ctx);
>  
>  	return true;
>  }
