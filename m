Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeEBJQv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:16:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42108 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751076AbeEBJQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:16:47 -0400
Date: Wed, 2 May 2018 11:16:35 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2] mtd: onenand: omap2: Disable DMA for HIGHMEM buffers
Message-ID: <20180502111635.689397fc@bbrezillon>
In-Reply-To: <20180502080636.GA2124@lenoch>
References: <20180416065256.GA24455@lenoch>
        <20180420220134.3021860f@bbrezillon>
        <20180502080636.GA2124@lenoch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018 10:06:36 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> Hi Boris,
> 
> (and apologies for delay)
> 
> On Fri, Apr 20, 2018 at 10:01:34PM +0200, Boris Brezillon wrote:
> > Hi Ladislav,
> > 
> > On Mon, 16 Apr 2018 08:52:59 +0200
> > Ladislav Michl <ladis@linux-mips.org> wrote:
> >   
> > > dma_map_single doesn't get the proper DMA address for vmalloced area,  
> > 
> > That's not true, it returns the right DMA (physical) address, it's just
> > that:  
> 
> To be honest I used log message from commit dcf08227e964 which is dealing
> with the same issue.

Okay, looks like I was wrong. The problem is caused by the
virt_to_page() call done in dma_map_single_attrs() which expects a
valid virtual address (one that is present in the identity mapping). If
you pass a vmalloc address to it, the conversion is broken and that's
probably why you end up with a NULL pointer exception.

Maybe you should just say that dma_map_single() does not work for
vmalloc-ed buffers instead of saying that it does not get the right DMA
address.
