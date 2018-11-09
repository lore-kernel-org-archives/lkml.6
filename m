Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06C5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7723520883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mKQeO+1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7723520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeKIViW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:38:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33119 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:38:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id q5-v6so781758pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 03:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oj0qv3KwGcTOa1sp7yqXD7mcastYXWlmJMO9yoT5yBg=;
        b=mKQeO+1VwBJSyA3ZwMybJc9inoblqXuxzryQ3DP0yj3ClE3ppXhRhMEJSSymn65OJ2
         kr1cNXCvonXdZXeGkrxZ8S+9weqisvigKiIEdCl6sxjHa6bZ9IZtKxozYgJvsJU202GX
         zcke2SzDNP8ty/58D6TFKva8x4LdfFJYHe6BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oj0qv3KwGcTOa1sp7yqXD7mcastYXWlmJMO9yoT5yBg=;
        b=ZVtJk3cJlXFwPowhkV/OyZjnVRu+it3tOh2gEXaZb9yRTsIzBb9Pntpn26VwYMuH0b
         5U6UkP6DZG/DwxQGPwCSiu6nA9acmtl+50T9hcOIl+KGGqFGZrmZ7reNnpidmQmPwzgb
         /lh/agmlEtFQbRxzgeJZhpurl9VzhI+R9IfO6oEKDCd2XltBTT24i7A9wNpvwNdIvinK
         eTfMFXGz1TxcQh/mHbfT1Ea/YpNYske5mXj2oGtRjoZ7SVMg+Q4LgjmLaF09YZqXk7ve
         HpshUNKVHzotsQSplgKVeI95GDLKqSuLcwJa5djBNjUpOWxrmC/cWrndfoBgPywTguzm
         iF5Q==
X-Gm-Message-State: AGRZ1gIxGhfqZnisYc0lgUXxunyhtmJ9UK+tHujG8F6ZiVXng3VsgFm0
        nQZ81MDD0IWYcP9+SblMuU7j7rP2fO5P3ltZJiNK/A==
X-Google-Smtp-Source: AJdET5enU09SuBo3wyZbygGy3ZpUuCTx47thIm2+eJpwL9Epsv6QAEUiIR5N8seTk2FeooweMoIoOM25D31Dj7ULHP8=
X-Received: by 2002:a62:4251:: with SMTP id p78-v6mr8737695pfa.72.1541764683280;
 Fri, 09 Nov 2018 03:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20181109082448.150302-1-drinkcat@chromium.org>
 <20181109082448.150302-2-drinkcat@chromium.org> <00afe803-22dd-5a75-70aa-dda0c7752470@suse.cz>
In-Reply-To: <00afe803-22dd-5a75-70aa-dda0c7752470@suse.cz>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 9 Nov 2018 19:57:50 +0800
Message-ID: <CANMq1KB84Lpe_QbiuaKaBOwSsYr9Cis-gv5xpXaV5qjU=ON=7w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] mm: When CONFIG_ZONE_DMA32 is set, use DMA32 for SLAB_CACHE_DMA
To:     vbabka@suse.cz
Cc:     robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        mgorman@techsingularity.net, yehs1@lenovo.com,
        rppt@linux.vnet.ibm.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        yong.wu@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
        tfiga@google.com, yingjoe.chen@mediatek.com,
        Alexander.Levin@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 6:43 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/9/18 9:24 AM, Nicolas Boichat wrote:
> > Some callers, namely iommu/io-pgtable-arm-v7s, expect the physical
> > address returned by kmem_cache_alloc with GFP_DMA parameter to be
> > a 32-bit address.
> >
> > Instead of adding a separate SLAB_CACHE_DMA32 (and then audit
> > all the calls to check if they require memory from DMA or DMA32
> > zone), we simply allocate SLAB_CACHE_DMA cache in DMA32 region,
> > if CONFIG_ZONE_DMA32 is set.
> >
> > Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >  include/linux/slab.h | 13 ++++++++++++-
> >  mm/slab.c            |  2 +-
> >  mm/slub.c            |  2 +-
> >  3 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 918f374e7156f4..390afe90c5dec0 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -30,7 +30,7 @@
> >  #define SLAB_POISON          ((slab_flags_t __force)0x00000800U)
> >  /* Align objs on cache lines */
> >  #define SLAB_HWCACHE_ALIGN   ((slab_flags_t __force)0x00002000U)
> > -/* Use GFP_DMA memory */
> > +/* Use GFP_DMA or GFP_DMA32 memory */
> >  #define SLAB_CACHE_DMA               ((slab_flags_t __force)0x00004000U)
> >  /* DEBUG: Store the last owner for bug hunting */
> >  #define SLAB_STORE_USER              ((slab_flags_t __force)0x00010000U)
> > @@ -126,6 +126,17 @@
> >  #define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
> >                               (unsigned long)ZERO_SIZE_PTR)
> >
> > +/*
> > + * When ZONE_DMA32 is defined, have SLAB_CACHE_DMA allocate memory with
> > + * GFP_DMA32 instead of GFP_DMA, as this is what some of the callers
> > + * require (instead of duplicating cache for DMA and DMA32 zones).
> > + */
> > +#ifdef CONFIG_ZONE_DMA32
> > +#define SLAB_CACHE_DMA_GFP GFP_DMA32
> > +#else
> > +#define SLAB_CACHE_DMA_GFP GFP_DMA
> > +#endif
>
> AFAICS this will break e.g. x86 which can have both ZONE_DMA and
> ZONE_DMA32, and now you would make kmalloc(__GFP_DMA) return objects
> from ZONE_DMA32 instead of __ZONE_DMA, which can break something.

Oh, I was not aware that both ZONE_DMA and ZONE_DMA32 can be defined
at the same time. I guess the test should be inverted, something like
this (can be simplified...):
#ifdef CONFIG_ZONE_DMA
#define SLAB_CACHE_DMA_GFP GFP_DMA
#elif defined(CONFIG_ZONE_DMA32)
#define SLAB_CACHE_DMA_GFP GFP_DMA32
#else
#define SLAB_CACHE_DMA_GFP GFP_DMA // ?
#endif

> Also I'm probably missing the point of this all. In patch 3 you use
> __get_dma32_pages() thus __get_free_pages(__GFP_DMA32), which uses
> alloc_pages, thus the page allocator directly, and there's no slab
> caches involved.

__get_dma32_pages fixes level 1 page allocations in the patch 3.

This change fixes level 2 page allocations
(kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA)), by transparently
remapping GFP_DMA to an underlying ZONE_DMA32.

The alternative would be to create a new SLAB_CACHE_DMA32 when
CONFIG_ZONE_DMA32 is defined, but then I'm concerned that the callers
would need to choose between the 2 (GFP_DMA or GFP_DMA32...), and also
need to use some ifdefs (but maybe that's not a valid concern?).

> It makes little sense to involve slab for page table
> allocations anyway, as those tend to be aligned to a page size (or
> high-order page size). So what am I missing?

Level 2 tables are ARM_V7S_TABLE_SIZE(2) => 1kb, so we'd waste 3kb if
we allocated a full page.

Thanks,
