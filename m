Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D35AC00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C445221479
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhs/Ry4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C445221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeJGXIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 19:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeJGXIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 19:08:25 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 002AA2088F;
        Sun,  7 Oct 2018 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538928041;
        bh=bKCthfdy6p/TjNlFGrnHkNR158bS6uVnjecGvAg4y3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhs/Ry4Rf4JKXCQy8wj2Q6ChqZHSxecV7LTzOXgP56oPq6zEuVtY3Ha2SPwWkPGnQ
         z/aaerrAijlB+5vaWRuGbnHx4XHNleZMZDWMoZ4iGiAEfwLtLeXe2HyejsxuxZB6iN
         ljnfkqUL+FgsJ0g+FAk5SZztFEcjNdRGSP63TrEk=
Date:   Sun, 7 Oct 2018 21:30:30 +0530
From:   Vinod <vkoul@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] dmaengine: stm32-dma: Add DMA/MDMA chaining
 support
Message-ID: <20181007160030.GB2372@vkoul-mobl>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-5-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538139715-24406-5-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-18, 15:01, Pierre-Yves MORDRET wrote:
> This patch adds support of DMA/MDMA chaining support.
> It introduces an intermediate transfer between peripherals and STM32 DMA.
> This intermediate transfer is triggered by SW for single M2D transfer and
> by STM32 DMA IP for all other modes (sg, cyclic) and direction (D2M).
> 
> A generic SRAM allocator is used for this intermediate buffer
> Each DMA channel will be able to define its SRAM needs to achieve chaining
> feature : (2 ^ order) * PAGE_SIZE.
> For cyclic, SRAM buffer is derived from period length (rounded on
> PAGE_SIZE).

So IIUC, you chain two dma txns together and transfer data via an SRAM?

> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v3:
>        * Solve KBuild warning
>     v2:
>     v1:
>        * Initial
> ---
> ---
>  drivers/dma/stm32-dma.c | 879 ++++++++++++++++++++++++++++++++++++++++++------

that is a lot of change for a driver, consider splitting it up
logically in smaller changes...

