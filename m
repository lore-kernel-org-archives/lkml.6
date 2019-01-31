Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529D6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26895218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfAaO6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:58:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:33389 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfAaO6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:58:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 06:58:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="120985220"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2019 06:58:11 -0800
Received: from [10.251.7.163] (kliang2-mobl1.ccr.corp.intel.com [10.251.7.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A5C9B580297;
        Thu, 31 Jan 2019 06:58:10 -0800 (PST)
Subject: Re: [PATCH V3 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com,
        Andy Lutomirski <luto@amacapital.net>
References: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
 <20190131123725.GB31516@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <6ecaa29b-af17-938d-8638-acb9de5454be@linux.intel.com>
Date:   Thu, 31 Jan 2019 09:58:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190131123725.GB31516@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/2019 7:37 AM, Peter Zijlstra wrote:
> On Wed, Jan 30, 2019 at 06:23:42AM -0800, kan.liang@linux.intel.com wrote:
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 374a197..03bf45d 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2578,3 +2578,45 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
>>   	cap->events_mask_len	= x86_pmu.events_mask_len;
>>   }
>>   EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
>> +
>> +/*
>> + * map x86 page levels to perf page sizes
>> + */
>> +static const enum perf_page_size perf_page_size_map[PG_LEVEL_NUM] = {
>> +	[PG_LEVEL_NONE] = PERF_PAGE_SIZE_NONE,
>> +	[PG_LEVEL_4K]   = PERF_PAGE_SIZE_4K,
>> +	[PG_LEVEL_2M]   = PERF_PAGE_SIZE_2M,
>> +	[PG_LEVEL_1G]   = PERF_PAGE_SIZE_1G,
>> +	[PG_LEVEL_512G] = PERF_PAGE_SIZE_512G,
>> +};
>> +
>> +u64 perf_get_page_size(u64 virt)
>> +{
>> +	unsigned long flags;
>> +	unsigned int level;
>> +	pte_t *pte;
>> +
>> +	if (!virt)
>> +		return 0;
>> +
>> +	/*
>> +	 * Interrupts are disabled, so it prevents any tear down
>> +	 * of the page tables.
>> +	 * See the comment near struct mmu_table_batch.
>> +	 */
>> +	local_irq_save(flags);
>> +	if (virt >= TASK_SIZE)
>> +		pte = lookup_address(virt, &level);
>> +	else {
>> +		if (current->mm)
>> +			pte = lookup_address_in_pgd(pgd_offset(current->mm, virt),
>> +						    virt, &level);
> 
> Aside from all the missin {}, I'm fairly sure this is broken since this
> happens from NMI context. This can interrupt switch_mm() and things like
> use_temporary_mm().
> 
> Also; why does this live in the x86 code and not in the generic code?
>

This is x86 implementation.
In generic code, there is a __weak function. I'll make it clear in the 
change log in v4.

+/* Return page size of given virtual address. IRQ-safe required. */
+u64 __weak perf_get_page_size(u64 virt)
+{
+	return PERF_PAGE_SIZE_NONE;
+}


>> +		else
>> +			level = PG_LEVEL_NUM;
>> +	}
>> +	local_irq_restore(flags);
>> +	if (level >= PG_LEVEL_NUM)
>> +		return PERF_PAGE_SIZE_NONE;
>> +
>> +	return (u64)perf_page_size_map[level];
>> +}
> 
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 7198ddd..79daacd 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -141,8 +141,9 @@ enum perf_event_sample_format {
>>   	PERF_SAMPLE_TRANSACTION			= 1U << 17,
>>   	PERF_SAMPLE_REGS_INTR			= 1U << 18,
>>   	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
>> +	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 20,
>>   
>> -	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
>> +	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
>>   
>>   	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>>   };
>> @@ -863,6 +864,7 @@ enum perf_event_type {
>>   	 *	{ u64			abi; # enum perf_sample_regs_abi
>>   	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
>>   	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
>> +	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
>>   	 * };
>>   	 */
>>   	PERF_RECORD_SAMPLE			= 9,
>> @@ -1150,6 +1152,18 @@ union perf_mem_data_src {
>>   #define PERF_MEM_S(a, s) \
>>   	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>>   
>> +
>> +enum perf_page_size {
>> +	PERF_PAGE_SIZE_NONE,
>> +	PERF_PAGE_SIZE_4K,
>> +	PERF_PAGE_SIZE_8K,
>> +	PERF_PAGE_SIZE_16K,
>> +	PERF_PAGE_SIZE_64K,
>> +	PERF_PAGE_SIZE_2M,
>> +	PERF_PAGE_SIZE_1G,
>> +	PERF_PAGE_SIZE_512G,
>> +};
> 
> Since you have a u64 to store this in, WTH do you use this limited enum?
> Are you very sure this covers all the possible page sizes for all
> architectures?
> 
> Why not simply report the page size in bytes?
> 

I will use the page size instead in V4.

Thanks,
Kan
