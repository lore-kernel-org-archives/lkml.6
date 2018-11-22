Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E46C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A0C2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLUufkg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A0C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbeKWAz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:55:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36542 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389042AbeKWAz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:55:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id t3so9428750wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JsRedvYYJzklUvBCfuxegwXJCVCC9ujxfs6i8Z41kB8=;
        b=jLUufkg0cxxtzRKEAO5gZNJ0/S0oFGU1Ryqcu12gM9nFDHHX4pEJ4pyPXccA8gLzHt
         ekYOKOYvC1u2PAjJhAb+1Opeolto+73SUs0Fy+wpewXN9FTNW50bMblSdwu6iNBi2S8l
         +zJaNC+iVKLF3K4h2JLtQO2znS9X79BsczSHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JsRedvYYJzklUvBCfuxegwXJCVCC9ujxfs6i8Z41kB8=;
        b=TPR8P5t7sW5MirlI7ufsRB4OGq7R7alviknGkSpDTH/MCAjh7ba2dXA7Fk7HDT8TKG
         lUCggoGnWcrtSZKI7wQXhUW6dvFvUJlxNzL6ifVUQuZBu+JJOx+lvKLIkOgzW0jmgAt8
         6elLkLQEpEHNhfkP/NJYQOX6uCGu8gEs+qPhjYCdBOb69SDIiL2eTn66PJOgpnNnr56v
         PACXqyzTW9TzqOx3g7Oz+Mq2nTBbt0I/PNXZp9bAR9jwSAJ333l+S3D7SeP+qeKg1UVy
         wL8pg04urNYrtqXS5cFE5jU304TWQFKGHRG8CcbGzQOuAIJAXqFNUrPfsUXO/ZFU6WwJ
         PzqQ==
X-Gm-Message-State: AA+aEWbpYHouBHG5C1tTwHos1VgTQm6m5FWakGa8m0nRA0nUovsF5wH1
        bldaU/1RoSA/fva4UqYY0I+dyw==
X-Google-Smtp-Source: AFSGD/XDrXsoVu68fDZ2H7XzT2Y7L7RM/G7dh7fZbJFP5jGw3DfD9a3731gtAJ4RI+y/K1heVtM84A==
X-Received: by 2002:adf:e488:: with SMTP id i8mr10318376wrm.10.1542896182756;
        Thu, 22 Nov 2018 06:16:22 -0800 (PST)
Received: from [192.168.0.40] (44.65.136.77.rev.sfr.net. [77.136.65.44])
        by smtp.googlemail.com with ESMTPSA id t131sm2554427wmt.1.2018.11.22.06.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 06:16:22 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
References: <20181120131853.19710-1-tiny.windzz@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <55576bf9-4514-a4df-d632-07af6e170fdf@linaro.org>
Date:   Thu, 22 Nov 2018 15:16:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120131853.19710-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yangtao,

On 20/11/2018 14:18, Yangtao Li wrote:
> use of_node_put() to release the refcount.

In future please give a better description.

No need to resend, I'll do the change.

Linus? I'm about to take this patch. Is it fine for you?

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/clocksource/timer-integrator-ap.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
> index 76e526f58620..50e0a9166f66 100644
> --- a/drivers/clocksource/timer-integrator-ap.c
> +++ b/drivers/clocksource/timer-integrator-ap.c
> @@ -204,8 +204,6 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
>  		return err;
>  	}
>  
> -	pri_node = of_find_node_by_path(path);
> -
>  	err = of_property_read_string(of_aliases,
>  				"arm,timer-secondary", &path);
>  	if (err) {
> @@ -213,14 +211,18 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
>  		return err;
>  	}
>  
> +	pri_node = of_find_node_by_path(path);
> +	if (node == pri_node){
> +		of_node_put(pri_node);
>  
> -	sec_node = of_find_node_by_path(path);
> -
> -	if (node == pri_node)
>  		/* The primary timer lacks IRQ, use as clocksource */
>  		return integrator_clocksource_init(rate, base);
> +	}
>  
> +	sec_node = of_find_node_by_path(path);
>  	if (node == sec_node) {
> +		of_node_put(sec_node);
> +
>  		/* The secondary timer will drive the clock event */
>  		irq = irq_of_parse_and_map(node, 0);
>  		return integrator_clockevent_init(rate, base, irq);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

