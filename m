Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281F6C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB17B20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LEDezd0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB17B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeIFSvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:51:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbeIFSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oxpfwXfAYyY/qM8/KJ845v67BOzcA/s7fuYR88b/h5Q=; b=LEDezd0/uKnQIXCuRG8Y9WwHX
        NsmQNUmERc8Pf7+CPXx2UfUY1ygn/Sd4kkcCPgEg5gNsKhBqcacGvFKVjHC1Jhb0uIdvwFfTxCh+I
        elRq6WMeaLnjt+mRpU1pvPq+ebVP4pFlmV1JhGJMxTnTHYDLiGiPtvW0S5+PU9TBgCbrgza6/K/KN
        ZBUNJktI+1S+CfMWEz7N+OPa2FdC57P0E4WskWTBYSMIJjbPUsXbCin+S7gVm5AdHbicUT9Ni3gUS
        7WB8guaOqY9PEhGjLPrGP5dweaQRPa55UTPXf+IkKvaO8kAE4srBX5LWJtOilWZp7c91NY6gtuYf7
        8N/nxJ2kQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxv4A-0008C6-Il; Thu, 06 Sep 2018 14:15:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA9D12018BF7D; Thu,  6 Sep 2018 16:15:24 +0200 (CEST)
Date:   Thu, 6 Sep 2018 16:15:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 5/6] x86/intel_rdt: Use perf infrastructure for
 measurements
Message-ID: <20180906141524.GF24106@hirez.programming.kicks-ass.net>
References: <cover.1534450299.git.reinette.chatre@intel.com>
 <30b32ebd826023ab88f3ab3122e4c414ea532722.1534450299.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b32ebd826023ab88f3ab3122e4c414ea532722.1534450299.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 01:16:08PM -0700, Reinette Chatre wrote:
> +	l2_miss_event = perf_event_create_kernel_counter(&perf_miss_attr,
> +							 plr->cpu,
> +							 NULL, NULL, NULL);
> +	if (IS_ERR(l2_miss_event))
> +		goto out;
> +
> +	l2_hit_event = perf_event_create_kernel_counter(&perf_hit_attr,
> +							plr->cpu,
> +							NULL, NULL, NULL);
> +	if (IS_ERR(l2_hit_event))
> +		goto out_l2_miss;
> +
> +	local_irq_disable();
> +	/*
> +	 * Check any possible error state of events used by performing
> +	 * one local read.
> +	 */
> +	if (perf_event_read_local(l2_miss_event, &tmp, NULL, NULL)) {
> +		local_irq_enable();
> +		goto out_l2_hit;
> +	}
> +	if (perf_event_read_local(l2_hit_event, &tmp, NULL, NULL)) {
> +		local_irq_enable();
> +		goto out_l2_hit;
> +	}
> +
> +	/*
> +	 * Disable hardware prefetchers.
>  	 *
> +	 * Call wrmsr direcly to avoid the local register variables from
> +	 * being overwritten due to reordering of their assignment with
> +	 * the wrmsr calls.
> +	 */
> +	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
> +
> +	/* Initialize rest of local variables */
> +	/*
> +	 * Performance event has been validated right before this with
> +	 * interrupts disabled - it is thus safe to read the counter index.
> +	 */
> +	l2_miss_pmcnum = x86_perf_rdpmc_ctr_get(l2_miss_event);
> +	l2_hit_pmcnum = x86_perf_rdpmc_ctr_get(l2_hit_event);
> +	line_size = plr->line_size;
> +	mem_r = plr->kmem;
> +	size = plr->size;
> +
> +	/*
> +	 * Read counter variables twice - first to load the instructions
> +	 * used in L1 cache, second to capture accurate value that does not
> +	 * include cache misses incurred because of instruction loads.
> +	 */
> +	rdpmcl(l2_hit_pmcnum, l2_hits_before);
> +	rdpmcl(l2_miss_pmcnum, l2_miss_before);
> +	/*
> +	 * From SDM: Performing back-to-back fast reads are not guaranteed
> +	 * to be monotonic. To guarantee monotonicity on back-toback reads,
> +	 * a serializing instruction must be placed between the two
> +	 * RDPMC instructions
> +	 */
> +	rmb();
> +	rdpmcl(l2_hit_pmcnum, l2_hits_before);
> +	rdpmcl(l2_miss_pmcnum, l2_miss_before);
> +	/*
> +	 * rdpmc is not a serializing instruction. Add barrier to prevent
> +	 * instructions that follow to begin executing before reading the
> +	 * counter value.
> +	 */
> +	rmb();
> +	for (i = 0; i < size; i += line_size) {
> +		/*
> +		 * Add a barrier to prevent speculative execution of this
> +		 * loop reading beyond the end of the buffer.
> +		 */
> +		rmb();
> +		asm volatile("mov (%0,%1,1), %%eax\n\t"
> +			     :
> +			     : "r" (mem_r), "r" (i)
> +			     : "%eax", "memory");
> +	}
> +	rdpmcl(l2_hit_pmcnum, l2_hits_after);
> +	rdpmcl(l2_miss_pmcnum, l2_miss_after);
> +	/*
> +	 * rdpmc is not a serializing instruction. Add barrier to ensure
> +	 * events measured have completed and prevent instructions that
> +	 * follow to begin executing before reading the counter value.
> +	 */
> +	rmb();
> +	/* Re-enable hardware prefetchers */
> +	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
> +	local_irq_enable();
> +	trace_pseudo_lock_l2(l2_hits_after - l2_hits_before,
> +			     l2_miss_after - l2_miss_before);
> +
> +out_l2_hit:
> +	perf_event_release_kernel(l2_hit_event);
> +out_l2_miss:
> +	perf_event_release_kernel(l2_miss_event);
> +out:
> +	plr->thread_done = 1;
> +	wake_up_interruptible(&plr->lock_thread_wq);
> +	return 0;
> +}
> +

