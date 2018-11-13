Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E84C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B5F206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJm9K5Qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B5F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbeKMO3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:29:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38121 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMO3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:29:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so5072623pgq.5;
        Mon, 12 Nov 2018 20:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pvo+gboLEaeHkXi07NrmDlRl5xKGxwIwhzunymMLtCU=;
        b=IJm9K5Qt182yHYs2WOB+uHtBxzeZ949YFu8NKZQssCFW50m/SOmxSDP+JwTGJull+q
         TtPMjvkg+ibKCp2wIxf7ptz8S+J/KUEsBn7SUBS8N0t0k93QbUVi84BCl1fzIi8Fmvho
         JonsotkA+gfOUeEc5caGZeXy8RDQclefn7rZU6VnApxTTt6kwp1hVMyC10nfNB3LT5Lg
         6GfKM/utg4njK2fv1+PFO0rwTf4RaWcyjLHgYnNwD009Igc2MitlFWK+Xyipfq8sd25Y
         7kksJK9tB6TRmCHDCKOaLsRzPK0ZD8zP/hdgz7foRV0HfMDoNiLBBoOY2ZWVKwinFms+
         eFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pvo+gboLEaeHkXi07NrmDlRl5xKGxwIwhzunymMLtCU=;
        b=Cgf2iSOQlNWzyp5BCTKNoAD9gFJfjoPxeTkYGWZ+s2GIx1wf5u+SGjRMEbCqvK2SZn
         OtOdIJxP5kyrI+w7pYIEzmOZwZcZbiDMm2uT1UqItjoBBfxJCIq1/ifnTdbIlQ9YAga2
         yITZMkynkcJD5uX+CCFwSZHIULpvsI6NufqCj3SyMNdqgtnsSUyq2Ka85uVDk2mQYPUC
         dO0RXPGnfQvOERk/U5IhDt5wXSfweW8cbPUm1h/j3ZqaZvOQlNlwRcF2N+zu8ep+RqUG
         AhIjqOHbw4AO++M5bVaEGTua89nupwpURi10G+aL4ZwYwXEx0iK4DIdOvsG/NATnsCAK
         t09Q==
X-Gm-Message-State: AGRZ1gIMqEjKIALvgigoLqTSJROPnsVYfLxJSgMk7H5DODKHVM/qJFAc
        Fv3Z1/9szX2WWLfs+NnRbuQgeavSAe8=
X-Google-Smtp-Source: AJdET5ebJOVCpNAC0CsWB9vAZ6ZAwbdu6lnViVU2mHgMygDnCBGKIBD8EdAHJB0jHkmyqEVNwn5V2Q==
X-Received: by 2002:a63:be4d:: with SMTP id g13mr3404659pgo.378.1542083570344;
        Mon, 12 Nov 2018 20:32:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12sm17092333pgr.55.2018.11.12.20.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 20:32:49 -0800 (PST)
Date:   Mon, 12 Nov 2018 20:32:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon (ina3221) Add single-shot mode support
Message-ID: <20181113043248.GB11205@roeck-us.net>
References: <20181113042353.1507-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113042353.1507-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 08:23:53PM -0800, Nicolin Chen wrote:
> INA3221 supports both continuous and single-shot modes. When
> running in the continuous mode, it keeps measuring the inputs
> and converting them to the data register even if there are no
> users reading the data out. In this use case, this could be a
> power waste.
> 
> So this patch adds a single-shot mode support so that ina3221
> could do measurement and conversion only if users trigger it,
> depending on the use case where it only needs to poll data in
> a lower frequency.
> 
> The change also exposes "mode" and "available_modes" nodes to
> allow users to switch between two operating modes.
> 
Lots and lots of complexity for little gain. Sorry, I don't see
the point of this change.

Guenter

> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  Documentation/hwmon/ina3221 |   3 +
>  drivers/hwmon/ina3221.c     | 109 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+)
> 
> diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
> index 4b82cbfb551c..b03f4ad901ee 100644
> --- a/Documentation/hwmon/ina3221
> +++ b/Documentation/hwmon/ina3221
> @@ -35,3 +35,6 @@ curr[123]_max           Warning alert current(mA) setting, activates the
>                            average is above this value.
>  curr[123]_max_alarm     Warning alert current limit exceeded
>  in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
> +available_modes         Available operating modes of the chip:
> +                          continuous mode; single-shot mode
> +mode                    Current operating mode of the chip
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 17a57dbc0424..8f7da3f75d53 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -91,6 +91,17 @@ enum ina3221_channels {
>  	INA3221_NUM_CHANNELS
>  };
>  
> +enum ina3221_modes {
> +	INA3221_MODE_SINGLE_SHOT,
> +	INA3221_MODE_CONTINUOUS,
> +	INA3221_NUM_MODES,
> +};
> +
> +static const char * const ina3221_mode_names[] = {
> +	[INA3221_MODE_SINGLE_SHOT] = "single-shot",
> +	[INA3221_MODE_CONTINUOUS] = "continuous",
> +};
> +
>  /**
>   * struct ina3221_input - channel input source specific information
>   * @label: label of channel input source
> @@ -127,6 +138,11 @@ static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
>  	       (ina->reg_config & INA3221_CONFIG_CHx_EN(channel));
>  }
>  
> +static inline bool ina3221_is_singleshot_mode(struct ina3221_data *ina)
> +{
> +	return !(ina->reg_config & INA3221_CONFIG_MODE_CONTINUOUS);
> +}
> +
>  /* Lookup table for Bus and Shunt conversion times in usec */
>  static const u16 ina3221_conv_time[] = {
>  	140, 204, 332, 588, 1100, 2116, 4156, 8244,
> @@ -188,6 +204,11 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
>  		if (!ina3221_is_enabled(ina, channel))
>  			return -ENODATA;
>  
> +		/* Write CONFIG register to trigger a single-shot measurement */
> +		if (ina3221_is_singleshot_mode(ina))
> +			regmap_write(ina->regmap, INA3221_CONFIG,
> +				     ina->reg_config);
> +
>  		ret = ina3221_wait_for_data(ina);
>  		if (ret)
>  			return ret;
> @@ -232,6 +253,11 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
>  		if (!ina3221_is_enabled(ina, channel))
>  			return -ENODATA;
>  
> +		/* Write CONFIG register to trigger a single-shot measurement */
> +		if (ina3221_is_singleshot_mode(ina))
> +			regmap_write(ina->regmap, INA3221_CONFIG,
> +				     ina->reg_config);
> +
>  		ret = ina3221_wait_for_data(ina);
>  		if (ret)
>  			return ret;
> @@ -532,6 +558,82 @@ static ssize_t ina3221_set_shunt(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t available_modes_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ina3221_mode_names); i++)
> +		snprintf(buf, PAGE_SIZE, "%s%s ", buf, ina3221_mode_names[i]);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", buf);
> +}
> +
> +static ssize_t mode_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	int mode;
> +
> +	if (ina->reg_config & INA3221_CONFIG_MODE_CONTINUOUS)
> +		mode = INA3221_MODE_CONTINUOUS;
> +	else
> +		mode = INA3221_MODE_SINGLE_SHOT;
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", ina3221_mode_names[mode]);
> +}
> +
> +static ssize_t mode_store(struct device *dev,
> +			  struct device_attribute *attr,
> +			  const char *buf, size_t count)
> +{
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	u16 mask = INA3221_CONFIG_MODE_CONTINUOUS;
> +	u16 continuous;
> +	int mode, ret;
> +	char name[32];
> +
> +	mutex_lock(&ina->lock);
> +
> +	snprintf(name, sizeof(name), "%s", buf);
> +	strim(name);
> +
> +	for (mode = 0; mode < INA3221_NUM_MODES; mode++) {
> +		if (!strcmp(name, ina3221_mode_names[mode]))
> +			break;
> +	}
> +
> +	switch (mode) {
> +	case INA3221_MODE_SINGLE_SHOT:
> +		continuous = 0;
> +		break;
> +	case INA3221_MODE_CONTINUOUS:
> +		continuous = INA3221_CONFIG_MODE_CONTINUOUS;
> +		break;
> +	default:
> +		mutex_unlock(&ina->lock);
> +		return -EINVAL;
> +	}
> +
> +	/* Set register to configure single-shot or continuous mode */
> +	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, continuous);
> +	if (ret) {
> +		mutex_unlock(&ina->lock);
> +		return ret;
> +	}
> +
> +	/* Cache the latest config register value */
> +	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
> +	if (ret) {
> +		mutex_unlock(&ina->lock);
> +		return ret;
> +	}
> +
> +	mutex_unlock(&ina->lock);
> +
> +	return count;
> +}
> +
>  /* shunt resistance */
>  static SENSOR_DEVICE_ATTR(shunt1_resistor, S_IRUGO | S_IWUSR,
>  		ina3221_show_shunt, ina3221_set_shunt, INA3221_CHANNEL1);
> @@ -540,10 +642,17 @@ static SENSOR_DEVICE_ATTR(shunt2_resistor, S_IRUGO | S_IWUSR,
>  static SENSOR_DEVICE_ATTR(shunt3_resistor, S_IRUGO | S_IWUSR,
>  		ina3221_show_shunt, ina3221_set_shunt, INA3221_CHANNEL3);
>  
> +/* operating mode */
> +static DEVICE_ATTR_RW(mode);
> +static DEVICE_ATTR_RO(available_modes);
> +
>  static struct attribute *ina3221_attrs[] = {
>  	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
>  	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
>  	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
> +	/* common attributes */
> +	&dev_attr_mode.attr,
> +	&dev_attr_available_modes.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(ina3221);
> -- 
> 2.17.1
> 
