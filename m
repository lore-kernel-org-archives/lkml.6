Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECABC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9728A2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfARVuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:50:21 -0500
Received: from ec2-18-194-220-216.eu-central-1.compute.amazonaws.com ([18.194.220.216]:50198
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbfARVuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:50:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 07D0621BB7;
        Fri, 18 Jan 2019 21:50:19 +0000 (UTC)
Received: from sysam.it ([127.0.0.1])
        by localhost (sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9ALgWxC_EC8f; Fri, 18 Jan 2019 21:50:17 +0000 (UTC)
Received: from jerusalem (host242-223-dynamic.54-82-r.retail.telecomitalia.it [82.54.223.242])
        by sysam.it (Postfix) with ESMTPSA id C4EF721BB4;
        Fri, 18 Jan 2019 21:50:16 +0000 (UTC)
Date:   Fri, 18 Jan 2019 22:50:16 +0100
From:   Angelo Dureghello <angelo@sysam.it>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com
Subject: Re: [PATCH] dmaengine: fsl-edma: dma map slave device address
Message-ID: <20190118215015.GA6677@jerusalem>
References: <20190118100623.13271-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118100623.13271-1-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

On Fri, Jan 18, 2019 at 12:06:23PM +0200, Laurentiu Tudor wrote:
> This mapping needs to be created in order for slave dma transfers
> to work on systems with SMMU. The implementation mostly mimics the
> one in pl330 dma driver, authored by Robin Murphy.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> ---
> Original approach was to add the missing mappings in the i2c client driver,
> see here for discussion: https://patchwork.ozlabs.org/patch/1026013/
> 
>  drivers/dma/fsl-edma-common.c | 66 ++++++++++++++++++++++++++++++++---
>  drivers/dma/fsl-edma-common.h |  4 +++
>  drivers/dma/fsl-edma.c        |  1 +
>  drivers/dma/mcf-edma.c        |  1 +
>  4 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 8876c4c1bb2c..0e95ee24b6d4 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -6,6 +6,7 @@
>  #include <linux/dmapool.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/dma-mapping.h>
>  
>  #include "fsl-edma-common.h"
>  
> @@ -173,12 +174,62 @@ int fsl_edma_resume(struct dma_chan *chan)
>  }
>  EXPORT_SYMBOL_GPL(fsl_edma_resume);
>  
> +static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
> +{
> +	if (fsl_chan->dma_dir != DMA_NONE)
> +		dma_unmap_resource(fsl_chan->vchan.chan.device->dev,
> +				   fsl_chan->dma_dev_addr,
> +				   fsl_chan->dma_dev_size,
> +				   fsl_chan->dma_dir, 0);
> +	fsl_chan->dma_dir = DMA_NONE;
> +}
> +
> +static bool fsl_edma_prep_slave_dma(struct fsl_edma_chan *fsl_chan,
> +				    enum dma_transfer_direction dir)
> +{
> +	struct device *dev = fsl_chan->vchan.chan.device->dev;
> +	enum dma_data_direction dma_dir;
> +	phys_addr_t addr = 0;
> +	u32 size = 0;
> +
> +	switch (dir) {
> +	case DMA_MEM_TO_DEV:
> +		dma_dir = DMA_FROM_DEVICE;
> +		addr = fsl_chan->cfg.dst_addr;
> +		size = fsl_chan->cfg.dst_maxburst;
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		dma_dir = DMA_TO_DEVICE;
> +		addr = fsl_chan->cfg.src_addr;
> +		size = fsl_chan->cfg.src_maxburst;
> +		break;
> +	default:
> +		dma_dir = DMA_NONE;
> +		break;
> +	}
> +
> +	/* Already mapped for this config? */
> +	if (fsl_chan->dma_dir == dma_dir)
> +		return true;
> +
> +	fsl_edma_unprep_slave_dma(fsl_chan);
> +
> +	fsl_chan->dma_dev_addr = dma_map_resource(dev, addr, size, dma_dir, 0);
> +	if (dma_mapping_error(dev, fsl_chan->dma_dev_addr))
> +		return false;
> +	fsl_chan->dma_dev_size = size;
> +	fsl_chan->dma_dir = dma_dir;
> +
> +	return true;
> +}
> +
>  int fsl_edma_slave_config(struct dma_chan *chan,
>  				 struct dma_slave_config *cfg)
>  {
>  	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
>  
>  	memcpy(&fsl_chan->cfg, cfg, sizeof(*cfg));
> +	fsl_edma_unprep_slave_dma(fsl_chan);
>  
>  	return 0;
>  }
> @@ -378,6 +429,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  	if (!is_slave_direction(direction))
>  		return NULL;
>  
> +	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
> +		return NULL;
> +
>  	sg_len = buf_len / period_len;
>  	fsl_desc = fsl_edma_alloc_desc(fsl_chan, sg_len);
>  	if (!fsl_desc)
> @@ -409,11 +463,11 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  
>  		if (direction == DMA_MEM_TO_DEV) {
>  			src_addr = dma_buf_next;
> -			dst_addr = fsl_chan->cfg.dst_addr;
> +			dst_addr = fsl_chan->dma_dev_addr;
>  			soff = fsl_chan->cfg.dst_addr_width;
>  			doff = 0;
>  		} else {
> -			src_addr = fsl_chan->cfg.src_addr;
> +			src_addr = fsl_chan->dma_dev_addr;
>  			dst_addr = dma_buf_next;
>  			soff = 0;
>  			doff = fsl_chan->cfg.src_addr_width;
> @@ -444,6 +498,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  	if (!is_slave_direction(direction))
>  		return NULL;
>  
> +	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
> +		return NULL;
> +
>  	fsl_desc = fsl_edma_alloc_desc(fsl_chan, sg_len);
>  	if (!fsl_desc)
>  		return NULL;
> @@ -468,11 +525,11 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  
>  		if (direction == DMA_MEM_TO_DEV) {
>  			src_addr = sg_dma_address(sg);
> -			dst_addr = fsl_chan->cfg.dst_addr;
> +			dst_addr = fsl_chan->dma_dev_addr;
>  			soff = fsl_chan->cfg.dst_addr_width;
>  			doff = 0;
>  		} else {
> -			src_addr = fsl_chan->cfg.src_addr;
> +			src_addr = fsl_chan->dma_dev_addr;
>  			dst_addr = sg_dma_address(sg);
>  			soff = 0;
>  			doff = fsl_chan->cfg.src_addr_width;
> @@ -555,6 +612,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  	fsl_edma_chan_mux(fsl_chan, 0, false);
>  	fsl_chan->edesc = NULL;
>  	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
> +	fsl_edma_unprep_slave_dma(fsl_chan);
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  
>  	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 8917e8865959..b435d8e1e3a1 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -6,6 +6,7 @@
>  #ifndef _FSL_EDMA_COMMON_H_
>  #define _FSL_EDMA_COMMON_H_
>  
> +#include <linux/dma-direction.h>
>  #include "virt-dma.h"
>  
>  #define EDMA_CR_EDBG		BIT(1)
> @@ -120,6 +121,9 @@ struct fsl_edma_chan {
>  	struct dma_slave_config		cfg;
>  	u32				attr;
>  	struct dma_pool			*tcd_pool;
> +	dma_addr_t			dma_dev_addr;
> +	u32				dma_dev_size;
> +	enum dma_data_direction		dma_dir;
>  };
>  
>  struct fsl_edma_desc {
> diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
> index 34d70112fcc9..75e8a7ba3a22 100644
> --- a/drivers/dma/fsl-edma.c
> +++ b/drivers/dma/fsl-edma.c
> @@ -254,6 +254,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  		fsl_chan->pm_state = RUNNING;
>  		fsl_chan->slave_id = 0;
>  		fsl_chan->idle = true;
> +		fsl_chan->dma_dir = DMA_NONE;
>  		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
>  		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
>  
> diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
> index 5de1b07eddff..7de54b2fafdb 100644
> --- a/drivers/dma/mcf-edma.c
> +++ b/drivers/dma/mcf-edma.c
> @@ -214,6 +214,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
>  		mcf_chan->edma = mcf_edma;
>  		mcf_chan->slave_id = i;
>  		mcf_chan->idle = true;
> +		mcf_chan->dma_dir = DMA_NONE;
>  		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
>  		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
>  		iowrite32(0x0, &regs->tcd[i].csr);
> -- 
> 2.17.1
> 

I tested this patch on:

- Vybrid VF50N (Toradex Colibri VF50)
- ColdFire mcf54415 (Sysam stmark2 board)

and dma still works properly.

Tested-by: Angelo Dureghello <angelo@sysam.it>
