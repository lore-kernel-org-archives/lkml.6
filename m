Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69754C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4242220859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfAPRz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:55:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54096 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbfAPRz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:55:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFB4380D;
        Wed, 16 Jan 2019 09:55:25 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 851C23F763;
        Wed, 16 Jan 2019 09:55:24 -0800 (PST)
Subject: Re: [RFC PATCH] i2c: imx: dma map the i2c data i/o register
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-i2c@vger.kernel.org, linux-imx@nxp.com,
        iommu@lists.linux-foundation.org, kernel@pengutronix.de,
        wsa@the-dreams.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190116161713.12748-1-laurentiu.tudor@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7f9a9486-250d-cc92-1ce5-b5c1afc96f2d@arm.com>
Date:   Wed, 16 Jan 2019 17:55:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116161713.12748-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2019 16:17, Laurentiu Tudor wrote:
> This is an attempt to fix an iommu exception when doing dma to the
> i2c controller with EDMA. Without these mappings the smmu raises a
> context fault [1] exactly with the address of the i2c data i/o reg.
> This was seen on an NXP LS1043A chip while working on enabling SMMU.

Rather than gradually adding much the same code to potentially every 
possible client driver, can it not be implemented once in the edma 
driver as was done for pl330 and rcar-dmac? That also sidesteps any of 
the nastiness of smuggling a dma_addr_t via a phys_addr_t variable.

Robin.

> [1] arm-smmu 9000000.iommu: Unhandled context fault: fsr=0x402,
>      iova=0x02180004, fsynr=0x150021, cb=7
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   drivers/i2c/busses/i2c-imx.c | 57 +++++++++++++++++++++++++++++-------
>   1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 4e34b1572756..07cc8f4b45b9 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -202,6 +202,9 @@ struct imx_i2c_struct {
>   	struct pinctrl_state *pinctrl_pins_gpio;
>   
>   	struct imx_i2c_dma	*dma;
> +
> +	dma_addr_t		dma_tx_addr;
> +	dma_addr_t		dma_rx_addr;
>   };
>   
>   static const struct imx_i2c_hwdata imx1_i2c_hwdata = {
> @@ -274,17 +277,20 @@ static inline unsigned char imx_i2c_read_reg(struct imx_i2c_struct *i2c_imx,
>   
>   /* Functions for DMA support */
>   static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> -			       dma_addr_t phy_addr)
> +			       phys_addr_t phy_addr)
>   {
>   	struct imx_i2c_dma *dma;
>   	struct dma_slave_config dma_sconfig;
>   	struct device *dev = &i2c_imx->adapter.dev;
>   	int ret;
> +	phys_addr_t i2dr_pa;
>   
>   	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
>   	if (!dma)
>   		return -ENOMEM;
>   
> +	i2dr_pa = phy_addr + (IMX_I2C_I2DR << i2c_imx->hwdata->regshift);
> +
>   	dma->chan_tx = dma_request_chan(dev, "tx");
>   	if (IS_ERR(dma->chan_tx)) {
>   		ret = PTR_ERR(dma->chan_tx);
> @@ -293,15 +299,25 @@ static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>   		goto fail_al;
>   	}
>   
> -	dma_sconfig.dst_addr = phy_addr +
> -				(IMX_I2C_I2DR << i2c_imx->hwdata->regshift);
> +	i2c_imx->dma_tx_addr = dma_map_resource(dma->chan_tx->device->dev,
> +						i2dr_pa,
> +						DMA_SLAVE_BUSWIDTH_1_BYTE,
> +						DMA_MEM_TO_DEV, 0);
> +	ret = dma_mapping_error(dma->chan_tx->device->dev,
> +				i2c_imx->dma_tx_addr);
> +	if (ret) {
> +		dev_err(dev, "can't dma map tx destination (%d)\n", ret);
> +		goto fail_tx;
> +	}
> +
> +	dma_sconfig.dst_addr = i2c_imx->dma_tx_addr;
>   	dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>   	dma_sconfig.dst_maxburst = 1;
>   	dma_sconfig.direction = DMA_MEM_TO_DEV;
>   	ret = dmaengine_slave_config(dma->chan_tx, &dma_sconfig);
>   	if (ret < 0) {
>   		dev_err(dev, "can't configure tx channel (%d)\n", ret);
> -		goto fail_tx;
> +		goto fail_tx_dma;
>   	}
>   
>   	dma->chan_rx = dma_request_chan(dev, "rx");
> @@ -309,18 +325,28 @@ static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>   		ret = PTR_ERR(dma->chan_rx);
>   		if (ret != -ENODEV && ret != -EPROBE_DEFER)
>   			dev_err(dev, "can't request DMA rx channel (%d)\n", ret);
> -		goto fail_tx;
> +		goto fail_tx_dma;
>   	}
>   
> -	dma_sconfig.src_addr = phy_addr +
> -				(IMX_I2C_I2DR << i2c_imx->hwdata->regshift);
> +	i2c_imx->dma_rx_addr = dma_map_resource(dma->chan_rx->device->dev,
> +						i2dr_pa,
> +						DMA_SLAVE_BUSWIDTH_1_BYTE,
> +						DMA_DEV_TO_MEM, 0);
> +	ret = dma_mapping_error(dma->chan_rx->device->dev,
> +				i2c_imx->dma_rx_addr);
> +	if (ret) {
> +		dev_err(dev, "can't dma map rx source (%d)\n", ret);
> +		goto fail_rx;
> +	}
> +
> +	dma_sconfig.src_addr = i2c_imx->dma_rx_addr;
>   	dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>   	dma_sconfig.src_maxburst = 1;
>   	dma_sconfig.direction = DMA_DEV_TO_MEM;
>   	ret = dmaengine_slave_config(dma->chan_rx, &dma_sconfig);
>   	if (ret < 0) {
>   		dev_err(dev, "can't configure rx channel (%d)\n", ret);
> -		goto fail_rx;
> +		goto fail_rx_dma;
>   	}
>   
>   	i2c_imx->dma = dma;
> @@ -330,8 +356,14 @@ static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>   
>   	return 0;
>   
> +fail_rx_dma:
> +	dma_unmap_resource(dma->chan_rx->device->dev, i2c_imx->dma_rx_addr,
> +			   DMA_SLAVE_BUSWIDTH_1_BYTE, DMA_DEV_TO_MEM, 0);
>   fail_rx:
>   	dma_release_channel(dma->chan_rx);
> +fail_tx_dma:
> +	dma_unmap_resource(dma->chan_tx->device->dev, i2c_imx->dma_tx_addr,
> +			   DMA_SLAVE_BUSWIDTH_1_BYTE, DMA_MEM_TO_DEV, 0);
>   fail_tx:
>   	dma_release_channel(dma->chan_tx);
>   fail_al:
> @@ -1057,7 +1089,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
>   	struct imxi2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
>   	void __iomem *base;
>   	int irq, ret;
> -	dma_addr_t phy_addr;
> +	phys_addr_t phy_addr;
>   
>   	dev_dbg(&pdev->dev, "<%s>\n", __func__);
>   
> @@ -1072,7 +1104,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
> -	phy_addr = (dma_addr_t)res->start;
> +	phy_addr = res->start;
>   	i2c_imx = devm_kzalloc(&pdev->dev, sizeof(*i2c_imx), GFP_KERNEL);
>   	if (!i2c_imx)
>   		return -ENOMEM;
> @@ -1220,6 +1252,11 @@ static int i2c_imx_remove(struct platform_device *pdev)
>   	pm_runtime_put_noidle(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
>   
> +	dma_unmap_resource(&pdev->dev, i2c_imx->dma_tx_addr,
> +			   DMA_SLAVE_BUSWIDTH_1_BYTE, DMA_MEM_TO_DEV, 0);
> +	dma_unmap_resource(&pdev->dev, i2c_imx->dma_rx_addr,
> +			   DMA_SLAVE_BUSWIDTH_1_BYTE, DMA_DEV_TO_MEM, 0);
> +
>   	return 0;
>   }
>   
> 
