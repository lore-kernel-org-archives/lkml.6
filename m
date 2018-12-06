Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730C3C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3852820672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A2mlhkbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3852820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbeLFKJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:09:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35536 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:09:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so11569720plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAZFAsMe6hZyGv5RzFXOQY01K5owXwcpa6Gj4RdYfLU=;
        b=A2mlhkbXkZpjgEqBQ4YZbuwMAkvlehsRCIJxTI4iYiC7c3WzDU7YIuPN1ycIh139sG
         Qu0+cHE1dO3bTwd+nGj0d/2zo1pZbuo1B6Bkvi3mp9MSml+d3wgsbbGJyG9t0mqcyHpV
         uae8CJ1VoR4cn2g8bJdsBtQzeobY0KSnxdww4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAZFAsMe6hZyGv5RzFXOQY01K5owXwcpa6Gj4RdYfLU=;
        b=gmrzifR1QOylFyw76Qg9aHnYRDyGgDVfOVrEx0k27Tr2WnhWowEjUuLt3Q2buYiwkZ
         m1SJjMps8r5QMOshnjS0H8AUo4FRoaiGgOkoF0yrM9F5yeJ+hE9N+SrPFzUBVnMEW2iZ
         ZmO5+RpOl7hdZhWi/gpV3kJ9UCZtV66FRNO/BOpi1xidgunI0dJtK7vXykSpOvggb8BU
         slKcIK9PuYSusMwgq/SCKLp3vJ76+2qvNalOfPikUkMl1xiujKv/RY6k1fEZulFm1dxV
         TDdzHx4woKpvR/dRzSBsJxqh5M3ih4KE9MlKoJi1LC36ouswphhQKYXmpVYPSnqoAhds
         pizQ==
X-Gm-Message-State: AA+aEWbrOoPcc7m/uvEeX8ymrC4oG0aHnjZ4oYJL2tnRoXPymshWrZBx
        AsvsiudG3IdopfI1kASS6FCZOS3hzpL9UVYr9GH1BQ==
X-Google-Smtp-Source: AFSGD/WZ4ET0u3SIXj0I70/iJWZ/4hF3pE8zGA7spHW4T7hjjyD/ZR7zhHTFbEFplrLbmhPL+KKze90vJfs9uCvUt+k=
X-Received: by 2002:a17:902:b68d:: with SMTP id c13mr27666751pls.102.1544090990437;
 Thu, 06 Dec 2018 02:09:50 -0800 (PST)
MIME-Version: 1.0
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-3-drinkcat@chromium.org> <5eddd264-5527-a98e-fc8b-31ea89f474db@suse.cz>
 <CANMq1KAL7TcVa4xF8=NdK2cs0VakEq5i6MyCvfmYTGCmJ78-ag@mail.gmail.com> <09f56edb-2dab-c023-2164-dd7b5cef6afb@suse.cz>
In-Reply-To: <09f56edb-2dab-c023-2164-dd7b5cef6afb@suse.cz>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 6 Dec 2018 18:09:39 +0800
Message-ID: <CANMq1KAJ7YvbpUvRqP0zEWY1_pC-TvHMZYn4FUj4A9Bpmv_jxg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 5:37 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 12/6/18 4:49 AM, Nicolas Boichat wrote:
> >> So it would be fine even unchanged. The check would anyway need some
> >> more love to catch the same with __GFP_DMA to be consistent and cover
> >> all corner cases.
> > Yes, the test is not complete. If we really wanted this to be
> > accurate, we'd need to check that GFP_* exactly matches SLAB_CACHE_*.
> >
> > The only problem with dropping this is test that we should restore
> > GFP_DMA32 warning/errors somewhere else (as Christopher pointed out
> > here: https://lkml.org/lkml/2018/11/22/430), especially for kmalloc
> > case.
>
> I meant just dropping that patch hunk, not the whole test. Then the test
> stays as it is and will keep warning anyone calling kmalloc(GFP_DMA32).
> It would also warn anyone calling kmem_cache_alloc(GFP_DMA32) on
> SLAB_CACHE_DMA32 cache, but since the gfp can be just dropped, and you
> as the only user of this so far will do that, it's fine?

I missed your point, this would work fine indeed.

Thanks.

> > Maybe this can be done in kmalloc_slab.
