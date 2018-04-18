Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeDRKrU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:47:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeDRKrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:47:18 -0400
Date: Wed, 18 Apr 2018 03:47:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
        thomas.petazzoni@free-electrons.com, robin.murphy@arm.com,
        geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
Message-ID: <20180418104703.GA12462@infradead.org>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 03:35:23PM +0200, Jacopo Mondi wrote:
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

Please fix those callers to not pass a NULL pointer instead.
