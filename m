Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBC5C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1153F2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1153F2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeJWSLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:11:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42969 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWSLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:11:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3B7F6208BE; Tue, 23 Oct 2018 11:49:01 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id CA04120701;
        Tue, 23 Oct 2018 11:49:00 +0200 (CEST)
Date:   Tue, 23 Oct 2018 11:49:00 +0200
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
Subject: Re: [PATCH v3 2/7] spi: spi-mem: add support for octo mode I/O data
 transfer
Message-ID: <20181023114900.2ff4cbfc@bbrezillon>
In-Reply-To: <1540287311-1572-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1540287311-1572-3-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 09:37:13 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add support for octo mode I/O data transfer in spi-mem framework.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> Changes for v3:
> - Modified string 'octal' with 'octo'.
> Changes for v2:
> - Patch added in v2 version.
> 
>  drivers/spi/spi-mem.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index c6bdea7..2379efc 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -12,7 +12,7 @@
>  
>  #include "internals.h"
>  
> -#define SPI_MEM_MAX_BUSWIDTH		4
> +#define SPI_MEM_MAX_BUSWIDTH		8
>  
>  /**
>   * spi_controller_dma_map_mem_op_data() - DMA-map the buffer attached to a
> @@ -121,6 +121,13 @@ static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
>  
>  		break;
>  
> +	case 8:
> +		if ((tx && (mode & SPI_TX_OCTO)) ||
> +		    (!tx && (mode & SPI_RX_OCTO)))
> +			return 0;
> +
> +		break;
> +
>  	default:
>  		break;
>  	}

