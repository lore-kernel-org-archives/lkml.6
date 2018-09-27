Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D86C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70AB216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70AB216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeI0ULy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:11:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:65092 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeI0ULx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:11:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 06:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,310,1534834800"; 
   d="scan'208";a="92451059"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2018 06:53:30 -0700
Received: from [10.251.7.230] (kliang2-mobl1.ccr.corp.intel.com [10.251.7.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5E0F15802BA;
        Thu, 27 Sep 2018 06:53:29 -0700 (PDT)
Subject: Re: [PATCH V2 2/3] x86, perf: Add a separate Arch Perfmon v4 PMI
 handler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
References: <1533712328-2834-1-git-send-email-kan.liang@linux.intel.com>
 <1533712328-2834-2-git-send-email-kan.liang@linux.intel.com>
 <20180927125141.GA3439@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <79e026f0-dabc-ba29-2a90-a6b24521b525@linux.intel.com>
Date:   Thu, 27 Sep 2018 09:53:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927125141.GA3439@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2018 8:51 AM, Peter Zijlstra wrote:
> On Wed, Aug 08, 2018 at 12:12:07AM -0700, kan.liang@linux.intel.com wrote:
>> @@ -4325,6 +4428,8 @@ __init int intel_pmu_init(void)
>>   		x86_pmu.extra_regs = intel_skl_extra_regs;
>>   		x86_pmu.pebs_aliases = intel_pebs_aliases_skl;
>>   		x86_pmu.pebs_prec_dist = true;
>> +		x86_pmu.counter_freezing = disable_counter_freezing ?
>> +					   false : true;
>>   		/* all extra regs are per-cpu when HT is on */
>>   		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
>>   		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
> 
> 
> How about so instead? It is very much tied to the perfmon version, not
> the FMS.
>

Yes, it matches the name of the handler.
But the change as below is not sufficient. We have to temporarily 
disable counter_freezing in this patch for small core.
The 3/3 patch will also be impact.

I will send V3 patch for these changes.

Thanks,
Kan

> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4049,6 +4049,9 @@ __init int intel_pmu_init(void)
>   			max((int)edx.split.num_counters_fixed, assume);
>   	}
>   
> +	if (version >= 4)
> +		x86_pmu.counter_freezing = !disable_counter_freezing;
> +
>   	if (boot_cpu_has(X86_FEATURE_PDCM)) {
>   		u64 capabilities;
>   
> @@ -4428,8 +4431,6 @@ __init int intel_pmu_init(void)
>   		x86_pmu.extra_regs = intel_skl_extra_regs;
>   		x86_pmu.pebs_aliases = intel_pebs_aliases_skl;
>   		x86_pmu.pebs_prec_dist = true;
> -		x86_pmu.counter_freezing = disable_counter_freezing ?
> -					   false : true;
>   		/* all extra regs are per-cpu when HT is on */
>   		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
>   		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
> 
