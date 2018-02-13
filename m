Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934849AbeBMLee (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:34:34 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:52765 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934078AbeBMLeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:34:31 -0500
Subject: Re: [PATCH v2 04/15] MIPS: memblock: Discard bootmem initialization
To: Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <miodrag.dinic@mips.com>, <jhogan@kernel.org>, <goran.ferenc@mips.com>,
        <david.daney@cavium.com>, <paul.gortmaker@windriver.com>,
        <paul.burton@mips.com>, <alex.belits@cavium.com>,
        <Steven.Hill@cavium.com>
CC: <alexander.sverdlin@nokia.com>, <kumba@gentoo.org>,
        <marcin.nowakowski@mips.com>, <James.hogan@mips.com>,
        <Peter.Wotton@mips.com>, <Sergey.Semin@t-platforms.ru>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
 <20180202035458.30456-5-fancer.lancer@gmail.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <8b96992e-1cac-7744-292b-b5b247b4eb52@mips.com>
Date: Tue, 13 Feb 2018 11:28:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180202035458.30456-5-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518521577-637137-26797-167879-13
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189977
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,


On 02/02/18 03:54, Serge Semin wrote:
> Since memblock is going to be used for the early memory allocation
> lets discard the bootmem node setup and all the related free-space
> search code. Low/high PFN extremums should be still calculated
> since they are needed on the paging_init stage. Since the current
> code is already doing memblock regions initialization the only thing
> left is to set the upper allocation limit to be up to the max low
> memory PFN, so the memblock API can be fully used from now.

Please could we move this patch to later in the series, perhaps before 
the patches to remove bootmem initialisation from Loongson3 / IP27? This 
would vastly improve the bisectability of the series.

Either that, or less ideally, perhaps merge this patch with "MIPS: 
memblock: Add reserved memory regions to memblock" since those 2 
combined should be a more atomic change so more bisectable, if slightly 
harder to review.

> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>   arch/mips/kernel/setup.c | 86 +++++++-----------------------------------------
>   1 file changed, 11 insertions(+), 75 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index a015cee353be..b5fcacf71b3f 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -367,29 +367,15 @@ static void __init bootmem_init(void)
>   
>   #else  /* !CONFIG_SGI_IP27 */
>   
> -static unsigned long __init bootmap_bytes(unsigned long pages)
> -{
> -	unsigned long bytes = DIV_ROUND_UP(pages, 8);
> -
> -	return ALIGN(bytes, sizeof(long));
> -}
> -
>   static void __init bootmem_init(void)
>   {
> -	unsigned long reserved_end;
> -	unsigned long mapstart = ~0UL;
> -	unsigned long bootmap_size;
> -	bool bootmap_valid = false;
>   	int i;
>   
>   	/*
> -	 * Sanity check any INITRD first. We don't take it into account
> -	 * for bootmem setup initially, rely on the end-of-kernel-code
> -	 * as our memory range starting point. Once bootmem is inited we
> +	 * Sanity check any INITRD first. Once memblock is inited we
>   	 * will reserve the area used for the initrd.
>   	 */
>   	init_initrd();
> -	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
>   
>   	/*
>   	 * max_low_pfn is not a number of pages. The number of pages
> @@ -428,16 +414,6 @@ static void __init bootmem_init(void)
>   			max_low_pfn = end;
>   		if (start < min_low_pfn)
>   			min_low_pfn = start;
> -		if (end <= reserved_end)
> -			continue;
> -#ifdef CONFIG_BLK_DEV_INITRD
> -		/* Skip zones before initrd and initrd itself */
> -		if (initrd_end && end <= (unsigned long)PFN_UP(__pa(initrd_end)))
> -			continue;
> -#endif
> -		if (start >= mapstart)
> -			continue;
> -		mapstart = max(reserved_end, start);
>   	}
>   
>   	if (min_low_pfn >= max_low_pfn)
> @@ -463,53 +439,19 @@ static void __init bootmem_init(void)
>   #endif
>   		max_low_pfn = PFN_DOWN(HIGHMEM_START);
>   	}
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -	/*
> -	 * mapstart should be after initrd_end
> -	 */
> -	if (initrd_end)
> -		mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
> +#ifdef CONFIG_HIGHMEM
> +	pr_info("PFNs: low min %lu, low max %lu, high start %lu, high end %lu,"
> +		"max %lu\n",
> +		min_low_pfn, max_low_pfn, highstart_pfn, highend_pfn, max_pfn);
> +#else
> +	pr_info("PFNs: low min %lu, low max %lu, max %lu\n",
> +		min_low_pfn, max_low_pfn, max_pfn);

I think this debug info should be pr_debug (or removed from the final 
version).


>   #endif
>   
>   	/*
> -	 * check that mapstart doesn't overlap with any of
> -	 * memory regions that have been reserved through eg. DTB
> -	 */
> -	bootmap_size = bootmap_bytes(max_low_pfn - min_low_pfn);
> -
> -	bootmap_valid = memory_region_available(PFN_PHYS(mapstart),
> -						bootmap_size);
> -	for (i = 0; i < boot_mem_map.nr_map && !bootmap_valid; i++) {
> -		unsigned long mapstart_addr;
> -
> -		switch (boot_mem_map.map[i].type) {
> -		case BOOT_MEM_RESERVED:
> -			mapstart_addr = PFN_ALIGN(boot_mem_map.map[i].addr +
> -						boot_mem_map.map[i].size);
> -			if (PHYS_PFN(mapstart_addr) < mapstart)
> -				break;
> -
> -			bootmap_valid = memory_region_available(mapstart_addr,
> -								bootmap_size);
> -			if (bootmap_valid)
> -				mapstart = PHYS_PFN(mapstart_addr);
> -			break;
> -		default:
> -			break;
> -		}
> -	}
> -
> -	if (!bootmap_valid)
> -		panic("No memory area to place a bootmap bitmap");
> -
> -	/*
> -	 * Initialize the boot-time allocator with low memory only.
> +	 * Initialize the boot-time allocator with low/high memory, but
> +	 * set the allocation limit to low memory only
>   	 */
> -	if (bootmap_size != init_bootmem_node(NODE_DATA(0), mapstart,
> -					 min_low_pfn, max_low_pfn))
> -		panic("Unexpected memory size required for bootmap");
> -
>   	for (i = 0; i < boot_mem_map.nr_map; i++) {
>   		unsigned long start, end;
>   
> @@ -535,6 +477,7 @@ static void __init bootmem_init(void)
>   
>   		memblock_add_node(PFN_PHYS(start), PFN_PHYS(end - start), 0);
>   	}
> +	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
>   
>   	/*
>   	 * Register fully available low RAM pages with the bootmem allocator.
> @@ -570,8 +513,6 @@ static void __init bootmem_init(void)
>   		 */
>   		if (start >= max_low_pfn)
>   			continue;
> -		if (start < reserved_end)
> -			start = reserved_end;
>   		if (end > max_low_pfn)
>   			end = max_low_pfn;
>   
> @@ -587,11 +528,6 @@ static void __init bootmem_init(void)
>   		memory_present(0, start, end);
>   	}
>   
> -	/*
> -	 * Reserve the bootmap memory.
> -	 */
> -	reserve_bootmem(PFN_PHYS(mapstart), bootmap_size, BOOTMEM_DEFAULT);
> -
>   #ifdef CONFIG_RELOCATABLE
>   	/*
>   	 * The kernel reserves all memory below its _end symbol as bootmem,
> 

Thanks,
Matt
