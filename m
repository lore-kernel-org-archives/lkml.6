Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F3AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664802098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664802098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeJDP5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:57:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57618 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbeJDP5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:57:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F22A0208E7; Thu,  4 Oct 2018 11:04:55 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9093F2072C;
        Thu,  4 Oct 2018 11:04:45 +0200 (CEST)
Date:   Thu, 4 Oct 2018 11:04:46 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        vigneshr@ti.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        computersforpeace@gmail.com, frieder.schrempf@exceet.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] spi: add support for octal I/O data transfer
Message-ID: <20181004110446.5e1bb255@bbrezillon>
In-Reply-To: <1538642920-3843-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1538642920-3843-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Thu,  4 Oct 2018 14:18:37 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add flags for Octal I/O data transfer
> Required for the SPI controller which can do the data transfer (TX/RX)
> on 8 data lines e.g. NXP FlexSPI controller.
>  SPI_TX_OCTAL: transmit with 8 wires
>  SPI_RX_OCTAL: receive with 8 wires
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  drivers/spi/spi.c       | 6 ++++++
>  include/linux/spi/spi.h | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ec395a6..80f672f 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1573,6 +1573,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		case 4:
>  			spi->mode |= SPI_TX_QUAD;
>  			break;
> +		case 8:
> +			spi->mode |= SPI_TX_OCTAL;
> +			break;
>  		default:
>  			dev_warn(&ctlr->dev,
>  				"spi-tx-bus-width %d not supported\n",
> @@ -1591,6 +1594,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		case 4:
>  			spi->mode |= SPI_RX_QUAD;
>  			break;
> +		case 8:
> +			spi->mode |= SPI_RX_OCTAL;
> +			break;
>  		default:
>  			dev_warn(&ctlr->dev,
>  				"spi-rx-bus-width %d not supported\n",
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index a64235e..2d21307 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -163,6 +163,8 @@ struct spi_device {
>  #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
>  #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
>  #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
> +#define	SPI_TX_OCTAL	0x1000			/* transmit with 8 wires */
> +#define	SPI_RX_OCTAL	0x2000			/* receive with 8 wires */
>  	int			irq;
>  	void			*controller_state;
>  	void			*controller_data;

You're still not updating spi-mem.c to check those flags and
SPI_MEM_MAX_BUSWIDTH is not updated to match the new limit (8 instead
of 4).

Regards,

Boris
