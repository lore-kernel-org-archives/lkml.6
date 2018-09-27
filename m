Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56D3216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56D3216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeI0UIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:08:16 -0400
Received: from verein.lst.de ([213.95.11.211]:45429 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbeI0UIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:08:16 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C7F6568B02; Thu, 27 Sep 2018 15:49:54 +0200 (CEST)
Date:   Thu, 27 Sep 2018 15:49:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal
 memory size
Message-ID: <20180927134954.GB8281@lst.de>
References: <20180920185247.20037-1-hch@lst.de> <20180920185247.20037-6-hch@lst.de> <985079efc3296ac45de1e6344d7916c42fc7cbdd.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985079efc3296ac45de1e6344d7916c42fc7cbdd.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:50:14AM +1000, Benjamin Herrenschmidt wrote:
> > -	 * to be able to satisfy them - either by not supporting more physical
> > -	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> > -	 * architecture needs to use an IOMMU instead of the direct mapping.
> > -	 */
> > -	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> > +	u64 min_mask;
> > +
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA))
> > +		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> > +	else
> > +		min_mask = min_t(u64, DMA_BIT_MASK(32),
> > +				 (max_pfn - 1) << PAGE_SHIFT);
> > +
> > +	if (mask >= phys_to_dma(dev, min_mask))
> >  		return 0;
> 
> nitpick ... to be completely "correct", I would have written
> 
> 	if (IS_ENABLED(CONFIG_ZONE_DMA))
> 		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> 	else
> 		min_mask = DMA_BIT_MASK(32);
> 
> 	min_mask = min_t(u64, min_mask,	(max_pfn - 1) << PAGE_SHIFT);
> 
> In "theory" it's also ok to have a mask < ZONE_DMA_BITS as long as it's
> big enough to fit all memory :-)

Yeah, we could do that.
