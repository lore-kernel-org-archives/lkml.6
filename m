Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeDYIJk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:09:40 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55267 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeDYIJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:09:28 -0400
X-Google-Smtp-Source: AIpwx48Y0PbBOT7AdQg2pjXrcQmx8XcHo9EKj/d9vo0tl4rtbprRf4aeTnA1uosVoVduBupl07vb3I66LtFsXEij7Es=
MIME-Version: 1.0
In-Reply-To: <20180425063527.29763-1-takahiro.akashi@linaro.org>
References: <20180425063527.29763-1-takahiro.akashi@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 25 Apr 2018 10:09:26 +0200
Message-ID: <CAKv+Gu9eAYzTFGdiUOyCTVyG4F1faefrehxmvUpE2YbCWvio4Q@mail.gmail.com>
Subject: Re: [RESEND PATCH] arm64: acpi,efi: fix alignment fault in accessing
 ACPI tables at kdump
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, Dave Young <dyoung@redhat.com>,
        James Morse <james.morse@arm.com>, Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 April 2018 at 08:35, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> This is a fix against the issue that crash dump kernel may hang up
> during booting, which can happen on any ACPI-based system with "ACPI
> Reclaim Memory."
>
> (kernel messages after panic kicked off kdump)
>            (snip...)
>         Bye!
>            (snip...)
>         ACPI: Core revision 20170728
>         pud=000000002e7d0003, *pmd=000000002e7c0003, *pte=00e8000039710707
>         Internal error: Oops: 96000021 [#1] SMP
>         Modules linked in:
>         CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-rc6 #1
>         task: ffff000008d05180 task.stack: ffff000008cc0000
>         PC is at acpi_ns_lookup+0x25c/0x3c0
>         LR is at acpi_ds_load1_begin_op+0xa4/0x294
>            (snip...)
>         Process swapper/0 (pid: 0, stack limit = 0xffff000008cc0000)
>         Call trace:
>            (snip...)
>         [<ffff0000084a6764>] acpi_ns_lookup+0x25c/0x3c0
>         [<ffff00000849b4f8>] acpi_ds_load1_begin_op+0xa4/0x294
>         [<ffff0000084ad4ac>] acpi_ps_build_named_op+0xc4/0x198
>         [<ffff0000084ad6cc>] acpi_ps_create_op+0x14c/0x270
>         [<ffff0000084acfa8>] acpi_ps_parse_loop+0x188/0x5c8
>         [<ffff0000084ae048>] acpi_ps_parse_aml+0xb0/0x2b8
>         [<ffff0000084a8e10>] acpi_ns_one_complete_parse+0x144/0x184
>         [<ffff0000084a8e98>] acpi_ns_parse_table+0x48/0x68
>         [<ffff0000084a82cc>] acpi_ns_load_table+0x4c/0xdc
>         [<ffff0000084b32f8>] acpi_tb_load_namespace+0xe4/0x264
>         [<ffff000008baf9b4>] acpi_load_tables+0x48/0xc0
>         [<ffff000008badc20>] acpi_early_init+0x9c/0xd0
>         [<ffff000008b70d50>] start_kernel+0x3b4/0x43c
>         Code: b9008fb9 2a000318 36380054 32190318 (b94002c0)
>         ---[ end trace c46ed37f9651c58e ]---
>         Kernel panic - not syncing: Fatal exception
>         Rebooting in 10 seconds..
>
> (diagnosis)
> * This fault is a data abort, alignment fault (ESR=0x96000021)
>   during reading out ACPI table.
> * Initial ACPI tables are normally stored in system ram and marked as
>   "ACPI Reclaim memory" by the firmware.
> * After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
>   memory as MEMBLOCK_NOMAP"), those regions are differently handled
>   as they are "memblock-reserved", without NOMAP bit.
> * So they are now excluded from device tree's "usable-memory-range"
>   which kexec-tools determines based on a current view of /proc/iomem.
> * When crash dump kernel boots up, it tries to accesses ACPI tables by
>   mapping them with ioremap(), not ioremap_cache(), in acpi_os_ioremap()
>   since they are no longer part of mapped system ram.
> * Given that ACPI accessor/helper functions are compiled in without
>   unaligned access support (ACPI_MISALIGNMENT_NOT_SUPPORTED),
>   any unaligned access to ACPI tables can cause a fatal panic.
>
> With this patch, acpi_os_ioremap() always honors a memory attribute
> provided by the firmware (efi). Hence retaining cacheability in said cases
> allows the kernel safe access to ACPI tables.
>
> Please note that arm_enable_runtime_services(), which is renamed to
> efi_enter_virtual_mode() due to the similarity to x86's, is now called
> earlier before acpi_early_init() since efi_mem_attributes() relies on
> efi.memmap being mapped.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Suggested-by: James Morse <james.morse@arm.com>
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by and Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  arch/arm64/include/asm/acpi.h      | 23 ++++++++++++++++-------
>  arch/arm64/kernel/acpi.c           | 11 +++--------
>  drivers/firmware/efi/arm-runtime.c | 15 ++++++---------
>  init/main.c                        |  3 +++
>  4 files changed, 28 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 32f465a80e4e..d53c95f4e1a9 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -12,10 +12,12 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
>
> +#include <linux/efi.h>
>  #include <linux/memblock.h>
>  #include <linux/psci.h>
>
>  #include <asm/cputype.h>
> +#include <asm/io.h>
>  #include <asm/smp_plat.h>
>  #include <asm/tlbflush.h>
>
> @@ -29,18 +31,22 @@
>
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
> +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> +
>  /* ACPI table mapping after acpi_permanent_mmap is set */
>  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>                                             acpi_size size)
>  {
> +       /* For normal memory we already have a cacheable mapping. */
> +       if (memblock_is_map_memory(phys))
> +               return (void __iomem *)__phys_to_virt(phys);
> +
>         /*
> -        * EFI's reserve_regions() call adds memory with the WB attribute
> -        * to memblock via early_init_dt_add_memory_arch().
> +        * We should still honor the memory's attribute here because
> +        * crash dump kernel possibly excludes some ACPI (reclaim)
> +        * regions from memblock list.
>          */
> -       if (!memblock_is_memory(phys))
> -               return ioremap(phys, size);
> -
> -       return ioremap_cache(phys, size);
> +       return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
>  }
>  #define acpi_os_ioremap acpi_os_ioremap
>
> @@ -125,7 +131,10 @@ static inline const char *acpi_get_enable_method(int cpu)
>   * for compatibility.
>   */
>  #define acpi_disable_cmcff 1
> -pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
> +static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
> +{
> +       return __acpi_get_mem_attribute(addr);
> +}
>  #endif /* CONFIG_ACPI_APEI */
>
>  #ifdef CONFIG_ACPI_NUMA
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 7b09487ff8fb..7880076c1cf0 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -18,6 +18,7 @@
>  #include <linux/acpi.h>
>  #include <linux/bootmem.h>
>  #include <linux/cpumask.h>
> +# include <linux/efi.h>

