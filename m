Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E3EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B8320869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds1mWKMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfA3RZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:25:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38380 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfA3RZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:25:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so122632plb.5;
        Wed, 30 Jan 2019 09:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AQPDSHP9hNMnLitiXzM8O9j1dhPkTvS3uxdzzAIMsFs=;
        b=Ds1mWKMR5YWnhEvdxYknQDw0lnF23+xU05aex8x4uipUvo8HJtk0mURLl6Uvkgrc41
         ZeBhEo+nanw4N0YEZjVHMdKCW95V2Vod59TjHPcEJtshujvS8GWnvx8BOi5XYdrwFwtA
         zXe0oTmPRHNdA4JyWvUEGGCuVmO4B66ytMesHOXSJsZ0SRARbjRQ4g0A/Uv0F/MhKBqt
         +c2TsvTfzgjDotGhRPqHAXoOSDVrBM8SPLls5d0MF7/mPF2BJcoiUp2fOxmPsb2vxonF
         5MOIA2a8V678agooOIEP2Z5Ms0YbNkTgiO6X3WIyxVdyJv8CC6kk4qUeRDi0pAmpdluN
         s8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AQPDSHP9hNMnLitiXzM8O9j1dhPkTvS3uxdzzAIMsFs=;
        b=foEQGsTHdveTrmzfxO7d1/tZuaTlpRAHSjBy1pV6rCUafhSUWhNpgYGfyQP4UGY58n
         cvwzn5b3b52aShVVsb8bPY1cuNg0jGGqnW7kIAqSCB/XXS9jeCA/j9xmPPHIYgXeGYGA
         t65kvhEY2ynF4nBA9LrpS7Yw6NjkL3keNrAJFXzJeOh7vPFXjXfahHsV6RI0vF8NzBWf
         ONt6uVmMoJRa7FxvujzKTH7uDOeYM9YS/55M9+CKfzSkxf5bk8uP5eD6PBsJgwYvI5vi
         2KInRz8n6lPy7hinH5ZnJCaOxbSeC5XBEchF6ec2EJKrI/Yjzf2CrujQL8Zs2ac2kH0I
         HmaA==
X-Gm-Message-State: AJcUukfzx4B5+nHdgNJg6DjXgySpYbI9YBQwjAx0MSk0/NCbUs1vwL2w
        wbCvdlug5/LZpNXpp1Swqog=
X-Google-Smtp-Source: ALg8bN53aP35E/kUx5BQPqrbDp0k0KVgLflCrHG+CeT89vYfjKC7WvekSbE+SEc7AEcT2Ljeyx9ibw==
X-Received: by 2002:a17:902:20c8:: with SMTP id v8mr31683244plg.319.1548869112203;
        Wed, 30 Jan 2019 09:25:12 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j21sm3385752pfn.175.2019.01.30.09.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 09:25:11 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:25:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jeremy Gebben <jgebben@sweptlaser.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 1/3] hwmon: (lm85) remove freq_map size hardcodes
Message-ID: <20190130172510.GB14781@roeck-us.net>
References: <20190129212920.27921-1-jgebben@sweptlaser.com>
 <20190130161447.19946-1-jgebben@sweptlaser.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130161447.19946-1-jgebben@sweptlaser.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 09:14:45AM -0700, Jeremy Gebben wrote:
> 
> Allow support for chips that support more than 8 frequencies.
> The size still must be a power of two.
> 
This is risky. Someone later may not know/remember and 
expand the table without maintaining that restriction.
I would suggest to use map_size instead of map_mask.
While that adds some divide operations, none of those are
in a critical path, and the code would be much more robust.

> Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
> ---
>  drivers/hwmon/lm85.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index 0a325878e8f5..48f59667a88c 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -198,13 +198,13 @@ static int RANGE_TO_REG(long range)
>  #define RANGE_FROM_REG(val)	lm85_range_map[(val) & 0x0f]
>  
>  /* These are the PWM frequency encodings */
> -static const int lm85_freq_map[8] = { /* 1 Hz */
> +static const int lm85_freq_map[] = { /* 1 Hz */
>  	10, 15, 23, 30, 38, 47, 61, 94
>  };
> -static const int adm1027_freq_map[8] = { /* 1 Hz */
> +
> +static const int adm1027_freq_map[] = { /* 1 Hz */
>  	11, 15, 22, 29, 35, 44, 59, 88
>  };
> -#define FREQ_MAP_LEN	8
>  
>  static int FREQ_TO_REG(const int *map,
>  		       unsigned int map_size, unsigned long freq)
> @@ -212,9 +212,9 @@ static int FREQ_TO_REG(const int *map,
>  	return find_closest(freq, map, map_size);
>  }
>  
> -static int FREQ_FROM_REG(const int *map, u8 reg)
> +static int FREQ_FROM_REG(const int *map, unsigned int map_size, u8 reg)
>  {
> -	return map[reg & 0x07];
> +	return map[reg & (map_size - 1)];

Passing in map_size (calculated as map_mask + 1) just to subtract one
doesn't make sense.

>  }
>  
>  /*
> @@ -296,6 +296,8 @@ struct lm85_data {
>  	struct i2c_client *client;
>  	const struct attribute_group *groups[6];
>  	const int *freq_map;
> +	unsigned int freq_map_mask;
> +
>  	enum chips type;
>  
>  	bool has_vid5;	/* true if VID5 is configured for ADT7463 or ADT7468 */
> @@ -514,7 +516,7 @@ static struct lm85_data *lm85_update_device(struct device *dev)
>  			data->autofan[i].config =
>  			    lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
>  			val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
> -			data->pwm_freq[i] = val & 0x07;
> +			data->pwm_freq[i] = val & data->freq_map_mask;
>  			data->zone[i].range = val >> 4;
>  			data->autofan[i].min_pwm =
>  			    lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));
> @@ -791,7 +793,8 @@ static ssize_t show_pwm_freq(struct device *dev,
>  	if (IS_ADT7468_HFPWM(data))
>  		freq = 22500;
>  	else
> -		freq = FREQ_FROM_REG(data->freq_map, data->pwm_freq[nr]);
> +		freq = FREQ_FROM_REG(data->freq_map, data->freq_map_mask + 1,
> +				     data->pwm_freq[nr]);
>  
>  	return sprintf(buf, "%d\n", freq);
>  }
> @@ -820,7 +823,7 @@ static ssize_t set_pwm_freq(struct device *dev,
>  		lm85_write_value(client, ADT7468_REG_CFG5, data->cfg5);
>  	} else {					/* Low freq. mode */
>  		data->pwm_freq[nr] = FREQ_TO_REG(data->freq_map,
> -						 FREQ_MAP_LEN, val);
> +						 data->freq_map_mask + 1, val);
>  		lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
>  				 (data->zone[nr].range << 4)
>  				 | data->pwm_freq[nr]);
> @@ -1196,7 +1199,7 @@ static ssize_t set_temp_auto_temp_min(struct device *dev,
>  		TEMP_FROM_REG(data->zone[nr].limit));
>  	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
>  		((data->zone[nr].range & 0x0f) << 4)
> -		| (data->pwm_freq[nr] & 0x07));
> +		| data->pwm_freq[nr]);
>  
>  	mutex_unlock(&data->update_lock);
>  	return count;
> @@ -1232,7 +1235,7 @@ static ssize_t set_temp_auto_temp_max(struct device *dev,
>  		val - min);
>  	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
>  		((data->zone[nr].range & 0x0f) << 4)
> -		| (data->pwm_freq[nr] & 0x07));
> +		| data->pwm_freq[nr]);
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -1569,9 +1572,11 @@ static int lm85_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	case emc6d103:
>  	case emc6d103s:
>  		data->freq_map = adm1027_freq_map;
> +		data->freq_map_mask = ARRAY_SIZE(adm1027_freq_map) - 1;
>  		break;
>  	default:
>  		data->freq_map = lm85_freq_map;
> +		data->freq_map_mask = ARRAY_SIZE(lm85_freq_map) - 1;
>  	}

You'd have to make sure that freq_map_mask is indeed a mask, ie that
ARRAY_SIZE() is a power of two. I would suggest to use freq_map_size
instead.

>  
>  	/* Set the VRM version */
> -- 
> 2.17.1
> 
