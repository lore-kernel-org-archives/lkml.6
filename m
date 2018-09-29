Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7512AC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F23206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcNpmvxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F23206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeI2WCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 18:02:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43898 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeI2WCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 18:02:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id q19-v6so6513603pgn.10;
        Sat, 29 Sep 2018 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OKGv+PAvTSSaE15URe0j351Vi7haxpQd1+yC+y06Jew=;
        b=bcNpmvxgLsRr0L2yNS7lXyxqcTV6Z76NFhS/uKnvR4OwiGca4PQN/fo8YZefBirEz7
         sZ/oxTcsh4UE5zFf9z/RgKJLk/5cn5AwSshOfaQES61LSlrbgBVHXRfTQL2mPD171aq/
         cdM30BtWAW7idfevcknyIXbuohVJEHJK5OMdDHdbfHHiVF5eEd4MPO3LRnTfJq+RVNFp
         LiMtGHNxI6X45sfS+mnbHPG0WFwtV2nDaQPMy+EbCcYkOyomlSU/zgRwsOXKlYKRoOx2
         5KGYo0vNZ4NoX/6e87EdfqfEkqy79U5NQP2Faqx+q1XThpNFoqjRS/uokop8qEeW24u7
         TngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OKGv+PAvTSSaE15URe0j351Vi7haxpQd1+yC+y06Jew=;
        b=NwA9rVD2jlN67nT8PdGrmeO723xhlAF/fQsfZN1S+zM7B19YLAhPFWDdD6Bv4fbzT9
         TpM7eEtJ0KS/kp2Db1W2Vd0WrbMBp9CB++eYNEE78gqtLRT9SqUzj709Xwt/oVSUw3XY
         QIoIL7n6PYTbZKvrSHN7+ycTNgvInMQmR0C7j1rKE6gPQontco0Z5cZPlkrz7gy0UKs4
         CBOfl3w8G32SCT/V4flfNhwLal4ay6Tvs1VxvBuw40w+Bwe/ja5a6iIPqBE+PQYJDJCz
         wUBu+wTGZ5+80Y3u4F4zBkC2XlsbjGYla+l2XBB97E3y9JE++hJfpLteF2GUug0678Du
         IdQw==
X-Gm-Message-State: ABuFfogm+5OTIm7e7NTz6RWEN41Cl5Uz+54E4WRSbFaXkguWcqnBM495
        ETjqitaXmv5BJqI+aEHMm5E=
X-Google-Smtp-Source: ACcGV605WpdEaSKlOIzRWsWae6WVCU9CrnEE5h9u+vI9jYE/iJrEsaj92a7jddrx9D5NkdN5hBApRw==
X-Received: by 2002:a17:902:d715:: with SMTP id w21-v6mr3641249ply.143.1538235229001;
        Sat, 29 Sep 2018 08:33:49 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d18-v6sm18290706pfk.163.2018.09.29.08.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 08:33:48 -0700 (PDT)
Date:   Sat, 29 Sep 2018 08:33:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add suspend and resume functions
Message-ID: <20180929153346.GA26651@roeck-us.net>
References: <20180928214921.11528-1-nicoleotsuka@gmail.com>
 <20180928214921.11528-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928214921.11528-3-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 02:49:21PM -0700, Nicolin Chen wrote:
> Depending on the hardware design, an INA3221 chip might lose
> its power during system suspend/resume. So this patch adds
> a pair of suspend and resume functions to cache the register
> values including config register value and limit settings.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/hwmon/ina3221.c | 54 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index cfe65ff01051..26f66f728b27 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -91,11 +91,13 @@ static const unsigned int register_channel[] = {
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
> @@ -415,8 +417,59 @@ static int ina3221_probe(struct i2c_client *client,
>  		return PTR_ERR(hwmon_dev);
>  	}
>  
> +	dev_set_drvdata(dev, ina);
> +
> +	return 0;
> +}
> +
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

Would it make sense to explicitly disable all channels here ?

Thanks,
Guenter

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
>  	return 0;
>  }
> +#endif
> +
> +static const struct dev_pm_ops ina3221_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(ina3221_suspend, ina3221_resume)
> +};
>  
>  static const struct of_device_id ina3221_of_match_table[] = {
>  	{ .compatible = "ti,ina3221", },
> @@ -435,6 +488,7 @@ static struct i2c_driver ina3221_i2c_driver = {
>  	.driver = {
>  		.name = INA3221_DRIVER_NAME,
>  		.of_match_table = ina3221_of_match_table,
> +		.pm = &ina3221_pm,
>  	},
>  	.id_table = ina3221_ids,
>  };
> -- 
> 2.17.1
> 
