Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeDKI14 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:27:56 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:56560 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeDKI1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:27:51 -0400
Date: Wed, 11 Apr 2018 10:27:46 +0200
From: Ladislav Michl <ladis@linux-mips.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Andreas Kemnade <andreas@kemnade.info>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: Re: [Letux-kernel] [Bug]: mtd: onenand: omap2plus: kernel panic with
 OneNAND on OMAP3 (DM3730) device GTA04A5
Message-ID: <20180411082746.GA20164@lenoch>
References: <5D496D5C-4E3E-47B4-9981-E8F4C348DE00@goldelico.com>
 <20180410205643.GA2228@lenoch>
 <20180411065836.7e1bfc3f@aktux>
 <20180411062607.GA9179@lenoch>
 <20180411091528.4e954c32@bbrezillon>
 <20180411073655.GA18273@lenoch>
 <20180411100806.3c09bafc@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411100806.3c09bafc@bbrezillon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 10:08:06AM +0200, Boris Brezillon wrote:
> On Wed, 11 Apr 2018 09:36:56 +0200
> Ladislav Michl <ladis@linux-mips.org> wrote:
> 
> > Hi Boris,
> > 
> > On Wed, Apr 11, 2018 at 09:15:28AM +0200, Boris Brezillon wrote:
[...]
> > > Not sure this approach is safe on all archs: if the cache is VIVT or
> > > VIPT, you may have several entries pointing to the same phys page, and
> > > then, when dma_map_page() does its cache maintenance operations, it's
> > > only taking one of these entries into account.  
> > 
> > Hmm, I used the same approach Samsung OneNAND driver does since commit
> > dcf08227e964a53a2cb39130b74842c7dcb6adde.
> > Both TI OMAP3630 and Samsung S5PC110 are using Cortex-A8 which
> > is VIPT. In that case samsung's driver code has the same problem.
> > 
> > > In other parts of the MTD subsystem, we tend to not do DMA on buffers
> > > that have been vmalloc-ed.
> > > 
> > > You can do something like
> > > 
> > > 		if (virt_addr_valid(buf))
> > > 			/* Use DMA */
> > > 		else
> > > 			/*
> > > 			 * Do not use DMA, or use a bounce buffer
> > > 			 * allocated with kmalloc
> > > 			 */  
> > 
> > Okay, I'll use this approach then, but first I'd like to be sure above is
> > correct. Anyone?
> 
> See this discussion [1]. The problem came up a few times already, so
> might find other threads describing why it's not safe.
> 
> [1]https://lists.linuxfoundation.org/pipermail/iommu/2016-March/016240.html

Question was more likely whenever there might exist more that one mapping
of the same page. But okay, I'll disable DMA for highmem. Patch will follow.

	ladis
