Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933011AbeEWNcO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932873AbeEWNcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:32:11 -0400
Date: Wed, 23 May 2018 19:02:06 +0530
From: Vinod <vkoul@kernel.org>
To: Robin Gong <yibin.gong@nxp.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v1] dmaengine: imx-sdma: add virt-dma support
Message-ID: <20180523133206.GJ20991@vkoul-mobl>
References: <1527003940-9473-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527003940-9473-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 23:45, Robin Gong wrote:
> The legacy sdma driver has below limitations or drawbacks:
>   1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
>      one page size for one channel regardless of only few BDs needed
>      most time. But in few cases, the max PAGE_SIZE maybe not enough.
>   2. One SDMA channel can't stop immediatley once channel disabled which

typo immediatley

>      means SDMA interrupt may come in after this channel terminated.There
>      are some patches for this corner case such as commit "2746e2c389f9",

Please add patch title along with commit id in logs

> +struct sdma_desc {
> +	struct virt_dma_desc	vd;
> +	struct list_head	node;
> +	unsigned int		num_bd;
> +	dma_addr_t		bd_phys;
> +	unsigned int		buf_tail;

what are these two used for?

>  static irqreturn_t sdma_int_handler(int irq, void *dev_id)
> @@ -785,13 +778,24 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
>  	while (stat) {
>  		int channel = fls(stat) - 1;
>  		struct sdma_channel *sdmac = &sdma->channel[channel];
> -
> -		if (sdmac->flags & IMX_DMA_SG_LOOP)
> -			sdma_update_channel_loop(sdmac);
> -		else
> -			tasklet_schedule(&sdmac->tasklet);
> +		struct sdma_desc *desc;
> +
> +		spin_lock(&sdmac->vc.lock);
> +		desc = sdmac->desc;
> +		if (desc) {
> +			if (sdmac->flags & IMX_DMA_SG_LOOP) {
> +				sdma_update_channel_loop(sdmac);

I guess loop is for cyclic case, are you not invoking vchan_cyclic_callback()
for that? I dont see this call in this patch although the driver supports
cyclic mode.

> +static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
> +				enum dma_transfer_direction direction, u32 bds)
> +{
> +	struct sdma_desc *desc;
> +
> +	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);

this is called from _prep_ so we are in non slpeepy context and would need to
use GFP_NOWAIT flag..

> @@ -1432,26 +1497,74 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
>  {
>  	struct sdma_channel *sdmac = to_sdma_chan(chan);
>  	u32 residue;
> +	struct virt_dma_desc *vd;
> +	struct sdma_desc *desc;
> +	enum dma_status ret;
> +	unsigned long flags;
>  
> -	if (sdmac->flags & IMX_DMA_SG_LOOP)
> -		residue = (sdmac->num_bd - sdmac->buf_ptail) *
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	if (ret == DMA_COMPLETE && txstate) {
> +		residue = sdmac->chn_count - sdmac->chn_real_count;

on DMA_COMPLETE reside is 0, so why this?

> +		return ret;
> +	}
> +
> +	spin_lock_irqsave(&sdmac->vc.lock, flags);
> +	vd = vchan_find_desc(&sdmac->vc, cookie);
> +	desc = to_sdma_desc(&vd->tx);
> +	if (vd) {
> +		if (sdmac->flags & IMX_DMA_SG_LOOP)
> +			residue = (desc->num_bd - desc->buf_ptail) *
>  			   sdmac->period_len - sdmac->chn_real_count;

you need to check which descriptor is the query for, current or queued.

> +static void sdma_start_desc(struct sdma_channel *sdmac)
> +{
> +	struct virt_dma_desc *vd = vchan_next_desc(&sdmac->vc);
> +	struct sdma_desc *desc;
> +	struct sdma_engine *sdma = sdmac->sdma;
> +	int channel = sdmac->channel;
> +
> +	if (!vd) {
> +		sdmac->desc = NULL;
> +		return;
> +	}
> +	sdmac->desc = desc = to_sdma_desc(&vd->tx);
> +	/*
> +	 * Do not delete the node in desc_issued list in cyclic mode, otherwise
> +	 * the desc alloced will never be freed in vchan_dma_desc_free_list

alloced .. you mean allocated?

-- 
~Vinod
