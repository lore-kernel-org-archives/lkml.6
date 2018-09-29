Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9D0C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2296A2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x2MLRemh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2296A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeI2R7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbeI2R7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:59:18 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49F2E2073F;
        Sat, 29 Sep 2018 11:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538220671;
        bh=a8qSyKtkOc2IbusDHpELkozS+nhC1lFzPXgdcFZF47M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x2MLRemhZ3jmx+CDgoj0iT4FPrUJnTq39vRAiQeOjNzS8v/7zY9X2aZUu172/xjWo
         ki9SoNfR2XIShK3I2zag99bPQHturA9O2ILEEdrv0y92fJM02ihfGdES31Ml8mnZ72
         PXTxw3FfDbViGwqNBXPNg9h/prXbfMfdeVKgX9SE=
Date:   Sat, 29 Sep 2018 12:31:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/2] iio: adc: at91: fix acking DRDY irq on simple
 conversions
Message-ID: <20180929123107.0d0053e3@archlinux>
In-Reply-To: <20180925131739.2nuoelhqmkszamqo@M43218.corp.atmel.com>
References: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
        <20180925131739.2nuoelhqmkszamqo@M43218.corp.atmel.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 15:17:39 +0200
Ludovic Desroches <ludovic.desroches@microchip.com> wrote:

> On Mon, Sep 24, 2018 at 10:51:43AM +0300, Eugen Hristev wrote:
> > When doing simple conversions, the driver did not acknowledge the DRDY irq.
> > If this irq status is not acked, it will be left pending, and as soon as a
> > trigger is enabled, the irq handler will be called, it doesn't know why
> > this status has occurred because no channel is pending, and then it will go
> > int a irq loop and board will hang.
> > To avoid this situation, read the LCDR after a raw conversion is done.
> > 
> > Fixes 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>  
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 
Applied to the togreg branch of iio.git and marked for stable.

It's been broken long enough that I think it can wait for the merge window
coming in a few weeks time.

Thanks,

Jonathan

> 
> > ---
> > Hello Jonathan,
> > 
> > I moved this LCDR read/acknowledge into the IRQ handler after the conversion
> > value is being read.
> > Sorry about the noise to stable@vger, removed from message.
> > 
> > Thanks,
> > Eugen
> > 
> >  drivers/iio/adc/at91_adc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index 44b5168..e3be88e 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -279,6 +279,8 @@ static void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
> >  		iio_trigger_poll(idev->trig);
> >  	} else {
> >  		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
> > +		/* Needed to ACK the DRDY interruption */
> > +		at91_adc_readl(st, AT91_ADC_LCDR);
> >  		st->done = true;
> >  		wake_up_interruptible(&st->wq_data_avail);
> >  	}
> > -- 
> > 2.7.4
> >   

