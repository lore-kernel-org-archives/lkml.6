Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42053C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CF920644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CF920644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJOQjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:39:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60977 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOQjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:39:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 07A5E20728; Mon, 15 Oct 2018 10:54:45 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id B0BC720703;
        Mon, 15 Oct 2018 10:54:34 +0200 (CEST)
Date:   Mon, 15 Oct 2018 10:54:35 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v5 1/2] spi: Add MXIC controller driver
Message-ID: <20181015105435.6c869a56@bbrezillon>
In-Reply-To: <1539591976-30430-2-git-send-email-masonccyang@mxic.com.tw>
References: <1539591976-30430-1-git-send-email-masonccyang@mxic.com.tw>
        <1539591976-30430-2-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Mon, 15 Oct 2018 16:26:15 +0800
masonccyang@mxic.com.tw wrote:


> +
> +static int mxic_spi_setup(struct spi_device *spi)
> +{
> +	return 0;
> +}

Drop this empty function and leave ->setup to NULL.

> +
> +static int mxic_spi_probe(struct platform_device *pdev)
> +{
> +	struct spi_master *master;
> +	struct resource *res;
> +	struct mxic_spi *mxic;
> +	int ret;
> +
> +	master = spi_alloc_master(&pdev->dev, sizeof(struct mxic_spi));
> +	if (!master)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, master);
> +
> +	mxic = spi_master_get_devdata(master);
> +
> +	master->dev.of_node = pdev->dev.of_node;
> +
> +	mxic->ps_clk = devm_clk_get(&pdev->dev, "ps_clk");
> +	if (IS_ERR(mxic->ps_clk))
> +		return PTR_ERR(mxic->ps_clk);
> +
> +	mxic->send_clk = devm_clk_get(&pdev->dev, "send_clk");
> +	if (IS_ERR(mxic->send_clk))
> +		return PTR_ERR(mxic->send_clk);
> +
> +	mxic->send_dly_clk = devm_clk_get(&pdev->dev, "send_dly_clk");
> +	if (IS_ERR(mxic->send_dly_clk))
> +		return PTR_ERR(mxic->send_dly_clk);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> +	mxic->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(mxic->regs))
> +		return PTR_ERR(mxic->regs);
> +
> +	pm_runtime_enable(&pdev->dev);
> +	master->auto_runtime_pm = true;
> +
> +	master->num_chipselect = 1;
> +	master->setup = mxic_spi_setup;
> +	master->mem_ops = &mxic_spi_mem_ops;
> +
> +	master->set_cs = mxic_spi_set_cs;
> +	master->transfer_one = mxic_spi_transfer_one;
> +	master->bits_per_word_mask = SPI_BPW_MASK(8);
> +	master->mode_bits = SPI_CPOL | SPI_CPHA |
> +			SPI_RX_DUAL | SPI_TX_DUAL |
> +			SPI_RX_QUAD | SPI_TX_QUAD;
> +
> +	mxic_spi_hw_init(mxic);

Don't you need at least the ps_clk to be enabled to write to the MXIC
regs? Also, what happens when the ps_clk is disabled? Is reg content
preserved? If not, then you should probably move the mxic_spi_hw_init()
in the mxic_spi_runtime_resume() function so that you always start from
a known state.

> +
> +	ret = spi_register_master(master);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_master failed\n");
> +		goto err_put_master;
> +	}
> +
> +	return 0;
> +
> +err_put_master:
> +	spi_master_put(master);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static int mxic_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	spi_unregister_master(master);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mxic_spi_of_ids[] = {
> +	{ .compatible = "mxicy,mx25f0a-spi", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxic_spi_of_ids);
> +
> +static struct platform_driver mxic_spi_driver = {
> +	.probe = mxic_spi_probe,
> +	.remove = mxic_spi_remove,
> +	.driver = {
> +		.name = "mxic-spi",
> +		.of_match_table = mxic_spi_of_ids,
> +		.pm = &mxic_spi_dev_pm_ops,
> +	},
> +};
> +module_platform_driver(mxic_spi_driver);
> +
> +MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
> +MODULE_DESCRIPTION("MX25F0A SPI controller driver");
> +MODULE_LICENSE("GPL v2");
> +

Drop this blank line.

Regards,

Boris
