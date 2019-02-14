Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E494EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34982177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406472AbfBNKMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:12:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfBNKMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:12:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D8A6C079C4C;
        Thu, 14 Feb 2019 10:12:40 +0000 (UTC)
Received: from localhost (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00C6260C6D;
        Thu, 14 Feb 2019 10:12:38 +0000 (UTC)
Date:   Thu, 14 Feb 2019 18:12:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "kirill@shutemov.name Thomas Gleixner" <tglx@linutronix.de>,
        x86@kernel.org, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] x86/mm: Adjust the padding size for KASLR
Message-ID: <20190214101236.GE14858@MiWiFi-R3L-srv>
References: <20190212013118.28203-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212013118.28203-1-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 14 Feb 2019 10:12:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masa,

On 02/11/19 at 08:31pm, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> The system sometimes crashes while memory hot-adding on KASLR
> enabled system. The crash happens because the regions pointed by
> kaslr_regions[].base are overwritten by the hot-added memory.
> 
> It happens because of the padding size for kaslr_regions[].base isn't
> enough for the system whose physical memory layout has huge space for
> memory hotplug. kaslr_regions[].base points "actual installed
> memory size + padding" or higher address. So, if the "actual + padding"
> is lower address than the maximum memory address, which means the memory
> address reachable by memory hot-add, kaslr_regions[].base is destroyed by
> the overwritten.
> 
>   address
>     ^
>     |------- maximum memory address (Hotplug)
>     |                                    ^
>     |------- kaslr_regions[0].base       | Hotadd-able region
>     |     ^                              |
>     |     | padding                      |
>     |     V                              V
>     |------- actual memory address (Installed on boot)
>     |
> 
> Fix it by getting the maximum memory address from SRAT and store
> the value in boot_param, then set the padding size while kaslr
> initializing if the default padding size isn't enough.

Thanks for the effort on fixing this KASLR&hotplug conflict issue.
I roughly go through this patch, seems three parts are contained:
 
1) Wrap up the SRAT travesing code into subtable_parse();
2) Add a field max_addr in struct boot_params, and get the max address
   from SRAT and write it into boot_params->max_addr;
3) Add kaslr_padding() to adjust the padding size for the direct
mapping. 

So could you split them into three patches for better reviewing?

Another thing is for the 3rd part, I also queued several patches in my
local branch, they are code bug fix patches, and several clean up
patches suggested by Ingo and Kirill. They can be found here:

https://github.com/baoquan-he/linux/commits/kaslar-mm-bug-fix

In my local patches, Ingo suggested opening code get_padding(), and
about the SGI UV bug, he suggested adding another function to calculate
the needed size for the direct mapping region. So I am wondering if you
can rebase the part 3 on top of it, or you add a new function to
calculate the size for the direct mapping region so that I can rebase on
top of your patch and reuse it.

What do you think about it?

Hi Ingo,

By the way, you suggested me to try to change the memory kaslr to
randomize the starting address from PUD aligned to PMD size aligned,
I changed code and experimented, seems it's not doable. Because the 1 GB
page of the direct mapping ask the physical address to have to be 1 GB
aligned. However, the PMD aligned memory region starting address will
cause the 1 GB page of the direct mapping to map physicall address at
non 1 GB aligned position, then system boot up will fail. The code is
here:
https://github.com/baoquan-he/linux/commits/mm-kaslr-2m-aligned

When I tested on KVM guest with 1 GB memory, system can work. When
enlarged system, e.g to 4G, it hardly succeeded to boot up.

Finally I found it's because of the intel cpu requirement:
Table 4-15. Format of an IA-32e Page-Directory-Pointer-Table Entry (PDPTE) that Maps a 1-GByte Page

But we still can improve the current memory region KASLR in 5-level from
512 GB aligned to PUD aligned, namely 1 GB aligned. Will post patch to
address this.

Thanks
Baoquan

