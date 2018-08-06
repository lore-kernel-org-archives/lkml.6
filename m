Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB4C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA05219EB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA05219EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeHFLtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:49:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33269 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeHFLtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:49:33 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fmc0m-0000RO-Qh; Mon, 06 Aug 2018 11:41:12 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fmc0l-0001tc-GP; Mon, 06 Aug 2018 11:41:11 +0200
Date:   Mon, 6 Aug 2018 11:41:11 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH RESEND 2/5] spi: imx: Use dynamic bursts only when
 bits_per_word is 8, 16 or 32
Message-ID: <20180806094111.uutolczqccm2e2ot@pengutronix.de>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
 <20180717143154.28241-3-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717143154.28241-3-maxime.chevallier@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:40:30 up 54 days, 18:49, 57 users,  load average: 0.29, 0.15,
 0.14
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:31:51PM +0200, Maxime Chevallier wrote:
> The dynamic bursts mode allows to group together multiple words into a
> single burst. To do so, it's necessary that words can be packed into the
> 32-bits FIFO entries, so we can't allow using this mode with bit_per_words
> different to 8, 16 or 32.
> 
> This prevents shitfing out extra clock ticks for transfers with

s/shitfing/shifting/

> bit_per_word values not aligned on 8 bits.
> 
> With that , we are sure that only the correct number of bits is
> shifted out at each transfer, so we don't need to mask out the remaining
> parts of the words.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/spi/spi-imx.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index d75153c995af..ecafbda5ec94 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -95,7 +95,6 @@ struct spi_imx_data {
>  	const void *tx_buf;
>  	unsigned int txfifo; /* number of words pushed in tx FIFO */
>  	unsigned int dynamic_burst, read_u32;
> -	unsigned int word_mask;
>  
>  	/* Slave mode */
>  	bool slave_mode;
> @@ -291,7 +290,6 @@ static void spi_imx_buf_rx_swap_u32(struct spi_imx_data *spi_imx)
>  		else if (bytes_per_word == 2)
>  			val = (val << 16) | (val >> 16);
>  #endif
> -		val &= spi_imx->word_mask;
>  		*(u32 *)spi_imx->rx_buf = val;
>  		spi_imx->rx_buf += sizeof(u32);
>  	}
> @@ -322,7 +320,6 @@ static void spi_imx_buf_tx_swap_u32(struct spi_imx_data *spi_imx)
>  
>  	if (spi_imx->tx_buf) {
>  		val = *(u32 *)spi_imx->tx_buf;
> -		val &= spi_imx->word_mask;
>  		spi_imx->tx_buf += sizeof(u32);
>  	}
>  
> @@ -1102,25 +1099,23 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>  	spi_imx->bits_per_word = t->bits_per_word;
>  	spi_imx->speed_hz  = t->speed_hz;
>  
> -	/* Initialize the functions for transfer */
> -	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->slave_mode) {
> -		u32 mask;
> +	/*
> +	 * Initialize the functions for transfer. To transfer non byte-aligned
> +	 * words, we have to use multiple word-size bursts, we can't use
> +	 * dynamic_burst in that case.
> +	 */
> +	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->slave_mode &&
> +	    (spi_imx->bits_per_word == 8 ||
> +	    spi_imx->bits_per_word == 16 ||
> +	    spi_imx->bits_per_word == 32)) {
>  
>  		spi_imx->read_u32  = 1;
>  
> -		mask = (1 << spi_imx->bits_per_word) - 1;
>  		spi_imx->rx = spi_imx_buf_rx_swap;
>  		spi_imx->tx = spi_imx_buf_tx_swap;
>  		spi_imx->dynamic_burst = 1;
>  		spi_imx->remainder = t->len;
>  
> -		if (spi_imx->bits_per_word <= 8)
> -			spi_imx->word_mask = mask << 24 | mask << 16
> -					     | mask << 8 | mask;
> -		else if (spi_imx->bits_per_word <= 16)
> -			spi_imx->word_mask = mask << 16 | mask;
> -		else
> -			spi_imx->word_mask = mask;
>  	} else {
>  		if (spi_imx->bits_per_word <= 8) {
>  			spi_imx->rx = spi_imx_buf_rx_u8;
> -- 
> 2.11.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
