Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A6FC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175002082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAuTavuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175002082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbeLBFxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:53:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44878 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeLBFxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 00:53:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so4384012pfh.11;
        Sat, 01 Dec 2018 10:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JwTBatTuAQbc9Q/g33sbLRDjc1uyMz/mfUyC27Y3YBI=;
        b=JAuTavuX1yWrNHGGjiOvx5YmBAUtTa4/CFB1nzBD2sfxrS/UQI6EaSVC8wcN3++d18
         A8C6KCinc2UjAzowR8oQWjDiwhjGjh7HGAbsjPnDjZvn+1i8/UB7AdBBie1eXNdJkJQn
         QgZbS2WVCwj0B9inG8oJjA3PVZIVNKTHVach792Td6xr+1RS5eYwVm15tYC2BKNP65r1
         wv0fpsL36lZOhFp6ZMJ+WcmvunRMkyCilVJZsYUE51usTUeylS5+LoDB+gk2b0e8ew3y
         nvjvG8vApnZL4dn8jWIbSR+K2Tqe39wuDljM/7EzOyD0lIaNIjhg2XRCM0fC6AdLzC1E
         Ugww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JwTBatTuAQbc9Q/g33sbLRDjc1uyMz/mfUyC27Y3YBI=;
        b=EjeY0CuTRQtUFoTA5ufWNk8lagoUFgpvoM6ls5+t4B6dE8845hg7Ju7WogZqDSf+/S
         wlex2ovZDj4A7Kl+bcGK3BUgWss7eq54xhXkGLf3ut69hET7lY2+6mcp3/5pY4KgSts7
         dSOy1UaKjglMkf+jN0JVRBCnSw9F+f7YQ2urRtYAyKsdiFB7YNFvxyGU9bd6dF1FHiQd
         A9xLLq8C535GAe3kRHU/yYt/HBhzcS9T96pYCn4Gtg8ZrMHR+LALlszNlW30/FtYJD5L
         VWIXqv1K/52SmMEfe/y+hozIlpGsbemTeRkEb/ElVcsMiUCNQ0HqbN6SJltcPF5C9O6v
         /l+g==
X-Gm-Message-State: AA+aEWZT8+BVXYmmCnuYXqm/bFLvpKTeVQ58qD2XlPCewnvCss/lq9W5
        GucFkIcP5970+Ne2pAxyq9g=
X-Google-Smtp-Source: AFSGD/WzDeHCILC79bGAZ65GDPbhFwG8DfVHS0oSiBe4zbDRDdLmunfVsqeo+7U4TrL82ZQhn2WIGg==
X-Received: by 2002:a62:1289:: with SMTP id 9mr10289689pfs.102.1543689636168;
        Sat, 01 Dec 2018 10:40:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n23-v6sm19834043pfg.84.2018.12.01.10.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 10:40:35 -0800 (PST)
Date:   Sat, 1 Dec 2018 10:40:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (ntc_thermistor) use a table to lookup the
 thermistor type
Message-ID: <20181201184034.GA25714@roeck-us.net>
References: <b732b7e0-0076-9cb3-a146-4d0cd80d2658@roeck-us.net>
 <20181121160327.16772-1-peda@axentia.se>
 <20181121160327.16772-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121160327.16772-3-peda@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 04:03:46PM +0000, Peter Rosin wrote:
> Sort the entries while at it.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ntc_thermistor.c               | 47 +++++++++++++---------------
>  include/linux/platform_data/ntc_thermistor.h |  6 ++--
>  2 files changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index 7747c1ed1f02..56d83b2472c8 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -315,6 +315,23 @@ static const struct ntc_compensation b57891s0103[] = {
>  	{ .temp_c	= 155.0, .ohm	= 168 },
>  };
>  
> +struct ntc_type {
> +	const struct ntc_compensation *comp;
> +	int n_comp;
> +};
> +
> +#define NTC_TYPE(ntc, compensation) \
> +[(ntc)] = { .comp = (compensation), .n_comp = ARRAY_SIZE(compensation) }
> +
> +static const struct ntc_type ntc_type[] = {
> +	NTC_TYPE(TYPE_B57330V2103, b57330v2103),
> +	NTC_TYPE(TYPE_B57891S0103, b57891s0103),
> +	NTC_TYPE(TYPE_NCPXXWB473,  ncpXXwb473),
> +	NTC_TYPE(TYPE_NCPXXWF104,  ncpXXwf104),
> +	NTC_TYPE(TYPE_NCPXXWL333,  ncpXXwl333),
> +	NTC_TYPE(TYPE_NCPXXXH103,  ncpXXxh103),
> +};
> +
>  struct ntc_data {
>  	struct ntc_thermistor_platform_data *pdata;
>  	const struct ntc_compensation *comp;
> @@ -671,37 +688,15 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
>  
>  	data->pdata = pdata;
>  
> -	switch (pdev_id->driver_data) {
> -	case TYPE_NCPXXWB473:
> -		data->comp = ncpXXwb473;
> -		data->n_comp = ARRAY_SIZE(ncpXXwb473);
> -		break;
> -	case TYPE_NCPXXWL333:
> -		data->comp = ncpXXwl333;
> -		data->n_comp = ARRAY_SIZE(ncpXXwl333);
> -		break;
> -	case TYPE_B57330V2103:
> -		data->comp = b57330v2103;
> -		data->n_comp = ARRAY_SIZE(b57330v2103);
> -		break;
> -	case TYPE_NCPXXWF104:
> -		data->comp = ncpXXwf104;
> -		data->n_comp = ARRAY_SIZE(ncpXXwf104);
> -		break;
> -	case TYPE_NCPXXXH103:
> -		data->comp = ncpXXxh103;
> -		data->n_comp = ARRAY_SIZE(ncpXXxh103);
> -		break;
> -	case TYPE_B57891S0103:
> -		data->comp = b57891s0103;
> -		data->n_comp = ARRAY_SIZE(b57891s0103);
> -		break;
> -	default:
> +	if (pdev_id->driver_data >= ARRAY_SIZE(ntc_type)) {
>  		dev_err(dev, "Unknown device type: %lu(%s)\n",
>  				pdev_id->driver_data, pdev_id->name);
>  		return -EINVAL;
>  	}
>  
> +	data->comp   = ntc_type[pdev_id->driver_data].comp;
> +	data->n_comp = ntc_type[pdev_id->driver_data].n_comp;
> +
>  	hwmon_dev = devm_hwmon_device_register_with_groups(dev, pdev_id->name,
>  							   data, ntc_groups);
>  	if (IS_ERR(hwmon_dev)) {
> diff --git a/include/linux/platform_data/ntc_thermistor.h b/include/linux/platform_data/ntc_thermistor.h
> index 231a27c302ec..ee03d429742b 100644
> --- a/include/linux/platform_data/ntc_thermistor.h
> +++ b/include/linux/platform_data/ntc_thermistor.h
> @@ -24,12 +24,12 @@
>  struct iio_channel;
>  
>  enum ntc_thermistor_type {
> -	TYPE_NCPXXWB473,
> -	TYPE_NCPXXWL333,
>  	TYPE_B57330V2103,
> +	TYPE_B57891S0103,
> +	TYPE_NCPXXWB473,
>  	TYPE_NCPXXWF104,
> +	TYPE_NCPXXWL333,
>  	TYPE_NCPXXXH103,
> -	TYPE_B57891S0103,
>  };
>  
>  struct ntc_thermistor_platform_data {
