Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeDKJHh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:07:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:20098 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbeDKJHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:07:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="32509798"
Date: Wed, 11 Apr 2018 14:41:59 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc: dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, radheys@xilinx.com, lars@metafoo.de,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 5/6] dmaengine: xilinx_dma: Program interrupt delay timeout
Message-ID: <20180411091159.GA6014@localhost>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-6-git-send-email-radheys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522665546-10035-6-git-send-email-radheys@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 04:09:05PM +0530, Radhey Shyam Pandey wrote:
> Program IRQDelay for AXI DMA. The interrupt timeout mechanism causes
> the DMA engine to generate an interrupt after the delay time period
> has expired. It enables dmaengine to respond in real-time even though
> interrupt coalescing is configured.

again you are doing this only for axieth_connected, why is that?

> 
> Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 518465e..ab8f1b0 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -161,8 +161,12 @@
>  /* AXI DMA Specific Masks/Bit fields */
>  #define XILINX_DMA_MAX_TRANS_LEN	GENMASK(22, 0)
>  #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
> +#define XILINX_DMA_CR_DELAY_MAX		GENMASK(31, 24)
>  #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
>  #define XILINX_DMA_CR_COALESCE_SHIFT	16
> +#define XILINX_DMA_CR_DELAY_SHIFT	24
> +#define XILINX_DMA_CR_WAITBOUND_DFT	254
> +
>  #define XILINX_DMA_BD_SOP		BIT(27)
>  #define XILINX_DMA_BD_EOP		BIT(26)
>  #define XILINX_DMA_COALESCE_MAX		255
> @@ -1294,6 +1298,12 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>  		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
>  		reg |= chan->desc_pendingcount <<
>  				  XILINX_DMA_CR_COALESCE_SHIFT;
> +
> +		if (chan->xdev->has_axieth_connected) {
> +			reg  &= ~XILINX_DMA_CR_DELAY_MAX;
> +			reg  |= XILINX_DMA_CR_WAITBOUND_DFT <<
> +					XILINX_DMA_CR_DELAY_SHIFT;
> +		}
>  		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>  	}
>  
> @@ -1508,7 +1518,8 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
>  		}
>  	}
>  
> -	if (status & XILINX_DMA_DMASR_DLY_CNT_IRQ) {
> +	if (!chan->xdev->has_axieth_connected && (status &
> +			XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
>  		/*
>  		 * Device takes too long to do the transfer when user requires
>  		 * responsiveness.
> @@ -1516,7 +1527,8 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
>  		dev_dbg(chan->dev, "Inter-packet latency too long\n");
>  	}
>  
> -	if (status & XILINX_DMA_DMASR_FRM_CNT_IRQ) {
> +	if (status & (XILINX_DMA_DMASR_FRM_CNT_IRQ |
> +		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
>  		spin_lock(&chan->lock);
>  		xilinx_dma_complete_descriptor(chan);
>  		chan->idle = true;
> -- 
> 1.7.1
> 

-- 
~Vinod
