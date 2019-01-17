Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6AAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238882054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547718012;
	bh=zfjAB8ZKFbMVSRlr4GRG4WdpPCwHLoCY2w4KKtnhVG0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eVSunRKBnECeASmQ8BBQIjR6xRUK5DkXyy4kQ92sj9QURkatQ618sVR2eL9F4LpZB
	 koBSigzWDYy6nf/GlLUWE2bdaL52h0NLQR5MRIuVZzOfqLsjK5O07DBZe/h28BTo7E
	 /kqJeDG/5WIC92jpQ52FLym0C/bcYWGgNvVe6RFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfAQJkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:40:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42088 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfAQJkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:40:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id v23so10519674otk.9;
        Thu, 17 Jan 2019 01:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFKSzFsfMt9ff9QVI8w6EY+shCSKMvCQypFeZi0ZZew=;
        b=nSen9A0JuTTV+vzcunTjw5WCRV1JqP7h9eU01jDGTRkbizlCUTTBk77ZTh58TUgkot
         d+5yCSw4AlOJChL5d0dqCoQrHkJFL8116P2YiPX7NIB+b6ZqPrfuYO+36zOfop98evVb
         Kb1eP0AW9xoTxHErF1CpAtwx0fU4CrbuqOzhrVxWd9gzugZ4x1r7X1EJz32KFWS25l2Q
         RAS12wFLft2ry1LVkhs/Dg6vAANF3R86h4UiO52xYeaIvbYhHRMTnSUsCxKQFivU0BPp
         IIsps5Ui8YAy6GFqA/ZQ1OIH13zW0m/1hddckZIfwK0sPZGzrewNUgAUoE0ejU/Sc+RF
         UCkQ==
X-Gm-Message-State: AJcUukcJ7UQwqxHptY/w4glzcgZilhaqKMiWLXeKLGOgkEUkJFZCvxki
        LDsOGQHuP7QNgTahc7pLv+inBc6n5Cok22st8hA=
X-Google-Smtp-Source: ALg8bN6hlONZGyC7dzX71T9iVB+gxDz1z/hI4ufEzi70l/lSSGxP9IZKbSqsyvf+P75kvAkaso72d9tz56HSlQdWIGA=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr7838799otq.119.1547718008394;
 Thu, 17 Jan 2019 01:40:08 -0800 (PST)
MIME-Version: 1.0
References: <20190115095834.22617-1-kasong@redhat.com> <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic> <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic> <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190117085316.GA17940@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190117085316.GA17940@dhcp-128-65.nay.redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 10:39:57 +0100
Message-ID: <CAJZ5v0hb6Lz0knzNFTZKNb863bvDx2a1EFjTjOG2NdvyyyhniQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
To:     Dave Young <dyoung@redhat.com>
Cc:     Kairui Song <kasong@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 9:53 AM Dave Young <dyoung@redhat.com> wrote:
>
> Add linux-acpi list

Well, thanks, but please resend the patches with a CC to linux-acpi.

> On 01/17/19 at 03:41pm, Kairui Song wrote:
> > On Wed, Jan 16, 2019 at 5:46 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Wed, Jan 16, 2019 at 03:08:42PM +0800, Kairui Song wrote:
> > > > I didn't see a way to reuse things in that patch series, situation is
> > > > different, in that patch it needs to get RSDP in very early boot stage
> > > > so it did everything from scratch, in this patch kexec_file_load need
> > > > to get RSDP too, but everything is well setup so things are a lot
> > > > easier, just read from current boot_prams, efi and fallback to
> > > > acpi_find_root_pointer should be good.
> > >
> > > No no. Early code should find out that venerable RSDP thing once and
> > > will save it somewhere for further use. No gazillion parsings of it.
> > > Just once and share it with the rest of the code that needs it.
> > >
> >
> > How about we refill the boot_params.acpi_rsdp_addr if it is not valid
> > in early code, so it could be used as a reliable RSDP address source?
> > That should make things easier.
> >
> > But if early code should parse it and store it should be done in
> > Chao's patch, or I can post another patch to do it if Chao's patch is
> > merged.
> >
> > For now I think good to have something like this in this patch series
> > to always keep storing acpi_rsdp in late code,
> > acpi_os_get_root_pointer_late (maybe comeup with a better name later)
> > could be used anytime to get RSDP and no extra parsing:
> >
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -180,8 +180,8 @@ void acpi_os_vprintf(const char *fmt, va_list args)
> >  #endif
> >  }
> >
> > -#ifdef CONFIG_KEXEC
> >  static unsigned long acpi_rsdp;
> > +#ifdef CONFIG_KEXEC
> >  static int __init setup_acpi_rsdp(char *arg)
> >  {
> >         return kstrtoul(arg, 16, &acpi_rsdp);
> > @@ -189,28 +189,38 @@ static int __init setup_acpi_rsdp(char *arg)
> >  early_param("acpi_rsdp", setup_acpi_rsdp);
> >  #endif
> >
> > +acpi_physical_address acpi_os_get_root_pointer_late(void) {
> > +       return acpi_rsdp;
> > +}
> > +
> >  acpi_physical_address __init acpi_os_get_root_pointer(void)
> >  {
> >         acpi_physical_address pa;
> >
> > -#ifdef CONFIG_KEXEC
> >         if (acpi_rsdp)
> >                 return acpi_rsdp;
> > -#endif
> > +
> >         pa = acpi_arch_get_root_pointer();
> > -       if (pa)
> > +       if (pa) {
> > +               acpi_rsdp = pa;
> >                 return pa;
> > +       }
> >
> >         if (efi_enabled(EFI_CONFIG_TABLES)) {
> > -               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> > +               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR) {
> > +                       acpi_rsdp = efi.acpi20;
> >                         return efi.acpi20;
> > -               if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> > +               }
> > +               if (efi.acpi != EFI_INVALID_TABLE_ADDR) {
> > +                       acpi_rsdp = efi.acpi;
> >                         return efi.acpi;
> > +               }
> >                 pr_err(PREFIX "System description tables not found\n");
> >         } else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
> >                 acpi_find_root_pointer(&pa);
> >         }
> >
> >  +       acpi_rsdp = pa;
> >         return pa;
> >  }
> >
> > > --
> > > Regards/Gruss,
> > >     Boris.
> > >
> > > Good mailing practices for 400: avoid top-posting and trim the reply.
> > --
> > Best Regards,
> > Kairui Song
