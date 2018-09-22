Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A71C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F43A21522
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm60PJU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F43A21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeIVQYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 12:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbeIVQYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 12:24:33 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A59214C4;
        Sat, 22 Sep 2018 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537612287;
        bh=+U+LxMZtqu1tnyEvD8as4V1J9/Gn90sNcswvKETa8M8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rm60PJU2MTGNChr+RfFtbEwaLtGSYzhPoWn1kwlM2jnVP1uL0WA0ruU9wdq0Yptut
         W36pf22kuiZmucccqyUG1bijKWbew0Rfja4ivhOS2oGniVQJJSp5uYWGIdakEtrNts
         zcn/pGgu2EV7qJBvMmV+qMpIkE1XbBsv6SlB5qhU=
Date:   Sat, 22 Sep 2018 11:31:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: at91: fix acking DRDY irq on simple
 conversions
Message-ID: <20180922113123.2c8da044@archlinux>
In-Reply-To: <1537447238-18674-1-git-send-email-eugen.hristev@microchip.com>
References: <1537447238-18674-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 15:40:37 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> When doing simple conversions, the driver did not acknowledge the DRDY irq.
> If this irq is not acked, it will be left pending, and as soon as a trigger
> is enabled, the irq handler will be called, it doesn't know why this irq
> has occurred because no channel is pending, and then we will have irq loop
> and board will hang.
> 
> Fixes 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/iio/adc/at91_adc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 44b5168..e85f859 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -712,6 +712,11 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  		at91_adc_writel(st, AT91_ADC_CHDR,
>  				AT91_ADC_CH(chan->channel));
>  		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
> +		/*
> +		 * we need to ack the DRDY irq, otherwise it will be
> +		 * left pending and irq handler will be confused
> +		 */
> +		at91_adc_readl(st, AT91_ADC_LCDR);

I'm curious as to how things were working before.  Does this only occur
if we do a raw_read whilst the buffer is enabled?

I would have assumed when it's not enabled, the irq would be masked and
never generated in the first place...

It may be that what we actually need to do is to prevent read_raw accesses
when the buffer is enabled (like lots of other drivers do precisely to
avoid this sort of condition). The problem there comes if we have
existing applications doing this combination as we are then breaking
userspace. If that's the case we'll need to be a bit more clever.

Hammering down an irq state in a non irq handling path isn't a good
solution.

Jonathan

>  
>  		st->last_value = 0;
>  		st->done = false;

