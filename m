Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44A7C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7767B217D6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549102879;
	bh=+fdH/w2zAugmHdwEMMQcXoW9UFPDCuiV2igdmI2iw1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KWlx1Bci0r0kn7sjCL6dWFQhTuc6uLZYXAt8LWyiWMVRVcI6qBFzNwvT07LjcHpBT
	 8C1XhPdVS2EW1MZZdhdLc+zg27D0E9eG/jFRHQL6lEWoI74TOaEFRNetgArCSJwivd
	 LhN4las+kOdg7b0gpPlb7h2mx+IK+/jRmnDuEVBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfBBKU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:20:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfBBKU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:20:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B247020870;
        Sat,  2 Feb 2019 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549102855;
        bh=+fdH/w2zAugmHdwEMMQcXoW9UFPDCuiV2igdmI2iw1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i2bZLGxzujncRYN/k8bXege1x2mJt3q3jmNUPvLeKJc6HDt+ixFcXRK1iouTUsjZE
         H4JcxMZMFuSjj/da+1GyIWu8+6qtY7QkABU+rToJefd5jmUkKvpm6IUMQduWFeJXkN
         co9qcgROXoXKQljTiJtyNSKa2zSTzJ7SzRjw+ISM=
Date:   Sat, 2 Feb 2019 10:20:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <g.ottinger@abatec.at>
Cc:     <eugen.hristev@microchip.com>, <s.etzlstorfer@abatec.at>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in
 timeout case
Message-ID: <20190202102021.12bb0a72@archlinux>
In-Reply-To: <20190130134202.5831-1-g.ottinger@abatec.at>
References: <20190130134202.5831-1-g.ottinger@abatec.at>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 14:42:02 +0100
<g.ottinger@abatec.at> wrote:

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

Whilst I agree this looks like a correct change, I would like Maxime
to take a look as he is obviously much more familiar with the driver
than I am.

I suspect you can only actually get there in the event of a hardware
failure as that isn't actually a timeout you should ever see.
Could be wrong though!

Thanks,

Jonathan

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

