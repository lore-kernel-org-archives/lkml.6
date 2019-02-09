Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0201DC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC07D21929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549731651;
	bh=j5t/Bjmp+iMytDtpRx3EGJ/OR2p6ayJ4lDT/JcLViTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jsKAzg84ihSJjMCqL+GTHRTcjwc5vk6n3biF0Q26pxrj/17vxuW3XvZiVwpP3GcKD
	 d5FFswgXQREqRk/bhfz1/KGH7IhyT2Tdc5RvaBQBfBPqxytK8HeMXxrghkMXE5Eqf+
	 D4HqzrNWM1rTinZJT/DmBB6AJ0lWsfdflry2x3P8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfBIRAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:00:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfBIRAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:00:50 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15B5521919;
        Sat,  9 Feb 2019 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549731648;
        bh=j5t/Bjmp+iMytDtpRx3EGJ/OR2p6ayJ4lDT/JcLViTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aePRf8mbrR12WaqKpNYDwuGJGU/1a3G0PcVtPQBpNGaCDUMQ4YvzvjufbTcDXHPvJ
         UNlXm6nxovZor6oq3cgPFcVhnEcnUUVgQmzyBguU8XN9KEbRWqDgOMR336oPfDPsqX
         OakdMueKPggO91ZBUbLLEby83FKLtXEAV5AvZCiA=
Date:   Sat, 9 Feb 2019 17:00:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     justinpopo6@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        david@lechnology.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: add GPIO support
Message-ID: <20190209170042.69a78684@archlinux>
In-Reply-To: <1549653856-47409-1-git-send-email-justinpopo6@gmail.com>
References: <1549653856-47409-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Feb 2019 11:24:16 -0800
justinpopo6@gmail.com wrote:

> From: Justin Chen <justinpopo6@gmail.com>
>=20
> The ADS79XX has GPIO pins that can be used. Add support for the GPIO
> pins using the GPIO chip framework.
>=20
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Hi Justin,

Unfortunately the existing driver is making incorrect use of
the indio_dev->mlock mutex.  That used to get abused a lot before
we clamped down on it being for only one purpose, protection of
the 'mode' of the iio device. It's about stopping anything interfering
with buffered captures by talking to the device in a way that breaks
them.

