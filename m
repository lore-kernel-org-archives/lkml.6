Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDKJGj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:06:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:47854 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeDKJGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:06:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="215737110"
Date: Wed, 11 Apr 2018 14:41:03 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc: dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, radheys@xilinx.com, lars@metafoo.de,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 4/6] dmaengine: xilinx_dma: Freeup active list based on
 descriptor completion bit
Message-ID: <20180411091102.GZ6014@localhost>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-5-git-send-email-radheys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522665546-10035-5-git-send-email-radheys@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 04:09:04PM +0530, Radhey Shyam Pandey wrote:
> AXIDMA IP sets completion bit to 1 when the transfer is completed. Read
> this bit to move descriptor from active list to the done list. This feature
> is needed when interrupt delay timeout and IRQThreshold is enabled i.e
> Dly_IrqEn is triggered w/o completing Interrupt Threshold.
> 
> Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 36e1ab9..518465e 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -103,6 +103,7 @@
>  #define XILINX_DMA_PARK_PTR_RD_REF_SHIFT	0
>  #define XILINX_DMA_PARK_PTR_RD_REF_MASK		GENMASK(4, 0)
>  #define XILINX_DMA_REG_VDMA_VERSION		0x002c
> +#define XILINX_DMA_COMP_MASK			BIT(31)
>  
>  /* Register Direct Mode Registers */
>  #define XILINX_DMA_REG_VSIZE			0x0000
> @@ -1387,16 +1388,25 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
>  static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
>  {
>  	struct xilinx_dma_tx_descriptor *desc, *next;
> +	struct xilinx_axidma_tx_segment *seg;
>  
>  	/* This function was invoked with lock held */
>  	if (list_empty(&chan->active_list))
>  		return;
>  
>  	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
> -		list_del(&desc->node);
> -		if (!desc->cyclic)
> -			dma_cookie_complete(&desc->async_tx);
> -		list_add_tail(&desc->node, &chan->done_list);
> +
> +		seg = list_last_entry(&desc->segments,
> +				      struct xilinx_axidma_tx_segment, node);
> +		if ((seg->hw.status & XILINX_DMA_COMP_MASK) ||
> +			(!chan->xdev->has_axieth_connected)) {

why the second case ? That is not expalined in log?

> +			list_del(&desc->node);
> +			if (!desc->cyclic)
> +				dma_cookie_complete(&desc->async_tx);
> +			list_add_tail(&desc->node, &chan->done_list);
> +		} else {
> +			break;
> +		}
>  	}
>  }
>  
> -- 
> 1.7.1
> 

-- 
~Vinod
