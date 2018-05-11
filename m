Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeEKF3H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 01:29:07 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:41120 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeEKF3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 01:29:06 -0400
Date: Fri, 11 May 2018 15:28:58 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc: "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
In-Reply-To: <0b13a08d-ba2d-b9dc-4fd9-1f6bad5cd1ee@gmail.com>
Message-ID: <alpine.LNX.2.21.1805111451220.8@nippy.intranet>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org> <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com> <alpine.LNX.2.21.1805031801310.8@nippy.intranet> <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
 <alpine.LNX.2.21.1805091805130.72@nippy.intranet> <CAOmrzkKNPemq5RySvza+Y8_jgwg2fkUZodR794cgOxpQpfh+SA@mail.gmail.com> <alpine.LNX.2.21.1805110921020.8@nippy.intranet> <CAOmrzkLL0ZNzAh7rwiDy=BkNqqXgbqfv3vkN6K8CTF8VGbT8zA@mail.gmail.com>
 <alpine.LNX.2.21.1805111221180.8@nippy.intranet> <0b13a08d-ba2d-b9dc-4fd9-1f6bad5cd1ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018, Michael Schmitz wrote:

> 
> I'm afraid using platform_device_register() (which you already use for 
> the SCC devices) is the only option handling this on a per-device basis 
> without touching platform core code, while at the same time keeping the 
> DMA mask setup out of device drivers

I don't think that will fly. If you call platform_device_register() and 
follow that with a dma mask assignment, you could race with the bus 
matching and driver probe, and we are back to the same WARNING message.

If you want to use platform_device_register(), you'd have to implement 
arch_setup_pdev_archdata() and use that to set up the dma mask.

> (I can see Geert's point there - device driver code might be shared 
> across implementations of the device on platforms with different DMA 
> mask requirements,, something the driver can't be expected to know 
> about).

As I said, these drivers might be expected to be portable between Macs and 
early PowerMacs, but the same dma mask would apply AFAIK.

If a platform driver isn't expected to be portable, I think either method 
is reasonable: arch_setup_pdev_archdata() or the method in the patch.

Anyway, there is this in arch/powerpc/kernel/setup-common.c:

void arch_setup_pdev_archdata(struct platform_device *pdev)
{
        pdev->archdata.dma_mask = DMA_BIT_MASK(32);
        pdev->dev.dma_mask = &pdev->archdata.dma_mask;
	...

I'm inclined to propose something similar for m68k. That should fix the 
problem, since arch_setup_pdev_archdata() is already in the call chain:

	platform_device_register_simple()
		platform_device_register_resndata()
			platform_device_register_full()
				platform_device_alloc()
					arch_setup_pdev_archdata()

Thoughts? Will this have nasty side effects for m68k platforms that use 
smaller dma masks?

-- 

> 
> Cheers,
> 
> 	Michael
> 
