Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F14C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730B220875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lbb+xs+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730B220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeGVImU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 04:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbeGVImU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 04:42:20 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BFE220874;
        Sun, 22 Jul 2018 07:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532245593;
        bh=rzuSjcKhoRvujVQq527iGvuu5ykjvTgQM1L8sRz1ouQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lbb+xs+6sVlo9iFJkmQbY2J4HQOgFeojVzja5hzuvKneKdJQm57kHgBgFHC7yPtxh
         eBXK5PSeR59H9lAxBCR0KIH6mDz4BjmX215STtVmB4UvKJdRqeoYvwMCjWMoxwFAru
         7M8beFdly+t6vT2cAtQnbR1ZGuUjryaLmicpPt4U=
Date:   Sun, 22 Jul 2018 08:46:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads7950: allow simultaneous use of
 buffer and direct mode
Message-ID: <20180722084629.3ca9218a@archlinux>
In-Reply-To: <20180721193734.6427-3-david@lechnology.com>
References: <20180721193734.6427-1-david@lechnology.com>
        <20180721193734.6427-3-david@lechnology.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018 14:37:34 -0500
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
> 100Hz).
> 
> Signed-off-by: David Lechner <david@lechnology.com>
One slight quirk I'd missed before.  The two new buffers are used for
dma and as such need to be in a cacheline separate from anything else
that might be corrupted.  I've just move them down to below the existing
buffers which should accomplish this.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads7950.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index f08c4de2bd10..eae987bef994 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -60,6 +60,8 @@ struct ti_ads7950_state {
>  	unsigned int		vref_mv;
>  
>  	unsigned int		settings;
> +	__be16			single_tx;
> +	__be16			single_rx;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -287,18 +289,26 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> -static int ti_ads7950_scan_direct(struct ti_ads7950_state *st, unsigned int ch)
> +static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  {
> +	struct ti_ads7950_state *st = iio_priv(indio_dev);
>  	int ret, cmd;
>  
> +	mutex_lock(&indio_dev->mlock);
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
> +	mutex_unlock(&indio_dev->mlock);
>  
> -	return be16_to_cpu(st->rx_buf[0]);
> +	return ret;
>  }
>  
>  static int ti_ads7950_get_range(struct ti_ads7950_state *st)
> @@ -330,13 +340,7 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret < 0)
> -			return ret;
> -
> -		ret = ti_ads7950_scan_direct(st, chan->address);
> -		iio_device_release_direct_mode(indio_dev);
> +		ret = ti_ads7950_scan_direct(indio_dev, chan->address);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -402,13 +406,13 @@ static int ti_ads7950_probe(struct spi_device *spi)
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

