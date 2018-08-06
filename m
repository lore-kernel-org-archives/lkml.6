Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20114C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF7421A6A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF7421A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbeHGBSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:18:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:36538 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731697AbeHGBSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:18:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 16:07:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="78041579"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.136]) ([10.24.14.136])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2018 16:07:09 -0700
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <653e874f-5e77-a9b5-996a-ed9daa3c6d43@intel.com>
 <20180802195410.GR2494@hirez.programming.kicks-ass.net>
 <d64f85e8-98ca-a81d-bf2d-13dd72fc411e@intel.com>
 <20180802201312.GS2494@hirez.programming.kicks-ass.net>
 <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
 <20180803104956.GU2494@hirez.programming.kicks-ass.net>
 <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
 <20180803152523.GY2476@hirez.programming.kicks-ass.net>
 <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
 <57c011e1-113d-c38f-c318-defbad085843@intel.com>
 <20180806221225.GO2458@hirez.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <08d51131-7802-5bfe-2cae-d116807183d1@intel.com>
Date:   Mon, 6 Aug 2018 16:07:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180806221225.GO2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/6/2018 3:12 PM, Peter Zijlstra wrote:
> On Mon, Aug 06, 2018 at 12:50:50PM -0700, Reinette Chatre wrote:
>> In my previous email I provided the details of the Cache Pseudo-Locking
>> feature implemented on top of resctrl. Please let me know if you would
>> like any more details about that. I can send you more materials.
> 
> I've no yet had time to read..
> 
>> BUG: sleeping function called from invalid context at
>> kernel/locking/mutex.c:748
>>
>> I thus continued to use the API with interrupts enabled did the following:
>>
>> Two new event attributes:
>> static struct perf_event_attr l2_miss_attr = {
>>         .type           = PERF_TYPE_RAW,
>>         .config         = (0x10ULL << 8) | 0xd1,
> 
> Please use something like:
> 
> 		X86_CONFIG(.event=0xd1, .umask=0x10),
> 
> that's ever so much more readable.
> 
>>         .size           = sizeof(struct perf_event_attr),
>>         .pinned         = 1,
>>         .disabled       = 1,
>>         .exclude_user   = 1
>> };
>>
>> static struct perf_event_attr l2_hit_attr = {
>>         .type           = PERF_TYPE_RAW,
>>         .config         = (0x2ULL << 8) | 0xd1,
>>         .size           = sizeof(struct perf_event_attr),
>>         .pinned         = 1,
>>         .disabled       = 1,
>>         .exclude_user   = 1
>> };
>>
>> Create the two new events using these attributes:
>> l2_miss_event = perf_event_create_kernel_counter(&l2_miss_attr, cpu,
>> NULL, NULL, NULL);
>> l2_hit_event = perf_event_create_kernel_counter(&l2_hit_attr, cpu, NULL,
>> NULL, NULL);
>>
>> Take measurements:
>> perf_event_enable(l2_miss_event);
>> perf_event_enable(l2_hit_event);
>> local_irq_disable();
>> /* Disable hardware prefetchers */
>> /* Loop through pseudo-locked memory */
>> /* Enable hardware prefetchers */
>> local_irq_enable();
>> perf_event_disable(l2_hit_event);
>> perf_event_disable(l2_miss_event);
>>
>> Read results:
>> l2_hits = perf_event_read_value(l2_hit_event, &enabled, &running);
>> l2_miss = perf_event_read_value(l2_miss_event, &enabled, &running);
>> /* Make results available in tracepoints */
> 
> switch to .disabled=0 and try this for measurement:
> 
> 	local_irq_disable();
> 	perf_event_read_local(l2_miss_event, &miss_val1, NULL, NULL);
> 	perf_event_read_local(l2_hit_event, &hit_val1, NULL, NULL);
> 	/* do your thing */
> 	perf_event_read_local(l2_miss_event, &miss_val2, NULL, NULL);
> 	perf_event_read_local(l2_hit_event, &hit_val2, NULL, NULL);
> 	local_irq_enable();

