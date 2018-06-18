Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE35C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBD6208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBD6208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755015AbeFRGzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:55:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:9437 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754722AbeFRGzh (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:55:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2018 23:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="58448407"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.208.136]) ([10.254.208.136])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2018 23:55:33 -0700
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        me@kylehuey.com, Linux-kernel@vger.kernel.org,
        vincent.weaver@maine.edu, will.deacon@arm.com, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
 <20180615113608.6m74sm7gpl5p6oqe@lakrids.cambridge.arm.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <52c75f12-1f91-405d-0b05-0aa6a9c09306@linux.intel.com>
Date:   Mon, 18 Jun 2018 14:55:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615113608.6m74sm7gpl5p6oqe@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2018 7:36 PM, Mark Rutland wrote:
> On Fri, Jun 15, 2018 at 06:03:22PM +0800, Jin Yao wrote:
>> When doing sampling, for example:
>>
>> perf record -e cycles:u ...
>>
>> On workloads that do a lot of kernel entry/exits we see kernel
>> samples, even though :u is specified. This is due to skid existing.
>>
>> This might be a security issue because it can leak kernel addresses even
>> though kernel sampling support is disabled.
>>
>> One patch "perf/core: Drop kernel samples even though :u is specified"
>> was posted in last year but it was reverted because it introduced a
>> regression issue that broke the rr-project, which used sampling
>> events to receive a signal on overflow. These signals were critical
>> to the correct operation of rr.
>>
>> See '6a8a75f32357 ("Revert "perf/core: Drop kernel samples even
>> though :u is specified"")' for detail.
>>
>> Now the idea is to use sysctl to control the dropping of leaked
>> kernel samples.
>>
>> /sys/devices/cpu/perf_allow_sample_leakage:
>>
>> 0 - default, drop the leaked kernel samples.
>> 1 - don't drop the leaked kernel samples.
> 
> Does this need to be conditional at all?
> 
> At least for sampling the GPRs, we could do something like below
> unconditionally, which seems sufficient for my test cases.
> 
> Mark.
> 
> ---->8----
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 67612ce359ad..79a21531d57c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6359,6 +6359,24 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>          return callchain ?: &__empty_callchain;
>   }
>   
> +static struct pt_regs *perf_get_sample_regs(struct perf_event *event, struct pt_regs *regs)
> +{
> +       /*
> +        * Due to interrupt latency (AKA "skid"), we may enter the kernel
> +        * before taking an overflow, even if the PMU is only counting user
> +        * events.
> +        *
> +        * If we're not counting kernel events, always use the user regs when
> +        * sampling.
> +        *
> +        * TODO: how does this interact with guest sampling?
> +        */
> +       if (event->attr.exclude_kernel && !user_mode(regs))
> +               return task_pt_regs(current);
> +
> +       return regs;
> +}
> +
>   void perf_prepare_sample(struct perf_event_header *header,
>                           struct perf_sample_data *data,
>                           struct perf_event *event,
> @@ -6366,6 +6384,8 @@ void perf_prepare_sample(struct perf_event_header *header,
>   {
>          u64 sample_type = event->attr.sample_type;
>   
> +       regs = perf_get_sample_regs(event, regs);
> +
>          header->type = PERF_RECORD_SAMPLE;
>          header->size = sizeof(*header) + event->header_size;
>   
> 

Hi Mark,

Thanks for providing the patch. I understand this approach.

In my opinion, the skid window is from counter overflow to interrupt 
delivered. While if the skid window is too *big* (e.g. user -> kernel), 
it should be not very useful. So personally, I'd prefer to drop the samples.

Thanks
Jin Yao

