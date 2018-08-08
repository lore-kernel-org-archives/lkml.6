Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045BDC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B022177D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B022177D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeHHTxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:53:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:52842 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeHHTxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:53:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 10:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,458,1531810800"; 
   d="scan'208";a="60894521"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.134]) ([10.24.14.134])
  by fmsmga007.fm.intel.com with ESMTP; 08 Aug 2018 10:33:02 -0700
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
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
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <5960739f-ee27-b182-3804-7e5d9356457f@intel.com>
Date:   Wed, 8 Aug 2018 10:33:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180808075154.GN2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Tony,

On 8/8/2018 12:51 AM, Peter Zijlstra wrote:
> On Tue, Aug 07, 2018 at 03:47:15PM -0700, Reinette Chatre wrote:
>>> FWIW, how long is that IRQ disabled section? It looks like something
>>> that could be taking a bit of time. We have these people that care about
>>> IRQ latency.
>>
>> We work closely with customers needing low latency as well as customers
>> needing deterministic behavior.
>>
>> This measurement is triggered by the user as a validation mechanism of
>> the pseudo-locked memory region after it has been created as part of
>> system setup as well as during runtime if there are any concerns with
>> the performance of an application that uses it.
>>
>> This measurement would thus be triggered before the sensitive workloads
>> start - during system setup, or if an issue is already present. In
>> either case the measurement is triggered by the administrator via debugfs.
> 
> That does not in fact include the answer to the question. Also, it
> assumes a competent operator (something I've found is not always true).

My apologies, I did not intend to avoid your question. The main goal of
this measurement is for an operator to test if a pseudo-locked region
has been set up correctly. It is thus targeted for system setup time,
before the IRQ sensitive workloads - some of which would use these
memory regions - start.

>>>  - I don't much fancy people accessing the guts of events like that;
>>>    would not an inline function like:
>>>
>>>    static inline u64 x86_perf_rdpmc(struct perf_event *event)
>>>    {
>>> 	u64 val;
>>>
>>> 	lockdep_assert_irqs_disabled();
>>>
>>> 	rdpmcl(event->hw.event_base_rdpmc, val);
>>> 	return val;
>>>    }
>>>
>>>    Work for you?
>>
>> No. This does not provide accurate results. Implementing the above produces:
>> pseudo_lock_mea-366   [002] ....    34.950740: pseudo_lock_l2: hits=4096
>> miss=4
> 
> But it being an inline function should allow the compiler to optimize
> and lift the event->hw.event_base_rdpmc load like you now do manually.
> Also, like Tony already suggested, you can prime that load just fine by
> doing an extra invocation.
> 
> (and note that the above function is _much_ simpler than
> perf_event_read_local())

Unfortunately I do not find this to be the case. When I implement
x86_perf_rdpmc() _exactly_ as you suggest above and do the measurement like:

l2_hits_before = x86_perf_rdpmc(l2_hit_event);
l2_miss_before = x86_perf_rdpmc(l2_miss_event);
l2_hits_before = x86_perf_rdpmc(l2_hit_event);
l2_miss_before = x86_perf_rdpmc(l2_miss_event);
/* read memory */
l2_hits_after = x86_perf_rdpmc(l2_hit_event);
l2_miss_after = x86_perf_rdpmc(l2_miss_event);


Then the results are not accurate, neither are the consistently
inaccurate to consider a constant adjustment:

pseudo_lock_mea-409   [002] ....   194.322611: pseudo_lock_l2: hits=4100
miss=0
pseudo_lock_mea-412   [002] ....   195.520203: pseudo_lock_l2: hits=4096
miss=3
pseudo_lock_mea-415   [002] ....   196.571114: pseudo_lock_l2: hits=4097
miss=3
pseudo_lock_mea-422   [002] ....   197.629118: pseudo_lock_l2: hits=4097
miss=3
pseudo_lock_mea-425   [002] ....   198.687160: pseudo_lock_l2: hits=4096
miss=3
pseudo_lock_mea-428   [002] ....   199.744156: pseudo_lock_l2: hits=4096
miss=2
pseudo_lock_mea-431   [002] ....   200.801131: pseudo_lock_l2: hits=4097
miss=2
pseudo_lock_mea-434   [002] ....   201.858141: pseudo_lock_l2: hits=4097
miss=2
pseudo_lock_mea-437   [002] ....   202.917168: pseudo_lock_l2: hits=4096
miss=2

I was able to test Tony's theory and replacing the reading of the
"after" counts with a direct rdpmcl() improve the results. What I mean
is this:

l2_hit_pmcnum = x86_perf_rdpmc_ctr_get(l2_hit_event);
l2_miss_pmcnum = x86_perf_rdpmc_ctr_get(l2_miss_event);
l2_hits_before = x86_perf_rdpmc(l2_hit_event);
l2_miss_before = x86_perf_rdpmc(l2_miss_event);
l2_hits_before = x86_perf_rdpmc(l2_hit_event);
l2_miss_before = x86_perf_rdpmc(l2_miss_event);
/* read memory */
rdpmcl(l2_hit_pmcnum, l2_hits_after);
rdpmcl(l2_miss_pmcnum, l2_miss_after);

I did not run my full tests with the above but a simple read of 256KB
pseudo-locked memory gives:
pseudo_lock_mea-492   [002] ....   372.001385: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-495   [002] ....   373.059748: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-498   [002] ....   374.117027: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-501   [002] ....   375.182864: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-504   [002] ....   376.243958: pseudo_lock_l2: hits=4096
miss=0

We thus seem to be encountering the issue Tony predicted where the
memory being tested is evicting the earlier measurement code and data.

>>>  - native_read_pmc(); are you 100% sure this code only ever runs on
>>>    native and not in some dodgy virt environment?
>>
>> My understanding is that a virtual environment would be a customer of a
>> RDT allocation (cache or memory bandwidth). I do not see if/where this
>> is restricted though - I'll move to rdpmcl() but the usage of a cache
>> allocation feature like this from a virtual machine needs more
>> investigation.
> 
> I can imagine that hypervisors that allow physical partitioning could
> allow delegating the rdt crud to their guests when they 'own' a full
> socket or whatever the domain is for this.

I am using rdpmcl() now

> 
>> Will do. I created the following helper function that can be used after
>> interrupts are disabled:
>>
>> static inline int perf_event_error_state(struct perf_event *event)
>> {
>>         int ret = 0;
>>         u64 tmp;
>>
>>         ret = perf_event_read_local(event, &tmp, NULL, NULL);
>>         if (ret < 0)
>>                 return ret;
>>
>>         if (event->attr.pinned && event->oncpu != smp_processor_id())
>>                 return -EBUSY;
>>
>>         return ret;
>> }
> 
> Nah, stick the test in perf_event_read_local(), that actually needs it.

I will keep this outside for now since it does not seem as though
perf_event_read_local() works well for this use case.


>>> Also, while you disable IRQs, your fancy pants loop is still subject to
>>> NMIs that can/will perturb your measurements, how do you deal with
>>> those?
> 
>> Customers interested in this feature are familiar with dealing with them
>> (and also SMIs). The user space counterpart is able to detect such an
>> occurrence.
> 
> You're very optimistic about your customers capabilities. And this might
> be true for the current people you're talking to, but once this is
> available and public, joe monkey will have access and he _will_ screw it
> up.

I think this ventures into an area that is an existing issue for all
workloads that fall into this category, not unique to this.

> 
>> Please note that if an NMI arrives it would be handled with the
>> currently active cache capacity bitmask so none of the pseudo-locked
>> memory will be evicted since no capacity bitmask overlaps with the
>> pseudo-locked region.
> 
> So exceptions change / have their own bitmask?

My understanding is that interrupts are run with the current active
capacity bitmask. The capacity bitmasks specify which portions of cache
a cpu and/or task may allocate into. No capacity bitmask would overlap
with the pseudo-locked region and thus no cpu or task would be able to
evict the data from the pseudo-locked region. Even if later interrupts
do obtain their own class of service with its own capacity bitmasks -
these btimasks would still not be allowed to overlap with the
pseudo-locked region.

Reinette


