Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030583AbeCAMxF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 07:53:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:26017 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030504AbeCAMxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 07:53:03 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="179075660"
Date: Thu, 1 Mar 2018 18:26:49 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Sean Wang <sean.wang@mediatek.com>
Cc: dan.j.williams@intel.com, robh+dt@kernel.org, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v5 2/3] dmaengine: mediatek: Add MediaTek High-Speed DMA
 controller for MT7622 and MT7623 SoC
Message-ID: <20180301125649.GH15443@localhost>
References: <cover.1518857746.git.sean.wang@mediatek.com>
 <de4177cb2269c99f8d7c5738ac8a64f512122dfd.1518857747.git.sean.wang@mediatek.com>
 <20180301082329.GD15443@localhost>
 <1519900021.8089.136.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519900021.8089.136.camel@mtkswgap22>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 06:27:01PM +0800, Sean Wang wrote:
> On Thu, 2018-03-01 at 13:53 +0530, Vinod Koul wrote:
> > On Sun, Feb 18, 2018 at 03:08:30AM +0800, sean.wang@mediatek.com wrote:
> > 
> > > @@ -0,0 +1,1054 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > // Copyright ...
> > 
> > The copyright line needs to follow SPDX tag line
> > 
> 
> okay, I will make it reorder and be something like that
> 
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * Copyright (c) 2017-2018 MediaTek Inc.
>  * Author: Sean Wang <sean.wang@mediatek.com>
>  *
>  * Driver for MediaTek High-Speed DMA Controller
>  *
>  */

It needs to be:

// SPDX-License-Identifier: GPL-2.0
// Copyright (c) 2017-2018 MediaTek Inc.

/*
 * whatever else you want
 */

The first two lines are in C99 style comment and need to have SPDX tag and
Copyright info

> the point is I learned from other subsystem makes the driver name be
> same with the module name with KBUILD_MODNAME.
> 
> If you really don't like it, I can just change it into 
> 
> #define MTK_DMA_DEV "mtk-hsdma"

It is used only once, why not use KBUILD_MODNAME directly?

> 
> > > +
> > > +#define MTK_HSDMA_USEC_POLL		20
> > > +#define MTK_HSDMA_TIMEOUT_POLL		200000
> > > +#define MTK_HSDMA_DMA_BUSWIDTHS		BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED)
> > 
> > Undefined buswidth??

??

> > > +/**
> > > + * struct mtk_hsdma_pdesc - This is the struct holding info describing physical
> > > + *			    descriptor (PD) and its placement must be kept at
> > > + *			    4-bytes alignment in little endian order.
> > > + * @desc[1-4]:		    The control pad used to indicate hardware how to
> > 
> > pls align to 80char or lesser
> > 
> 
> weird, it seems the line is already with 80 char and pass the
> checkpatch.pl. or do I misunderstand something ?

Okay please check. With text it helps to wrap before that

> > > +	/*
> > > +	 * Updating into hardware the pointer of TX ring lets HSDMA to take
> > > +	 * action for those pending PDs.
> > > +	 */
> > > +	mtk_dma_write(hsdma, MTK_HSDMA_TX_CPU, ring->cur_tptr);
> > > +
> > > +	spin_unlock_irqrestore(&hsdma->lock, flags);
> > > +
> > > +	return !hvd->len ? 0 : -ENOSPC;
> > 
> > you already wrote and started txn, so why this?
> > 
> 
> it's possible just partial virtual descriptor fits into hardware and
> then return -ENOSPC. And it will start it to complete the remaining part
> as soon as possible when some rooms is being freed.

Either ways you have issued the descriptor, so you succeed right?

> > shouldn't we check if next is in range, we can crash if we get bad value
> > from hardware..
> 
> okay, there are checks for next with ddone bit check and null check in
> the corresponding descriptor as the following.

what if you get bad next value

> 
> > > +		rxd = &pc->ring.rxd[next];

resulting in bad ref here

-- 
~Vinod
