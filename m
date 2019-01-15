Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163CCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D372A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EqTHHWjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403769AbfAOXKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:10:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40386 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbfAOXKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:10:20 -0500
Received: from zn.tnic (p200300EC2BCBB400BDE8DF251329FBA0.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b400:bde8:df25:1329:fba0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E72D1EC078A;
        Wed, 16 Jan 2019 00:10:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547593819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=k1koKEKrTYjaI/KXHMa/+DVMU50seZGxyRktv/1YJ1w=;
        b=EqTHHWjbvFPs7N80hJ4TCK8AEEtKM5cLyq7V8b+7JGragmDQaLj4HZ77S65KWeKwsgXYHU
        rhYiYm3In7HLuvqFeLulbmuKwO8FHPpcEcBJYeUzIJKjtiWxhz56/yEVFkMyLgs3hxrkBn
        Nw86O+ufNtEdKcKiSBJlUXsdC9zON0Q=
Date:   Wed, 16 Jan 2019 00:10:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, dyoung@redhat.com, bhe@redhat.com,
        kexec@lists.infradead.org, akpm@linux-foundation.org,
        robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190115231005.GF6596@zn.tnic>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115095834.22617-3-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 05:58:34PM +0800, Kairui Song wrote:
> When efi=noruntime or efi=oldmap is used, EFI services won't be available
> in the second kernel, therefore the second kernel will not be able to get
> the ACPI RSDP address from firmware by calling EFI services and won't
> boot. Previously we are expecting the user to set the acpi_rsdp=<addr>
> on kernel command line for second kernel as there was no way to pass RSDP
> address to second kernel.
> 
> After commit e6e094e053af ('x86/acpi, x86/boot: Take RSDP address from
> boot params if available'), now it's possible to set an acpi_rsdp_addr
> parameter in the boot_params passed to second kernel, this commit make
> use of it, detect and set the RSDP address when it's required for second
> kernel to boot.
> 
> Tested with an EFI enabled KVM VM with efi=noruntime.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 21 +++++++++++++++++++++
>  drivers/acpi/acpica/tbxfroot.c    |  3 +--
>  include/acpi/acpixf.h             |  2 +-
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 53917a3ebf94..0a90dcbd041f 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -20,6 +20,7 @@
>  #include <linux/mm.h>
>  #include <linux/efi.h>
>  #include <linux/verification.h>
> +#include <linux/acpi.h>
>  
>  #include <asm/bootparam.h>
>  #include <asm/setup.h>
> @@ -255,8 +256,28 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  	/* Setup EFI state */
>  	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
>  			efi_setup_data_offset);
> +
> +#ifdef CONFIG_ACPI
> +	/* Setup ACPI RSDP pointer in case EFI is not available in second kernel */
> +	if (!acpi_disabled && (!efi_enabled(EFI_RUNTIME_SERVICES) || efi_enabled(EFI_OLD_MEMMAP))) {
> +		/* Copied from acpi_os_get_root_pointer accordingly */
> +		params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
> +		if (!params->acpi_rsdp_addr) {
> +			if (efi_enabled(EFI_CONFIG_TABLES)) {
> +				if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> +					params->acpi_rsdp_addr = efi.acpi20;
> +				else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> +					params->acpi_rsdp_addr = efi.acpi;
> +			} else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
> +				acpi_find_root_pointer(&params->acpi_rsdp_addr);
> +			}
> +		}
> +		if (!params->acpi_rsdp_addr)
> +			pr_warn("RSDP is not available for second kernel\n");
> +	}
>  #endif

Amazing the amount of ACPI RDSP parsing and fiddling patches flying
around these days...

In any case, this needs to be synchronized with:

https://lkml.kernel.org/r/20190107032243.25324-1-fanc.fnst@cn.fujitsu.com

and checked whether the above can be used instead of sprinkling of ACPI
parsing code left and right.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
