Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6F6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEF620657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4ZSBp5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEF620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeJaBtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:49:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37248 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeJaBtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:49:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id g9-v6so13400380wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9dAkYr2Q3ZZk3b4DNA7rtl3LpN8B52eOdHvfIesVBNY=;
        b=h4ZSBp5oDde5WZ8tqFvYJIdgV3EGGhfUZPTkGNDTBiXUbDVYgtSOk0qhniKD/c9ubb
         BZ/FqPpWcZkyzfpquZpt6YvVT3gKZSR5IMrWkqtbzQZDwkn36S9DyMqSjviBq7zRMWTw
         Wor7wrAcOzC/Cwjl3+FdnPOt852Vi1yR9R39Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9dAkYr2Q3ZZk3b4DNA7rtl3LpN8B52eOdHvfIesVBNY=;
        b=CATr0nznExhIlJwkhgY1gz6GpMnYeAiJhh9LOKbPAYKjnobnTL1dCVnZDF1Ko9YPWk
         WcXKKWPwbiBCpYqVPDAVrDBzxUEUz/x3MAhtuq6rvdRQFRCqWW7ay8m53/uCvOOW3CuV
         Ugm7L+3VI28FDgRXiQuESPBA02pnw7JBlUl0WNBkgJfZSb1zdvDcFeo2LUxRxdwU4Llt
         mkgjy7RguaV4Zfhat3WevkowvADU2GBcu9idjORxMsuLCXCl6kXpotBE6a3vm/EG2VO0
         V44dmzP16bMOp2o4iwrE/QlJ3R12srjloCZ8YmY8NsShil1OoN516yXhU50FCUYXEeri
         cmXw==
X-Gm-Message-State: AGRZ1gL7h+jtv0KNCbWIIDgAefzEWygij24FPBOwa9BXM4Gf5I01FYt7
        F4UA+m7jsM+K1ub6tcJXqCWOGmstTWM=
X-Google-Smtp-Source: AJdET5c4Xd5zj0WQSK8mikWZGuu4SPliIooH463qaICeJzE+5YgFX9SU9nG57VqHqJaUIZxY7GoHaw==
X-Received: by 2002:a5d:4292:: with SMTP id k18-v6mr18412175wrq.225.1540918496058;
        Tue, 30 Oct 2018 09:54:56 -0700 (PDT)
Received: from [192.168.0.40] (12.152.88.92.rev.sfr.net. [92.88.152.12])
        by smtp.googlemail.com with ESMTPSA id 195-v6sm20057913wmx.21.2018.10.30.09.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:54:55 -0700 (PDT)
Subject: Re: [PATCH] thermal: broadcom: use
 devm_thermal_zone_of_sensor_register
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Markus Mayer <mmayer@broadcom.com>
Cc:     kernel-janitors@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1540915731-22312-1-git-send-email-Julia.Lawall@lip6.fr>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <14095608-e080-d907-c9ea-788a3abe1645@linaro.org>
Date:   Tue, 30 Oct 2018 17:54:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540915731-22312-1-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 17:08, Julia Lawall wrote:
> Using devm_thermal_zone_of_sensor_register allows to simplify some
> error handling code, drop a label, and drop the remove function.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> This patch is completely orthogonal to the recent constification
> patch.
> 
>  drivers/thermal/broadcom/brcmstb_thermal.c |   24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 1919f91fa756..956eef8717bb 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -329,7 +329,8 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
>  	priv->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, priv);
>  
> -	thermal = thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &of_ops);
> +	thermal = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv,
> +						       &of_ops);
>  	if (IS_ERR(thermal)) {
>  		ret = PTR_ERR(thermal);
>  		dev_err(&pdev->dev, "could not register sensor: %d\n", ret);
> @@ -341,40 +342,23 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		dev_err(&pdev->dev, "could not get IRQ\n");
> -		ret = irq;
> -		goto err;
> +		return irq;
>  	}
>  	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  					brcmstb_tmon_irq_thread, IRQF_ONESHOT,
>  					DRV_NAME, priv);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
> -		goto err;
> +		return ret;
>  	}
>  
>  	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
>  
>  	return 0;
> -
> -err:
> -	thermal_zone_of_sensor_unregister(&pdev->dev, thermal);
> -	return ret;
> -}
> -
> -static int brcmstb_thermal_exit(struct platform_device *pdev)
> -{
> -	struct brcmstb_thermal_priv *priv = platform_get_drvdata(pdev);
> -	struct thermal_zone_device *thermal = priv->thermal;
> -
> -	if (thermal)
> -		thermal_zone_of_sensor_unregister(&pdev->dev, priv->thermal);
> -
> -	return 0;
>  }
>  
>  static struct platform_driver brcmstb_thermal_driver = {
>  	.probe = brcmstb_thermal_probe,
> -	.remove = brcmstb_thermal_exit,
>  	.driver = {
>  		.name = DRV_NAME,
>  		.of_match_table = brcmstb_thermal_id_table,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

