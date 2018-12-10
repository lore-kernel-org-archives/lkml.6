Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB640C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E212054F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E212054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeLJIp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:45:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49708 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbeLJIp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:45:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9D83220CE8; Mon, 10 Dec 2018 09:45:23 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 602692037D;
        Mon, 10 Dec 2018 09:45:13 +0100 (CET)
Date:   Mon, 10 Dec 2018 09:45:13 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
Message-ID: <20181210094513.6282d55e@bbrezillon>
In-Reply-To: <20181003165603.2579-4-vigneshr@ti.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
        <20181003165603.2579-4-vigneshr@ti.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 22:26:03 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Cadence OSPI controller IP supports Octal IO (x8 IO lines),
> It also has an integrated PHY. IP register layout is very
> similar to existing QSPI IP except for additional bits to support Octal
> and Octal DDR mode. Therefore, extend current driver to support Octal
> mode.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index e24db817154e..48b00e75a879 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -101,6 +101,7 @@ struct cqspi_st {
>  #define CQSPI_INST_TYPE_SINGLE			0
>  #define CQSPI_INST_TYPE_DUAL			1
>  #define CQSPI_INST_TYPE_QUAD			2
> +#define CQSPI_INST_TYPE_OCTAL			3
>  
>  #define CQSPI_DUMMY_CLKS_PER_BYTE		8
>  #define CQSPI_DUMMY_BYTES_MAX			4
> @@ -898,6 +899,9 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
>  		case SNOR_PROTO_1_1_4:
>  			f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
>  			break;
> +		case SNOR_PROTO_1_1_8:
> +			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -1205,6 +1209,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>  			SNOR_HWCAPS_READ_FAST |
>  			SNOR_HWCAPS_READ_1_1_2 |
>  			SNOR_HWCAPS_READ_1_1_4 |
> +			SNOR_HWCAPS_READ_1_1_8 |

Is this really supported on qspi versions of this IP? I guess not given
the description in the commit message and the name of the new
compatible (ospi instead of qspi).

>  			SNOR_HWCAPS_PP,
>  	};
>  	struct platform_device *pdev = cqspi->pdev;
> @@ -1456,6 +1461,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
>  		.compatible = "ti,k2g-qspi",
>  		.data = (void *)CQSPI_NEEDS_WR_DELAY,
>  	},
> +	{
> +		.compatible = "ti,am654-ospi",
> +		.data = (void *)CQSPI_NEEDS_WR_DELAY,
> +	},
>  	{ /* end of table */ }
>  };
>  

