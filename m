Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7433C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE6020672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jjp6fPye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE6020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeLELBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:01:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37039 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeLELBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:01:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so9906282plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 03:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fAwxirXvKSBwHD7F87FQNRm1Bs8VUKIJ1ixDohaxvyo=;
        b=jjp6fPye3+yWNPt145+nY0kGHOOdSMnqumE8d06LeJbKKU+Hxe1vctFtVfz66IomL/
         5tOM6q/6xliyE6EyvrgxxrE7p3kBJmLUBEa+kykNCxYMQDxKc63p/fITVzWhK2lUP5TK
         U+bbS7es4Etx0I30scYfPfMwtmhXEO9UfNqJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAwxirXvKSBwHD7F87FQNRm1Bs8VUKIJ1ixDohaxvyo=;
        b=tSechjIzq4RvcUK/e6XqE45PREZN4ESlVR9hO+lTI/RsqCfplWzLMeHI13eGhwxn1u
         QaTIhvSHH2I8Iwt9+z1r5vw6PQE28nxjkFlUZ4Oqlrx3u+8VQ4zuxEXIw46hVtA/B1VW
         M2rBeMpfO1UIgF9wqGupo7iUMUbzNwQtsJP4oFl2pk16Buxn5bU/7WNJzb/X7NIwXYB5
         JHR/3o6FYXOWJdcT4fWIFGYeW1M+KTfU5lE9EI8zHsKubnpKXNdiaomfYWgeEF6DFFNA
         uTwarpS334m3mE748GONrDEPdrgm0aVnfBJf/fJZd1DZPksZapwAAvzCTVkrivKi9HQt
         roBQ==
X-Gm-Message-State: AA+aEWaSzljQqn1VFpwFdjZnGNyRjYK/4HBbWY40I5J1YXqx7SQSNBUW
        u6vGeIeYIS4NIuQrXZ1oit31RiTV/Ut8qnU3PRNChQ==
X-Google-Smtp-Source: AFSGD/Wk0zs4VhqhdwYbu2PyFWGf/M2ApBaccL6hKiY9HzccaDJKBrxcsNLKo6cKHPwSnn9CjE1s7A6FIsX17UlinCg=
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr22731032pln.224.1544007676601;
 Wed, 05 Dec 2018 03:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-3-drinkcat@chromium.org> <20181205095557.GE1286@dhcp22.suse.cz>
In-Reply-To: <20181205095557.GE1286@dhcp22.suse.cz>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 5 Dec 2018 19:01:03 +0800
Message-ID: <CANMq1KCnpSUKoz83LcEgAkhCi8QVPH715xtgdQD23r-tYusrPw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
To:     mhocko@kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
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
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 5:56 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 05-12-18 13:48:27, Nicolas Boichat wrote:
> > In some cases (e.g. IOMMU ARMv7s page allocator), we need to allocate
> > data structures smaller than a page with GFP_DMA32 flag.
> >
> > This change makes it possible to create a custom cache in DMA32 zone
> > using kmem_cache_create, then allocate memory using kmem_cache_alloc.
> >
> > We do not create a DMA32 kmalloc cache array, as there are currently
> > no users of kmalloc(..., GFP_DMA32). The new test in check_slab_flags
> > ensures that such calls still fail (as they do before this change).
>
> The changelog should be much more specific about decisions made here.
> First of all it would be nice to mention the usecase.

Ok, I'll copy most of the cover letter text here (i.e. the fact that
IOMMU wants physical memory <4GB for L2 page tables, why it's better
than genalloc/page_frag).

> Secondly, why do we need a new sysfs file? Who is going to consume it?

We have cache_dma, so it seems consistent to add cache_dma32.

I wasn't aware of tools/vm/slabinfo.c, so I can add support for
cache_dma32 in a follow-up patch. Any other user I should take care
of?

> Then why do we need SLAB_MERGE_SAME to cover GFP_DMA32 as well?

SLAB_MERGE_SAME tells us which flags _need_ to be the same for the
slabs to be merged. We don't want slab caches with GFP_DMA32 and
~GFP_DMA32 to be merged, so it should be in there.
(https://elixir.bootlin.com/linux/v4.19.6/source/mm/slab_common.c#L342).

> I
> thought the whole point is to use dedicated slab cache. Who is this
> going to merge with?

Well, if there was another SLAB cache requiring 1KB GFP_DMA32
elements, then I don't see why we would not merge the caches. This is
what happens with this IOMMU L2 tables cache pre-CONFIG_ZONE_DMA32 on
arm64 (output on some 3.18 kernel below), and what would happen on
arm32 since we still use GFP_DMA.

/sys/kernel/slab # ls -l | grep dt-0001024
drwxr-xr-x. 2 root root 0 Dec  5 02:25 :dt-0001024
lrwxrwxrwx. 1 root root 0 Dec  5 02:25 dma-kmalloc-1024 -> :dt-0001024
lrwxrwxrwx. 1 root root 0 Dec  5 02:25 io-pgtable_armv7s_l2 -> :dt-0001024

Thanks!

> --
> Michal Hocko
> SUSE Labs
