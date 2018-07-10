Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA869C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A460E208F7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yOcMADSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A460E208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934102AbeGJP3X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754280AbeGJP3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:29:22 -0400
Received: from localhost (unknown [106.200.232.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DCC7208EB;
        Tue, 10 Jul 2018 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531236561;
        bh=WwgAsPMyVWxCt1EXHYdi2D2U0QBvZqr4v8gh2EXP1YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOcMADSWA/H6QcxezjakItEKie+NMD1/4skwef3TGN39CZIfK8w4J1r5Tf7B0mp7y
         JxfNcfV9KeeSDO8W8WD6mvcd/ElZZfSrqXiCU9y6Hp2LLHO9Y4B/4w8FqTQWL8oT4w
         8nVeoYjWVp2BcU4UpdnCeoU09LV8DS3SO9pUl2pg=
Date:   Tue, 10 Jul 2018 20:59:12 +0530
From:   Vinod <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
Message-ID: <20180710152912.GE3219@vkoul-mobl>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 11-07-18, 00:23, Robin Gong wrote:
> Add MEMCPY support, meanwhile, add SDMA_BD_MAX_CNT instead
> of '0xffff'.

latter part should be its own patch. Never mix things

> +static struct dma_async_tx_descriptor *sdma_prep_memcpy(
> +		struct dma_chan *chan, dma_addr_t dma_dst,
> +		dma_addr_t dma_src, size_t len, unsigned long flags)
> +{
> +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> +	struct sdma_engine *sdma = sdmac->sdma;
> +	int channel = sdmac->channel;
> +	size_t count;
> +	int i = 0, param;
> +	struct sdma_buffer_descriptor *bd;
> +	struct sdma_desc *desc;
> +
> +	if (!chan || !len)
> +		return NULL;
> +
> +	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=%zu, channel=%d.\n",
> +		&dma_src, &dma_dst, len, channel);
> +
> +	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM, len / SDMA_BD_MAX_CNT
> +					+ 1);

this looks quite odd to read consider:

        esc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM,
                                 len / SDMA_BD_MAX_CNT + 1);

> +	if (!desc)
> +		goto err_out;
> +
> +	do {
> +		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
> +		bd = &desc->bd[i];
> +		bd->buffer_addr = dma_src;
> +		bd->ext_buffer_addr = dma_dst;
> +		bd->mode.count = count;
> +		desc->chn_count += count;
> +
> +		switch (sdmac->word_size) {
> +		case DMA_SLAVE_BUSWIDTH_4_BYTES:

This looks wrong, we are in memcpy, there is no SLAVE so no SLAVE
widths..

>  static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
>  		struct dma_chan *chan, struct scatterlist *sgl,
>  		unsigned int sg_len, enum dma_transfer_direction direction,
> @@ -1344,9 +1431,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
>  
>  		count = sg_dma_len(sg);
>  
> -		if (count > 0xffff) {
> +		if (count > SDMA_BD_MAX_CNT) {
>  			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
> -					channel, count, 0xffff);
> +					channel, count, SDMA_BD_MAX_CNT);

these changes dont belong to this patch

> @@ -1486,6 +1573,8 @@ static int sdma_config(struct dma_chan *chan,
>  		sdmac->watermark_level |= (dmaengine_cfg->dst_maxburst << 16) &
>  			SDMA_WATERMARK_LEVEL_HWML;
>  		sdmac->word_size = dmaengine_cfg->dst_addr_width;
> +	} else if (dmaengine_cfg->direction == DMA_MEM_TO_MEM) {
> +		sdmac->word_size = dmaengine_cfg->dst_addr_width;

same here too, we are in .device_config which deals with slave. Not
memcpy!

>  	} else {
>  		sdmac->per_address = dmaengine_cfg->dst_addr;
>  		sdmac->watermark_level = dmaengine_cfg->dst_maxburst *
> @@ -1902,6 +1991,7 @@ static int sdma_probe(struct platform_device *pdev)
>  
>  	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
> +	dma_cap_set(DMA_MEMCPY, sdma->dma_device.cap_mask);
>  
>  	INIT_LIST_HEAD(&sdma->dma_device.channels);
>  	/* Initialize channel parameters */
> @@ -1968,9 +2058,11 @@ static int sdma_probe(struct platform_device *pdev)
>  	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
>  	sdma->dma_device.directions = SDMA_DMA_DIRECTIONS;
>  	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> +	sdma->dma_device.device_prep_dma_memcpy = sdma_prep_memcpy;
>  	sdma->dma_device.device_issue_pending = sdma_issue_pending;
>  	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
> -	dma_set_max_seg_size(sdma->dma_device.dev, 65535);
> +	sdma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
> +	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);

this line should not be part of this patch

-- 
~Vinod
