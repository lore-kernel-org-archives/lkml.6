Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5655BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A73120700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfBVJ5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:57:18 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:35071 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfBVJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:57:17 -0500
X-IronPort-AV: E=Sophos;i="5.58,399,1544511600"; 
   d="scan'208";a="26982101"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Feb 2019 02:57:16 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Fri, 22 Feb 2019
 02:57:15 -0700
Date:   Fri, 22 Feb 2019 10:56:56 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <g.ottinger@abatec.at>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        <eugen.hristev@microchip.com>, <s.etzlstorfer@abatec.at>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout
 case
Message-ID: <20190222095656.gl3j46tqtlinhfbr@M43218.corp.atmel.com>
Mail-Followup-To: g.ottinger@abatec.at,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, eugen.hristev@microchip.com,
        s.etzlstorfer@abatec.at, "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <jic23@kernel.org>
References: <20190130134202.5831-1-g.ottinger@abatec.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190130134202.5831-1-g.ottinger@abatec.at>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 02:42:02PM +0100, g.ottinger@abatec.at wrote:
> From: Georg Ottinger <g.ottinger@abatec.at>
> 
> Having a brief look at at91_adc_read_raw() it is obvious that in the case
> of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR registers is
> omitted. If 2 different channels are queried we can end up with a
> situation where two interrupts are enabled, but only one interrupt is
> cleared in the interrupt handler. Resulting in a interrupt loop and a
> system hang.
> 
> Signed-off-by: Georg Ottinger <g.ottinger@abatec.at>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
>  drivers/iio/adc/at91_adc.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 75d2f7358..596841a3c 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -704,23 +704,29 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  		ret = wait_event_interruptible_timeout(st->wq_data_avail,
>  						       st->done,
>  						       msecs_to_jiffies(1000));
> -		if (ret == 0)
> -			ret = -ETIMEDOUT;
> -		if (ret < 0) {
> -			mutex_unlock(&st->lock);
> -			return ret;
> -		}
> -
> -		*val = st->last_value;
>  
> +		/* Disable interrupts, regardless if adc conversion was
> +		 * successful or not
> +		 */
>  		at91_adc_writel(st, AT91_ADC_CHDR,
>  				AT91_ADC_CH(chan->channel));
>  		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
>  
> -		st->last_value = 0;
> -		st->done = false;
> +		if (ret > 0) {
> +			/* a valid conversion took place */
> +			*val = st->last_value;
> +			st->last_value = 0;
> +			st->done = false;
> +			ret = IIO_VAL_INT;
> +		} else if (ret == 0) {
> +			/* conversion timeout */
> +			dev_err(&idev->dev, "ADC Channel %d timeout.\n",
> +				chan->channel);
> +			ret = -ETIMEDOUT;
> +		}
> +
>  		mutex_unlock(&st->lock);
> -		return IIO_VAL_INT;
> +		return ret;
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = st->vref_mv;
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
