Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A7820657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfAQIWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:22:17 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44998 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfAQIWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:22:16 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so7089780iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLWjjkvfZ2q7dJeJa7FFeyE0qFQHMgdBhXZc8cSFzTc=;
        b=rt+yj29lDuFN7vHqSu+IQaJR+QjkiUQpsYkJjCGDzZG4zkev0SrSUzr99hj3hJ3Ur6
         wRFVKeluwghy+Qt8y6FQafMD4AZMXOiey4GxjR3xuVlIYxANprjW8924CbRsC4qLHy9X
         BT0w/vynv1nThURp3CcXj+wdVRnhtzAREbpJSxmpdvWVYT2IEb+jHrCNxYD1Dl7cTxGk
         zyi/+bZir9oGLt+tKA0Y0gWcu1ovAtdym8V+iqV8RDc8wuhBEdwM4HhzD+DzSWSP/df/
         8XQL58dtCQlzi2a+yb7NLtuPzS8XH/NrUnLaxypteiDxvi+0mFQl3spao0Gdih8o7QlU
         AfYg==
X-Gm-Message-State: AJcUukehbofb1AFizBMq+3UdTRyWvkFKjVlrU6YeatLk+tzBy0IHKUah
        3EZuS6e/AKYgqrjUGpkzh2vY5tp1yGjo1lfMIGaQyQ==
X-Google-Smtp-Source: ALg8bN74gcVf+NhQqOelKDj/7vEG48rSGbBbbmCOZlcv7VzF8DRstWEoL8tl87JmS1hjKQFoYVC6Rd28ZqCPbkx4WJc=
X-Received: by 2002:a6b:b502:: with SMTP id e2mr6512108iof.43.1547713336226;
 Thu, 17 Jan 2019 00:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com> <CACPcB9dO8FxpqSeG2whJGpUT7TiuiSJFWNWcF_fkRQwdRHwVcA@mail.gmail.com>
 <20190117062451.GA588@localhost.localdomain> <20190117075729.GC31097@localhost.localdomain>
In-Reply-To: <20190117075729.GC31097@localhost.localdomain>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 17 Jan 2019 16:22:05 +0800
Message-ID: <CACPcB9c=gPE3CtMFw8kZXnWPDUoRDedKcLjcPDykLNbFoZH5GQ@mail.gmail.com>
Subject: Re: [PATCH v15 5/6] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, Kees Cook <keescook@chromium.org>,
        Baoquan He <bhe@redhat.com>, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        jgross@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 3:58 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Wed, Jan 16, 2019 at 03:28:52PM +0800, Kairui Song wrote:
> >On Mon, Jan 7, 2019 at 11:24 AM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> >>
> >> +
> >> +/* Determine RSDP, based on acpi_os_get_root_pointer(). */
> >> +static acpi_physical_address get_rsdp_addr(void)
> >> +{
> >> +       acpi_physical_address pa;
> >> +
> >> +       pa = get_acpi_rsdp();
> >> +
> >> +       if (!pa)
> >> +               pa = efi_get_rsdp_addr();
> >> +
> >> +       if (!pa)
> >> +               pa = bios_get_rsdp_addr();
> >> +
> >> +       return pa;
> >> +}
> >
> >acpi_rsdp might be provided by boot_params.acpi_rsdp_addr too,
> >it's introduced in ae7e1238e68f2a for Xen PVH guest and later move to
> >boot_params in e6e094e053af,
> >kexec could use it to pass RSDP to second kernel as well. Please check
> >it as well make sure it always works.
> >
>
> Hi Kairui,
>
> I saw the parsing code has been added to kernel, but I didn't see
> where to fill in the 'acpi_rsdp_addr'. If only you(KEXEC) use it,
> I can add "#ifdef CONFIG_KEXEC", but you said Xen will use it also,
> so I didn't add ifdef to control it. I was trying to do as below:
>
> static inline acpi_physical_address get_boot_params_rsdp(void)
> {
>         return boot_params->acpi_rsdp_addr;
> }
>
> static acpi_physical_address get_rsdp_addr(void)
> {
>         bool boot_params_rsdp_exist;
>         acpi_physical_address pa;
>
>         pa = get_acpi_rsdp();
>
>         if (!pa)
>                 pa = get_boot_params_rsdp();
>
>         if (!pa) {
>                 pa = efi_get_rsdp_addr();
>                 boot_params_rsdp_exist = false;
>         }
>         else
>                 boot_params_rsdp_exist = true;
>
>         if (!pa)
>                 pa = bios_get_rsdp_addr();
>
>         if (pa && !boot_params_rsdp_exist)
>                 boot_params.acpi_rsdp_addr = pa;
>
>         return pa;
> }
>
> At the same time, I notice kernel only parses it when
> "#ifdef CONFIG_ACPI", we should keep sync with kernel, but I think
> we are parsing SRAT, CONFIG_ACPI is needed sure, so I am going to
> update the define of EARLY_SRAT_PARSE:
>
> config EARLY_SRAT_PARSE
>         bool "EARLY SRAT parsing"
>         def_bool y
>         depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE && ACPI
>
> Boris, how do you think the update for the new acpi_rsdp_addr?
> If I misunderstand something, please let me know.
>
> Thanks,
> Chao Fan
>

Hi, thanks for considering kexec usage,

but I think "boot_params_rsdp_exist" is not necessary,
boot_params->acpi_rsdp_addr should be either NULL or a valid value if
I, later initialization code considers it a valid value if it's not
NULL.

For the usage for Xen I'm not sure either, the info comes from commit
message of ae7e1238e68f2a that's also where boot_params.acpi_rsdp_addr
is first introduced, lets cc Juergen as well.


--
Best Regards,
Kairui Song
