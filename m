Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BEEC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA6420838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D+PUfioI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA6420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLGItI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:49:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39354 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGItH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:49:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id c72so1619909pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 00:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJPKq/wqJp6Om5V2krap5TgJ85QivzMatjG9wTpmnJ0=;
        b=D+PUfioInyPnEpDXMsFxc5VegCqW+nr+qkS8uUFRrH6SQwCeWyS8kQKE2ofWvXD88c
         m/LvvcaPYyc+OehALPucz4mRinKCR1oBooqueLUI82waYT154pqFVbHcoqN1LYYCc2Om
         b5ThQLupgp1FxlSjBv1/6ckFDvThn0IdRnDWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJPKq/wqJp6Om5V2krap5TgJ85QivzMatjG9wTpmnJ0=;
        b=dC746StFLoFnMrmqqFcsS3iJrYLsalH0MfVslbvol9cjEp5iNs3yUsnkfsJoAvCbyB
         n4xOJalvzWykqyUfgea5zP1rYQgkbDdtyGk7KlLMF2pp51gFf3kZWImCV6NdF8zvDz/4
         DwZ9Iu7uK0C37gGOyLmNXzLjxttpHmV+SDlqzDHCZPLSQZ63Fi3SkmKd3boHHpwm41d2
         aBVSNzjjXfjI+RbWNzN0G3tvrE4bNPdzIDFKsolSy/SxGoTD0uV4MwwzzhQ0J5ewJWwK
         lVNLjD3sWX4EaNg3FdK6pLD0g6YgSAHBWdgT81kSIoAw8x6tHAGeTIq/+Oc5Qemlcvfy
         +AKg==
X-Gm-Message-State: AA+aEWa0DKDrZxmHWhKQOCqZe2PyNnH/j38xOqyqJ7l/y71vpUVI61O4
        6MWD1xPm6m6Lx1a+rKLuStJQ0ttFKJs2zhbX07bbBYakznP+gg==
X-Google-Smtp-Source: AFSGD/U//Oe+P+eE9LYX2jIXq1t5N/Fr4Ot5gm80YgOEI8ZtK+adoYc38Dv6jREJtlu+YGAO0GVNpaCJGprC1Tyx2Rk=
X-Received: by 2002:a63:4c04:: with SMTP id z4mr1201926pga.312.1544172546009;
 Fri, 07 Dec 2018 00:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20181207061620.107881-1-drinkcat@chromium.org>
 <20181207061620.107881-3-drinkcat@chromium.org> <20181207080551.GA15120@bombadil.infradead.org>
In-Reply-To: <20181207080551.GA15120@bombadil.infradead.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 7 Dec 2018 16:48:54 +0800
Message-ID: <CANMq1KABLMgvGcP-KwKhxmZnO-GuRAKJHf0sBtFaYLnCuHMJOQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com,
        hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 4:05 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Dec 07, 2018 at 02:16:19PM +0800, Nicolas Boichat wrote:
> > +#ifdef CONFIG_ZONE_DMA32
> > +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
> > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
>
> This name doesn't make any sense.  Why not ARM_V7S_TABLE_SLAB_FLAGS ?

Sure, will fix in v6 then.

> > +#else
> > +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
> > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA
>
> Can you remind me again why it is, on machines which don't support
> ZONE_DMA32, why we have to allocate from ZONE_DMA?  My understanding
> is that 64-bit machines have ZONE_DMA32 and 32-bit machines don't.
> So shouldn't this rather be GFP_KERNEL?

Sorry I mean to reply on the v4 thread, Christoph raised the same
question (https://patchwork.kernel.org/patch/10713025/).

I don't know, and I don't have all the hardware needed to test this
,-( Robin and Will both didn't seem sure.

I'd rather not introduce a new regression, this patch series tries to
fix a known arm64 regression, where we _need_ tables to be in DMA32.
If we want to change 32-bit hardware to use GFP_KERNEL, and we're sure
it works, that's fine by me, but it should be in another patch set.

Hope this makes sense,

Thanks,

> Actually, maybe we could centralise this in gfp.h:
>
> #ifdef CONFIG_64BIT
> # ifdef CONFIG_ZONE_DMA32
> #define GFP_32BIT       GFP_DMA32
> # else
> #define GFP_32BIT       GFP_DMA
> #else /* 32-bit */
> #define GFP_32BIT       GFP_KERNEL
> #endif
>
