Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeCTQIV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:08:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37567 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeCTQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:08:17 -0400
X-Google-Smtp-Source: AG47ELvSV0WNQUOBgdHypfIlADcpWWxH3CeshNpSGeYEXUHpGqXGRXzygFw5u79/gp3UKhGqO30Ajw==
Date: Tue, 20 Mar 2018 09:08:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: jdelvare@suse.com, lee.jones@linaro.org, cphealy@gmail.com,
        andrew.smirnov@gmail.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: MC13783: add uid and die temperature sensor
 inputs
Message-ID: <20180320160814.GA31015@roeck-us.net>
References: <1521558087-21626-1-git-send-email-andrey.gusakov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521558087-21626-1-git-send-email-andrey.gusakov@cogentembedded.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 06:01:27PM +0300, Andrey Gusakov wrote:
> The uid and die temperature can be read out on the ADIN7 using
> input mux. Map uid and die tenperature sensor to channels 16
> and 17.
> 
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> ---
> Changes in v2:
> - suport both mc13783 and mc13892
> - uit_input renamed to in16_input
> - style fixes
> ---
>  drivers/hwmon/mc13783-adc.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/mc13xxx-core.c  | 15 +++++++++++-
>  include/linux/mfd/mc13xxx.h |  2 ++
>  3 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> index 960a1db..413b83c 100644
> --- a/drivers/hwmon/mc13783-adc.c
> +++ b/drivers/hwmon/mc13783-adc.c
> @@ -63,6 +63,10 @@ static int mc13783_adc_read(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> +	/* ADIN7 subchannels */
> +	if (channel >= 16)
> +		channel = 7;
> +
>  	channel &= 0x7;
>  
>  	*val = (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
> @@ -111,6 +115,54 @@ static ssize_t mc13783_adc_read_gp(struct device *dev,
>  	return sprintf(buf, "%u\n", val);
>  }
>  
> +static ssize_t mc13783_adc_read_uid(struct device *dev,
> +		struct device_attribute *devattr, char *buf)

Please watch multi-line alignments.

> +{
> +	unsigned int val;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	kernel_ulong_t driver_data = platform_get_device_id(pdev)->driver_data;
> +	int ret = mc13783_adc_read(dev, devattr, &val);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* MC13892 have 1/2 divider, input range is [0, 4.800V] */
> +	if (driver_data & MC13783_ADC_BPDIV2)
> +		val = DIV_ROUND_CLOSEST(val * 4800, 1024);
> +	/* MC13783 have 0.9 divider, input range is [0, 2.555V] */

Please move the comments into the if/else block and adjust indentation.

> +	else
> +		val = DIV_ROUND_CLOSEST(val * 2555, 1024);
> +
> +	return sprintf(buf, "%u\n", val);
> +}
> +
> +static ssize_t mc13783_adc_read_temp(struct device *dev,
> +		struct device_attribute *devattr, char *buf)
> +{
> +	unsigned int val;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	kernel_ulong_t driver_data = platform_get_device_id(pdev)->driver_data;
> +	int ret = mc13783_adc_read(dev, devattr, &val);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* MC13892:
> +	 * Die Temperature Read Out Code at 25C 680
> +	 * Temperature change per LSB +0.4244C
> +	 */

This is not a networking driver. Please use the standard multi-line
comment format. Also, please move the comments into the if/else
block and use { } to improve readability.

> +	if (driver_data & MC13783_ADC_BPDIV2)
> +		ret = DIV_ROUND_CLOSEST(-2635920 + val * 4244, 10);
> +	/* MC13783:
> +	 * Die Temperature Read Out Code at 25C 282
> +	 * Temperature change per LSB -1.14C
> +	 */

Especially this comment is just confusing due to its alignment.

> +	else
> +		ret = 346480 - 1140 * val;
> +
> +	return sprintf(buf, "%d\n", ret);
> +}
> +
>  static DEVICE_ATTR_RO(name);
>  static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, mc13783_adc_read_bp, NULL, 2);
>  static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, mc13783_adc_read_gp, NULL, 5);
> @@ -124,6 +176,9 @@ static ssize_t mc13783_adc_read_gp(struct device *dev,
>  static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, mc13783_adc_read_gp, NULL, 13);
>  static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, mc13783_adc_read_gp, NULL, 14);
>  static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, mc13783_adc_read_gp, NULL, 15);
> +static SENSOR_DEVICE_ATTR(in16_input, S_IRUGO, mc13783_adc_read_uid, NULL, 16);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
> +			  mc13783_adc_read_temp, NULL, 17);
>  
>  static struct attribute *mc13783_attr_base[] = {
>  	&dev_attr_name.attr,
> @@ -131,6 +186,8 @@ static ssize_t mc13783_adc_read_gp(struct device *dev,
>  	&sensor_dev_attr_in5_input.dev_attr.attr,
>  	&sensor_dev_attr_in6_input.dev_attr.attr,
>  	&sensor_dev_attr_in7_input.dev_attr.attr,
> +	&sensor_dev_attr_in16_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	NULL
>  };
>  
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index d7f54e4..c63e331 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -279,8 +279,21 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>  	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2;
>  	adc1 = MC13XXX_ADC1_ADEN | MC13XXX_ADC1_ADTRIGIGN | MC13XXX_ADC1_ASC;
>  
> -	if (channel > 7)
> +	/*
> +	 * Channels mapped through ADIN7:
> +	 * 7  - General purpose ADIN7
> +	 * 16 - UID
> +	 * 17 - Die temperature
> +	 */
> +	if (channel > 7 && channel < 16) {
>  		adc1 |= MC13XXX_ADC1_ADSEL;
> +	} else if (channel == 16) {
> +		adc0 |= MC13XXX_ADC0_ADIN7SEL_UID;
> +		channel = 7;
> +	} else if (channel == 17) {
> +		adc0 |= MC13XXX_ADC0_ADIN7SEL_DIE;
> +		channel = 7;
> +	}
>  
>  	switch (mode) {
>  	case MC13XXX_ADC_MODE_TS:
> diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
> index 638222e..54a3cd8 100644
> --- a/include/linux/mfd/mc13xxx.h
> +++ b/include/linux/mfd/mc13xxx.h
> @@ -243,6 +243,8 @@ struct mc13xxx_platform_data {
>  #define MC13XXX_ADC0_LICELLCON		(1 << 0)
>  #define MC13XXX_ADC0_CHRGICON		(1 << 1)
>  #define MC13XXX_ADC0_BATICON		(1 << 2)
> +#define MC13XXX_ADC0_ADIN7SEL_DIE	(1 << 4)
> +#define MC13XXX_ADC0_ADIN7SEL_UID	(2 << 4)
>  #define MC13XXX_ADC0_ADREFEN		(1 << 10)
>  #define MC13XXX_ADC0_TSMOD0		(1 << 12)
>  #define MC13XXX_ADC0_TSMOD1		(1 << 13)
> -- 
> 1.9.1
> 
