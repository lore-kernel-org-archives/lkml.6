Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E07C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3EF20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3EF20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbeLNMgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:36:49 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43662 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730971AbeLNMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:36:39 -0500
Received: by mail-ua1-f68.google.com with SMTP id z11so1918263uaa.10;
        Fri, 14 Dec 2018 04:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqxfuuSPSAlQ411a79lNQlI69Cygyc43d8KqVm4q3X8=;
        b=tIeISsaZ7TfPuNYfoWcCwEE5YAlsKtHdX3M72hbVOL8qa3MXzx+SzrtJWg50x+S3F3
         oCWdSBXdUXoBDYtjXQVtaWvg0w7tX0dwndF60oRbaOE9iQB7ZPvSZ4c+whOdOQplTzQt
         DDXjzrxgHi6WX9Yl4bHqU4cCH1fw3WDllWjkebai4TBc4tOGH3GSdqcC1fNpjjI2QIqN
         FFSd4UVrprqoJRn7WpV0jllAudj8wh/35sfNCXrQm7eX9/A+VklV4nSmRZKW4gA/EvtG
         lKE0Wb9Vyy0smuf+DcykKp6I2b1X6N4MKuEc0l8FLpCpLGl5WNoObrq94uYkQvGwCJNJ
         ox2A==
X-Gm-Message-State: AA+aEWZ4ejUoo6BomuaeFXMpA048Z/2li8YJbkIMRSQZQRIB7Z1+BS13
        NeG34yvYAniVqIDcu06h/xlg/+SNNnLVz+07/vM=
X-Google-Smtp-Source: AFSGD/Uk0FNPu0d7TR2WdDrWKyiFVluIj13FXrIrQImHkjEe2TcIfvOBpRI6lb5lcLI+cX4sn2/NabljOhiDyA7RAI4=
X-Received: by 2002:ab0:465:: with SMTP id 92mr1224666uav.28.1544790998234;
 Fri, 14 Dec 2018 04:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20181214082515.14835-1-hch@lst.de> <20181214082515.14835-2-hch@lst.de>
 <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com> <20181214114719.GA3316@lst.de>
In-Reply-To: <20181214114719.GA3316@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 13:36:26 +0100
Message-ID: <CAMuHMdUU36Jg0vNGV2WwkceNNGEnGX4yxwEecT3abKz0AG+epw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux IOMMU <iommu@lists.linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>, ashutosh.dixit@intel.com,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Dec 14, 2018 at 12:47 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Dec 14, 2018 at 10:54:32AM +0100, Geert Uytterhoeven wrote:
> > > -       page = alloc_pages(flag, order);
> > > +       page = alloc_pages(flag | GFP_ZERO, order);
> > >         if (!page)
> > >                 return NULL;
> >
> > There's second implementation below, which calls __get_free_pages() and
> > does an explicit memset().  As __get_free_pages() calls alloc_pages(), perhaps
> > it makes sense to replace the memset() by GFP_ZERO, to increase consistency?
>
> It would, but this patch really tries to be minimally invasive to just
> provide the zeroing everywhere.

Fair enough.

> There is plenty of opportunity
> to improve the m68k dma allocator if I can get enough reviewers/testers:
>
>  - for one the coldfire/nommu case absolutely does not make sense to
>    me as there is not work done at all to make sure the memory is
>    mapped uncached despite the architecture implementing cache
>    flushing for the map interface.  So this whole implementation
>    looks broken to me and will need some major work (I had a previous
>    discussion with Greg on that which needs to be dug out)
>  - the "regular" implementation in this patch should probably be replaced
>    with the generic remapping helpers that have been added for the 4.21
>    merge window:
>
>         http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/0c3b3171ceccb8830c2bb5adff1b4e9b204c1450
>
> Compile tested only patch below:
>
> --
> From ade86dc75b9850daf9111ebf9ce15825a6144f2d Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 14 Dec 2018 12:41:45 +0100
> Subject: m68k: use the generic dma coherent remap allocator
>
> This switche to using common code for the DMA allocations, including
> potential use of the CMA allocator if configure.  Also add a few
> comments where the existing behavior seems to be lacking.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, looks OK to me.
M68k doesn't have many drivers using the DMA framework, as most of them
predated that framework.

> --- a/arch/m68k/kernel/dma.c
> +++ b/arch/m68k/kernel/dma.c

>
> -void arch_dma_free(struct device *dev, size_t size, void *addr,
> -               dma_addr_t handle, unsigned long attrs)
> +pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
> +               unsigned long attrs)
>  {
> -       pr_debug("dma_free_coherent: %p, %x\n", addr, handle);
> -       vfree(addr);
> +       /*
> +        * XXX: this doesn't seem to handle the sun3 MMU at all.

Sun-3 selects NO_DMA, and this file is compiled for the HAS_DMA case only.

> +        */
> +       if (CPU_IS_040_OR_060) {
> +               pgprot_val(prot) &= ~_PAGE_CACHE040;
> +               pgprot_val(prot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
> +       } else {
> +               pgprot_val(prot) |= _PAGE_NOCACHE030;
> +       }
> +       return prot;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
