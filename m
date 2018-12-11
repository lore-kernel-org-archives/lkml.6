Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A12AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AAF2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AAF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeLKRht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:37:49 -0500
Received: from foss.arm.com ([217.140.101.70]:54250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbeLKRhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:37:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 301A9EBD;
        Tue, 11 Dec 2018 09:37:48 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB8A93F6A8;
        Tue, 11 Dec 2018 09:37:46 -0800 (PST)
Subject: Re: [PATCH] arm64: Add memory hotplug support
To:     Will Deacon <will.deacon@arm.com>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
        cyrilc@xilinx.com, james.morse@arm.com, anshuman.khandual@arm.com
References: <0a0c7d3b8fbe1b2b399eeb6889027031335d2af1.1544453739.git.robin.murphy@arm.com>
 <20181211163605.GC12597@edgewater-inn.cambridge.arm.com>
 <b6a21681-beee-4083-89ce-cdfdbb958cbf@arm.com>
 <20181211172418.GA29593@edgewater-inn.cambridge.arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d5fff85d-9e26-4619-b61c-5f01433b43c9@arm.com>
Date:   Tue, 11 Dec 2018 17:37:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211172418.GA29593@edgewater-inn.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 17:24, Will Deacon wrote:
> On Tue, Dec 11, 2018 at 05:21:24PM +0000, Robin Murphy wrote:
>> On 11/12/2018 16:36, Will Deacon wrote:
>>> On Mon, Dec 10, 2018 at 03:29:01PM +0000, Robin Murphy wrote:
>>>> Wire up the basic support for hot-adding memory. Since memory hotplug
>>>> is fairly tightly coupled to sparsemem, we tweak pfn_valid() to also
>>>> cross-check the presence of a section in the manner of the generic
>>>> implementation, before falling back to memblock to check for no-map
>>>> regions within a present section as before. By having arch_add_memory(()
>>>> create the linear mapping first, this then makes everything work in the
>>>> way that __add_section() expects.
>>>>
>>>> We expect hotplug to be ACPI-driven, so the swapper_pg_dir updates
>>>> should be safe from races by virtue of the global device hotplug lock.
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>
>>>> Looks like I'm not going to have the whole pte_devmap story figured out
>>>> in time to land any ZONE_DEVICE support this cycle, but since this patch
>>>> also stands alone as a complete feature (and has ended up remarkably
>>>> simple and self-contained), I hope we might consider getting it merged
>>>> on its own merit.
>>>>
>>>> Robin.
>>>>
>>>>    arch/arm64/Kconfig   |  3 +++
>>>>    arch/arm64/mm/init.c |  8 ++++++++
>>>>    arch/arm64/mm/mmu.c  | 12 ++++++++++++
>>>>    arch/arm64/mm/numa.c | 10 ++++++++++
>>>>    4 files changed, 33 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index 6d2b25f51bb3..7b855ae45747 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -261,6 +261,9 @@ config ZONE_DMA32
>>>>    config HAVE_GENERIC_GUP
>>>>    	def_bool y
>>>> +config ARCH_ENABLE_MEMORY_HOTPLUG
>>>> +	def_bool y
>>>> +
>>>>    config SMP
>>>>    	def_bool y
>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>> index 2983e0fc1786..82e0b08f2e31 100644
>>>> --- a/arch/arm64/mm/init.c
>>>> +++ b/arch/arm64/mm/init.c
>>>> @@ -291,6 +291,14 @@ int pfn_valid(unsigned long pfn)
>>>>    	if ((addr >> PAGE_SHIFT) != pfn)
>>>>    		return 0;
>>>> +
>>>> +#ifdef CONFIG_SPARSEMEM
>>>> +	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>>>> +		return 0;
>>>> +
>>>> +	if (!valid_section(__nr_to_section(pfn_to_section_nr(pfn))))
>>>> +		return 0;
>>>
>>> I'm a bit nervous about the call to __nr_to_section() here. How do we
>>> ensure that the section number we're passing stays within the bounds of
>>> the mem_section array?
>>
>> The same way every other sparsemem user (apart from arch/arm) does, I guess
>> - this is literally a copy-paste of the generic pfn_valid() implementation
>> :/
> 
> I don't trust the generic pfn_valid() at all :)
> 
>> Given the implementation of __nr_to_section() respective of how
>> memory_present() and sparse_index_init() set up mem_section in the first
>> place, I can't see how there can be a problem. You did see the bit 4 lines
>> above, right?
> 
> D'oh, yes, I read that and then instantly forgot it. Ok, so that should be
> fine.
> 
>>>> +#endif
>>>>    	return memblock_is_map_memory(addr);
>>>>    }
>>>>    EXPORT_SYMBOL(pfn_valid);
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index e1b2d58a311a..22379a74d289 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -1044,3 +1044,15 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>>>    	pmd_free(NULL, table);
>>>>    	return 1;
>>>>    }
>>>> +
>>>> +#ifdef CONFIG_MEMORY_HOTPLUG
>>>> +int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>>>> +		    bool want_memblock)
>>>> +{
>>>> +	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>>>> +			     size, PAGE_KERNEL, pgd_pgtable_alloc, 0);
>>>> +
>>>> +	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
>>>> +			   altmap, want_memblock);
>>>> +}
>>>
>>> If we're mapping the new memory into the linear map, shouldn't we be
>>> respecting rodata_full and debug page alloc by forcing page granularity
>>> and tweaking the permissions?
>>
>> Bah, James mentioned debug_pagealloc long ago, and I did have a slight
>> nagging feeling that I was still missing something - yes, I need to fix the
>> flags for that case. I'm not sure about rodata_full (do you mean
>> STRICT_KERNEL_RWX?) since a section being added here won't contain kernel
>> text nor data, and I can't seem to find anywhere that rodata options affect
>> the linear mapping of plain free RAM.
> 
> Ah, we've got code queued on for-next/core so that changing vmalloc()
> permissions makes the same changes to the linear map.

Gotcha, I see "arm64: mm: apply r/o permissions of VM areas to its 
linear alias as well" now, no wonder I couldn't find anything relevant 
in my rc3-based development branch. I'll rebase and add that case too.

Thanks,
Robin.
