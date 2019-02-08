Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4CAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D55B20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfBHNfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:35:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:22123 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbfBHNfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:35:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 05:35:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="scan'208";a="142661673"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2019 05:35:05 -0800
Received: from [10.254.83.157] (kliang2-mobl1.ccr.corp.intel.com [10.254.83.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8A4535802BB;
        Fri,  8 Feb 2019 05:35:05 -0800 (PST)
Subject: Re: [PATCH V3 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, acme@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        Andy Lutomirski <luto@amacapital.net>
References: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
 <20190131123725.GB31516@hirez.programming.kicks-ass.net>
 <6ecaa29b-af17-938d-8638-acb9de5454be@linux.intel.com>
 <alpine.DEB.2.21.1902081138050.1595@nanos.tec.linutronix.de>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <63b27cde-294e-056d-3ac5-3778c27cfb09@linux.intel.com>
Date:   Fri, 8 Feb 2019 08:35:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902081138050.1595@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/2019 5:39 AM, Thomas Gleixner wrote:
> On Thu, 31 Jan 2019, Liang, Kan wrote:
>>>> +u64 perf_get_page_size(u64 virt)
>>>> +{
>>>> +	unsigned long flags;
>>>> +	unsigned int level;
>>>> +	pte_t *pte;
>>>> +
>>>> +	if (!virt)
>>>> +		return 0;
>>>> +
>>>> +	/*
>>>> +	 * Interrupts are disabled, so it prevents any tear down
>>>> +	 * of the page tables.
>>>> +	 * See the comment near struct mmu_table_batch.
>>>> +	 */
>>>> +	local_irq_save(flags);
>>>> +	if (virt >= TASK_SIZE)
>>>> +		pte = lookup_address(virt, &level);
>>>> +	else {
>>>> +		if (current->mm)
>>>> +			pte = lookup_address_in_pgd(pgd_offset(current->mm,
>>>> virt),
>>>> +						    virt, &level);
>>>
>>> Aside from all the missin {}, I'm fairly sure this is broken since this
>>> happens from NMI context. This can interrupt switch_mm() and things like
>>> use_temporary_mm().
>>>
>>> Also; why does this live in the x86 code and not in the generic code?
>>>
>>
>> This is x86 implementation.
>> In generic code, there is a __weak function. I'll make it clear in the change
>> log in v4.
> 
> No, instead of hiding it in the changelog, split the patch into two:
> 
>   #1 Adding the core stuff including the weak function
> 
>   #2 Adding the x86 implementation.
> 

Thanks for the comments. I will do it in V5.

Thanks,
Kan
