Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A03C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8441B20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbfAOUzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:55:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37389 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730050AbfAOUzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:55:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9A40B207B2; Tue, 15 Jan 2019 21:55:45 +0100 (CET)
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr [86.202.150.119])
        by mail.bootlin.com (Postfix) with ESMTPSA id 61F2420750;
        Tue, 15 Jan 2019 21:55:45 +0100 (CET)
Date:   Tue, 15 Jan 2019 21:55:45 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Artem Panfilov <panfilovartyom@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/1] rtc: add AB-RTCMC-32.768kHz-EOZ9-S3 RTC support
Message-ID: <20190115205545.GB2627@piout.net>
References: <20190115110146.21180-1-panfilov.artyom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115110146.21180-1-panfilov.artyom@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for the patch, a few comments:

On 15/01/2019 14:01:45+0300, Artem Panfilov wrote:
> This patch adds support for AB-RTCMC-32.768kHz-EOZ9-S3
> RTC/Calendar module w/ I2C interface.
> 
> Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>

This has to match the From: header of the email (the dot is the
difference).

> ---
>  drivers/rtc/Kconfig          |  10 +
>  drivers/rtc/Makefile         |   1 +
>  drivers/rtc/rtc-ab-eoz9-s3.c | 412 +++++++++++++++++++++++++++++++++++

I'd remove s3 from the various file and variable names because this is
a package denomination (I know other RTCs have it but this has caused
issue in the past).

> +static int abeoz9s3_rtc_get_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct abeoz9s3_rtc_data *data = dev_get_drvdata(dev);
> +	u8 regs[ABEOZ9S3_REG_SECONDS + ABEOZ9S3_SECONDS_LEN];

Why do you add ABEOZ9S3_REG_SECONDS here?

> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, ABEOZ9S3_REG_SECONDS,
> +			       regs, sizeof(regs));
> +
> +	if (ret) {
> +		dev_err(dev, "reading RTC time failed (%d)\n", ret);
> +		goto err;

You can return ret directly here instead of using a goto.

> +	}
> +
> +	tm->tm_sec  = bcd2bin(regs[ABEOZ9S3_REG_SECONDS] & 0x7F);
> +	tm->tm_min  = bcd2bin(regs[ABEOZ9S3_REG_MINUTES] & 0x7F);
> +
> +	if (regs[ABEOZ9S3_REG_CTRL1] & ABEOZ9S3_HOURS_PM) {
> +		tm->tm_hour = bcd2bin(regs[ABEOZ9S3_REG_HOURS] & 0x1f);
> +		if (regs[ABEOZ9S3_REG_HOURS] & ABEOZ9S3_HOURS_PM)
> +			tm->tm_hour += 12;
> +	} else {
> +		tm->tm_hour = bcd2bin(regs[ABEOZ9S3_REG_HOURS]);
> +	}
> +
> +	tm->tm_mday = bcd2bin(regs[ABEOZ9S3_REG_DAYS]);
> +	tm->tm_wday = bcd2bin(regs[ABEOZ9S3_REG_WEEKDAYS]);
> +	tm->tm_mon  = bcd2bin(regs[ABEOZ9S3_REG_MONTHS]) - 1;
> +	tm->tm_year = bcd2bin(regs[ABEOZ9S3_REG_YEARS]) + 100;
> +err:
> +	return ret;
> +}
> +
> +static int abeoz9s3_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct abeoz9s3_rtc_data *data = dev_get_drvdata(dev);
> +	u8 regs[ABEOZ9S3_REG_SECONDS + ABEOZ9S3_SECONDS_LEN];

ABEOZ9S3_REG_SECONDS is probably not needed here either.

> +	int ret;
> +
> +	regs[ABEOZ9S3_REG_SECONDS]  = bin2bcd(tm->tm_sec);
> +	regs[ABEOZ9S3_REG_MINUTES]  = bin2bcd(tm->tm_min);
> +	regs[ABEOZ9S3_REG_HOURS]    = bin2bcd(tm->tm_hour);
> +	regs[ABEOZ9S3_REG_DAYS]     = bin2bcd(tm->tm_mday);
> +	regs[ABEOZ9S3_REG_WEEKDAYS] = bin2bcd(tm->tm_wday);
> +	regs[ABEOZ9S3_REG_MONTHS]   = bin2bcd(tm->tm_mon + 1);
> +	regs[ABEOZ9S3_REG_YEARS]    = bin2bcd(tm->tm_year - 100);
> +
> +	mutex_lock(&data->lock);

