Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C412ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D25208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wOXg6+jX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D25208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeGOK4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbeGOK4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:56:24 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1DA4208C2;
        Sun, 15 Jul 2018 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531650833;
        bh=Awki1EplQ04ujF84spdZgk6yRyc5GUyWRS8gHba2nGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wOXg6+jXSTtqcW9NW/IPaTAxD2rNrikZ5gsQ9IL0u3m4byjG+mvoWndv2v4wglfWw
         5F4NFhw2x59tFbhgbXEyDmp+6Yj26tdUVkOlwiS6XQNoi5uLh9IhOTfHGp68+3xtmb
         cQqYW7QEIhPeCdv+XUNVz/Hl6KXqlm55d5X423FA=
Date:   Sun, 15 Jul 2018 11:33:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        cdleonard@gmail.com
Subject: Re: [PATCH 3/5] iio:adxl372: Add FIFO and interrupts support
Message-ID: <20180715113347.099e7a77@archlinux>
In-Reply-To: <1531409760-20070-1-git-send-email-stefan.popa@analog.com>
References: <1531409760-20070-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 18:36:00 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> This patch adds support for the adxl372 FIFO. In order to accomplish this,
> triggered buffers were used.
> 
> The number of FIFO samples which trigger the watermark interrupt can be
> configured by using the buffer watermark, while the format depends on the
> selected channels.The FIFO data along with the timestamp is pushed to the
> IIO device's buffer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/iio/accel/adxl372.txt      |   7 +
>  drivers/iio/accel/adxl372.c                        | 346 ++++++++++++++++++++-
>  2 files changed, 352 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> index fea4baf..73d7e03 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> +++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> @@ -7,10 +7,17 @@ Required properties:
>   - reg: SPI chip select number for the device
>   - spi-max-frequency: Max SPI frequency to use
>  
> +Optional properties:
> + - interrupt-parent: phandle to the parent interrupt controller
> + - interrupts: interrupt mapping for GPIO IRQ, it should by configured with
> + 		flag IRQ_TYPE_EDGE_FALLING
Absolutely no reason I can see why this should be a gpio.  Plenty of
chips out there have specific irq lines that aren't completely useless
as gpios. 

As a general rule, a DT binding is not meant to represent what Linux
can currently do with a device, but rather everything about how it might
be connected up.  So it would have been better to have a single patch
introducing all the DT bindings rather than having it in scattered like
this.

Note this is unlike other forms of documentation where doing it like this
would have been entirely correct!

> +
>  Example:
>  
>  	accelerometer@0 {
>  		compatible = "adi,adxl372";
>  		reg = <0>;
>  		spi-max-frequency = <1000000>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>  	};
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 62ce238..645902d 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -6,12 +6,20 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
> +#include <linux/gpio/consumer.h>

That worries me.  No way a device should know about GPIOs to add 
interrupt support.  Thankfully seems to just be the header. 
Drop it - you aren't a gpio consumer, you are an irq consumer
which might be a gpio.


