Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C64C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31F52192C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgRwnpLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfAYIEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:04:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41890 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYIE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:04:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so4382153pfi.8;
        Fri, 25 Jan 2019 00:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OGEFOw2yL2kgWYOCZc4tobG/RbEgTa2Gvcucx/p5Aiw=;
        b=UgRwnpLcVdpL26gAfu5IP3OhhtCMiuEmDDHtVL2wVPJruXOHMjea2j7FU2coRoSuLA
         A6inDwMjns6StM5ff/J7r8iTIql+J+71WrTi+Dj62bKPl9s8pQd3Tv5jJ4/zb202Hg78
         17kESxDeuzmOGXH0JDNecBU5rdDtvgi81fskjo9+lRMB7YjtxO/g8zooPpA7eYoi6s2H
         6a3S+eNDZZZrZivqbJJcIbQ1eHQYIWwMyZFqj7PpO0izuROs1U+oH8L2XHdc/X1BlMLM
         iwhLBa7/q5hqTkRgjPn1rxD5+ZKrJSKL+XBvEJg7rqiXzNboExSFE+ematFrrefwftQc
         Q7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OGEFOw2yL2kgWYOCZc4tobG/RbEgTa2Gvcucx/p5Aiw=;
        b=Ezr5NZXspYnzxAUZbvpw2sK8VM7TpmZUkM+LEAq9k8RnW1uEGKrQ7vlXUIe+qrBuAV
         +fS5jsNronKDTVLpmPjV5ERxvMa/pQ9MEk0aJqclEC1ssTWgoIY/aUENAput1UkAr1Xo
         TGkJJSWNzznwyr1Pdpa67ngPIyC3cWd6B1AhqkIiSDm+6Z+RSjWuKexDTZOMUt5Sb9XM
         lUnPrLgbw8QqgDG/OBLD3a4BsbBdlX/pIxBYFfXnBTxwpyiwH7omR+DhunP3AXPWeT56
         ayr4Bhx8h8ddT0EJ7LxgZw0tJcgm1NPgU4wuXoZAqMkcbFKTgtmXFOgwS37c6g5jz/oX
         NoIg==
X-Gm-Message-State: AJcUukc3OX8IGTFJ0/HZkAyjPnQSwWQOrpmR8QJ/0mkVAXt6hzZeC4Zt
        K3GqMhv0tAiO3sapp7BmkdDYepIu
X-Google-Smtp-Source: ALg8bN566+5FdO/sB9MSawlqdxUEa8ewSvJ2kUzBLx5RYj9x+xQmWFnAXijD78CDsLMMtwvsPoskSQ==
X-Received: by 2002:a63:4384:: with SMTP id q126mr8955512pga.160.1548403468624;
        Fri, 25 Jan 2019 00:04:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2sm46694651pfa.167.2019.01.25.00.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 00:04:27 -0800 (PST)
Subject: Re: [PATCH] watchdog: dw: use devm_watchdog_register_device()
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190125154604.66801c6a@xhacker.debian>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b521625b-ffff-ba49-77d7-018ad363db36@roeck-us.net>
Date:   Fri, 25 Jan 2019 00:04:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125154604.66801c6a@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/24/19 11:52 PM, Jisheng Zhang wrote:
> Use devm_watchdog_register_device() to simplify the code.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>   drivers/watchdog/dw_wdt.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 501aebb5b81f..c053c2de5c2f 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -303,7 +303,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>   
>   	watchdog_set_restart_priority(wdd, 128);
>   
> -	ret = watchdog_register_device(wdd);
> +	ret = devm_watchdog_register_device(wdd);
>   	if (ret)
>   		goto out_disable_clk;
>   
> @@ -318,7 +318,6 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
>   {
>   	struct dw_wdt *dw_wdt = platform_get_drvdata(pdev);
>   
> -	watchdog_unregister_device(&dw_wdt->wdd);
>   	reset_control_assert(dw_wdt->rst);
>   	clk_disable_unprepare(dw_wdt->clk);
>   
> 
Unfortunately it isn't that easy. The other two calls have to be executed after
unregistering the watchdog, meaning you would have to add devm_add_action()
in the probe function to call them.

Guenter
