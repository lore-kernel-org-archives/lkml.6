Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E06C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51738214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tzo9Ah2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfAUQWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:22:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbfAUQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ddLMmpwg07bDKig77yyfZoBxTi30hmKOTn48Y4iVA9w=; b=tzo9Ah2WnduWLPC8rDKi208Ul
        Wjdq5G8lYqIJvB22CRfDcWxjrgutd05cioRQ2goRLjBon1QhRjqowa2LYbqcUqZqWaC5puxe5pg7w
        tSV1uBiN79BzLVD36g7Qy1RENAxOjugO35KbPzP3E0icUqL5auHz/L1anBByw7YRiDcf7M1Z4CF55
        kzeQFHLd8F8l1QG0KO7MQuS2+1QEeJvZlHysn6LWojE3L/Mz/nQE6rk29IksQgMialJiHvbP//SQN
        gDB4OsTzvtLxlz9Dtrq9Oam0Fqz61Po/quJhilyx+CgVQHu/dtjqKFjfJfT005V5naqL0Ltsp62HY
        6sMVF3ceg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glcLO-0007Io-TC; Mon, 21 Jan 2019 16:22:38 +0000
Date:   Mon, 21 Jan 2019 08:22:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Michel Daenzer <michel.daenzer@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Message-ID: <20190121162238.GA17651@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 05:14:37PM +0100, Ard Biesheuvel wrote:
> > I'll add big fat comments.  But the fact that nothing is exported
> > there should be a fairly big hint.
> >
> 
> I don't follow. How do other header files 'export' things in a way
> that this header doesn't?

Well, I'll add comments to make it more obvious..

> As far as I can tell, these drivers allocate DMA'able memory [in
> ttm_tt_populate()] and subsequently create their own CPU mappings for
> it, assuming that
> a) the default is cache coherent, so vmap()ing those pages with
> cacheable attributes works, and

Yikes.  vmaping with different attributes is generally prone to
create problems on a lot of architectures.

> b) telling the GPU to use NoSnoop attributes makes the accesses it
> performs coherent with non-cacheable CPU mappings of those physical
> pages
> 
> Since the latter is not true for many arm64 systems, I need this patch
> to get a working system.

Do we know that this actually works anywhere but x86?

In general I would call these above sequence rather bogus and would
prefer we could get rid of such antipatterns in the kernel and just use
dma_alloc_attrs with DMA_ATTR_WRITECOMBINE if we want writecombine
semantics.

Until that happens we should just change the driver ifdefs to default
the hacks to off and only enable them on setups where we 100%
positively know that they actually work.  And document that fact
in big fat comments.
