Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BC9C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EB920870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfBAOqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:46:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:32356 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfBAOqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:46:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 06:46:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="143402731"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2019 06:46:01 -0800
Received: from [10.254.84.202] (kliang2-mobl1.ccr.corp.intel.com [10.254.84.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9EADE5804BB;
        Fri,  1 Feb 2019 06:46:00 -0800 (PST)
Subject: Re: [PATCH V4 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, luto@amacapital.net,
        Vlastimil Babka <vbabka@suse.cz>, kirill@shutemov.name
References: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
 <20190201092240.GB31498@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <48363dcc-2047-e311-9da1-98b598a39df7@linux.intel.com>
Date:   Fri, 1 Feb 2019 09:45:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190201092240.GB31498@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/2019 4:22 AM, Peter Zijlstra wrote:
> On Thu, Jan 31, 2019 at 12:27:54PM -0800, kan.liang@linux.intel.com wrote:
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 374a197..229a73b 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2578,3 +2578,34 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
>>   	cap->events_mask_len	= x86_pmu.events_mask_len;
>>   }
>>   EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
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
>> +		if (current->mm) {
>> +			pte = lookup_address_in_pgd(pgd_offset(current->mm, virt),
>> +						    virt, &level);
>> +		} else
>> +			level = PG_LEVEL_NUM;
>> +	}
>> +	local_irq_restore(flags);
>> +	if (level >= PG_LEVEL_NUM)
>> +		return 0;
>> +
>> +	return (u64)page_level_size(level);
>> +}
> 
> *sigh* there really isn't anything x86 specific there.

OK. I will split the patch and move the common code to a dedicated patch 
in V5. I will try the proposed code and do some tests on X86.

> >> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 236bb8d..d233f45 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -6352,6 +6358,12 @@ static u64 perf_virt_to_phys(u64 virt)
>>   	return phys_addr;
>>   }
>>   
>> +/* Return page size of given virtual address. IRQ-safe required. */
>> +u64 __weak perf_get_page_size(u64 virt)
>> +{
>> +	return 0;
>> +}
>> +
>>   static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
>>   
>>   struct perf_callchain_entry *
> 
> How about something like so instead?
> 
> (completely untested, will likely make your grandma eat puppies
That's not funny!


Kan

