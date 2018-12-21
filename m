Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3845BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0331421920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIofrfNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403895AbeLUOnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:43:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40155 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:43:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so2609189pgp.7;
        Fri, 21 Dec 2018 06:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=im/BQf51BbC4ngwQOMzwCg/sT8Z/wZr3mjYWoaEMw4s=;
        b=sIofrfNftgewuwEjx+RxBpT+0baW1TuWYY6dTb7YgLnL7G8VgHqLL5mCHU2JrtJNzl
         Wgjz07bvIrMO+0NvqN8wFw1FaX59emkWCHnToql0KWDC0EOIOiGUe05DH1/q6HzVXvk6
         at2OxpkdSnmrbaiNOZTvPl/w0Nqp0GpeYiVDghxTyovZ2pY2AkTBTeI797WeXyj1bsLc
         BfGcvb7x11yGYW37/Fb5fEC4RPikccIHytpOzqKmCtxebIVPHJqyGOWsqZN3m3kupcH2
         m1jMljyJZd0Tm33tcEyLb4eZZ9a8Cqt/mcr9tKI3K8bcuFIA9aE9UM5ZxS/JaOHZrsI2
         mOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=im/BQf51BbC4ngwQOMzwCg/sT8Z/wZr3mjYWoaEMw4s=;
        b=JGtk5F6cpHGGHovuLsPuGPEb2kg8OK+m+HUs9lNxhGAXdYdGdrXNuyCJZDiNW/xkc4
         DUW2dLRWEZdbCmakyQWROv5kbZVDBe8AyHsdAEAPDcZ0/BA7jF46co5Eao8BhTGwatwK
         eB9QTMptHTbbp7QxDNvJYWBxM+/n2DfTZ7t2JRqf6/+k9IBB3DX7aSis3yCRZ35TlUoS
         VHOQj23Dx7CyJpVKkSGg75XqIPHxOK+ws6UjoyD799o2ImKKnzPXUZZZH+8e7rp6ES2y
         avSw2QMek7EXlX77G1EFuq5I2xj7pM7l0HEGuPoSIlESNRksKg2a3YWaj8kGT5p9OFYA
         ZhYw==
X-Gm-Message-State: AJcUukcVlCePlXPh5jLf2h4SBs2d4eCxnE2Nd8X4JR+KS6x0RVitwFH0
        jFMvlwABEWZ+IyFSSk4heoj91vM0
X-Google-Smtp-Source: ALg8bN7ncgtgCe13Yt143WRAcYKM7PQ2ENjQjow/jn3CgGFhhRbFLuHQRdmsj9EwBG7KiXSg3kCxVQ==
X-Received: by 2002:a63:42c1:: with SMTP id p184mr2670811pga.202.1545403389449;
        Fri, 21 Dec 2018 06:43:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k24sm33036129pfj.13.2018.12.21.06.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 06:43:08 -0800 (PST)
Subject: Re: [PATCH] hwmon: lm80: fix a missing check of return value
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181221061304.59684-1-kjlu@umn.edu>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <21e64781-808b-be83-9d28-ec7daeedf197@roeck-us.net>
Date:   Fri, 21 Dec 2018 06:43:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221061304.59684-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 10:13 PM, Kangjie Lu wrote:
> If lm80_read_value() fails, it returns a negative number instead of the
> correct read data. Therefore, we should avoid using the data if it
> fails.
> 
> The fix checks if lm80_read_value() fails, and if so, returns with the
> error number.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/hwmon/lm80.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> index 08e3945a6fbf..fca6363cd77f 100644
> --- a/drivers/hwmon/lm80.c
> +++ b/drivers/hwmon/lm80.c
> @@ -360,9 +360,11 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
>   	struct i2c_client *client = data->client;
>   	unsigned long min, val;
>   	u8 reg;
> -	int err = kstrtoul(buf, 10, &val);
> -	if (err < 0)
> -		return err;
> +	int ret;
> +

In the other patch you are using 'rv'. Please use consistent variable names.

Also, please use "hwmon: (lm80) <description>" as subject, and use different subjects
for both patches so we can distinguish them without looking into each patch itself.

This applies to the other patch as well.

Thanks,
Guenter

> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
>   
>   	/* Save fan_min */
>   	mutex_lock(&data->update_lock);
> @@ -390,8 +392,11 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
>   		return -EINVAL;
>   	}
>   
> -	reg = (lm80_read_value(client, LM80_REG_FANDIV) &
> -	       ~(3 << (2 * (nr + 1)))) | (data->fan_div[nr] << (2 * (nr + 1)));
> +	ret = lm80_read_value(client, LM80_REG_FANDIV);
> +	if (ret < 0)
> +		return ret;
> +	reg = (ret & ~(3 << (2 * (nr + 1))))
> +	      | (data->fan_div[nr] << (2 * (nr + 1)));
>   	lm80_write_value(client, LM80_REG_FANDIV, reg);
>   
>   	/* Restore fan_min */
> 

