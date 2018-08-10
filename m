Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF4C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928162189B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928162189B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeHJSzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:55:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:3211 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbeHJSzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:55:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 09:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,220,1531810800"; 
   d="scan'208";a="223630742"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.94]) ([10.24.14.94])
  by orsmga004.jf.intel.com with ESMTP; 10 Aug 2018 09:25:03 -0700
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
 <20180803104956.GU2494@hirez.programming.kicks-ass.net>
 <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
 <20180803152523.GY2476@hirez.programming.kicks-ass.net>
 <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
 <57c011e1-113d-c38f-c318-defbad085843@intel.com>
 <20180806221225.GO2458@hirez.programming.kicks-ass.net>
 <08d51131-7802-5bfe-2cae-d116807183d1@intel.com>
 <20180807093615.GY2494@hirez.programming.kicks-ass.net>
 <ace0bebb-91ab-5d40-e7d7-d72d48302fa8@intel.com>
 <20180808075154.GN2494@hirez.programming.kicks-ass.net>
 <5960739f-ee27-b182-3804-7e5d9356457f@intel.com>
Message-ID: <b689b8d4-5fe1-6fae-c873-6e62a273cd07@intel.com>
Date:   Fri, 10 Aug 2018 09:25:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5960739f-ee27-b182-3804-7e5d9356457f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/8/2018 10:33 AM, Reinette Chatre wrote:
> On 8/8/2018 12:51 AM, Peter Zijlstra wrote:
>> On Tue, Aug 07, 2018 at 03:47:15PM -0700, Reinette Chatre wrote:
>>>>  - I don't much fancy people accessing the guts of events like that;
>>>>    would not an inline function like:
>>>>
>>>>    static inline u64 x86_perf_rdpmc(struct perf_event *event)
>>>>    {
>>>> 	u64 val;
>>>>
>>>> 	lockdep_assert_irqs_disabled();
>>>>
>>>> 	rdpmcl(event->hw.event_base_rdpmc, val);
>>>> 	return val;
>>>>    }
>>>>
>>>>    Work for you?
>>>
>>> No. This does not provide accurate results. Implementing the above produces:
>>> pseudo_lock_mea-366   [002] ....    34.950740: pseudo_lock_l2: hits=4096
>>> miss=4
>>
>> But it being an inline function should allow the compiler to optimize
>> and lift the event->hw.event_base_rdpmc load like you now do manually.
>> Also, like Tony already suggested, you can prime that load just fine by
>> doing an extra invocation.
>>
>> (and note that the above function is _much_ simpler than
>> perf_event_read_local())
> 
> Unfortunately I do not find this to be the case. When I implement
> x86_perf_rdpmc() _exactly_ as you suggest above and do the measurement like:
> 
> l2_hits_before = x86_perf_rdpmc(l2_hit_event);
> l2_miss_before = x86_perf_rdpmc(l2_miss_event);
> l2_hits_before = x86_perf_rdpmc(l2_hit_event);
> l2_miss_before = x86_perf_rdpmc(l2_miss_event);
> /* read memory */
> l2_hits_after = x86_perf_rdpmc(l2_hit_event);
> l2_miss_after = x86_perf_rdpmc(l2_miss_event);
> 
> 
> Then the results are not accurate, neither are the consistently
> inaccurate to consider a constant adjustment:
> 
> pseudo_lock_mea-409   [002] ....   194.322611: pseudo_lock_l2: hits=4100
> miss=0
> pseudo_lock_mea-412   [002] ....   195.520203: pseudo_lock_l2: hits=4096
> miss=3
> pseudo_lock_mea-415   [002] ....   196.571114: pseudo_lock_l2: hits=4097
> miss=3
> pseudo_lock_mea-422   [002] ....   197.629118: pseudo_lock_l2: hits=4097
> miss=3
> pseudo_lock_mea-425   [002] ....   198.687160: pseudo_lock_l2: hits=4096
> miss=3
> pseudo_lock_mea-428   [002] ....   199.744156: pseudo_lock_l2: hits=4096
> miss=2
> pseudo_lock_mea-431   [002] ....   200.801131: pseudo_lock_l2: hits=4097
> miss=2
> pseudo_lock_mea-434   [002] ....   201.858141: pseudo_lock_l2: hits=4097
> miss=2
> pseudo_lock_mea-437   [002] ....   202.917168: pseudo_lock_l2: hits=4096
> miss=2
> 
> I was able to test Tony's theory and replacing the reading of the
> "after" counts with a direct rdpmcl() improve the results. What I mean
> is this:
> 
> l2_hit_pmcnum = x86_perf_rdpmc_ctr_get(l2_hit_event);
> l2_miss_pmcnum = x86_perf_rdpmc_ctr_get(l2_miss_event);
> l2_hits_before = x86_perf_rdpmc(l2_hit_event);
> l2_miss_before = x86_perf_rdpmc(l2_miss_event);
> l2_hits_before = x86_perf_rdpmc(l2_hit_event);
> l2_miss_before = x86_perf_rdpmc(l2_miss_event);
> /* read memory */
> rdpmcl(l2_hit_pmcnum, l2_hits_after);
> rdpmcl(l2_miss_pmcnum, l2_miss_after);
> 
> I did not run my full tests with the above but a simple read of 256KB
> pseudo-locked memory gives:
> pseudo_lock_mea-492   [002] ....   372.001385: pseudo_lock_l2: hits=4096
> miss=0
> pseudo_lock_mea-495   [002] ....   373.059748: pseudo_lock_l2: hits=4096
> miss=0
> pseudo_lock_mea-498   [002] ....   374.117027: pseudo_lock_l2: hits=4096
> miss=0
> pseudo_lock_mea-501   [002] ....   375.182864: pseudo_lock_l2: hits=4096
> miss=0
> pseudo_lock_mea-504   [002] ....   376.243958: pseudo_lock_l2: hits=4096
> miss=0
> 
> We thus seem to be encountering the issue Tony predicted where the
> memory being tested is evicting the earlier measurement code and data.

