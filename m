Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1640FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC582082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbfAPHIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:08:55 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46544 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731056AbfAPHIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:08:55 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so4082318ios.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 23:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTXUgGZ7r+hTPCWbFqNb6Tqjl4dZDQq8XRLvzxl4HDs=;
        b=dOtADzDggdNqNnhGAhH4Tziqf7jRDsyFg57b38a8Jg7kY2dTmBdfVVhPBz98lHH61h
         NuTqG+7frv9kinCZNAvS3A9ltAeAQBNMpa0W/tmYeLpSBs9zWYAOswDT//RXP9K1JMsE
         K6PJVBdD7HmHw6OFoQ5Iqgm2+QdYpswItq+GLkk0GSoyDnMQ2jluUl5O7aJQy6aYm5+M
         1K4fQN+BMd25MAaNCPfDCbzt1IkdIaxcaqP516qeCARLWH78FqFnsXykG4CObZbXIENa
         inpDLyq8qlEyeS1hHX01DFTZcd5y86qSzkAckThENEIYaHMX2jDCh5f5p/YPwhwXukxH
         a7nQ==
X-Gm-Message-State: AJcUukcLMhhOYY8mv6xtBLCsm4rwB8h18WCLflKu3iwzoym5iolEZ0CH
        P2LjS0yVcUCTno+/la+N4lJGkDUgH75PMLaqi2cLzg==
X-Google-Smtp-Source: ALg8bN5X8xT/QteyZNcXgITYi/BsNlMxu+3vk8anhoDvusT2reuSzsjl0vz+XTj1IgCpG0KekPd2Lx96Ro12fvH85w4=
X-Received: by 2002:a5d:8889:: with SMTP id d9mr4393736ioo.68.1547622533911;
 Tue, 15 Jan 2019 23:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20190115095834.22617-1-kasong@redhat.com> <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
In-Reply-To: <20190115231005.GF6596@zn.tnic>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 16 Jan 2019 15:08:42 +0800
Message-ID: <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        akpm@linux-foundation.org, robert.moore@intel.com,
        erik.schmauss@intel.com, rafael.j.wysocki@intel.com,
        Len Brown <lenb@kernel.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 7:10 AM Borislav Petkov <bp@alien8.de> wrote:

> > +#ifdef CONFIG_ACPI
> > +     /* Setup ACPI RSDP pointer in case EFI is not available in second kernel */
> > +     if (!acpi_disabled && (!efi_enabled(EFI_RUNTIME_SERVICES) || efi_enabled(EFI_OLD_MEMMAP))) {
> > +             /* Copied from acpi_os_get_root_pointer accordingly */
> > +             params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
> > +             if (!params->acpi_rsdp_addr) {
> > +                     if (efi_enabled(EFI_CONFIG_TABLES)) {
> > +                             if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> > +                                     params->acpi_rsdp_addr = efi.acpi20;
> > +                             else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> > +                                     params->acpi_rsdp_addr = efi.acpi;
> > +                     } else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
> > +                             acpi_find_root_pointer(&params->acpi_rsdp_addr);
> > +                     }
> > +             }
> > +             if (!params->acpi_rsdp_addr)
> > +                     pr_warn("RSDP is not available for second kernel\n");
> > +     }
> >  #endif
>
> Amazing the amount of ACPI RDSP parsing and fiddling patches flying
> around these days...
>
> In any case, this needs to be synchronized with:
>
> https://lkml.kernel.org/r/20190107032243.25324-1-fanc.fnst@cn.fujitsu.com
>
> and checked whether the above can be used instead of sprinkling of ACPI
> parsing code left and right.
>
> Thx.

Hi thanks for the suggestion.

I didn't see a way to reuse things in that patch series, situation is
different, in that patch it needs to get RSDP in very early boot stage
so it did everything from scratch, in this patch kexec_file_load need
to get RSDP too, but everything is well setup so things are a lot
easier, just read from current boot_prams, efi and fallback to
acpi_find_root_pointer should be good.

And that patch series also need to consider boot_params.acpi_rsdp_addr
value, or it won't work if the system is rebooted with kexec, efi is
disabled and acpi_rsdp is provided by boot_params (Xen PVH guests also
need to get acpi_rsdp from boot_params according to commit message of
ae7e1238e68f2a472a125673ab506d49158c1889). Will add some comment and
discuss.

>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
--
Best Regards,
Kairui Song
