Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEF1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BF0206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyAfuu24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BF0206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406658AbeKTDbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:31:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46855 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406271AbeKTDbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:31:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so11900995ply.13;
        Mon, 19 Nov 2018 09:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XZpEWxqmj+M8ri5b/GfMD8rAJh3MaWf0rAgLdhe1Yrw=;
        b=DyAfuu24IUBHfQ/teYq3VSuHBsJzvZIxSbd0M+Hgy+qa1ck94OOY4vxU6cuQV170xC
         KKQ79+wF1YjTuqb6IzV6X0K8CNpGaEx5UbXwlIJq4gWwSOUiaOxW5oaOH8rO0l4mDPUY
         FfRyy7MBJMv7kzv1VUo5f9l178iac01dBMclqxuUqjgdh1TDHCSvUoaa8afNOcXdiSiw
         CPt9Vsp/vLb5PdvUc6WvyFiUB4727HW7MoMjKxjeggFEUqNgwJQlBX+VScRZiPF/I5zl
         GOWqzWcBVVEBnAMGulAPMlVawsy2HZhaDQV8pD2gvNq8uJjVpXQYW3l8NLb11gziyG3f
         ryeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZpEWxqmj+M8ri5b/GfMD8rAJh3MaWf0rAgLdhe1Yrw=;
        b=FwP2wPTw05p+a7d+tnogdKyTdSEchFYkQxAKGndJlh1W0FCOxFs7VikWK06FPhuOnO
         jqWSvwHZhzdBQKCemKb8R6L4WXMbA1f7AXEd+WdgA48F4Lv+bBqjXEySwMk+6CPLf5C5
         xWfeHLlyNSJgac1eQyyMXWAKCDlHShQUfQ/WxRtNiwRK5hbSWuzLuRC/b9SpcWdflc2/
         IB+oiXyWdce3sKWXVbBRUJSPUT2xs1seFfvMfE/XZqbDRMLpvG3JWwtF0DN0BMXu1Kh/
         tupoVTzzJyWM6+k5aCSkZ1Jw6OsadnHzjco5Ivt80SpGPAqJMsv5RfotXHi4sQa4L/Un
         Wvsw==
X-Gm-Message-State: AGRZ1gINmCY8OGilvsh1EYGeahlC04akv3926v/b34WfxwIqgDxtdpUl
        BufByt+vdD6eOdes0fU6uR4=
X-Google-Smtp-Source: AJdET5cZO+2nrsQngeCnK/8NU/Nyglg8jCQQDoGPG4DKLYf90iwJXSacpN/kV+W4SmnBa2WH5zArfg==
X-Received: by 2002:a17:902:3084:: with SMTP id v4-v6mr22687880plb.326.1542647254429;
        Mon, 19 Nov 2018 09:07:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b27sm34700649pfh.113.2018.11.19.09.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:07:33 -0800 (PST)
Date:   Mon, 19 Nov 2018 09:07:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (ntc_thermistor): add support for B57891S0103
 from Epcos
Message-ID: <20181119170732.GA27435@roeck-us.net>
References: <20181117121248.32143-1-peda@axentia.se>
 <20181117121248.32143-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117121248.32143-2-peda@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 12:13:00PM +0000, Peter Rosin wrote:
