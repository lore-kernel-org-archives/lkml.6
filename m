Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BD6ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316942145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v7KQpi+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316942145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeIYC3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeIYC3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:29:43 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B7A208D9;
        Mon, 24 Sep 2018 20:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537820745;
        bh=y1nI+8+4A6MenaLTIv8naJL/Q9xWX3h7+PzQSMzkmGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v7KQpi+Hr3tCO4mp+IaoPicG3Zpkj0499ZtG17AStYZ+TTrdbm1X4vVlvd++0RP0+
         ygw/4Z8Mb8X55pu3sA72zOKX0DgZvx/2+AvPTeVqGwJRfVFdmhXDBNtq5e6w7OJvUI
         7sAp4iidir2CszdjIaYdoLuAkqHaqNK+9ORSCx08=
Date:   Mon, 24 Sep 2018 21:25:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 2/2] iio: adc: at91: fix wrong channel number in
 triggered buffer mode
Message-ID: <20180924212541.22c7eec2@archlinux>
In-Reply-To: <1537775504-7981-2-git-send-email-eugen.hristev@microchip.com>
References: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
        <1537775504-7981-2-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018 10:51:44 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

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
Again.  Looks entirely sensible to me, but I'd like to leave it
a little longer for Maxime to have an opportunity to comment.
(or anyone else for that matter!)

Do give me a poke if I seem to have forgotten this in a week or so
though.

Thanks,

Jonathan

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

