Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DEFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC8D2473F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC8D2473F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932496AbeGDHEA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:04:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34817 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeGDHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:03:59 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fabpM-0005JL-OA; Wed, 04 Jul 2018 09:03:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fabpH-0004tl-0o; Wed, 04 Jul 2018 09:03:43 +0200
Date:   Wed, 4 Jul 2018 09:03:42 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Phil Reid <preid@electromag.com.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Michail Georgios Etairidis <m.etairidis@beck-ipc.com>,
        linux-kernel@vger.kernel.org, Yuan Yao <yao.yuan@freescale.com>,
        linux-imx@nxp.com
Subject: Re: [PATCH 1/4] i2c: imx: Fix reinit_completion() use
Message-ID: <20180704070342.pgnjjffk34nkloob@pengutronix.de>
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
 <20180523095623.3347-2-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180523095623.3347-2-esben.haabendal@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc += Yuan Yao who authored DMA support and the NXP team.

On Wed, May 23, 2018 at 11:56:20AM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> Make sure to call reinit_completion() before dma is started to avoid race
> condition where reinit_compleition() is called after complete() and before

s/compleition/completion/

> wait_for_completion_timeout().

Is this a theoretical problem, or did it trigger on your side?
 
> Signed-off-by: Esben Haabendal <eha@deif.com>
Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

> ---
>  drivers/i2c/busses/i2c-imx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index d7267dd9c7bf..6fca5e64cffb 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -377,6 +377,7 @@ static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
>  		goto err_desc;
>  	}
>  
> +	reinit_completion(&dma->cmd_complete);
>  	txdesc->callback = i2c_imx_dma_callback;
>  	txdesc->callback_param = i2c_imx;
>  	if (dma_submit_error(dmaengine_submit(txdesc))) {
> @@ -631,7 +632,6 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
>  	 * The first byte must be transmitted by the CPU.
>  	 */
>  	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
> -	reinit_completion(&i2c_imx->dma->cmd_complete);
>  	time_left = wait_for_completion_timeout(
>  				&i2c_imx->dma->cmd_complete,
>  				msecs_to_jiffies(DMA_TIMEOUT));
> @@ -690,7 +690,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
>  	if (result)
>  		return result;
>  
> -	reinit_completion(&i2c_imx->dma->cmd_complete);
>  	time_left = wait_for_completion_timeout(
>  				&i2c_imx->dma->cmd_complete,
>  				msecs_to_jiffies(DMA_TIMEOUT));

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
