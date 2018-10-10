Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BF7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD1D21568
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QANlWsTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD1D21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJJH7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:59:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44391 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeJJH7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:59:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id r9-v6so1691586pff.11;
        Tue, 09 Oct 2018 17:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TRnvesHUliFjYJ8/fP8jErGD/yJv5PkD0X7T8VX4i+g=;
        b=QANlWsTj8e1O7F8mbTYwgGgPlaRC9a0xF0PGBEDkZUpI++EvdaTsECZfeny1ryDzwI
         Xuer/p8ydQokGOi4NjYkNPy2ISTIn0KJOa2vv6yBU8D977Jaib4jSY+RUWTVGpz0dPJr
         o2w9UZX0YcJAKJKIs/JT+WdesiO53U36+GGryei4Z1rtNl8FLH3bAnqmG30w+F/ntEQk
         pUQzkCLOD2OVV1RAiHtURr5NewD6v2Zchqd4cZELtrFloguqjOQip/W1YcV8waMFAFio
         Ps1Uxu7va1VFZt9vhZQ81iBJ0052jL1M4np+a41SlPs431L4tDUDzSBa+nUip6U88FzX
         L/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TRnvesHUliFjYJ8/fP8jErGD/yJv5PkD0X7T8VX4i+g=;
        b=QQ82Fzmgc1UYyFcpP8J9T3FTTi4viRep7UITcRn5aPRXYFdiEfopEbe57OOuYDT1tH
         QD2Xt84/hYvaFDEMXS8KPcEFh6pKti+gl5giwvL30U0fieVSqSuy9Xt3qtvVfkVs4fT+
         F5bmLV5dvTBRylagbMi1u0IYd5GNZXU32FoEL8v8ADzbVNPvai1jlpJYifd01cG2ArLn
         RDvUDhe5qxwsmq9xPNdH9mGoa87ccYHcShagfhuFEYKhyWWf+UuOrRR79Rsju6E0/pKE
         QWnqVyBVXYAmyxf6eQT1oXp0hId/dmw2V6TMdXF2GPR4h6AhwZMx7EuAANRmuzWnRyYK
         gicA==
X-Gm-Message-State: ABuFfogfkaJeH7/XlUe1iMX1vt8UToyGMMmd7ZdnCSGfR19wd4o+JEYT
        LHqilvMHnR753GCTiyzPsXo=
X-Google-Smtp-Source: ACcGV61jHqoQyi1K32fKyCNmcXC1leoNeDafOaYP5/oTHXMddwvsqIwtzu28L+d1AGKALkuvG2Pkuw==
X-Received: by 2002:a62:1112:: with SMTP id z18-v6mr32585711pfi.200.1539132010484;
        Tue, 09 Oct 2018 17:40:10 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x17-v6sm26853874pfn.59.2018.10.09.17.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 17:40:09 -0700 (PDT)
Date:   Tue, 9 Oct 2018 17:40:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (ina3221) Use _info API to register hwmon
 device
