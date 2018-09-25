Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA5C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5088F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5088F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbeIYTZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:25:59 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:32649 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeIYTZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:25:59 -0400
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="18387827"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Sep 2018 06:18:25 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Tue, 25 Sep 2018
 06:17:58 -0700
Date:   Tue, 25 Sep 2018 15:17:57 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
CC:     <jic23@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 2/2] iio: adc: at91: fix wrong channel number in
 triggered buffer mode
Message-ID: <20180925131757.gjk2t277twhji5ns@M43218.corp.atmel.com>
Mail-Followup-To: Eugen Hristev <eugen.hristev@microchip.com>,
        jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        nicolas.ferre@microchip.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
References: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
 <1537775504-7981-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1537775504-7981-2-git-send-email-eugen.hristev@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:51:44AM +0300, Eugen Hristev wrote:
> When channels are registered, the hardware channel number is not the
> actual iio channel number.
> This is because the driver is probed with a certain number of accessible
> channels. Some pins are routed and some not, depending on the description of
> the board in the DT.
> Because of that, channels 0,1,2,3 can correspond to hardware channels
> 2,3,4,5 for example.
> In the buffered triggered case, we need to do the translation accordingly.
> Fixed the channel number to stop reading the wrong channel.
> 
> Fixes 0e589d5fb "ARM: AT91: IIO: Add AT91 ADC driver."
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
> Changes in v2:
> - Added 'const' spec to the declaration to avoid build warning
> 
>  drivers/iio/adc/at91_adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index e3be88e..75d2f73 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -248,12 +248,14 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *idev = pf->indio_dev;
>  	struct at91_adc_state *st = iio_priv(idev);
> +	struct iio_chan_spec const *chan;
>  	int i, j = 0;
>  
>  	for (i = 0; i < idev->masklength; i++) {
>  		if (!test_bit(i, idev->active_scan_mask))
>  			continue;
> -		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, i));
> +		chan = idev->channels + i;
> +		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, chan->channel));
>  		j++;
>  	}
>  
> -- 
> 2.7.4
> 
