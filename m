Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39CBC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB42A2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550658593;
	bh=ihNkSzqAAFhFcoXkz2WEuxqjMgKZDHQGckxMKV/yXhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IQUAkdk+jP3DWF4H62wF39Mqpd47v1xHIONjk0iIvusSvbbTmvWgaR4yIGEQcuqTN
	 xNmG967HkWYizwY5Ik8gQS6Ewc4h8hbRh/bPi3iN6+HDliKHYsVJMbcTErt/DP10di
	 v/LnRSmQOf6XPAeq7D5DpvQ2kQgUWYiUtDd4m4+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfBTK3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:29:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfBTK3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:29:52 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1EF02086A;
        Wed, 20 Feb 2019 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550658590;
        bh=ihNkSzqAAFhFcoXkz2WEuxqjMgKZDHQGckxMKV/yXhs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xBzPO2rd3xpbV4mrMY4Cc3byCCoD/euq+T9Yo5168BniUPbH03RmUwTPQFA0nMRED
         oKAFM/2J+2G3hJR7xpKfz7Jn5rzbGUbF5GbSuNN381XeHmwAzQFOzQkYbjCF/Lkvz/
         aZsLx7y1Bpyu5B07tYjjMax6BLHd56XZx2qkDmBQ=
Date:   Wed, 20 Feb 2019 10:29:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/6] iio: imu: adis16480: Add support for configurable
 drdy indicator
Message-ID: <20190220102945.6af3edc4@archlinux>
In-Reply-To: <1550596338-24220-3-git-send-email-stefan.popa@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
        <1550596338-24220-3-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 19:12:14 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The FNCTIO_CTRL register provides configuration control for each I/O pin
> (DIO1, DIO2, DIO3 and DIO4).
> 
> This patch adds the option to configure each DIOx pin as data ready
> indicator with positive or negative polarity by reading the 'interrupts'
> and 'interrupt-names' properties from the devicetree. The
> 'interrupt-names' property is optional, if it is not specified, then the
> factory default DIO2 data ready signal is used.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Other than follow on from the previous patch change of the default, this
looks fine to me.

One question inline.

Jonathan
> ---
>  drivers/iio/imu/adis16480.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index d222188..38ba0c1 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/of_irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
> @@ -109,6 +110,10 @@
>  #define ADIS16480_FIR_COEF_D(x)			ADIS16480_FIR_COEF(0x0B, (x))
>  
>  /* ADIS16480_REG_FNCTIO_CTRL */
> +#define ADIS16480_DRDY_SEL_MSK		GENMASK(1, 0)
> +#define ADIS16480_DRDY_SEL(x)		FIELD_PREP(ADIS16480_DRDY_SEL_MSK, x)
> +#define ADIS16480_DRDY_POL_MSK		BIT(2)
> +#define ADIS16480_DRDY_POL(x)		FIELD_PREP(ADIS16480_DRDY_POL_MSK, x)
>  #define ADIS16480_DRDY_EN_MSK		BIT(3)
>  #define ADIS16480_DRDY_EN(x)		FIELD_PREP(ADIS16480_DRDY_EN_MSK, x)
>  
> @@ -121,12 +126,26 @@ struct adis16480_chip_info {
>  	unsigned int accel_max_scale;
>  };
>  
> +enum adis16480_int_pin {
> +	ADIS16480_PIN_DIO1,
> +	ADIS16480_PIN_DIO2,
> +	ADIS16480_PIN_DIO3,
> +	ADIS16480_PIN_DIO4
> +};
> +
>  struct adis16480 {
>  	const struct adis16480_chip_info *chip_info;
>  
>  	struct adis adis;
>  };
>  
> +static const char * const adis16480_int_pin_names[4] = {
> +	[ADIS16480_PIN_DIO1] = "DIO1",
> +	[ADIS16480_PIN_DIO2] = "DIO2",
> +	[ADIS16480_PIN_DIO3] = "DIO3",
> +	[ADIS16480_PIN_DIO4] = "DIO4",
> +};
> +
>  #ifdef CONFIG_DEBUG_FS
>  
>  static ssize_t adis16480_show_firmware_revision(struct file *file,
> @@ -840,6 +859,59 @@ static const struct adis_data adis16480_data = {
>  	.enable_irq = adis16480_enable_irq,
>  };
>  
> +static int adis16480_config_irq_pin(struct device_node *of_node,
> +				    struct adis16480 *st)
> +{
> +	struct irq_data *desc;
> +	enum adis16480_int_pin pin;
> +	unsigned int irq_type;
> +	uint16_t val;
> +	int i, irq = 0;
> +
> +	desc = irq_get_irq_data(st->adis.spi->irq);
> +	if (!desc) {
> +		dev_err(&st->adis.spi->dev, "Could not find IRQ %d\n", irq);
> +		return -EINVAL;
> +	}
> +
> +	/* Disable data ready */
> +	val = ADIS16480_DRDY_EN(0);
Does it default to on after reset?
That's a little unusual and nasty.  If not, why are you disabling here?
> +
> +	/*
> +	 * Get the interrupt from the devicetre by reading the
> +	 * interrupt-names property. If it is not specified, use
> +	 * the default interrupt on DIO2 pin.
> +	 */
> +	pin = ADIS16480_PIN_DIO2;
> +	for (i = 0; i < ARRAY_SIZE(adis16480_int_pin_names); i++) {
> +		irq = of_irq_get_byname(of_node, adis16480_int_pin_names[i]);
> +		if (irq > 0) {
> +			pin = i;
> +			break;
> +		}
> +	}
> +
> +	val |= ADIS16480_DRDY_SEL(pin);
> +
> +	/*
> +	 * Get the interrupt line behaviour. The data ready polarity can be
> +	 * configured as positive or negative, corresponding to
> +	 * IRQF_TRIGGER_RISING or IRQF_TRIGGER_FALLING respectively.
> +	 */
> +	irq_type = irqd_get_trigger_type(desc);
> +	if (irq_type == IRQF_TRIGGER_RISING) { /* Default */
> +		val |= ADIS16480_DRDY_POL(1);
> +	} else if (irq_type == IRQF_TRIGGER_FALLING) {
> +		val |= ADIS16480_DRDY_POL(0);
> +	} else {
> +		dev_err(&st->adis.spi->dev,
> +			"Invalid interrupt type 0x%x specified\n", irq_type);
> +		return -EINVAL;
> +	}
> +	/* Write the data ready configuration to the FNCTIO_CTRL register */
> +	return adis_write_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, val);
> +}
> +
>  static int adis16480_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -867,6 +939,10 @@ static int adis16480_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	ret =  adis16480_config_irq_pin(spi->dev.of_node, st);
> +	if (ret)
> +		return ret;
> +
>  	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
>  	if (ret)
>  		return ret;