This lock doesn't actually protect anything, it can be removed.

> +	ret = regmap_bulk_write(data->regmap, ABEOZ9S3_REG_SECONDS,
> +				regs + ABEOZ9S3_REG_SECONDS,
> +				ABEOZ9S3_SECONDS_LEN);
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +


> +static int abeoz9s3_rtc_setup(struct device *dev, struct device_node *node)
> +{
> +	struct abeoz9s3_rtc_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +
> +	int ret;
> +
> +	/* Enable Self Recovery, Clock for Watch and EEPROM refresh functions*/
> +	ret = regmap_update_bits(regmap, ABEOZ9S3_REG_CTRL1,
> +				 ABEOZ9S3_REG_CTRL1_MASK,
> +				 ABEOZ9S3_REG_CTRL1_WE |
> +				 ABEOZ9S3_REG_CTRL1_EERE |
> +				 ABEOZ9S3_REG_CTRL1_SRON);

You can just use regmap_write here and drop ABEOZ9S3_REG_CTRL1_MASK

> +	if (ret < 0) {
> +		dev_err(dev, "unable to set control 1 register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(regmap, ABEOZ9S3_REG_CTRL2,
> +				 ABEOZ9S3_REG_CTRL2_MASK, 0);

Same here, this just write 0 in ABEOZ9S3_REG_CTRL2 as all the other bits
will read 0.

> +	if (ret < 0) {
> +		dev_err(dev, "unable to set control 2 register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(regmap, ABEOZ9S3_REG_CTRL3,
> +				 ABEOZ9S3_REG_CTRL3_MASK, 0);

Ditto.

> +	if (ret < 0) {
> +		dev_err(dev, "unable to set control 3 register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(regmap, ABEOZ9S3_REG_CTRL4,
> +				 ABEOZ9S3_REG_CTRL4_MASK, 0);

Ditto.

However, this loses valuable information. PON, V2F and V1F are very
important as they may indicate that the time set in the RTC is now
inaccurate. This has to be used in .read_time and reset only in
.set_time.

Also, I would rename CTRL2 to CTRL4 according to the datasheet.

> +	if (ret < 0) {
> +		dev_err(dev, "unable to set control 4 register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = abeoz9s3_trickle_parse_dt(node);
> +
> +	/* Enable built-in termometer */
> +	ret |= ABEOZ9S3_REG_EEPROM_THE;
> +
> +	ret = regmap_update_bits(regmap, ABEOZ9S3_REG_EEPROM,
> +				 ABEOZ9S3_REG_EEPROM_MASK,
> +				 ret);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to set eeprom register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct rtc_class_ops rtc_ops = {
> +	.read_time = abeoz9s3_rtc_get_time,
> +	.set_time  = abeoz9s3_rtc_set_time,
> +};
> +
> +static const struct regmap_config abeoz9s3_rtc_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +#if IS_REACHABLE(CONFIG_HWMON)
> +
> +static int abeoz9z3_temp_read(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long *temp)
> +{
> +	struct abeoz9s3_rtc_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret;
> +	unsigned int regval = 37;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		ret = regmap_read(regmap, ABEOZ9S3_REG_REG_TEMP, &regval);
> +		if (ret < 0)
> +			return ret;
> +		*temp = 1000 * (regval + ABEOZ953_TEMP_MIN);
> +		return 0;
> +	case hwmon_temp_max:
> +		*temp = 1000 * ABEOZ953_TEMP_MAX;
> +		return 0;
> +	case hwmon_temp_min:
> +		*temp = 1000 * ABEOZ953_TEMP_MIN;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t abeoz9s3_is_visible(const void *data,
> +				   enum hwmon_sensor_types type,
> +				   u32 attr, int channel)
> +{
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_max:
> +	case hwmon_temp_min:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const u32 abeoz9s3_chip_config[] = {
> +	HWMON_C_REGISTER_TZ,
> +	0
> +};
> +
> +static const struct hwmon_channel_info abeoz9s3_chip = {
> +	.type = hwmon_chip,
> +	.config = abeoz9s3_chip_config,
> +};
> +
> +static const u32 abeoz9s3_temp_config[] = {
> +	HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN,
> +	0
> +};
> +
> +static const struct hwmon_channel_info abeoz9s3_temp = {
> +	.type = hwmon_temp,
> +	.config = abeoz9s3_temp_config,
> +};
> +
> +static const struct hwmon_channel_info *abeoz9s3_info[] = {
> +	&abeoz9s3_chip,
> +	&abeoz9s3_temp,
> +	NULL
> +};
> +
> +static const struct hwmon_ops abeoz9s3_hwmon_ops = {
> +	.is_visible = abeoz9s3_is_visible,
> +	.read = abeoz9z3_temp_read,
> +};
> +
> +static const struct hwmon_chip_info abeoz9s3_chip_info = {
> +	.ops = &abeoz9s3_hwmon_ops,
> +	.info = abeoz9s3_info,
> +};
> +
> +static void abeoz9s3_hwmon_register(struct device *dev,
> +				    struct abeoz9s3_rtc_data *data)
> +{
> +	data->hwmon_dev =
> +		devm_hwmon_device_register_with_info(dev,
> +						     "abeoz9s3",
> +						     data,
> +						     &abeoz9s3_chip_info,
> +						     NULL);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		dev_warn(dev, "unable to register hwmon device %ld\n",
> +			 PTR_ERR(data->hwmon_dev));
> +	}
> +}
> +
> +#else
> +
> +static void abeoz9s3_hwmon_register(struct device *dev,
> +				    struct abeoz9s3_rtc_data *data)
> +{
> +}
> +
> +#endif /* CONFIG_RTC_DRV_ABEOZ9S3_HWMON */
> +
> +static int abeoz9s3_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct abeoz9s3_rtc_data *data = NULL;
> +	struct device *dev = &client->dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +				     I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, &abeoz9s3_rtc_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(dev, "regmap allocation failed: %d\n", ret);
> +		goto err;
> +	}
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	mutex_init(&data->lock);
> +	data->regmap = regmap;
> +	dev_set_drvdata(dev, data);
> +
> +	ret = abeoz9s3_rtc_setup(dev, client->dev.of_node);
> +	if (ret)
> +		goto err;
> +
> +	data->rtc = devm_rtc_allocate_device(dev);
> +	ret = PTR_ERR_OR_ZERO(data->rtc);
> +	if (ret)
> +		goto err;
> +
> +	data->rtc->ops = &rtc_ops;
> +	data->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	data->rtc->range_max = RTC_TIMESTAMP_END_2099;
> +
> +	ret = rtc_register_device(data->rtc);
> +	if (ret)
> +		goto err;
> +
> +	abeoz9s3_hwmon_register(dev, data);
> +	return 0;
> +err:
> +	dev_err(dev, "unable to register RTC device (%d)\n", ret);
> +	return ret;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id abeoz9s3_dt_match[] = {
> +	{ .compatible = "abracon,abeoz9s3" },

This compatible string needs to be documented. You can simply add it in
Documentation/devicetree/bindings/rtc/rtc.txt

> +	{ },
> +};
> +#endif
> +
> +MODULE_DEVICE_TABLE(of, abeoz9s3_dt_match);
> +
> +static const struct i2c_device_id abeoz9s3_id[] = {
> +	{ "abeoz9s3", 0 },
> +	{ }
> +};
> +
> +static struct i2c_driver abeoz9s3_driver = {
> +	.driver = {
> +		.name = "rtc-ab-eoz9-s3",
> +		.of_match_table = of_match_ptr(abeoz9s3_dt_match),
> +	},
> +	.probe	  = abeoz9s3_probe,
> +	.id_table = abeoz9s3_id,
> +};
> +
> +module_i2c_driver(abeoz9s3_driver);
> +
> +MODULE_AUTHOR("Artem Panfilov panfilov.artyom@gmail.com");

I would put "Artem Panfilov <panfilov.artyom@gmail.com>" here.

> +MODULE_DESCRIPTION("Abracon AB-RTCMC-32.768kHz-EOZ9-S3 RTC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