>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  /* ADXL372 registers definition */
>  #define ADXL372_DEVID			0x00
> @@ -126,6 +134,8 @@
>  #define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
>  #define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
>  
> +#define ADXL372_FIFO_SIZE			512
> +
>  /*
>   * At +/- 200g with 12-bit resolution, scale is computed as:
>   * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
> @@ -167,6 +177,28 @@ enum adxl372_bandwidth {
>  	ADXL372_BW_3200HZ,
>  };
>  
> +enum adxl372_fifo_format {
> +	ADXL372_XYZ_FIFO,
> +	ADXL372_X_FIFO,
> +	ADXL372_Y_FIFO,
> +	ADXL372_XY_FIFO,
> +	ADXL372_Z_FIFO,
> +	ADXL372_XZ_FIFO,
> +	ADXL372_YZ_FIFO,
> +	ADXL372_XYZ_PEAK_FIFO,
Hmm. This one is interesting ;)
> +};
> +
> +enum adxl372_fifo_mode {
> +	ADXL372_FIFO_BYPASSED,
> +	ADXL372_FIFO_STREAMED,
> +	ADXL372_FIFO_TRIGGERED,
> +	ADXL372_FIFO_OLD_SAVED
> +};
> +
> +static const int adxl372_samp_freq_tbl[5] = {
> +	400, 800, 1600, 3200, 6400,
> +};
> +
>  #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
>  	.address = reg,							\
> @@ -193,12 +225,27 @@ static const struct iio_chan_spec adxl372_channels[] = {
>  struct adxl372_state {
>  	struct spi_device		*spi;
>  	struct regmap			*regmap;
> +	struct iio_trigger		*dready_trig;
> +	enum adxl372_fifo_mode		fifo_mode;
> +	enum adxl372_fifo_format	fifo_format;
>  	enum adxl372_op_mode		op_mode;
>  	enum adxl372_act_proc_mode	act_proc_mode;
>  	enum adxl372_odr		odr;
>  	enum adxl372_bandwidth		bw;
> +	u8				fifo_set_size;
> +	u8				int1_bitmask;
> +	u8				int2_bitmask;
> +	u16				watermark;
> +	__be16				fifo_buf[512];
>  };
>  
> +static int adxl372_read_fifo(struct adxl372_state *st, u16 fifo_entries)
> +{
> +	return regmap_bulk_read(st->regmap,
> +				ADXL372_RD_FLAG_MSK(ADXL372_FIFO_DATA),
> +				st->fifo_buf, fifo_entries * 2);
That's not what regmap_bulk_read does.  It's reading from different
addresses. Now that might not matter now, but it certainly will if you
want to (sensibly) turn on regmap caching later.

So right now it's a semantic issue but it may come back to bite you
in evil hard to find bugs later!

https://lkml.org/lkml/2016/6/16/548

Was the last discussion I think we had around how to do this right.

IIRC main sticking point was the naming so it 'should' be possible to
move this forward if you want to have a go.

Also this is potentially a larger read than some SPI masters will
cope with.  I'm not sure if regmap copes with that nicely or
not - worth checking!  If nothing else, should it be able to split
the transfer it's going to send the second one with completely
the wrong address.

> +}
> +
>  static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
>  {
>  	__be16 regval;
> @@ -313,6 +360,114 @@ static int adxl372_set_activity_threshold(struct adxl372_state *st,
>  				 buf, ARRAY_SIZE(buf));
>  }
>  
> +static int adxl372_set_interrupts(struct adxl372_state *st,
> +				  unsigned char int1_bitmask,
> +				  unsigned char int2_bitmask)
> +{
> +	unsigned char buf[2];
> +	int ret;
> +
> +	buf[0] = int1_bitmask;
> +	buf[1] = int2_bitmask;
> +
> +	/* INT1_MAP and INT2_MAP are adjacent registers */
> +	ret = regmap_bulk_write(st->regmap,
> +				ADXL372_WR_FLAG_MSK(ADXL372_INT1_MAP),
> +				buf, ARRAY_SIZE(buf));

If there isn't a strong 'fast path' argument for this I would do
them separately.  It looks like a micro optimization where it isn't
needed.