Please drop the space after #

>  #include <linux/efi-bgrt.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
> @@ -29,12 +30,8 @@
>
>  #include <asm/cputype.h>
>  #include <asm/cpu_ops.h>
> -#include <asm/smp_plat.h>
> -
> -#ifdef CONFIG_ACPI_APEI
> -# include <linux/efi.h>
>  # include <asm/pgtable.h>

And here

> -#endif
> +#include <asm/smp_plat.h>
>
>  int acpi_noirq = 1;            /* skip ACPI IRQ initialization */
>  int acpi_disabled = 1;
> @@ -239,8 +236,7 @@ void __init acpi_boot_table_init(void)
>         }
>  }
>
> -#ifdef CONFIG_ACPI_APEI
> -pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
> +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
>  {
>         /*
>          * According to "Table 8 Map: EFI memory types to AArch64 memory
> @@ -261,4 +257,3 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
>                 return __pgprot(PROT_NORMAL_NC);
>         return __pgprot(PROT_DEVICE_nGnRnE);
>  }
> -#endif
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 5889cbea60b8..1148ea5a0faa 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -106,23 +106,23 @@ static bool __init efi_virtmap_init(void)
>   * non-early mapping of the UEFI system table and virtual mappings for all
>   * EFI_MEMORY_RUNTIME regions.
>   */
> -static int __init arm_enable_runtime_services(void)
> +void __init efi_enter_virtual_mode(void)
>  {
>         u64 mapsize;
>
>         if (!efi_enabled(EFI_BOOT)) {
>                 pr_info("EFI services will not be available.\n");
> -               return 0;
> +               return;
>         }
>
>         if (efi_runtime_disabled()) {
>                 pr_info("EFI runtime services will be disabled.\n");
> -               return 0;
> +               return;
>         }
>

This is a problem. If you are booting using efi=noruntime, the routine
exits early and never sets up the mapping for the EFI memory map.
So the efi_memmap_init_late() call should be moved before the
efi_runtime_disabled() check, everything else can stay as is afaict

Could you please move the changes to this file and init/main.c into a
separate patch?

>         if (efi_enabled(EFI_RUNTIME_SERVICES)) {
>                 pr_info("EFI runtime services access via paravirt.\n");
> -               return 0;
> +               return;
>         }
>
>         pr_info("Remapping and enabling EFI services.\n");
> @@ -131,21 +131,18 @@ static int __init arm_enable_runtime_services(void)
>
>         if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
>                 pr_err("Failed to remap EFI memory map\n");
> -               return -ENOMEM;
> +               return;
>         }
>
>         if (!efi_virtmap_init()) {
>                 pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
> -               return -ENOMEM;
> +               return;
>         }
>
>         /* Set up runtime services function pointers */
>         efi_native_runtime_setup();
>         set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> -
> -       return 0;
>  }
> -early_initcall(arm_enable_runtime_services);
>
>  void efi_virtmap_load(void)
>  {
> diff --git a/init/main.c b/init/main.c
> index b795aa341a3a..40d05b63960f 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -693,6 +693,9 @@ asmlinkage __visible void __init start_kernel(void)
>         debug_objects_mem_init();
>         setup_per_cpu_pageset();
>         numa_policy_init();
> +       if (IS_ENABLED(CONFIG_EFI) &&
> +           (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)))
> +               efi_enter_virtual_mode();
>         acpi_early_init();
>         if (late_time_init)
>                 late_time_init();
> --
> 2.17.0
>
