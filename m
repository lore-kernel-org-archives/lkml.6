Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49B4C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34A1208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34A1208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeLNJzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:55:43 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43553 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:55:41 -0500
Received: by mail-vs1-f68.google.com with SMTP id x1so2997489vsc.10;
        Fri, 14 Dec 2018 01:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThuXCDpz5CSLhhjoqBknKNp1QrnaV9y+p8Qap5dUeXs=;
        b=OmMKWXF9bV5yc9PSoa2IVbjqcgwKvzo+67onrcfPDnsJmoRdau6VE0Ulla2M9APmHP
         l/3NgaXMMo15BNW0rbfjzb4WZ5lcNFIDOz68Te/kxbtYjL7mB2xTgrgOR2bcMpdalVmK
         kY/DSg6zvUcPuV8g5KVcivjxqfhfMg9m88l12u/dNsL+VRmDTfLPseb4xCvQy6sPNuRE
         b4BtWdk+b09hUEaSEDLZligvc13mLnWfBPN/hnEl3ivJp/3JD3ALw1SHm0hGo+ATv7B7
         NXpXjZ9ArkucY/PdRCZHoRMyiMxQmn9SHBmOOIxuHOhHzzhQ1OaAljrJwfa6VOD8H1S2
         x6Ag==
X-Gm-Message-State: AA+aEWayWHN0omDkbzsH/jqoBwWF7kVNT9yLgyFxtJVGpPZnp8mlV4vC
        djyJyEkgcxys5g2WlR5zlEotikEBIzEz5dhHM8A=
X-Google-Smtp-Source: AFSGD/V3n/1TM+2yf4bgAfeH10M3EAUX09H19VWC7w1ulSBQvf8Trtj1/fBaKWP6qMPLPi5zwjqKKm4ZDeSXJk26JLs=
X-Received: by 2002:a67:6002:: with SMTP id u2mr980067vsb.115.1544781340192;
 Fri, 14 Dec 2018 01:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20181214082515.14835-1-hch@lst.de> <20181214082515.14835-2-hch@lst.de>
 <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com>
In-Reply-To: <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 10:55:27 +0100
Message-ID: <CAMuHMdXzuS3sEZ1LNxhCiNtvzUneGsfPjMNWSh8UfbGEEnPTRA@mail.gmail.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:54 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Dec 14, 2018 at 9:26 AM Christoph Hellwig <hch@lst.de> wrote:
> > If we want to map memory from the DMA allocator to userspace it must be
> > zeroed at allocation time to prevent stale data leaks.   We already do
> > this on most common architectures, but some architectures don't do this
> > yet, fix them up, either by passing GFP_ZERO when we use the normal page
> > allocator or doing a manual memset otherwise.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Thanks for your patch!
>
> > --- a/arch/m68k/kernel/dma.c
> > +++ b/arch/m68k/kernel/dma.c
> > @@ -32,7 +32,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> >         size = PAGE_ALIGN(size);
> >         order = get_order(size);
> >
> > -       page = alloc_pages(flag, order);
> > +       page = alloc_pages(flag | GFP_ZERO, order);
> >         if (!page)
> >                 return NULL;
>
> There's second implementation below, which calls __get_free_pages() and
> does an explicit memset().  As __get_free_pages() calls alloc_pages(), perhaps
> it makes sense to replace the memset() by GFP_ZERO, to increase consistency?

Regardless, for m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
