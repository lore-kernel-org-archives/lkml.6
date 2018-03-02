Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034372AbeCBIJl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:09:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:54448 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034333AbeCBIJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:09:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,411,1515484800";
   d="scan'208";a="34085254"
Date: Fri, 2 Mar 2018 13:43:26 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: dmaengine@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/2] dmaengine: Introduce DW AXI DMAC driver
Message-ID: <20180302081326.GJ15443@localhost>
References: <20180226145628.11892-1-Eugeniy.Paltsev@synopsys.com>
 <20180226145628.11892-2-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226145628.11892-2-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 05:56:27PM +0300, Eugeniy Paltsev wrote:

> +/*
> + * Synopsys DesignWare AXI DMA Controller driver.
> + *
> + * Copyright (C) 2017-2018 Synopsys, Inc. (www.synopsys.com)
> + * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> + *
> + * SPDX-License-Identifier:	GPL-2.0
> + */

This needs to be in below style

// SPDX-License-Identifier:  GPL-2.0
// Copyright (C) ....

/*
 * other things u want to add
 */

> +#define DRV_NAME	"axi_dw_dmac"

how about use KBUILD_MODNAME here?

> +static enum dma_status
> +dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
> +		  struct dma_tx_state *txstate)
> +{
> +	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
> +	enum dma_status ret;
> +
> +	ret = dma_cookie_status(dchan, cookie, txstate);
> +
> +	if (chan->is_paused && ret == DMA_IN_PROGRESS)
> +		return DMA_PAUSED;
> +
> +	return ret;

nitpick, how about

	if (chan->is_paused && ret == DMA_IN_PROGRESS)
		ret = DMA_PAUSED;

	return ret;

that way we have single point of return.

> +static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
> +{
> +	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
> +
> +	/* ASSERT: channel is idle */
> +	if (axi_chan_is_hw_enable(chan)) {
> +		dev_err(chan2dev(chan), "%s is non-idle!\n",
> +			axi_chan_name(chan));
> +		return -EBUSY;
> +	}
> +
> +	dev_vdbg(dchan2dev(dchan), "%s: allocating\n", axi_chan_name(chan));
> +
> +	dma_cookie_init(dchan);

This is already done as part of vchan_init(), so why is it called explicitly
and why is that not invoked here?

> +static void dma_chan_free_chan_resources(struct dma_chan *dchan)
> +{
> +	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
> +
> +	/* ASSERT: channel is idle */
> +	if (axi_chan_is_hw_enable(chan))
> +		dev_err(dchan2dev(dchan), "%s is non-idle!\n",
> +			axi_chan_name(chan));
> +
> +	axi_chan_disable(chan);
> +	axi_chan_irq_disable(chan, DWAXIDMAC_IRQ_ALL);
> +
> +	vchan_free_chan_resources(&chan->vc);
> +
> +	dev_vdbg(dchan2dev(dchan), "%s: free resources, descriptor still allocated: %u\n",

making the string in subsequent line make it lesser than 80 chars, here and
few other places can benefit..

> +static irqreturn_t dw_axi_dma_intretupt(int irq, void *dev_id)
/s/intretupt/interrupt/ ?

> +static int axi_dma_resume(struct axi_dma_chip *chip)
> +{
> +	int ret = 0;

superfluous init

> +static int parse_device_properties(struct axi_dma_chip *chip)
> +{
> +	struct device *dev = chip->dev;
> +	u32 tmp, carr[DMAC_MAX_CHANNELS];
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "dma-channels", &tmp);
> +	if (ret)
> +		return ret;
> +	if (tmp == 0 || tmp > DMAC_MAX_CHANNELS)
> +		return -EINVAL;
> +
> +	chip->dw->hdata->nr_channels = tmp;
> +
> +	ret = device_property_read_u32(dev, "snps,dma-masters", &tmp);

why is it snps,... shouldn't it be only dma-masters?

> +enum {
> +	DWAXIDMAC_ARWLEN_1		= 0x0,
> +	DWAXIDMAC_ARWLEN_2		= 0x1,
> +	DWAXIDMAC_ARWLEN_4		= 0x3,
> +	DWAXIDMAC_ARWLEN_8		= 0x7,
> +	DWAXIDMAC_ARWLEN_16		= 0xF,
> +	DWAXIDMAC_ARWLEN_32		= 0x1F,
> +	DWAXIDMAC_ARWLEN_64		= 0x3F,
> +	DWAXIDMAC_ARWLEN_128		= 0x7F,
> +	DWAXIDMAC_ARWLEN_256		= 0xFF,

GENMASK() for these?

-- 
~Vinod
