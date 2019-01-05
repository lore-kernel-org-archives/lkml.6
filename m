Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80424C43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599832087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfAEQyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:54:52 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:48996 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfAEQyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:54:52 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 4A09F9E7585;
        Sat,  5 Jan 2019 16:54:49 +0000 (GMT)
Date:   Sat, 5 Jan 2019 16:54:47 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: sps30: allow changing self cleaning
 period
Message-ID: <20190105165447.0056fb2e@archlinux>
In-Reply-To: <20181226193035.3144-1-tduszyns@gmail.com>
References: <20181226193035.3144-1-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2018 20:30:35 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Sensor can periodically trigger self cleaning. Period can be changed by
> writing a new value to a dedicated attribute. Upon attribute read
> triplet representing respectively current, minimum and maximum period is
> returned.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>

Code is fine, but to end up with predictable generic interface
that fits with the rest of IIO we need a different userspace interface I think...

See below.

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-sps30 |  11 ++
>  drivers/iio/chemical/sps30.c                  | 134 +++++++++++++++---
>  2 files changed, 127 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sps30 b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> index e7ce2c57635e..d83d9192a3e0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-sps30
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> @@ -6,3 +6,14 @@ Description:
>  		Writing 1 starts sensor self cleaning. Internal fan accelerates
>  		to its maximum speed and keeps spinning for about 10 seconds in
>  		order to blow out accumulated dust.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/cleaning_interval
> +Date:		December 2018
> +KernelVersion:	4.22
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Sensor is capable of triggering self cleaning periodically.
> +		Period can be changed by writing a new value here. Upon reading
> +		three values are returned representing respectively current,
> +		minimum and maximum period. All values are in seconds.
> +		Writing 0 here disables periodical self cleaning entirely.
Hmm. The issue here is that the value isn't:
1. Intuitive
2. A single value (requirement for sysfs interfaces - we stretch the meaning
a bit where there the values really don't have any meaning on their own but
that isn't true here).

We have a syntax in IIO use when we want to specify a range of acceptable
values.  It's done for 'core' attributes using the available callback
(I need to write some proper docs for it though...)

cleaning_period - the actual value.
cleaning_period_available 
The range version (rather than list of values) is formatted
by iio_format_avail_range which generates [min step max]

Please do something along those lines for this control as well.

> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index f3b4390c8f5c..c219fda08cba 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -5,9 +5,6 @@
>   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
>   *
>   * I2C slave address: 0x69
> - *
> - * TODO:
> - *  - support for reading/setting auto cleaning interval
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -21,6 +18,7 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  
>  #define SPS30_CRC8_POLYNOMIAL 0x31
> @@ -28,6 +26,9 @@
>  #define SPS30_MAX_READ_SIZE 48
>  /* sensor measures reliably up to 3000 ug / m3 */
>  #define SPS30_MAX_PM 3000
> +/* minimum and maximum self cleaning intervals in seconds */
> +#define SPS30_AUTO_CLEANING_INTERVAL_MIN 0
> +#define SPS30_AUTO_CLEANING_INTERVAL_MAX 604800
>  
>  /* SPS30 commands */
>  #define SPS30_START_MEAS 0x0010
> @@ -37,6 +38,9 @@
>  #define SPS30_READ_DATA 0x0300
>  #define SPS30_READ_SERIAL 0xd033
>  #define SPS30_START_FAN_CLEANING 0x5607
> +#define SPS30_AUTO_CLEANING_INTERVAL 0x8004
> +/* not a sensor command per se, used only to distinguish write from read */
> +#define SPS30_READ_AUTO_CLEANING_INTERVAL 0x8005
>  
>  enum {
>  	PM1,
> @@ -45,6 +49,11 @@ enum {
>  	PM10,
>  };
>  
> +enum {
> +	RESET,
> +	MEASURING,
> +};
> +
>  struct sps30_state {
>  	struct i2c_client *client;
>  	/*
> @@ -52,6 +61,7 @@ struct sps30_state {
>  	 * Must be held whenever sequence of commands is to be executed.
>  	 */
>  	struct mutex lock;
> +	int state;
>  };
>  
>  DECLARE_CRC8_TABLE(sps30_crc8_table);
> @@ -107,6 +117,9 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
>  	case SPS30_START_FAN_CLEANING:
>  		ret = sps30_write_then_read(state, buf, 2, NULL, 0);
>  		break;
> +	case SPS30_READ_AUTO_CLEANING_INTERVAL:
> +		buf[0] = SPS30_AUTO_CLEANING_INTERVAL >> 8;
> +		buf[1] = (u8)SPS30_AUTO_CLEANING_INTERVAL;
>  	case SPS30_READ_DATA_READY_FLAG:
>  	case SPS30_READ_DATA:
>  	case SPS30_READ_SERIAL:
> @@ -114,6 +127,15 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
>  		size += size / 2;
>  		ret = sps30_write_then_read(state, buf, 2, buf, size);
>  		break;
> +	case SPS30_AUTO_CLEANING_INTERVAL:
> +		buf[2] = data[0];
> +		buf[3] = data[1];
> +		buf[4] = crc8(sps30_crc8_table, &buf[2], 2, CRC8_INIT_VALUE);
> +		buf[5] = data[2];
> +		buf[6] = data[3];
> +		buf[7] = crc8(sps30_crc8_table, &buf[5], 2, CRC8_INIT_VALUE);
> +		ret = sps30_write_then_read(state, buf, 8, NULL, 0);
> +		break;
>  	}
>  
>  	if (ret)
> @@ -170,6 +192,14 @@ static int sps30_do_meas(struct sps30_state *state, s32 *data, int size)
>  	int i, ret, tries = 5;
>  	u8 tmp[16];
>  
> +	if (state->state == RESET) {
> +		ret = sps30_do_cmd(state, SPS30_START_MEAS, NULL, 0);
> +		if (ret)
> +			return ret;
> +
> +		state->state = MEASURING;
> +	}
> +
>  	while (tries--) {
>  		ret = sps30_do_cmd(state, SPS30_READ_DATA_READY_FLAG, tmp, 2);
>  		if (ret)
> @@ -276,6 +306,24 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int sps30_do_cmd_reset(struct sps30_state *state)
> +{
> +	int ret;
> +
> +	ret = sps30_do_cmd(state, SPS30_RESET, NULL, 0);
> +	msleep(300);
> +	/*
> +	 * Power-on-reset causes sensor to produce some glitch on i2c bus and
> +	 * some controllers end up in error state. Recover simply by placing
> +	 * some data on the bus, for example STOP_MEAS command, which
> +	 * is NOP in this case.
> +	 */
> +	sps30_do_cmd(state, SPS30_STOP_MEAS, NULL, 0);
> +	state->state = RESET;
> +
> +	return ret;
> +}
> +
>  static ssize_t start_cleaning_store(struct device *dev,
>  				    struct device_attribute *attr,
>  				    const char *buf, size_t len)
> @@ -296,10 +344,73 @@ static ssize_t start_cleaning_store(struct device *dev,
>  	return len;
>  }
>  
> +static ssize_t cleaning_interval_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sps30_state *state = iio_priv(indio_dev);
> +	u8 tmp[4];
> +	int ret;
> +
> +	mutex_lock(&state->lock);
> +	ret = sps30_do_cmd(state, SPS30_READ_AUTO_CLEANING_INTERVAL, tmp, 4);
> +	mutex_unlock(&state->lock);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%d %d %d\n", get_unaligned_be32(tmp),
> +		       SPS30_AUTO_CLEANING_INTERVAL_MIN,
> +		       SPS30_AUTO_CLEANING_INTERVAL_MAX);
> +}
> +
> +static ssize_t cleaning_interval_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sps30_state *state = iio_priv(indio_dev);
> +	int val, ret;
> +	u8 tmp[4];
> +
> +	if (kstrtoint(buf, 0, &val))
> +		return -EINVAL;
> +
> +	if ((val < SPS30_AUTO_CLEANING_INTERVAL_MIN) &&
> +	    (val > SPS30_AUTO_CLEANING_INTERVAL_MAX))
> +		return -EINVAL;
> +
> +	put_unaligned_be32(val, tmp);
> +
> +	mutex_lock(&state->lock);
> +	ret = sps30_do_cmd(state, SPS30_AUTO_CLEANING_INTERVAL, tmp, 0);
> +	if (ret) {
> +		mutex_unlock(&state->lock);
> +		return ret;
> +	}
> +
> +	msleep(20);
> +
> +	/*
> +	 * sensor requires reset in order to return up to date self cleaning
> +	 * period
> +	 */
> +	ret = sps30_do_cmd_reset(state);
> +	if (ret)
> +		dev_warn(dev,
> +			 "interval changed but reads will return the old value\n");
> +
> +	mutex_unlock(&state->lock);
> +
> +	return len;
> +}
> +
>  static IIO_DEVICE_ATTR_WO(start_cleaning, 0);
> +static IIO_DEVICE_ATTR_RW(cleaning_interval, 0);
>  
>  static struct attribute *sps30_attrs[] = {
>  	&iio_dev_attr_start_cleaning.dev_attr.attr,
> +	&iio_dev_attr_cleaning_interval.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -362,6 +473,7 @@ static int sps30_probe(struct i2c_client *client)
>  	state = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	state->client = client;
> +	state->state = RESET;
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->info = &sps30_info;
>  	indio_dev->name = client->name;
> @@ -373,19 +485,11 @@ static int sps30_probe(struct i2c_client *client)
>  	mutex_init(&state->lock);
>  	crc8_populate_msb(sps30_crc8_table, SPS30_CRC8_POLYNOMIAL);
>  
> -	ret = sps30_do_cmd(state, SPS30_RESET, NULL, 0);
> +	ret = sps30_do_cmd_reset(state);
>  	if (ret) {
>  		dev_err(&client->dev, "failed to reset device\n");
>  		return ret;
>  	}
> -	msleep(300);
> -	/*
> -	 * Power-on-reset causes sensor to produce some glitch on i2c bus and
> -	 * some controllers end up in error state. Recover simply by placing
> -	 * some data on the bus, for example STOP_MEAS command, which
> -	 * is NOP in this case.
> -	 */
> -	sps30_do_cmd(state, SPS30_STOP_MEAS, NULL, 0);
>  
>  	ret = sps30_do_cmd(state, SPS30_READ_SERIAL, buf, sizeof(buf));
>  	if (ret) {
> @@ -395,12 +499,6 @@ static int sps30_probe(struct i2c_client *client)
>  	/* returned serial number is already NUL terminated */
>  	dev_info(&client->dev, "serial number: %s\n", buf);
>  
> -	ret = sps30_do_cmd(state, SPS30_START_MEAS, NULL, 0);
> -	if (ret) {
> -		dev_err(&client->dev, "failed to start measurement\n");
> -		return ret;
> -	}
> -
>  	ret = devm_add_action_or_reset(&client->dev, sps30_stop_meas, state);
>  	if (ret)
>  		return ret;

