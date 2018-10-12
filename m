Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6DAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACECC2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACECC2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJLOfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 10:35:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:57543 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeJLOfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 10:35:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 00:04:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="scan'208";a="240733462"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2018 00:04:40 -0700
Received: from [10.125.251.247] (abudanko-mobl.ccr.corp.intel.com [10.125.251.247])
        by linux.intel.com (Postfix) with ESMTP id 43CEE58015C;
        Fri, 12 Oct 2018 00:04:37 -0700 (PDT)
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
To:     Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "eranian@google.com" <eranian@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <D2014055-9B25-4152-A582-7AD42A3837AB@fb.com>
 <20181011092913.GA9848@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <162cce00-745c-6e30-f859-497d9307059d@linux.intel.com>
Date:   Fri, 12 Oct 2018 10:04:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011092913.GA9848@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11.10.2018 12:29, Peter Zijlstra wrote:
> On Thu, Oct 11, 2018 at 07:50:23AM +0000, Song Liu wrote:
>> Hi Peter, 
>>
>> I am trying to understand this. Pardon me if any question is silly. 
>>
>> I am not sure I fully understand the motivation here. I guess we
>> see problem when there are two (or more) independent hardware PMUs 
>> per cpu? Then on a given cpu, there are two (or more) 
>> perf_cpu_context, but only one task context? 
> 
> Right.
> 
>> If this is correct (I really doubt...), I guess perf_rotate_context()
>> is the problem? 
> 
> No, everything comes apart. Where would you put the events of the second
> PMU?
> 
> The thing most often proposed it pretending the second PMU is a
> 'software' PMU and sticking the events on the software PMU context.
> 
> But because software PMUs must never fail to schedule an event, that
> results in some quite horrible things -- including that we cannot RR the
> events.
> 
> Similarly the big.little guys have the problem that the PMUs are not the
> same between big and little cores, and they fudge something horrible. By
> having clear ordering on PMU, that can be cleaned up too.
> 
>> And if this is still correct, this patch may not help,
>> as we are doing rotation for each perf_cpu_pmu_context? (or rotation 
>> per perf_event_context is the next step?). 
> 
> We do indeed to rotation per perf_cpu_pmu_context, however:
> 
>  - perf_cpu_pmu_context embeds a cpu scope perf_event_pmu_context,
>  - perf_cpu_pmu_context tracks the currently associated task scope
>    perf_event_pmu_context.
> 
> So it can rotate all current events for a particular PMU.
> 
>> Or step back a little... I see two big changes:
>>
>> 1. struct perf_ctx_context is now per cpu (instead of per pmu per cpu);
>> 2. one perf_event_ctxp per task_struct (instead of 2).  
> 
> Correct, we reduce to 1 cpu context and 1 task context at all times.
> This in fact simplifies quite a bit of things.

And what is currently missing is 
some markup of the per cpu event list into per pmu sublists and 
capability to rotate or not rotate the sublists independently, 
right?

Thanks,
Alexey

> 
>> I think #1 is a bigger change than #2. Is this correct? 
> 
> They're the 'same' change. But yes the primary purpose was 2, but having
> only a single cpu context is a direct consequence.
> 
>> Could you please help me understand it better? 
> 
> I hope this helps to understand, please feel free to ask more.
> 
