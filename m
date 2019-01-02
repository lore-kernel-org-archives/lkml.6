Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13624C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 05:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E3E218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 05:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m1NoC2Hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfABFv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 00:51:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41094 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfABFv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 00:51:58 -0500
Received: by mail-qt1-f193.google.com with SMTP id l12so32445868qtf.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 21:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RT2abgqnBKCQ74QwzoyIyU7Rv/U52C3iy99nR44H5o=;
        b=m1NoC2HqsQfyDG3eQXWCxZiWnU2XjiZIpTQPa+5vsHI3mqNz1EftTooPlMZQlxFfZ8
         JZ2zSWtwWl2/Z84PqKsLn35wscF4HMwRIE5ZiM/gSS87W9A2VP3RnRkgCRuFUxzuEw39
         3U+ycyEya+PCJmp8aBL4QQPSPNy+QlQHisk2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RT2abgqnBKCQ74QwzoyIyU7Rv/U52C3iy99nR44H5o=;
        b=sheYfddiQBsFZriDMBOjq6L9cEcOvdB/0QLM3WqPuV+8RnUSjDr9sjX+C3sliTBQgW
         qB9Rb4K/YL+nxNEkuduHx2pHKUfiaCaIe+hzl7/2i2RuaYxkm1Etv+yT0mvEYkQSWHKL
         qIa0Ey5veL2FNAaIDnvDDDR7OPUJ25+IVNGB3bufba8CrzdRwuEMsqcO7/mvlAZxf1xd
         pCvflwSzu9Ch+QDeC+zGIW1LTusoLwbGLBLqEhwgvWWtwx4Uu1EUum077+ezNJMP7PXO
         ZsX4mClwDTHeZV6JsHGN4ryy1MSDUFlxBO9jRwzi3RT6UbOQ5oRyUyq8iTs9Ibpl6LX9
         dduQ==
X-Gm-Message-State: AA+aEWbilIDiCkL2ZhNHUfGH21y9k19fGkKyLjkvMvd/thnLn6REPMI4
        tAVSYqyMMs/Z0qRKfzdtqU6+EMDobhKJRUzzrbITPg==
X-Google-Smtp-Source: AFSGD/U/cTetaNn2yuxykYMMgcxPM+HG9ZU6Nw6VmD3O2sHrZWwUWUUgYwwduvJqxV6VLHsvs9V8vcPOQLpfP2Pcta8=
X-Received: by 2002:ac8:6b50:: with SMTP id x16mr42135783qts.368.1546408316297;
 Tue, 01 Jan 2019 21:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20181210011504.122604-1-drinkcat@chromium.org>
In-Reply-To: <20181210011504.122604-1-drinkcat@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 2 Jan 2019 13:51:45 +0800
Message-ID: <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
To:     Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
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
        Tomasz Figa <tfiga@google.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>, hch@infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, Dec 10, 2018 at 9:15 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> This is a follow-up to the discussion in [1], [2].
>
> IOMMUs using ARMv7 short-descriptor format require page tables
> (level 1 and 2) to be allocated within the first 4GB of RAM, even
> on 64-bit systems.
>
> For L1 tables that are bigger than a page, we can just use __get_free_pages
> with GFP_DMA32 (on arm64 systems only, arm would still use GFP_DMA).
>
> For L2 tables that only take 1KB, it would be a waste to allocate a full
> page, so we considered 3 approaches:
>  1. This series, adding support for GFP_DMA32 slab caches.
>  2. genalloc, which requires pre-allocating the maximum number of L2 page
>     tables (4096, so 4MB of memory).
>  3. page_frag, which is not very memory-efficient as it is unable to reuse
>     freed fragments until the whole page is freed. [3]
>
> This series is the most memory-efficient approach.

Does anyone have any further comment on this series? If not, which
maintainer is going to pick this up? I assume Andrew Morton?

Thanks,

> stable@ note:
>   We confirmed that this is a regression, and IOMMU errors happen on 4.19
>   and linux-next/master on MT8173 (elm, Acer Chromebook R13). The issue
>   most likely starts from commit ad67f5a6545f ("arm64: replace ZONE_DMA
>   with ZONE_DMA32"), i.e. 4.15, and presumably breaks a number of Mediatek
>   platforms (and maybe others?).
>
> [1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html
> [2] https://lists.linuxfoundation.org/pipermail/iommu/2018-December/031696.html
> [3] https://patchwork.codeaurora.org/patch/671639/
>
> Changes since v1:
>  - Add support for SLAB_CACHE_DMA32 in slab and slub (patches 1/2)
>  - iommu/io-pgtable-arm-v7s (patch 3):
>    - Changed approach to use SLAB_CACHE_DMA32 added by the previous
>      commit.
>    - Use DMA or DMA32 depending on the architecture (DMA for arm,
>      DMA32 for arm64).
>
> Changes since v2:
>  - Reworded and expanded commit messages
>  - Added cache_dma32 documentation in PATCH 2/3.
>
> v3 used the page_frag approach, see [3].
>
> Changes since v4:
>  - Dropped change that removed GFP_DMA32 from GFP_SLAB_BUG_MASK:
>    instead we can just call kmem_cache_*alloc without GFP_DMA32
>    parameter. This also means that we can drop PATCH v4 1/3, as we
>    do not make any changes in GFP flag verification.
>  - Dropped hunks that added cache_dma32 sysfs file, and moved
>    the hunks to PATCH v5 3/3, so that maintainer can decide whether
>    to pick the change independently.
>
> Changes since v5:
>  - Rename ARM_V7S_TABLE_SLAB_CACHE to ARM_V7S_TABLE_SLAB_FLAGS.
>  - Add stable@ to cc.
>
> Nicolas Boichat (3):
>   mm: Add support for kmem caches in DMA32 zone
>   iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging
>   mm: Add /sys/kernel/slab/cache/cache_dma32
>
>  Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
>  drivers/iommu/io-pgtable-arm-v7s.c          | 19 +++++++++++++++----
>  include/linux/slab.h                        |  2 ++
>  mm/slab.c                                   |  2 ++
>  mm/slab.h                                   |  3 ++-
>  mm/slab_common.c                            |  2 +-
>  mm/slub.c                                   | 16 ++++++++++++++++
>  tools/vm/slabinfo.c                         |  7 ++++++-
>  8 files changed, 53 insertions(+), 7 deletions(-)
>
> --
> 2.20.0.rc2.403.gdbc3b29805-goog
>
