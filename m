Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DB3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF3421917
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KP6IfCKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfBQRPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 12:15:46 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42117 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfBQRPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 12:15:46 -0500
Received: by mail-vs1-f66.google.com with SMTP id b20so8317180vsl.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVv4u7xXBnJzjMh4BjD25r3SfNCvgwwqZN8ECpi/Rz4=;
        b=KP6IfCKZrlPqGXPN6AKUKX/2Nhx21liHOSXowW6PciT3Evtgh/pUBd8x0VeKzl1Maz
         z/z6TDa9IM+dUvSsLJ/yFa5PrZBRc0JP9Mfnd4GhOr2n5JXOCnRi6nXgDlpRgSlZ8Vmj
         Yw5ZnL1ZazB/9808frg5/ytacz0YBFKfm+RbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVv4u7xXBnJzjMh4BjD25r3SfNCvgwwqZN8ECpi/Rz4=;
        b=pYLkQohFKdZ1TkFCH00x8Srt5yof0srPFfQ1UgIkxyQ9oueMpogr9GDUtF2f1e70xD
         xL9FNlCPlcIP0m+iPVnv04QmTCZXLlk+S+VpGFBd5IW/kyczFmfkGvf9GV/TYNZxYvx9
         XvLFpWyluy7vdl4UYO5uuTVxk2nr35l9d3KOhQ6p/IrzXsqwErqMoQrRkqITkv0+qWoE
         uwsqrb7IYyTfAmBfRmtPcHAEmE4BSnydQnpQqh7y+YaFPw61pKAflEDt9PLwWlLJrQTT
         vKjG0g04lQPfx3jl13IKfGhSc5PaGb6YzZgfKmukw0tfDgHHW/NDqf5KqN7KPAtRAFcl
         q25g==
X-Gm-Message-State: AHQUAubn0qz3m9r5Q9kI7WXy6F/u2oqxXhG5T7E9kW963ECYjUA1BIsL
        6stRGcgM2xEdVZoz5rRrl+6lXFHrpN0=
X-Google-Smtp-Source: AHgI3IYgiIAs0W/FSc9GiY3pdzrmK1N+0Ch9C2dFHC+R/HfUN8TQ39l8/V9S1oridvEyb4rpShNMGw==
X-Received: by 2002:a67:f68b:: with SMTP id n11mr10209560vso.164.1550423744749;
        Sun, 17 Feb 2019 09:15:44 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id p185sm1837466vsd.20.2019.02.17.09.15.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 09:15:44 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id i15so5718027vsd.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:15:44 -0800 (PST)
X-Received: by 2002:a67:6f44:: with SMTP id k65mr9396261vsc.222.1550423288041;
 Sun, 17 Feb 2019 09:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20190216140008.28671-1-bhe@redhat.com> <20190216140008.28671-2-bhe@redhat.com>
In-Reply-To: <20190216140008.28671-2-bhe@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 09:07:55 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+MUrt70E6YiwM0QWOQxQeU9+rY7UPvuDrASne1pkCZLA@mail.gmail.com>
Message-ID: <CAGXu5j+MUrt70E6YiwM0QWOQxQeU9+rY7UPvuDrASne1pkCZLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] x86/mm/KASLR: Improve code comments about struct kaslr_memory_region
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

On Sat, Feb 16, 2019 at 6:01 AM Baoquan He <bhe@redhat.com> wrote:
>
> The old comment above kaslr_memory_region is not clear enough to explain
> the concepts of memory region KASLR.
>
> [Ingo suggested this and helped to prettify the text]
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/kaslr.c | 55 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 3f452ffed7e9..d7c6e4e8e48e 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -42,10 +42,59 @@
>  static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
>
>  /*
> - * Memory regions randomized by KASLR (except modules that use a separate logic
> - * earlier during boot). The list is ordered based on virtual addresses. This
> - * order is kept after randomization.
> + * 'struct kasl_memory_region' entries represent continuous chunks of

Typo: struct kaslr_memory_region

Also, while you're rewriting this, how about putting it in full
kern-doc format? (You're already using the "@field" style...) I think
you just need the "/**" header...

/**
 * struct name.... - short description...

> + * kernel virtual memory regions, to be randomized by KASLR.
> + *
> + * ( The exception is the module space virtual memory window which
> + *   uses separate logic earlier during bootup. )
> + *
> + * Currently there are three such regions: the physical memory mapping,
> + * vmalloc and vmemmap regions.
> + *
> + * The array below has the entries ordered based on virtual addresses.
> + * The order is kept after randomization, i.e. the randomized
> + * virtual addresses of these regions are still ascending.
> + *
> + * Here are the fields:
> + *
> + * @base: points to a global variable used by the MM to get the
> + * virtual base address of any of the above regions. This allows the
> + * early KASLR code to modify these base addresses early during bootup,
> + * on a per bootup basis, without the MM code even being aware of whether
> + * it got changed and to what value.
> + *
> + * When KASLR is active then the MM code makes sure that for each region
> + * there's such a single, dynamic, global base address 'unsigned long'
> + * variable available for the KASLR code to point to and modify directly:
> + *
> + *     { &page_offset_base, 0 },
> + *     { &vmalloc_base,     0 },
> + *     { &vmemmap_base,     1 },
> + *
> + * @size_tb: size in TB of each memory region. Thereinto, the size of

nit: "Thereinto" is odd. I'd say "Therefore".

> + * the physical memory mapping region is variable, calculated according
> + * to the actual size of system RAM in order to save more space for
> + * randomization. The rest are fixed values related to paging mode.
> + *
> + * @size_tb: is the size of each memory region after randomization, and
> + * its unit is TB.

Redundant lines?

> + *
> + * Physical memory mapping: (actual RAM size + 10 TB padding)
> + * Vmalloc: 32 TB
> + * Vmemmap: 1 TB
> + *
> + * When randomize the layout, their order are kept, still the physical
> + * memory mapping region is handled fistly, next vmalloc and vmemmap.

typo: "first"

> + * E.g the physical memory region, we limit the starting address to be
> + * taken from the 1st 1/3 part of the whole available virtual address
> + * space which is from 0xffff880000000000 to 0xfffffe0000000000, namely
> + * the original starting address of the physical memory mapping region
> + * to the starting address of cpu_entry_area mapping region. Once a random
> + * address is chosen for the physical memory mapping, we jump over the
> + * region and add 1G to begin the next region handling with the remaining
> + * available space.

Should the "operation" comments (rather than the struct field
comments) be moved to the start of the kernel_randomize_memory()
function instead?

-Kees

>   */
> +
>  static __initdata struct kaslr_memory_region {
>         unsigned long *base;
>         unsigned long size_tb;
> --
> 2.17.2
>


-- 
Kees Cook
