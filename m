Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B821FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849C321983
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NuON10re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbeLVQvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:51:09 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50374 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbeLVQvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:51:09 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so11302158iti.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nC66WFBt2UA/oQmVErlW1SJnvVObcYp24ZyY6ukSH9o=;
        b=NuON10re+9DbPQheYmgLRGo6CLC1oGuEAZTxovj4V8CSWAOLZqKRLTIM5bVWl2MYrL
         HI9HOKmjzC0LRjjoGQfYjavXHRUr+620BYiFjd/w7wH5yLB8lhoLmIgdxhcf5M2hAEOv
         21yjwcjpEFg5KqMGZyfHYNmRjHooi3URwCdZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nC66WFBt2UA/oQmVErlW1SJnvVObcYp24ZyY6ukSH9o=;
        b=GV9RsMVyXsxEiv8gZPXA4S4XC54X5bx4NTPyxXE0ojy5F9k1rCtMF/bUIMsheRmzqh
         D76e/RTw6ayKYtJ9Lizlu5iuOjm5GEvuo93Not2VrjB8lajImhFcHA4RD4tFOmSxSu4g
         uto3NPZnMECUfyFLlyHFHKcpX/N4/apYx3ZDhZW0gZ8OBM06j1SYwqSrtZxq5pZPt97F
         RgS3J9RZYGlEQoYaeSrHh7BUbMmKWxazWUIYabp4hG0X8R1UC9+W4McbMIja/l3P3rAO
         sSHWB7+0fsOHUS2a6G3JZV7XOSXtOxgGJkiEaa27b9dfXfDAaRSDS1HoPidKhCbn+fe2
         G1lA==
X-Gm-Message-State: AA+aEWaATV/NUyULcnFmvg4tNLOirsvoVsz/858oVLbikaFiaiPpisaU
        yza1ZX7kkgcDCLd+AMlTZ7CMiF758IDnVURkT65ZEQ==
X-Google-Smtp-Source: AFSGD/Xvu34JKoPUrMlGXIe1NEmLUxO2UPlgJjSNY7gNZn2/omNG+kmkb/ZjkECFJkE1n5N6M/9svUOLbPvkosYo9sg=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr4701604ith.158.1545476699638;
 Sat, 22 Dec 2018 03:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20181222022234.7573-1-sai.praneeth.prakhya@intel.com> <20181222105410.GA130780@gmail.com>
In-Reply-To: <20181222105410.GA130780@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 22 Dec 2018 12:04:49 +0100
Message-ID: <CAKv+Gu93dgfXsq_sRzvXBw-h=8pn2BtrQLtpwtjK51potpOtdg@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Don't unmap EFI boot services code/data regions
 for EFI_OLD_MEMMAP and EFI_MIXED_MODE
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 at 11:54, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com> wrote:
>
> > Commit d5052a7130a6 ("x86/efi: Unmap EFI boot services code/data regions
> > from efi_pgd") forgets to take two EFI modes into consideration namely
> > EFI_OLD_MEMMAP and EFI_MIXED_MODE.
>
> So the commit sha1 ended up being this one in tip:efi/core:
>
>   08cfb38f3ef4: x86/efi: Unmap EFI boot services code/data regions from efi_pgd
>
> > EFI_OLD_MEMMAP is a legacy way of mapping EFI regions into swapper_pg_dir
> > using ioremap() and init_memory_mapping(). This feature can be enabled by
> > passing "efi=old_map" as kernel command line argument. But,
> > efi_unmap_pages() unmaps EFI boot services code/data regions *only* from
> > efi_pgd and hence cannot be used for unmapping EFI boot services code/data
> > regions from swapper_pg_dir.
> >
> > Introduce a temporary fix to not unmap EFI boot services code/data regions
> > when EFI_OLD_MEMMAP is enabled while working on a real fix.
> >
> > EFI_MIXED_MODE is another feature where a 64-bit kernel runs on a
> > 64-bit platform crippled by a 32-bit firmware. To support EFI_MIXED_MODE,
> > all RAM (i.e. namely EFI regions like EFI_CONVENTIONAL_MEMORY,
> > EFI_LOADER_<CODE/DATA>, EFI_BOOT_SERVICES_<CODE/DATA> and
> > EFI_RUNTIME_CODE/DATA regions) is mapped into efi_pgd all the time to
> > facilitate EFI runtime calls access it's arguments in 1:1 mode. Hence,
> > don't unmap EFI boot services code/data regions when booted in mixed mode.
> >
> > Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Bhupesh Sharma <bhsharma@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/x86/platform/efi/quirks.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> > index 09e811b9da26..9c34230aaeae 100644
> > --- a/arch/x86/platform/efi/quirks.c
> > +++ b/arch/x86/platform/efi/quirks.c
> > @@ -380,6 +380,22 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
> >       u64 pa = md->phys_addr;
> >       u64 va = md->virt_addr;
> >
> > +     /*
> > +      * To Do: Remove this check after adding functionality to unmap EFI boot
> > +      * services code/data regions from direct mapping area because
> > +      * "efi=old_map" maps EFI regions in swapper_pg_dir.
> > +      */
> > +     if (efi_enabled(EFI_OLD_MEMMAP))
> > +             return;
> > +
> > +     /*
> > +      * EFI mixed mode has all RAM mapped to access arguments while making
> > +      * EFI runtime calls, hence don't unmap EFI boot services code/data
> > +      * regions.
> > +      */
> > +     if (!efi_is_native() && IS_ENABLED(CONFIG_EFI_MIXED))

AFAIK efi_is_native() can only return false is CONFIG_EFI_MIXED is
set, so this expression can be simplified.

> > +             return;
>
> I suppose old_mmap and mixed mode stopped working altogether after the
> unmapping changes? What are the symptoms, instant reboots, crasher, or
> some more benign behavior like non-working runtime EFI functionality?
>
> If Ard acks this I'll apply it immediately, as these bugs look like
> show-stoppers for merging the EFI tree into v4.21.
>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

with the sidenote that I won't be able to test this myself until
monday at the earliest.
