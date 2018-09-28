Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547B6C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC63821547
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC63821547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeI1NRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:17:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44253 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeI1NRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:17:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3288C208F4; Fri, 28 Sep 2018 08:55:25 +0200 (CEST)
Received: from bbrezillon (unknown [176.187.87.154])
        by mail.bootlin.com (Postfix) with ESMTPSA id DF20420725;
        Fri, 28 Sep 2018 08:55:14 +0200 (CEST)
Date:   Fri, 28 Sep 2018 08:55:15 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, eha@deif.com
Subject: Re: [PATCH 2/2] spi: spi-fsl-dspi: Fix support for XSPI transport
 mode
Message-ID: <20180928085515.3faa3555@bbrezillon>
In-Reply-To: <20180921070628.35153-2-chuanhua.han@nxp.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180921070628.35153-2-chuanhua.han@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuanhua,

On Fri, 21 Sep 2018 15:06:27 +0800
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> This patch fixes the problem that the XSPI mode of the dspi controller
> cannot transfer data properly.
> In XSPI mode, cmd_fifo is written before tx_fifo, which transforms the
> byte order of sending and receiving data.

Again, I have a hard time understanding what the problem is. It doesn't
seem related to the ->bits_per_word aspect, and I have the feeling
you're actually abusing this field to get your problem fixed.

Regards,

Boris

> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 3082e72e4f6c..44cc2bd0120e 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -220,9 +220,15 @@ static u32 dspi_pop_tx(struct fsl_dspi *dspi)
>  		if (dspi->bytes_per_word == 1)
>  			txdata = *(u8 *)dspi->tx;
>  		else if (dspi->bytes_per_word == 2)
> -			txdata = *(u16 *)dspi->tx;
> +			if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1))
> +				txdata =  cpu_to_le16(*(u16 *)dspi->tx);
> +			else
> +				txdata =  cpu_to_be16(*(u16 *)dspi->tx);
>  		else  /* dspi->bytes_per_word == 4 */
> -			txdata = *(u32 *)dspi->tx;
> +			if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1))
> +				txdata = cpu_to_le32(*(u32 *)dspi->tx);
> +			else
> +				txdata = cpu_to_be32(*(u32 *)dspi->tx);
>  		dspi->tx += dspi->bytes_per_word;
>  	}
>  	dspi->len -= dspi->bytes_per_word;
> @@ -243,15 +249,18 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
>  	if (!dspi->rx)
>  		return;
>  
> -	/* Mask of undefined bits */
> -	rxdata &= (1 << dspi->bits_per_word) - 1;
> -
>  	if (dspi->bytes_per_word == 1)
>  		*(u8 *)dspi->rx = rxdata;
>  	else if (dspi->bytes_per_word == 2)
> -		*(u16 *)dspi->rx = rxdata;
> +		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1))
> +			*(u16 *)dspi->rx = be16_to_cpu(rxdata);
> +		else
> +			*(u16 *)dspi->rx = be16_to_cpu(rxdata);
>  	else /* dspi->bytes_per_word == 4 */
> -		*(u32 *)dspi->rx = rxdata;
> +		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1))
> +			*(u32 *)dspi->rx = le32_to_cpu(rxdata);
> +		else
> +			*(u32 *)dspi->rx = be32_to_cpu(rxdata);
>  	dspi->rx += dspi->bytes_per_word;
>  }
>  
> @@ -593,16 +602,16 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
>  		 */
>  		u32 data = dspi_pop_tx(dspi);
>  
> +		cmd_fifo_write(dspi);
>  		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1)) {
>  			/* LSB */
> -			tx_fifo_write(dspi, data & 0xFFFF);
>  			tx_fifo_write(dspi, data >> 16);
> +			tx_fifo_write(dspi, data & 0xFFFF);
>  		} else {
>  			/* MSB */
> -			tx_fifo_write(dspi, data >> 16);
>  			tx_fifo_write(dspi, data & 0xFFFF);
> +			tx_fifo_write(dspi, data >> 16);
>  		}
> -		cmd_fifo_write(dspi);
>  	} else {
>  		/* Write one entry to both TX FIFO and CMD FIFO
>  		 * simultaneously.

