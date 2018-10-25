Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C620BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADAE2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADAE2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeJYWdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:33:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:52396 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbeJYWdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:33:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 07:00:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,424,1534834800"; 
   d="scan'208";a="103224003"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 25 Oct 2018 07:00:10 -0700
Received: from [10.251.10.119] (kliang2-mobl1.ccr.corp.intel.com [10.251.10.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1E0FD580496;
        Thu, 25 Oct 2018 07:00:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] perf: Add munmap callback
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, ak@linux.intel.com,
        eranian@google.com
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <20181025002943.GT3109@worktop.c.hoisthospitality.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <0083c5c2-8a53-3aca-543b-16bd764e31ab@linux.intel.com>
Date:   Thu, 25 Oct 2018 10:00:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025002943.GT3109@worktop.c.hoisthospitality.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2018 8:29 PM, Peter Zijlstra wrote:
> On Wed, Oct 24, 2018 at 08:11:15AM -0700, kan.liang@linux.intel.com wrote:
>> +void perf_event_munmap(void)
>> +{
>> +	struct perf_cpu_context *cpuctx;
>> +	unsigned long flags;
>> +	struct pmu *pmu;
>> +
>> +	local_irq_save(flags);
> 
> It is impossible to get here with IRQs already disabled.

I don't think so. Based on my test, IRQs are still enabled here. I once 
observed dead lock with my stress test. So I have to explicitly disable 
the IRQs here.

> 
>> +	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
>> +		pmu = cpuctx->ctx.pmu;
>> +
>> +		if (!pmu->munmap)
>> +			continue;
>> +
>> +		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>> +		perf_pmu_disable(pmu);
>> +
>> +		pmu->munmap();
>> +
>> +		perf_pmu_enable(pmu);
>> +
>> +		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>> +	}
>> +	local_irq_restore(flags);
>> +}
>> +
>>   static void perf_event_switch(struct task_struct *task,
>>   			      struct task_struct *next_prev, bool sched_in);
>>   
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 5f2b2b184c60..61978ad8c480 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2777,6 +2777,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>>   	/*
>>   	 * Remove the vma's, and unmap the actual pages
>>   	 */
>> +	perf_event_munmap();
> 
> I think that if you add the munmap hook, you should do it right and at
> least do it such that we can solve the other munmap problem.
>

Is this patch you mentioned?
https://lkml.org/lkml/2017/1/27/452

I will take a look and find a right place for both problems.

Thanks,
Kan
>>   	detach_vmas_to_be_unmapped(mm, vma, prev, end);
>>   	unmap_region(mm, vma, prev, start, end);
>>   
>> -- 
>> 2.17.1
>>
