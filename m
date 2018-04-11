Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeDKJff (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:35:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:62743 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbeDKJfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:35:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="45282895"
Date: Wed, 11 Apr 2018 15:10:01 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: dan.j.williams@intel.com, eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] dmaengine: sprd: Add 'device_config' and
 'device_prep_slave_sg' interfaces
Message-ID: <20180411094000.GD6014@localhost>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0a9fa618bd74e74c135ebee2e40b30d361c1d905.1523346135.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a9fa618bd74e74c135ebee2e40b30d361c1d905.1523346135.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 03:46:07PM +0800, Baolin Wang wrote:
> This patch adds the 'device_config' and 'device_prep_slave_sg' interfaces
> for users to configure DMA.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/dma/sprd-dma.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index f8038de..c923fb0 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -869,6 +869,52 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
>  	return vchan_tx_prep(&schan->vc, &sdesc->vd, flags);
>  }
>  
> +static struct dma_async_tx_descriptor *
> +sprd_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +		       unsigned int sglen, enum dma_transfer_direction dir,
> +		       unsigned long flags, void *context)
> +{
> +	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> +	struct sprd_dma_config *slave_cfg = &schan->slave_cfg;
> +	struct sprd_dma_desc *sdesc;
> +	struct scatterlist *sg;
> +	int ret, i;
> +
> +	/* TODO: now we only support one sg for each DMA configuration. */
> +	if (!is_slave_direction(slave_cfg->config.direction) || sglen > 1)

the slave direction check seems wrong to me. .device_config shall give you
dma_slave_config. You should check here if dir passed is slave or not. If
you want to check parameters in slave_config then please use .device_config

> +		return NULL;
> +
> +	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
> +	if (!sdesc)
> +		return NULL;
> +
> +	for_each_sg(sgl, sg, sglen, i) {
> +		if (slave_cfg->config.direction == DMA_MEM_TO_DEV)
> +			slave_cfg->config.src_addr = sg_dma_address(sg);

Nope slave_config specifies peripheral address and not memory one passed here

-- 
~Vinod
