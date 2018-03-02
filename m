Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163907AbeCBGr7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 01:47:59 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:28971 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S935863AbeCBGr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 01:47:57 -0500
X-UUID: ba102993478f40ecb36aad222d88a6f3-20180302
Message-ID: <1519973271.8089.166.camel@mtkswgap22>
Subject: Re: [PATCH v5 2/3] dmaengine: mediatek: Add MediaTek High-Speed DMA
 controller for MT7622 and MT7623 SoC
From: Sean Wang <sean.wang@mediatek.com>
To: Vinod Koul <vinod.koul@intel.com>
CC: <dan.j.williams@intel.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Date: Fri, 2 Mar 2018 14:47:51 +0800
In-Reply-To: <20180301125649.GH15443@localhost>
References: <cover.1518857746.git.sean.wang@mediatek.com>
         <de4177cb2269c99f8d7c5738ac8a64f512122dfd.1518857747.git.sean.wang@mediatek.com>
         <20180301082329.GD15443@localhost> <1519900021.8089.136.camel@mtkswgap22>
         <20180301125649.GH15443@localhost>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vinod

On Thu, 2018-03-01 at 18:26 +0530, Vinod Koul wrote:
> On Thu, Mar 01, 2018 at 06:27:01PM +0800, Sean Wang wrote:
> > On Thu, 2018-03-01 at 13:53 +0530, Vinod Koul wrote:
> > > On Sun, Feb 18, 2018 at 03:08:30AM +0800, sean.wang@mediatek.com wrote:
> > > 
> > > > @@ -0,0 +1,1054 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > // Copyright ...
> > > 
> > > The copyright line needs to follow SPDX tag line
> > > 
> > 
> > okay, I will make it reorder and be something like that
> > 
> > // SPDX-License-Identifier: GPL-2.0
> > /*
> >  * Copyright (c) 2017-2018 MediaTek Inc.
> >  * Author: Sean Wang <sean.wang@mediatek.com>
> >  *
> >  * Driver for MediaTek High-Speed DMA Controller
> >  *
> >  */
> 
> It needs to be:
> 
> // SPDX-License-Identifier: GPL-2.0
> // Copyright (c) 2017-2018 MediaTek Inc.
> 
> /*
>  * whatever else you want
>  */
> 
> The first two lines are in C99 style comment and need to have SPDX tag and
> Copyright info

Sure, I can do it using C99 style comments at the first two lines.

In addition, I'm really curious where we can find a reference to the
rule and if it 's a strict rule for all the drivers.

Because I'm considering whether I should turn other driver into using
the same rule.

> > the point is I learned from other subsystem makes the driver name be
> > same with the module name with KBUILD_MODNAME.
> > 
> > If you really don't like it, I can just change it into 
> > 
> > #define MTK_DMA_DEV "mtk-hsdma"
> 
> It is used only once, why not use KBUILD_MODNAME directly?
> 

Yup, it can use KBUILD_MODNAME directly.

> > 
> > > > +
> > > > +#define MTK_HSDMA_USEC_POLL		20
> > > > +#define MTK_HSDMA_TIMEOUT_POLL		200000
> > > > +#define MTK_HSDMA_DMA_BUSWIDTHS		BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED)
> > > 
> > > Undefined buswidth??
> 
> ??

Sorry for I didn't answer the question in the short time.

After spending some time on a confirmation with design, it is
DMA_SLAVE_BUSWIDTH_4_BYTES and not be configurable. 

> 
> > > > +/**
> > > > + * struct mtk_hsdma_pdesc - This is the struct holding info describing physical
> > > > + *			    descriptor (PD) and its placement must be kept at
> > > > + *			    4-bytes alignment in little endian order.
> > > > + * @desc[1-4]:		    The control pad used to indicate hardware how to
> > > 
> > > pls align to 80char or lesser
> > > 
> > 
> > weird, it seems the line is already with 80 char and pass the
> > checkpatch.pl. or do I misunderstand something ?
> 
> Okay please check. With text it helps to wrap before that
> 

After check again, these lines are all already aligned to 80 chars

> > > > +	/*
> > > > +	 * Updating into hardware the pointer of TX ring lets HSDMA to take
> > > > +	 * action for those pending PDs.
> > > > +	 */
> > > > +	mtk_dma_write(hsdma, MTK_HSDMA_TX_CPU, ring->cur_tptr);
> > > > +
> > > > +	spin_unlock_irqrestore(&hsdma->lock, flags);
> > > > +
> > > > +	return !hvd->len ? 0 : -ENOSPC;
> > > 
> > > you already wrote and started txn, so why this?
> > > 
> > 
> > it's possible just partial virtual descriptor fits into hardware and
> > then return -ENOSPC. And it will start it to complete the remaining part
> > as soon as possible when some rooms is being freed.
> 
> Either ways you have issued the descriptor, so you succeed right?
> 

I think I should get your points.

I guessed what you meant is that it should be returning 0 instead of
-ENOSPC for all successful descriptor issuing either in part or in full

I will refine this flow based on the thought.

> > > shouldn't we check if next is in range, we can crash if we get bad value
> > > from hardware..
> > 
> > okay, there are checks for next with ddone bit check and null check in
> > the corresponding descriptor as the following.
> 
> what if you get bad next value
> 

next is not hardware value. it's maintained by software which is always
between 0 to MTK_DMA_SIZE - 1, and definitely doesn't get a bad value.

> > 
> > > > +		rxd = &pc->ring.rxd[next];
> 
> resulting in bad ref here

rxd is also definitely a good ref


> 
