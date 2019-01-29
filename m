Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF52C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EFF20856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfA2UMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:12:41 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51295 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfA2UMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:12:41 -0500
X-Originating-IP: 86.202.150.119
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr [86.202.150.119])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 516E91C0005;
        Tue, 29 Jan 2019 20:12:38 +0000 (UTC)
Date:   Tue, 29 Jan 2019 21:12:39 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: atmel-mci: enable 8 bits buswidth support
Message-ID: <20190129201239.GC19959@piout.net>
References: <20190129164950.31052-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129164950.31052-1-nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2019 17:49:12+0100, Nicolas Ferre wrote:
> This patch adds support for 8-bit buswidth.
> Relevant SDCR value modified.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/mmc/host/atmel-mci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 47189f9ed4e2..735aa5871358 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1410,6 +1410,9 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	case MMC_BUS_WIDTH_4:
>  		slot->sdc_reg |= ATMCI_SDCBUS_4BIT;
>  		break;
> +	case MMC_BUS_WIDTH_8:
> +		slot->sdc_reg |= ATMCI_SDCBUS_8BIT;
> +		break;
>  	}
>  
>  	if (ios->clock) {
> @@ -2275,8 +2278,11 @@ static int atmci_init_slot(struct atmel_mci *host,
>  	 * use only one bit for data to prevent fifo underruns and overruns
>  	 * which will corrupt data.
>  	 */
> -	if ((slot_data->bus_width >= 4) && host->caps.has_rwproof)
> +	if ((slot_data->bus_width >= 4) && host->caps.has_rwproof) {
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
> +		if (slot_data->bus_width >= 8)
> +			mmc->caps |= MMC_CAP_8_BIT_DATA;
> +	}
>  
>  	if (atmci_get_version(host) < 0x200) {
>  		mmc->max_segs = 256;
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
