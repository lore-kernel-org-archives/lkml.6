Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBABAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F755205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500979;
	bh=V8b/IpnYgvpynFuTONwdPfRYfcp9aeQGnhbYIksrQM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wGtIQ7pi+H2TA81mcU9PvTlibNLxuJQGVwyvihPeFhUhBhHohS33TCTLq4MJ0GwtX
	 iwQXhkhOQhzTuhUja4fFuy4bzenodrHVaQ4dDYHVsXpTVdcKj9ou7CyCNpSkx7hmyY
	 F+6tfRv1SiJdkZvaURDRgJy3+/zH2asSymJQ4dqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392802AbeLVRti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:49:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388655AbeLVRte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:49:34 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CEE12054F;
        Sat, 22 Dec 2018 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545500973;
        bh=V8b/IpnYgvpynFuTONwdPfRYfcp9aeQGnhbYIksrQM4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yWYZ5c4bLYjTsGjAUelfFSd1i4F3lULZTM3KrQ8uDOsUpVYBwSaKvKngQF7kquv/i
         zwQnppWVTt+vEwHNxVCyzVkugOsRVFeDZYjO9XHkrYDgv/NsbCMPSmdO6RdXRsEWS1
         3fo50HzggxKvhCPrONmGSzqqW/lKuOJ8zjogv1nc=
Date:   Sat, 22 Dec 2018 17:49:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: Re: [PATCH v2 3/6] staging: iio: adc: ad7606: Add support for
 threaded irq
Message-ID: <20181222174928.3b3eb031@archlinux>
In-Reply-To: <1545049420-16484-4-git-send-email-stefan.popa@analog.com>
References: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
        <1545049420-16484-4-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 14:23:37 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> This patch replaces the use of a polling ring buffer with a threaded
