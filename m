Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718CCC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C23321836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544967688;
	bh=GbqO9SU46DtCiCBdjZlIRXU6eO4ccjxYt0ExW2DydCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YPIubBdJnIS6GS3avSl4I6OZTw9yixDRl1qGW/pSg4dUY1Mw7BiZ14NKAABVNWC9w
	 9XkMWvfsl1Q6+nPI8eYddJYlzvatjhDZI2sCk2KHDzm9IIlFH09BcaujoSZvqzNKee
	 znZCrpDOFJMs9aIcqx2Oe8OCjusIpoW5Bi92dtGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbeLPNl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:41:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbeLPNl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:41:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F377217F9;
        Sun, 16 Dec 2018 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544967685;
        bh=GbqO9SU46DtCiCBdjZlIRXU6eO4ccjxYt0ExW2DydCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MeWvUHy7CE2yCFK6+qLI8b5hmX+2IolNZ8imkGGdb6gNLaIH6cNOBghyBLtJjgPfR
         YT1Hf4avBS9EOew5t8+Ub1hPOsEnYX+dvx/mLOFPMR5F182zaZ53ILfXqUsv7TmAdy
         Tyfueyhpz9V8MXwFk9VxXGo79QBHIb51b2eMB/Uo=
Date:   Sun, 16 Dec 2018 13:41:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: Re: [PATCH 03/11] staging: iio: adc: ad7606: Use
 wait-for-completion handler
Message-ID: <20181216134120.7e23a143@archlinux>
In-Reply-To: <1544705183-13288-4-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
        <1544705183-13288-4-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 14:46:15 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> This patch replaces the use of wait_event_interruptible() with
> wait_for_completion_timeout() when reading the result of a single
> conversion. In this way, if the interrupt never occurs, the program will
> not remain blocked.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Looks good and not related to the previous 2 that obviously need
a v2.  I'll cherry pick what I can from the series to minimise
the number that you need to send again.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7606.c | 14 +++++++-------
>  drivers/staging/iio/adc/ad7606.h |  6 ++----
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index aa5ab1e..4b1bc20 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -118,12 +118,13 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	st->done = false;
>  	gpiod_set_value(st->gpio_convst, 1);
> -
> -	ret = wait_event_interruptible(st->wq_data_avail, st->done);
> -	if (ret)
> +	ret = wait_for_completion_timeout(&st->completion,
> +					  msecs_to_jiffies(1000));
> +	if (!ret) {
> +		ret = -ETIMEDOUT;
>  		goto error_ret;
> +	}
>  
>  	ret = ad7606_read_samples(st);
>  	if (ret == 0)
> @@ -388,8 +389,7 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
>  	if (iio_buffer_enabled(indio_dev)) {
>  		schedule_work(&st->poll_work);
>  	} else {
> -		st->done = true;
> -		wake_up_interruptible(&st->wq_data_avail);
> +		complete(&st->completion);
>  	}
>  
>  	return IRQ_HANDLED;
> @@ -473,7 +473,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	indio_dev->channels = st->chip_info->channels;
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
> -	init_waitqueue_head(&st->wq_data_avail);
> +	init_completion(&st->completion);
>  
>  	ret = ad7606_reset(st);
>  	if (ret)
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index e365fa0..cf20ca2 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -28,11 +28,9 @@ struct ad7606_chip_info {
>   * @reg		regulator info for the the power supply of the device
>   * @poll_work		work struct for continuously reading data from the device
>   *			into an IIO triggered buffer
> - * @wq_data_avail	wait queue struct for buffer mode
>   * @bops		bus operations (SPI or parallel)
>   * @range		voltage range selection, selects which scale to apply
>   * @oversampling	oversampling selection
> - * @done		marks whether reading data is done
>   * @base_address	address from where to read data in parallel operation
>   * @lock		protect sensor state from concurrent accesses to GPIOs
>   * @gpio_convst	GPIO descriptor for conversion start signal (CONVST)
> @@ -43,6 +41,7 @@ struct ad7606_chip_info {
>   * @gpio_frstdata	GPIO descriptor for reading from device when data
>   *			is being read on the first channel
>   * @gpio_os		GPIO descriptors to control oversampling on the device
> + * @complete		completion to indicate end of conversion
>   * @data		buffer for reading data from the device
>   */
>  
> @@ -51,11 +50,9 @@ struct ad7606_state {
>  	const struct ad7606_chip_info	*chip_info;
>  	struct regulator		*reg;
>  	struct work_struct		poll_work;
> -	wait_queue_head_t		wq_data_avail;
>  	const struct ad7606_bus_ops	*bops;
>  	unsigned int			range;
>  	unsigned int			oversampling;
> -	bool				done;
>  	void __iomem			*base_address;
>  
>  	struct mutex			lock; /* protect sensor state */
> @@ -65,6 +62,7 @@ struct ad7606_state {
>  	struct gpio_desc		*gpio_standby;
>  	struct gpio_desc		*gpio_frstdata;
>  	struct gpio_descs		*gpio_os;
> +	struct completion		completion;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the

