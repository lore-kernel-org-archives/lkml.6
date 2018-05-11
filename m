Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbeEKLMi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:12:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39952 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753473AbeEKLMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:12:36 -0400
Subject: Re: [RFC][PATCH] arm64: update iomem_resource.end
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: will.deacon@arm.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        steve.capper@arm.com, kristina.martsenko@arm.com, labbott@redhat.com,
        stefan@agner.ch, akpm@linux-foundation.org, jglisse@redhat.com
References: <1525906703-28481-1-git-send-email-nicoleotsuka@gmail.com>
 <cfb81f55-f917-431f-0afd-c97e7641a2f8@arm.com>
 <20180510222920.GA20553@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f183a131-fbf7-3b73-71bf-f898c3b0f757@arm.com>
Date: Fri, 11 May 2018 12:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510222920.GA20553@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/18 23:29, Nicolin Chen wrote:
> Thanks for the comments, Robin.
> 
> On Thu, May 10, 2018 at 06:45:59PM +0100, Robin Murphy wrote:
>> On 09/05/18 23:58, Nicolin Chen wrote:
>>> The iomem_resource.end is -1 by default and should be updated in
>>> arch-level code.
>>>
>>> ARM64 so far hasn't updated it while core kernel code (mm/hmm.c)
>>> started to use iomem_resource.end for boundary check. So it'd be
>>> better to assign iomem_resource.end using a valid value, the end
>>> of physical address space for example because iomem_resource.end
>>> in theory should reflect that.
>>>
>>> However, VA_BITS might be smaller than PA_BITS in ARM64. So using
>>> the end of physical address space doesn't make a lot of sense in
>>> this case, or could be even harmful since virtual address cannot
>>> reach that memory region.
>>
>> Why? There's plenty of stuff in the physical address space that will
>> only ever be accessed via ioremap/memremap. There's no reason you
>> shouldn't be able to run a VA_BITS < 48 kernel on a Cavium ThunderX
> 
> I'm running VA_BITS_39 and PA_BITS_48 on Tegra 210. There had
> not been any problem of it, however with hmm.....
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/mm/hmm.c#n1144
> 
> This hmm_devmem_add() requests a region with PFNs being outside
> of the linear region in ARM64 case which takes MAX_PHYSMEM_BITS
> (48 bits) over iomem_resource.end without this patch. Then when
> dealing with page structures in vmemmap region from a given PFN
> directly (CONFIG_SPARSEMEM_VMEMMAP=y), and the given PFN is the
> last one based on physical region (48 bits), the address of its
> page structure will go beyond vmemmap region. Does this sound a
> problem?

Yes, but as far as we're concerned here it's not a problem with arm64:

	config ARCH_HAS_HMM
		...
		depends on (X86_64 || PPC64)
		depends on ZONE_DEVICE
		...
		depends on MEMORY_HOTPLUG
		depends on MEMORY_HOTREMOVE
		...

Whatever out-of-tree changes you have to address all of those are 
clearly implemented incorrectly; *that's* your problem.

>> where *all* the I/O is in the top half of the PA space. We already
>> constrain RAM in this very function to those regions which fit into
>> the linear map, and if you're accessing anything other than RAM
>> through the linear map you're probably doing something wrong.
> 
> If I understand this part correctly, since ARM64 has applied the
> memory limit already, does it mean that probably we should fix
> something in the region_intersects() or add an extra check in the
> hmm_devmem_add(), instead of limiting the iomem_resource?

It means we should implement memory hotplug correctly. Which, 
unfortunately, I happen to know is really hard (it's something I've been 
looking at from the device-DAX angle).

>> Furthermore, the physical region covered by the linear map doesn't
>> necessarily start at physical address 0 anyway - see PHYS_OFFSET.
> 
> Hmm...okay...but there still should be a protection somewhere if
> it happens to access a page structure via pfn_to_page() while the
> PFN is not covered by the vmemmap linear mapping, right?

There already is: pfn_valid() will return false for anything outside the 
intersection of memblock regions and the linear map region as calculated 
by arm64_memblock_init(); anything calling pfn_to_page() without 
checking pfn_valid() first is fundamentally broken. Or if you have 
out-of-tree changes to the pfn_valid() implementation then all bets are 
off, and it's not something for mainline to work around.

Robin.
