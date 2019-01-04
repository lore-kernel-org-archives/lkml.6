Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D3CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DDA2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljI/i7LE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfADEZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:25:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33653 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfADEZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:25:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so17688535pfb.0;
        Thu, 03 Jan 2019 20:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PE5keDcQLiZ5S+n+2pUZP3UjWvKHOFXuAd8bfCtKNfQ=;
        b=ljI/i7LEydqHPrIAunld0ncAT4gA6tG3UPGtXLMSy7P00pHCsNer68nZDAdByPsTzA
         2VgXzSKj2OEb+nMge1k9eu4I9hrdp9ghYQ5Mqf9hXesXEhf+Vo+/6/MV8HH9qCecQjCa
         MUoBCHL5JvQrmUIrx+KbS0SUcZf0iynwQkL0ieJn+dLZ9U2ugxnAe4JeoBbAlp5V5+l5
         wCFz6thTKXpHcDN/ZgwE+hGqpKX5DNlNQuZXyT+zf325GyrrrwiqUwTo9QZ5BNj++1RU
         oSzRMUGiWfpdjZ5QVlOg2LcUAoCWlQqO00ldXK3gDO0EIFJ7v5wWwvxcdbBQljZwB3BE
         1D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PE5keDcQLiZ5S+n+2pUZP3UjWvKHOFXuAd8bfCtKNfQ=;
        b=i5ZGon1GZp5TYVCh6ArlG73ELbD2ubOq4Eu6KTe0gmGRIYzWhWadj98SUXeyrK9+0l
         udi7sxDgDGaVEFAxTtCKnSFnXapV4R2iouZEYAmBfsNMwLohrYr270qqXl8GF4Of46zi
         1m9UFW/SGQyXnOWTsYdoiR/C5lFRVlXeyKvE42MBSIGRTplp/pmm1DMzU6RGiB65tfWt
         EoNr+wlg/0choiYEjTzYGKy1yrU4QgCzcN1cCR5kuH2EtZ9pe7yuqA4KI9MwoJt1f3+/
         jsx4FTrsMN8OYKw+axYnGqEjVsTzv2mPdVnaeomRn83EibY41L/tV8jLfZTZePe7Trii
         yTCg==
X-Gm-Message-State: AJcUuke5z9+Cal30mTsTUkquxxMG9G0xle52ylS9kAgMPRyD6hHSmuAS
        QJJRfz5BcMJQxW8p7IFEJqA=
X-Google-Smtp-Source: ALg8bN7vz6118RT/P/DlXdiNBSIObpH/4IiCLHGrww7dZ9MUxdxK07dGG3a7GotPntbEN0xFkK7j4g==
X-Received: by 2002:a63:6506:: with SMTP id z6mr363662pgb.334.1546575948461;
        Thu, 03 Jan 2019 20:25:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r66sm88584028pfk.157.2019.01.03.20.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 20:25:47 -0800 (PST)
Date:   Thu, 3 Jan 2019 20:25:45 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (hih6130) add dtb compatibility tables
Message-ID: <20190104042545.GA22722@roeck-us.net>
References: <20181227151349.29753-1-andreas@kemnade.info>
 <20181227151349.29753-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227151349.29753-2-andreas@kemnade.info>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 04:13:48PM +0100, Andreas Kemnade wrote:
> This allows the hih6130 to be used in devicetree files and auto-probed
> that way.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applie to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/hih6130.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/hih6130.c b/drivers/hwmon/hih6130.c
> index 0ae1ee1dbf76..de1b50ddc740 100644
> --- a/drivers/hwmon/hih6130.c
> +++ b/drivers/hwmon/hih6130.c
> @@ -254,8 +254,17 @@ static const struct i2c_device_id hih6130_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, hih6130_id);
>  
> +static const struct of_device_id hih6130_of_match[] = {
> +	{ .compatible = "honeywell,hih6130", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hih6130_of_match);
> +
>  static struct i2c_driver hih6130_driver = {
> -	.driver.name = "hih6130",
> +	.driver = {
> +		.name = "hih6130",
> +		.of_match_table = of_match_ptr(hih6130_of_match),
> +	},
>  	.probe       = hih6130_probe,
>  	.id_table    = hih6130_id,
>  };
