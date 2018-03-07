Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754585AbeCGRWD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:22:03 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:52458 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeCGRWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:22:00 -0500
Date: Wed, 7 Mar 2018 18:21:57 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: David Miller <davem@davemloft.net>
Cc: pavel@ucw.cz, peppe.cavallaro@st.com, alexandre.torgue@st.com,
        Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: stmmac: use correct barrier between
 coherent memory and MMIO
Message-ID: <20180307172157.GA22658@axis.com>
References: <20180302091959.GC15948@amd>
 <20180302.095411.1270630534912987342.davem@davemloft.net>
 <20180302232853.GA11108@axis.com>
 <20180307.103226.1538176953286317879.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307.103226.1538176953286317879.davem@davemloft.net>
User-Agent: Mutt/1.9.1+16 (8a41d1c2f267) (2017-09-22)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 10:32:26AM -0500, David Miller wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> Date: Sat, 3 Mar 2018 00:28:53 +0100
> 
> > However, the last write we do is "DMA start transmission",
> > this is a register in the IP, i.e. it is a write to the cache
> > incoherent MMIO region (rather than a write to cache coherent memory).
> > To ensure that all writes to cache coherent memory have
> > completed before we start the DMA, we have to use the barrier
> > wmb() (which performs a more extensive flush compared to
> > dma_wmb()).
> 
> The is an implicit memory barrier between physical memory writes
> and those to MMIO register space.
> 
> So as long as you place the dma_wmb() to ensure the correct
> ordering within the descriptor words, you need nothing else
> after the last descriptor word write.

Hello David,

Looking at writel() in e.g. arch/arm/include/asm/io.h:
#define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
it indeed has a __iowmb() (which is defined as a wmb()) in its definition.

Is is safe to assume that this is true for all archs?

If so, perhaps the example at:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/memory-barriers.txt?h=v4.16-rc1#n1913
Should be updated.

Considering this, you can drop/revert:
95eb930a40a0 ("net: stmmac: use correct barrier between coherent memory and MMIO")
or perhaps you want me to send a revert?

After reverting 95eb930a40a0, we will still have a dma_wmb() _after_ the
last descriptor word write. You just explained that nothing else is needed
after the last descriptor word write, so I actually think that this last
barrier is superfluous.


Best regards,
Niklas
