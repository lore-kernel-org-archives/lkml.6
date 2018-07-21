Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD164ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B97A20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqEdXS8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B97A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeGUSwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbeGUSwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:52:13 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C59720849;
        Sat, 21 Jul 2018 17:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532195920;
        bh=ona05z4jveWzHTPOWrZeHPSXvEbNMkfHTRXuJ7kcXBY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iqEdXS8x9zK2OAZIPRYkOQVM1nz4rAKA/KbVAXhgAwkkGc+mIkppJxy/ASQYhh8hH
         QqVDg1jZ/Ys5a7K6RGHd+dHWVSs7fLA11Q6G40Sbr17yFUvodWLn93IxuflM8SpkUW
         u2iQ8o8s2VejaqzsuxegCLqXAw8/H3S7wkZKCk/w=
Date:   Sat, 21 Jul 2018 18:58:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: allow simultaneous use of buffer
 and direct mode
Message-ID: <20180721185836.5a8202a2@archlinux>
In-Reply-To: <20180716233550.6449-1-david@lechnology.com>
References: <20180716233550.6449-1-david@lechnology.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018 18:35:50 -0500
David Lechner <david@lechnology.com> wrote:

> This modifies the TI ADS7950 A/DC driver to allow the simultaneous use
> of both the triggered buffer and reading channels directly (via in-
> kernel API or sysfs).
> 
> The use case for this is on LEGO MINDSTORMS EV3. Two of the voltage
> channels are used in-kernel by a power supply driver, which reads the
> values using iio_read_channel_processed(). These channels are only read
> at a slow rate (<= 1Hz).  However, we want to be able to read 12 other
> channels at the same time using the triggered buffer at a high rate (>=
> 100Hz) without breaking the power supply driver.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
Hmm. I've wondered for a long time what the 'right' way to handle these
dual speed / method situations is.

There is a more involved solution in the iio core that would work.
When we have another in kernel user request a particular set of
channels, we could have the core setup a buffer consumer that
basically caches them.  The trick is to then make that optional
so that it only gets enabled if someone else is using the buffered
interface.  Getting that detail right was the bit that always left
me stuck.

Even then there is the potential for a really slow buffered read
to block a fast sysfs read. Hence it's less than ideal.

So let's go with what you have here and perhaps revisit in future
if it keeps turning up.

A few comments line.

Jonathan

> ---
>  drivers/iio/adc/ti-ads7950.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 0225c1b333ab..ba7e5a027490 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -58,6 +58,7 @@
>  	(((val) >> (dec)) & ((1 << (bits)) - 1))
>  
>  struct ti_ads7950_state {
> +	struct iio_dev		*indio_dev;

The moment I see this, it rings alarm bells, suggesting some
less than ideal architecture.

>  	struct spi_device	*spi;
>  	struct spi_transfer	ring_xfer[TI_ADS7950_MAX_CHAN + 2];
>  	struct spi_transfer	scan_single_xfer[3];
> @@ -68,6 +69,8 @@ struct ti_ads7950_state {
>  	unsigned int		vref_mv;
>  
>  	unsigned int		settings;
> +	__be16			single_tx;
> +	__be16			single_rx;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -299,14 +302,21 @@ static int ti_ads7950_scan_direct(struct ti_ads7950_state *st, unsigned int ch)
>  {
>  	int ret, cmd;
>  
> +	mutex_lock(&st->indio_dev->mlock);

Change it so that scan_direct is passed the indio_dev rather than st.

> +
>  	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
> -	st->tx_buf[0] = cpu_to_be16(cmd);
> +	st->single_tx = cpu_to_be16(cmd);
>  
>  	ret = spi_sync(st->spi, &st->scan_single_msg);
>  	if (ret)
> -		return ret;
> +		goto out;
> +
> +	ret = be16_to_cpu(st->single_rx);
> +
> +out:
> +	mutex_unlock(&st->indio_dev->mlock);
>  
> -	return be16_to_cpu(st->rx_buf[0]);
> +		return ret;

Indenting seems unlikely to be right!

>  }
>  
>  static int ti_ads7950_get_range(struct ti_ads7950_state *st)
> @@ -338,13 +348,7 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret < 0)
> -			return ret;
> -
>  		ret = ti_ads7950_scan_direct(st, chan->address);
> -		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -389,6 +393,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  
>  	spi_set_drvdata(spi, indio_dev);
>  
> +	st->indio_dev = indio_dev;
>  	st->spi = spi;
>  	st->settings = TI_ADS7950_CR_MANUAL | TI_ADS7950_CR_RANGE_5V;
>  
> @@ -410,13 +415,13 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	 * was read at the end of the first transfer.
>  	 */
>  
> -	st->scan_single_xfer[0].tx_buf = &st->tx_buf[0];
> +	st->scan_single_xfer[0].tx_buf = &st->single_tx;
>  	st->scan_single_xfer[0].len = 2;
>  	st->scan_single_xfer[0].cs_change = 1;
> -	st->scan_single_xfer[1].tx_buf = &st->tx_buf[0];
> +	st->scan_single_xfer[1].tx_buf = &st->single_tx;
>  	st->scan_single_xfer[1].len = 2;
>  	st->scan_single_xfer[1].cs_change = 1;
> -	st->scan_single_xfer[2].rx_buf = &st->rx_buf[0];
> +	st->scan_single_xfer[2].rx_buf = &st->single_rx;
>  	st->scan_single_xfer[2].len = 2;
>  
>  	spi_message_init_with_transfers(&st->scan_single_msg,

