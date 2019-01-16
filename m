Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728B5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F8720840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfAPFJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:09:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53676 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfAPFJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:09:51 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so1239560ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLwqZsLPctr46/6aQANoR969bgmeOBMpHoBdkgcDvhA=;
        b=lRPbch+m8Rl/5M3NN4hfsjpM3EM/2UFmgU1OGsg14FWLl/oBRR+TTRMyjB8QNzwio5
         N/xgQf+RDe7ukrtvxOlXVYjQytw9yonQ0tRm+LBv09O6ASFvOmp2w5rQFF0OMpGk8LWa
         SqlXxBf+X4Rhtr1YORRu6WQSBu2V5zxzeDR9afDCVoGej071s+7d5htg6Vgp7/7GuPJX
         YqXF/tIANuae6kjLPS12BMD/9hA3ucF7tJwzci0PB61Fig25kDwciDAvwVmPqArhBjKN
         W7thUjTfulH7unPimGe28nH8tkK+iTfjN9UKpz4sfMz+7xbQRsRAWoKm7NwrouAk8avP
         HmCw==
X-Gm-Message-State: AJcUukfXfU9RP8kAAvu1cv6i/HEWnScFq9z5qH98ebR0eq6YIS49N2FG
        lCB/gO+5QIkK3Nn20mKYwR9NoTxeQ820Ft2YNQNgDQ==
X-Google-Smtp-Source: ALg8bN562ARQZL7NPD7vkyggQae3X5MTDuP362sQLN0nU/tBOVyFufFFHakTHBQa5OJ3LfZjWTZ62rtPa8NcomnkAJQ=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr4551925itg.136.1547615389860;
 Tue, 15 Jan 2019 21:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20190115095834.22617-1-kasong@redhat.com> <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic> <20190116033243.GB9649@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190116033243.GB9649@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 16 Jan 2019 13:09:38 +0800
Message-ID: <CACPcB9fWoV=b3DwhmBAAgqDHc0x=PfSyEuqnZcAQjM=LLLkAQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
To:     Dave Young <dyoung@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, akpm@linux-foundation.org,
        robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:32 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 01/16/19 at 12:10am, Borislav Petkov wrote:
> > On Tue, Jan 15, 2019 at 05:58:34PM +0800, Kairui Song wrote:
> > > When efi=noruntime or efi=oldmap is used, EFI services won't be available
> > > in the second kernel, therefore the second kernel will not be able to get
> > > the ACPI RSDP address from firmware by calling EFI services and won't
> > > boot. Previously we are expecting the user to set the acpi_rsdp=<addr>
> > > on kernel command line for second kernel as there was no way to pass RSDP
> > > address to second kernel.
> > >
> > > After commit e6e094e053af ('x86/acpi, x86/boot: Take RSDP address from
> > > boot params if available'), now it's possible to set an acpi_rsdp_addr
> > > parameter in the boot_params passed to second kernel, this commit make
> > > use of it, detect and set the RSDP address when it's required for second
> > > kernel to boot.
> > >
> > > Tested with an EFI enabled KVM VM with efi=noruntime.
> > >
> > > Suggested-by: Dave Young <dyoung@redhat.com>
> > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > > ---
> > >  arch/x86/kernel/kexec-bzimage64.c | 21 +++++++++++++++++++++
> > >  drivers/acpi/acpica/tbxfroot.c    |  3 +--
> > >  include/acpi/acpixf.h             |  2 +-
> > >  3 files changed, 23 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > > index 53917a3ebf94..0a90dcbd041f 100644
> > > --- a/arch/x86/kernel/kexec-bzimage64.c
> > > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/mm.h>
> > >  #include <linux/efi.h>
> > >  #include <linux/verification.h>
> > > +#include <linux/acpi.h>
> > >
> > >  #include <asm/bootparam.h>
> > >  #include <asm/setup.h>
> > > @@ -255,8 +256,28 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
> > >     /* Setup EFI state */
> > >     setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> > >                     efi_setup_data_offset);
> > > +
> > > +#ifdef CONFIG_ACPI
> > > +   /* Setup ACPI RSDP pointer in case EFI is not available in second kernel */
> > > +   if (!acpi_disabled && (!efi_enabled(EFI_RUNTIME_SERVICES) || efi_enabled(EFI_OLD_MEMMAP))) {
> > > +           /* Copied from acpi_os_get_root_pointer accordingly */
> > > +           params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
> > > +           if (!params->acpi_rsdp_addr) {
> > > +                   if (efi_enabled(EFI_CONFIG_TABLES)) {
> > > +                           if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> > > +                                   params->acpi_rsdp_addr = efi.acpi20;
> > > +                           else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> > > +                                   params->acpi_rsdp_addr = efi.acpi;
> > > +                   } else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
> > > +                           acpi_find_root_pointer(&params->acpi_rsdp_addr);
> > > +                   }
> > > +           }
> > > +           if (!params->acpi_rsdp_addr)
> > > +                   pr_warn("RSDP is not available for second kernel\n");
> > > +   }
> > >  #endif
> >
> > Amazing the amount of ACPI RDSP parsing and fiddling patches flying
> > around these days...
> >
> > In any case, this needs to be synchronized with:
> >
> > https://lkml.kernel.org/r/20190107032243.25324-1-fanc.fnst@cn.fujitsu.com
> >
> > and checked whether the above can be used instead of sprinkling of ACPI
> > parsing code left and right.
>
> Both Baoquan and Chao are cced for comments.
> The above KASLR patches seems some early code to parsing acpi, but I think in this
> patch just call acpi function to get the root pointer no need to add the
> duplicate logic of if/else/else if.
>
> Kairui,  do you have any reason for the checking?  Is there some simple
> acpi function to just return the root pointer?

Hi, I'm afraid that would require moving multiple structure and
function out of .init,
acpi_os_get_root_pointer is an ideal function to do the job, but it's
in .init and (on x86) it will call x86_init.acpi.get_root_pointer (by
calling acpi_arch_get_root_pointer) which will also be freed after
init, unless I change the x86_init, move they out of .init which is
not a good idea.

Maybe I could split acpi_os_get_root_pointer into two, one gets freed
after init, one for later use. But the "acpi_rsdp_addr" trick only
works for x86, and this would change more common acpi driver code so
not sure if a good idea.


>
> >
> > Thx.
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > Good mailing practices for 400: avoid top-posting and trim the reply.
>
> Thanks
> Dave



--
Best Regards,
Kairui Song
