Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A3CC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8047520833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaSWKI7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8047520833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeI3WBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 18:01:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46825 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeI3WBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 18:01:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so7671560pga.13;
        Sun, 30 Sep 2018 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DC2R2DUePwjNrKRyarAkVFFVwDfElOsKP6pWN/URmak=;
        b=kaSWKI7tySZjMPLjDSmG8XgKi25rZVfmSnoQsKYXeoHYTlV9k44Z4x5Rl+dJQ7QTSO
         cUYat+gLfFIV9on/E/3hvtzaBuGU8OuBZi2uF2tdnRY9MEIcogA3OxDu1FAFejeQnPxt
         ZugkUXG3ZoyFm5dpada+uT49QBpQ21t2j44u7Iv5Rlg2DeBKvQHVy893jkuhZ5Rk7H+I
         f/SjxxYACsDdmnTNEDqzzIIf7SXWmfYFVs9WG5EA0HlnwazLZe5qR/A6DdSKbOaYf7kI
         lGyRWkB8W40eo9NWVQPRq2bpkZXC/4825Rs6aRg9cGGGlIbOhsdYQcrF7jqF63fs15m1
         hrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DC2R2DUePwjNrKRyarAkVFFVwDfElOsKP6pWN/URmak=;
        b=ewRH8Im73iEoj3Q3OhkUQc7igEqfdg2PLozJ/hi7eyXHML2X82Z2asYT9uO41q8w0o
         m0wOuyK7haCLNZdJ276pGAcrrPivSNmaRrpm8n5f4Cf2xplB+mt/3MwgzBAi3nLt47pE
         G54X3eozGbviMGh3Tu57IFYOFDdHh37ojlSUSLZNQu/a+W01fdW8CZsr/+LtqdAKkQFp
         vEHShdFN8qHw/qxgyfFrao97HeAc2laRYcK2tIr1QaveVCN5CEWqEW4PKakRYE/q6zoY
         iZuxVgqC5PNnM2uTlr8UFMQlvWDdAQUrPd+yrgV0tUfe2Gvzb6wsupGnwcGb+rogtOqt
         qtnQ==
X-Gm-Message-State: ABuFfoj3fydOqWEbBgM3hQ6XwUYpF9hhgfuNd2wPpJNZ+4QK3/terjGd
        Z9zCgC+YfTSdWLghSH1s0hYcL94c
X-Google-Smtp-Source: ACcGV63ZaGIFPaLIIulOA4iXYzH4dykcoo1f5i0m1zNqbmyIJJcFmEDRM5v/2HQvxtEyY2PakqpbNw==
X-Received: by 2002:a63:5509:: with SMTP id j9-v6mr6623266pgb.208.1538321271097;
        Sun, 30 Sep 2018 08:27:51 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s16-v6sm14373440pfm.114.2018.09.30.08.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 08:27:50 -0700 (PDT)
Date:   Sun, 30 Sep 2018 08:27:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: ina3221: Add suspend and resume functions
Message-ID: <20180930152749.GA16746@roeck-us.net>
References: <20180929214407.27208-1-nicoleotsuka@gmail.com>
 <20180929214407.27208-4-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929214407.27208-4-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 02:44:07PM -0700, Nicolin Chen wrote:
> Depending on the hardware design, an INA3221 chip might lose
> its power during system suspend/resume. So this patch adds
> a set of suspend and resume functions to cache the register
> values including config register value and limit settings.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied to hwmon-next, with a minor change; see below.

Thanks,
Guenter

> ---
> Changelog
> v1->v2:
>  * Added power-down setting during suspend for power saving
> 
>  drivers/hwmon/ina3221.c | 63 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index e0c4f4d83f4e..877952efaa88 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -38,6 +38,8 @@
>  #define INA3221_WARN3			0x0c
>  #define INA3221_MASK_ENABLE		0x0f
>  
> +#define INA3221_CONFIG_MODE_MASK	GENMASK(2, 0)
> +#define INA3221_CONFIG_MODE_POWERDOWN	0
>  #define INA3221_CONFIG_MODE_SHUNT	BIT(0)
>  #define INA3221_CONFIG_MODE_BUS		BIT(1)
>  #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(2)
> @@ -91,11 +93,13 @@ static const unsigned int register_channel[] = {
>   * @regmap: Register map of the device
>   * @fields: Register fields of the device
>   * @shunt_resistors: Array of resistor values per channel
> + * @reg_config: Register value of INA3221_CONFIG
>   */
>  struct ina3221_data {
>  	struct regmap *regmap;
>  	struct regmap_field *fields[F_MAX_FIELDS];
>  	int shunt_resistors[INA3221_NUM_CHANNELS];
> +	u32 reg_config;
>  };
>  
>  static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
> @@ -415,9 +419,67 @@ static int ina3221_probe(struct i2c_client *client,
>  		return PTR_ERR(hwmon_dev);
>  	}
>  
> +	dev_set_drvdata(dev, ina);
> +

It is better to call that function before registering the hwmon device,
to avoid the theroretical possibility that suspend is called before drvdata
is set. I moved the call accordingly.

>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int ina3221_suspend(struct device *dev)
> +{
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Save config register value and enable cache-only */
> +	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
> +	if (ret)
> +		return ret;
> +
> +	/* Set to power-down mode for power saving */
> +	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
> +				 INA3221_CONFIG_MODE_MASK,
> +				 INA3221_CONFIG_MODE_POWERDOWN);
> +	if (ret)
> +		return ret;
> +
> +	regcache_cache_only(ina->regmap, true);
> +	regcache_mark_dirty(ina->regmap);
> +
> +	return 0;
> +}
> +
> +static int ina3221_resume(struct device *dev)
> +{
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	int ret;
> +
> +	regcache_cache_only(ina->regmap, false);
> +
> +	/* Software reset the chip */
> +	ret = regmap_field_write(ina->fields[F_RST], true);
> +	if (ret) {
> +		dev_err(dev, "Unable to reset device\n");
> +		return ret;
> +	}
> +
> +	/* Restore cached register values to hardware */
> +	ret = regcache_sync(ina->regmap);
> +	if (ret)
> +		return ret;
> +
> +	/* Restore config register value to hardware */
> +	ret = regmap_write(ina->regmap, INA3221_CONFIG, ina->reg_config);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops ina3221_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(ina3221_suspend, ina3221_resume)
> +};
> +
>  static const struct of_device_id ina3221_of_match_table[] = {
>  	{ .compatible = "ti,ina3221", },
>  	{ /* sentinel */ }
> @@ -435,6 +497,7 @@ static struct i2c_driver ina3221_i2c_driver = {
>  	.driver = {
>  		.name = INA3221_DRIVER_NAME,
>  		.of_match_table = ina3221_of_match_table,
> +		.pm = &ina3221_pm,
>  	},
>  	.id_table = ina3221_ids,
>  };
