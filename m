Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF28C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB4E20844
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB4E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbeGDRGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:06:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40894 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752165AbeGDRGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:06:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E29167A9;
        Wed,  4 Jul 2018 10:06:15 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B29B63F5AD;
        Wed,  4 Jul 2018 10:06:15 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id AF7341AE180C; Wed,  4 Jul 2018 18:06:55 +0100 (BST)
Date:   Wed, 4 Jul 2018 18:06:55 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, tbaicar@codeaurora.org,
        bhsharma@redhat.com, dyoung@redhat.com, james.morse@arm.com,
        mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
Message-ID: <20180704170655.GD8370@arm.com>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619064424.6642-4-takahiro.akashi@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

[Ard -- please can you look at the EFI parts of this patch]

On Tue, Jun 19, 2018 at 03:44:23PM +0900, AKASHI Takahiro wrote:
> Since arm_enter_runtime_services() was modified to always create a virtual
> mapping of UEFI memory map in the previous patch, it is now renamed to
> efi_enter_virtual_mode() and called earlier before acpi_load_tables()
> in acpi_early_init().
> 
> This will allow us to use UEFI memory map in acpi_os_ioremap() to create
> mappings of ACPI tables using memory attributes described in UEFI memory
> map.
> 
> See a relevant commit:
>     arm64: acpi: fix alignment fault in accessing ACPI tables
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/firmware/efi/arm-runtime.c | 15 ++++++---------
>  init/main.c                        |  3 +++
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 30ac5c82051e..566ef0a9edb5 100644
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
>  	}
>  
>  	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
>  
>  	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
>  		pr_err("Failed to remap EFI memory map\n");
> -		return 0;
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
> -early_initcall(arm_enable_runtime_services);
>  
>  void efi_virtmap_load(void)
>  {
> diff --git a/init/main.c b/init/main.c
> index 3b4ada11ed52..532fc0d02353 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -694,6 +694,9 @@ asmlinkage __visible void __init start_kernel(void)
>  	debug_objects_mem_init();
>  	setup_per_cpu_pageset();
>  	numa_policy_init();
> +	if (IS_ENABLED(CONFIG_EFI) &&
> +	    (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)))
> +		efi_enter_virtual_mode();

Hmm, this is ugly as hell. Is there nothing else we can piggy-back off?
It's also fairly jarring that, on x86, efi_enter_virtual_mode() is called
a few lines later, *after* acpi_early_init() has been called.

The rest of the series looks fine to me, but I'm not comfortable taking
changes like this via the arm64 tree.

Will
