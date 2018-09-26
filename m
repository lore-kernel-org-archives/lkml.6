Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4593AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE00B21502
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cz+pRrCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE00B21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeIZVfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:35:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46162 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeIZVfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:35:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id z3-v6so15621754wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qTc6gR4Y7dDdYSiOtKtvSUO0xhGDDCxmtA9wP1midnQ=;
        b=cz+pRrCLFisOlzC8eQo6+xVmXmumFW/fhn+V00jFUvJEXYcuV2do4h9P9yGvYeI+ud
         EWqmk0npQ/d033n5XzLaibx3XLrTSFecl+FTvGP4mfoH7nUf3VpYTq5LzN4NQSKMp0GF
         WR2ve4vhBSn3zyT4v3Pa3nbha8lQxazKN/ntc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qTc6gR4Y7dDdYSiOtKtvSUO0xhGDDCxmtA9wP1midnQ=;
        b=N5yfjXJjDZCrShxxaPNUS/5m7aJytHW1It0OooEAxG6ZgFRuSqUuP+sVDfVm+ay5fZ
         CPleZgZOg/qxHx4IT5c5jCjxyhAtnzylgSFJPEJgQIfGunbvC4stt76EMddG8T95vL1t
         /o9gvRttd4613v2S1tO5231S7YKotlaRP35ahjrImoNVBv6wiwhfmI+S/PEivKv7Hzbu
         Vqcpc604Yb6SK+rcOD9nHCF2ruA8Ch74MaoXQjxZ4e8dtwJkYJN3ov3RY4NnDDlXAdX6
         cR46zptDE6yQuwaZeEShAiNCnbilacX9v5BhXcMzlO1csxHFM3c6a8AagRjLmhygdtvE
         4JfQ==
X-Gm-Message-State: ABuFfohHgfdhnHgS7pE3JAeHJ42kAOqJaf4KMjJnOnm2d2rS0hAUw2jZ
        m08VAJ/PeygZFiWdbcjJBQqfPEEsl6Q=
X-Google-Smtp-Source: ACcGV61PYeELbIb8p0AsuDOIthpN5ZWZdzBPAb7zvGxeBb+pGYswY7l8f+ymnBWzGB5G6vYe1J40IA==
X-Received: by 2002:adf:f991:: with SMTP id f17-v6mr5463143wrr.105.1537975300921;
        Wed, 26 Sep 2018 08:21:40 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id j2-v6sm4630442wmj.5.2018.09.26.08.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 08:21:40 -0700 (PDT)
Subject: Re: [PATCH] clocksource: dw_apb: add reset control
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>
References: <1537195934-26035-1-git-send-email-dinguyen@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b99e898f-176f-b587-0d8e-eea18550f3da@linaro.org>
Date:   Wed, 26 Sep 2018 17:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537195934-26035-1-git-send-email-dinguyen@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2018 16:52, Dinh Nguyen wrote:
> Add code to retrieve the reset property for the dw-apb timers.

The patch does more than that. Can you explain why the assert/deassert ?


> Signed-off-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/clocksource/dw_apb_timer_of.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
> index 69866cd..24bc073 100644
> --- a/drivers/clocksource/dw_apb_timer_of.c
> +++ b/drivers/clocksource/dw_apb_timer_of.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/clk.h>
> +#include <linux/reset.h>
>  #include <linux/sched_clock.h>
>  
>  static void __init timer_get_base_and_rate(struct device_node *np,
> @@ -29,12 +30,20 @@ static void __init timer_get_base_and_rate(struct device_node *np,
>  {
>  	struct clk *timer_clk;
>  	struct clk *pclk;
> +	struct reset_control *rstc;
>  
>  	*base = of_iomap(np, 0);
>  
>  	if (!*base)
>  		panic("Unable to map regs for %s", np->name);
>  
> +	/* Unreset the timer if applicable */
> +	rstc = of_reset_control_get(np, NULL);
> +	if (!IS_ERR(rstc)) {
> +		reset_control_assert(rstc);
> +		reset_control_deassert(rstc);
> +	}
> +
>  	/*
>  	 * Not all implementations use a periphal clock, so don't panic
>  	 * if it's not present
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

