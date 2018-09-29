Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4D9C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BAE2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPV9itCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BAE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeI2SAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 14:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeI2SAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 14:00:03 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3E6E2073F;
        Sat, 29 Sep 2018 11:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538220715;
        bh=9uMoB8FXgNfnVVyOJ0a/iFsK6KL2vSXE3aSTs2PFPD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oPV9itCESvqnvXRqGE1jVpZnK+UoAf66TVVnwABCgYjY9zwKAdCBaRFVRanhnxt9k
         9rK6q7GMIZJIBCHG3o4oS8vRe9C1zAHs5dfkUTxtxhdOB2t9j9vzm2cMxBYS8yKL3T
         nugHp50pTNX02adaqcuAqs9ItE92Wx+DZFUw9MXE=
Date:   Sat, 29 Sep 2018 12:31:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 2/2] iio: adc: at91: fix wrong channel number in
 triggered buffer mode
Message-ID: <20180929123151.1fd0f9ec@archlinux>
In-Reply-To: <20180925131757.gjk2t277twhji5ns@M43218.corp.atmel.com>
References: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
        <1537775504-7981-2-git-send-email-eugen.hristev@microchip.com>
        <20180925131757.gjk2t277twhji5ns@M43218.corp.atmel.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 15:17:57 +0200
Ludovic Desroches <ludovic.desroches@microchip.com> wrote:

> On Mon, Sep 24, 2018 at 10:51:44AM +0300, Eugen Hristev wrote:
> > When channels are registered, the hardware channel number is not the
> > actual iio channel number.
> > This is because the driver is probed with a certain number of accessible
> > channels. Some pins are routed and some not, depending on the description of
> > the board in the DT.
> > Because of that, channels 0,1,2,3 can correspond to hardware channels
> > 2,3,4,5 for example.
> > In the buffered triggered case, we need to do the translation accordingly.
> > Fixed the channel number to stop reading the wrong channel.
> > 
> > Fixes 0e589d5fb "ARM: AT91: IIO: Add AT91 ADC driver."
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>  
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> 
> > ---
> > Changes in v2:
> > - Added 'const' spec to the declaration to avoid build warning
> > 
> >  drivers/iio/adc/at91_adc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index e3be88e..75d2f73 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -248,12 +248,14 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
> >  	struct iio_poll_func *pf = p;
> >  	struct iio_dev *idev = pf->indio_dev;
> >  	struct at91_adc_state *st = iio_priv(idev);
> > +	struct iio_chan_spec const *chan;
> >  	int i, j = 0;
> >  
> >  	for (i = 0; i < idev->masklength; i++) {
> >  		if (!test_bit(i, idev->active_scan_mask))
> >  			continue;
> > -		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, i));
> > +		chan = idev->channels + i;
> > +		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, chan->channel));
> >  		j++;
> >  	}
> >  
> > -- 
> > 2.7.4
> >   

