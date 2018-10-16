Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ED9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6727120881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6727120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeJPO2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:28:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:21507 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbeJPO2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:28:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 23:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,387,1534834800"; 
   d="scan'208";a="241660898"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 15 Oct 2018 23:39:08 -0700
Received: from [10.125.252.40] (abudanko-mobl.ccr.corp.intel.com [10.125.252.40])
        by linux.intel.com (Postfix) with ESMTP id 6C87C580444;
        Mon, 15 Oct 2018 23:39:05 -0700 (PDT)
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, songliubraving@fb.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>, megha.dey@intel.com,
        frederic@kernel.org
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
 <20181015083448.GN9867@hirez.programming.kicks-ass.net>
 <a7cd88d6-a379-2d3b-7fde-e313328a3381@linux.intel.com>
 <CABPqkBQ48dM0bTFr_o3pSpAP8e_aH5gHeqXEdkPS0LY3bxBtLw@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d2cd65bc-7f30-43ec-638c-53fb94245e36@linux.intel.com>
Date:   Tue, 16 Oct 2018 09:39:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABPqkBQ48dM0bTFr_o3pSpAP8e_aH5gHeqXEdkPS0LY3bxBtLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15.10.2018 21:31, Stephane Eranian wrote:
> Hi,
> 
> On Mon, Oct 15, 2018 at 10:29 AM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>>
>> Hi,
>> On 15.10.2018 11:34, Peter Zijlstra wrote:
>>> On Mon, Oct 15, 2018 at 10:26:06AM +0300, Alexey Budankov wrote:
>>>> Hi,
>>>>
>>>> On 10.10.2018 13:45, Peter Zijlstra wrote:
>>>>> Hi all,
>>>>>
>>>>> There have been various issues and limitations with the way perf uses
>>>>> (task) contexts to track events. Most notable is the single hardware PMU
>>>>> task context, which has resulted in a number of yucky things (both
>>>>> proposed and merged).
>>>>>
>>>>> Notably:
>>>>>
>>>>>  - HW breakpoint PMU
>>>>>  - ARM big.little PMU
>>>>>  - Intel Branch Monitoring PMU
>>>>>
>>>>> Since we now track the events in RB trees, we can 'simply' add a pmu
>>>>> order to them and have them grouped that way, reducing to a single
>>>>> context. Of course, reality never quite works out that simple, and below
>>>>> ends up adding an intermediate data structure to bridge the context ->
>>>>> pmu mapping.
>>>>>
>>>>> Something a little like:
>>>>>
>>>>>               ,------------------------[1:n]---------------------.
>>>>>               V                                                  V
>>>>>     perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
>>>>>               ^                      ^     |                     |
>>>>>               `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
>>>>>
>>>>> This patch builds (provided you disable CGROUP_PERF), boots and survives
>>>>> perf-top without the machine catching fire.
>>>>>
>>>>> There's still a fair bit of loose ends (look for XXX), but I think this
>>>>> is the direction we should be going.
>>>>>
>>>>> Comments?
>>>>>
>>>>> Not-Quite-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>>> ---
>>>>>  arch/powerpc/perf/core-book3s.c |    4
>>>>>  arch/x86/events/core.c          |    4
>>>>>  arch/x86/events/intel/core.c    |    6
>>>>>  arch/x86/events/intel/ds.c      |    6
>>>>>  arch/x86/events/intel/lbr.c     |   16
>>>>>  arch/x86/events/perf_event.h    |    6
>>>>>  include/linux/perf_event.h      |   80 +-
>>>>>  include/linux/sched.h           |    2
>>>>>  kernel/events/core.c            | 1412 ++++++++++++++++++++--------------------
>>>>>  9 files changed, 815 insertions(+), 721 deletions(-)
>>>>
>>>> Rewrite is impressive however it doesn't result in code base reduction as it is.
>>>
>>> Yeah.. that seems to be nature of these things ..
>>>
>>>> Nonetheless there is a clear demand for per pmu events groups tracking and rotation
>>>> in single cpu context (HW breakpoints, ARM big.little, Intel LBRs) and there is
>>>> a supply thru groups ordering on RB-tree.
>>>>
>>>> This might be driven into the kernel by some new Perf features that would base on
>>>> that RB-tree groups ordering or by refactoring of existing code but in the way it
>>>> would result in overall code base reduction thus lowering support cost.
>>>
>>> If you have a concrete suggestion on how to reduce complexity? I tried,
>>> but couldn't find any (without breaking something).
>>
>> Could some of those PMUs (HW breakpoints, ARM big.little, Intel LBRs)
>> or other Perf related code be adjusted now so that overall subsystem
>> code base would reduce?
>>
> I have always had a hard time understanding the role of all these structs in
> the generic code. This is still very confusing and very hard to follow.
> 
> In my mind, you have per-task and per-cpu perf_events contexts.
> And for each you can have multiple PMUs, some hw some sw.
> Each PMU has its own list of events maintained in RB tree. There is
> never any interactions between PMUs.
> 
> Maybe this is how this is done or proposed by your patches, but it
> certainly is not
> obvious.
> 
> Also the Intel LBR is not a PMU on is own. Maybe you are talking about
> the BTS in
> arch/x86/even/sintel/bts.c.

I am referring to Intel Branch Monitoring PMU mentioned in the description. 
Thanks for correction.

- Alexey
> 
> 
>>>
>>> The active lists and pmu_ctx_list could arguably be replaced with
>>> (slower) iteratons over the RB tree, but you'll still need the per pmu
>>> nr_events/nr_active counts to determine if rotation is required at all.
>>>
>>> And like you know, performance is quite important here too. I'd love to
>>> reduce complexity while maintaining or improve performance, but that
>>> rarely if ever happens :/
>>>
> 
