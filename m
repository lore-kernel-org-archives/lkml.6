Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA2BC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D043724449
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D043724449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932646AbeGDBjJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:39:09 -0400
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:33546
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932263AbeGDBjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:39:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BCAAD1Izxb/zXSMGcNTxoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGFUoN5iASNCAEBAQEBAQaBCAgidZQzgXqEdwKCOjQYAQIBAQEBAQE?=
 =?us-ascii?q?ChkwBAQEDIwQRQRALDQEKAgImAgJXBgEMBgIBAYMcgXOncG6BaTMahEGDdYE6g?=
 =?us-ascii?q?QuIcIEHgQ8nDIInNYR6gwGCVQKHYYUsjD4IAY8ZiCsDhS8rkx+CCjMaCCgIgyS?=
 =?us-ascii?q?CJBeOKV0BkRABAQ?=
X-IPAS-Result: =?us-ascii?q?A2BCAAD1Izxb/zXSMGcNTxoBAQEBAQIBAQEBCAEBAQGFUoN?=
 =?us-ascii?q?5iASNCAEBAQEBAQaBCAgidZQzgXqEdwKCOjQYAQIBAQEBAQEChkwBAQEDIwQRQ?=
 =?us-ascii?q?RALDQEKAgImAgJXBgEMBgIBAYMcgXOncG6BaTMahEGDdYE6gQuIcIEHgQ8nDII?=
 =?us-ascii?q?nNYR6gwGCVQKHYYUsjD4IAY8ZiCsDhS8rkx+CCjMaCCgIgySCJBeOKV0BkRABA?=
 =?us-ascii?q?Q?=
X-IronPort-AV: E=Sophos;i="5.51,306,1526313600"; 
   d="scan'208";a="91670113"
Received: from unknown (HELO [10.44.0.22]) ([103.48.210.53])
  by icp-osb-irony-out3.iinet.net.au with ESMTP; 04 Jul 2018 09:39:01 +0800
