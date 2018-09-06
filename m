Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE46820659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Htq1vvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE46820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbeIFTOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:14:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46148 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbeIFTOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eT9nFDqXulFbQZ1mQdFfGIqn13Rb+nL0n5/MvwTDLFw=; b=0Htq1vvwbsdbiJvSf0+SW/7JL
        Mce2YKB/u0mVkXJ1z7M+iRhHjTzt5WMmoCcEWQ3WEnBKbhkzPQeIDl7jFGL/WhEVEd3ekPQMaKpB7
        XQHqrgLx7MRUDZfkh7TxOUUm98tP2bl5UdShC6oKzf9V0WwL8VpCxhAnZ7M7AQ1ZTfTIOArlaOIip
        l5vyblPmxhbSdoRgJobsB7PLV7ULZun8GCwK6R/zxh4h2H5l8R27ZPLMvdT/BTN+oLRH7QkMpnCVn
        hGasauvxlk2ON6O9/r1FCxn29rzVFN9RjdvaVjGfz+E0XusbVXx0WoaNBV+BUdyoUVL8um1z1tQ8B
        M626+G4pQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxvQc-0003CC-G8; Thu, 06 Sep 2018 14:38:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 292882025C698; Thu,  6 Sep 2018 16:38:36 +0200 (CEST)
Date:   Thu, 6 Sep 2018 16:38:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 5/6] x86/intel_rdt: Use perf infrastructure for
 measurements
Message-ID: <20180906143836.GG24106@hirez.programming.kicks-ass.net>
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

So what about virt?

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

You probably want READ_ONCE() on that, the volatile cast in there
disallows the compiler from re-loading the values later.

> +
> +	/*
> +	 * Read counter variables twice - first to load the instructions
> +	 * used in L1 cache, second to capture accurate value that does not
> +	 * include cache misses incurred because of instruction loads.
> +	 */
> +	rdpmcl(l2_hit_pmcnum, l2_hits_before);

And this again does do virt.

> +	rdpmcl(l2_miss_pmcnum, l2_miss_before);
> +	/*
> +	 * From SDM: Performing back-to-back fast reads are not guaranteed
> +	 * to be monotonic. To guarantee monotonicity on back-toback reads,
> +	 * a serializing instruction must be placed between the two
> +	 * RDPMC instructions
> +	 */
> +	rmb();

You're copying the horrid horrid (did I say truly horrid?) use of
'serializing' from the SDM. Please don't do that.

LFENCE is not a serializing instruction. But given the (new) definition
LFENCE does ensure all prior instructions are retired before it
proceeds.

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

Why does that need to be asm?

> +	}

I think you want another LFENCE here, to ensure the RDPMCs don't overlap
with the last LOAD in the loop above.

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


So what I do in userspace is:

	mmap_read_pinned(ctx); /* prime */

	for (many-times) {

		cnt = mmap_read_pinned(evt);
		barrier();
		cnt = mmap_read_pinned(evt) - cnt;
		update_stats(&empty, cnt);

		cnt = mmap_read_pinned(evt);
		barrier();
		/* the thing */
		barrier();
		cnt = mmap_read_pinned(evt) - cnt;
		update_stats(&stat, cnt);

	}

	sub_stats(&stat, &empty);

Maybe I should've used asm("lfence" ::: "memory") instead of barrier(),
but the results were good enough.
