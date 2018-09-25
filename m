Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C07C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F3B2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F3B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeIYTZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:25:13 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:32620 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeIYTZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:25:12 -0400
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="18387805"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Sep 2018 06:17:42 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Tue, 25 Sep 2018
 06:17:40 -0700
Date:   Tue, 25 Sep 2018 15:17:39 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
CC:     <jic23@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/2] iio: adc: at91: fix acking DRDY irq on simple
 conversions
Message-ID: <20180925131739.2nuoelhqmkszamqo@M43218.corp.atmel.com>
Mail-Followup-To: Eugen Hristev <eugen.hristev@microchip.com>,
        jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        nicolas.ferre@microchip.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
References: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:51:43AM +0300, Eugen Hristev wrote:
> When doing simple conversions, the driver did not acknowledge the DRDY irq.
> If this irq status is not acked, it will be left pending, and as soon as a
> trigger is enabled, the irq handler will be called, it doesn't know why
> this status has occurred because no channel is pending, and then it will go
> int a irq loop and board will hang.
> To avoid this situation, read the LCDR after a raw conversion is done.
> 
> Fixes 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

> ---
> Hello Jonathan,
> 
> I moved this LCDR read/acknowledge into the IRQ handler after the conversion
> value is being read.
> Sorry about the noise to stable@vger, removed from message.
> 
> Thanks,
> Eugen
> 
>  drivers/iio/adc/at91_adc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 44b5168..e3be88e 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -279,6 +279,8 @@ static void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
>  		iio_trigger_poll(idev->trig);
>  	} else {
>  		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
> +		/* Needed to ACK the DRDY interruption */
> +		at91_adc_readl(st, AT91_ADC_LCDR);
>  		st->done = true;
>  		wake_up_interruptible(&st->wq_data_avail);
>  	}
> -- 
> 2.7.4
> 
