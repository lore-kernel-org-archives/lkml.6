Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E0C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FD021019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548233165;
	bh=ybNY4yrApg4SJFEO0q+sJn4O5cGX8ghkI9ETNmwf4Qg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=J6mC0RIBsGRBij+reSiafAFdmZMNMj9hvPMwDIpqIxpc77SuGdiHgwScvX/XXliis
	 p7lbbrJAY9rPU+HDE6Yo5jnuf4mnqP4DhGkBA57f1zbtxdDefgtDkWLNPlEnXoSzgy
	 q7GxEbqXy9J5/h3qoNWpDDIUdIXbbZoC2QJFFqIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfAWIqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfAWIqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:46:01 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E95721019;
        Wed, 23 Jan 2019 08:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548233161;
        bh=ybNY4yrApg4SJFEO0q+sJn4O5cGX8ghkI9ETNmwf4Qg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CJiBsy5suBMnRjVvqMv4YraZfv3+DNaNg+6HTHSwcoFh9PJweMJRmQOr0HjeOYJ6w
         PrZmLgzmTFK9JMMjZdaA6llgNR+3fA/Tszzat+pNoUfrnklcByJHcKVwTIT8Py1HxN
         KfDE7aXnYfna9Vf5vfNLFPA9qNtaPoKY24HbZ8BY=
Date:   Wed, 23 Jan 2019 09:45:52 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     <Tudor.Ambarus@microchip.com>, Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
Message-ID: <20190123094552.57665d2e@bbrezillon>
In-Reply-To: <20190122064137.17114-3-vigneshr@ti.com>
References: <20190122064137.17114-1-vigneshr@ti.com>
        <20190122064137.17114-3-vigneshr@ti.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 12:11:37 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Cadence OSPI controller IP supports Octal IO (x8 IO lines),
> It also has an integrated PHY. IP register layout is very
> similar to existing QSPI IP except for additional bits to support Octal
> and Octal DDR mode. Therefore, extend current driver to support Octal
> mode. Only Octal SDR read (1-1-8)mode is supported for now.
> 
> Tested with mt35xu512aba Octal flash on TI's AM654 EVM.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> 
> v4: Fix comments by Tudor on v3
> v3: No changes
> v2: Declare Octal mode capability based on compatible.
> 
>  drivers/mtd/spi-nor/cadence-quadspi.c | 53 +++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index 04cedd3a2bf6..2091addc45a3 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -44,6 +44,12 @@
>  /* Quirks */
>  #define CQSPI_NEEDS_WR_DELAY		BIT(0)
>  
> +/* Capabilities mask */
> +#define cqspi_base_hwcaps_mask					\

Nit: we usually use upper cases for such definitions.

> +	(SNOR_HWCAPS_READ | SNOR_HWCAPS_READ_FAST |		\
> +	SNOR_HWCAPS_READ_1_1_2 | SNOR_HWCAPS_READ_1_1_4 |	\
> +	SNOR_HWCAPS_PP)
> +
>  struct cqspi_st;
>  
>  struct cqspi_flash_pdata {
> @@ -93,6 +99,11 @@ struct cqspi_st {
>  	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
>  };
>  
> +struct cqspi_driver_platdata {
> +	u32 hwcaps_mask;
> +	u8 quirks;
> +};
> +
>  /* Operation timeout value */
>  #define CQSPI_TIMEOUT_MS			500
>  #define CQSPI_READ_TIMEOUT_MS			10
> @@ -101,6 +112,7 @@ struct cqspi_st {
>  #define CQSPI_INST_TYPE_SINGLE			0
>  #define CQSPI_INST_TYPE_DUAL			1
>  #define CQSPI_INST_TYPE_QUAD			2
> +#define CQSPI_INST_TYPE_OCTAL			3
>  
>  #define CQSPI_DUMMY_CLKS_PER_BYTE		8
>  #define CQSPI_DUMMY_BYTES_MAX			4
> @@ -911,6 +923,9 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
>  		case SNOR_PROTO_1_1_4:
>  			f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
>  			break;
> +		case SNOR_PROTO_1_1_8:
> +			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -1213,21 +1228,22 @@ static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
>  
>  static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>  {
> -	const struct spi_nor_hwcaps hwcaps = {
> -		.mask = SNOR_HWCAPS_READ |
> -			SNOR_HWCAPS_READ_FAST |
> -			SNOR_HWCAPS_READ_1_1_2 |
> -			SNOR_HWCAPS_READ_1_1_4 |
> -			SNOR_HWCAPS_PP,
> -	};
>  	struct platform_device *pdev = cqspi->pdev;
>  	struct device *dev = &pdev->dev;
> +	const struct cqspi_driver_platdata *ddata;
> +	struct spi_nor_hwcaps hwcaps;
>  	struct cqspi_flash_pdata *f_pdata;
>  	struct spi_nor *nor;
>  	struct mtd_info *mtd;
>  	unsigned int cs;
>  	int i, ret;
>  
> +	ddata = of_device_get_match_data(dev);
> +	if (!ddata)
> +		hwcaps.mask = cqspi_base_hwcaps_mask;
> +	else
> +		hwcaps.mask = ddata->hwcaps_mask;
> +
>  	/* Get flash device data */
>  	for_each_available_child_of_node(dev->of_node, np) {
>  		ret = of_property_read_u32(np, "reg", &cs);
> @@ -1310,7 +1326,7 @@ static int cqspi_probe(struct platform_device *pdev)
>  	struct cqspi_st *cqspi;
>  	struct resource *res;
>  	struct resource *res_ahb;
> -	unsigned long data;
> +	const struct cqspi_driver_platdata *ddata;
>  	int ret;
>  	int irq;
>  
> @@ -1377,8 +1393,8 @@ static int cqspi_probe(struct platform_device *pdev)
>  	}
>  
>  	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
> -	data  = (unsigned long)of_device_get_match_data(dev);
> -	if (data & CQSPI_NEEDS_WR_DELAY)
> +	ddata  = of_device_get_match_data(dev);
> +	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
>  		cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
>  						   cqspi->master_ref_clk_hz);
>  
> @@ -1460,14 +1476,27 @@ static const struct dev_pm_ops cqspi__dev_pm_ops = {
>  #define CQSPI_DEV_PM_OPS	NULL
>  #endif
>  
> +static const struct cqspi_driver_platdata k2g_qspi = {
> +	.hwcaps_mask = cqspi_base_hwcaps_mask,
> +	.quirks = CQSPI_NEEDS_WR_DELAY,
> +};
> +
> +static const struct cqspi_driver_platdata am654_ospi = {
> +	.hwcaps_mask = cqspi_base_hwcaps_mask | SNOR_HWCAPS_READ_1_1_8,
> +	.quirks = CQSPI_NEEDS_WR_DELAY,
> +};
> +
>  static const struct of_device_id cqspi_dt_ids[] = {
>  	{
>  		.compatible = "cdns,qspi-nor",
> -		.data = (void *)0,

Can't we have a cqspi_driver_platdata instance for that one too?

>  	},
>  	{
>  		.compatible = "ti,k2g-qspi",
> -		.data = (void *)CQSPI_NEEDS_WR_DELAY,
> +		.data = &k2g_qspi,
> +	},
> +	{
> +		.compatible = "ti,am654-ospi",
> +		.data = &am654_ospi,
>  	},
>  	{ /* end of table */ }
>  };

