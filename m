Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68982C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BDB21A6C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BDB21A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbeHFWBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:01:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:23205 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbeHFWBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:01:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 12:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="77991857"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.136]) ([10.24.14.136])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2018 12:50:53 -0700
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20180802161823.GJ2458@hirez.programming.kicks-ass.net>
 <f990df31-ab75-974e-b142-47af07a33a08@intel.com>
 <20180802173727.GP2494@hirez.programming.kicks-ass.net>
 <653e874f-5e77-a9b5-996a-ed9daa3c6d43@intel.com>
 <20180802195410.GR2494@hirez.programming.kicks-ass.net>
 <d64f85e8-98ca-a81d-bf2d-13dd72fc411e@intel.com>
 <20180802201312.GS2494@hirez.programming.kicks-ass.net>
 <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
 <20180803104956.GU2494@hirez.programming.kicks-ass.net>
 <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
 <20180803152523.GY2476@hirez.programming.kicks-ass.net>
 <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
Message-ID: <57c011e1-113d-c38f-c318-defbad085843@intel.com>
Date:   Mon, 6 Aug 2018 12:50:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/3/2018 11:37 AM, Reinette Chatre wrote:
> On 8/3/2018 8:25 AM, Peter Zijlstra wrote:
>> On Fri, Aug 03, 2018 at 08:18:09AM -0700, Reinette Chatre wrote:
>>> You state that you understand what we are trying to do and I hope that I
>>> convinced you that we are not able to accomplish the same by following
>>> your guidance.
>>
>> No, I said I understood your pmc reserve patch and its implications.
>>
>> I have no clue what you're trying to do with resctl, nor why you think
>> this is not feasible with perf. And if it really is not feasible, you'll
>> have to live without it.

In my previous email I provided the details of the Cache Pseudo-Locking
feature implemented on top of resctrl. Please let me know if you would
like any more details about that. I can send you more materials.

In my previous message I also provided the thoughts on why I believe
same is not feasible with perf as commented below ...

> Looking at if we were to build on top of the kernel perf event API
> (perf_event_create_kernel_counter(), perf_event_enable(),
> perf_event_disable(), ...). Just looking at perf_event_enable() -
> ideally this would be as lean as possible to only enable the event and
> not result in itself contributing the the measurement. First, the
> enabling of the event is not as lean to fulfill this requirement since
> it executes more code after the event was actually enabled. Also, the
> code relies on a mutex so we cannot use it with interrupts disabled.

I proceeded to modify the implemented debugfs measurements to build on
top of the perf APIs mentioned above. As anticipated the events could
not be enabled in interrupt context. I get a clear message in this regard:

BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:748

I thus continued to use the API with interrupts enabled did the following:

Two new event attributes:
static struct perf_event_attr l2_miss_attr = {
        .type           = PERF_TYPE_RAW,
        .config         = (0x10ULL << 8) | 0xd1,
        .size           = sizeof(struct perf_event_attr),
        .pinned         = 1,
        .disabled       = 1,
        .exclude_user   = 1
};

static struct perf_event_attr l2_hit_attr = {
        .type           = PERF_TYPE_RAW,
        .config         = (0x2ULL << 8) | 0xd1,
        .size           = sizeof(struct perf_event_attr),
        .pinned         = 1,
        .disabled       = 1,
        .exclude_user   = 1
};

Create the two new events using these attributes:
l2_miss_event = perf_event_create_kernel_counter(&l2_miss_attr, cpu,
NULL, NULL, NULL);
l2_hit_event = perf_event_create_kernel_counter(&l2_hit_attr, cpu, NULL,
NULL, NULL);

Take measurements:
perf_event_enable(l2_miss_event);
perf_event_enable(l2_hit_event);
local_irq_disable();
/* Disable hardware prefetchers */
/* Loop through pseudo-locked memory */
/* Enable hardware prefetchers */
local_irq_enable();
perf_event_disable(l2_hit_event);
perf_event_disable(l2_miss_event);

Read results:
l2_hits = perf_event_read_value(l2_hit_event, &enabled, &running);
l2_miss = perf_event_read_value(l2_miss_event, &enabled, &running);
/* Make results available in tracepoints */


With the above implementation and a 256KB pseudo-locked memory region I
obtain the following results:
pseudo_lock_mea-755   [002] ....   396.946953: pseudo_lock_l2: hits=4140
miss=5
pseudo_lock_mea-762   [002] ....   397.998864: pseudo_lock_l2: hits=4138
miss=8
pseudo_lock_mea-765   [002] ....   399.041868: pseudo_lock_l2: hits=4142
miss=5
pseudo_lock_mea-768   [002] ....   400.086871: pseudo_lock_l2: hits=4141
miss=7
pseudo_lock_mea-771   [002] ....   401.132921: pseudo_lock_l2: hits=4138
miss=10
pseudo_lock_mea-774   [002] ....   402.216700: pseudo_lock_l2: hits=4238
miss=46
pseudo_lock_mea-777   [002] ....   403.312148: pseudo_lock_l2: hits=4142
miss=5
pseudo_lock_mea-780   [002] ....   404.381674: pseudo_lock_l2: hits=4139
miss=8
pseudo_lock_mea-783   [002] ....   405.422820: pseudo_lock_l2: hits=4472
miss=79
pseudo_lock_mea-786   [002] ....   406.495065: pseudo_lock_l2: hits=4140
miss=8
pseudo_lock_mea-793   [002] ....   407.561383: pseudo_lock_l2: hits=4143
miss=4

The above results are not accurate since it does not reflect the success
of the pseudo-locked region. Expected results are as we can currently
obtain (copying results from previous email):
pseudo_lock_mea-26090 [002] .... 61838.488027: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26097 [002] .... 61843.689381: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26100 [002] .... 61848.751411: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26108 [002] .... 61853.820361: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26111 [002] .... 61858.880364: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26118 [002] .... 61863.937343: pseudo_lock_l2: hits=4096
miss=0
pseudo_lock_mea-26121 [002] .... 61869.008341: pseudo_lock_l2: hits=4096
miss=0

Could you please guide me on how you would prefer us to use perf in
order to obtain the same accurate results we can now?

Thank you very much

Reinette