>  1 file changed, 772 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
> index 379e8d5..85e81c4 100644
> --- a/drivers/dma/stm32-dma.c
> +++ b/drivers/dma/stm32-dma.c
> @@ -15,11 +15,14 @@
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> +#include <linux/genalloc.h>
>  #include <linux/init.h>
> +#include <linux/iopoll.h>
>  #include <linux/jiffies.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_dma.h>
>  #include <linux/platform_device.h>
> @@ -118,6 +121,7 @@
>  #define STM32_DMA_FIFO_THRESHOLD_FULL			0x03
>  
>  #define STM32_DMA_MAX_DATA_ITEMS	0xffff
> +#define STM32_DMA_SRAM_GRANULARITY	PAGE_SIZE
>  /*
>   * Valid transfer starts from @0 to @0xFFFE leading to unaligned scatter
>   * gather at boundary. Thus it's safer to round down this value on FIFO
> @@ -135,6 +139,12 @@
>  /* DMA Features */
>  #define STM32_DMA_THRESHOLD_FTR_MASK	GENMASK(1, 0)
>  #define STM32_DMA_THRESHOLD_FTR_GET(n)	((n) & STM32_DMA_THRESHOLD_FTR_MASK)
> +#define STM32_DMA_MDMA_CHAIN_FTR_MASK	BIT(2)
> +#define STM32_DMA_MDMA_CHAIN_FTR_GET(n)	(((n) & STM32_DMA_MDMA_CHAIN_FTR_MASK) \
> +					 >> 2)
> +#define STM32_DMA_MDMA_SRAM_SIZE_MASK	GENMASK(4, 3)
> +#define STM32_DMA_MDMA_SRAM_SIZE_GET(n)	(((n) & STM32_DMA_MDMA_SRAM_SIZE_MASK) \
> +					 >> 3)
>  
>  enum stm32_dma_width {
>  	STM32_DMA_BYTE,
> @@ -176,15 +186,31 @@ struct stm32_dma_chan_reg {
>  	u32 dma_sfcr;
>  };
>  
> +struct stm32_dma_mdma_desc {
> +	struct sg_table sgt;
> +	struct dma_async_tx_descriptor *desc;
> +};
> +
> +struct stm32_dma_mdma {
> +	struct dma_chan *chan;
> +	enum dma_transfer_direction dir;
> +	dma_addr_t sram_buf;
> +	u32 sram_period;
> +	u32 num_sgs;
> +};
> +
>  struct stm32_dma_sg_req {
> -	u32 len;
> +	struct scatterlist stm32_sgl_req;
>  	struct stm32_dma_chan_reg chan_reg;
> +	struct stm32_dma_mdma_desc m_desc;
>  };
>  
>  struct stm32_dma_desc {
>  	struct virt_dma_desc vdesc;
>  	bool cyclic;
>  	u32 num_sgs;
> +	dma_addr_t dma_buf;
> +	void *dma_buf_cpu;
>  	struct stm32_dma_sg_req sg_req[];
>  };
>  
> @@ -201,6 +227,10 @@ struct stm32_dma_chan {
>  	u32 threshold;
>  	u32 mem_burst;
>  	u32 mem_width;
> +	struct stm32_dma_mdma mchan;
> +	u32 use_mdma;
> +	u32 sram_size;
> +	u32 residue_after_drain;
>  };
>  
>  struct stm32_dma_device {
> @@ -210,6 +240,7 @@ struct stm32_dma_device {
>  	struct reset_control *rst;
>  	bool mem2mem;
>  	struct stm32_dma_chan chan[STM32_DMA_MAX_CHANNELS];
> +	struct gen_pool *sram_pool;
>  };
>  
>  static struct stm32_dma_device *stm32_dma_get_dev(struct stm32_dma_chan *chan)
> @@ -497,11 +528,15 @@ static void stm32_dma_stop(struct stm32_dma_chan *chan)
>  static int stm32_dma_terminate_all(struct dma_chan *c)
>  {
>  	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
> +	struct stm32_dma_mdma *mchan = &chan->mchan;
>  	unsigned long flags;
>  	LIST_HEAD(head);
>  
>  	spin_lock_irqsave(&chan->vchan.lock, flags);
>  
> +	if (chan->use_mdma)
> +		dmaengine_terminate_async(mchan->chan);
> +
>  	if (chan->busy) {
>  		stm32_dma_stop(chan);
>  		chan->desc = NULL;
> @@ -514,9 +549,96 @@ static int stm32_dma_terminate_all(struct dma_chan *c)
>  	return 0;
>  }
>  
> +static u32 stm32_dma_get_remaining_bytes(struct stm32_dma_chan *chan)
> +{
> +	u32 dma_scr, width, ndtr;
> +	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
> +
> +	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
> +	width = STM32_DMA_SCR_PSIZE_GET(dma_scr);
> +	ndtr = stm32_dma_read(dmadev, STM32_DMA_SNDTR(chan->id));
> +
> +	return ndtr << width;
> +}
> +
> +static int stm32_dma_mdma_drain(struct stm32_dma_chan *chan)
> +{
> +	struct stm32_dma_mdma *mchan = &chan->mchan;
> +	struct stm32_dma_sg_req *sg_req;
> +	struct dma_device *ddev = mchan->chan->device;
> +	struct dma_async_tx_descriptor *desc = NULL;
> +	enum dma_status status;
> +	dma_addr_t src_buf, dst_buf;
> +	u32 mdma_residue, mdma_wrote, dma_to_write, len;
> +	struct dma_tx_state state;
> +	int ret;
> +
> +	/* DMA/MDMA chain: drain remaining data in SRAM */
> +
> +	/* Get the residue on MDMA side */
> +	status = dmaengine_tx_status(mchan->chan, mchan->chan->cookie, &state);
> +	if (status == DMA_COMPLETE)
> +		return status;
> +
> +	mdma_residue = state.residue;
> +	sg_req = &chan->desc->sg_req[chan->next_sg - 1];
> +	len = sg_dma_len(&sg_req->stm32_sgl_req);
> +
> +	/*
> +	 * Total = mdma blocks * sram_period + rest (< sram_period)
> +	 * so mdma blocks * sram_period = len - mdma residue - rest
> +	 */
> +	mdma_wrote = len - mdma_residue - (len % mchan->sram_period);
> +
> +	/* Remaining data stuck in SRAM */
> +	dma_to_write = mchan->sram_period - stm32_dma_get_remaining_bytes(chan);
> +	if (dma_to_write > 0) {
> +		/* Stop DMA current operation */
> +		stm32_dma_disable_chan(chan);
> +
> +		/* Terminate current MDMA to initiate a new one */
> +		dmaengine_terminate_all(mchan->chan);
> +
> +		/* Double buffer management */
> +		src_buf = mchan->sram_buf +
> +			  ((mdma_wrote / mchan->sram_period) & 0x1) *
> +			  mchan->sram_period;
> +		dst_buf = sg_dma_address(&sg_req->stm32_sgl_req) + mdma_wrote;
> +
> +		desc = ddev->device_prep_dma_memcpy(mchan->chan,
> +						    dst_buf, src_buf,
> +						    dma_to_write,
> +						    DMA_PREP_INTERRUPT);

why would you do that?

If at all you need to create anothe txn, I think it would be good to
prepare a new descriptor and chain it, not call the dmaengine APIs..

-- 
~Vinod
