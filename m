Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC75BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F052148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F052148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbeHPLYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:24:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60269 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731260AbeHPLYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:24:24 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fqDck-0002cE-GT; Thu, 16 Aug 2018 10:27:18 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fqDcj-0002fZ-ON; Thu, 16 Aug 2018 10:27:17 +0200
Date:   Thu, 16 Aug 2018 10:27:17 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Wei Jinhua <wei.jinhua1@zte.com.cn>,
        Phil Reid <preid@electromag.com.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] i2c: imx: Fix race condition in dma read
Message-ID: <20180816082717.tnoslzw4hwuanvxp@pengutronix.de>
References: <20180809123207.9732-1-esben.haabendal@gmail.com>
 <20180809123207.9732-2-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180809123207.9732-2-esben.haabendal@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 02:32:05PM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> This fixes a race condition, where the DMAEN bit ends up being set after
> I2C slave has transmitted a byte following the dummy read.  When that
> happens, an interrupt is generated instead, and no DMA request is generated
> to kickstart the DMA read, and a timeout happens after DMA_TIMEOUT (1 sec).
> 
> Fixed by setting the DMAEN bit before the dummy read.
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 498c5e891649..f7bd6c21da27 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -668,9 +668,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
>  	struct imx_i2c_dma *dma = i2c_imx->dma;
>  	struct device *dev = &i2c_imx->adapter.dev;
>  
> -	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> -	temp |= I2CR_DMAEN;
> -	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>  
>  	dma->chan_using = dma->chan_rx;
>  	dma->dma_transfer_dir = DMA_DEV_TO_MEM;
> @@ -809,6 +806,8 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
>  	 */
>  	if ((msgs->len - 1) || block_data)
>  		temp &= ~I2CR_TXAK;
> +	if (i2c_imx->dma && msgs->len >= DMA_THRESHOLD && !block_data)
> +		temp |= I2CR_DMAEN;

Instead of duplicating the if condition I'd do:

	int use_dma = i2c_imx->dma && msgs->len >= DMA_THRESHOLD && !block_data;

and then simplify the two conditions to just "use_dma".

With this changed you can add my Ack.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
