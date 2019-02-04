Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F30C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283A7214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFQ5iom2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfBDH2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:28:12 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38772 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfBDH2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:28:11 -0500
Received: by mail-it1-f194.google.com with SMTP id z20so18908788itc.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 23:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAAzLY4nUUOH2CgPODRoRtQscXB+WtCb4ZBQSrMoK1Y=;
        b=fFQ5iom2VdjPzxBH+62cCZKFr8DxgNh3kV524J26mtGHmBXrjwOxo+5QqZAZtC/Rgr
         ku/CraPfVzlopWjbeXQStGZWn1bLqApl1X5V/Q+FVBBz1ik7iLwtPuWqBzIx2mVx1qln
         fNJHrnMAFDVEmFD1jZQ8g/x54u8YStMxOoWsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAAzLY4nUUOH2CgPODRoRtQscXB+WtCb4ZBQSrMoK1Y=;
        b=CQ6f4BwN0G3ai2ZFEP3HamuMnpwk39IEs9DuAreewTDv91SAZ0+cBh42yckljs6ktU
         daBvwWJjo4WugK61inOKBmU9KyPIGXWeAj/m7TpUbNIzc0WEm5DCmZ1K5Q0ompRUSXfw
         3YBDbmMB2i7rxCTjpWa48ab5zwbVk15YbSyn6enXy/p2817IbwUjzOBKvU9h6P1++V2s
         R3uB66/ZhymPTAl6bjwJPCoral9UDmD9Ky6Jyp6SChkd7hiv1+OC42+6pokGO7lenqx5
         P561iY5zO5STH2CG8VaZzw5Cg6ABP4y4jSkWpc9mMdXkZhpnkX5xhpkmPlOcmtx8PHgZ
         0gGg==
X-Gm-Message-State: AHQUAua9cmNzyIiHam908zu3fPMv7HW2iGGplYtpoEGLGpkYM418KVAJ
        gmTDs+oL2JJK/JILBm0dARyQGHFA5wm+djpJfpsnIA==
X-Google-Smtp-Source: AHgI3IYRLly3c4b5KQJA/e1VLGNDjW0HRUffzUF2nzEq/jZWkF0mEiAVgxm57IaCEi3PMorDEZQOmQqdPCOYdZV9DEc=
X-Received: by 2002:a02:734b:: with SMTP id a11mr1165897jae.62.1549265290404;
 Sun, 03 Feb 2019 23:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
 <20190202094119.13230-3-ard.biesheuvel@linaro.org> <20190204071809.GA115714@gmail.com>
