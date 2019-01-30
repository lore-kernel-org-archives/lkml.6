Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31BCC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17FB218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548868528;
	bh=rL8MOHGzlA9uP8ZVfBxcHv6afRZ6IvHg9FHRaOPcosk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DTj0y9mD+MjgMl3pBwLzavMpXYLJP+mcWP6bdKgjIfe2reLow8puyzuMticeyt+GQ
	 ElqP4MuusP6hXxCZ3DUI2o4Xjn1udGNbnvJjyi/XUM0YSvAxVXy62Khqqd3fsvOq4I
	 +VRz2mFh6/wOMZ9UCPL3Fv6awhj5EaeW2PPJp0EE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfA3RP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbfA3RPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:15:25 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A9502087F;
        Wed, 30 Jan 2019 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548868525;
        bh=rL8MOHGzlA9uP8ZVfBxcHv6afRZ6IvHg9FHRaOPcosk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YO2hnQZac79tNmomIgsJVI8OVsrSL2Qx3EndLyD28MP07Ics+sQpM5I9hBgLBYUZZ
         K9hT1fGkj+1ZQOHuJ11Ae1pH69bglZxftA/ej4r/u60uibd4BZ83hKrqUhu9plKZz4
         z5dw4Av/dwlRfgAnpzErEbFw5xiMb+ev/WpIDOlU=
Date:   Wed, 30 Jan 2019 18:15:15 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/9] spi: atmel-quadspi: optimize qspi init
Message-ID: <20190130181505.4f495d3a@bbrezillon>
In-Reply-To: <20190130150818.24902-2-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-2-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 15:08:29 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Set the QSPI controller in Serial Memory Mode at init and not
> at each exec_op() call.

If you ever want to support regular SPI you'll have to put it back to
atmel_qspi_exec_op(), so I'm not sure this is a good move. Another
approach would be to cache the MR value to avoid doing a write access
on the bus when the value hasn't changed.

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/spi/atmel-quadspi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index ddc712410812..f79b17792a11 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -238,8 +238,6 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>  	ifr = QSPI_IFR_INSTEN;
>  
> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> -
>  	mode = find_mode(op);
>  	if (mode < 0)
>  		return -ENOTSUPP;
> @@ -381,6 +379,9 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
>  	/* Reset the QSPI controller */
>  	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
>  
> +	/* Set the QSPI controller in Serial Memory Mode */
> +	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +
>  	/* Enable the QSPI controller */
>  	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
>  

