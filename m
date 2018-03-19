Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933198AbeCSNRP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:17:15 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45543 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932584AbeCSNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:17:08 -0400
X-Google-Smtp-Source: AG47ELsQO5AaTHk8c4/BQ8lKP/oeT2YMyFD1r9QbK/nCCy260GBIcQhQXJhuir/XOBmVx7QtCLB12A==
Subject: Re: [PATCH] hwmon: MC13982: add uid and die temperature sensor inputs
To: Andrey Gusakov <andrey.gusakov@cogentembedded.com>, jdelvare@suse.com,
        lee.jones@linaro.org, cphealy@gmail.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1521455926-26423-1-git-send-email-andrey.gusakov@cogentembedded.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <98caa9a9-b1cc-f5c1-0560-f884abb74d66@roeck-us.net>
Date: Mon, 19 Mar 2018 06:17:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521455926-26423-1-git-send-email-andrey.gusakov@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 03:38 AM, Andrey Gusakov wrote:
> The uid and die temperature can be read out on the ADIN7 using
> input mux. Map uid and die tenperature sensor to channels 16
> and 17.
> 
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> ---
>   drivers/hwmon/mc13783-adc.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/mfd/mc13xxx-core.c  | 15 ++++++++++++++-
>   include/linux/mfd/mc13xxx.h |  2 ++
>   3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> index 960a1db..ee42133 100644
> --- a/drivers/hwmon/mc13783-adc.c
> +++ b/drivers/hwmon/mc13783-adc.c
> @@ -63,6 +63,10 @@ static int mc13783_adc_read(struct device *dev,
>   	if (ret)
>   		return ret;
>   
> +	/* ADIN7 subchannels */
> +	if (channel >= 16)
> +		channel = 7;
> +
>   	channel &= 0x7;
>   
>   	*val = (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
> @@ -111,6 +115,40 @@ static ssize_t mc13783_adc_read_gp(struct device *dev,
>   	return sprintf(buf, "%u\n", val);
>   }
>   
> +static ssize_t mc13783_adc_read_uid(struct device *dev,
> +		struct device_attribute *devattr, char *buf)
> +{
> +	unsigned int val;
> +	int ret = mc13783_adc_read(dev, devattr, &val);
> +
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * UID is scaled with 0.9 factor.
> +	 * input range is [0, 2.555V], val is 10 bits
> +	 */
> +	return sprintf(buf, "%d\n",

'val' is unsigned.

> +		DIV_ROUND_CLOSEST(val * 2555, 1024));
> +}
> +
> +static ssize_t mc13783_adc_read_temp(struct device *dev,
> +		struct device_attribute *devattr, char *buf)
> +{
> +	unsigned int val;
> +	int ret = mc13783_adc_read(dev, devattr, &val);
> +
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Return value is raw temperature.
> +	 * Convert per MC13892 datasheet.
> +	 */
> +	return sprintf(buf, "%d\n", > +		DIV_ROUND_CLOSEST(-2635920 + val * 4244, 10));
> +}
> +
>   static DEVICE_ATTR_RO(name);
>   static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, mc13783_adc_read_bp, NULL, 2);
>   static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, mc13783_adc_read_gp, NULL, 5);
> @@ -124,6 +162,8 @@ static ssize_t mc13783_adc_read_gp(struct device *dev,
>   static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, mc13783_adc_read_gp, NULL, 13);
>   static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, mc13783_adc_read_gp, NULL, 14);
>   static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, mc13783_adc_read_gp, NULL, 15);
> +static SENSOR_DEVICE_ATTR(uid_input, S_IRUGO, mc13783_adc_read_uid, NULL, 16);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, mc13783_adc_read_temp, NULL, 17);
>   
>   static struct attribute *mc13783_attr_base[] = {
>   	&dev_attr_name.attr,
> @@ -131,6 +171,8 @@ static ssize_t mc13783_adc_read_gp(struct device *dev,
>   	&sensor_dev_attr_in5_input.dev_attr.attr,
>   	&sensor_dev_attr_in6_input.dev_attr.attr,
>   	&sensor_dev_attr_in7_input.dev_attr.attr,
> +	&sensor_dev_attr_uid_input.dev_attr.attr,

uid is a voltage. We report voltages with inX_input.

Guenter

> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
>   	NULL
>   };
>   
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index d7f54e4..2178c784 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -279,8 +279,21 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>   	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2;
>   	adc1 = MC13XXX_ADC1_ADEN | MC13XXX_ADC1_ADTRIGIGN | MC13XXX_ADC1_ASC;
>   
> -	if (channel > 7)
> +	/*
> +	 * Channels mapped through ADIN7:
> +	 * 7  - General purpose ADIN7
> +	 * 16 - UID
> +	 * 17 - Die temperature
> +	 */
> +	if ((channel > 7) && (channel < 16)) {

No unnecessary ( ), please.

>   		adc1 |= MC13XXX_ADC1_ADSEL;
> +	} else if (channel == 16) {
> +		adc0 |= MC13XXX_ADC0_UIDEN;
> +		channel = 7;
> +	} else if (channel == 17) {
> +		adc0 |= MC13XXX_ADC0_DTHEN;
> +		channel = 7;
> +	}
>   
>   	switch (mode) {
>   	case MC13XXX_ADC_MODE_TS:
> diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
> index 638222e..6389a98 100644
> --- a/include/linux/mfd/mc13xxx.h
> +++ b/include/linux/mfd/mc13xxx.h
> @@ -243,6 +243,8 @@ struct mc13xxx_platform_data {
>   #define MC13XXX_ADC0_LICELLCON		(1 << 0)
>   #define MC13XXX_ADC0_CHRGICON		(1 << 1)
>   #define MC13XXX_ADC0_BATICON		(1 << 2)
> +#define MC13XXX_ADC0_DTHEN		(1 << 4)
> +#define MC13XXX_ADC0_UIDEN		(1 << 5)
>   #define MC13XXX_ADC0_ADREFEN		(1 << 10)
>   #define MC13XXX_ADC0_TSMOD0		(1 << 12)
>   #define MC13XXX_ADC0_TSMOD1		(1 << 13)
> 
