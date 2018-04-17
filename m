Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753911AbeDQNyZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:54:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60584 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753392AbeDQNyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:54:23 -0400
Date: Tue, 17 Apr 2018 15:54:07 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
        thomas.petazzoni@free-electrons.com, robin.murphy@arm.com,
        geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
Message-ID: <20180417155407.49c981b3@windsurf.numericable.fr>
In-Reply-To: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 17 Apr 2018 15:35:23 +0200, Jacopo Mondi wrote:
> With commit ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping
> operations observe dev->dma_pfn_offset") the generic DMA allocation
> function on which the SH 'dma_alloc_coherent()' function relies on,
> access the 'dma_pfn_offset' field of struct device.
> 
> Unfortunately the 'dma_generic_alloc_coherent()' function is called from
> several places with a NULL struct device argument, halting the CPU
> during the boot process.
> 
> This patch fixes the issue protecting access to dev->dma_pfn_offset,
> with a trivial check for validity. It also passes a valid 'struct device'
> in the 'platform_resource_setup_memory' function which is the main user
> of 'dma_alloc_coherent()', and inserting a WARN_ON() check to make future
> (and existing) bogus users of this function they're should provide a valid
> 'struct device' whenever possible.
> 
> Fixes: ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset")
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

I would have done two commits here, one to fix:

  dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);

and one to switch to the WARN_ON + if(dev) model. But I don't really
care either way, so:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Note that even with the if (dev) check, you don't avoid all possible
regressions. For example, some parts of the sh_eth driver were passing
a non-NULL struct device, but it was the wrong struct device (the one
inside struct net_device, and not the one part of struct
platform_device). I fixed that for sh_eth, but there could be other
drivers doing bogus things.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
