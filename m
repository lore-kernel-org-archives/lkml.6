Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4A7218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfB0AnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:43:00 -0500
Received: from muru.com ([72.249.23.125]:40912 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfB0AnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:43:00 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F243E80CD;
        Wed, 27 Feb 2019 00:43:09 +0000 (UTC)
Date:   Tue, 26 Feb 2019 16:42:55 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>, hch@lst.de,
        m.szyprowski@samsung.com, vdumpa@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com,
        sre@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
Message-ID: <20190227004255.GG39872@atomide.com>
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
 <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Robin Murphy <robin.murphy@arm.com> [190226 23:36]:
> On 2019-02-26 8:23 pm, Nicolin Chen wrote:
> > This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
> > 
> > The original change breaks omap dss:
> >      omapdss_dispc 58001000.dispc:
> >          dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> > 
> > Let's revert it first and then find a safer solution instead.

Sounds like a good idea since we're only have few days left
before the merge window.

> Ah, I think I see the problem - once arch/arm's __dma_alloc() has decided to
> use CMA (because dev_get_cma_area(dev) returns the global area), it then
> won't fall back to trying a regular page allocation if
> dma_alloc_from_contiguous() returns NULL. Thus anything on 32-bit Arm trying
> to allocate a single-page buffer in blockable context with a CMA-enabled
> config is just going to fail. Similarly, it looks like none of the
> DMA_ATTR_FORCE_CONTIGUOUS cases are prepared to handle this change either
> (amd_iommu appears technically affected, but is already using
> dma_alloc_from_contiguous() backwards compared to everyone else, hmm).
> 
> I guess the question is whether to add alloc_page()/free_page() fallbacks to
> those call sites, or stuff them directly into the CMA helpers here.

Well if you come up with some test patch, I can easily test it :)

> > Would you please test and verify? Thanks!

Yes this revert works for me:

Tested-by: Tony Lindgren <tony@atomide.com>

