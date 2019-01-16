Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECB2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E738020675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfAPVjm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:39:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:14867 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfAPVjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:39:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 13:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="312414165"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jan 2019 13:39:41 -0800
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.231]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.140]) with mapi id 14.03.0415.000;
 Wed, 16 Jan 2019 13:39:40 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Dave Young <dyoung@redhat.com>, Kairui Song <kasong@redhat.com>,
        "Jung-uk Kim" <jkim@FreeBSD.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: RE: [PATCH 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=oldmap
Thread-Topic: [PATCH 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=oldmap
Thread-Index: AQHUp+dE1OicAZFzAU6ZcBmUe3zX7KWwkrmAgAHlHtA=
Date:   Wed, 16 Jan 2019 21:39:40 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C560C62@ORSMSX122.amr.corp.intel.com>
References: <20190109064727.27936-1-kasong@redhat.com>
 <20190115084213.GA6468@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190115084213.GA6468@dhcp-128-65.nay.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dave Young [mailto:dyoung@redhat.com]
> Sent: Tuesday, January 15, 2019 12:42 AM
> To: Kairui Song <kasong@redhat.com>
> Cc: linux-kernel@vger.kernel.org; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de; hpa@zytor.com; x86@kernel.org;
> akpm@linux-foundation.org; Moore, Robert
> <robert.moore@intel.com>; Schmauss, Erik
> <erik.schmauss@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; lenb@kernel.org
> Subject: Re: [PATCH 2/2] x86, kexec_file_load: make it work with
> efi=noruntime or efi=oldmap
> 
> On 01/09/19 at 02:47pm, Kairui Song wrote:
> > When efi=noruntime or efi=oldmap is used, EFI services won't be
> > available in the second kernel, therefore the second kernel will not
> > be able to get the ACPI RSDP address from firmware by calling EFI
> > services and won't boot. Previously we are expecting the user to set
> > the acpi_rsdp=<addr> on kernel command line for second kernel as
> there
> > was no way to pass RSDP address to second kernel.
> >
> > After commit e6e094e053af ('x86/acpi, x86/boot: Take RSDP address
> from
> > boot params if available'), now it's possible to set a acpi_rsdp_addr
> > parameter in the boot_params passed to second kernel, this commit
> make
> > use of it, detect and set the RSDP address when it's required for
> > second kernel to boot.
> >
> > Tested with an EFI enabled KVM VM with efi=noruntime.
> >
> > Suggested-by: Dave Young <dyoung@redhat.com>
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >  arch/x86/kernel/kexec-bzimage64.c | 21 +++++++++++++++++++++
> >  drivers/acpi/acpica/tbxfroot.c    |  3 +--
> >  include/acpi/acpixf.h             |  2 +-
> >  3 files changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c
> > b/arch/x86/kernel/kexec-bzimage64.c
> > index 53917a3ebf94..0a90dcbd041f 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/efi.h>
> >  #include <linux/verification.h>
> > +#include <linux/acpi.h>
> >
> >  #include <asm/bootparam.h>
> >  #include <asm/setup.h>
> > @@ -255,8 +256,28 @@ setup_boot_parameters(struct kimage
> *image, struct boot_params *params,
> >  	/* Setup EFI state */
> >  	setup_efi_state(params, params_load_addr, efi_map_offset,
> efi_map_sz,
> >  			efi_setup_data_offset);
> > +
> > +#ifdef CONFIG_ACPI
> > +	/* Setup ACPI RSDP pointer in case EFI is not available in
> second kernel */
> > +	if (!acpi_disabled && (!efi_enabled(EFI_RUNTIME_SERVICES)
> || efi_enabled(EFI_OLD_MEMMAP))) {
> > +		/* Copied from acpi_os_get_root_pointer accordingly
> */
> > +		params->acpi_rsdp_addr =
> boot_params.acpi_rsdp_addr;
> > +		if (!params->acpi_rsdp_addr) {
> > +			if (efi_enabled(EFI_CONFIG_TABLES)) {
> > +				if (efi.acpi20 !=
> EFI_INVALID_TABLE_ADDR)
> > +					params->acpi_rsdp_addr =
> efi.acpi20;
> > +				else if (efi.acpi !=
> EFI_INVALID_TABLE_ADDR)
> > +					params->acpi_rsdp_addr =
> efi.acpi;
> > +			} else if
> (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
> > +				acpi_find_root_pointer(&params-
> >acpi_rsdp_addr);
> > +			}
> > +		}
> > +		if (!params->acpi_rsdp_addr)
> > +			pr_warn("RSDP is not available for second
> kernel\n");
> > +	}
> >  #endif
> >
> > +#endif
> >  	/* Setup EDD info */
> >  	memcpy(params->eddbuf, boot_params.eddbuf,
> >  				EDDMAXNR * sizeof(struct edd_info));
> diff --git
> > a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
> > index 483d0ce5180a..dac1e34a931c 100644
> > --- a/drivers/acpi/acpica/tbxfroot.c
> > +++ b/drivers/acpi/acpica/tbxfroot.c
> > @@ -108,8 +108,7 @@ acpi_status acpi_tb_validate_rsdp(struct
> acpi_table_rsdp *rsdp)
> >   *
> >
> >
> ******************************************************
> ****************
> > ********/
> >
> > -acpi_status ACPI_INIT_FUNCTION
> > -acpi_find_root_pointer(acpi_physical_address *table_address)
> > +acpi_status acpi_find_root_pointer(acpi_physical_address
> > +*table_address)
> >  {
> >  	u8 *table_ptr;
> >  	u8 *mem_rover;
> > diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index
> > 7aa38b648564..869d75ecaf7d 100644
> > --- a/include/acpi/acpixf.h
> > +++ b/include/acpi/acpixf.h
> > @@ -474,7 +474,7 @@
> ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> > ACPI_INIT_FUNCTION
> ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
> >  			    acpi_reallocate_root_table(void))
> >
> > -ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> ACPI_INIT_FUNCTION
> > +ACPI_EXTERNAL_RETURN_STATUS(acpi_status

@JK

Do you see any issues with this? Does free BSD use ACPI_INIT_FUNCTION?

> >
> acpi_find_root_pointer(acpi_physical_address
> >  						   *rsdp_address))
> >  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> > --
> > 2.20.1
> >
> 
> Kairui, thanks for the patches, did a test, it works for me.
> 
> Seems the two patches are not in a thread, can you resend them
> together?
> 
> Dave
