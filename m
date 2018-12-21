Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D26E21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpv/X5f6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404004AbeLUXik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:38:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39181 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392288AbeLUXik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:38:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so3257730pfc.6;
        Fri, 21 Dec 2018 15:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SRHddD8lv1TnSXNuiikyj4+AKS6QXBbmS1nSVmNJzAE=;
        b=cpv/X5f6PusaG+xc2juzYcAaD3i21rqzbTVqteRy0QHt9mB2LKDA/zNA6b0Aqj8Azb
         LQttlfwxZ/O4+oBtEegysJ8OQuNYTEUVHWKAupds3lWGhJZVtlGFzxazenAaknkNv3Cn
         fBeRW4T924L6Nf9FKaPkGdh9tFqDl1/ODZMddMBtU6l7htGOtdb9HzkJ15CeMPCnfubE
         LT8eQqrVUA+2ZmmfDu7uuADxwtXe6UTwET5dMLQh4RiRB8ZUwt+OK5F6xIUxf3TSU9bD
         msP9e/kgrjjwPnCH5jRJX7UkOyBWfWaGuBrVfM6i579WLenceveE+BtSEoRx4tlauA/c
         97Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SRHddD8lv1TnSXNuiikyj4+AKS6QXBbmS1nSVmNJzAE=;
        b=EecAIeDObdrdqRAlHL2dJo/rQCSrMkZkNZCxwJL8Eym9xTALlwUfBXtJGpPOvGD2Ri
         D5YxBEA6TuLKj27FeeH4mgDtWSTOXyelaESO7r+oqyQVrjuIN9WNtLubGj9krlBIol6H
         fbGYhTW+X5tdqdsJX1Q9nP0ZUsFLjgD1goawWiBPNl9Wh4skfuEOgj+bIRL5HRLuuJEc
         5/tmx4d5UPX4C3f46SEW+bzes9MbMO/1sSkB+Xp2uOEgKThZekUGFUGdUQ86KVhmOr5K
         yhry29r5gYKBSuGKV3YZb92rGUoJDS9LgZAM1N++KqL3EB75DRqblTfU9ugRZQTCMO68
         YAdg==
X-Gm-Message-State: AA+aEWYI49ccNAo8pt0s9sBFC1GWJu8a7mMf+XlD3AFGz1ZJCCMNUlye
        uUMFXuKJ1/TgmPe2BlALC3e0vF6/
X-Google-Smtp-Source: AFSGD/WQZosxW0keLHP6WEkbI5QFEDBKVqwZ9UC/8fn0wjgFJQTTBhf8bx7sJ3fjPyAcuE1XFUW8fA==
X-Received: by 2002:a62:1289:: with SMTP id 9mr4567111pfs.102.1545435518262;
        Fri, 21 Dec 2018 15:38:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j185sm30579564pge.72.2018.12.21.15.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 15:38:37 -0800 (PST)
Date:   Fri, 21 Dec 2018 15:38:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (lm80) fix a missing check of bus read in lm80
 probe
Message-ID: <20181221233836.GA17485@roeck-us.net>
References: <20181221191039.1519-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221191039.1519-1-kjlu@umn.edu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 01:10:39PM -0600, Kangjie Lu wrote:
> In lm80_probe(), if lm80_read_value() fails, it returns a negative
> error number which is stored to data->fan[f_min] and will be further
> used. We should avoid using the data if the read fails.
> 
> The fix checks if lm80_read_value() fails, and if so, returns with the
> error number.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/lm80.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> index d91333557f04..85f797501aaf 100644
> --- a/drivers/hwmon/lm80.c
> +++ b/drivers/hwmon/lm80.c
> @@ -627,6 +627,7 @@ static int lm80_probe(struct i2c_client *client,
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
>  	struct lm80_data *data;
> +	int rv;
>  
>  	data = devm_kzalloc(dev, sizeof(struct lm80_data), GFP_KERNEL);
>  	if (!data)
> @@ -639,8 +640,14 @@ static int lm80_probe(struct i2c_client *client,
>  	lm80_init_client(client);
>  
>  	/* A few vars need to be filled upon startup */
> -	data->fan[f_min][0] = lm80_read_value(client, LM80_REG_FAN_MIN(1));
> -	data->fan[f_min][1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
> +	rv = lm80_read_value(client, LM80_REG_FAN_MIN(1));
> +	if (rv < 0)
> +		return rv;
> +	data->fan[f_min][0] = rv;
> +	rv = lm80_read_value(client, LM80_REG_FAN_MIN(2));
> +	if (rv < 0)
> +		return rv;
> +	data->fan[f_min][1] = rv;
>  
>  	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
>  							   data, lm80_groups);
