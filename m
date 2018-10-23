Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA6CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6484220824
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6484220824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeJWSL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:11:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42951 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWSL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:11:26 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C4DB620789; Tue, 23 Oct 2018 11:48:44 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5854820701;
        Tue, 23 Oct 2018 11:48:44 +0200 (CEST)
Date:   Tue, 23 Oct 2018 11:48:44 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] spi: add support for octo mode I/O data transfer
Message-ID: <20181023114844.7adfa054@bbrezillon>
In-Reply-To: <1540287311-1572-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1540287311-1572-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 09:37:06 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add flags for Octo mode I/O data transfer
> Required for the SPI controller which can do the data transfer (TX/RX)
> on 8 data lines e.g. NXP FlexSPI controller.
>  SPI_TX_OCTO: transmit with 8 wires
>  SPI_RX_OCTO: receive with 8 wires
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> Changes for v3:
> - Modified string 'octal' with 'octo'.
> - Add octo mode support in spi_setup().
> Changes for v2:
> - Incorporated review comments of Boris.
> 
>  drivers/spi/spi.c       | 12 ++++++++++--
>  include/linux/spi/spi.h |  2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ec395a6..6d57fa7 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1573,6 +1573,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		case 4:
>  			spi->mode |= SPI_TX_QUAD;
>  			break;
> +		case 8:
> +			spi->mode |= SPI_TX_OCTO;
> +			break;
>  		default:
>  			dev_warn(&ctlr->dev,
>  				"spi-tx-bus-width %d not supported\n",
> @@ -1591,6 +1594,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		case 4:
>  			spi->mode |= SPI_RX_QUAD;
>  			break;
> +		case 8:
> +			spi->mode |= SPI_RX_OCTO;
> +			break;
>  		default:
>  			dev_warn(&ctlr->dev,
>  				"spi-rx-bus-width %d not supported\n",
> @@ -2770,14 +2776,16 @@ int spi_setup(struct spi_device *spi)
>  	/* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
>  	 */
>  	if ((spi->mode & SPI_3WIRE) && (spi->mode &
> -		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)))
> +		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO |
> +		 SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTO)))
>  		return -EINVAL;
>  	/* help drivers fail *cleanly* when they need options
>  	 * that aren't supported with their current controller
>  	 */
>  	bad_bits = spi->mode & ~spi->controller->mode_bits;
>  	ugly_bits = bad_bits &
> -		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
> +		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO |
> +		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTO);
>  	if (ugly_bits) {
>  		dev_warn(&spi->dev,
>  			 "setup: ignoring unsupported mode bits %x\n",
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index a64235e..cea4e49 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -163,6 +163,8 @@ struct spi_device {
>  #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
>  #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
>  #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
> +#define	SPI_TX_OCTO	0x1000			/* transmit with 8 wires */
> +#define	SPI_RX_OCTO	0x2000			/* receive with 8 wires */
>  	int			irq;
>  	void			*controller_state;
>  	void			*controller_data;

