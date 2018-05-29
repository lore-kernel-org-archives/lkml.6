Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756097AbeE2CPD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:15:03 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56986 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755922AbeE2CO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:14:59 -0400
Date: Tue, 29 May 2018 12:15:05 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Christoph Hellwig <hch@lst.de>, Michael Schmitz <schmitzmic@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, Joshua Thompson <funaho@jurai.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
In-Reply-To: <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1805291047230.13@nippy.intranet>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net> <alpine.LNX.2.21.1805271212480.9@nippy.intranet> <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com> <alpine.LNX.2.21.1805271547090.9@nippy.intranet> <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
 <alpine.LNX.2.21.1805281521420.10@nippy.intranet> <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018, Geert Uytterhoeven wrote:

> 
> Do we have a consensus on the way forward?

My prefered solution remains the two driver patches that I originally 
submitted, which you objected to:

https://lkml.org/lkml/2018/5/3/10
https://lkml.org/lkml/2018/5/3/9

So there is no consensus yet.

To my mind, the existing code is pretty clear: drivers should set the 
(default) mask. See also,

$ egrep -r -A1 "coherent_dma_mask.*expected" */
drivers/of/device.c:     * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
drivers/of/device.c-     * setup the correct supported mask.
--
drivers/acpi/arm64/iort.c:       * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
drivers/acpi/arm64/iort.c-       * setup the correct supported mask.
$ 

And drivers/usb/dwc2/platform.c:

        /*
         * Use reasonable defaults so platforms don't have to provide these.
         */
        if (!dev->dev.dma_mask)
                dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
        retval = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));

And FWIW,

$ egrep -wlr "dma_set_mask_and_coherent|dma_set_coherent_mask|dma_coerce_mask_and_coherent" drivers/ | wc -l
196

I suppose that a driver should avoid lengthening an existing device mask.

Since an arch gets to apply limits in the dma ops it implements, why would 
arch code also have to set a limit in the form of default platform device 
masks? Powerpc seems to be the only arch that does this.

The same line of reasoning suggests that the problematic WARN_ON should 
not appear in include/linux/ in the first place. If it is needed by 
certain architectures, it should be in arch/x.

I would send a patch to revert commit 205e1b7f51e4 ("dma-mapping: warn 
when there is no coherent_dma_mask") if I thought that arch code was not 
somehow relying on it. But I'll leave that up to Chrisoph.

-- 
