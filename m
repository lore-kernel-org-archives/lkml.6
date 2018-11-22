Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB49C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C126820824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfjTyIAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C126820824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406679AbeKWGGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:06:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41128 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeKWGGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:06:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so9615288plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 11:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CtFQov3diMWmzCH/eueIdqic6nbQK8XnAWHttr7Ta4k=;
        b=rfjTyIAuFoq7fgtYVO1LHU8IvPITBUeNCWSx2O9vEstWzhBeYp+AilPjlv6nGb/jLT
         hsLWvW/m2vaGdkLBh7CojIii+DgboZZXkeQ8737rXVQRiB+cuCBb/b0+h5MBWgMgX+G3
         kjYgwQOnjCGWil6ml9aiSdY5eTiDkoHDD9jg0WHZovIu7sJKy7jAT8uOQVNrJMNj80wV
         xsLZI0nxauZYoybE4EByJprOZAXC6VOmOIBOgemSdYwNyvV2AxOCd6x2TLcWQTr5vtDQ
         y5w+zbfDK2HNOz93wUic+zeFIe+oUWpi2XDmE3LOhEpE5kh0LXvPJepqvCfJ0hMnWSg+
         GqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CtFQov3diMWmzCH/eueIdqic6nbQK8XnAWHttr7Ta4k=;
        b=brY22Rzjr6dAHhwAmx5sn2RhOZlF6/L1V+ecMtH1Tqs7SbDl73NJ6rxWNxqhkhZPE6
         MGRNgdJY6GZpMfMp7hASEi85feJ0MSLc80I238iK4tg09++YaX1dX21NI4v6RpkDT2dU
         lWAbUEWly9uWMg7hLlVqsyeOSlBzFlISbOZOmuSH63Hm+jBZhTtoPTJuKjO82UbmyPBw
         Quvq6u+77BfZdTHHDGZNFRF3tzzk9Mfhk9UFhrc6EnxtWvrwpD8BamGuhbbQIUmBYN/c
         cRBU6wRSGdgX/BM71GYiufuACFiMWGXNbUGsFd4x9fEJFNCkdJThHeQFnizIXOU0SdUA
         ixCw==
X-Gm-Message-State: AA+aEWakvyHPfbaSyztGtkV4HbSnD46YGf6xenMbnz8cuj2Bi36EPjvB
        rSk2dgqx9Jf1vRUvRlJtM8o=
X-Google-Smtp-Source: AFSGD/Wlrud1i8/wGshb64Zrz/yqbExQpn/q5Y3fzae9Y9SdbJaSVn6cHpYX8LVhdgXDKN/Alz1u+w==
X-Received: by 2002:a17:902:14e:: with SMTP id 72-v6mr12071244plb.299.1542914746466;
        Thu, 22 Nov 2018 11:25:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e64-v6sm37453747pfc.122.2018.11.22.11.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 11:25:45 -0800 (PST)
Date:   Thu, 22 Nov 2018 11:25:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 7/7] platform/chrome: cros_ec_lightbar: instantiate only
 if the EC has a lightbar.
Message-ID: <20181122192544.GA2410@roeck-us.net>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
 <20181122113356.23610-8-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122113356.23610-8-enric.balletbo@collabora.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:33:56PM +0100, Enric Balletbo i Serra wrote:
> Due to the way attribute groups visibility work, the function
> cros_ec_lightbar_attrs_are_visible is called multiple times, once per
> attribute, and each of these calls makes an EC transaction. For what is
> worth the EC log reports multiple errors on boot when the lightbar is
> not available. Instead, check if the EC has a lightbar in the probe
> function and only instantiate the device.
> 
> Ideally we should have instantiate the driver only if the
> EC_FEATURE_LIGHTBAR is defined, but that's not possible because that flag
> is not in the very first Pixel Chromebook (Link), only on Samus. So, the
> driver is instantiated by his parent always.
> 
> This patch changes a bit the actual behaviour. Before the patch if an EC
> doesn't have a lightbar an empty lightbar folder is created in
> /sys/class/chromeos/<ec device>, after the patch the empty folder is not
> created, so, the folder is only created if the lightbar exists.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Guess this is the answer to the suggestion I had before. Maybe the two patches
should be merged together ? Or do  others think that they should be kept
separate ?

Additional comment below.

Thanks,
Guenter

> ---
> 
>  drivers/platform/chrome/cros_ec_lightbar.c | 29 +++++++++-------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index 31d22f594fac..d255264eb082 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -567,37 +567,28 @@ static struct attribute *__lb_cmds_attrs[] = {
>  	NULL,
>  };
>  
> -static bool ec_has_lightbar(struct cros_ec_dev *ec)
> +static bool cros_ec_has_lightbar(struct cros_ec_dev *ec_dev)
>  {
> -	return !!get_lightbar_version(ec, NULL, NULL);
> -}
> -
> -static umode_t cros_ec_lightbar_attrs_are_visible(struct kobject *kobj,
> -						  struct attribute *a, int n)
> -{
> -	struct device *dev = container_of(kobj, struct device, kobj);
> -	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
> -	struct platform_device *pdev = to_platform_device(ec->dev);
> +	struct platform_device *pdev = to_platform_device(ec_dev->dev);
>  	struct cros_ec_platform *pdata = pdev->dev.platform_data;
>  	int is_cros_ec;
>  
>  	is_cros_ec = strcmp(pdata->ec_name, CROS_EC_DEV_NAME);
>  
Can this now ever be false ?

>  	if (is_cros_ec != 0)
> -		return 0;
> +		return false;
>  
> -	/* Only instantiate this stuff if the EC has a lightbar */
> -	if (ec_has_lightbar(ec)) {
> -		ec_with_lightbar = ec;
> -		return a->mode;
> +	if (!!get_lightbar_version(ec_dev, NULL, NULL)) {
> +		ec_with_lightbar = ec_dev;

Is this variable (and the associated check in lb_manual_suspend_ctrl)
still necessary ?

> +		return true;
>  	}
> -	return 0;
> +
> +	return false;
>  }
>  
>  struct attribute_group cros_ec_lightbar_attr_group = {
>  	.name = "lightbar",
>  	.attrs = __lb_cmds_attrs,
> -	.is_visible = cros_ec_lightbar_attrs_are_visible,
>  };
>  
>  static int cros_ec_lightbar_probe(struct platform_device *pd)
> @@ -611,6 +602,10 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
>  		return -EINVAL;
>  	}
>  
> +	/* Only instantiate this stuff if the EC has a lightbar */
> +	if (!cros_ec_has_lightbar(ec_dev))
> +		return -ENODEV;
> +
>  	/* Take control of the lightbar from the EC. */
>  	lb_manual_suspend_ctrl(ec_dev, 1);
>  
