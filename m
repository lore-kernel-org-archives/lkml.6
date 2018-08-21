Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FD7217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtQC8INI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FD7217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeHUTH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbeHUTH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:07:26 -0400
Received: from localhost (unknown [171.76.73.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E3CE20685;
        Tue, 21 Aug 2018 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534866405;
        bh=kqzdQjcsV3Ay3hB4330X1t0ApyT9w62rrh8wRN2bmeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtQC8INI9gaTy63cn6e8h1oeI4yvffYxaNrxD3meip41fJpbgv7UjgTQ6bQSqWUMl
         DsVvf3ApaZ43Q3C8W3Slyi8nAec5ZgsiduRJJZJCbJNqzuROxNMSZambbEZco9UWtd
         HEUyy+XppLLn6DTPZC3bXP5r0A1JI5DtTSNIgd3I=
Date:   Tue, 21 Aug 2018 21:16:35 +0530
From:   Vinod <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        dan.j.williams@intel.com, appanad@xilinx.com, lars@metafoo.de,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] dmaengine: xilinx_dma: Add Xilinx AXI MCDMA
 Engine driver support
Message-ID: <20180821154635.GG2388@vkoul-mobl>
References: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1533059173-21405-3-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533059173-21405-3-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-07-18, 23:16, Radhey Shyam Pandey wrote:
>  struct xilinx_dma_config {
> @@ -402,6 +470,7 @@ struct xilinx_dma_config {
>  	int (*clk_init)(struct platform_device *pdev, struct clk **axi_clk,
>  			struct clk **tx_clk, struct clk **txs_clk,
>  			struct clk **rx_clk, struct clk **rxs_clk);
> +	irqreturn_t (*irq_handler)(int irq, void *data);

this sounds like a preparatory change?

> +	} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
> +		/* Allocate the buffer descriptors. */
> +		chan->seg_mv = dma_zalloc_coherent(chan->dev,
> +						  sizeof(*chan->seg_mv) *
> +						  XILINX_DMA_NUM_DESCS,
> +						  &chan->seg_p, GFP_KERNEL);
> +		if (!chan->seg_mv) {
> +			dev_err(chan->dev,
> +				"unable to allocate channel %d descriptors\n",
> +				chan->id);
> +			return -ENOMEM;
> +		}
> +		for (i = 0; i < XILINX_DMA_NUM_DESCS; i++) {
> +			chan->seg_mv[i].hw.next_desc =
> +			lower_32_bits(chan->seg_p + sizeof(*chan->seg_mv) *
> +				((i + 1) % XILINX_DMA_NUM_DESCS));
> +			chan->seg_mv[i].hw.next_desc_msb =
> +			upper_32_bits(chan->seg_p + sizeof(*chan->seg_mv) *
> +				((i + 1) % XILINX_DMA_NUM_DESCS));
> +			chan->seg_mv[i].phys = chan->seg_p +
> +				sizeof(*chan->seg_v) * i;
> +			list_add_tail(&chan->seg_mv[i].node,
> +				      &chan->free_seg_list);
> +		}

only change with this and previous one seems to be use of seg_mv instead
of seg_v right? if so, can you try to modularise this..

>  /**
> + * xilinx_mcdma_start_transfer - Starts MCDMA transfer
> + * @chan: Driver specific channel struct pointer
> + */
> +static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
> +{
> +	struct xilinx_dma_tx_descriptor *head_desc, *tail_desc;
> +	struct xilinx_axidma_tx_segment *tail_segment;
> +	u32 reg;
> +
> +	if (chan->err)
> +		return;
> +
> +	if (!chan->idle)
> +		return;
> +
> +	if (list_empty(&chan->pending_list))
> +		return;

okay i was thinking that we need lock here, but then this is called with
lock held, worth mentioning in the comment though..

> +static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
> +{
> +	struct xilinx_dma_chan *chan = data;
> +	u32 status, ser_offset, chan_sermask, chan_offset = 0, chan_id;
> +
> +	if (chan->direction == DMA_DEV_TO_MEM)
> +		ser_offset = XILINX_MCDMA_RXINT_SER_OFFSET;
> +	else
> +		ser_offset = XILINX_MCDMA_TXINT_SER_OFFSET;
> +
> +	/* Read the channel id raising the interrupt*/
> +	chan_sermask = dma_ctrl_read(chan, ser_offset);
> +	chan_id = ffs(chan_sermask);
> +
> +	if (!chan_id)
> +		return IRQ_NONE;
> +
> +	if (chan->direction == DMA_DEV_TO_MEM)
> +		chan_offset = XILINX_DMA_MAX_CHANS_PER_DEVICE / 2;
> +
> +	chan_offset = chan_offset + (chan_id - 1);
> +	chan = chan->xdev->chan[chan_offset];
> +	/* Read the status and ack the interrupts. */
> +	status = dma_ctrl_read(chan, XILINX_MCDMA_CHAN_SR_OFFSET(chan->tdest));
> +	if (!(status & XILINX_MCDMA_IRQ_ALL_MASK))
> +		return IRQ_NONE;
> +
> +	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_SR_OFFSET(chan->tdest),
> +		       status & XILINX_MCDMA_IRQ_ALL_MASK);
> +
> +	if (status & XILINX_MCDMA_IRQ_ERR_MASK) {
> +		dev_err(chan->dev, "Channel %p has errors %x cdr %x tdr %x\n",
> +			chan, dma_ctrl_read(chan,
> +			XILINX_MCDMA_CH_ERR_OFFSET), dma_ctrl_read(chan,
> +			XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest)),
> +			dma_ctrl_read(chan,
> +				      XILINX_MCDMA_CHAN_TDESC_OFFSET
> +				      (chan->tdest)));

this looks very hard to read, please start each dma_ctrl_read() from a
new line to make it better

> +		chan->err = true;
> +	}
> +
> +	if (status & XILINX_MCDMA_IRQ_DELAY_MASK) {
> +		/*
> +		 * Device takes too long to do the transfer when user requires
> +		 * responsiveness.
> +		 */
> +		dev_dbg(chan->dev, "Inter-packet latency too long\n");

so we just log it..?

> +	}
> +
> +	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
> +		spin_lock(&chan->lock);
> +		xilinx_dma_complete_descriptor(chan);
> +		chan->idle = true;
> +		chan->start_transfer(chan);
> +		spin_unlock(&chan->lock);
> +	}
> +
> +	tasklet_schedule(&chan->tasklet);
> +	return IRQ_HANDLED;
> +

bogus empty line...

> +static struct dma_async_tx_descriptor *xilinx_mcdma_prep_slave_sg(
> +	struct dma_chan *dchan, struct scatterlist *sgl, unsigned int sg_len,
> +	enum dma_transfer_direction direction, unsigned long flags,
> +	void *context)

indent is pretty bad here too :(

> +{
> +	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> +	struct xilinx_dma_tx_descriptor *desc;
> +	struct xilinx_aximcdma_tx_segment *segment = NULL;
> +	u32 *app_w = (u32 *)context;
> +	struct scatterlist *sg;
> +	size_t copy;
> +	size_t sg_used;
> +	unsigned int i;
> +
> +	if (!is_slave_direction(direction))
> +		return NULL;
> +
> +	/* Allocate a transaction descriptor. */
> +	desc = xilinx_dma_alloc_tx_descriptor(chan);
> +	if (!desc)
> +		return NULL;
> +
> +	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> +	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
> +
> +	/* Build transactions using information in the scatter gather list */
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		sg_used = 0;
> +
> +		/* Loop until the entire scatterlist entry is used */
> +		while (sg_used < sg_dma_len(sg)) {
> +			struct xilinx_aximcdma_desc_hw *hw;
> +
> +			/* Get a free segment */
> +			segment = xilinx_aximcdma_alloc_tx_segment(chan);
> +			if (!segment)
> +				goto error;
> +
> +			/*
> +			 * Calculate the maximum number of bytes to transfer,
> +			 * making sure it is less than the hw limit
> +			 */
> +			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
> +				     XILINX_DMA_MAX_TRANS_LEN);
> +			hw = &segment->hw;
> +
> +			/* Fill in the descriptor */
> +			xilinx_aximcdma_buf(chan, hw, sg_dma_address(sg),
> +					    sg_used);
> +			hw->control = copy;
> +
> +			if (chan->direction == DMA_MEM_TO_DEV) {
> +				if (app_w)

why not make condition as: chan->direction == DMA_MEM_TO_DEV && app_w

> +					memcpy(hw->app, app_w, sizeof(u32) *
> +					       XILINX_DMA_NUM_APP_WORDS);
> +			}
> +
> +			sg_used += copy;
> +			/*
> +			 * Insert the segment into the descriptor segments
> +			 * list.
> +			 */
> +			list_add_tail(&segment->node, &desc->segments);
> +		}
> +	}
> +
> +	segment = list_first_entry(&desc->segments,
> +				   struct xilinx_aximcdma_tx_segment, node);
> +	desc->async_tx.phys = segment->phys;
> +
> +	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
> +	if (chan->direction == DMA_MEM_TO_DEV) {
> +		segment->hw.control |= XILINX_MCDMA_BD_SOP;
> +		segment = list_last_entry(&desc->segments,
> +					  struct xilinx_aximcdma_tx_segment,
> +					  node);
> +		segment->hw.control |= XILINX_MCDMA_BD_EOP;
> +	}
> +
> +	return &desc->async_tx;
> +
> +error:
> +	xilinx_dma_free_tx_descriptor(chan, desc);

will it free the ones allocated here or all descriptors?

>  /**
>   * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
> @@ -2422,12 +2827,16 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  
>  	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
>  	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
> -	    of_device_is_compatible(node, "xlnx,axi-cdma-channel")) {
> +	    of_device_is_compatible(node, "xlnx,axi-cdma-channel") ||
> +	    of_device_is_compatible(node, "xlnx,axi-mcdma-mm2s-channel")) {

this is not scaling, maybe you should use data with each
compatible to check for specific things..

> +static const struct xilinx_dma_config aximcdma_config = {
> +	.dmatype = XDMA_TYPE_AXIMCDMA,
> +	.clk_init = axidma_clk_init,
> +	.irq_handler = xilinx_mcdma_irq_handler,
> +};
>  static const struct xilinx_dma_config axicdma_config = {
>  	.dmatype = XDMA_TYPE_CDMA,
>  	.clk_init = axicdma_clk_init,
> +	.irq_handler = xilinx_dma_irq_handler,

this should be in preparatory patch
-- 
~Vinod
