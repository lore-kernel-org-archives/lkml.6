Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934636AbeCBX26 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:28:58 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:33576 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934230AbeCBX24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:28:56 -0500
Date: Sat, 3 Mar 2018 00:28:53 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: David Miller <davem@davemloft.net>
Cc: pavel@ucw.cz, peppe.cavallaro@st.com, alexandre.torgue@st.com,
        Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: stmmac: use correct barrier between
 coherent memory and MMIO
Message-ID: <20180302232853.GA11108@axis.com>
References: <20180226214709.4359-1-niklas.cassel@axis.com>
 <20180226214709.4359-3-niklas.cassel@axis.com>
 <20180302091959.GC15948@amd>
 <20180302.095411.1270630534912987342.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302.095411.1270630534912987342.davem@davemloft.net>
User-Agent: Mutt/1.9.1+16 (8a41d1c2f267) (2017-09-22)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 09:54:11AM -0500, David Miller wrote:
> From: Pavel Machek <pavel@ucw.cz>
> Date: Fri, 2 Mar 2018 10:20:00 +0100
>

Hello Pavel, David

> >> This barrier cannot be a simple dma_wmb(), since a dma_wmb() is only
> >> used to guarantee the ordering, with respect to other writes,
> >> to cache coherent DMA memory.
> > 
> > Could you explain this a bit more (and perhaps in code comment)?

Have a look at:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/memory-barriers.txt?h=v4.16-rc1#n1913

AFAICT, a dma_wmb() can only be used to guarantee that the
writes to cache coherent memory (e.g. memory allocated with
dma_alloc_coherent()) before the dma_wmb() will be performed
before the writes to cache coherent memory after the dma_wmb().

Since most of our writes are simply writing new buffer addresses
and sizes to TDES0/TDES1/TDES2/TDES3, and since these TX DMA
descriptors have been allocated with dma_alloc_coherent(),
a dma_wmb() should be enough to e.g. make sure that TDES3
(which contains the OWN bit), is written after the writes to
TDES0/TDES1/TDES2.

However, the last write we do is "DMA start transmission",
this is a register in the IP, i.e. it is a write to the cache
incoherent MMIO region (rather than a write to cache coherent memory).
To ensure that all writes to cache coherent memory have
completed before we start the DMA, we have to use the barrier
wmb() (which performs a more extensive flush compared to
dma_wmb()).

So the only place where we have to use a wmb() instead
of a dma_wmb() is where we have a write to coherent memory,
followed by a write to cache incoherent MMIO.
The only obvious place where we have this situtation is
where we write the OWN bit immediately followed by a write
to the "DMA start transmission" register.

Note that this also matches how it's done in other other drivers:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/amd/xgbe/xgbe-dev.c?h=v4.16-rc1#n1638

There is already a comment describing the barrier in
stmmac_xmit() and stmmac_tso_xmit() that says:
/* The own bit must be the latest setting done when prepare the
 * descriptor and then barrier is needed to make sure that
 * all is coherent before granting the DMA engine.
 */
However, if you want, we could mention wmb() explicitly in this comment.

> > 
> > Ensuring other writes are done before writing the "GO!" bit should be
> > enough, no?
> 
> Indeed, the chip should never look at the descriptor contents unless
> the GO bit is set.
> 
> If there are ways that it can, this must be explained and documented
> since it is quite unusual compared to other hardware.
> 
> > (If it is not, do we need heavier barriers in other places, too?)
> 
> Right.

I hope that my explaination above has cleared any potential confusion.


Best regards,
Niklas
