Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeEKKGR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 06:06:17 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:45816 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeEKKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 06:06:15 -0400
Date: Fri, 11 May 2018 20:06:06 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Schmitz <schmitzmic@gmail.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
In-Reply-To: <8c2c3ad5-eeb5-cf61-b9fb-c6096619e310@gmail.com>
Message-ID: <alpine.LNX.2.21.1805112003250.8@nippy.intranet>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org> <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com> <alpine.LNX.2.21.1805031801310.8@nippy.intranet> <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
 <alpine.LNX.2.21.1805091805130.72@nippy.intranet> <CAOmrzkKNPemq5RySvza+Y8_jgwg2fkUZodR794cgOxpQpfh+SA@mail.gmail.com> <alpine.LNX.2.21.1805110921020.8@nippy.intranet> <CAOmrzkLL0ZNzAh7rwiDy=BkNqqXgbqfv3vkN6K8CTF8VGbT8zA@mail.gmail.com>
 <alpine.LNX.2.21.1805111221180.8@nippy.intranet> <0b13a08d-ba2d-b9dc-4fd9-1f6bad5cd1ee@gmail.com> <alpine.LNX.2.21.1805111451220.8@nippy.intranet> <8c2c3ad5-eeb5-cf61-b9fb-c6096619e310@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018, Michael Schmitz wrote:

> 
> I wasn't proposing to follow platform_device_register() with the mask 
> assignment,

I see.

> but rather to use the same strategy from the Coldfire FEC patch 
> (f61e64310b75): set pdev.dev.coherent_dma_mask and pdev.dev.dma_mask 
> _before_ calling platform_device_register().
> 

That patch is attempting to solve the same problem using a different 
approach, but I'd prefer to keep using platform_device_register_simple().

> 
> If you want to avoid the overhead of defining the macmace platform 
> device and using platform_device_register() ... seeing as you would not 
> be defining just the DMA mask and nothing else, that's probably the 
> least effort for the MACE and SONIC drivers.
> 

I don't mind the effort. I want to avoid all the boilerplate.

> 
> You would have to be careful not to overwrite a pdev->dev.dma_mask and 
> pdev->dev.dma_coherent_mask that might have been set in a platform 
> device passed via platform_device_register here. Coldfire is the only 
> m68k platform currently using that, but there might be others in future.
> 

That Coldfire patch could be reverted if this is a better solution.

> ... But I don't think there are smaller DMA masks used by m68k drivers 
> that use the platform device mechanism at present. I've only looked at 
> arch/m68k though.

So we're back at the same problem that Geert's suggestion also raised: how 
to identify potentially affected platform devices and drivers?

Maybe we can take a leaf out of Christoph's book, and leave a noisy 
WARNING splat in the log.

void arch_setup_pdev_archdata(struct platform_device *pdev)
{
        WARN_ON_ONCE(pdev->dev.coherent_dma_mask != DMA_MASK_NONE ||
                     pdev->dev.dma_mask != NULL);
        pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
        pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
}

-- 
