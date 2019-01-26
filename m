Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D2BC282C9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9D3218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548527418;
	bh=Lb5nsk+TNV5ZShC4CzD8Gbq3WWu4HtESt6MHRMbaW0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZggZRKEGiGZHlU3ZPmF4ocC9yifH5imk251JxjQ5uGyZsEsOf8kZDW3pCGA7oxj/F
	 r31dPdzOIMaomPm2qCi7BKzPzGuimwFdWOKP01ynTaLIPdymAMkzRopZzALY7dIvDL
	 1KVGr1i62RKpXbwqRwCMvJ00yIz6zzYoomQno8Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfAZSaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 13:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfAZSaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 13:30:17 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E3E2184C;
        Sat, 26 Jan 2019 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548527416;
        bh=Lb5nsk+TNV5ZShC4CzD8Gbq3WWu4HtESt6MHRMbaW0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=woz3Ulb6RPd0Or0RUN2UoeyC+aW32mPtZ3Qj5J2BGVfX+F9FmWn7UpKZ6nNB35pxe
         sPhcHtApMJX7poamSrs4V+K43lrRmfdOHqxzmhjhHOh7nFVRb3dQzFRHINrvaroY9c
         toSYCII3rBXRwLOFLogikvGGz2G0eB4Lv/Wtie+k=
Date:   Sat, 26 Jan 2019 18:30:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     justinpopo6@gmail.com
Cc:     linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] iio: adc: ti-ads7950: inconsistency with spi msg
Message-ID: <20190126183011.00f03cc3@archlinux>
In-Reply-To: <1548440422-27943-1-git-send-email-justinpopo6@gmail.com>
References: <1548440422-27943-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 10:20:22 -0800
justinpopo6@gmail.com wrote:

> From: Justin Chen <justinpopo6@gmail.com>
> 
> To read a channel we require 3 cycles to send, process, and receive
> the data. The transfer buffer for the third transaction is left blank.
> This leaves it up to the SPI driver to decide what to do.
Interesting.  I think that means you may have a bug in your SPI driver.
The pointer in question is always left set to NULL in the adc
driver (not explicitly but it will be because ultimately comes from
a kzalloc).

Documentation for an SPI message makes it clear that NULL is
allowed.  From include/linux/spi/spi.h

"* Those segments always read the same number of bits as they
 * write; but one or the other is easily ignored by passing a null buffer
 * pointer. "

Hmm. It does say 'ignored'.  My assumption has always been that
means it would be filled with zeros, but maybe I'm wrong.

Mark?

> 
> In one particular case, if the tx buffer is not set the spi driver
> sets it to 0xff. This puts the ADC in a alarm programming state,
> therefore the following read to a channel becomes erroneous.
> 
> Instead of leaving us to the mercy of the SPI driver, we send the
> ADC cmd on the third transaction to prevent inconsistent behavior.
> 
> Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>  drivers/iio/adc/ti-ads7950.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 0ad6359..1255d8b 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -422,6 +422,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	st->scan_single_xfer[1].tx_buf = &st->single_tx;
>  	st->scan_single_xfer[1].len = 2;
>  	st->scan_single_xfer[1].cs_change = 1;
> +	st->scan_single_xfer[2].tx_buf = &st->single_tx;
>  	st->scan_single_xfer[2].rx_buf = &st->single_rx;
>  	st->scan_single_xfer[2].len = 2;
>  