Message-ID: <20181010004009.GA22161@roeck-us.net>
References: <20181008201424.22978-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008201424.22978-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 01:14:24PM -0700, Nicolin Chen wrote:
> The hwmon core has a newer API which abstracts most of common
> things in the core so as to simplify the hwmon device drivers.
> 
> This patch implements this _info API to ina3221 hwmon driver.
> 
> It also reduces the binary size:
>    text	   data	    bss	    dec	    hex	filename
>    5114	   1712	      0	   6826	   1aaa	drivers/hwmon/ina3221_before.o
>    4456	    440	      0	   4896	   1320	drivers/hwmon/ina3221.o
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Changelog
> v1->v2:
>  * Added a binary size comparison in commit message
>  * Dropped unnecessary checks
>  * Dropped misleading ID conversion in the comments
>  * Added two comments to indicate 0-align channel indexes
>  * Used "fall through" instead of "fallthrough"
> 
>  drivers/hwmon/ina3221.c | 520 ++++++++++++++++++----------------------
>  1 file changed, 236 insertions(+), 284 deletions(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index ce8f0a8c4982..973fc4af0ddf 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -77,21 +77,6 @@ enum ina3221_channels {
>  	INA3221_NUM_CHANNELS
>  };
>  
> -static const unsigned int register_channel[] = {
> -	[INA3221_BUS1] = INA3221_CHANNEL1,
> -	[INA3221_BUS2] = INA3221_CHANNEL2,
> -	[INA3221_BUS3] = INA3221_CHANNEL3,
> -	[INA3221_SHUNT1] = INA3221_CHANNEL1,
> -	[INA3221_SHUNT2] = INA3221_CHANNEL2,
> -	[INA3221_SHUNT3] = INA3221_CHANNEL3,
> -	[INA3221_CRIT1] = INA3221_CHANNEL1,
> -	[INA3221_CRIT2] = INA3221_CHANNEL2,
> -	[INA3221_CRIT3] = INA3221_CHANNEL3,
> -	[INA3221_WARN1] = INA3221_CHANNEL1,
> -	[INA3221_WARN2] = INA3221_CHANNEL2,
> -	[INA3221_WARN3] = INA3221_CHANNEL3,
> -};
> -
>  /**
>   * struct ina3221_input - channel input source specific information
>   * @label: label of channel input source
> @@ -123,58 +108,6 @@ static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
>  	return ina->reg_config & INA3221_CONFIG_CHx_EN(channel);
>  }
>  
> -static ssize_t ina3221_show_label(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> -{
> -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> -	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	unsigned int channel = sd_attr->index;
> -	struct ina3221_input *input = &ina->inputs[channel];
> -
> -	return snprintf(buf, PAGE_SIZE, "%s\n", input->label);
> -}
> -
> -static ssize_t ina3221_show_enable(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> -	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	unsigned int channel = sd_attr->index;
> -
> -	return snprintf(buf, PAGE_SIZE, "%d\n",
> -			ina3221_is_enabled(ina, channel));
> -}
> -
> -static ssize_t ina3221_set_enable(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t count)
> -{
> -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> -	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	unsigned int channel = sd_attr->index;
> -	u16 config, mask = INA3221_CONFIG_CHx_EN(channel);
> -	bool enable;
> -	int ret;
> -
> -	ret = kstrtobool(buf, &enable);
> -	if (ret)
> -		return ret;
> -
> -	config = enable ? mask : 0;
> -
> -	/* Enable or disable the channel */
> -	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
> -	if (ret)
> -		return ret;
> -
> -	/* Cache the latest config register value */
> -	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
> -	if (ret)
> -		return ret;
> -
> -	return count;
> -}
> -
>  static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
>  			      int *val)
>  {
> @@ -190,94 +123,104 @@ static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
>  	return 0;
>  }
>  
> -static ssize_t ina3221_show_bus_voltage(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> +static const u8 ina3221_in_reg[] = {
> +	INA3221_BUS1,
> +	INA3221_BUS2,
> +	INA3221_BUS3,
> +	INA3221_SHUNT1,
> +	INA3221_SHUNT2,
> +	INA3221_SHUNT3,
> +};
> +
> +static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
>  {
> -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> +	const bool is_shunt = channel > INA3221_CHANNEL3;
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	unsigned int reg = sd_attr->index;
> -	unsigned int channel = register_channel[reg];
> -	int val, voltage_mv, ret;
> +	u8 reg = ina3221_in_reg[channel];
> +	int regval, ret;
>  
> -	/* No data for read-only attribute if channel is disabled */
> -	if (!attr->store && !ina3221_is_enabled(ina, channel))
> -		return -ENODATA;
> +	/* Translate shunt channel index to sensor channel index */
> +	channel %= INA3221_NUM_CHANNELS;
>  
> -	ret = ina3221_read_value(ina, reg, &val);
> -	if (ret)
> -		return ret;
> +	switch (attr) {
> +	case hwmon_in_input:
> +		if (!ina3221_is_enabled(ina, channel))
> +			return -ENODATA;
>  
> -	voltage_mv = val * 8;
> +		ret = ina3221_read_value(ina, reg, &regval);
> +		if (ret)
> +			return ret;
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", voltage_mv);
> +		/*
> +		 * Scale of shunt voltage (uV): LSB is 40uV
> +		 * Scale of bus voltage (mV): LSB is 8mV
> +		 */
> +		*val = regval * (is_shunt ? 40 : 8);
> +		return 0;
> +	case hwmon_in_enable:
> +		*val = ina3221_is_enabled(ina, channel);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
>  
> -static ssize_t ina3221_show_shunt_voltage(struct device *dev,
> -					  struct device_attribute *attr,
> -					  char *buf)
> +static const u8 ina3221_curr_reg[][INA3221_NUM_CHANNELS] = {
> +	[hwmon_curr_input] = { INA3221_SHUNT1, INA3221_SHUNT2, INA3221_SHUNT3 },
> +	[hwmon_curr_max] = { INA3221_WARN1, INA3221_WARN2, INA3221_WARN3 },
> +	[hwmon_curr_crit] = { INA3221_CRIT1, INA3221_CRIT2, INA3221_CRIT3 },
> +	[hwmon_curr_max_alarm] = { F_WF1, F_WF2, F_WF3 },
> +	[hwmon_curr_crit_alarm] = { F_CF1, F_CF2, F_CF3 },
> +};
> +
> +static int ina3221_read_curr(struct device *dev, u32 attr,
> +			     int channel, long *val)
>  {
> -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	unsigned int reg = sd_attr->index;
> -	unsigned int channel = register_channel[reg];
> -	int val, voltage_uv, ret;
> -
> -	/* No data for read-only attribute if channel is disabled */
> -	if (!attr->store && !ina3221_is_enabled(ina, channel))
> -		return -ENODATA;
> -
> -	ret = ina3221_read_value(ina, reg, &val);
> -	if (ret)
> -		return ret;
> -	voltage_uv = val * 40;
> -
> -	return snprintf(buf, PAGE_SIZE, "%d\n", voltage_uv);
> -}
> -
> -static ssize_t ina3221_show_current(struct device *dev,
> -				    struct device_attribute *attr, char *buf)
> -{
> -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> -	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	unsigned int reg = sd_attr->index;
> -	unsigned int channel = register_channel[reg];
>  	struct ina3221_input *input = &ina->inputs[channel];
>  	int resistance_uo = input->shunt_resistor;
> -	int val, current_ma, voltage_nv, ret;
> +	u8 reg = ina3221_curr_reg[attr][channel];
> +	int regval, voltage_nv, ret;
>  
> -	/* No data for read-only attribute if channel is disabled */
> -	if (!attr->store && !ina3221_is_enabled(ina, channel))
> -		return -ENODATA;
> +	switch (attr) {
> +	case hwmon_curr_input:
> +		if (!ina3221_is_enabled(ina, channel))
> +			return -ENODATA;
> +		/* fall through */
> +	case hwmon_curr_crit:
> +	case hwmon_curr_max:
> +		ret = ina3221_read_value(ina, reg, &regval);
> +		if (ret)
> +			return ret;
>  
> -	ret = ina3221_read_value(ina, reg, &val);
> -	if (ret)
> -		return ret;
> -	voltage_nv = val * 40000;
> -
> -	current_ma = DIV_ROUND_CLOSEST(voltage_nv, resistance_uo);
> -
> -	return snprintf(buf, PAGE_SIZE, "%d\n", current_ma);
> +		/* Scale of shunt voltage: LSB is 40uV (40000nV) */
> +		voltage_nv = regval * 40000;
> +		/* Return current in mA */
> +		*val = DIV_ROUND_CLOSEST(voltage_nv, resistance_uo);
> +		return 0;
> +	case hwmon_curr_crit_alarm:
> +	case hwmon_curr_max_alarm:
> +		ret = regmap_field_read(ina->fields[reg], &regval);
> +		if (ret)
> +			return ret;
> +		*val = regval;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
>  
> -static ssize_t ina3221_set_current(struct device *dev,
> -				   struct device_attribute *attr,
> -				   const char *buf, size_t count)
> +static int ina3221_write_curr(struct device *dev, u32 attr,
> +			      int channel, long val)
>  {
> -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	unsigned int reg = sd_attr->index;
> -	unsigned int channel = register_channel[reg];
>  	struct ina3221_input *input = &ina->inputs[channel];
>  	int resistance_uo = input->shunt_resistor;
> -	int val, current_ma, voltage_uv, ret;
> -
> -	ret = kstrtoint(buf, 0, &current_ma);
> -	if (ret)
> -		return ret;
> +	u8 reg = ina3221_curr_reg[attr][channel];
> +	int regval, current_ma, voltage_uv;
>  
>  	/* clamp current */
> -	current_ma = clamp_val(current_ma,
> +	current_ma = clamp_val(val,
>  			       INT_MIN / resistance_uo,
>  			       INT_MAX / resistance_uo);
>  
> @@ -287,15 +230,168 @@ static ssize_t ina3221_set_current(struct device *dev,
>  	voltage_uv = clamp_val(voltage_uv, -163800, 163800);
>  
>  	/* 1 / 40uV(scale) << 3(register shift) = 5 */
> -	val = DIV_ROUND_CLOSEST(voltage_uv, 5) & 0xfff8;
> +	regval = DIV_ROUND_CLOSEST(voltage_uv, 5) & 0xfff8;
>  
> -	ret = regmap_write(ina->regmap, reg, val);
> +	return regmap_write(ina->regmap, reg, regval);
> +}
> +
> +static int ina3221_write_enable(struct device *dev, int channel, bool enable)
> +{
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	u16 config, mask = INA3221_CONFIG_CHx_EN(channel);
> +	int ret;
> +
> +	config = enable ? mask : 0;
> +
> +	/* Enable or disable the channel */
> +	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
>  	if (ret)
>  		return ret;
>  
> -	return count;
> +	/* Cache the latest config register value */
> +	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
>  }
>  
> +static int ina3221_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		/* 0-align channel ID */
> +		return ina3221_read_in(dev, attr, channel - 1, val);
> +	case hwmon_curr:
> +		return ina3221_read_curr(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int ina3221_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		/* 0-align channel ID */
> +		return ina3221_write_enable(dev, channel - 1, val);
> +	case hwmon_curr:
> +		return ina3221_write_curr(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int ina3221_read_string(struct device *dev, enum hwmon_sensor_types type,
> +			       u32 attr, int channel, const char **str)
> +{
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	int index = channel - 1;
> +
> +	*str = ina->inputs[index].label;
> +
> +	return 0;
> +}
> +
> +static umode_t ina3221_is_visible(const void *drvdata,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	const struct ina3221_data *ina = drvdata;
> +	const struct ina3221_input *input = NULL;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		/* Ignore in0_ */
> +		if (channel == 0)
> +			return 0;
> +
> +		switch (attr) {
> +		case hwmon_in_label:
> +			if (channel - 1 <= INA3221_CHANNEL3)
> +				input = &ina->inputs[channel - 1];
> +			/* Hide label node if label is not provided */
> +			return (input && input->label) ? 0444 : 0;
> +		case hwmon_in_input:
> +			return 0444;
> +		case hwmon_in_enable:
> +			return 0644;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +		case hwmon_curr_crit_alarm:
> +		case hwmon_curr_max_alarm:
> +			return 0444;
> +		case hwmon_curr_crit:
> +		case hwmon_curr_max:
> +			return 0644;
> +		default:
> +			return 0;
> +		}
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const u32 ina3221_in_config[] = {
> +	/* 0: dummy, skipped in is_visible */
> +	HWMON_I_INPUT,
> +	/* 1-3: input voltage Channels */
> +	HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +	HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +	HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +	/* 4-6: shunt voltage Channels */
> +	HWMON_I_INPUT,
> +	HWMON_I_INPUT,
> +	HWMON_I_INPUT,
> +	0
> +};
> +
> +static const struct hwmon_channel_info ina3221_in = {
> +	.type = hwmon_in,
> +	.config = ina3221_in_config,
> +};
> +
> +#define INA3221_HWMON_CURR_CONFIG (HWMON_C_INPUT | \
> +				   HWMON_C_CRIT | HWMON_C_CRIT_ALARM | \
> +				   HWMON_C_MAX | HWMON_C_MAX_ALARM)
> +
> +static const u32 ina3221_curr_config[] = {
> +	INA3221_HWMON_CURR_CONFIG,
> +	INA3221_HWMON_CURR_CONFIG,
> +	INA3221_HWMON_CURR_CONFIG,
> +	0
> +};
> +
> +static const struct hwmon_channel_info ina3221_curr = {
> +	.type = hwmon_curr,
> +	.config = ina3221_curr_config,
> +};
> +
> +static const struct hwmon_channel_info *ina3221_info[] = {
> +	&ina3221_in,
> +	&ina3221_curr,
> +	NULL
> +};
> +
> +static const struct hwmon_ops ina3221_hwmon_ops = {
> +	.is_visible = ina3221_is_visible,
> +	.read_string = ina3221_read_string,
> +	.read = ina3221_read,
> +	.write = ina3221_write,
> +};
> +
> +static const struct hwmon_chip_info ina3221_chip_info = {
> +	.ops = &ina3221_hwmon_ops,
> +	.info = ina3221_info,
> +};
> +
> +/* Extra attribute groups */
>  static ssize_t ina3221_show_shunt(struct device *dev,
>  				  struct device_attribute *attr, char *buf)
>  {
> @@ -329,54 +425,6 @@ static ssize_t ina3221_set_shunt(struct device *dev,
>  	return count;
>  }
>  
> -static ssize_t ina3221_show_alert(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> -{
> -	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> -	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	unsigned int field = sd_attr->index;
> -	unsigned int regval;
> -	int ret;
> -
> -	ret = regmap_field_read(ina->fields[field], &regval);
> -	if (ret)
> -		return ret;
> -
> -	return snprintf(buf, PAGE_SIZE, "%d\n", regval);
> -}
> -
> -/* input channel label */
> -static SENSOR_DEVICE_ATTR(in1_label, 0444,
> -		ina3221_show_label, NULL, INA3221_CHANNEL1);
> -static SENSOR_DEVICE_ATTR(in2_label, 0444,
> -		ina3221_show_label, NULL, INA3221_CHANNEL2);
> -static SENSOR_DEVICE_ATTR(in3_label, 0444,
> -		ina3221_show_label, NULL, INA3221_CHANNEL3);
> -
> -/* voltage channel enable */
> -static SENSOR_DEVICE_ATTR(in1_enable, 0644,
> -		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL1);
> -static SENSOR_DEVICE_ATTR(in2_enable, 0644,
> -		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL2);
> -static SENSOR_DEVICE_ATTR(in3_enable, 0644,
> -		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL3);
> -
> -/* bus voltage */
> -static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO,
> -		ina3221_show_bus_voltage, NULL, INA3221_BUS1);
> -static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO,
> -		ina3221_show_bus_voltage, NULL, INA3221_BUS2);
> -static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO,
> -		ina3221_show_bus_voltage, NULL, INA3221_BUS3);
> -
> -/* calculated current */
> -static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO,
> -		ina3221_show_current, NULL, INA3221_SHUNT1);
> -static SENSOR_DEVICE_ATTR(curr2_input, S_IRUGO,
> -		ina3221_show_current, NULL, INA3221_SHUNT2);
> -static SENSOR_DEVICE_ATTR(curr3_input, S_IRUGO,
> -		ina3221_show_current, NULL, INA3221_SHUNT3);
> -
>  /* shunt resistance */
>  static SENSOR_DEVICE_ATTR(shunt1_resistor, S_IRUGO | S_IWUSR,
>  		ina3221_show_shunt, ina3221_set_shunt, INA3221_CHANNEL1);
> @@ -385,109 +433,13 @@ static SENSOR_DEVICE_ATTR(shunt2_resistor, S_IRUGO | S_IWUSR,
>  static SENSOR_DEVICE_ATTR(shunt3_resistor, S_IRUGO | S_IWUSR,
>  		ina3221_show_shunt, ina3221_set_shunt, INA3221_CHANNEL3);
>  
> -/* critical current */
> -static SENSOR_DEVICE_ATTR(curr1_crit, S_IRUGO | S_IWUSR,
> -		ina3221_show_current, ina3221_set_current, INA3221_CRIT1);
> -static SENSOR_DEVICE_ATTR(curr2_crit, S_IRUGO | S_IWUSR,
> -		ina3221_show_current, ina3221_set_current, INA3221_CRIT2);
> -static SENSOR_DEVICE_ATTR(curr3_crit, S_IRUGO | S_IWUSR,
> -		ina3221_show_current, ina3221_set_current, INA3221_CRIT3);
> -
> -/* critical current alert */
> -static SENSOR_DEVICE_ATTR(curr1_crit_alarm, S_IRUGO,
> -		ina3221_show_alert, NULL, F_CF1);
> -static SENSOR_DEVICE_ATTR(curr2_crit_alarm, S_IRUGO,
> -		ina3221_show_alert, NULL, F_CF2);
> -static SENSOR_DEVICE_ATTR(curr3_crit_alarm, S_IRUGO,
> -		ina3221_show_alert, NULL, F_CF3);
> -
> -/* warning current */
> -static SENSOR_DEVICE_ATTR(curr1_max, S_IRUGO | S_IWUSR,
> -		ina3221_show_current, ina3221_set_current, INA3221_WARN1);
> -static SENSOR_DEVICE_ATTR(curr2_max, S_IRUGO | S_IWUSR,
> -		ina3221_show_current, ina3221_set_current, INA3221_WARN2);
> -static SENSOR_DEVICE_ATTR(curr3_max, S_IRUGO | S_IWUSR,
> -		ina3221_show_current, ina3221_set_current, INA3221_WARN3);
> -
> -/* warning current alert */
> -static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO,
> -		ina3221_show_alert, NULL, F_WF1);
> -static SENSOR_DEVICE_ATTR(curr2_max_alarm, S_IRUGO,
> -		ina3221_show_alert, NULL, F_WF2);
> -static SENSOR_DEVICE_ATTR(curr3_max_alarm, S_IRUGO,
> -		ina3221_show_alert, NULL, F_WF3);
> -
> -/* shunt voltage */
> -static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO,
> -		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT1);
> -static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO,
> -		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT2);
> -static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO,
> -		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT3);
> -
>  static struct attribute *ina3221_attrs[] = {
> -	/* channel 1 -- make sure label at first */
> -	&sensor_dev_attr_in1_label.dev_attr.attr,
> -	&sensor_dev_attr_in1_enable.dev_attr.attr,
> -	&sensor_dev_attr_in1_input.dev_attr.attr,
> -	&sensor_dev_attr_curr1_input.dev_attr.attr,
>  	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
> -	&sensor_dev_attr_curr1_crit.dev_attr.attr,
> -	&sensor_dev_attr_curr1_crit_alarm.dev_attr.attr,
> -	&sensor_dev_attr_curr1_max.dev_attr.attr,
> -	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
> -	&sensor_dev_attr_in4_input.dev_attr.attr,
> -
> -	/* channel 2 -- make sure label at first */
> -	&sensor_dev_attr_in2_label.dev_attr.attr,
> -	&sensor_dev_attr_in2_enable.dev_attr.attr,
> -	&sensor_dev_attr_in2_input.dev_attr.attr,
> -	&sensor_dev_attr_curr2_input.dev_attr.attr,
>  	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
> -	&sensor_dev_attr_curr2_crit.dev_attr.attr,
> -	&sensor_dev_attr_curr2_crit_alarm.dev_attr.attr,
> -	&sensor_dev_attr_curr2_max.dev_attr.attr,
> -	&sensor_dev_attr_curr2_max_alarm.dev_attr.attr,
> -	&sensor_dev_attr_in5_input.dev_attr.attr,
> -
> -	/* channel 3 -- make sure label at first */
> -	&sensor_dev_attr_in3_label.dev_attr.attr,
> -	&sensor_dev_attr_in3_enable.dev_attr.attr,
> -	&sensor_dev_attr_in3_input.dev_attr.attr,
> -	&sensor_dev_attr_curr3_input.dev_attr.attr,
>  	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
> -	&sensor_dev_attr_curr3_crit.dev_attr.attr,
> -	&sensor_dev_attr_curr3_crit_alarm.dev_attr.attr,
> -	&sensor_dev_attr_curr3_max.dev_attr.attr,
> -	&sensor_dev_attr_curr3_max_alarm.dev_attr.attr,
> -	&sensor_dev_attr_in6_input.dev_attr.attr,
> -
>  	NULL,
>  };
> -
> -static umode_t ina3221_attr_is_visible(struct kobject *kobj,
> -				       struct attribute *attr, int n)
> -{
> -	const int max_attrs = ARRAY_SIZE(ina3221_attrs) - 1;
> -	const int num_attrs = max_attrs / INA3221_NUM_CHANNELS;
> -	struct device *dev = kobj_to_dev(kobj);
> -	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	enum ina3221_channels channel = n / num_attrs;
> -	struct ina3221_input *input = &ina->inputs[channel];
> -	int index = n % num_attrs;
> -
> -	/* Hide label node if label is not provided */
> -	if (index == 0 && !input->label)
> -		return 0;
> -
> -	return attr->mode;
> -}
> -
> -static const struct attribute_group ina3221_group = {
> -	.is_visible = ina3221_attr_is_visible,
> -	.attrs = ina3221_attrs,
> -};
> -__ATTRIBUTE_GROUPS(ina3221);
> +ATTRIBUTE_GROUPS(ina3221);
>  
>  static const struct regmap_range ina3221_yes_ranges[] = {
>  	regmap_reg_range(INA3221_CONFIG, INA3221_BUS3),
> @@ -622,9 +574,9 @@ static int ina3221_probe(struct i2c_client *client,
>  
>  	dev_set_drvdata(dev, ina);
>  
> -	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
> -							   client->name,
> -							   ina, ina3221_groups);
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, ina,
> +							 &ina3221_chip_info,
> +							 ina3221_groups);
>  	if (IS_ERR(hwmon_dev)) {
>  		dev_err(dev, "Unable to register hwmon device\n");
>  		return PTR_ERR(hwmon_dev);