Thank you very much for taking a look and providing your guidance.

> 
> You're running this on the CPU you created the event for, right?

Yes.

I've modified your suggestion slightly in an attempt to gain accuracy.
Now it looks like:

local_irq_disable();
/* disable hw prefetchers */
/* init local vars to loop through pseudo-locked mem */
perf_event_read_local(l2_hit_event, &l2_hits_before, NULL, NULL);
perf_event_read_local(l2_miss_event, &l2_miss_before, NULL, NULL);
/* loop through pseudo-locked mem */
perf_event_read_local(l2_hit_event, &l2_hits_after, NULL, NULL);
perf_event_read_local(l2_miss_event, &l2_miss_after, NULL, NULL);
/* enable hw prefetchers */
local_irq_enable();

With the above I do not see the impact of an interference workload
anymore but the results are not yet accurate:

pseudo_lock_mea-538   [002] ....   113.296084: pseudo_lock_l2: hits=4103
miss=2
pseudo_lock_mea-541   [002] ....   114.349343: pseudo_lock_l2: hits=4102
miss=3
pseudo_lock_mea-544   [002] ....   115.410206: pseudo_lock_l2: hits=4101
miss=4
pseudo_lock_mea-551   [002] ....   116.473912: pseudo_lock_l2: hits=4102
miss=3
pseudo_lock_mea-554   [002] ....   117.532446: pseudo_lock_l2: hits=4100
miss=5
pseudo_lock_mea-557   [002] ....   118.591121: pseudo_lock_l2: hits=4103
miss=2
pseudo_lock_mea-560   [002] ....   119.642467: pseudo_lock_l2: hits=4102
miss=3
pseudo_lock_mea-563   [002] ....   120.698562: pseudo_lock_l2: hits=4102
miss=3
pseudo_lock_mea-566   [002] ....   121.769348: pseudo_lock_l2: hits=4105
miss=4

In an attempt to improve the accuracy of the above I modified it to the
following:

/* create the two events as before in "enabled" state */
l2_hit_pmcnum = l2_hit_event->hw.event_base_rdpmc;
l2_miss_pmcnum = l2_miss_event->hw.event_base_rdpmc;
local_irq_disable();
/* disable hw prefetchers */
/* init local vars to loop through pseudo-locked mem */
l2_hits_before = native_read_pmc(l2_hit_pmcnum);
l2_miss_before = native_read_pmc(l2_miss_pmcnum);
/* loop through pseudo-locked mem */
l2_hits_after = native_read_pmc(l2_hit_pmcnum);
l2_miss_after = native_read_pmc(l2_miss_pmcnum);
/* enable hw prefetchers */
local_irq_enable();

With the above I seem to get the same accuracy as before:
pseudo_lock_mea-557   [002] ....   155.402566: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-564   [002] ....   156.441299: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-567   [002] ....   157.478605: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-570   [002] ....   158.524054: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-573   [002] ....   159.561853: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-576   [002] ....   160.599758: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-579   [002] ....   161.645553: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-582   [002] ....   162.687593: pseudo_lock_l2: hits=4096
miss=0

Would a solution like this perhaps be acceptable to you?

I will continue to do more testing searching for any caveats in this
solution.

>> With the above implementation and a 256KB pseudo-locked memory region I
>> obtain the following results:
>> pseudo_lock_mea-755   [002] ....   396.946953: pseudo_lock_l2: hits=4140
> 
>> The above results are not accurate since it does not reflect the success
>> of the pseudo-locked region. Expected results are as we can currently
>> obtain (copying results from previous email):
>> pseudo_lock_mea-26090 [002] .... 61838.488027: pseudo_lock_l2: hits=4096
> 
> Still fairly close.. only like 44 extra hits or 1% error.

While the results do seem close, reporting a cache miss on memory that
is set up to be locked in cache is significant.

Thank you very much for your patience

Reinette


