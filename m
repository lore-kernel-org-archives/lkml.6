Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965526AbeCACpa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 21:45:30 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:45832 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965468AbeCACp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 21:45:27 -0500
X-Google-Smtp-Source: AG47ELu5qzrnBjkfjfrIFMw58OkNoUAxjSe7neLxC2Bi9KSLs93/WdVnjVL3sw6z1Mob8MwlrGIO8w==
Subject: Re: 4.16 regression: s2ram broken on non-PAE i686
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        William Grant <william.grant@canonical.com>
References: <CAM6Zs0WTjWW+Lw3ws_iAH-K1dJgd5r9s0oC=u4TgEFUyC5bxig@mail.gmail.com>
 <alpine.DEB.2.21.1802280959180.1886@nanos.tec.linutronix.de>
 <da61401a-5d97-c925-ef0b-fcd937c2712a@gmail.com>
 <alpine.DEB.2.21.1802282137290.1392@nanos.tec.linutronix.de>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <80bffdab-be19-17f3-f3ba-bf96050130ee@gmail.com>
Date: Wed, 28 Feb 2018 21:45:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802282137290.1392@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> Woody,
>
> On Wed, 28 Feb 2018, Woody Suwalski wrote:
>> Certainly. I understand you want dmesg output for kernels build with and
>> without PAE, not just PAE=n on the cmdline :-)
>> Here it is...
> Thanks for providing the data. It did not pinpoint the issue but at least
> it gave me the hint to look into the right direction.
>
> Does the patch below fix the issue for you? It's untested as I'm at home
> and have no access to a 32bit machine right now.
>
> Thanks,
>
> 	tglx
>
> 8<------------------
> Subject: x86/cpu_entry_area: Sync cpu_entry_area to initial_page_table
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Wed, 28 Feb 2018 21:14:26 +0100
>
> The separation of the cpu_entry_area from the fixmap missed the fact that
> on 32bit non-PAE kernels the cpu_entry_area mapping might not be covered in
> initial_page_table by the previous synchronizations.
>
> This results in suspend/resume failures because 32bit utilizes initial page
> table for resume. The absence of the cpu_entry_area mapping results in a
> triple fault, aka. insta reboot.
>
> Synchronize the initial page table after setting up the cpu entry
> area. Instead of adding yet another copy of the same code, move it to a
> function and invoke it from the various places.
>
> It needs to be investigated if the existing calls in setup_arch() and
> setup_per_cpu_areas() can be replaced by the later invocation from
> setup_cpu_entry_areas(), but that's beyond the scope of this fix.
>
> Fixes: 92a0f81d8957 ("x86/cpu_entry_area: Move it out of the fixmap")
> Reported-by: Woody Suwalski <terraluna977@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>   arch/x86/include/asm/pgtable_32.h |    1 +
>   arch/x86/include/asm/pgtable_64.h |    1 +
>   arch/x86/kernel/setup.c           |   17 +++++------------
>   arch/x86/kernel/setup_percpu.c    |   17 ++++-------------
>   arch/x86/mm/cpu_entry_area.c      |    6 ++++++
>   arch/x86/mm/init_32.c             |   15 +++++++++++++++
>   6 files changed, 32 insertions(+), 25 deletions(-)
>
> --- a/arch/x86/include/asm/pgtable_32.h
> +++ b/arch/x86/include/asm/pgtable_32.h
> @@ -32,6 +32,7 @@ extern pmd_t initial_pg_pmd[];
>   static inline void pgtable_cache_init(void) { }
>   static inline void check_pgt_cache(void) { }
>   void paging_init(void);
> +void sync_initial_page_table(void);
>   
>   /*
>    * Define this if things work differently on an i386 and an i486:
> --- a/arch/x86/include/asm/pgtable_64.h
> +++ b/arch/x86/include/asm/pgtable_64.h
> @@ -28,6 +28,7 @@ extern pgd_t init_top_pgt[];
>   #define swapper_pg_dir init_top_pgt
>   
>   extern void paging_init(void);
> +static inline void sync_initial_page_table(void) { }
>   
>   #define pte_ERROR(e)					\
>   	pr_err("%s:%d: bad pte %p(%016lx)\n",		\
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1204,20 +1204,13 @@ void __init setup_arch(char **cmdline_p)
>   
>   	kasan_init();
>   
> -#ifdef CONFIG_X86_32
> -	/* sync back kernel address range */
> -	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
> -			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
> -			KERNEL_PGD_PTRS);
> -
>   	/*
> -	 * sync back low identity map too.  It is used for example
> -	 * in the 32-bit EFI stub.
> +	 * Sync back kernel address range.
> +	 *
> +	 * FIXME: Can the later sync in setup_cpu_entry_areas() replace
> +	 * this call?
>   	 */
> -	clone_pgd_range(initial_page_table,
> -			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
> -			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
> -#endif
> +	sync_initial_page_table();
>   
>   	tboot_probe();
>   
> --- a/arch/x86/kernel/setup_percpu.c
> +++ b/arch/x86/kernel/setup_percpu.c
> @@ -287,24 +287,15 @@ void __init setup_per_cpu_areas(void)
>   	/* Setup cpu initialized, callin, callout masks */
>   	setup_cpu_local_masks();
>   
> -#ifdef CONFIG_X86_32
>   	/*
>   	 * Sync back kernel address range again.  We already did this in
>   	 * setup_arch(), but percpu data also needs to be available in
>   	 * the smpboot asm.  We can't reliably pick up percpu mappings
>   	 * using vmalloc_fault(), because exception dispatch needs
>   	 * percpu data.
> +	 *
> +	 * FIXME: Can the later sync in setup_cpu_entry_areas() replace
> +	 * this call?
>   	 */
> -	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
> -			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
> -			KERNEL_PGD_PTRS);
> -
> -	/*
> -	 * sync back low identity map too.  It is used for example
> -	 * in the 32-bit EFI stub.
> -	 */
> -	clone_pgd_range(initial_page_table,
> -			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
> -			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
> -#endif
> +	sync_initial_page_table();
>   }
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -163,4 +163,10 @@ void __init setup_cpu_entry_areas(void)
>   
>   	for_each_possible_cpu(cpu)
>   		setup_cpu_entry_area(cpu);
> +
> +	/*
> +	 * This is the last essential update to swapper_pgdir which needs
> +	 * to be synchronized to initial_page_table on 32bit.
> +	 */
> +	sync_initial_page_table();
>   }
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -453,6 +453,21 @@ static inline void permanent_kmaps_init(
>   }
>   #endif /* CONFIG_HIGHMEM */
>   
> +void __init sync_initial_page_table(void)
> +{
> +	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
> +			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
> +			KERNEL_PGD_PTRS);
> +
> +	/*
> +	 * sync back low identity map too.  It is used for example
> +	 * in the 32-bit EFI stub.
> +	 */
> +	clone_pgd_range(initial_page_table,
> +			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
> +			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
> +}
> +
>   void __init native_pagetable_init(void)
>   {
>   	unsigned long pfn, va;
Thanks for the patch, good news, it did fix the problem.
I did 2 builds and both worked OK over the s2ram cycle.

It will be necessary to add the patch to 4.15-stable and 4.14-stable, I 
believe that both have now broken s2ram.

I will build tomorrow 4.15 and 4.14 with your patch and try it out - the 
patch seems to apply OK to 4.15.7 and 4.14.23...

Thanks, Woody