In-Reply-To: <20190204071809.GA115714@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 4 Feb 2019 08:28:02 +0100
Message-ID: <CAKv+Gu-vxV_U03jdMY0N1UMDWcB1jZLKj-ONV2rsw3UTeimhBg@mail.gmail.com>
Subject: Re: [PATCH 02/10] x86/efi: Return error status if mapping EFI regions fail
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 at 08:18, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> >
> > efi_map_region() creates VA mappings for an given EFI region using any one
> > of the two helper functions (namely __map_region() and old_map_region()).
> > These helper functions *could* fail while creating mappings and presently
> > their return value is not checked. Not checking for the return value of
> > these functions might create issues because after these functions return
> > "md->virt_addr" is set to the requested virtual address (so it's assumed
> > that these functions always succeed which is not quite true). This
> > assumption leads to "md->virt_addr" having invalid mapping should any of
> > __map_region() or old_map_region() fail.
> >
> > Hence, check for the return value of these functions and if indeed they
> > fail, turn off EFI Runtime Services forever because kernel cannot
> > prioritize among EFI regions.
> >
> > This also fixes the comment "FIXME: add error handling" in
> > kexec_enter_virtual_mode().
> >
> > Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/x86/include/asm/efi.h     |  6 +++---
> >  arch/x86/platform/efi/efi.c    | 21 +++++++++++++-----
> >  arch/x86/platform/efi/efi_32.c |  6 +++---
> >  arch/x86/platform/efi/efi_64.c | 39 ++++++++++++++++++++++------------
> >  4 files changed, 48 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > index 107283b1eb1e..a37378f986ec 100644
> > --- a/arch/x86/include/asm/efi.h
> > +++ b/arch/x86/include/asm/efi.h
> > @@ -125,12 +125,12 @@ extern pgd_t * __init efi_call_phys_prolog(void);
> >  extern void __init efi_call_phys_epilog(pgd_t *save_pgd);
> >  extern void __init efi_print_memmap(void);
> >  extern void __init efi_memory_uc(u64 addr, unsigned long size);
> > -extern void __init efi_map_region(efi_memory_desc_t *md);
> > -extern void __init efi_map_region_fixed(efi_memory_desc_t *md);
> > +extern int __init efi_map_region(efi_memory_desc_t *md);
> > +extern int __init efi_map_region_fixed(efi_memory_desc_t *md);
> >  extern void efi_sync_low_kernel_mappings(void);
> >  extern int __init efi_alloc_page_tables(void);
> >  extern int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages);
> > -extern void __init old_map_region(efi_memory_desc_t *md);
> > +extern int __init old_map_region(efi_memory_desc_t *md);
> >  extern void __init runtime_code_page_mkexec(void);
> >  extern void __init efi_runtime_update_mappings(void);
> >  extern void __init efi_dump_pagetable(void);
> > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> > index e1cb01a22fa8..3d43ec58775b 100644
> > --- a/arch/x86/platform/efi/efi.c
> > +++ b/arch/x86/platform/efi/efi.c
> > @@ -581,7 +581,7 @@ void __init efi_memory_uc(u64 addr, unsigned long size)
> >       set_memory_uc(addr, npages);
> >  }
> >
> > -void __init old_map_region(efi_memory_desc_t *md)
> > +int __init old_map_region(efi_memory_desc_t *md)
> >  {
> >       u64 start_pfn, end_pfn, end;
> >       unsigned long size;
> > @@ -601,10 +601,14 @@ void __init old_map_region(efi_memory_desc_t *md)
> >               va = efi_ioremap(md->phys_addr, size,
> >                                md->type, md->attribute);
> >
> > -     md->virt_addr = (u64) (unsigned long) va;
> > -     if (!va)
> > +     if (!va) {
> >               pr_err("ioremap of 0x%llX failed!\n",
> >                      (unsigned long long)md->phys_addr);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     md->virt_addr = (u64)(unsigned long)va;
> > +     return 0;
>
> Just wondering, shouldn't the failure path set ->virt_addr to something
> safe, just in case a caller doesn't check the error and relies on it?
>
> That's because in this commit we've now changed it from 0 to undefined.
>

Indeed. We don't usually rely on the value of ->virt_addr when
EFI_RUNTIME_SERVICES is unset, but there is some sysfs code, and
perhaps some other places where we do reference ->virt_addr, and not
assigning it at all is obviously wrong, and potentially hazardous.

> > +int __init efi_map_region_fixed(efi_memory_desc_t *md) { return 0; }
>
> Inline functions should be marked inline ...
>
> >       if (efi_va < EFI_VA_END) {
> > -             pr_warn(FW_WARN "VA address range overflow!\n");
> > -             return;
> > +             pr_err(FW_WARN "VA address range overflow!\n");
> > +             return -ENOMEM;
> >       }
> >
> >       /* Do the VA map */
> > -     __map_region(md, efi_va);
> > +     if (__map_region(md, efi_va))
> > +             return -ENOMEM;
> > +
> >       md->virt_addr = efi_va;
> > +     return 0;
>
> Same error return problem of leaving ->virt_addr undefined.
>
> Note that I also fixed up the grammar and readability of the changelog -
> see the updated version below.
>
> Thanks,
>
>         Ingo
>
> =============>
> Subject: x86/efi: Return error status if mapping of EFI regions fails
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date: Sat, 2 Feb 2019 10:41:11 +0100
>
> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>
> efi_map_region() creates VA mappings for a given EFI region using one
> of the two helper functions (namely __map_region() and old_map_region()).
>
> These helper functions could fail while creating mappings and presently
> their return value is not checked.
>
> Not checking for the return value of these functions might create bugs,
> because after these functions return "md->virt_addr" is set to the
> requested virtual address (so it's assumed that these functions always
> succeed which is not quite true). This assumption leads to
> "md->virt_addr" having invalid mapping, should any of __map_region()
> or old_map_region() fail.
>
> Hence, check for the return value of these functions and if indeed they
> fail, turn off EFI Runtime Services forever because kernel cannot
> prioritize among EFI regions.
>
> This also fixes the comment "FIXME: add error handling" in
> kexec_enter_virtual_mode().
>

Thanks Ingo.

Sai, could you please respin this and use Ingo's updated version of
the commit log?
