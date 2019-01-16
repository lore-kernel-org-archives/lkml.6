Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88125C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6015D20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388213AbfAPGvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:51:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388157AbfAPGvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:51:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64FFA58E46;
        Wed, 16 Jan 2019 06:51:36 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AACF55D961;
        Wed, 16 Jan 2019 06:51:30 +0000 (UTC)
Date:   Wed, 16 Jan 2019 14:51:26 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, akpm@linux-foundation.org,
        robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190116065126.GC6468@dhcp-128-65.nay.redhat.com>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <20190116033243.GB9649@dhcp-128-65.nay.redhat.com>
 <CACPcB9fWoV=b3DwhmBAAgqDHc0x=PfSyEuqnZcAQjM=LLLkAQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9fWoV=b3DwhmBAAgqDHc0x=PfSyEuqnZcAQjM=LLLkAQw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 16 Jan 2019 06:51:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16/19 at 01:09pm, Kairui Song wrote:
> On Wed, Jan 16, 2019 at 11:32 AM Dave Young <dyoung@redhat.com> wrote:
> >
> > On 01/16/19 at 12:10am, Borislav Petkov wrote:
> > > On Tue, Jan 15, 2019 at 05:58:34PM +0800, Kairui Song wrote:
> > > > When efi=noruntime or efi=oldmap is used, EFI services won't be available
> > > > in the second kernel, therefore the second kernel will not be able to get
> > > > the ACPI RSDP address from firmware by calling EFI services and won't
> > > > boot. Previously we are expecting the user to set the acpi_rsdp=<addr>
> > > > on kernel command line for second kernel as there was no way to pass RSDP
> > > > address to second kernel.
> > > >
> > > > After commit e6e094e053af ('x86/acpi, x86/boot: Take RSDP address from
> > > > boot params if available'), now it's possible to set an acpi_rsdp_addr
> > > > parameter in the boot_params passed to second kernel, this commit make
> > > > use of it, detect and set the RSDP address when it's required for second
> > > > kernel to boot.
> > > >
> > > > Tested with an EFI enabled KVM VM with efi=noruntime.
> > > >
> > > > Suggested-by: Dave Young <dyoung@redhat.com>
> > > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > > > ---
> > > >  arch/x86/kernel/kexec-bzimage64.c | 21 +++++++++++++++++++++
> > > >  drivers/acpi/acpica/tbxfroot.c    |  3 +--
> > > >  include/acpi/acpixf.h             |  2 +-
> > > >  3 files changed, 23 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > > > index 53917a3ebf94..0a90dcbd041f 100644
> > > > --- a/arch/x86/kernel/kexec-bzimage64.c
> > > > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > > > @@ -20,6 +20,7 @@
> > > >  #include <linux/mm.h>
> > > >  #include <linux/efi.h>
> > > >  #include <linux/verification.h>
> > > > +#include <linux/acpi.h>
> > > >
> > > >  #include <asm/bootparam.h>
> > > >  #include <asm/setup.h>
> > > > @@ -255,8 +256,28 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
> > > >     /* Setup EFI state */
> > > >     setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> > > >                     efi_setup_data_offset);
> > > > +
> > > > +#ifdef CONFIG_ACPI
> > > > +   /* Setup ACPI RSDP pointer in case EFI is not available in second kernel */
> > > > +   if (!acpi_disabled && (!efi_enabled(EFI_RUNTIME_SERVICES) || efi_enabled(EFI_OLD_MEMMAP))) {
> > > > +           /* Copied from acpi_os_get_root_pointer accordingly */
> > > > +           params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
> > > > +           if (!params->acpi_rsdp_addr) {
> > > > +                   if (efi_enabled(EFI_CONFIG_TABLES)) {
> > > > +                           if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> > > > +                                   params->acpi_rsdp_addr = efi.acpi20;
> > > > +                           else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> > > > +                                   params->acpi_rsdp_addr = efi.acpi;
> > > > +                   } else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
> > > > +                           acpi_find_root_pointer(&params->acpi_rsdp_addr);
> > > > +                   }
> > > > +           }
> > > > +           if (!params->acpi_rsdp_addr)
> > > > +                   pr_warn("RSDP is not available for second kernel\n");
> > > > +   }
> > > >  #endif
> > >
> > > Amazing the amount of ACPI RDSP parsing and fiddling patches flying
> > > around these days...
> > >
> > > In any case, this needs to be synchronized with:
> > >
> > > https://lkml.kernel.org/r/20190107032243.25324-1-fanc.fnst@cn.fujitsu.com
> > >
> > > and checked whether the above can be used instead of sprinkling of ACPI
> > > parsing code left and right.
> >
> > Both Baoquan and Chao are cced for comments.
> > The above KASLR patches seems some early code to parsing acpi, but I think in this
> > patch just call acpi function to get the root pointer no need to add the
> > duplicate logic of if/else/else if.
> >
> > Kairui,  do you have any reason for the checking?  Is there some simple
> > acpi function to just return the root pointer?
> 
> Hi, I'm afraid that would require moving multiple structure and
> function out of .init,
> acpi_os_get_root_pointer is an ideal function to do the job, but it's
> in .init and (on x86) it will call x86_init.acpi.get_root_pointer (by
> calling acpi_arch_get_root_pointer) which will also be freed after
> init, unless I change the x86_init, move they out of .init which is
> not a good idea.
> 
> Maybe I could split acpi_os_get_root_pointer into two, one gets freed
> after init, one for later use. But the "acpi_rsdp_addr" trick only
> works for x86, and this would change more common acpi driver code so
> not sure if a good idea.

Can the acpi root pointer be saved after initialized? If that is good
then a new function to get it would be easier. But need opinion from
acpi people.

Thanks
Dave
