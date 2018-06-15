Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E9AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B409F208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B409F208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966039AbeFOQaO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:30:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44138 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966019AbeFOQaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:30:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECFE01529;
        Fri, 15 Jun 2018 09:30:12 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6A3E3F25D;
        Fri, 15 Jun 2018 09:30:09 -0700 (PDT)
Subject: Re: [PATCH 2/3] arm64: acpi,efi: fix alignment fault in accessing
 ACPI tables at kdump
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
 <20180615075623.13454-3-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <026a4d23-ac91-ed35-d711-c55882242037@arm.com>
Date:   Fri, 15 Jun 2018 17:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615075623.13454-3-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 15/06/18 08:56, AKASHI Takahiro wrote:
> This is a fix against the issue that crash dump kernel may hang up
> during booting, which can happen on any ACPI-based system with "ACPI
> Reclaim Memory."
> 
> (kernel messages after panic kicked off kdump)
> 	   (snip...)
> 	Bye!
> 	   (snip...)
> 	ACPI: Core revision 20170728
> 	pud=000000002e7d0003, *pmd=000000002e7c0003, *pte=00e8000039710707
> 	Internal error: Oops: 96000021 [#1] SMP
> 	Modules linked in:
> 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-rc6 #1
> 	task: ffff000008d05180 task.stack: ffff000008cc0000
> 	PC is at acpi_ns_lookup+0x25c/0x3c0
> 	LR is at acpi_ds_load1_begin_op+0xa4/0x294
> 	   (snip...)
> 	Process swapper/0 (pid: 0, stack limit = 0xffff000008cc0000)
> 	Call trace:
> 	   (snip...)
> 	[<ffff0000084a6764>] acpi_ns_lookup+0x25c/0x3c0
> 	[<ffff00000849b4f8>] acpi_ds_load1_begin_op+0xa4/0x294
> 	[<ffff0000084ad4ac>] acpi_ps_build_named_op+0xc4/0x198
> 	[<ffff0000084ad6cc>] acpi_ps_create_op+0x14c/0x270
> 	[<ffff0000084acfa8>] acpi_ps_parse_loop+0x188/0x5c8
> 	[<ffff0000084ae048>] acpi_ps_parse_aml+0xb0/0x2b8
> 	[<ffff0000084a8e10>] acpi_ns_one_complete_parse+0x144/0x184
> 	[<ffff0000084a8e98>] acpi_ns_parse_table+0x48/0x68
> 	[<ffff0000084a82cc>] acpi_ns_load_table+0x4c/0xdc
> 	[<ffff0000084b32f8>] acpi_tb_load_namespace+0xe4/0x264
> 	[<ffff000008baf9b4>] acpi_load_tables+0x48/0xc0
> 	[<ffff000008badc20>] acpi_early_init+0x9c/0xd0
> 	[<ffff000008b70d50>] start_kernel+0x3b4/0x43c
> 	Code: b9008fb9 2a000318 36380054 32190318 (b94002c0)
> 	---[ end trace c46ed37f9651c58e ]---
> 	Kernel panic - not syncing: Fatal exception
> 	Rebooting in 10 seconds..
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
> With this patch, acpi_os_ioremap() always honors memory attribute
> information provided by the firmware (EFI) and retaining cacheability
> allows the kernel safe access to ACPI tables.


> Please note that arm_enable_runtime_services() is now renamed to
> efi_enter_virtual_mode() due to the similarity to x86's.

Just a rename?:
>  drivers/firmware/efi/arm-runtime.c | 27 ++++++++++++---------------



> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 32f465a80e4e..d53c95f4e1a9 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -29,18 +31,22 @@
>  
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
> +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> +
>  /* ACPI table mapping after acpi_permanent_mmap is set */
>  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>  					    acpi_size size)
>  {
> +	/* For normal memory we already have a cacheable mapping. */
> +	if (memblock_is_map_memory(phys))
> +		return (void __iomem *)__phys_to_virt(phys);

>  	/*
> -	 * EFI's reserve_regions() call adds memory with the WB attribute
> -	 * to memblock via early_init_dt_add_memory_arch().
> +	 * We should still honor the memory's attribute here because
> +	 * crash dump kernel possibly excludes some ACPI (reclaim)
> +	 * regions from memblock list.
>  	 */

(Even without kdump we would still need this. Regions ACPI wants mapped may not
be covered by the linear map. In this case we need to use the attributes
firmware described in the UEFI memory map. Kdump exacerbates this by
artificially reducing the range of the linear map.)


> -	if (!memblock_is_memory(phys))
> -		return ioremap(phys, size);
> -
> -	return ioremap_cache(phys, size);
> +	return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
>  }



> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 5889cbea60b8..566ef0a9edb5 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -106,46 +106,43 @@ static bool __init efi_virtmap_init(void)
>   * non-early mapping of the UEFI system table and virtual mappings for all
>   * EFI_MEMORY_RUNTIME regions.
>   */
> -static int __init arm_enable_runtime_services(void)
> +void __init efi_enter_virtual_mode(void)
>  {
>  	u64 mapsize;
>  
>  	if (!efi_enabled(EFI_BOOT)) {
>  		pr_info("EFI services will not be available.\n");
> -		return 0;
> +		return;
> +	}
> +
> +	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> +
> +	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> +		pr_err("Failed to remap EFI memory map\n");
> +		return;
>  	}
>  
>  	if (efi_runtime_disabled()) {
>  		pr_info("EFI runtime services will be disabled.\n");
> -		return 0;
> +		return;
>  	}
>  
>  	if (efi_enabled(EFI_RUNTIME_SERVICES)) {
>  		pr_info("EFI runtime services access via paravirt.\n");
> -		return 0;
> +		return;
>  	}
>  
>  	pr_info("Remapping and enabling EFI services.\n");
>  
> -	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> -
> -	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> -		pr_err("Failed to remap EFI memory map\n");
> -		return -ENOMEM;
> -	}
> -
>  	if (!efi_virtmap_init()) {
>  		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
> -		return -ENOMEM;
> +		return;
>  	}
>  
>  	/* Set up runtime services function pointers */
>  	efi_native_runtime_setup();
>  	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> -
> -	return 0;
>  }

Please have the drivers/firmware/efi/arm-runtime.c changes in a separate patch
(maybe combine it with patch 3). The 'efi/arm: ' prefix is more likely to catch
the maintainers attention.

I think this is what Ard meant by:
| Could you please move the changes to this file and init/main.c into a
| separate patch?

https://patchwork.kernel.org/patch/10361761/


> -early_initcall(arm_enable_runtime_services);

With just this patch, surely nothing ever calls arm_enable_runtime_services(),
and now acpi_os_ioremap() will return device memory for anything that isn't part
of the linear region. (This breaks RAS).

This will make it difficult to bisect through for any RAS or
efi-runtime-services issue. Its easily fixed: please put the efi+init changes in
a patch before the acpi_os_ioremap() changes.


Otherwise, looks good to me!


Thanks,

James
