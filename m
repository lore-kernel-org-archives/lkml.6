Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC0BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB76421917
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZpteCKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfBQRW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 12:22:57 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35838 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBQRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 12:22:56 -0500
Received: by mail-vk1-f194.google.com with SMTP id l136so3350194vke.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXHgdZ/XLQUe2OZ4G9qF4I0KOgq13Q/ejtJlCQloByI=;
        b=WZpteCKzTeR1SWTtO8vGqh+0h3W6/VQlIgavbijqQ09b1y44Drw13JcukPMPU84d2/
         rlHC1Ru4e3N16lwyn02mpKLKoQ8JpjaS4P+PCBdJg2RNYibWV6D7bLZscXE37EZN/UUE
         8NALvjYayhgRLACVm8gYXLDauk6aik49U/CGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXHgdZ/XLQUe2OZ4G9qF4I0KOgq13Q/ejtJlCQloByI=;
        b=PnDsbLQ30sRvJA6T37M9XjPog9pCr6QZuIyFq9+dQnLwHpnb31Gz2DP8doNcZfplXx
         uGVvjQJ+XRJRpy0x7nUGxhJmg0JD7+w6trjFpkxSAVBUt/Hjc22AgF+n0+mmGAPK3J5h
         xoJIYCV7XFpzI/SKSmgBGGQpfpmyJocLBylm2XiUq1TeGT5/s1siBdhsHfdgAS7suvE1
         rjffXob5fvnnuV+QpjTH6185yMOKXpgWzmYN9BnDdROoOoXiCq3Ru6WLQElRY4tbMi5E
         sxfaT4Pd8bCr4chmmTP3x55OXCp6GvWHH/M4faPUl+Vlcgc77xrNprx9zvNA75sL0TeK
         2//w==
X-Gm-Message-State: AHQUAuYh4tN9UW+HUiiv6mHFJAw87aeWqkVMO4x7rvDSFGsfonODEY3E
        mdnLYWvlwOra7fnmPwBA1Hwkm8R8VyA=
X-Google-Smtp-Source: AHgI3IbXTxSv9cbo2Bu3sS5jUwg7vNKybhf7OSzQTDq6YWYrg6RiawPW9ngvFjZlKQ7KA46FfQdMLw==
X-Received: by 2002:a1f:a0d7:: with SMTP id j206mr3210640vke.37.1550424174847;
        Sun, 17 Feb 2019 09:22:54 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id e23sm1493680uam.4.2019.02.17.09.22.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 09:22:54 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id i15so5723542vsd.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:22:54 -0800 (PST)
X-Received: by 2002:a05:6102:d2:: with SMTP id u18mr2049755vsp.172.1550423710168;
 Sun, 17 Feb 2019 09:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20190216140008.28671-1-bhe@redhat.com> <20190216140008.28671-3-bhe@redhat.com>
In-Reply-To: <20190216140008.28671-3-bhe@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 09:14:58 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKesZbrMWk6DOyMcpRr_JOLZF01umzXsf3BDueFFegqDQ@mail.gmail.com>
Message-ID: <CAGXu5jKesZbrMWk6DOyMcpRr_JOLZF01umzXsf3BDueFFegqDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] x86/mm/KASLR: Open code unnecessary function get_padding
To:     Baoquan He <bhe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Mike Travis <travis@sgi.com>,
        Thomas Garnier <thgarnie@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 6:02 AM Baoquan He <bhe@redhat.com> wrote:
>
> It's used only twice and we do bit shifts in the parent function
> anyway so it's not like it's hiding some uninteresting detail.
>
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/mm/kaslr.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index d7c6e4e8e48e..bf680929fe26 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -104,12 +104,6 @@ static __initdata struct kaslr_memory_region {
>         { &vmemmap_base, 1 },
>  };
>
> -/* Get size in bytes used by the memory region */
> -static inline unsigned long get_padding(struct kaslr_memory_region *region)
> -{
> -       return (region->size_tb << TB_SHIFT);
> -}
> -
>  /*
>   * Apply no randomization if KASLR was disabled at boot or if KASAN
>   * is enabled. KASAN shadow mappings rely on regions being PGD aligned.
> @@ -161,7 +155,7 @@ void __init kernel_randomize_memory(void)
>         /* Calculate entropy available between regions */
>         remain_entropy = vaddr_end - vaddr_start;
>         for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
> -               remain_entropy -= get_padding(&kaslr_regions[i]);
> +               remain_entropy -= kaslr_regions[i].size_tb << TB_SHIFT;
>
>         prandom_seed_state(&rand_state, kaslr_get_random_long("Memory"));
>
> @@ -185,7 +179,7 @@ void __init kernel_randomize_memory(void)
>                  * Jump the region and add a minimum padding based on
>                  * randomization alignment.
>                  */
> -               vaddr += get_padding(&kaslr_regions[i]);
> +               vaddr += kaslr_regions[i].size_tb << TB_SHIFT;
>                 if (pgtable_l5_enabled())
>                         vaddr = round_up(vaddr + 1, P4D_SIZE);
>                 else
> --
> 2.17.2
>


-- 
Kees Cook
