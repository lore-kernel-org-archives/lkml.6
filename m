Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590E1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECB82145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVkidHoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECB82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeIYC1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeIYC1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:27:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443CF208D9;
        Mon, 24 Sep 2018 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537820617;
        bh=A2INA+wiV5JqiuqYUJYbDj2Bfqjvfot+D8Crtm636pg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XVkidHoqU1Xmw1oMuNtmqpbKKTu+7vrtSNZaESQAYudmycxhqO/EhaNTZaYpKHDsi
         5p1Fvp9wCJ7sJsIt4wxruJ2LkL5tMlygATccF8N6iTHb8KiBVHxvkKKHjYjBind61d
         J6szUI+Ph1bV6e46tvLvFTifsmwUhjLvlCfcUW0o=
Date:   Mon, 24 Sep 2018 21:23:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/2] iio: adc: at91: fix acking DRDY irq on simple
 conversions
Message-ID: <20180924212333.797439dd@archlinux>
In-Reply-To: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
References: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018 10:51:43 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

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
> ---
> Hello Jonathan,
> 
> I moved this LCDR read/acknowledge into the IRQ handler after the conversion
> value is being read.
Ah.. This all makes more sense now. I'd misunderstood originally and thought
we were looking at a read raw that wasn't using the interrupt at all.

Sorry about that.

However, mostly by coincidence (given I misread the code) I think
this is a neater way to do this than the previous option as it
puts it near the actual read.

Given Maxime is the author of this one though I'd like to leave it
on the list a little longer before applying.

At this stage in the cycle I'll probably just queue it up for the
next merge window anyway (marked for stable). It's not exactly a new bug
after all.

Thanks,

Jonathan
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

