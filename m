Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42747C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057582085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwU4JTab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057582085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbeKFA0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:26:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51556 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbeKFA0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:26:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so8683312wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NBmIygQOCZ7TXna0G01UQoZybbSyBkyr/EnVVmVa+LA=;
        b=KwU4JTabIgrlHOgmFHy34WhL0KuXguM0OEQVZCRoBlJmZiLjqJb30feN1WGIlK6eVf
         I+8CLwPXc9pifkiJkVjuACjNqtVambeIA9u9Gp7yas7aGxE4DnYWAf+SKWQm7hHrSIrW
         2sLqFZ25CgwWfTIw3v0/FeJkLZ/0cegchp2CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NBmIygQOCZ7TXna0G01UQoZybbSyBkyr/EnVVmVa+LA=;
        b=aMyQJqdWmisuyywnHRqYlYxvsYTBbPteqrX3TtVh28250yr1v8HvPKtAiF1vizkdW4
         2qmBlUKLiEnmxUOp5AL6/bitp8nQFJSKR8fAU1nejsQON3vSvG4YOnsKRiB5CnKZ9rAG
         M/AErQpKe02FQKpKaNz6DfmL8yxanOW8AQgNgUEId0YO684uWa7LngVt+Y4QTaX1exRC
         wFZHXcDmNICmTVbYAz/cx4J5UEdkcEQFLIi6hDEP36+Gxvos3pVhvmKZBVsU4vkVRuXv
         vjqGQF283IEydv0QQHIsDLvZ6T26OOjiUGc0xgyrahb9aO7ncx2A1DyXYDMfpYO8JVQj
         GONw==
X-Gm-Message-State: AGRZ1gLD2Pu21bMJyPuKY2CxIPTWkjMBc3v8maQcrTo162RLzbQRuY3m
        HInaojt+B+3t5Ajcd9NCbW9pKQ==
X-Google-Smtp-Source: AJdET5eho4AI7CAFB17XyOhknqZItOHoMU3IqzguvoCxEjZ3cWoyg6kdVhlucafn3M4uxAIu67g4YQ==
X-Received: by 2002:a1c:954b:: with SMTP id x72-v6mr497864wmd.14.1541430367641;
        Mon, 05 Nov 2018 07:06:07 -0800 (PST)
Received: from [192.168.0.40] (119.151.136.77.rev.sfr.net. [77.136.151.119])
        by smtp.googlemail.com with ESMTPSA id a7sm7318740wrx.26.2018.11.05.07.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 07:06:06 -0800 (PST)
Subject: Re: [PATCH 3/5] thermal: spear_thermal: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
 <20181021200053.2194-4-wsa+renesas@sang-engineering.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8dbe48f1-6e9c-ed43-b902-6d9f7f757017@linaro.org>
Date:   Mon, 5 Nov 2018 16:06:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181021200053.2194-4-wsa+renesas@sang-engineering.com>
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
>  drivers/thermal/spear_thermal.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
> index 81b35aace9de..8b9d567134d0 100644
> --- a/drivers/thermal/spear_thermal.c
> +++ b/drivers/thermal/spear_thermal.c
> @@ -56,8 +56,7 @@ static struct thermal_zone_device_ops ops = {
>  
>  static int __maybe_unused spear_thermal_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
> +	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
>  	struct spear_thermal_dev *stdev = spear_thermal->devdata;
>  	unsigned int actual_mask = 0;
>  
> @@ -73,15 +72,14 @@ static int __maybe_unused spear_thermal_suspend(struct device *dev)
>  
>  static int __maybe_unused spear_thermal_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
> +	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
>  	struct spear_thermal_dev *stdev = spear_thermal->devdata;
>  	unsigned int actual_mask = 0;
>  	int ret = 0;
>  
>  	ret = clk_enable(stdev->clk);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Can't enable clock\n");
> +		dev_err(dev, "Can't enable clock\n");
>  		return ret;
>  	}
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