> 
> ---
>  Documentation/x86/zero-page.txt       |  4 ++++
>  arch/x86/boot/compressed/acpi.c       | 30 ++++++++++++++++++++-------
>  arch/x86/include/uapi/asm/bootparam.h |  2 +-
>  arch/x86/mm/kaslr.c                   | 29 +++++++++++++++++++++++++-
>  4 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/x86/zero-page.txt b/Documentation/x86/zero-page.txt
> index 68aed077f..6c107816c 100644
> --- a/Documentation/x86/zero-page.txt
> +++ b/Documentation/x86/zero-page.txt
> @@ -15,6 +15,7 @@ Offset	Proto	Name		Meaning
>  058/008	ALL	tboot_addr      Physical address of tboot shared page
>  060/010	ALL	ist_info	Intel SpeedStep (IST) BIOS support information
>  				(struct ist_info)
> +078/010	ALL	max_addr	The possible maximum physical memory address[*].
>  080/010	ALL	hd0_info	hd0 disk parameter, OBSOLETE!!
>  090/010	ALL	hd1_info	hd1 disk parameter, OBSOLETE!!
>  0A0/010	ALL	sys_desc_table	System description table (struct sys_desc_table),
> @@ -38,3 +39,6 @@ Offset	Proto	Name		Meaning
>  2D0/A00	ALL	e820_table	E820 memory map table
>  				(array of struct e820_entry)
>  D00/1EC	ALL	eddbuf		EDD data (array of struct edd_info)
> +
> +[*]: max_addr shows the maximum memory address to be reachable by memory
> +     hot-add. max_addr is set by parsing ACPI SRAT.
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index c5a949335..3247c7153 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -272,6 +272,26 @@ static unsigned long get_acpi_srat_table(void)
>  	return 0;
>  }
>  
> +static void subtable_parse(struct acpi_subtable_header *sub_table, int *num,
> +		unsigned long *max_addr)
> +{
> +	struct acpi_srat_mem_affinity *ma;
> +	unsigned long addr;
> +
> +	ma = (struct acpi_srat_mem_affinity *)sub_table;
> +	if (ma->length) {
> +		if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
> +			addr = ma->base_address + ma->length;
> +			if (addr > *max_addr)
> +				*max_addr = addr;
> +		} else {
> +			immovable_mem[*num].start = ma->base_address;
> +			immovable_mem[*num].size = ma->length;
> +			(*num)++;
> +		}
> +	}
> +}
> +
>  /**
>   * count_immovable_mem_regions - Parse SRAT and cache the immovable
>   * memory regions into the immovable_mem array.
> @@ -288,6 +308,7 @@ int count_immovable_mem_regions(void)
>  	struct acpi_subtable_header *sub_table;
>  	struct acpi_table_header *table_header;
>  	char arg[MAX_ACPI_ARG_LENGTH];
> +	unsigned long max_addr = 0;
>  	int num = 0;
>  
>  	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
> @@ -305,14 +326,8 @@ int count_immovable_mem_regions(void)
>  	while (table + sizeof(struct acpi_subtable_header) < table_end) {
>  		sub_table = (struct acpi_subtable_header *)table;
>  		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
> -			struct acpi_srat_mem_affinity *ma;
>  
> -			ma = (struct acpi_srat_mem_affinity *)sub_table;
> -			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
> -				immovable_mem[num].start = ma->base_address;
> -				immovable_mem[num].size = ma->length;
> -				num++;
> -			}
> +			subtable_parse(sub_table, &num, &max_addr);
>  
>  			if (num >= MAX_NUMNODES*2) {
>  				debug_putstr("Too many immovable memory regions, aborting.\n");
> @@ -321,6 +336,7 @@ int count_immovable_mem_regions(void)
>  		}
>  		table += sub_table->length;
>  	}
> +	boot_params->max_addr = max_addr;
>  	return num;
>  }
>  #endif /* CONFIG_RANDOMIZE_BASE && CONFIG_MEMORY_HOTREMOVE */
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index 60733f137..d4882e171 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -156,7 +156,7 @@ struct boot_params {
>  	__u64  tboot_addr;				/* 0x058 */
>  	struct ist_info ist_info;			/* 0x060 */
>  	__u64 acpi_rsdp_addr;				/* 0x070 */
> -	__u8  _pad3[8];					/* 0x078 */
> +	__u64 max_addr;					/* 0x078 */
>  	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
>  	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
>  	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 3f452ffed..f44ebfcb7 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -70,6 +70,33 @@ static inline bool kaslr_memory_enabled(void)
>  	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
>  }
>  
> +/*
> + * The padding size should set to get for kaslr_regions[].base bigger address
> + * than the maximum memory address the system can have.
> + * kaslr_regions[].base points "actual size + padding" or higher address.
> + * If "actual size + padding" points the lower address than the maximum
> + * memory size, fix the padding size.
> + */
> +static unsigned long __init kaslr_padding(void)
> +{
> +	unsigned long padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +	unsigned long actual, maximum, base;
> +
> +	if (!boot_params.max_addr)
> +		goto out;
> +
> +	actual = roundup(PFN_PHYS(max_pfn), 1UL << TB_SHIFT);
> +	maximum = roundup(boot_params.max_addr, 1UL << TB_SHIFT);
> +	base = actual + (padding << TB_SHIFT);
> +
> +	if (maximum > base)
> +		padding = (maximum - actual) >> TB_SHIFT;
> +out:
> +#endif
> +	return padding;
> +}
> +
>  /* Initialize base and padding for each memory region randomized with KASLR */
>  void __init kernel_randomize_memory(void)
>  {
> @@ -103,7 +130,7 @@ void __init kernel_randomize_memory(void)
>  	 */
>  	BUG_ON(kaslr_regions[0].base != &page_offset_base);
>  	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> -		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> +			kaslr_padding();
>  
>  	/* Adapt phyiscal memory region size based on available memory */
>  	if (memory_tb < kaslr_regions[0].size_tb)
> -- 
> 2.20.1
> 
