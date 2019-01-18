Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7FAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103682086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfARErm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:47:42 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46274 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfARErm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:47:42 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so9690093ios.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 20:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjjsWmZ/uAomuo3rrysqPjhFJYm6rOP6Ng4Q0adkvJI=;
        b=XCTioBa/3NgS7CV9dlQN3M53qQYfaxf73VKbXM+L5w5T/kAVt4q0OPBZlev8yEtHLc
         /BzyPYorYNPEUa/tQKqlQQ95hr5DGPUEmvcdD8XlA5jfTn5NWumMkHZrnCHmaewUg6QE
         BzWoY01hj8ZhBVcJYU0S5qKwvA7au+L9fTUFBm65fVm9NeT02R90TttUotGKpytHRSpB
         SBBLk7sJjVJ8GbcqEIK3ow4JAAatJ7spbU0mzpylKQOKjiF0TGWr4lVktN8LK9Xo+uAG
         QsxfBP1cGsOgglNEV7CnZdF+PtMqYbebYn9XhwSo1Ra8oQaH6TphIE0KF8YeptomshCG
         /eXw==
X-Gm-Message-State: AJcUukemvLv3wMN9BYGtIYOYfhfik30NtaGVtGKjhCPRGZLR1RSoxLKo
        mmozfRg+i4t9aX/8wi3ECUKX329ObRBVISecz+JisA==
X-Google-Smtp-Source: ALg8bN7B2XJgtFsnKs3LyfHXtFShemxpWWbdgAq9lnc1Dz6C+m3k67xyKGodXhpzR478mqTcG+cjvpXTqHN9V3pXumM=
X-Received: by 2002:a6b:b502:: with SMTP id e2mr8673324iof.43.1547786860537;
 Thu, 17 Jan 2019 20:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20190115095834.22617-1-kasong@redhat.com> <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic> <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic> <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190117085316.GA17940@dhcp-128-65.nay.redhat.com> <CAJZ5v0hb6Lz0knzNFTZKNb863bvDx2a1EFjTjOG2NdvyyyhniQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hb6Lz0knzNFTZKNb863bvDx2a1EFjTjOG2NdvyyyhniQ@mail.gmail.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 18 Jan 2019 12:47:29 +0800
Message-ID: <CACPcB9eomuBPmxCEWEutt1gxO3=nrFFuYtKeANd0+h8DsN7M3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dave Young <dyoung@redhat.com>, Borislav Petkov <bp@alien8.de>,
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

On Thu, Jan 17, 2019 at 5:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 17, 2019 at 9:53 AM Dave Young <dyoung@redhat.com> wrote:
> >
> > Add linux-acpi list
>
> Well, thanks, but please resend the patches with a CC to linux-acpi.
>

Hi, sure will do.
Any thought on adding an acpi_os_get_root_pointer_late and store rsdp
pointer as mentioned? Will updat the patch and post V2, and cc
linux-acpi as well later.

> > On 01/17/19 at 03:41pm, Kairui Song wrote:
> > > On Wed, Jan 16, 2019 at 5:46 PM Borislav Petkov <bp@alien8.de> wrote:
> > > >
> > > > On Wed, Jan 16, 2019 at 03:08:42PM +0800, Kairui Song wrote:
> > > > > I didn't see a way to reuse things in that patch series, situation is
> > > > > different, in that patch it needs to get RSDP in very early boot stage
> > > > > so it did everything from scratch, in this patch kexec_file_load need
> > > > > to get RSDP too, but everything is well setup so things are a lot
> > > > > easier, just read from current boot_prams, efi and fallback to
> > > > > acpi_find_root_pointer should be good.
> > > >
> > > > No no. Early code should find out that venerable RSDP thing once and
> > > > will save it somewhere for further use. No gazillion parsings of it.
> > > > Just once and share it with the rest of the code that needs it.
> > > >
> > >
> > > How about we refill the boot_params.acpi_rsdp_addr if it is not valid
> > > in early code, so it could be used as a reliable RSDP address source?
> > > That should make things easier.
> > >
> > > But if early code should parse it and store it should be done in
> > > Chao's patch, or I can post another patch to do it if Chao's patch is
> > > merged.
> > >
> > > For now I think good to have something like this in this patch series
> > > to always keep storing acpi_rsdp in late code,
> > > acpi_os_get_root_pointer_late (maybe comeup with a better name later)
> > > could be used anytime to get RSDP and no extra parsing:
> > >
> > > --- a/drivers/acpi/osl.c
> > > +++ b/drivers/acpi/osl.c
> > > @@ -180,8 +180,8 @@ void acpi_os_vprintf(const char *fmt, va_list args)
> > >  #endif
> > >  }
> > >
> > > -#ifdef CONFIG_KEXEC
> > >  static unsigned long acpi_rsdp;
> > > +#ifdef CONFIG_KEXEC
> > >  static int __init setup_acpi_rsdp(char *arg)
> > >  {
> > >         return kstrtoul(arg, 16, &acpi_rsdp);
> > > @@ -189,28 +189,38 @@ static int __init setup_acpi_rsdp(char *arg)
> > >  early_param("acpi_rsdp", setup_acpi_rsdp);
> > >  #endif
> > >
> > > +acpi_physical_address acpi_os_get_root_pointer_late(void) {
> > > +       return acpi_rsdp;
> > > +}
> > > +
> > >  acpi_physical_address __init acpi_os_get_root_pointer(void)
> > >  {
> > >         acpi_physical_address pa;
> > >
> > > -#ifdef CONFIG_KEXEC
> > >         if (acpi_rsdp)
> > >                 return acpi_rsdp;
> > > -#endif
> > > +
> > >         pa = acpi_arch_get_root_pointer();
> > > -       if (pa)
> > > +       if (pa) {
> > > +               acpi_rsdp = pa;
> > >                 return pa;
> > > +       }
> > >
> > >         if (efi_enabled(EFI_CONFIG_TABLES)) {
> > > -               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> > > +               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR) {
> > > +                       acpi_rsdp = efi.acpi20;
> > >                         return efi.acpi20;
> > > -               if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> > > +               }
> > > +               if (efi.acpi != EFI_INVALID_TABLE_ADDR) {
> > > +                       acpi_rsdp = efi.acpi;
> > >                         return efi.acpi;
> > > +               }
> > >                 pr_err(PREFIX "System description tables not found\n");
> > >         } else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
> > >                 acpi_find_root_pointer(&pa);
> > >         }
> > >
> > >  +       acpi_rsdp = pa;
> > >         return pa;
> > >  }
> > >
> > > > --
> > > > Regards/Gruss,
> > > >     Boris.
> > > >
> > > > Good mailing practices for 400: avoid top-posting and trim the reply.
> > > --
> > > Best Regards,
> > > Kairui Song



-- 
Best Regards,
Kairui Song
