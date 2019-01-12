Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A61C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489342086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfALM4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 07:56:01 -0500
Received: from foss.arm.com ([217.140.101.70]:42140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfALM4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 07:56:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08DDE80D;
        Sat, 12 Jan 2019 04:56:00 -0800 (PST)
Received: from [10.162.40.80] (p8cg001049571a15.blr.arm.com [10.162.40.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21A493F70D;
        Sat, 12 Jan 2019 04:55:49 -0800 (PST)
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, mpe@ellerman.id.au,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, christoffer.dall@arm.com,
        marc.zyngier@arm.com, kirill@shutemov.name,
        rppt@linux.vnet.ibm.com, mhocko@suse.com,
        ard.biesheuvel@linaro.org, mark.rutland@arm.com,
        steve.capper@arm.com, james.morse@arm.com, robin.murphy@arm.com,
        aneesh.kumar@linux.ibm.com, vbabka@suse.cz, shakeelb@google.com,
        rientjes@google.com
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9dd9a8ef-8db8-891c-79a9-270ab033037c@arm.com>
Date:   Sat, 12 Jan 2019 18:25:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190112121230.GQ6310@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/12/2019 05:42 PM, Matthew Wilcox wrote:
> On Sat, Jan 12, 2019 at 03:56:38PM +0530, Anshuman Khandual wrote:
>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>> __GFP_ZERO) and using it for allocating page table pages.
> 
> Except that's not true.
> 
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -13,19 +13,17 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>>  EXPORT_SYMBOL(physical_mask);
>>  #endif
>>  
>> -#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
>> -
>>  #ifdef CONFIG_HIGHPTE
> 
> ...
> 
>>  pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>>  {
>> -	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
>> +	return (pte_t *)__get_free_page(GFP_PGTABLE & ~__GFP_ACCOUNT);
>>  }
> 
> I think x86 was the only odd one out here, but you'll need to try again ...

IIUC the user page table pages need __GFP_ACCOUNT not the kernel ones. Hence
in the above function it clears out __GFP_ACCOUNT for kernel page table page
allocations but where as by default it has got __GFP_ACCOUNT which would be
used for user page tables. Instead we can make X86 user allocations add
__GFP_ACCOUNT (like other archs) to generic GFP_PGTABLE when ever required.
