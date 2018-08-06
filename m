Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A75C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7B7219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7B7219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbeHFL0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58279 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHFL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:11 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fmbeH-00062W-Qn; Mon, 06 Aug 2018 11:17:57 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fmbeH-0001Ie-Ea; Mon, 06 Aug 2018 11:17:57 +0200
Date:   Mon, 6 Aug 2018 11:17:57 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH RESEND 4/5] spi: imx: remove unnecessary check in
 spi_imx_can_dma
Message-ID: <20180806091757.fnbonh66kd2cuuyk@pengutronix.de>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
 <20180717143154.28241-5-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717143154.28241-5-maxime.chevallier@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:15:55 up 54 days, 18:25, 56 users,  load average: 0.20, 0.19,
 0.28
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:31:53PM +0200, Maxime Chevallier wrote:
> The spi_imx_can_dma function computes the watermark level so that
> the transfer will fit in exactly N bursts (without a remainder).
> 
> The smallest watermark level possible being one FIFO entry per burst, we
> can't never have a case where the transfer size isn't divsiible by 1.

s/can't never/can never/
s/divsiible/divisible/

Otherwise:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> Remove the extra check for the wml being different than 0.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/spi/spi-imx.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 3ae706dac660..ef6d3648396a 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -229,9 +229,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>  			break;
>  	}
>  
> -	if (i == 0)
> -		return false;
> -
>  	spi_imx->wml = i;
>  	spi_imx->dynamic_burst = 0;
>  
> -- 
> 2.11.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
