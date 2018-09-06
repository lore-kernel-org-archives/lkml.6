Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF15C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3C220844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D6g1CZgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3C220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeIGCQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:16:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49508 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeIGCQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MmOzpdPlrOhGX/65Vy0uauDiuoYpL4R0X/s8wbhU9Lg=; b=D6g1CZgMUjYLLDdKzPqtpZAab
        oE6jk62G+jJzoyxvvnVbiPt6bTFR/0N+vOu7Od+ONCabF/GMAyW/kCUF6hqo2nT/8mUzXJKSNBoAm
        Pgba2q5GhZLYSeICVBFr84SlegpACNv/YcBAxgTefPh8ZFkg/NS3bOVjv5qamNdIi+8izLhxTPhZ4
        hUBBRpla7vMccU/6lyh5MKOJCObSBsrQWN4NF4Toxam+0X4C4h0GNu44SMO+p3Ev42sUadoHpv14D
        F5vsc/ixVvF7fiVz1GR1QaS9FygUKFgN5FOcqWtmR4b+uYOXXehlFnzXwPE+BINEDnjKg6OFgSwVq
        nezAIcs7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fy1zS-00052S-33; Thu, 06 Sep 2018 21:39:02 +0000
Received: by worktop (Postfix, from userid 1000)
        id A55EA6E0AA9; Thu,  6 Sep 2018 23:38:57 +0200 (CEST)
Date:   Thu, 6 Sep 2018 23:38:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 5/6] x86/intel_rdt: Use perf infrastructure for
 measurements
Message-ID: <20180906213857.GF9358@worktop.programming.kicks-ass.net>
References: <cover.1534450299.git.reinette.chatre@intel.com>
 <30b32ebd826023ab88f3ab3122e4c414ea532722.1534450299.git.reinette.chatre@intel.com>
 <20180906141524.GF24106@hirez.programming.kicks-ass.net>
 <40894b6f-c421-32fb-39c3-3dddbed5aa91@intel.com>
 <20180906194441.GA9358@worktop.programming.kicks-ass.net>
 <2465aa4d-fa84-cb0c-082a-15240472b349@intel.com>
 <20180906202943.GE9358@worktop.programming.kicks-ass.net>
 <12da3ce5-710b-b18e-8c0c-a0aa3724afd2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12da3ce5-710b-b18e-8c0c-a0aa3724afd2@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:37:14PM -0700, Reinette Chatre wrote:
> On 9/6/2018 1:29 PM, Peter Zijlstra wrote:
> > On Thu, Sep 06, 2018 at 01:05:05PM -0700, Reinette Chatre wrote:
> >> When I separate the above into the two functions it just becomes either:
> >>                    rdpmcl(l2_hit_pmcnum, l2_hits_after);
> >>                    rdpmcl(l2_miss_pmcnum, l2_miss_after);
> >> or:
> >>                    rdpmcl(l3_hit_pmcnum, l3_hits_after);
> >>                    rdpmcl(l3_miss_pmcnum, l3_miss_after);
> >>
> > 
> > Right, which is the exact _same_ code, so you only need a single
> > function.
> > 
> 
> From my understanding it is not this code specifically that is causing
> the cache misses but instead the code and variables used to decide
> whether to run them or not. These would still be needed when I extract
> the above into inline functions.

Oh, seriously, use your brain.. This is trivial stuff. Compare the two
functions l2/l3.

They are _identical_ except for some silly bits before/after and
some spurious differences because apparently you cannot copy/paste.
I thought there would be some differences in the loop, but not even
that. They really are identical.

The below should work I think.

---

struct recidency_counts {
	u64 miss_before, hits_before;
	u64 miss_after,  hits_after;
};

