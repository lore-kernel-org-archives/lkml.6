Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E196C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C854B219EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C854B219EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeHFL3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:29:37 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52247 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeHFL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:29:37 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fmbha-0006kB-8i; Mon, 06 Aug 2018 11:21:22 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fmbhZ-0001Po-Ts; Mon, 06 Aug 2018 11:21:21 +0200
Date:   Mon, 6 Aug 2018 11:21:21 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH RESEND 3/5] spi: imx: Use correct number of bytes per
 words
Message-ID: <20180806092121.s7kuwf3yamrerw24@pengutronix.de>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
 <20180717143154.28241-4-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717143154.28241-4-maxime.chevallier@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:21:07 up 54 days, 18:30, 56 users,  load average: 0.15, 0.13,
 0.21
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:31:52PM +0200, Maxime Chevallier wrote:
> The SPI core enforces that we always use the next power-of-two number of
> bytes to store words. As a result, a 24 bits word will be stored in 4
> bytes.
> 
> This commit fixes the spi_imx_bytes_per_word function to return the
> correct number of bytes.
> 
> This also allows to get rid of unnecessary checks in the can_dma
> function, since the SPI core validates that we always have a transfer
> length that is a multiple of the number of bytes per word.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/spi/spi-imx.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index ecafbda5ec94..3ae706dac660 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -202,7 +202,12 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
>  
>  static int spi_imx_bytes_per_word(const int bits_per_word)
>  {
> -	return DIV_ROUND_UP(bits_per_word, BITS_PER_BYTE);
> +	if (bits_per_word <= 8)
> +		return 1;
> +	else if (bits_per_word <= 16)
> +		return 2;
> +	else
> +		return 4;
>  }
>  
>  static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
> @@ -219,9 +224,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>  
>  	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
>  
> -	if (bytes_per_word != 1 && bytes_per_word != 2 && bytes_per_word != 4)
> -		return false;
> -
>  	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
>  		if (!(transfer->len % (i * bytes_per_word)))
>  			break;
> -- 
> 2.11.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
