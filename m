Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551A3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7D020874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7D020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbeGWJuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:50:00 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:39485 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387951AbeGWJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:50:00 -0400
Received: by mail-vk0-f65.google.com with SMTP id e139-v6so8848753vkf.6;
        Mon, 23 Jul 2018 01:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3gEY2CxvXNh09RfS+F0kJfVDZ/7N1a2XoHJIdBLzFc=;
        b=hwwxZyND+1dXzlmOgE8memhIjE14S9EIlLetSxf+mPWISEJhDqoDsfrGz7aVXTDXpJ
         xaS0RRM3vvjQrvgONoltWqXhBckvqXynLt2xl+aW6Hf4wC7/jCrMf7xOFgr7IxQDSFgI
         PCjNbYXBbcKpmZ7vMK7g9Z6mGpRjQtIu9VXuWR24Ng2KNtwvkvTj2JllOKIdipHjgzSG
         YPTiSeSK8wIuX1rMuoARWF73VimIvecIu5tz8Ub1quKY0Bh0DubZ13BffUmhD4GAyCn+
         yKXGKt04M+3FlLaPcr3lrgH0n89qFIEyi6WsaG7CSJ/bdm4PRIKMLST8vobA0IJIeqlZ
         qIbQ==
X-Gm-Message-State: AOUpUlHnxFqQ0x4HQn+9HjYW4OT/kTFQWdU9G1jmr8zAndjzc2KOiqR8
        aUnJvYbfXTwaC2VFW6kv0DNduxj0U6gX0NT02XU=
X-Google-Smtp-Source: AAOMgpeMfshzmfo596wWHm9ni2pL+QwkT7Ojj0nOCAIldfYKKaj1u9zQHQGWsHOQMIyb/1fqtc8Y6m2cCv4z6g+qSOI=
X-Received: by 2002:a1f:8ad3:: with SMTP id m202-v6mr7092750vkd.9.1532335791483;
 Mon, 23 Jul 2018 01:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180719130516.1989-1-hch@lst.de> <20180719130516.1989-5-hch@lst.de>
 <20180723084207.GI6784@w540>
In-Reply-To: <20180723084207.GI6784@w540>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Jul 2018 10:49:39 +0200
Message-ID: <CAMuHMdX=b0iAnDw1=85MXNBSMD=MxZb27QrO3rEWHYq0vB+3ow@mail.gmail.com>
Subject: Re: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Mon, Jul 23, 2018 at 10:42 AM jacopo mondi <jacopo@jmondi.org> wrote:
> I have a single comment on something I noticed which might be an
> implementation bug. On the overall patch architecture, it's very hard
> for me to provide a valuable opinion as it's all relatively new for me
> here :)
>
> On Thu, Jul 19, 2018 at 06:05:15AM -0700, Christoph Hellwig wrote:
> > Half of the file just contains platform device memory setup code which
> > is required for all builds, and half contains helpers for dma coherent
> > allocation, which is only needed if CONFIG_DMA_NONCOHERENT is enabled.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>

> > --- /dev/null
> > +++ b/arch/sh/kernel/dma-coherent.c
> > @@ -0,0 +1,85 @@
> > +/*
> > + * Copyright (C) 2004 - 2007  Paul Mundt
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + */
> > +#include <linux/mm.h>
> > +#include <linux/init.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/module.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/addrspace.h>
> > +
> > +void *dma_generic_alloc_coherent(struct device *dev, size_t size,
> > +                              dma_addr_t *dma_handle, gfp_t gfp,
> > +                              unsigned long attrs)
> > +{
> > +     void *ret, *ret_nocache;
> > +     int order = get_order(size);
> > +
> > +     gfp |= __GFP_ZERO;
> > +
> > +     ret = (void *)__get_free_pages(gfp, order);
> > +     if (!ret)
> > +             return NULL;
> > +
> > +     /*
> > +      * Pages from the page allocator may have data present in
> > +      * cache. So flush the cache before using uncached memory.
> > +      */
> > +     sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
> > +
> > +     ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
> > +     if (!ret_nocache) {
> > +             free_pages((unsigned long)ret, order);
> > +             return NULL;
> > +     }
> > +
> > +     split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
> > +
> > +     *dma_handle = virt_to_phys(ret);
> > +     if (!WARN_ON(!dev))
> > +             *dma_handle - PFN_PHYS(dev->dma_pfn_offset);
>
> I guess this comes from below...

> > -     *dma_handle = virt_to_phys(ret);
> > -     if (!WARN_ON(!dev))
> > -             *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
>
> ... here
>
> Is the s/-=/- intended?
>
> Snippets copied here below:
>
> > +     *dma_handle = virt_to_phys(ret);
> > +     if (!WARN_ON(!dev))
> > +             *dma_handle - PFN_PHYS(dev->dma_pfn_offset);
> vs
> > -     *dma_handle = virt_to_phys(ret);
> > -     if (!WARN_ON(!dev))
> > -             *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);

Doesn't look right to me, neither.

No complaints for 0day? My gcc says:

    error: statement with no effect [-Werror=unused-value]

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
