Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964882AbeCAITp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:19:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:1307 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934985AbeCAITn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:19:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,407,1515484800";
   d="scan'208";a="31578261"
Date: Thu, 1 Mar 2018 13:53:29 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: sean.wang@mediatek.com
Cc: dan.j.williams@intel.com, robh+dt@kernel.org, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v5 2/3] dmaengine: mediatek: Add MediaTek High-Speed DMA
 controller for MT7622 and MT7623 SoC
Message-ID: <20180301082329.GD15443@localhost>
References: <cover.1518857746.git.sean.wang@mediatek.com>
 <de4177cb2269c99f8d7c5738ac8a64f512122dfd.1518857747.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de4177cb2269c99f8d7c5738ac8a64f512122dfd.1518857747.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 03:08:30AM +0800, sean.wang@mediatek.com wrote:

> @@ -0,0 +1,1054 @@
> +// SPDX-License-Identifier: GPL-2.0
// Copyright ...

The copyright line needs to follow SPDX tag line

> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/refcount.h>
> +#include <linux/slab.h>

that's a lot of headers, do u need all those?

> +
> +#include "../virt-dma.h"
> +
> +#define MTK_DMA_DEV KBUILD_MODNAME

why do you need this?

> +
> +#define MTK_HSDMA_USEC_POLL		20
> +#define MTK_HSDMA_TIMEOUT_POLL		200000
> +#define MTK_HSDMA_DMA_BUSWIDTHS		BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED)

Undefined buswidth??

> +/**
> + * struct mtk_hsdma_pdesc - This is the struct holding info describing physical
> + *			    descriptor (PD) and its placement must be kept at
> + *			    4-bytes alignment in little endian order.
> + * @desc[1-4]:		    The control pad used to indicate hardware how to

pls align to 80char or lesser

> +/**
> + * struct mtk_hsdma_ring - This struct holds info describing underlying ring
> + *			   space
> + * @txd:		   The descriptor TX ring which describes DMA source
> + *			   information
> + * @rxd:		   The descriptor RX ring which describes DMA
> + *			   destination information
> + * @cb:			   The extra information pointed at by RX ring
> + * @tphys:		   The physical addr of TX ring
> + * @rphys:		   The physical addr of RX ring
> + * @cur_tptr:		   Pointer to the next free descriptor used by the host
> + * @cur_rptr:		   Pointer to the last done descriptor by the device

here alignment and 80 char wrap will help too and few other places...


> +struct mtk_hsdma_vchan {
> +	struct virt_dma_chan vc;
> +	struct completion issue_completion;
> +	bool issue_synchronize;
> +	/* protected by vc.lock */

this should be at comments above...

