Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756330AbeEJBZ0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:25:26 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58130 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeEJBZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:25:25 -0400
Date: Thu, 10 May 2018 11:25:09 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Christoph Hellwig <hch@lst.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
In-Reply-To: <20180503085120.GA14574@lst.de>
Message-ID: <alpine.LNX.2.21.1805091804290.72@nippy.intranet>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org> <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com> <alpine.LNX.2.21.1805031801310.8@nippy.intranet> <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
 <20180503085120.GA14574@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2018, Christoph Hellwig wrote:

> On Thu, May 03, 2018 at 10:46:56AM +0200, Geert Uytterhoeven wrote:
> > Perhaps you can add a new helper 
> > (platform_device_register_simple_dma()?) that takes the DMA mask, too? 
> > With people setting the mask to kill the WARNING splat, this may 
> > become more common.
> > 
> > struct platform_device_info already has a dma_mask field, but 
> > platform_device_register_resndata() explicitly sets it to zero.
> 
> Yes, that would be useful.  The other assumption could be that platform 
> devices always allow an all-0xff dma mask.

Could that have unintended side effects? The mask is presently unset by 
default, and my worry would be that changing it may cause some drivers to 
behave differently.

A quick grep turns up this in drivers/spi/spi-au1550.c for example,

	if (pdev->dev.dma_mask == NULL)
		dev_warn(&pdev->dev, "no dma mask\n");
	else
		hw->usedma = 1;

Also, if pdev.dev.dma_mask is to get a default value, shouldn't it use the 
same default as dma_get_mask, to avoid unintended side effects?

static inline u64 dma_get_mask(struct device *dev)
{
        if (dev && dev->dma_mask && *dev->dma_mask)
                return *dev->dma_mask;
        return DMA_BIT_MASK(32);
}

-- 
