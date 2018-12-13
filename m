Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EB2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDF320851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDF320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeLMOZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:25:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727707AbeLMOZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:25:56 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1A514F950B82D;
        Thu, 13 Dec 2018 22:25:49 +0800 (CST)
Received: from localhost (10.206.48.115) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 22:25:47 +0800
Date:   Thu, 13 Dec 2018 14:25:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will.deacon@arm.com>, <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <cyrilc@xilinx.com>,
        <james.morse@arm.com>, <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v2] arm64: Add memory hotplug support
Message-ID: <20181213142537.00003095@huawei.com>
In-Reply-To: <0dc6de46-0b9f-9b0b-f967-e29804279631@arm.com>
References: <331db1485b4c8c3466217e16a1e1f05618e9bae8.1544553902.git.robin.murphy@arm.com>
        <20181212114236.000030c9@huawei.com>
        <0dc6de46-0b9f-9b0b-f967-e29804279631@arm.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.206.48.115]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 11:49:23 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 12/12/2018 11:42, Jonathan Cameron wrote:
> > On Tue, 11 Dec 2018 18:48:48 +0000
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >   
> >> Wire up the basic support for hot-adding memory. Since memory hotplug
> >> is fairly tightly coupled to sparsemem, we tweak pfn_valid() to also
> >> cross-check the presence of a section in the manner of the generic
> >> implementation, before falling back to memblock to check for no-map
> >> regions within a present section as before. By having arch_add_memory(()
> >> create the linear mapping first, this then makes everything work in the
> >> way that __add_section() expects.
> >>
> >> We expect hotplug to be ACPI-driven, so the swapper_pg_dir updates
> >> should be safe from races by virtue of the global device hotplug lock.
> >>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>  
> > Hi Robin,
> > 
> > What tree is this against?
> > 
> > rodata_full doesn't seem be exist for me on 4.20-rc6.  
> 
> Sorry, this is now based on the arm64 for-next/core branch - I was 
> similarly confused when Will first mentioned rodata_full on v1 ;)
> 
> > With v1 I did the 'new node' test and it looked good except for an
> > old cgroups warning that has always been there (and has been on my list
> > to track down for a long time).  
> 
> Great, thanks for testing!
>
Hi Robin,
 
For physical memory hotplug (well sort of as I'm not really pulling
modules in and out of the machine, test is purely on the software).

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is still an issue with a warning from the cpuset cgroups
controller I reported a while back but haven't followed up on.
That has nothing to do with this set though.

Tested with adding memory to proximity nodes that already have
memory in them and nodes that don't.  NUMA node support is just the
x86 code ripped out to a common location and appropriate SRAT.

We are looking at the virtualization usecases but that will take
a while longer.

If we can sneak this in this cycle that would be great!

Thanks,

Jonathan

> Robin.
> 
> > 
> > Jonathan  
> >> ---
> >>
> >> v2: Handle page-mappings-only cases appropriately
> >>
> >>   arch/arm64/Kconfig   |  3 +++
> >>   arch/arm64/mm/init.c |  8 ++++++++
> >>   arch/arm64/mm/mmu.c  | 17 +++++++++++++++++
> >>   arch/arm64/mm/numa.c | 10 ++++++++++
> >>   4 files changed, 38 insertions(+)
> >>
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 4dbef530cf58..be423fda5cec 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -261,6 +261,9 @@ config ZONE_DMA32
> >>   config HAVE_GENERIC_GUP
> >>   	def_bool y
> >>   
> >> +config ARCH_ENABLE_MEMORY_HOTPLUG
> >> +	def_bool y
> >> +
> >>   config SMP
> >>   	def_bool y
> >>   
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index 6cde00554e9b..4bfe0fc9edac 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -291,6 +291,14 @@ int pfn_valid(unsigned long pfn)
> >>   
> >>   	if ((addr >> PAGE_SHIFT) != pfn)
> >>   		return 0;
> >> +
> >> +#ifdef CONFIG_SPARSEMEM
> >> +	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> >> +		return 0;
> >> +
> >> +	if (!valid_section(__nr_to_section(pfn_to_section_nr(pfn))))
> >> +		return 0;
> >> +#endif
> >>   	return memblock_is_map_memory(addr);
> >>   }
> >>   EXPORT_SYMBOL(pfn_valid);
> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >> index 674c409a8ce4..da513a1facf4 100644
> >> --- a/arch/arm64/mm/mmu.c
> >> +++ b/arch/arm64/mm/mmu.c
> >> @@ -1046,3 +1046,20 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
> >>   	pmd_free(NULL, table);
> >>   	return 1;
> >>   }
> >> +
> >> +#ifdef CONFIG_MEMORY_HOTPLUG
> >> +int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
> >> +		    bool want_memblock)
> >> +{
> >> +	int flags = 0;
> >> +
> >> +	if (rodata_full || debug_pagealloc_enabled())
> >> +		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >> +
> >> +	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> >> +			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
> >> +
> >> +	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
> >> +			   altmap, want_memblock);
> >> +}
> >> +#endif
> >> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> >> index 27a31efd9e8e..ae34e3a1cef1 100644
> >> --- a/arch/arm64/mm/numa.c
> >> +++ b/arch/arm64/mm/numa.c
> >> @@ -466,3 +466,13 @@ void __init arm64_numa_init(void)
> >>   
> >>   	numa_init(dummy_numa_init);
> >>   }
> >> +
> >> +/*
> >> + * We hope that we will be hotplugging memory on nodes we already know about,
> >> + * such that acpi_get_node() succeeds and we never fall back to this...
> >> + */
> >> +int memory_add_physaddr_to_nid(u64 addr)
> >> +{
> >> +	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> >> +	return 0;
> >> +}  
> > 
> >   