Subject: Re: [PATCH 3/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1530613795-6956-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530613795-6956-4-git-send-email-rppt@linux.vnet.ibm.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <5388c6eb-2159-b103-51f9-2a211c54b4bc@linux-m68k.org>
Date:   Wed, 4 Jul 2018 11:39:00 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530613795-6956-4-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 03/07/18 20:29, Mike Rapoport wrote:
> In m68k the physical memory is described by [memory_start, memory_end] for
> !MMU variant and by m68k_memory array of memory ranges for the MMU version.
> This information is directly used to register the physical memory with
> memblock.
> 
> The reserve_bootmem() calls are replaced with memblock_reserve() and the
> bootmap bitmap allocation is simply dropped.
> 
> Since the MMU variant creates early mappings only for the small part of the
> memory we force bottom-up allocations in memblock because otherwise we will
> attempt to access memory that not yet mapped
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

This builds cleanly for me with a m5475_defconfig, but it fails
to boot on real hardware. No console, no nothing on startup.
I haven't debugged any further yet.

The M5475 is a ColdFire with MMU enabled target.

Regards
Greg


> ---
>   arch/m68k/Kconfig           |  3 +++
>   arch/m68k/kernel/setup_mm.c | 14 ++++----------
>   arch/m68k/kernel/setup_no.c | 20 ++++----------------
>   arch/m68k/mm/init.c         |  1 -
>   arch/m68k/mm/mcfmmu.c       | 11 +++++++----
>   arch/m68k/mm/motorola.c     | 35 +++++++++++------------------------
>   arch/m68k/sun3/config.c     |  4 ----
>   7 files changed, 29 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 785612b..bd7f38a 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -24,6 +24,9 @@ config M68K
>   	select MODULES_USE_ELF_RELA
>   	select OLD_SIGSUSPEND3
>   	select OLD_SIGACTION
> +	select HAVE_MEMBLOCK
> +	select ARCH_DISCARD_MEMBLOCK
> +	select NO_BOOTMEM
>   
>   config CPU_BIG_ENDIAN
>   	def_bool y
> diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
> index f35e3eb..6512955 100644
> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -21,6 +21,7 @@
>   #include <linux/string.h>
>   #include <linux/init.h>
>   #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>   #include <linux/proc_fs.h>
>   #include <linux/seq_file.h>
>   #include <linux/module.h>
> @@ -165,6 +166,8 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
>   					be32_to_cpu(m->addr);
>   				m68k_memory[m68k_num_memory].size =
>   					be32_to_cpu(m->size);
> +				memblock_add(m68k_memory[m68k_num_memory].addr,
> +					     m68k_memory[m68k_num_memory].size);
>   				m68k_num_memory++;
>   			} else
>   				pr_warn("%s: too many memory chunks\n",
> @@ -224,10 +227,6 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
>   
>   void __init setup_arch(char **cmdline_p)
>   {
> -#ifndef CONFIG_SUN3
> -	int i;
> -#endif
> -
>   	/* The bootinfo is located right after the kernel */
>   	if (!CPU_IS_COLDFIRE)
>   		m68k_parse_bootinfo((const struct bi_record *)_end);
> @@ -356,14 +355,9 @@ void __init setup_arch(char **cmdline_p)
>   #endif
>   
>   #ifndef CONFIG_SUN3
> -	for (i = 1; i < m68k_num_memory; i++)
> -		free_bootmem_node(NODE_DATA(i), m68k_memory[i].addr,
> -				  m68k_memory[i].size);
>   #ifdef CONFIG_BLK_DEV_INITRD
>   	if (m68k_ramdisk.size) {
> -		reserve_bootmem_node(__virt_to_node(phys_to_virt(m68k_ramdisk.addr)),
> -				     m68k_ramdisk.addr, m68k_ramdisk.size,
> -				     BOOTMEM_DEFAULT);
> +		memblock_reserve(m68k_ramdisk.addr, m68k_ramdisk.size);
>   		initrd_start = (unsigned long)phys_to_virt(m68k_ramdisk.addr);
>   		initrd_end = initrd_start + m68k_ramdisk.size;
>   		pr_info("initrd: %08lx - %08lx\n", initrd_start, initrd_end);
> diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
> index a98af10..3e8d87a 100644
> --- a/arch/m68k/kernel/setup_no.c
> +++ b/arch/m68k/kernel/setup_no.c
> @@ -28,6 +28,7 @@
>   #include <linux/errno.h>
>   #include <linux/string.h>
>   #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>   #include <linux/seq_file.h>
>   #include <linux/init.h>
>   #include <linux/initrd.h>
> @@ -86,8 +87,6 @@ void (*mach_power_off)(void);
>   
>   void __init setup_arch(char **cmdline_p)
>   {
> -	int bootmap_size;
> -
>   	memory_start = PAGE_ALIGN(_ramstart);
>   	memory_end = _ramend;
>   
> @@ -142,6 +141,8 @@ void __init setup_arch(char **cmdline_p)
>   	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n ",
>   		 __bss_stop, memory_start, memory_start, memory_end);
>   
> +	memblock_add(memory_start, memory_end - memory_start);
> +
>   	/* Keep a copy of command line */
>   	*cmdline_p = &command_line[0];
>   	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
> @@ -158,23 +159,10 @@ void __init setup_arch(char **cmdline_p)
>   	min_low_pfn = PFN_DOWN(memory_start);
>   	max_pfn = max_low_pfn = PFN_DOWN(memory_end);
>   
> -	bootmap_size = init_bootmem_node(
> -			NODE_DATA(0),
> -			min_low_pfn,		/* map goes here */
> -			PFN_DOWN(PAGE_OFFSET),
> -			max_pfn);
> -	/*
> -	 * Free the usable memory, we have to make sure we do not free
> -	 * the bootmem bitmap so we then reserve it after freeing it :-)
> -	 */
> -	free_bootmem(memory_start, memory_end - memory_start);
> -	reserve_bootmem(memory_start, bootmap_size, BOOTMEM_DEFAULT);
> -
>   #if defined(CONFIG_UBOOT) && defined(CONFIG_BLK_DEV_INITRD)
>   	if ((initrd_start > 0) && (initrd_start < initrd_end) &&
>   			(initrd_end < memory_end))
> -		reserve_bootmem(initrd_start, initrd_end - initrd_start,
> -				 BOOTMEM_DEFAULT);
> +		memblock_reserve(initrd_start, initrd_end - initrd_start);
>   #endif /* if defined(CONFIG_BLK_DEV_INITRD) */
>   
>   	/*
> diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
> index 8827b7f..38e2b27 100644
> --- a/arch/m68k/mm/init.c
> +++ b/arch/m68k/mm/init.c
> @@ -71,7 +71,6 @@ void __init m68k_setup_node(int node)
>   		pg_data_table[i] = pg_data_map + node;
>   	}
>   #endif
> -	pg_data_map[node].bdata = bootmem_node_data + node;
>   	node_set_online(node);
>   }
>   
> diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
> index 2925d79..e9e60e1 100644
> --- a/arch/m68k/mm/mcfmmu.c
> +++ b/arch/m68k/mm/mcfmmu.c
> @@ -14,6 +14,7 @@
>   #include <linux/init.h>
>   #include <linux/string.h>
>   #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>   
>   #include <asm/setup.h>
>   #include <asm/page.h>
> @@ -160,6 +161,8 @@ void __init cf_bootmem_alloc(void)
>   	m68k_memory[0].addr = _rambase;
>   	m68k_memory[0].size = _ramend - _rambase;
>   
> +	memblock_add(m68k_memory[0].addr, m68k_memory[0].size);
> +
>   	/* compute total pages in system */
>   	num_pages = PFN_DOWN(_ramend - _rambase);
>   
> @@ -170,14 +173,14 @@ void __init cf_bootmem_alloc(void)
>   	max_pfn = max_low_pfn = PFN_DOWN(_ramend);
>   	high_memory = (void *)_ramend;
>   
> +	/* Reserve kernel text/data/bss */
> +	memblock_reserve(memstart, _ramend - memstart);
> +
>   	m68k_virt_to_node_shift = fls(_ramend - 1) - 6;
>   	module_fixup(NULL, __start_fixup, __stop_fixup);
>   
> -	/* setup bootmem data */
> +	/* setup node data */
>   	m68k_setup_node(0);
> -	memstart += init_bootmem_node(NODE_DATA(0), start_pfn,
> -		min_low_pfn, max_low_pfn);
> -	free_bootmem_node(NODE_DATA(0), memstart, _ramend - memstart);
>   }
>   
>   /*
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index e490ecc..4e17ecb 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -19,6 +19,7 @@
>   #include <linux/types.h>
>   #include <linux/init.h>
>   #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>   #include <linux/gfp.h>
>   
>   #include <asm/setup.h>
> @@ -208,7 +209,7 @@ void __init paging_init(void)
>   {
>   	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
>   	unsigned long min_addr, max_addr;
> -	unsigned long addr, size, end;
> +	unsigned long addr;
>   	int i;
>   
>   #ifdef DEBUG
> @@ -253,34 +254,20 @@ void __init paging_init(void)
>   	min_low_pfn = availmem >> PAGE_SHIFT;
>   	max_pfn = max_low_pfn = max_addr >> PAGE_SHIFT;
>   
> -	for (i = 0; i < m68k_num_memory; i++) {
> -		addr = m68k_memory[i].addr;
> -		end = addr + m68k_memory[i].size;
> -		m68k_setup_node(i);
> -		availmem = PAGE_ALIGN(availmem);
> -		availmem += init_bootmem_node(NODE_DATA(i),
> -					      availmem >> PAGE_SHIFT,
> -					      addr >> PAGE_SHIFT,
> -					      end >> PAGE_SHIFT);
> -	}
> +	/* Reserve kernel text/data/bss and the memory allocated in head.S */
> +	memblock_reserve(m68k_memory[0].addr, availmem - m68k_memory[0].addr);
>   
>   	/*
>   	 * Map the physical memory available into the kernel virtual
> -	 * address space. First initialize the bootmem allocator with
> -	 * the memory we already mapped, so map_node() has something
> -	 * to allocate.
> +	 * address space. Make sure memblock will not try to allocate
> +	 * pages beyond the memory we already mapped in head.S
>   	 */
> -	addr = m68k_memory[0].addr;
> -	size = m68k_memory[0].size;
> -	free_bootmem_node(NODE_DATA(0), availmem,
> -			  min(m68k_init_mapped_size, size) - (availmem - addr));
> -	map_node(0);
> -	if (size > m68k_init_mapped_size)
> -		free_bootmem_node(NODE_DATA(0), addr + m68k_init_mapped_size,
> -				  size - m68k_init_mapped_size);
> -
> -	for (i = 1; i < m68k_num_memory; i++)
> +	memblock_set_bottom_up(true);
> +
> +	for (i = 0; i < m68k_num_memory; i++) {
> +		m68k_setup_node(i);
>   		map_node(i);
> +	}
>   
>   	flush_tlb_all();
>   
> diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
> index 1d28d38..79a2bb8 100644
> --- a/arch/m68k/sun3/config.c
> +++ b/arch/m68k/sun3/config.c
> @@ -123,10 +123,6 @@ static void __init sun3_bootmem_alloc(unsigned long memory_start,
>   	availmem = memory_start;
>   
>   	m68k_setup_node(0);
> -	availmem += init_bootmem(start_page, num_pages);
> -	availmem = (availmem + (PAGE_SIZE-1)) & PAGE_MASK;
> -
> -	free_bootmem(__pa(availmem), memory_end - (availmem));
>   }
>   
>   
> 
