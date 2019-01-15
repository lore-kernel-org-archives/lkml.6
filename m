Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9593C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A47320656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfAOImX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:42:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfAOImX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:42:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 878F4A459D;
        Tue, 15 Jan 2019 08:42:22 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67077608E8;
        Tue, 15 Jan 2019 08:42:17 +0000 (UTC)
Date:   Tue, 15 Jan 2019 16:42:13 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        akpm@linux-foundation.org, robert.moore@intel.com,
        erik.schmauss@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org
Subject: Re: [PATCH 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=oldmap
Message-ID: <20190115084213.GA6468@dhcp-128-65.nay.redhat.com>
References: <20190109064727.27936-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109064727.27936-1-kasong@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 15 Jan 2019 08:42:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/19 at 02:47pm, Kairui Song wrote:
> When efi=noruntime or efi=oldmap is used, EFI services won't be available
> in the second kernel, therefore the second kernel will not be able to get
> the ACPI RSDP address from firmware by calling EFI services and won't
> boot. Previously we are expecting the user to set the acpi_rsdp=<addr>
> on kernel command line for second kernel as there was no way to pass RSDP
> address to second kernel.
> 
> After commit e6e094e053af ('x86/acpi, x86/boot: Take RSDP address from
> boot params if available'), now it's possible to set a acpi_rsdp_addr
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
>  
> +#endif
>  	/* Setup EDD info */
>  	memcpy(params->eddbuf, boot_params.eddbuf,
>  				EDDMAXNR * sizeof(struct edd_info));
> diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
> index 483d0ce5180a..dac1e34a931c 100644
> --- a/drivers/acpi/acpica/tbxfroot.c
> +++ b/drivers/acpi/acpica/tbxfroot.c
> @@ -108,8 +108,7 @@ acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
>   *
>   ******************************************************************************/
>  
> -acpi_status ACPI_INIT_FUNCTION
> -acpi_find_root_pointer(acpi_physical_address *table_address)
> +acpi_status acpi_find_root_pointer(acpi_physical_address *table_address)
>  {
>  	u8 *table_ptr;
>  	u8 *mem_rover;
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 7aa38b648564..869d75ecaf7d 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -474,7 +474,7 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
>  			    acpi_reallocate_root_table(void))
>  
> -ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
> +ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>  			    acpi_find_root_pointer(acpi_physical_address
>  						   *rsdp_address))
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> -- 
> 2.20.1
> 

Kairui, thanks for the patches, did a test, it works for me.

Seems the two patches are not in a thread, can you resend them together?

Dave