> +static struct mtk_hsdma_device *to_hsdma_dev(struct dma_chan *chan)
> +{
> +	return container_of(chan->device, struct mtk_hsdma_device,
> +			    ddev);

and this can fit in a line

> +static int mtk_hsdma_alloc_pchan(struct mtk_hsdma_device *hsdma,
> +				 struct mtk_hsdma_pchan *pc)
> +{
> +	struct mtk_hsdma_ring *ring = &pc->ring;
> +	int err;
> +
> +	memset(pc, 0, sizeof(*pc));
> +
> +	/*
> +	 * Allocate ring space where [0 ... MTK_DMA_SIZE - 1] is for TX ring
> +	 * and [MTK_DMA_SIZE ... 2 * MTK_DMA_SIZE - 1] is for RX ring.
> +	 */
> +	pc->sz_ring = 2 * MTK_DMA_SIZE * sizeof(*ring->txd);
> +	ring->txd = dma_zalloc_coherent(hsdma2dev(hsdma), pc->sz_ring,
> +					&ring->tphys, GFP_ATOMIC);

GFP_NOWAIT please

> +	if (!ring->txd)
> +		return -ENOMEM;
> +
> +	ring->rxd = &ring->txd[MTK_DMA_SIZE];
> +	ring->rphys = ring->tphys + MTK_DMA_SIZE * sizeof(*ring->txd);
> +	ring->cur_tptr = 0;
> +	ring->cur_rptr = MTK_DMA_SIZE - 1;
> +
> +	ring->cb = kcalloc(MTK_DMA_SIZE, sizeof(*ring->cb), GFP_KERNEL);

this is inconsistent with your own pattern! make it GFP_NOWAIT pls

> +static int mtk_hsdma_issue_pending_vdesc(struct mtk_hsdma_device *hsdma,
> +					 struct mtk_hsdma_pchan *pc,
> +					 struct mtk_hsdma_vdesc *hvd)
> +{
> +	struct mtk_hsdma_ring *ring = &pc->ring;
> +	struct mtk_hsdma_pdesc *txd, *rxd;
> +	u16 reserved, prev, tlen, num_sgs;
> +	unsigned long flags;
> +
> +	/* Protect against PC is accessed by multiple VCs simultaneously */
> +	spin_lock_irqsave(&hsdma->lock, flags);
> +
> +	/*
> +	 * Reserve rooms, where pc->nr_free is used to track how many free
> +	 * rooms in the ring being updated in user and IRQ context.
> +	 */
> +	num_sgs = DIV_ROUND_UP(hvd->len, MTK_HSDMA_MAX_LEN);
> +	reserved = min_t(u16, num_sgs, atomic_read(&pc->nr_free));
> +
> +	if (!reserved) {
> +		spin_unlock_irqrestore(&hsdma->lock, flags);
> +		return -ENOSPC;
> +	}
> +
> +	atomic_sub(reserved, &pc->nr_free);
> +
> +	while (reserved--) {
> +		/* Limit size by PD capability for valid data moving */
> +		tlen = (hvd->len > MTK_HSDMA_MAX_LEN) ?
> +		       MTK_HSDMA_MAX_LEN : hvd->len;
> +
> +		/*
> +		 * Setup PDs using the remaining VD info mapped on those
> +		 * reserved rooms. And since RXD is shared memory between the
> +		 * host and the device allocated by dma_alloc_coherent call,
> +		 * the helper macro WRITE_ONCE can ensure the data written to
> +		 * RAM would really happens.
> +		 */
> +		txd = &ring->txd[ring->cur_tptr];
> +		WRITE_ONCE(txd->desc1, hvd->src);
> +		WRITE_ONCE(txd->desc2,
> +			   hsdma->soc->ls0 | MTK_HSDMA_DESC_PLEN(tlen));
> +
> +		rxd = &ring->rxd[ring->cur_tptr];
> +		WRITE_ONCE(rxd->desc1, hvd->dest);
> +		WRITE_ONCE(rxd->desc2, MTK_HSDMA_DESC_PLEN(tlen));
> +
> +		/* Associate VD, the PD belonged to */
> +		ring->cb[ring->cur_tptr].vd = &hvd->vd;
> +
> +		/* Move forward the pointer of TX ring */
> +		ring->cur_tptr = MTK_HSDMA_NEXT_DESP_IDX(ring->cur_tptr,
> +							 MTK_DMA_SIZE);
> +
> +		/* Update VD with remaining data */
> +		hvd->src  += tlen;
> +		hvd->dest += tlen;
> +		hvd->len  -= tlen;
> +	}
> +
> +	/*
> +	 * Tagging flag for the last PD for VD will be responsible for
> +	 * completing VD.
> +	 */
> +	if (!hvd->len) {
> +		prev = MTK_HSDMA_LAST_DESP_IDX(ring->cur_tptr, MTK_DMA_SIZE);
> +		ring->cb[prev].flag = MTK_HSDMA_VDESC_FINISHED;
> +	}
> +
> +	/* Ensure all changes indeed done before we're going on */
> +	wmb();
> +
> +	/*
> +	 * Updating into hardware the pointer of TX ring lets HSDMA to take
> +	 * action for those pending PDs.
> +	 */
> +	mtk_dma_write(hsdma, MTK_HSDMA_TX_CPU, ring->cur_tptr);
> +
> +	spin_unlock_irqrestore(&hsdma->lock, flags);
> +
> +	return !hvd->len ? 0 : -ENOSPC;

you already wrote and started txn, so why this?

> +static void mtk_hsdma_free_rooms_in_ring(struct mtk_hsdma_device *hsdma)
> +{
> +	struct mtk_hsdma_vchan *hvc;
> +	struct mtk_hsdma_pdesc *rxd;
> +	struct mtk_hsdma_vdesc *hvd;
> +	struct mtk_hsdma_pchan *pc;
> +	struct mtk_hsdma_cb *cb;
> +	__le32 desc2;
> +	u32 status;
> +	u16 next;
> +	int i;
> +
> +	pc = hsdma->pc;
> +
> +	/* Read IRQ status */
> +	status = mtk_dma_read(hsdma, MTK_HSDMA_INT_STATUS);
> +
> +	/*
> +	 * Ack the pending IRQ all to let hardware know software is handling
> +	 * those finished physical descriptors. Otherwise, the hardware would
> +	 * keep the used IRQ line in certain trigger state.
> +	 */
> +	mtk_dma_write(hsdma, MTK_HSDMA_INT_STATUS, status);
> +
> +	while (1) {
> +		next = MTK_HSDMA_NEXT_DESP_IDX(pc->ring.cur_rptr,
> +					       MTK_DMA_SIZE);

shouldn't we check if next is in range, we can crash if we get bad value
from hardware..

> +		rxd = &pc->ring.rxd[next];
> +
> +		/*
> +		 * If MTK_HSDMA_DESC_DDONE is no specified, that means data
> +		 * moving for the PD is still under going.
> +		 */
> +		desc2 = READ_ONCE(rxd->desc2);
> +		if (!(desc2 & hsdma->soc->ddone))
> +			break;

okay this is one break

> +
> +		cb = &pc->ring.cb[next];
> +		if (unlikely(!cb->vd)) {
> +			dev_err(hsdma2dev(hsdma), "cb->vd cannot be null\n");
> +			break;

and other for null, i feel we need to have checks for while(1) to break,
this can run infinitely if something bad happens, a fail safe would be good,
that too this being invoked from isr.

> +static enum dma_status mtk_hsdma_tx_status(struct dma_chan *c,
> +					   dma_cookie_t cookie,
> +					   struct dma_tx_state *txstate)
> +{
> +	struct mtk_hsdma_vchan *hvc = to_hsdma_vchan(c);
> +	struct mtk_hsdma_vdesc *hvd;
> +	struct virt_dma_desc *vd;
> +	enum dma_status ret;
> +	unsigned long flags;
> +	size_t bytes = 0;
> +
> +	ret = dma_cookie_status(c, cookie, txstate);
> +	if (ret == DMA_COMPLETE || !txstate)
> +		return ret;
> +
> +	spin_lock_irqsave(&hvc->vc.lock, flags);
> +	vd = mtk_hsdma_find_active_desc(c, cookie);
> +	spin_unlock_irqrestore(&hvc->vc.lock, flags);
> +
> +	if (vd) {
> +		hvd = to_hsdma_vdesc(vd);
> +		bytes = hvd->residue;

for active descriptor, shouldn't you read counters from hardware?

> +static struct dma_async_tx_descriptor *
> +mtk_hsdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest,
> +			  dma_addr_t src, size_t len, unsigned long flags)
> +{
> +	struct mtk_hsdma_vdesc *hvd;
> +
> +	hvd = kzalloc(sizeof(*hvd), GFP_NOWAIT);

GFP_NOWAIT here too

> +static int mtk_hsdma_terminate_all(struct dma_chan *c)
> +{
> +	mtk_hsdma_free_inactive_desc(c, false);

only inactive, active ones need to be freed and channel cleaned

-- 
~Vinod
