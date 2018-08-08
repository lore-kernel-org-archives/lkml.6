Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF96DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FA421721
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FA421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeHHICn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:02:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:9750 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeHHICn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:02:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 22:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="64412502"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.79.133]) ([10.254.79.133])
  by orsmga006.jf.intel.com with ESMTP; 07 Aug 2018 22:44:46 -0700
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
To:     "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "Hindman, Gavin" <gavin.hindman@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d64f85e8-98ca-a81d-bf2d-13dd72fc411e@intel.com>
 <20180802201312.GS2494@hirez.programming.kicks-ass.net>
 <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
 <20180803104956.GU2494@hirez.programming.kicks-ass.net>
 <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
 <20180803152523.GY2476@hirez.programming.kicks-ass.net>
 <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
 <57c011e1-113d-c38f-c318-defbad085843@intel.com>
 <20180806221225.GO2458@hirez.programming.kicks-ass.net>
 <08d51131-7802-5bfe-2cae-d116807183d1@intel.com>
 <20180807093615.GY2494@hirez.programming.kicks-ass.net>
 <ace0bebb-91ab-5d40-e7d7-d72d48302fa8@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7D3A10EF@ORSMSX110.amr.corp.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <413c3b6f-770d-9549-4249-c2407267b63c@intel.com>
Date:   Tue, 7 Aug 2018 22:44:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D3A10EF@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/7/2018 6:28 PM, Luck, Tony wrote:
> Would it help to call routines to read the "before" values of the counter
> twice. The first time to preload the cache with anything needed to execute
> the perf code path.

>>> In an attempt to improve the accuracy of the above I modified it to the
>>> following:
>>>
>>> /* create the two events as before in "enabled" state */
>>> l2_hit_pmcnum = l2_hit_event->hw.event_base_rdpmc;
>>> l2_miss_pmcnum = l2_miss_event->hw.event_base_rdpmc;
>>> local_irq_disable();
>>> /* disable hw prefetchers */
>>> /* init local vars to loop through pseudo-locked mem
>       * may take some misses in the perf code
>       */
>      l2_hits_before = native_read_pmc(l2_hit_pmcnum);
>      l2_miss_before = native_read_pmc(l2_miss_pmcnum);
>      /* Read counters again, hope no new misses here */
>>> l2_hits_before = native_read_pmc(l2_hit_pmcnum);
>>> l2_miss_before = native_read_pmc(l2_miss_pmcnum);
>>> /* loop through pseudo-locked mem */
>>> l2_hits_after = native_read_pmc(l2_hit_pmcnum);
>>> l2_miss_after = native_read_pmc(l2_miss_pmcnum);
>>> /* enable hw prefetchers */
>>> local_irq_enable();
>

The end of my previous email to Peter contains a solution that does
address all the feedback received up to this point while also able to
obtain (what I thought to be ... more below) accurate results. The code
you comment on below is not this latest version but your suggestion is
valuable and I do try it out on two different ways from what you quote
below to read the perf data.

So, instead of reading data with native_read_pmc() as in the code you
quoted I first test when reading data twice using the original
recommendation of "perf_event_read_local()" and second when reading data
twice using "rdpmcl()" chosen instead of native_read_pmc().

First, reading data using perf_event_read_local() called twice.
When testing as follows:
/* create perf events */
/* disable irq */
/* disable hw prefetchers */
/* init local vars */
/* read before data twice as follows: */
perf_event_read_local(l2_hit_event, &l2_hits_before, NULL, NULL);
perf_event_read_local(l2_miss_event, &l2_miss_before, NULL, NULL);
perf_event_read_local(l2_hit_event, &l2_hits_before, NULL, NULL);
perf_event_read_local(l2_miss_event, &l2_miss_before, NULL, NULL);
/* read through pseudo-locked memory */
perf_event_read_local(l2_hit_event, &l2_hits_after, NULL, NULL);
perf_event_read_local(l2_miss_event, &l2_miss_after, NULL, NULL);
/* re enable hw prefetchers */
/* enable irq */
/* write data to tracepoint */

With the above I am not able to obtain accurate data:
pseudo_lock_mea-351   [002] ....    61.859147: pseudo_lock_l2: hits=4109
miss=0
pseudo_lock_mea-354   [002] ....    63.045734: pseudo_lock_l2: hits=4103
miss=6
pseudo_lock_mea-357   [002] ....    64.104673: pseudo_lock_l2: hits=4106
miss=3
pseudo_lock_mea-360   [002] ....    65.174775: pseudo_lock_l2: hits=4105
miss=5
pseudo_lock_mea-367   [002] ....    66.232308: pseudo_lock_l2: hits=4104
miss=5
pseudo_lock_mea-370   [002] ....    67.291844: pseudo_lock_l2: hits=4103
miss=6
pseudo_lock_mea-373   [002] ....    68.348725: pseudo_lock_l2: hits=4105
miss=5
pseudo_lock_mea-376   [002] ....    69.409738: pseudo_lock_l2: hits=4105
miss=5
pseudo_lock_mea-379   [002] ....    70.466763: pseudo_lock_l2: hits=4105
miss=5


Second, reading data using rdpmcl() called twice.
This is the same solution as documented in my previous email, with the
two extra rdpmcl() calls added. An overview of the flow:

/* create perf events */
/* disable irq */
/* check perf event error state */
/* disable hw prefetchers */
/* init local vars */
/* read before data twice as follows: */
rdpmcl(l2_hit_pmcnum, l2_hits_before);
rdpmcl(l2_miss_pmcnum, l2_miss_before);
rdpmcl(l2_hit_pmcnum, l2_hits_before);
rdpmcl(l2_miss_pmcnum, l2_miss_before);
/* read through pseudo-locked memory */
rdpmcl(l2_hit_pmcnum, l2_hits_after);
rdpmcl(l2_miss_pmcnum, l2_miss_after);
/* re enable hw prefetchers */
/* enable irq */
/* write data to tracepoint */

Here as expected a simple test showed that the data was accurate
(hits=4096 miss=0) so I repeated the creation and measurement of
pseudo-locked region at different sizes under different loads. Each
possible pseudo-lock region size is created and measured 100 times on an
idle system and 100 times on a system with a noisy neighbor - this
resulted in a total of 2800 pseudo-lock region creations each followed
by a measurement of that region.

The results of these tests are the best I have yet seen. In this total
of 2800 measurements the number of cache hits were miscounted only in
eight measurements - each miscount was under(?) counted with one.
Specifically, a memory region consisting of 8192 cache lines was
measured as "hits=8191 miss=0", three memory regions with 12288 cache
lines were measured as "hits=12287 miss=0", two memory regions with
10240 cache lines were measured as "hits=10239 miss=0", and two memory
regions with 14336 cache lines were measured as "hits=14335 miss=0".
I do not think that having the number of cache hits reported as one less
than the number of read attempts would be of big concern.
The miss data remained consistent and reported as zero misses - this is
the exact data we were trying to capture!

Thank you so much for your valuable suggestion. I do hope that we could
proceed with this way of measurement.

Reinette
