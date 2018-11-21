Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD81320645
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t9Z2iURo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD81320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbeKVIPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:15:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbeKVIPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cRlbueyY+SE79sSVXSDyNFhJoIAEAQgj9H3E386hlQQ=; b=t9Z2iURomCrPF4p9zWq4fzQyX
        FX59HZ3JZc1A0egL9sKHM22a/0lfmM7FkJ+NDWNMYzN9oyiU1X3VJkw0hxrkrOzFXi3k06X01cFrW
        t95pv2KdHvxloegBLcS+YEC9Nz8fMQi3+C8LPP//Hg6tP+Nr6+kaT45A/2vV/AnDob73/eJLnAgu7
        pSM0vQtwJEKPXROU6XK0HPUbEe1RzUZgWGv2l2NIXVfkyIxIbE23pmxOcRG6IYSJ6FZHdttsTG65t
        1RhOVpUzBnP0NNjLm5NRfBBc20rDjxsBNQcUk6fDk40rFQAxHfx9PjUeqwbaKJT1HokkgfL1gUIb3
        m/gIyzCqw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPaCz-00019r-PX; Wed, 21 Nov 2018 21:38:53 +0000
Date:   Wed, 21 Nov 2018 13:38:53 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
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
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Message-ID: <20181121213853.GL3065@bombadil.infradead.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 06:20:02PM +0000, Christopher Lameter wrote:
> On Sun, 11 Nov 2018, Nicolas Boichat wrote:
> 
> > This is a follow-up to the discussion in [1], to make sure that the page
> > tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
> > physical address space.
> 
> Page tables? This means you need a page frame? Why go through the slab
> allocators?

Because this particular architecture has sub-page-size PMD page tables.
We desperately need to hoist page table allocation out of the architectures;
there're a bunch of different implementations and they're mostly bad,
one way or another.

For each level of page table we generally have three cases:

1. single page
2. sub-page, naturally aligned
3. multiple pages, naturally aligned

for 1 and 3, the page allocator will do just fine.
for 2, we should have a per-MM page_frag allocator.  s390 already has
something like this, although it's more complicated.  ppc also has
something a little more complex for the cases when it's configured with
a 64k page size but wants to use a 4k page table entry.

I'd like x86 to be able to simply do:

#define pte_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
#define pmd_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
#define pud_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
#define p4d_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)

An architecture with 4k page size and needing a 16k PMD would do:

#define pmd_alloc_one(mm, addr) page_alloc_table(mm, addr, 2)

while an architecture with a 64k page size needing a 4k PTE would do:

#define ARCH_PAGE_TABLE_FRAG
#define pte_alloc_one(mm, addr) pagefrag_alloc_table(mm, addr, 4096)

I haven't had time to work on this, but perhaps someone with a problem
that needs fixing would like to, instead of burying yet another awful
implementation away in arch/ somewhere.