> interrupt.
> 
> Enabling the buffer sets the CONVST signal to high. When the rising edge
> of the CONVST is applied, BUSY signal goes logic high and transitions low
> at the end of the entire conversion process. The falling edge of the BUSY
> signal triggers the interrupt.
> 
> ad7606_trigger_handler() is used as bottom half of the poll function.
> It reads data from the device and stores it in the internal buffer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7606.c | 111 +++++++++++++++++++++++++++++----------
>  drivers/staging/iio/adc/ad7606.h |   6 +--
>  2 files changed, 84 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index 97b4a83..5f0712c 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -22,6 +22,7 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/iio/triggered_buffer.h>
>  
>  #include "ad7606.h"
> @@ -86,36 +87,24 @@ static int ad7606_read_samples(struct ad7606_state *st)
>  static irqreturn_t ad7606_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> -	struct ad7606_state *st = iio_priv(pf->indio_dev);
> -
> -	gpiod_set_value(st->gpio_convst, 1);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -/**
> - * ad7606_poll_bh_to_ring() bh of trigger launched polling to ring buffer
> - * @work_s:	the work struct through which this was scheduled
> - *
> - * Currently there is no option in this driver to disable the saving of
> - * timestamps within the ring.
> - * I think the one copy of this at a time was to avoid problems if the
> - * trigger was set far too high and the reads then locked up the computer.
> - **/
> -static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
> -{
> -	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
> -						poll_work);
> -	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad7606_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> +	mutex_lock(&st->lock);
> +
>  	ret = ad7606_read_samples(st);
>  	if (ret == 0)
>  		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
>  						   iio_get_time_ns(indio_dev));
>  
> -	gpiod_set_value(st->gpio_convst, 0);
>  	iio_trigger_notify_done(indio_dev->trig);
> +	/* The rising edge of the CONVST signal starts a new conversion. */
> +	gpiod_set_value(st->gpio_convst, 1);
> +
> +	mutex_unlock(&st->lock);
> +
> +	return IRQ_HANDLED;
>  }
>  
>  static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
> @@ -366,8 +355,11 @@ static int ad7606_request_gpios(struct ad7606_state *st)
>  	return PTR_ERR_OR_ZERO(st->gpio_os);
>  }
>  
> -/**
> - *  Interrupt handler
> +/*
> + * The BUSY signal indicates when conversions are in progress, so when a rising
> + * edge of CONVST is applied, BUSY goes logic high and transitions low at the
> + * end of the entire conversion process. The falling edge of the BUSY signal
> + * triggers this interrupt.
>   */
>  static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
>  {
> @@ -375,7 +367,8 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
>  	if (iio_buffer_enabled(indio_dev)) {
> -		schedule_work(&st->poll_work);
> +		gpiod_set_value(st->gpio_convst, 0);
> +		iio_trigger_poll_chained(st->trig);
>  	} else {
>  		complete(&st->completion);
>  	}
> @@ -383,26 +376,69 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  };
>  
> +static int ad7606_validate_trigger(struct iio_dev *indio_dev,
> +				   struct iio_trigger *trig)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	if (st->trig != trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	iio_triggered_buffer_postenable(indio_dev);
> +	gpiod_set_value(st->gpio_convst, 1);
> +
> +	return 0;
> +}
> +
> +static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	gpiod_set_value(st->gpio_convst, 0);
> +
> +	return iio_triggered_buffer_predisable(indio_dev);
> +}
> +
> +static const struct iio_buffer_setup_ops ad7606_buffer_ops = {
> +	.postenable = &ad7606_buffer_postenable,
> +	.predisable = &ad7606_buffer_predisable,
> +};
> +
>  static const struct iio_info ad7606_info_no_os_or_range = {
>  	.read_raw = &ad7606_read_raw,
> +	.validate_trigger = &ad7606_validate_trigger,
>  };
>  
>  static const struct iio_info ad7606_info_os_and_range = {
>  	.read_raw = &ad7606_read_raw,
>  	.write_raw = &ad7606_write_raw,
>  	.attrs = &ad7606_attribute_group_os_and_range,
> +	.validate_trigger = &ad7606_validate_trigger,
>  };
>  
>  static const struct iio_info ad7606_info_os = {
>  	.read_raw = &ad7606_read_raw,
>  	.write_raw = &ad7606_write_raw,
>  	.attrs = &ad7606_attribute_group_os,
> +	.validate_trigger = &ad7606_validate_trigger,
>  };
>  
>  static const struct iio_info ad7606_info_range = {
>  	.read_raw = &ad7606_read_raw,
>  	.write_raw = &ad7606_write_raw,
>  	.attrs = &ad7606_attribute_group_range,
> +	.validate_trigger = &ad7606_validate_trigger,
> +};
> +
> +static const struct iio_trigger_ops ad7606_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
>  };
>  
>  static void ad7606_regulator_disable(void *data)
> @@ -434,7 +470,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	/* tied to logic low, analog input range is +/- 5V */
>  	st->range = 0;
>  	st->oversampling = 1;
> -	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
>  
>  	st->reg = devm_regulator_get(dev, "avcc");
>  	if (IS_ERR(st->reg))
> @@ -479,14 +514,32 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	if (ret)
>  		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
>  
> -	ret = devm_request_irq(dev, irq, ad7606_interrupt, IRQF_TRIGGER_FALLING,
> -			       name, indio_dev);
> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +					  indio_dev->name, indio_dev->id);
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad7606_trigger_ops;
> +	st->trig->dev.parent = dev;
> +	iio_trigger_set_drvdata(st->trig, indio_dev);
> +	ret = devm_iio_trigger_register(dev, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	ret = devm_request_threaded_irq(dev, irq,
> +					NULL,
> +					&ad7606_interrupt,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					name, indio_dev);
>  	if (ret)
>  		return ret;
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time,
>  					      &ad7606_trigger_handler,
> -					      NULL, NULL);
> +					      &ad7606_buffer_ops);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index 3e12fff..9a832d2 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -26,8 +26,6 @@ struct ad7606_chip_info {
>   * @dev		pointer to kernel device
>   * @chip_info		entry in the table of chips that describes this device
>   * @reg		regulator info for the the power supply of the device
> - * @poll_work		work struct for continuously reading data from the device
> - *			into an IIO triggered buffer
>   * @bops		bus operations (SPI or parallel)
>   * @range		voltage range selection, selects which scale to apply
>   * @oversampling	oversampling selection
> @@ -42,14 +40,13 @@ struct ad7606_chip_info {
>   *			is being read on the first channel
>   * @gpio_os		GPIO descriptors to control oversampling on the device
>   * @complete		completion to indicate end of conversion
> + * @trig		The IIO trigger associated with the device.
>   * @data		buffer for reading data from the device
>   */
> -
>  struct ad7606_state {
>  	struct device			*dev;
>  	const struct ad7606_chip_info	*chip_info;
>  	struct regulator		*reg;
> -	struct work_struct		poll_work;
>  	const struct ad7606_bus_ops	*bops;
>  	unsigned int			range;
>  	unsigned int			oversampling;
> @@ -62,6 +59,7 @@ struct ad7606_state {
>  	struct gpio_desc		*gpio_standby;
>  	struct gpio_desc		*gpio_frstdata;
>  	struct gpio_descs		*gpio_os;
> +	struct iio_trigger		*trig;
>  	struct completion		completion;
>  
>  	/*

