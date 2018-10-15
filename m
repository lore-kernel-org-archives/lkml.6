Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4E9C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA52E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA52E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeJPBPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:15:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:59400 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbeJPBPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:15:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 10:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,385,1534834800"; 
   d="scan'208";a="88526405"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Oct 2018 10:29:37 -0700
Received: from [10.252.7.84] (abudanko-mobl.ccr.corp.intel.com [10.252.7.84])
        by linux.intel.com (Postfix) with ESMTP id 6C1ED580487;
        Mon, 15 Oct 2018 10:29:34 -0700 (PDT)
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        mark.rutland@arm.com, megha.dey@intel.com, frederic@kernel.org
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
 <20181015083448.GN9867@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a7cd88d6-a379-2d3b-7fde-e313328a3381@linux.intel.com>
Date:   Mon, 15 Oct 2018 20:29:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015083448.GN9867@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
On 15.10.2018 11:34, Peter Zijlstra wrote:
> On Mon, Oct 15, 2018 at 10:26:06AM +0300, Alexey Budankov wrote:
>> Hi,
>>
>> On 10.10.2018 13:45, Peter Zijlstra wrote:
>>> Hi all,
>>>
>>> There have been various issues and limitations with the way perf uses
>>> (task) contexts to track events. Most notable is the single hardware PMU
>>> task context, which has resulted in a number of yucky things (both
>>> proposed and merged).
>>>
>>> Notably:
>>>
>>>  - HW breakpoint PMU
>>>  - ARM big.little PMU
>>>  - Intel Branch Monitoring PMU
>>>
>>> Since we now track the events in RB trees, we can 'simply' add a pmu
>>> order to them and have them grouped that way, reducing to a single
>>> context. Of course, reality never quite works out that simple, and below
>>> ends up adding an intermediate data structure to bridge the context ->
>>> pmu mapping.
>>>
>>> Something a little like:
>>>
>>>               ,------------------------[1:n]---------------------.
>>>               V                                                  V
>>>     perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
>>>               ^                      ^     |                     |
>>>               `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
>>>
>>> This patch builds (provided you disable CGROUP_PERF), boots and survives
>>> perf-top without the machine catching fire.
>>>
>>> There's still a fair bit of loose ends (look for XXX), but I think this
>>> is the direction we should be going.
>>>
>>> Comments?
>>>
>>> Not-Quite-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> ---
>>>  arch/powerpc/perf/core-book3s.c |    4 
>>>  arch/x86/events/core.c          |    4 
>>>  arch/x86/events/intel/core.c    |    6 
>>>  arch/x86/events/intel/ds.c      |    6 
>>>  arch/x86/events/intel/lbr.c     |   16 
>>>  arch/x86/events/perf_event.h    |    6 
>>>  include/linux/perf_event.h      |   80 +-
>>>  include/linux/sched.h           |    2 
>>>  kernel/events/core.c            | 1412 ++++++++++++++++++++--------------------
>>>  9 files changed, 815 insertions(+), 721 deletions(-)
>>
>> Rewrite is impressive however it doesn't result in code base reduction as it is.
> 
> Yeah.. that seems to be nature of these things ..
> 
>> Nonetheless there is a clear demand for per pmu events groups tracking and rotation 
>> in single cpu context (HW breakpoints, ARM big.little, Intel LBRs) and there is 
>> a supply thru groups ordering on RB-tree.
>>
>> This might be driven into the kernel by some new Perf features that would base on 
>> that RB-tree groups ordering or by refactoring of existing code but in the way it 
>> would result in overall code base reduction thus lowering support cost.
> 
> If you have a concrete suggestion on how to reduce complexity? I tried,
> but couldn't find any (without breaking something).

Could some of those PMUs (HW breakpoints, ARM big.little, Intel LBRs) 
or other Perf related code be adjusted now so that overall subsystem 
code base would reduce?

Thanks,
Alexey

> 
> The active lists and pmu_ctx_list could arguably be replaced with
> (slower) iteratons over the RB tree, but you'll still need the per pmu
> nr_events/nr_active counts to determine if rotation is required at all.
> 
> And like you know, performance is quite important here too. I'd love to
> reduce complexity while maintaining or improve performance, but that
> rarely if ever happens :/
> 
