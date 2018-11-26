Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A30C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC0A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rdWaGrgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC0A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeKZSzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:55:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeKZSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=amDM0wawmoyNitm1BF0fX+K8gx+7QqeubLeoS13rZMM=; b=rdWaGrgNfw4kIFrjUOJyZWmQ6
        aBhjsBHaApdP3bO5xfNs8r/aKiTr6pF9lvJM6fMLR1u6ZmzDjGYT/4XwxIo3nvCfJ15V9UxXFau1u
        Ydxz3rrpfq0jQbxpffudnJ1p3gFVQNieOo+JftB6R2H0SPfAikVJ32J8alP2bS0bCxiOuOHX/C9X+
        ejeX/026BP0NXNe7Mc+rxlRKaOQlCBGmn3eZ29gjaYM2CTrEeXnDeLI2ozkyHfBz+SSR+zVxtwAsv
        9fRTskn0Q9e1PaNpvrZf5juiKWrk02BKyKawdlxlusZykTR+Z0i5UXNpNGS/IJS01JNSa4oFfLZYr
        i0rcQeNvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRBqQ-0004fm-11; Mon, 26 Nov 2018 08:02:14 +0000
Date:   Mon, 26 Nov 2018 00:02:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Michal Hocko <mhocko@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        David Rientjes <rientjes@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yingjoe.chen@mediatek.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Message-ID: <20181126080213.GA17809@infradead.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
 <20181122082336.GA2049@infradead.org>
 <555dd63a-0634-6a39-7abc-121e02273cb2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555dd63a-0634-6a39-7abc-121e02273cb2@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 01:23:41PM +0100, Vlastimil Babka wrote:
> Is this also true for caches created by kmem_cache_create(), that
> debugging options can result in not respecting the alignment passed to
> kmem_cache_create()? That would be rather bad, IMHO.

That's what I understood in the discussion.  If not it would make
our live simpler, but would need to be well document.

Christoph can probably explain the alignment choices in slub.

> 
> > But I do agree with the sentiment of not wanting to spread GFP_DMA32
> > futher into the slab allocator.
> 
> I don't see a problem with GFP_DMA32 for custom caches. Generic
> kmalloc() would be worse, since it would have to create a new array of
> kmalloc caches. But that's already ruled out due to the alignment.

True, purely slab probably isn't too bad.
