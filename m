Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826A4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCA12086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCA12086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbeGQP1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:27:54 -0400
Received: from verein.lst.de ([213.95.11.211]:51848 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbeGQP1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:27:54 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 315A96FC87; Tue, 17 Jul 2018 16:57:25 +0200 (CEST)
Date:   Tue, 17 Jul 2018 16:57:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Fredrik Noring <noring@nocrew.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        JuergenUrban@gmx.de
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Message-ID: <20180717145725.GA22109@lst.de>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com> <20180705193613.GA28905@lst.de> <20180715122826.GB2342@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715122826.GB2342@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 02:28:27PM +0200, Fredrik Noring wrote:
> Hi Christoph, Robin,
> 
> On Thu, Jul 05, 2018 at 09:36:13PM +0200, Christoph Hellwig wrote:
> > > -	BUG_ON(!ops);
> > > -	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> > > -
> > >  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
> > >  		return cpu_addr;
> > >  
> > > +	BUG_ON(!ops);
> > > +	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> > 
> > I think doing dma on a device without ops is completely broken no matter
> > what you think of it, so I very much disagree with that part of the change.
> > 
> > Also while I don't think not having a dma mask is a good idea even for
> > a driver purely using dma coherent pools.  If the pools really are on
> > the device itself I can see why it might not matter, but for the case
> > commonly used on some ARM SOCs where we just reserve memory for certain
> > devices from a system pool it very much does matter.
> > 
> > There really is no good excuse to not set a coherent mask in the drivers.
> 
> Here are three other regressions related to the coherent mask WARN_ON_ONCE:

They are a pretty strong indication that yes, you should really set
the coherent mask if you ever do coherent allocations..