I'm not sure if the original driver was trying to use it for this
purpose and protecting it's buffers.  Even if so, there should be
an additional local lock to cover those chip specific elements.
Any use of mlock should be through the iio_device_claim_direct_mode
function etc.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads7950.c | 166 +++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 164 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 0ad6359..c54706ad 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -17,6 +17,7 @@
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -36,10 +37,14 @@
>   */
>  #define TI_ADS7950_VA_MV_ACPI_DEFAULT	5000
> =20
> +#define TI_ADS7950_CR_GPIO	BIT(14)
>  #define TI_ADS7950_CR_MANUAL	BIT(12)
>  #define TI_ADS7950_CR_WRITE	BIT(11)
>  #define TI_ADS7950_CR_CHAN(ch)	((ch) << 7)
>  #define TI_ADS7950_CR_RANGE_5V	BIT(6)
> +#define TI_ADS7950_CR_GPIO_DATA	BIT(5)
> +#define TI_ADS7950_NUM_GPIOS	4
> +#define TI_ADS7950_GPIO_MASK	GENMASK(TI_ADS7950_NUM_GPIOS - 1, 0)
> =20
>  #define TI_ADS7950_MAX_CHAN	16
> =20
> @@ -56,11 +61,17 @@ struct ti_ads7950_state {
>  	struct spi_message	ring_msg;
>  	struct spi_message	scan_single_msg;
> =20
> +	struct iio_dev		*indio_dev;
> +	struct gpio_chip	*chip;
> +
>  	struct regulator	*reg;
>  	unsigned int		vref_mv;
> =20
>  	unsigned int		settings;
> =20
> +	unsigned int		gpio_direction_bitmask;
> +	unsigned int		gpio_signal_bitmask;
> +
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -248,7 +259,8 @@ static int ti_ads7950_update_scan_mode(struct iio_dev=
 *indio_dev,
> =20
>  	len =3D 0;
>  	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels) {
> -		cmd =3D TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(i) | st->settings;
> +		cmd =3D TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(i) | st->settings
> +		      | (st->gpio_signal_bitmask & TI_ADS7950_GPIO_MASK);
>  		st->tx_buf[len++] =3D cmd;
>  	}
> =20
> @@ -288,7 +300,8 @@ static int ti_ads7950_scan_direct(struct iio_dev *ind=
io_dev, unsigned int ch)
> =20
>  	mutex_lock(&indio_dev->mlock);
> =20
> -	cmd =3D TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
> +	cmd =3D TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings
> +	      | (st->gpio_signal_bitmask & TI_ADS7950_GPIO_MASK);
>  	st->single_tx =3D cmd;
> =20
>  	ret =3D spi_sync(st->spi, &st->scan_single_msg);
> @@ -362,10 +375,149 @@ static const struct iio_info ti_ads7950_info =3D {
>  	.update_scan_mode	=3D ti_ads7950_update_scan_mode,
>  };
> =20
> +static void ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
> +			   int value)
> +{
> +	struct ti_ads7950_state *st =3D gpiochip_get_data(chip);
> +
> +	mutex_lock(&st->indio_dev->mlock);
> +
> +	if (value)
> +		st->gpio_signal_bitmask |=3D BIT(offset);
> +	else
> +		st->gpio_signal_bitmask &=3D ~BIT(offset);
> +
> +	st->single_tx =3D cpu_to_be16(TI_ADS7950_CR_MANUAL | TI_ADS7950_CR_WRIT=
E |
> +			(st->gpio_signal_bitmask & TI_ADS7950_GPIO_MASK));
> +	spi_sync(st->spi, &st->scan_single_msg);
> +
> +	mutex_unlock(&st->indio_dev->mlock);
> +}
> +
> +static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct ti_ads7950_state *st =3D gpiochip_get_data(chip);
> +	int ret;
> +
> +	mutex_lock(&st->indio_dev->mlock);
> +
> +	/* If set as output, return the output */
> +	if (st->gpio_direction_bitmask & BIT(offset)) {
> +		ret =3D st->gpio_signal_bitmask & BIT(offset);
> +		goto out;
> +	}
> +
> +	st->single_tx =3D cpu_to_be16(TI_ADS7950_CR_MANUAL | TI_ADS7950_CR_WRIT=
E |
> +				    TI_ADS7950_CR_GPIO_DATA);
> +	ret =3D spi_sync(st->spi, &st->scan_single_msg);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
> +
> +out:
> +	mutex_unlock(&st->indio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +static int ti_ads7950_get_direction(struct gpio_chip *chip,
> +				    unsigned int offset)
> +{
> +	struct ti_ads7950_state *st =3D gpiochip_get_data(chip);
> +
> +	return !(st->gpio_direction_bitmask & BIT(offset));
> +}
> +
> +static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
> +				     int input)
> +{
> +	struct ti_ads7950_state *st =3D gpiochip_get_data(chip);
> +	int ret =3D 0;
> +
> +	mutex_lock(&st->indio_dev->mlock);
> +
> +	if (input && (st->gpio_direction_bitmask & BIT(offset)))
> +		st->gpio_direction_bitmask &=3D ~BIT(offset);
> +	else if (!input && !(st->gpio_direction_bitmask & BIT(offset)))
> +		st->gpio_direction_bitmask |=3D BIT(offset);
> +	else
> +		goto out;
> +
> +
> +	st->single_tx =3D cpu_to_be16(TI_ADS7950_CR_GPIO |
> +				    (st->gpio_direction_bitmask &
> +				    TI_ADS7950_GPIO_MASK));
> +	ret =3D spi_sync(st->spi, &st->scan_single_msg);
> +
> +out:
> +	mutex_unlock(&st->indio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +static int ti_ads7950_direction_input(struct gpio_chip *chip,
> +				      unsigned int offset)
> +{
> +	return _ti_ads7950_set_direction(chip, offset, 1);
> +}
> +
> +static int ti_ads7950_direction_output(struct gpio_chip *chip,
> +				       unsigned int offset, int value)
> +{
> +	ti_ads7950_set(chip, offset, value);
> +
> +	return _ti_ads7950_set_direction(chip, offset, 0);
> +}
> +
> +static int ti_ads7950_init_gpio(struct ti_ads7950_state *st)
> +{
> +	int ret;
> +
> +	/* Initialize GPIO */
> +	mutex_lock(&st->indio_dev->mlock);
> +
> +	/* Default to GPIO input */
> +	st->gpio_direction_bitmask =3D 0x0;
> +	st->single_tx =3D cpu_to_be16(TI_ADS7950_CR_GPIO |
> +				    (st->gpio_direction_bitmask &
> +				    TI_ADS7950_GPIO_MASK));
> +	ret =3D spi_sync(st->spi, &st->scan_single_msg);
> +	mutex_unlock(&st->indio_dev->mlock);

Nope.  This is a state lock used to protect against transitions between
different modes of the IIO device (buffered vs polled), it
isn't suitable for general use.

The driver should be modified to handle that correctly.
We have iio_claim_direct_mode etc that deal with the case
where a device can't do certain operations whilst in buffered
mode.  Note it can fail and should.

Seems there are more drivers still doing this than I thought.
If anyone is bored and wants to clean them out, that would be
most appreciated!

If you need locking to protect a local buffer or the device
state, define a new lock to do it with clearly documented
scope.

> +	if (ret)
> +		return ret;
> +
> +	/* Default to signal low */
> +	st->gpio_signal_bitmask =3D 0x0;
> +	st->single_tx =3D cpu_to_be16(TI_ADS7950_CR_MANUAL |
> +				    TI_ADS7950_CR_WRITE |
> +				    (st->gpio_signal_bitmask &
> +				    TI_ADS7950_GPIO_MASK));
> +	ret =3D spi_sync(st->spi, &st->scan_single_msg);
> +	mutex_unlock(&st->indio_dev->mlock);
> +	if (ret)
> +		return ret;
> +
> +	/* Add GPIO chip */
> +	st->chip->label =3D dev_name(&st->spi->dev);
> +	st->chip->parent =3D &st->spi->dev;
> +	st->chip->owner =3D THIS_MODULE;
> +	st->chip->base =3D -1;
> +	st->chip->ngpio =3D TI_ADS7950_NUM_GPIOS;
> +	st->chip->get_direction =3D ti_ads7950_get_direction;
> +	st->chip->direction_input =3D ti_ads7950_direction_input;
> +	st->chip->direction_output =3D ti_ads7950_direction_output;
> +	st->chip->get =3D ti_ads7950_get;
> +	st->chip->set =3D ti_ads7950_set;
> +
> +	return gpiochip_add_data(st->chip, st);
> +}
> +
>  static int ti_ads7950_probe(struct spi_device *spi)
>  {
>  	struct ti_ads7950_state *st;
>  	struct iio_dev *indio_dev;
> +	struct gpio_chip *chip;
>  	const struct ti_ads7950_chip_info *info;
>  	int ret;
> =20
> @@ -381,6 +533,10 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
> =20
> +	chip =3D devm_kzalloc(&spi->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +

What stops us putting the chip structure inside the existing
info structure?  That avoids the need to separately allocate
memory and to set the pointer.  A cleaner option all round.

>  	st =3D iio_priv(indio_dev);
> =20
>  	spi_set_drvdata(spi, indio_dev);
> @@ -396,6 +552,8 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	indio_dev->channels =3D info->channels;
>  	indio_dev->num_channels =3D info->num_channels;
>  	indio_dev->info =3D &ti_ads7950_info;
> +	st->indio_dev =3D indio_dev;

Hmm. As a general rule I'm against things having pointers to the structure
that contains them as it usual means something is inconsistent in the
software architecture.

=46rom the above, looks like this is about accessing mlock. The driver
shouldn't be doing that directly at all, so a precursor to this
patch cleaning that up would be great.

> +	st->chip =3D chip;
> =20
>  	/* build spi ring message */
>  	spi_message_init(&st->ring_msg);
> @@ -457,6 +615,10 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  		goto error_cleanup_ring;
>  	}
> =20
> +	ret =3D ti_ads7950_init_gpio(st);
> +	if (ret)
> +		dev_warn(&spi->dev, "Unable to initialize GPIOs\n");
Why are we not treating this as an error?  I can't see any
obvious reason to make that choice.

> +
>  	return 0;
> =20
>  error_cleanup_ring:

