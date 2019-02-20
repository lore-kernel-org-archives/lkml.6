Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391EF21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iLw8G4oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfBTSCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:02:13 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4393 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTSCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:02:12 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6d96210000>; Wed, 20 Feb 2019 10:02:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 10:02:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Feb 2019 10:02:10 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 18:02:07 +0000
Subject: Re: [PATCH V19 5/7] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        <thierry.reding@gmail.com>, <mkarthik@nvidia.com>,
        <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <wsa@the-dreams.de>, <peda@axentia.se>, <digetx@gmail.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
 <1549998408-9137-5-git-send-email-skomatineni@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a98faf49-98f5-7b85-8acd-0fd6a4c8b426@nvidia.com>
Date:   Wed, 20 Feb 2019 18:02:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549998408-9137-5-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550685729; bh=4wVmbRuRJSgfCHgUZozfWsc3hk0toOzShuoOku71S3g=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=iLw8G4oADbiHT6Fz181IqBf+txM5pZo4XDemxJOx/VbI+gNPn+RxGCjZbbTlVOGsX
         gastsvZdNA30rc02zK8snL47WocjTlG3E02yt5hNKom2a6iVhvH3LNQXBHrh5K0ZDc
         jUCzNIvi/5Y/f4i3oM3lP9MRevrLOIVTDbxHt1N3U+0TKheqCTL6f0TwihttTeTazJ
         FRDjzPscsdylu+/PE6VffOnCQItIeU+tMSsof7AdQ1nKS68g1krilZhOmzMZocJ6bQ
         yddottjwg0NT6E8NLXfPFLQlack44DltQpZIxyyHTPwHU52RS/x918quvwo+shzyd+
         JvjNVh4oUR+2g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/02/2019 19:06, Sowjanya Komatineni wrote:
> This patch adds DMA support for Tegra I2C.
> 
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
> 
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction. This adds delay between data bytes of the same
> transfer when CPU is fully loaded and some slave devices has
> internal timeout for no bus activity and stops transaction to
> avoid bus hang. DMA mode is helpful in such cases.
> 
> DMA mode is also helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
> 
> Tegra210 and prior Tegra chips use APBDMA driver which is replaced
> with GPCDMA on Tegra186 and Tegra194.
> This patch uses has_apb_dma flag in hw_feature to differentiate
> DMA driver change between Tegra chipset.
> 
> APBDMA driver is registered from module-init level and this patch
> also has a change to register I2C driver at module-init level
> rather than subsys-init to avoid deferring I2C probe till APBDMA
> driver is registered.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

...

> +static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
> +{
> +	struct dma_chan *chan;
> +	u32 *dma_buf;
> +	dma_addr_t dma_phys;
> +	int err;
> +
> +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA) ||
> +	    !i2c_dev->hw->has_apb_dma) {
> +		err = -ENODEV;
> +		goto err_out;
> +	}
> +
> +	chan = dma_request_slave_channel_reason(i2c_dev->dev, "rx");
> +	if (IS_ERR(chan)) {
> +		err = PTR_ERR(chan);
> +		goto err_out;
> +	}
> +
> +	i2c_dev->rx_dma_chan = chan;
> +
> +	chan = dma_request_slave_channel_reason(i2c_dev->dev, "tx");
> +	if (IS_ERR(chan)) {
> +		err = PTR_ERR(chan);
> +		goto err_out;
> +	}
> +
> +	i2c_dev->tx_dma_chan = chan;
> +
> +	dma_buf = dma_alloc_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
> +				     &dma_phys, GFP_KERNEL | __GFP_NOWARN);
> +	if (!dma_buf) {
> +		dev_err(i2c_dev->dev, "failed to allocate the DMA buffer\n");
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	i2c_dev->dma_buf = dma_buf;
> +	i2c_dev->dma_phys = dma_phys;
> +	return 0;
> +
> +err_out:
> +	tegra_i2c_release_dma(i2c_dev);
> +	if (err != -EPROBE_DEFER) {
> +		dev_err(i2c_dev->dev, "cannot use DMA: %d\n", err);
> +		dev_err(i2c_dev->dev, "fallbacking to PIO\n");
> +		return 0;
> +	}
I think that the above should be a dev_dbg print or re-worked in someway
because now for Tegra194 which does not have an APB DMA I see ...

[       6.093234] ERR KERN tegra-i2c 31c0000.i2c: cannot use DMA: -19
[       6.096847] ERR KERN tegra-i2c 31c0000.i2c: falling back to PIO

Given that the APB DMA is not supported for Tegra186/Tegra194, there is
no point in printing these error messages. Now it looks like something
is wrong but really it is not :-(

Cheers
Jon

-- 
nvpublic
