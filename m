Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104F2C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED1720881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388215AbfA3Vsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:48:30 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40691 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfA3Vsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:48:30 -0500
X-Originating-IP: 86.202.150.119
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr [86.202.150.119])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4312B20002;
        Wed, 30 Jan 2019 21:48:27 +0000 (UTC)
Date:   Wed, 30 Jan 2019 22:48:28 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rtc: add AB-RTCMC-32.768kHz-EOZ9 RTC support
Message-ID: <20190130214828.GK19959@piout.net>
References: <20190117184608.20987-1-panfilov.artyom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117184608.20987-1-panfilov.artyom@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This seems pretty good.

On 17/01/2019 21:46:07+0300, Artem Panfilov wrote:
> +static int abeoz9_rtc_get_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct abeoz9_rtc_data *data = dev_get_drvdata(dev);
> +	u8 regs[ABEOZ9_SEC_LEN];
> +	int ret;
> +

I would check the validity here, there is no point in reading many
registers just to drop the result afterwards.

> +	ret = regmap_bulk_read(data->regmap, ABEOZ9_REG_SEC,
> +			       regs,
> +			       sizeof(regs));
> +	if (ret) {
> +		dev_err(dev, "reading RTC time failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	tm->tm_sec = bcd2bin(regs[ABEOZ9_REG_SEC - ABEOZ9_REG_SEC] & 0x7F);
> +	tm->tm_min = bcd2bin(regs[ABEOZ9_REG_MIN - ABEOZ9_REG_SEC] & 0x7F);
> +
> +	if (regs[ABEOZ9_REG_HOURS - ABEOZ9_REG_SEC] & ABEOZ9_HOURS_PM) {
> +		tm->tm_hour =
> +			bcd2bin(regs[ABEOZ9_REG_HOURS - ABEOZ9_REG_SEC] & 0x1f);
> +		if (regs[ABEOZ9_REG_HOURS - ABEOZ9_REG_SEC] & ABEOZ9_HOURS_PM)
> +			tm->tm_hour += 12;
> +	} else {
> +		tm->tm_hour = bcd2bin(regs[ABEOZ9_REG_HOURS - ABEOZ9_REG_SEC]);
> +	}
> +
> +	tm->tm_mday = bcd2bin(regs[ABEOZ9_REG_DAYS - ABEOZ9_REG_SEC]);
> +	tm->tm_wday = bcd2bin(regs[ABEOZ9_REG_WEEKDAYS - ABEOZ9_REG_SEC]);
> +	tm->tm_mon  = bcd2bin(regs[ABEOZ9_REG_MONTHS - ABEOZ9_REG_SEC]) - 1;
> +	tm->tm_year = bcd2bin(regs[ABEOZ9_REG_YEARS - ABEOZ9_REG_SEC]) + 100;
> +
> +	return abeoz9_check_validity(dev);
> +}
> +
> +static int abeoz9_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct abeoz9_rtc_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	u8 regs[ABEOZ9_SEC_LEN];
> +	int ret;
> +
> +	regs[ABEOZ9_REG_SEC - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_sec);
> +	regs[ABEOZ9_REG_MIN - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_min);
> +	regs[ABEOZ9_REG_HOURS - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_hour);
> +	regs[ABEOZ9_REG_DAYS - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_mday);
> +	regs[ABEOZ9_REG_WEEKDAYS - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_wday);
> +	regs[ABEOZ9_REG_MONTHS - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_mon + 1);
> +	regs[ABEOZ9_REG_YEARS - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_year - 100);
> +
> +	ret = regmap_bulk_write(data->regmap, ABEOZ9_REG_SEC,
> +				regs,
> +				sizeof(regs));
> +

ret should be checked.

> +	return abeoz9_reset_validity(regmap);
> +}
> +
> +#if IS_REACHABLE(CONFIG_HWMON)
> +
> +static int abeoz9z3_temp_read(struct device *dev,
> +			      enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long *temp)
> +{
> +	struct abeoz9_rtc_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret;
> +	unsigned int regval = 37;
> +

Maybe this should also check V1F/V2F because the thermometer may be
disabled.

> +	switch (attr) {
> +	case hwmon_temp_input:
> +		ret = regmap_read(regmap, ABEOZ9_REG_REG_TEMP, &regval);
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


> +#endif /* CONFIG_RTC_DRV_ABEOZ9_HWMON */
This comment is not correct


> +static int abeoz9_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct abeoz9_rtc_data *data = NULL;
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
> +	regmap = devm_regmap_init_i2c(client, &abeoz9_rtc_regmap_config);
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
> +	data->regmap = regmap;
> +	dev_set_drvdata(dev, data);
> +
> +	ret = abeoz9_rtc_setup(dev, client->dev.of_node);
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
> +	abeoz9_hwmon_register(dev, data);
> +	return 0;

I would add a blank line here.

> +err:
> +	dev_err(dev, "unable to register RTC device (%d)\n", ret);
> +	return ret;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id abeoz9_dt_match[] = {
> +	{ .compatible = "abracon,abeoz9" },
> +	{ },
> +};
> +#endif
> +
> +MODULE_DEVICE_TABLE(of, abeoz9_dt_match);

This should probably be included in the previous #ifdef

> +
> +static const struct i2c_device_id abeoz9_id[] = {
> +	{ "abeoz9", 0 },
> +	{ }
> +};
> +
> +static struct i2c_driver abeoz9_driver = {
> +	.driver = {
> +		.name = "rtc-ab-eoz9",
> +		.of_match_table = of_match_ptr(abeoz9_dt_match),
> +	},
> +	.probe	  = abeoz9_probe,
> +	.id_table = abeoz9_id,
> +};
> +
> +module_i2c_driver(abeoz9_driver);
> +
> +MODULE_AUTHOR("Artem Panfilov <panfilov.artyom@gmail.com>");
> +MODULE_DESCRIPTION("Abracon AB-RTCMC-32.768kHz-EOZ9 RTC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.19.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
