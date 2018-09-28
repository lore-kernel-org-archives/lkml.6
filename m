Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA69C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481652172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481652172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeI1G2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 02:28:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:46748 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeI1G2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 02:28:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8S06mRi025169;
        Thu, 27 Sep 2018 19:06:49 -0500
Message-ID: <514bd29960cb1573ead2f3956f18e1cbaa5f32f7.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 28 Sep 2018 10:06:48 +1000
In-Reply-To: <20180927134922.GA8281@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
         <20180920185247.20037-4-hch@lst.de>
         <1811156d5a1df1166c7ab7522525619b951f047d.camel@kernel.crashing.org>
         <20180927134922.GA8281@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-27 at 15:49 +0200, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 11:45:15AM +1000, Benjamin Herrenschmidt wrote:
> > I'm not sure this is entirely right.
> > 
> > Let's say the mask is 30 bits. You will return GFP_DMA32, which will
> > fail if you allocate something above 1G (which is legit for
> > ZONE_DMA32).
> 
> And then we will try GFP_DMA further down in the function:
> 
> 		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
> 		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
> 		    !(gfp & GFP_DMA)) {
> 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
> 			goto again;
> 		}
> 
> This is and old optimization from x86, because chances are high that
> GFP_DMA32 will give you suitable memory for the infamous 31-bit
> dma mask devices (at least at boot time) and thus we don't have
> to deplete the tiny ZONE_DMA pool.

I see, it's rather confusing :-) Wouldn't it be better to check against
top of 32-bit memory instead here too ?


Cheers,
Ben.