> +	if (ret < 0)
> +		return ret;
> +
> +	st->int1_bitmask = int1_bitmask;
> +	st->int2_bitmask = int2_bitmask;
> +
> +	return ret;
> +}
> +
> +static int adxl372_configure_fifo(struct adxl372_state *st)
> +{
> +	unsigned char buf[2];
> +	int ret;
> +
> +	/* FIFO must be configured while in standby mode */
> +	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[0] = st->watermark & 0xFF;
> +	buf[1] = ADXL372_FIFO_CTL_FORMAT_MODE(st->fifo_format) |
> +		 ADXL372_FIFO_CTL_MODE_MODE(st->fifo_mode) |
> +		 ADXL372_FIFO_CTL_SAMPLES_MODE(st->watermark);
> +
> +	/* FIFO_SAMPLES and FIFO_CTL are adjacent registers */

Same argument as previous.  Nice micro optimization but not a fast
path so better to not do it.

> +	ret = regmap_bulk_write(st->regmap,
> +				ADXL372_WR_FLAG_MSK(ADXL372_FIFO_SAMPLES),
> +				buf, ARRAY_SIZE(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
> +}
> +
> +static int adxl372_get_status(struct adxl372_state *st,
> +			      u8 *status1, u8 *status2,
> +			      u16 *fifo_entries)
> +{
> +	unsigned char buf[4];
> +	int ret;
> +
> +	/* STATUS, STATUS2, FIFO_ENTRIES2 and FIFO_ENTRIES are adjacent regs */

This one is fast path so fair enough.

> +	ret = regmap_bulk_read(st->regmap,
> +			       ADXL372_RD_FLAG_MSK(ADXL372_STATUS_1),
> +			       buf, ARRAY_SIZE(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	*status1 = buf[0];
> +	*status2 = buf[1];
> +	/*
> +	 * FIFO_ENTRIES contains the least significant byte, and FIFO_ENTRIES2
> +	 * contains the two most significant bits
> +	 */
> +	*fifo_entries = ((buf[2] & 0x3) << 8) | buf[3];

This is an aligned endian swap (potentially) with a mask.
Given it's a fast path, use the endian convertors as in one of the
options it won't have to do anything.

> +
> +	return ret;
> +}
> +
> +static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	u8 status1, status2;
> +	u16 fifo_entries, i;
> +	int ret;
> +
> +	ret = adxl372_get_status(st, &status1, &status2, &fifo_entries);
> +	if (ret < 0)
> +		goto err;
> +
> +	if ((st->fifo_mode != ADXL372_FIFO_BYPASSED) &&
> +	    (ADXL372_STATUS_1_FIFO_FULL(status1))) {
> +		/*
> +		 * When reading data from multiple axes from the FIFO,
> +		 * to ensure that data is not overwritten and stored out
> +		 * of order at least one sample set must be left in the
> +		 * FIFO after every read.

That's spectacularly ugly! (got to love hardware designers sometimes ;)

> +		 */
> +		fifo_entries -= st->fifo_set_size;
> +
> +		ret = adxl372_read_fifo(st, fifo_entries);
> +		if (ret < 0)
> +			goto err;
> +
> +		for (i = 0; i < fifo_entries * 2; i += st->fifo_set_size * 2)
> +			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
Hmm. Another user for a bulk pusher for IIO.  We've talked about it many times
in the past, but never quite gotten round to implementing it.  Feel free to
look at it if you like!

> +	}
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
>  static int adxl372_setup(struct adxl372_state *st)
>  {
>  	unsigned int regval;
> @@ -397,7 +552,12 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
>  		ret = adxl372_read_axis(st, chan->address);
> +		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -413,9 +573,159 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static ssize_t adxl372_get_fifo_enabled(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", st->fifo_mode);
> +}
> +
> +static ssize_t adxl372_get_fifo_watermark(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", st->watermark);
> +}
> +
> +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> +static IIO_CONST_ATTR(hwfifo_watermark_max,
> +		      __stringify(ADXL372_FIFO_SIZE));
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> +		       adxl372_get_fifo_watermark, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       adxl372_get_fifo_enabled, NULL, 0);
> +
> +static const struct attribute *adxl372_fifo_attributes[] = {
> +	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL,
> +};
> +
> +static int adxl372_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct adxl372_state *st  = iio_priv(indio_dev);
> +
> +	if (val > ADXL372_FIFO_SIZE)
> +		val = ADXL372_FIFO_SIZE;
> +
> +	st->watermark = val;
> +
> +	return 0;
> +}
> +
> +static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	u8 fifo_set_size, accel_axis_en;
> +	int bit, ret;
> +
> +	if (!st->watermark)
> +		return -EINVAL;

Why not clamp the set function to a minimum of 1 then drop this check
as it should always be safe?

> +
> +	ret = adxl372_set_interrupts(st,
> +				     ADXL372_INT1_MAP_FIFO_FULL_MSK,
> +				     0);
> +	if (ret < 0)
> +		return ret;
> +
> +	fifo_set_size = 0;
> +	accel_axis_en = 0;
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		accel_axis_en |= bit;
> +		fifo_set_size++;
> +	}
Oh this is fiddly because you are or ing not with the bit
but with it's position.  I'll admit my gut feeling here
is to just have a look up table of mask to which one to
enable.

So just to check I'll enumerate them all.
accel_axis_en,fifo_set_size
x = 0,1
y = 1,1
z = 2,1
xy = 1,2
xz = 2,2
yz = 3,2
xyz = 3,3

your code is right, but any reviewer is going to have to 
check vs a simple look up

axis_lookup = {
{ BIT(0), ADXL372_X_FIFO },
{ BIT(1), ADXL372_Y_FIFO },
{ BIT(2), ADXL372_Z_FIFO },
{ BIT(0) | BIT(1), ADXL372_XY_FIFO },
{ BIT(0) | BIT(2), ADXL372_XZ_FIFO },
{ BIT(1) | BIT(2), ADXL372_YZ_FIFO },
{ BIT(0) | BIT(1) | BIT(2), ADXL372_XYZ_FIFO }
};

then loop to check. Obviously it's actually complete
so you can avoid the loop, but more obviously correct
to do the search.

> +
> +	switch (accel_axis_en) {
> +	case 0:
> +		st->fifo_format = ADXL372_X_FIFO;
> +		break;
> +	case 1:
> +		if (fifo_set_size == 1)
> +			st->fifo_format = ADXL372_Y_FIFO;
> +		else
> +			st->fifo_format = ADXL372_XY_FIFO;
> +		break;
> +	case 2:
> +		if (fifo_set_size == 1)
> +			st->fifo_format = ADXL372_Z_FIFO;
> +		else
> +			st->fifo_format = ADXL372_XZ_FIFO;
> +		break;
> +	default: /* case 3 */

Not so nice, do case 3: and default as an error, it's not the default
in any meaningful sense.

> +		if (fifo_set_size == 3)
> +			st->fifo_format = ADXL372_XYZ_PEAK_FIFO;

Why the peak form?

> +		else
> +			st->fifo_format = ADXL372_YZ_FIFO;
> +		break;
> +	}
> +
> +	/*
> +	 * The 512 FIFO samples can be allotted in several ways, such as:
> +	 * 170 sample sets of concurrent 3-axis data
> +	 * 256 sample sets of concurrent 2-axis data (user selectable)
> +	 * 512 sample sets of single-axis data
> +	 */
> +	if ((st->watermark * fifo_set_size) > ADXL372_FIFO_SIZE)
> +		st->watermark = (ADXL372_FIFO_SIZE  / fifo_set_size);
> +
> +	st->fifo_set_size = fifo_set_size;
> +	st->fifo_mode = ADXL372_FIFO_STREAMED;
> +
> +	ret = adxl372_configure_fifo(st);
> +	if (ret < 0) {
> +		st->fifo_mode = ADXL372_FIFO_BYPASSED;
> +		adxl372_set_interrupts(st, 0, 0);
> +	}
> +
> +	return ret;
> +}
> +
> +static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +
> +	adxl372_set_interrupts(st, 0, 0);
> +	st->fifo_mode = ADXL372_FIFO_BYPASSED;
> +	adxl372_configure_fifo(st);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops adxl372_buffer_ops = {
> +	.postenable = adxl372_buffer_postenable,
> +	.predisable = adxl372_buffer_predisable,
> +};
> +
> +static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
> +					 bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	unsigned long int mask = 0;
> +
> +	if (state)
> +		mask = ADXL372_INT1_MAP_FIFO_FULL_MSK;
> +
> +	return adxl372_set_interrupts(st, mask, 0);
> +}
> +
> +static const struct iio_trigger_ops adxl372_trigger_ops = {
> +	.set_trigger_state = adxl372_dready_trig_set_state,
> +};
> +
>  static const struct iio_info adxl372_info = {
>  	.read_raw = adxl372_read_raw,
>  	.debugfs_reg_access = &adxl372_reg_access,
> +	.hwfifo_set_watermark = adxl372_set_watermark,
>  };
>  
>  static const struct regmap_config adxl372_spi_regmap_config = {
> @@ -451,7 +761,7 @@ static int adxl372_probe(struct spi_device *spi)
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &adxl372_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>  
>  	ret = adxl372_setup(st);
>  	if (ret < 0) {
> @@ -459,6 +769,40 @@ static int adxl372_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> +	ret = devm_iio_triggered_buffer_setup(&st->spi->dev,
> +					      indio_dev, NULL,
> +					      adxl372_trigger_handler,
> +					      &adxl372_buffer_ops);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev,
> +			  "%s-dev%d",
> +			  indio_dev->name);
> +	if (st->dready_trig == NULL)
> +		return -ENOMEM;
> +
> +	st->dready_trig->ops = &adxl372_trigger_ops;
> +	st->dready_trig->dev.parent = &st->spi->dev;
> +	iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> +	ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->dready_trig);
> +
> +	ret = devm_request_threaded_irq(&st->spi->dev, st->spi->irq,
> +					iio_trigger_generic_data_rdy_poll,
> +					NULL,
> +					IRQF_TRIGGER_RISING |
> +					IRQF_ONESHOT,
> +					indio_dev->name,
> +					st->dready_trig);
> +	if (ret < 0)
> +		return ret;

I would make the IRQ optional as it's not actually necessary to have a working
system (just to use the fifo) and you'd be amazed how many times it won't be
wired up on a given box.  Now if this is that common you can do evil poll based
methods to find out whether the IRQ has fired, but I wouldn't do that unless we
have a known user who cares (as it's really ugly!)

Jonathan

> +
> +	iio_buffer_set_attrs(indio_dev->buffer, adxl372_fifo_attributes);
> +
>  	return devm_iio_device_register(&st->spi->dev, indio_dev);
>  }
>  

