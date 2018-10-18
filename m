Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E789EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21332087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21332087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeJRPEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:04:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:35541 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbeJRPEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:04:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 00:05:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,395,1534834800"; 
   d="scan'208";a="92966026"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 18 Oct 2018 00:05:16 -0700
Received: from [10.125.252.18] (abudanko-mobl.ccr.corp.intel.com [10.125.252.18])
        by linux.intel.com (Postfix) with ESMTP id 465B2580117;
        Thu, 18 Oct 2018 00:05:13 -0700 (PDT)
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        mark.rutland@arm.com, megha.dey@intel.com, frederic@kernel.org
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <f12f2d18-2e25-1879-fe34-227c82618abd@linux.intel.com>
 <20181017163021.GP3121@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1fd51130-d8b8-e3cc-0e48-8599ddb6c4f2@linux.intel.com>
Date:   Thu, 18 Oct 2018 10:05:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017163021.GP3121@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17.10.2018 19:30, Peter Zijlstra wrote:
> On Wed, Oct 17, 2018 at 11:57:49AM +0300, Alexey Budankov wrote:
>> Hi,
>>
>> On 10.10.2018 13:45, Peter Zijlstra wrote:
>> <SNIP>
>>> -static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
>>> +/*
>>> + * XXX somewhat completely buggered; this is in cpu_pmu_context, but we need
>>> + * event_pmu_context for rotations. We also need event_pmu_context specific
>>> + * scheduling routines. ARGH
>>> + *
>>> + *  - fixed the cpu_pmu_context vs event_pmu_context thingy
>>> + *    (cpu_pmu_context embeds an event_pmu_context)
>>> + *
>>> + *  - need nr_events/nr_active in epc to do per epc rotation
>>> + *    (done)
>>> + *
>>> + *  - need cpu and task pmu ctx together...
>>> + *    (cpc->task_epc)
>>> + */
>>> +static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
>>
>> Since it reduces to single cpu context (and single task context) at all times, 
>> ideally, it would probably be coded as simple as this: 
>>
>> 	perf_rotate_context()
>> 	{
>>             cpu = this_cpu_ptr(&cpu_context)
>>             for_every_pmu(pmu, cpu)
> 
> Can't do that, because we have per PMU rotation periods..

Well, yes, the callback is already called per-cpu per-pmu, 
so then this simplifies a bit, like this:

perf_rotate_context(pmu, cpu)
{
	for_every_event_ctx(event_ctx, pmu)
		rotate(event_ctx, pmu)
}


                                        event_ctx
                                           |
                                           v
    pmu (struct perf_cpu_pmu_context) ->  ctx__0 -> ctx__1
                                           |         |
                                           v         v
                           sched_out -> fgroup00  fgroup01 -> event001 -> event101 -> event201
                                          |  ^      |  ^
                                          v  |      v  |
                                        fgroup10  fgroup11
                                          |  |      |  |
                                          v  |      v  |
                            sched_in -> fgroup20  fgroup21

> 
>>                     for_every_event_ctx(event_ctx, pmu)
>> 	                    rotate(event_ctx, pmu)
>> 	}
> 
> I'm also not sure I get the rest that follows... you only have to rotate
> _one_ event per PMU.

Yes. One group per PMU. It could end up in several HW counters reprogramming.

Thanks,
Alexey

> 
> I'll try and understand the rest of you email later; brain has checked
> out for the day.
> 
