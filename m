Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B28C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2672075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2672075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeIFNTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:19:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:40388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbeIFNTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:19:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C6BBAE39;
        Thu,  6 Sep 2018 08:44:35 +0000 (UTC)
Date:   Thu, 6 Sep 2018 10:44:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 19/29] memblock: replace alloc_bootmem_pages with
 memblock_alloc
Message-ID: <20180906084433.GD14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-20-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-20-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 18:59:34, Mike Rapoport wrote:
> The conversion is done using the following semantic patch:
> 
> @@
> expression e;
> @@
> - alloc_bootmem_pages(e)
> + memblock_alloc(e, PAGE_SIZE)
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Same as the previous patch

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/c6x/mm/init.c             | 3 ++-
>  arch/h8300/mm/init.c           | 2 +-
>  arch/m68k/mm/init.c            | 2 +-
>  arch/m68k/mm/mcfmmu.c          | 4 ++--
>  arch/m68k/mm/motorola.c        | 2 +-
>  arch/m68k/mm/sun3mmu.c         | 4 ++--
>  arch/sh/mm/init.c              | 4 ++--
>  arch/x86/kernel/apic/io_apic.c | 3 ++-
>  arch/x86/mm/init_64.c          | 2 +-
>  drivers/xen/swiotlb-xen.c      | 3 ++-
>  10 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
> index 4cc72b0..dc369ad 100644
> --- a/arch/c6x/mm/init.c
> +++ b/arch/c6x/mm/init.c
> @@ -38,7 +38,8 @@ void __init paging_init(void)
>  	struct pglist_data *pgdat = NODE_DATA(0);
>  	unsigned long zones_size[MAX_NR_ZONES] = {0, };
>  
> -	empty_zero_page      = (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
> +	empty_zero_page      = (unsigned long) memblock_alloc(PAGE_SIZE,
> +							      PAGE_SIZE);
>  	memset((void *)empty_zero_page, 0, PAGE_SIZE);
>  
>  	/*
> diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
> index 015287a..5d31ac9 100644
> --- a/arch/h8300/mm/init.c
> +++ b/arch/h8300/mm/init.c
> @@ -67,7 +67,7 @@ void __init paging_init(void)
>  	 * Initialize the bad page table and bad page to point
>  	 * to a couple of allocated pages.
>  	 */
> -	empty_zero_page = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
> +	empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  	memset((void *)empty_zero_page, 0, PAGE_SIZE);
>  
>  	/*
> diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
> index 38e2b27..977363e 100644
> --- a/arch/m68k/mm/init.c
> +++ b/arch/m68k/mm/init.c
> @@ -93,7 +93,7 @@ void __init paging_init(void)
>  
>  	high_memory = (void *) end_mem;
>  
> -	empty_zero_page = alloc_bootmem_pages(PAGE_SIZE);
> +	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  
>  	/*
>  	 * Set up SFC/DFC registers (user data space).
> diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
> index f5453d9..38a1d92 100644
> --- a/arch/m68k/mm/mcfmmu.c
> +++ b/arch/m68k/mm/mcfmmu.c
> @@ -44,7 +44,7 @@ void __init paging_init(void)
>  	enum zone_type zone;
>  	int i;
>  
> -	empty_zero_page = (void *) alloc_bootmem_pages(PAGE_SIZE);
> +	empty_zero_page = (void *) memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  	memset((void *) empty_zero_page, 0, PAGE_SIZE);
>  
>  	pg_dir = swapper_pg_dir;
> @@ -52,7 +52,7 @@ void __init paging_init(void)
>  
>  	size = num_pages * sizeof(pte_t);
>  	size = (size + PAGE_SIZE) & ~(PAGE_SIZE-1);
> -	next_pgtable = (unsigned long) alloc_bootmem_pages(size);
> +	next_pgtable = (unsigned long) memblock_alloc(size, PAGE_SIZE);
>  
>  	bootmem_end = (next_pgtable + size + PAGE_SIZE) & PAGE_MASK;
>  	pg_dir += PAGE_OFFSET >> PGDIR_SHIFT;
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index 8bcf57e..2113eec 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -276,7 +276,7 @@ void __init paging_init(void)
>  	 * initialize the bad page table and bad page to point
>  	 * to a couple of allocated pages
>  	 */
> -	empty_zero_page = alloc_bootmem_pages(PAGE_SIZE);
> +	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  
>  	/*
>  	 * Set up SFC/DFC registers
> diff --git a/arch/m68k/mm/sun3mmu.c b/arch/m68k/mm/sun3mmu.c
> index 4a99799..19c05ab 100644
> --- a/arch/m68k/mm/sun3mmu.c
> +++ b/arch/m68k/mm/sun3mmu.c
> @@ -45,7 +45,7 @@ void __init paging_init(void)
>  	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
>  	unsigned long size;
>  
> -	empty_zero_page = alloc_bootmem_pages(PAGE_SIZE);
> +	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  
>  	address = PAGE_OFFSET;
>  	pg_dir = swapper_pg_dir;
> @@ -55,7 +55,7 @@ void __init paging_init(void)
>  	size = num_pages * sizeof(pte_t);
>  	size = (size + PAGE_SIZE) & ~(PAGE_SIZE-1);
>  
> -	next_pgtable = (unsigned long)alloc_bootmem_pages(size);
> +	next_pgtable = (unsigned long)memblock_alloc(size, PAGE_SIZE);
>  	bootmem_end = (next_pgtable + size + PAGE_SIZE) & PAGE_MASK;
>  
>  	/* Map whole memory from PAGE_OFFSET (0x0E000000) */
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index 7713c08..c884b76 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -128,7 +128,7 @@ static pmd_t * __init one_md_table_init(pud_t *pud)
>  	if (pud_none(*pud)) {
>  		pmd_t *pmd;
>  
> -		pmd = alloc_bootmem_pages(PAGE_SIZE);
> +		pmd = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  		pud_populate(&init_mm, pud, pmd);
>  		BUG_ON(pmd != pmd_offset(pud, 0));
>  	}
> @@ -141,7 +141,7 @@ static pte_t * __init one_page_table_init(pmd_t *pmd)
>  	if (pmd_none(*pmd)) {
>  		pte_t *pte;
>  
> -		pte = alloc_bootmem_pages(PAGE_SIZE);
> +		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  		pmd_populate_kernel(&init_mm, pmd, pte);
>  		BUG_ON(pte != pte_offset_kernel(pmd, 0));
>  	}
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index ff0d14c..e25118f 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2621,7 +2621,8 @@ void __init io_apic_init_mappings(void)
>  #ifdef CONFIG_X86_32
>  fake_ioapic_page:
>  #endif
> -			ioapic_phys = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
> +			ioapic_phys = (unsigned long)memblock_alloc(PAGE_SIZE,
> +								    PAGE_SIZE);
>  			ioapic_phys = __pa(ioapic_phys);
>  		}
>  		set_fixmap_nocache(idx, ioapic_phys);
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index dd519f3..f39b512 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -197,7 +197,7 @@ static __ref void *spp_getpage(void)
>  	if (after_bootmem)
>  		ptr = (void *) get_zeroed_page(GFP_ATOMIC);
>  	else
> -		ptr = alloc_bootmem_pages(PAGE_SIZE);
> +		ptr = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  
>  	if (!ptr || ((unsigned long)ptr & ~PAGE_MASK)) {
>  		panic("set_pte_phys: cannot allocate page data %s\n",
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index a6f9ba8..8d849b4 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -217,7 +217,8 @@ int __ref xen_swiotlb_init(int verbose, bool early)
>  	 * Get IO TLB memory from any location.
>  	 */
>  	if (early)
> -		xen_io_tlb_start = alloc_bootmem_pages(PAGE_ALIGN(bytes));
> +		xen_io_tlb_start = memblock_alloc(PAGE_ALIGN(bytes),
> +						  PAGE_SIZE);
>  	else {
>  #define SLABS_PER_PAGE (1 << (PAGE_SHIFT - IO_TLB_SHIFT))
>  #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