The above, looks a _LOT_ like the below. And while C does suck a little,
I'm sure there's something we can do about this.

> +	l3_miss_event = perf_event_create_kernel_counter(&perf_miss_attr,
> +							 plr->cpu,
> +							 NULL, NULL,
> +							 NULL);
> +	if (IS_ERR(l3_miss_event))
> +		goto out;
> +
> +	l3_hit_event = perf_event_create_kernel_counter(&perf_hit_attr,
> +							plr->cpu,
> +							NULL, NULL,
> +							NULL);
> +	if (IS_ERR(l3_hit_event))
> +		goto out_l3_miss;
> +
>  	local_irq_disable();
>  	/*
> +	 * Check any possible error state of events used by performing
> +	 * one local read.
> +	 */
> +	if (perf_event_read_local(l3_miss_event, &tmp, NULL, NULL)) {
> +		local_irq_enable();
> +		goto out_l3_hit;
> +	}
> +	if (perf_event_read_local(l3_hit_event, &tmp, NULL, NULL)) {
> +		local_irq_enable();
> +		goto out_l3_hit;
> +	}
> +
> +	/*
> +	 * Disable hardware prefetchers.
> +	 *
>  	 * Call wrmsr direcly to avoid the local register variables from
>  	 * being overwritten due to reordering of their assignment with
>  	 * the wrmsr calls.
>  	 */
>  	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
> +
> +	/* Initialize rest of local variables */
> +	/*
> +	 * Performance event has been validated right before this with
> +	 * interrupts disabled - it is thus safe to read the counter index.
> +	 */
> +	l3_hit_pmcnum = x86_perf_rdpmc_ctr_get(l3_hit_event);
> +	l3_miss_pmcnum = x86_perf_rdpmc_ctr_get(l3_miss_event);
> +	line_size = plr->line_size;
>  	mem_r = plr->kmem;
>  	size = plr->size;
> +
> +	/*
> +	 * Read counter variables twice - first to load the instructions
> +	 * used in L1 cache, second to capture accurate value that does not
> +	 * include cache misses incurred because of instruction loads.
> +	 */
> +	rdpmcl(l3_hit_pmcnum, l3_hits_before);
> +	rdpmcl(l3_miss_pmcnum, l3_miss_before);
> +	/*
> +	 * From SDM: Performing back-to-back fast reads are not guaranteed
> +	 * to be monotonic. To guarantee monotonicity on back-toback reads,
> +	 * a serializing instruction must be placed between the two
> +	 * RDPMC instructions
> +	 */
> +	rmb();
> +	rdpmcl(l3_hit_pmcnum, l3_hits_before);
> +	rdpmcl(l3_miss_pmcnum, l3_miss_before);
> +	/*
> +	 * rdpmc is not a serializing instruction. Add barrier to prevent
> +	 * instructions that follow to begin executing before reading the
> +	 * counter value.
> +	 */
> +	rmb();
>  	for (i = 0; i < size; i += line_size) {
> +		/*
> +		 * Add a barrier to prevent speculative execution of this
> +		 * loop reading beyond the end of the buffer.
> +		 */
> +		rmb();
>  		asm volatile("mov (%0,%1,1), %%eax\n\t"
>  			     :
>  			     : "r" (mem_r), "r" (i)
>  			     : "%eax", "memory");
>  	}
> +	rdpmcl(l3_hit_pmcnum, l3_hits_after);
> +	rdpmcl(l3_miss_pmcnum, l3_miss_after);
>  	/*
> +	 * rdpmc is not a serializing instruction. Add barrier to ensure
> +	 * events measured have completed and prevent instructions that
> +	 * follow to begin executing before reading the counter value.
>  	 */
> +	rmb();
> +	/* Re-enable hardware prefetchers */
>  	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
>  	local_irq_enable();
> +	l3_miss_after -= l3_miss_before;
> +	if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X) {
> +		/*
> +		 * On BDW references and misses are counted, need to adjust.
> +		 * Sometimes the "hits" counter is a bit more than the
> +		 * references, for example, x references but x + 1 hits.
> +		 * To not report invalid hit values in this case we treat
> +		 * that as misses equal to references.
> +		 */
> +		/* First compute the number of cache references measured */
> +		l3_hits_after -= l3_hits_before;
> +		/* Next convert references to cache hits */
> +		l3_hits_after -= l3_miss_after > l3_hits_after ?
> +					l3_hits_after : l3_miss_after;
> +	} else {
> +		l3_hits_after -= l3_hits_before;
>  	}
> +	trace_pseudo_lock_l3(l3_hits_after, l3_miss_after);
>  
> +out_l3_hit:
> +	perf_event_release_kernel(l3_hit_event);
> +out_l3_miss:
> +	perf_event_release_kernel(l3_miss_event);
