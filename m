Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756394AbeEJBZw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:25:52 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58154 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756003AbeEJBZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:25:51 -0400
Date: Thu, 10 May 2018 11:25:35 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
In-Reply-To: <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1805091805130.72@nippy.intranet>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org> <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com> <alpine.LNX.2.21.1805031801310.8@nippy.intranet> <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2018, Geert Uytterhoeven wrote:

> 
> Perhaps you can add a new helper 
> (platform_device_register_simple_dma()?) that takes the DMA mask, too?

Would there be enough potential callers in future to justify that API?
It seems that there haven't been many in the past. I found four users of 
platform_device_register_simple() which might benefit. Mostly these call 
dma_set_coherent_mask() in the platform driver probe routine.

drivers/gpu/drm/etnaviv/etnaviv_drv.c
drivers/gpu/drm/exynos/exynos_drm_drv.c
drivers/gpu/drm/omapdrm/omap_drv.c
drivers/parport/parport_pc.c

(Am I missing any others?)

To actually hoist the dma mask setup out of existing platform drivers 
would have implications for every device that matches with those drivers. 

That's a bit risky since I can't test those devices -- that's assuming I 
could identify them all; sometimes platform device matching is not well 
defined at build time (see loongson_sysconf.ecname).

So far, it looks like macmace and macsonic would be the only callers of 
this new API call.

What's worse, if you do pass a dma_mask in struct platform_device_info, 
you end up with this problem in platform_device_register_full():

        if (pdevinfo->dma_mask) {
                /*
                 * This memory isn't freed when the device is put,
                 * I don't have a nice idea for that though.  Conceptually
                 * dma_mask in struct device should not be a pointer.
                 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
                 */
                pdev->dev.dma_mask =
                        kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);

Most of the platform drivers that call dma_coerce_mask_and_coherent() are 
using pdev->of_match_table, not platform_device_register_simple(). Many of 
them have a comment like this:

        /*
         * Right now device-tree probed devices don't get dma_mask set.
         * Since shared usb code relies on it, set it here for now.
         * Once we have dma capability bindings this can go away.
         */

> With people setting the mask to kill the WARNING splat, this may become 
> more common.

Since the commit which introduced the WARNING, only commits f61e64310b75 
("m68k: set dma and coherent masks for platform FEC ethernets") and 
7bcfab202ca7 ("powerpc/macio: set a proper dma_coherent_mask") seem to be 
aimed at squelching that WARNING.

(Am I missing any others?)

So far, this is not looking like a common problem, and I'm having trouble 
finding some way to improve on my original patches.

-- 
