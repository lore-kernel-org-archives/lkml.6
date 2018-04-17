Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeDQOEb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:04:31 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44382 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeDQOE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:04:29 -0400
X-Google-Smtp-Source: AIpwx4+3sQNh2FB82JAIHphQ9d1YmtJB880buMh2A9wW+OnNms6O4jDftpNj1PyeaE/3wQsRXOyll6dM57GA4uEHCGo=
MIME-Version: 1.0
In-Reply-To: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Apr 2018 16:04:27 +0200
X-Google-Sender-Auth: 16_Wvygr1pCXa4LEQ3mqhWwwPmk
Message-ID: <CAMuHMdX876iXo-Mio-VxUmR9hq9WFhNtOAn_XdhjFgNvDvXJvg@mail.gmail.com>
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thanks for your patch!

On Tue, Apr 17, 2018 at 3:35 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> With commit ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping
> operations observe dev->dma_pfn_offset") the generic DMA allocation
> function on which the SH 'dma_alloc_coherent()' function relies on,
> access the 'dma_pfn_offset' field of struct device.

accesses

> Unfortunately the 'dma_generic_alloc_coherent()' function is called from
> several places with a NULL struct device argument, halting the CPU
> during the boot process.
>
> This patch fixes the issue protecting access to dev->dma_pfn_offset,

by protecting access to the

> with a trivial check for validity. It also passes a valid 'struct device'
> in the 'platform_resource_setup_memory' function which is the main user
> of 'dma_alloc_coherent()', and inserting a WARN_ON() check to make future
> (and existing) bogus users of this function they're should provide a valid

drop "they're should"?

> 'struct device' whenever possible.

> --- a/arch/sh/mm/consistent.c
> +++ b/arch/sh/mm/consistent.c
> @@ -39,6 +39,8 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
>         void *ret, *ret_nocache;
>         int order = get_order(size);
>
> +       WARN_ON(!dev);
> +
>         gfp |= __GFP_ZERO;
>
>         ret = (void *)__get_free_pages(gfp, order);
> @@ -59,7 +61,9 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
>
>         split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
>
> -       *dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
> +       *dma_handle = virt_to_phys(ret);
> +       if (dev)
> +               *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);

I would keep the WARN_ON() and the (ideally unneeded) dev check as close
to each other as possible:

        if (!WARN_ON(!dev))
                *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);

>
>         return ret_nocache;
>  }
> @@ -69,9 +73,14 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
>                                unsigned long attrs)
>  {
>         int order = get_order(size);
> -       unsigned long pfn = (dma_handle >> PAGE_SHIFT) + dev->dma_pfn_offset;
> +       unsigned long pfn = (dma_handle >> PAGE_SHIFT);
>         int k;
>
> +       WARN_ON(!dev);
> +
> +       if (dev)
> +               pfn += dev->dma_pfn_offset;

        if (!WARN_ON(!dev))
                pfn += dev->dma_pfn_offset;

> +
>         for (k = 0; k < (1 << order); k++)
>                 __free_pages(pfn_to_page(pfn + k), 0);

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