> More of the same...
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/hwmon/Kconfig                        |  3 +-
>  drivers/hwmon/ntc_thermistor.c               | 57 +++++++++++++++++++++++++++-
>  include/linux/platform_data/ntc_thermistor.h |  1 +
>  3 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index f10840ad465c..5438cecace22 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1206,7 +1206,8 @@ config SENSORS_NTC_THERMISTOR
>  
>  	  Currently, this driver supports
>  	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, NCP15WL333,
> -	  NCP03WF104 and NCP15XH103 from Murata and B57330V2103 from EPCOS.
> +	  NCP03WF104 and NCP15XH103 from Murata and B57330V2103 and
> +	  B57891S0103 from EPCOS.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called ntc-thermistor.
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index c52d07c6b49f..e0c6b2f244a6 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -55,6 +55,7 @@ static const struct platform_device_id ntc_thermistor_id[] = {
>  	{ "b57330v2103", TYPE_B57330V2103},
>  	{ "ncp03wf104", TYPE_NCPXXWF104 },
>  	{ "ncp15xh103", TYPE_NCPXXXH103 },
> +	{ "b57891s0103", TYPE_B57891S0103 },
>  	{ },
>  };
>  
> @@ -212,8 +213,8 @@ static const struct ntc_compensation ncpXXxh103[] = {
>  };
>  
>  /*
> - * The following compensation table is from the specification of EPCOS NTC
> - * Thermistors Datasheet
> + * The following compensation tables are from the specifications in EPCOS NTC
> + * Thermistors Datasheets
>   */
>  static const struct ntc_compensation b57330v2103[] = {
>  	{ .temp_c	= -40, .ohm	= 190030 },
> @@ -252,6 +253,52 @@ static const struct ntc_compensation b57330v2103[] = {
>  	{ .temp_c	= 125, .ohm	= 531 },
>  };
>  
> +static const struct ntc_compensation b57891s0103[] = {
> +	{ .temp_c	= -55.0, .ohm	= 878900 },
> +	{ .temp_c	= -50.0, .ohm	= 617590 },
> +	{ .temp_c	= -45.0, .ohm	= 439340 },
> +	{ .temp_c	= -40.0, .ohm	= 316180 },
> +	{ .temp_c	= -35.0, .ohm	= 230060 },
> +	{ .temp_c	= -30.0, .ohm	= 169150 },
> +	{ .temp_c	= -25.0, .ohm	= 125550 },
> +	{ .temp_c	= -20.0, .ohm	= 94143 },
> +	{ .temp_c	= -15.0, .ohm	= 71172 },
> +	{ .temp_c	= -10.0, .ohm	= 54308 },
> +	{ .temp_c	= -5.0, .ohm	= 41505 },
> +	{ .temp_c	= 0.0, .ohm	= 32014 },
> +	{ .temp_c	= 5.0, .ohm	= 25011 },
> +	{ .temp_c	= 10.0, .ohm	= 19691 },
> +	{ .temp_c	= 15.0, .ohm	= 15618 },
> +	{ .temp_c	= 20.0, .ohm	= 12474 },
> +	{ .temp_c	= 25.0, .ohm	= 10000 },
> +	{ .temp_c	= 30.0, .ohm	= 8080 },
> +	{ .temp_c	= 35.0, .ohm	= 6569 },
> +	{ .temp_c	= 40.0, .ohm	= 5372 },
> +	{ .temp_c	= 45.0, .ohm	= 4424 },
> +	{ .temp_c	= 50.0, .ohm	= 3661 },
> +	{ .temp_c	= 55.0, .ohm	= 3039 },
> +	{ .temp_c	= 60.0, .ohm	= 2536 },
> +	{ .temp_c	= 65.0, .ohm	= 2128 },
> +	{ .temp_c	= 70.0, .ohm	= 1794 },
> +	{ .temp_c	= 75.0, .ohm	= 1518 },
> +	{ .temp_c	= 80.0, .ohm	= 1290 },
> +	{ .temp_c	= 85.0, .ohm	= 1100 },
> +	{ .temp_c	= 90.0, .ohm	= 942 },
> +	{ .temp_c	= 95.0, .ohm	= 809 },
> +	{ .temp_c	= 100.0, .ohm	= 697 },
> +	{ .temp_c	= 105.0, .ohm	= 604 },
> +	{ .temp_c	= 110.0, .ohm	= 525 },
> +	{ .temp_c	= 115.0, .ohm	= 457 },
> +	{ .temp_c	= 120.0, .ohm	= 400 },
> +	{ .temp_c	= 125.0, .ohm	= 351 },
> +	{ .temp_c	= 130.0, .ohm	= 308 },
> +	{ .temp_c	= 135.0, .ohm	= 272 },
> +	{ .temp_c	= 140.0, .ohm	= 240 },
> +	{ .temp_c	= 145.0, .ohm	= 213 },
> +	{ .temp_c	= 150.0, .ohm	= 189 },
> +	{ .temp_c	= 155.0, .ohm	= 168 },
> +};
> +
>  struct ntc_data {
>  	struct ntc_thermistor_platform_data *pdata;
>  	const struct ntc_compensation *comp;
> @@ -296,6 +343,8 @@ static const struct of_device_id ntc_match[] = {
>  		.data = &ntc_thermistor_id[6] },
>  	{ .compatible = "murata,ncp15xh103",
>  		.data = &ntc_thermistor_id[7] },
> +	{ .compatible = "epcos,b57891s0103",
> +		.data = &ntc_thermistor_id[8] },
>  
>  	/* Usage of vendor name "ntc" is deprecated */
>  	{ .compatible = "ntc,ncp15wb473",
> @@ -627,6 +676,10 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
>  		data->comp = ncpXXxh103;
>  		data->n_comp = ARRAY_SIZE(ncpXXxh103);
>  		break;
> +	case TYPE_B57891S0103:
> +		data->comp = b57891s0103;
> +		data->n_comp = ARRAY_SIZE(b57891s0103);
> +		break;
>  	default:
>  		dev_err(dev, "Unknown device type: %lu(%s)\n",
>  				pdev_id->driver_data, pdev_id->name);
> diff --git a/include/linux/platform_data/ntc_thermistor.h b/include/linux/platform_data/ntc_thermistor.h
> index 698d0d59db76..231a27c302ec 100644
> --- a/include/linux/platform_data/ntc_thermistor.h
> +++ b/include/linux/platform_data/ntc_thermistor.h
> @@ -29,6 +29,7 @@ enum ntc_thermistor_type {
>  	TYPE_B57330V2103,
>  	TYPE_NCPXXWF104,
>  	TYPE_NCPXXXH103,
> +	TYPE_B57891S0103,

Guess I deserve the non-alphabetic order as penalty for not enforcing it 
earlier. I'll accept the patch after DT approval and submit another one
myself afterwards to restore alphabetic order.

Guenter

>  };
>  
>  struct ntc_thermistor_platform_data {
> -- 
> 2.11.0
> 