static int measure_residency_fn(struct perf_event_attr *miss_attr,
				struct perf_event_attr *hit_attr,
				void *plr, struct recidency_counts *counts)
 {
+	u64 hits_before, hits_after, miss_before, miss_after;
+	struct perf_event *miss_event, *hit_event;
+	int hit_pmcnum, miss_pmcnum;
 	unsigned int line_size;
 	unsigned int size;
 	unsigned long i;
 	void *mem_r;
+	u64 tmp;
 
+	miss_event = perf_event_create_kernel_counter(miss_attr,
+							 plr->cpu,
+							 NULL, NULL, NULL);
+	if (IS_ERR(miss_event))
+		goto out;
+
+	hit_event = perf_event_create_kernel_counter(hit_attr,
+							plr->cpu,
+							NULL, NULL, NULL);
+	if (IS_ERR(hit_event))
+		goto out_miss;
+
+	local_irq_disable();
+	/*
+	 * Check any possible error state of events used by performing
+	 * one local read.
+	 */
+	if (perf_event_read_local(miss_event, &tmp, NULL, NULL)) {
+		local_irq_enable();
+		goto out_hit;
+	}
+	if (perf_event_read_local(hit_event, &tmp, NULL, NULL)) {
+		local_irq_enable();
+		goto out_hit;
+	}
+
+	/*
+	 * Disable hardware prefetchers.
 	 *
+	 * Call wrmsr direcly to avoid the local register variables from
+	 * being overwritten due to reordering of their assignment with
+	 * the wrmsr calls.
+	 */
+	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+
+	/* Initialize rest of local variables */
+	/*
+	 * Performance event has been validated right before this with
+	 * interrupts disabled - it is thus safe to read the counter index.
+	 */
+	miss_pmcnum = x86_perf_rdpmc_index(miss_event);
+	hit_pmcnum = x86_perf_rdpmc_index(hit_event);
+	line_size = READ_ONCE(plr->line_size);
+	mem_r = READ_ONCE(plr->kmem);
+	size = READ_ONCE(plr->size);
+
+	/*
+	 * Read counter variables twice - first to load the instructions
+	 * used in L1 cache, second to capture accurate value that does not
+	 * include cache misses incurred because of instruction loads.
+	 */
+	rdpmcl(hit_pmcnum, hits_before);
+	rdpmcl(miss_pmcnum, miss_before);
+	/*
+	 */
+	rmb();
+	rdpmcl(hit_pmcnum, hits_before);
+	rdpmcl(miss_pmcnum, miss_before);
+	/*
+	 */
+	rmb();
+	for (i = 0; i < size; i += line_size) {
+		/*
+		 * Add a barrier to prevent speculative execution of this
+		 * loop reading beyond the end of the buffer.
+		 */
+		rmb();
+		asm volatile("mov (%0,%1,1), %%eax\n\t"
+			     :
+			     : "r" (mem_r), "r" (i)
+			     : "%eax", "memory");
+	}
	rmb();
+	rdpmcl(hit_pmcnum, hits_after);
+	rdpmcl(miss_pmcnum, miss_after);
+	rmb();
+	/* Re-enable hardware prefetchers */
+	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
+	local_irq_enable();
+out_hit:
+	perf_event_release_kernel(hit_event);
+out_miss:
+	perf_event_release_kernel(miss_event);
+out:
	counts->miss_before = miss_before;
	counts->hits_before = hits_before;
	counts->miss_after  = miss_after;
	counts->hits_after  = hits_after;
+	return 0;
+}

measure_l2_recidency()
{
	struct recidency_counts counts;

+       switch (boot_cpu_data.x86_model) {
+       case INTEL_FAM6_ATOM_GOLDMONT:
+       case INTEL_FAM6_ATOM_GEMINI_LAKE:
+               perf_miss_attr.config = X86_CONFIG(.event = 0xd1,
+                                                  .umask = 0x10);
+               perf_hit_attr.config = X86_CONFIG(.event = 0xd1,
+                                                 .umask = 0x2);
+               break;
+       default:
+               goto out;
+       }

	measure_recidency_fn(&perf_miss_attr, &perf_hit_attr, plr, &counts);

	trace_pseudo_lock_l2(counts->hits_after - counts->hits_before,
			     counts->miss_after - counts->miss_before);
out:
+	plr->thread_done = 1;
+	wake_up_interruptible(&plr->lock_thread_wq);
}

measure_l3_residency()
{
	struct recidency_counts counts;

        switch (boot_cpu_data.x86_model) {
        case INTEL_FAM6_BROADWELL_X:
                /* On BDW the l3_hit_bits count references, not hits */
+               perf_hit_attr.config = X86_CONFIG(.event = 0x2e,
+                                                 .umask = 0x4f);
+               perf_miss_attr.config = X86_CONFIG(.event = 0x2e,
+                                                  .umask = 0x41);
                break;
        default:
                goto out;
        }

	measure_recidency_fn(&perf_miss_attr, &perf_hit_attr, plr, &counts);

+       counts->miss_after -= counts->miss_before;
+       if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X) {
+               /*
+                * On BDW references and misses are counted, need to adjust.
+                * Sometimes the "hits" counter is a bit more than the
+                * references, for example, x references but x + 1 hits.
+                * To not report invalid hit values in this case we treat
+                * that as misses equal to references.
+                */
+               /* First compute the number of cache references measured */
+               counts->hits_after -= counts->hits_before;
+               /* Next convert references to cache hits */
+               counts->hits_after -= counts->miss_after > counts->hits_after ?
+                                       counts->hits_after : counts->miss_after;
+       } else {
+               counts->hits_after -= counts->hits_before;
        }

+       trace_pseudo_lock_l3(counts->hits_after, counts->miss_after);
}
