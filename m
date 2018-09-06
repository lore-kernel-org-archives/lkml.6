Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE93C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAD220659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAD220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeIFX6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:58:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:7960 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbeIFX6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:58:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 12:21:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,339,1531810800"; 
   d="scan'208";a="89589982"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.122]) ([10.24.14.122])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2018 12:21:59 -0700
Subject: Re: [PATCH V2 5/6] x86/intel_rdt: Use perf infrastructure for
 measurements
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1534450299.git.reinette.chatre@intel.com>
 <30b32ebd826023ab88f3ab3122e4c414ea532722.1534450299.git.reinette.chatre@intel.com>
 <20180906141524.GF24106@hirez.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <40894b6f-c421-32fb-39c3-3dddbed5aa91@intel.com>
Date:   Thu, 6 Sep 2018 12:21:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180906141524.GF24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 9/6/2018 7:15 AM, Peter Zijlstra wrote:
> On Thu, Aug 16, 2018 at 01:16:08PM -0700, Reinette Chatre wrote:
>> +	l2_miss_event = perf_event_create_kernel_counter(&perf_miss_attr,
>> +							 plr->cpu,
>> +							 NULL, NULL, NULL);
>> +	if (IS_ERR(l2_miss_event))
>> +		goto out;
>> +
>> +	l2_hit_event = perf_event_create_kernel_counter(&perf_hit_attr,
>> +							plr->cpu,
>> +							NULL, NULL, NULL);
>> +	if (IS_ERR(l2_hit_event))
>> +		goto out_l2_miss;
>> +
>> +	local_irq_disable();
>> +	/*
>> +	 * Check any possible error state of events used by performing
>> +	 * one local read.
>> +	 */
>> +	if (perf_event_read_local(l2_miss_event, &tmp, NULL, NULL)) {
>> +		local_irq_enable();
>> +		goto out_l2_hit;
>> +	}
>> +	if (perf_event_read_local(l2_hit_event, &tmp, NULL, NULL)) {
>> +		local_irq_enable();
>> +		goto out_l2_hit;
>> +	}
>> +
>> +	/*
>> +	 * Disable hardware prefetchers.
>>  	 *
>> +	 * Call wrmsr direcly to avoid the local register variables from
>> +	 * being overwritten due to reordering of their assignment with
>> +	 * the wrmsr calls.
>> +	 */
>> +	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
>> +
>> +	/* Initialize rest of local variables */
>> +	/*
>> +	 * Performance event has been validated right before this with
>> +	 * interrupts disabled - it is thus safe to read the counter index.
>> +	 */
>> +	l2_miss_pmcnum = x86_perf_rdpmc_ctr_get(l2_miss_event);
>> +	l2_hit_pmcnum = x86_perf_rdpmc_ctr_get(l2_hit_event);
>> +	line_size = plr->line_size;
>> +	mem_r = plr->kmem;
>> +	size = plr->size;
>> +
>> +	/*
>> +	 * Read counter variables twice - first to load the instructions
>> +	 * used in L1 cache, second to capture accurate value that does not
>> +	 * include cache misses incurred because of instruction loads.
>> +	 */
>> +	rdpmcl(l2_hit_pmcnum, l2_hits_before);
>> +	rdpmcl(l2_miss_pmcnum, l2_miss_before);
>> +	/*
>> +	 * From SDM: Performing back-to-back fast reads are not guaranteed
>> +	 * to be monotonic. To guarantee monotonicity on back-toback reads,
>> +	 * a serializing instruction must be placed between the two
>> +	 * RDPMC instructions
>> +	 */
>> +	rmb();
>> +	rdpmcl(l2_hit_pmcnum, l2_hits_before);
>> +	rdpmcl(l2_miss_pmcnum, l2_miss_before);
>> +	/*
>> +	 * rdpmc is not a serializing instruction. Add barrier to prevent
>> +	 * instructions that follow to begin executing before reading the
>> +	 * counter value.
>> +	 */
>> +	rmb();
>> +	for (i = 0; i < size; i += line_size) {
>> +		/*
>> +		 * Add a barrier to prevent speculative execution of this
>> +		 * loop reading beyond the end of the buffer.
>> +		 */
>> +		rmb();
>> +		asm volatile("mov (%0,%1,1), %%eax\n\t"
>> +			     :
>> +			     : "r" (mem_r), "r" (i)
>> +			     : "%eax", "memory");
>> +	}
>> +	rdpmcl(l2_hit_pmcnum, l2_hits_after);
>> +	rdpmcl(l2_miss_pmcnum, l2_miss_after);
>> +	/*
>> +	 * rdpmc is not a serializing instruction. Add barrier to ensure
>> +	 * events measured have completed and prevent instructions that
>> +	 * follow to begin executing before reading the counter value.
>> +	 */
>> +	rmb();
>> +	/* Re-enable hardware prefetchers */
>> +	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
>> +	local_irq_enable();
>> +	trace_pseudo_lock_l2(l2_hits_after - l2_hits_before,
>> +			     l2_miss_after - l2_miss_before);
>> +
>> +out_l2_hit:
>> +	perf_event_release_kernel(l2_hit_event);
>> +out_l2_miss:
>> +	perf_event_release_kernel(l2_miss_event);
>> +out:
>> +	plr->thread_done = 1;
>> +	wake_up_interruptible(&plr->lock_thread_wq);
>> +	return 0;
>> +}
>> +
> 
> The above, looks a _LOT_ like the below. And while C does suck a little,
> I'm sure there's something we can do about this.

You are correct, the L2 and L3 cache measurements are very similar.
Indeed, the current implementation does have them together in one
function but I was not able to obtain the same accuracy in measurements
as presented in my previous emails that only did L2 measurements. When
combining the L2 and L3 measurements in one function it is required to
do something like:

          if (need_l2) {
                  rdpmcl(l2_hit_pmcnum, l2_hits_before);
                  rdpmcl(l2_miss_pmcnum, l2_miss_before);
          }
          if (need_l3) {
                  rdpmcl(l3_hit_pmcnum, l3_hits_before);
                  rdpmcl(l3_miss_pmcnum, l3_miss_before);
          }
          rmb();
          if (need_l2) {
                  rdpmcl(l2_hit_pmcnum, l2_hits_before);
                  rdpmcl(l2_miss_pmcnum, l2_miss_before);
          }
          if (need _l3) {
                  rdpmcl(l3_hit_pmcnum, l3_hits_before);
                  rdpmcl(l3_miss_pmcnum, l3_miss_before);
          }
          rmb();
          /* Test */
          if (need_l2) {
                  rdpmcl(l2_hit_pmcnum, l2_hits_after);
                  rdpmcl(l2_miss_pmcnum, l2_miss_after);
          }
          if (need_l3) {
                  rdpmcl(l3_hit_pmcnum, l3_hits_after);
                  rdpmcl(l3_miss_pmcnum, l3_miss_after);
          }

I have found that the additional branches required to support L2 and L3
measurements in one function introduces more cache misses in the
measurements than if I separate the measurements into two functions.

If you do have suggestions on how I can improve the implementation while
maintaining (or improving) the accuracy of the measurements I would
greatly appreciate it.

Reinette
