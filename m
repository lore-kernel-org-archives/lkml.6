Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6542177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6542177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeHCUem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:34:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:32824 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbeHCUem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:34:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 11:37:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,439,1526367600"; 
   d="scan'208";a="61905944"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.252.128.249]) ([10.252.128.249])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2018 11:37:14 -0700
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
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
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
Date:   Fri, 3 Aug 2018 11:37:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180803152523.GY2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/3/2018 8:25 AM, Peter Zijlstra wrote:
> On Fri, Aug 03, 2018 at 08:18:09AM -0700, Reinette Chatre wrote:
>> You state that you understand what we are trying to do and I hope that I
>> convinced you that we are not able to accomplish the same by following
>> your guidance.
> 
> No, I said I understood your pmc reserve patch and its implications.
> 
> I have no clue what you're trying to do with resctl, nor why you think
> this is not feasible with perf. And if it really is not feasible, you'll
> have to live without it.

I can surely provide the details on what we are doing with resctrl and
elaborate more on why this is not feasible with the full perf kernel API.

In summary:
Building on top of Cache Allocation Technology (CAT) we load a portion
of memory into a specified region of cache. After the region of cache
obtained its data it (the cache region) is configured (via CAT) to only
serve cache hits - this pre-loaded memory cannot be evicted from the
cache. We call this "cache pseudo-locking" - the memory has been
"pseudo-locked" to the cache.

To measure how successful the pseudo-locking of the memory is we can use
the precision capable performance events on our platforms: start the
cache hits and miss counters, read the pseudo-locked memory, stop the
counters. This measurement is done with interrupts and hardware
prefetchers disabled to ensure that _only_ access to the pseudo-locked
memory is measured.

Any additional code or data accessed either by the counter management or
even by the loops reading the memory itself can contribute to cache
hits/misses measured for that instead of the memory we are trying to access.

Even within the current measurement code we had to take a lot of care to
not use, for example, pointers to obtain information about the memory to
be measured. The information had to be local variables.

Looking at if we were to build on top of the kernel perf event API
(perf_event_create_kernel_counter(), perf_event_enable(),
perf_event_disable(), ...). Just looking at perf_event_enable() -
ideally this would be as lean as possible to only enable the event and
not result in itself contributing the the measurement. First, the
enabling of the event is not as lean to fulfill this requirement since
it executes more code after the event was actually enabled. Also, the
code relies on a mutex so we cannot use it with interrupts disabled.

We have two types of customers of this feature: those who require very
low latency and those who require high determinism. In either case a
measured cache miss is of concern to them and our goal is to provide a
memory region for which the number of cache misses can be demonstrated.

Reinette
