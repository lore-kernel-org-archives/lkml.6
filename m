Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098B7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B569420892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2CMi2Qq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B569420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeKJLsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 06:48:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40001 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeKJLr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 06:47:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id q19-v6so1720200pll.7;
        Fri, 09 Nov 2018 18:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FCwoP0P8yOTJlhuFfHI7km2RgSJiorPwIWbR6x1mqvU=;
        b=F2CMi2QqZXmWxy2t0P4Y400b+3uMkPk/eoLjw1c3DjxneLSY0sDaSH1lw6gEKJfFyk
         +O5djCoQ3UWT3gAzmtQpqNV7kg2IjvqAC8U6KoagvbD0dkDfo6HBwf5PyYqgYrqKaWVL
         /IndNZUQ8VmOal2xSHLtqVht1lXaATfiK6zcP4puftAQz/JzEe4tBpjijzNRGYD+II8L
         8p2ex98/1DaQOJ6amJBe9MqDNOxWqSLd3Dlp9m4NKbJcq0bzR36/sqYWQq4DtK2rNRR1
         vVYkfZHCOAfUgIcr7X2xpY5geDFgwlT7hYC4o7iIwgsAVYu53t/9qFoAvp2S7H3+Muan
         lN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=FCwoP0P8yOTJlhuFfHI7km2RgSJiorPwIWbR6x1mqvU=;
        b=KQktdc4vjtnkT29VCP9oOakggxAa4QMbI8ybsFX65bqcznXOTJXxKNuBDGCAOx2rGA
         rKs2PrI4o5UVBUEtLZeB5aNzzylPCPH6RltxBSbqXj0o3wx4PsqvpeVv+xiLpttIpV8p
         4orGMX1Rv/QDr9Y6NBocctILtBq92xq+l99o+RlRiCWi2skuJMpvFXMipEMRnrGSLvLW
         jMQgJ1JhuUHHa1lSUxilyZFuZvE+D3mcVkIDxMJ0ADhXG+1znskkoXkzDxwRAwZAQ5zI
         ZwR9jWKkLr5Oo6vpi5LkTZt31/jDu3B1bBUc1DJqvyG13dChK1vXZhVgB9msmJTCVTc1
         TjoQ==
X-Gm-Message-State: AGRZ1gIWcIO6RBO08lZKCQcE2CAGyAQYkfQOGZymeHaxn2IKST5kDxez
        XW0+ts1XZGpmz84b9Fd5ToE=
X-Google-Smtp-Source: AJdET5ftaaXAr29Ah3Pi2bPeo1Rc+IpFNDtLKlvU8DYnWSCMQgtwZ5YcwIig2VMykXfRwiCcej7U5w==
X-Received: by 2002:a17:902:244:: with SMTP id 62-v6mr11407849plc.280.1541815482486;
        Fri, 09 Nov 2018 18:04:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p62-v6sm8682395pfp.111.2018.11.09.18.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 18:04:41 -0800 (PST)
Date:   Fri, 9 Nov 2018 18:04:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon (ina2xx) Fix NULL id pointer in probe()
Message-ID: <20181110020441.GA13877@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 04:42:14PM -0800, Nicolin Chen wrote:
> When using DT configurations, the id pointer might turn out to
> be NULL. Then the driver encounters NULL pointer access:
> 
>   Unable to handle kernel read from unreadable memory at vaddr 00000018
>   [...]
>   PC is at ina2xx_probe+0x114/0x200
>   LR is at ina2xx_probe+0x10c/0x200
>   [...]
>   Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> The reason is that i2c core returns the id pointer by matching
> id_table with client->name, while the client->name is actually
> using the name from the first string in the DT compatible list,
> not the best one. So i2c core would fail to match the id_table
> if the best matched compatible string isn't the first one, and
> then would return a NULL id pointer.
> 
> This probably should be fixed in i2c core. But it doesn't hurt
> to make the driver robust. So this patch fixes it by using the
> "chip" that's added to unify both DT and non-DT configurations.
> 
> Additionally, since id pointer could be null, so as id->name:
>   ina2xx 10-0047: power monitor (null) (Rshunt = 1000 uOhm)
>   ina2xx 10-0048: power monitor (null) (Rshunt = 10000 uOhm)
> 
> So this patch also fixes NULL name pointer, using client->name
> to play safe and to align with hwmon->name.
> 
> Fixes: bd0ddd4d0883 ("hwmon: (ina2xx) Add OF device ID table")
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ina2xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index 71d3445ba869..c2252cf452f5 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -491,7 +491,7 @@ static int ina2xx_probe(struct i2c_client *client,
>  	}
>  
>  	data->groups[group++] = &ina2xx_group;
> -	if (id->driver_data == ina226)
> +	if (chip == ina226)
>  		data->groups[group++] = &ina226_group;
>  
>  	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> @@ -500,7 +500,7 @@ static int ina2xx_probe(struct i2c_client *client,
>  		return PTR_ERR(hwmon_dev);
>  
>  	dev_info(dev, "power monitor %s (Rshunt = %li uOhm)\n",
> -		 id->name, data->rshunt);
> +		 client->name, data->rshunt);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