I thoroughly reviewed this email thread to ensure that all your feedback
is being addressed. At this time I believe the current solution does so
since it addresses all requirements I was able to capture:
- Use in-kernel interface to perf.
- Do not write directly to PMU registers.
- Do not introduce another PMU owner. perf maintains role as performing
  resource arbitration for PMU.
- User space is able to use perf and resctrl at the same time.
- event_base_rdpmc is accessed and used only within an interrupts
  disabled section.
- Internals of events are never accessed directly, inline function used.
- Due to "pinned" usage the scheduling of event may have failed.  Error
  state is checked in recommended way and have a credible error
  handling.
- use X86_CONFIG

The pseudocode of the current solution is presented below. With this
solution I am able to address our customer requirement to be able to
measure a pseudo-locked region accurately while also addressing your
requirements to use perf correctly.

Is this solution acceptable to you?

#include "../../events/perf_event.h" /* For X86_CONFIG() */

/*
 * The X86_CONFIG() macro cannot be used in
 * a designated initializer as below - the initialization of
 * the .config attribute is thus deferred to later in order
 * to use X86_CONFIG
 */

static struct perf_event_attr l2_miss_attr = {
        .type           = PERF_TYPE_RAW,
        .size           = sizeof(struct perf_event_attr),
        .pinned         = 1,
        .disabled       = 0,
        .exclude_user   = 1
};

static struct perf_event_attr l2_hit_attr = {
        .type           = PERF_TYPE_RAW,
        .size           = sizeof(struct perf_event_attr),
        .pinned         = 1,
        .disabled       = 0,
        .exclude_user   = 1
};

static inline int x86_perf_rdpmc_ctr_get(struct perf_event *event)
{
        lockdep_assert_irqs_disabled();

        return IS_ERR(event) ? 0 : event->hw.event_base_rdpmc;
}

static inline int x86_perf_event_error_state(struct perf_event *event)
{
        int ret = 0;
        u64 tmp;

        ret = perf_event_read_local(event, &tmp, NULL, NULL);
        if (ret < 0)
                return ret;

        if (event->attr.pinned && event->oncpu != smp_processor_id())
                return -EBUSY;

        return ret;
}

/*
 * Below is run by kernel thread on correct CPU as triggered
 * by user via debugfs
 */
static int measure_cycles_perf_fn(...)
{
        u64 l2_hits_before, l2_hits_after, l2_miss_before, l2_miss_after;
        struct perf_event *l2_miss_event, *l2_hit_event;
        int l2_hit_pmcnum, l2_miss_pmcnum;
        /* Other vars */

        l2_miss_attr.config = X86_CONFIG(.event=0xd1, .umask=0x10);
        l2_hit_attr.config = X86_CONFIG(.event=0xd1, .umask=0x2);
        l2_miss_event = perf_event_create_kernel_counter(&l2_miss_attr,
                                                         cpu,
                                                         NULL, NULL, NULL);
        if (IS_ERR(l2_miss_event))
                goto out;

        l2_hit_event = perf_event_create_kernel_counter(&l2_hit_attr,
                                                        cpu,
                                                        NULL, NULL, NULL);
        if (IS_ERR(l2_hit_event))
                goto out_l2_miss;

        local_irq_disable();
        if (x86_perf_event_error_state(l2_miss_event)) {
                local_irq_enable();
                goto out_l2_hit;
        }
        if (x86_perf_event_error_state(l2_hit_event)) {
                local_irq_enable();
                goto out_l2_hit;
        }
        /* Disable hardware prefetchers */
        /* Initialize local variables */
        l2_hit_pmcnum = x86_perf_rdpmc_ctr_get(l2_hit_event);
        l2_miss_pmcnum = x86_perf_rdpmc_ctr_get(l2_miss_event);
        rdpmcl(l2_hit_pmcnum, l2_hits_before);
        rdpmcl(l2_miss_pmcnum, l2_miss_before);
        /*
         * From SDM: Performing back-to-back fast reads are not guaranteed
         * to be monotonic. To guarantee monotonicity on back-toback reads,
         * a serializing instruction must be placed between the two
         * RDPMC instructions
         */
        rmb();
        rdpmcl(l2_hit_pmcnum, l2_hits_before);
        rdpmcl(l2_miss_pmcnum, l2_miss_before);
        rmb();
        /* Loop through pseudo-locked memory */
        rdpmcl(l2_hit_pmcnum, l2_hits_after);
        rdpmcl(l2_miss_pmcnum, l2_miss_after);
        rmb();
        /* Re-enable hardware prefetchers */
        local_irq_enable();
        /* Write results to kernel tracepoints */
out_l2_hit:
        perf_event_release_kernel(l2_hit_event);
out_l2_miss:
        perf_event_release_kernel(l2_miss_event);
out:
        /* Cleanup */
}

Your feedback has been valuable and greatly appreciated.

Reinette

