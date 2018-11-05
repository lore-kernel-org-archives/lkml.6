Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899AFC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F952085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5/V2LY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F952085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbeKFAZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:25:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51124 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbeKFAZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:25:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so3780213wmw.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2FoXP6R1hBV5AeMBxq6hKppCa7ojxpwQBg//H9J01Go=;
        b=i5/V2LY2/4XKA5LUQVVYHDgdMzPehpB04Nf2VlzXA0sLVUpGnin4jVEN93W5+1d6Ip
         OcXLH0Y7ItpXtEJMEzKwx0F8KzvS5LhUI4/LRnx8t2n5qjhObG4y2WlxuHpTDKQYfRum
         T91fU0bjUNIxhhlW5UxCA3BVyKu/3czlRPfkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2FoXP6R1hBV5AeMBxq6hKppCa7ojxpwQBg//H9J01Go=;
        b=sZQB04wor+tIpnqwthc2jtZ3VR6NiUhjhUGwxAL0f5+kAa2o9pP7bCcZh8DbTks7V2
         KDmKTbT9PAn61r5pCB5WqxUNNRFozdWTLvdC9b0eWYgGvmrrKmQXQc2hIET+z2u8HzyL
         928cAbvgXKutGRB/DRXUqXlK+BE4ANv8m9jeAGjSDdkfSLLLESEZWTSVa4ISd6tQXMp+
         +7iGOM6xlL2rKON4c6GB/+JjfiKxAJdh4Wq9GB1JiegFn9hsgYYOAo5RbHRojL5efQkC
         0FTFGJYG9Py6nKIbepYGSo2Bc9fD0bPjM8HLDmuMFyamRzaUHAgYRXnWEkilx7HsHiVw
         sAnA==
X-Gm-Message-State: AGRZ1gLOqL6vEAUIKI2OBNArQoEw2ptB+4T9U1EFdUF+PU6L417cpaNp
        sbo1dS1SW7hUKgR0vneX1cAXnw==
X-Google-Smtp-Source: AJdET5cu/tOGLE37RM5pxm5rtryD2PXPPzPbm9jtYVbq7UfPTPzbS9wQvbKYNk1knoH0xKMzxKkRwA==
X-Received: by 2002:a1c:c604:: with SMTP id w4-v6mr6763681wmf.40.1541430319443;
        Mon, 05 Nov 2018 07:05:19 -0800 (PST)
Received: from [192.168.0.40] (119.151.136.77.rev.sfr.net. [77.136.151.119])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm20940941wrw.75.2018.11.05.07.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 07:05:18 -0800 (PST)
Subject: Re: [PATCH 2/5] thermal: rockchip_thermal: simplify getting
 .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
 <20181021200053.2194-3-wsa+renesas@sang-engineering.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e022320e-3a85-070c-4f9e-700457ae4386@linaro.org>
Date:   Mon, 5 Nov 2018 16:05:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181021200053.2194-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2018 22:00, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/thermal/rockchip_thermal.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index f36375d5a16c..9c7643d62ed7 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1327,8 +1327,7 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
>  
>  static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
> +	struct rockchip_thermal_data *thermal = dev_get_drvdata(dev);
>  	int i;
>  
>  	for (i = 0; i < thermal->chip->chn_num; i++)
> @@ -1346,8 +1345,7 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  
>  static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
> +	struct rockchip_thermal_data *thermal = dev_get_drvdata(dev);
>  	int i;
>  	int error;
>  
> @@ -1376,7 +1374,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  					      id, thermal->regs,
>  					      thermal->tshut_temp);
>  		if (error)
> -			dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
> +			dev_err(dev, "%s: invalid tshut=%d, error=%d\n",
>  				__func__, thermal->tshut_temp, error);
>  	}
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

