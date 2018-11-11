Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75374C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD8C20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD8C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeKKWU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:20:27 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:55324 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeKKWU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:20:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 4B6DD9E776F;
        Sun, 11 Nov 2018 12:31:55 +0000 (GMT)
Date:   Sun, 11 Nov 2018 12:31:54 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] staging: iio: ad7816: Switch to the gpio
 descriptor interface
Message-ID: <20181111123154.176ac734@archlinux>
In-Reply-To: <20181111122405.23970900@archlinux>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
        <3f9ea18864230b2758f86899b9bd1acb020dd176.1541733949.git.nishadkamdar@gmail.com>
        <20181111122405.23970900@archlinux>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 12:24:05 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 9 Nov 2018 13:05:17 +0530
> Nishad Kamdar <nishadkamdar@gmail.com> wrote:
> 
> > Use the gpiod interface for rdwr_pin, convert_pin and busy_pin
> > instead of the deprecated old non-descriptor interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>  
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
Actually no it isn't, because I applied the previous version back in
October.  Please avoid resending patches that have already been applied.
It gets very confusing!

Jonathan


> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/staging/iio/adc/ad7816.c | 80 ++++++++++++++------------------
> >  1 file changed, 34 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> > index bf76a8620bdb..12c4e0ab4713 100644
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ b/drivers/staging/iio/adc/ad7816.c
> > @@ -7,7 +7,7 @@
> >   */
> >  
> >  #include <linux/interrupt.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> > @@ -44,9 +44,9 @@
> >  
> >  struct ad7816_chip_info {
> >  	struct spi_device *spi_dev;
> > -	u16 rdwr_pin;
> > -	u16 convert_pin;
> > -	u16 busy_pin;
> > +	struct gpio_desc *rdwr_pin;
> > +	struct gpio_desc *convert_pin;
> > +	struct gpio_desc *busy_pin;
> >  	u8  oti_data[AD7816_CS_MAX + 1];
> >  	u8  channel_id;	/* 0 always be temperature */
> >  	u8  mode;
> > @@ -61,28 +61,28 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
> >  	int ret = 0;
> >  	__be16 buf;
> >  
> > -	gpio_set_value(chip->rdwr_pin, 1);
> > -	gpio_set_value(chip->rdwr_pin, 0);
> > +	gpiod_set_value(chip->rdwr_pin, 1);
> > +	gpiod_set_value(chip->rdwr_pin, 0);
> >  	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
> >  	if (ret < 0) {
> >  		dev_err(&spi_dev->dev, "SPI channel setting error\n");
> >  		return ret;
> >  	}
> > -	gpio_set_value(chip->rdwr_pin, 1);
> > +	gpiod_set_value(chip->rdwr_pin, 1);
> >  
> >  	if (chip->mode == AD7816_PD) { /* operating mode 2 */
> > -		gpio_set_value(chip->convert_pin, 1);
> > -		gpio_set_value(chip->convert_pin, 0);
> > +		gpiod_set_value(chip->convert_pin, 1);
> > +		gpiod_set_value(chip->convert_pin, 0);
> >  	} else { /* operating mode 1 */
> > -		gpio_set_value(chip->convert_pin, 0);
> > -		gpio_set_value(chip->convert_pin, 1);
> > +		gpiod_set_value(chip->convert_pin, 0);
> > +		gpiod_set_value(chip->convert_pin, 1);
> >  	}
> >  
> > -	while (gpio_get_value(chip->busy_pin))
> > +	while (gpiod_get_value(chip->busy_pin))
> >  		cpu_relax();
> >  
> > -	gpio_set_value(chip->rdwr_pin, 0);
> > -	gpio_set_value(chip->rdwr_pin, 1);
> > +	gpiod_set_value(chip->rdwr_pin, 0);
> > +	gpiod_set_value(chip->rdwr_pin, 1);
> >  	ret = spi_read(spi_dev, &buf, sizeof(*data));
> >  	if (ret < 0) {
> >  		dev_err(&spi_dev->dev, "SPI data read error\n");
> > @@ -99,8 +99,8 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
> >  	struct spi_device *spi_dev = chip->spi_dev;
> >  	int ret = 0;
> >  
> > -	gpio_set_value(chip->rdwr_pin, 1);
> > -	gpio_set_value(chip->rdwr_pin, 0);
> > +	gpiod_set_value(chip->rdwr_pin, 1);
> > +	gpiod_set_value(chip->rdwr_pin, 0);
> >  	ret = spi_write(spi_dev, &data, sizeof(data));
> >  	if (ret < 0)
> >  		dev_err(&spi_dev->dev, "SPI oti data write error\n");
> > @@ -129,10 +129,10 @@ static ssize_t ad7816_store_mode(struct device *dev,
> >  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> >  
> >  	if (strcmp(buf, "full")) {
> > -		gpio_set_value(chip->rdwr_pin, 1);
> > +		gpiod_set_value(chip->rdwr_pin, 1);
> >  		chip->mode = AD7816_FULL;
> >  	} else {
> > -		gpio_set_value(chip->rdwr_pin, 0);
> > +		gpiod_set_value(chip->rdwr_pin, 0);
> >  		chip->mode = AD7816_PD;
> >  	}
> >  
> > @@ -345,15 +345,9 @@ static int ad7816_probe(struct spi_device *spi_dev)
> >  {
> >  	struct ad7816_chip_info *chip;
> >  	struct iio_dev *indio_dev;
> > -	unsigned short *pins = dev_get_platdata(&spi_dev->dev);
> >  	int ret = 0;
> >  	int i;
> >  
> > -	if (!pins) {
> > -		dev_err(&spi_dev->dev, "No necessary GPIO platform data.\n");
> > -		return -EINVAL;
> > -	}
> > -
> >  	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> > @@ -364,34 +358,28 @@ static int ad7816_probe(struct spi_device *spi_dev)
> >  	chip->spi_dev = spi_dev;
> >  	for (i = 0; i <= AD7816_CS_MAX; i++)
> >  		chip->oti_data[i] = 203;
> > -	chip->rdwr_pin = pins[0];
> > -	chip->convert_pin = pins[1];
> > -	chip->busy_pin = pins[2];
> > -
> > -	ret = devm_gpio_request(&spi_dev->dev, chip->rdwr_pin,
> > -				spi_get_device_id(spi_dev)->name);
> > -	if (ret) {
> > -		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
> > -			chip->rdwr_pin);
> > +
> > +	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
> > +	if (IS_ERR(chip->rdwr_pin)) {
> > +		ret = PTR_ERR(chip->rdwr_pin);
> > +		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
> > +			ret);
> >  		return ret;
> >  	}
> > -	gpio_direction_input(chip->rdwr_pin);
> > -	ret = devm_gpio_request(&spi_dev->dev, chip->convert_pin,
> > -				spi_get_device_id(spi_dev)->name);
> > -	if (ret) {
> > -		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
> > -			chip->convert_pin);
> > +	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert", GPIOD_IN);
> > +	if (IS_ERR(chip->convert_pin)) {
> > +		ret = PTR_ERR(chip->convert_pin);
> > +		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
> > +			ret);
> >  		return ret;
> >  	}
> > -	gpio_direction_input(chip->convert_pin);
> > -	ret = devm_gpio_request(&spi_dev->dev, chip->busy_pin,
> > -				spi_get_device_id(spi_dev)->name);
> > -	if (ret) {
> > -		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
> > -			chip->busy_pin);
> > +	chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy", GPIOD_IN);
> > +	if (IS_ERR(chip->busy_pin)) {
> > +		ret = PTR_ERR(chip->busy_pin);
> > +		dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> > +			ret);
> >  		return ret;
> >  	}
> > -	gpio_direction_input(chip->busy_pin);
> >  
> >  	indio_dev->name = spi_get_device_id(spi_dev)->name;
> >  	indio_dev->dev.parent = &spi_dev->dev;  
> 

