Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64A2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877C72083D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEHOgQXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877C72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeGPN6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:58:44 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36158 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeGPN6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:58:43 -0400
Received: by mail-pl0-f67.google.com with SMTP id e11-v6so2304274plb.3;
        Mon, 16 Jul 2018 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F5SvMfv8+JktTMFIrpxWM6zwtctWYEsGhVsMPoRW28U=;
        b=DEHOgQXHBYXD8z5Yl2T7Ue7I6CuNRm0j/OiFFQZJrNpxDTGvg1xh9BjJ0iDS0dB6GN
         ufuKobFDzzyzUAdHZcRL2yFqYnJDGMusYyWa9M9Lv8KWdNYXBBv6dBFaGlobqloac0nG
         PGhlfQHcoK2Bx43jScKgM3bZA3TPN4NjlyBVEWslBCoLhKjrB9UcTXnt5yO2h5Y6dEYx
         +QuXgjclRsp5V5ExyIC1m7t6KcjZlmzfByzuPDD/6Y2WpGQMx2Wajt6z8Q4lHO09JPjm
         0h3h/EBjRIriJMq/FeMMYVjr7gWXBHuh2cbzSwDFhOOciKiVfqaVrV8/Xg2KRxBvIKRX
         3FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F5SvMfv8+JktTMFIrpxWM6zwtctWYEsGhVsMPoRW28U=;
        b=MIdFHNGxEcNp2uwbL3a59MwRmubcAjLOkBx1+DKrur520ZktDfnOr2NNVboaosW/5Q
         Ju5U3JJmbaJrrcvCfQueYjP3kxYiSUwrwAXFvve3NliH9jAWyhyL5WhGYcX1HMvZmSF5
         5XPpe0zZBV4FDByWrKTh2UaON14PP9drSd/cd3vohPnnVvDhVBcWixwapzbFRRvCTfKf
         f7uP1hXehze4S/v6Wo18JDeoXj/+79tHOznolLk6zgZHNcSkSHqdg01ukeKj/o/oJeSH
         qoZOsj3Ux+uS0Ii4iZGL3fg77Z5M67IfWpqOh/tiG32t4jwCLi6ND5vXa/julUKMxlyc
         KJUg==
X-Gm-Message-State: AOUpUlHRdEutO54/I9P6t5pg1HDfegJqjh8qUF+61Ywy70MehypSG9gw
        yrwlv6AR3emTj0MQRVqOdwo=
X-Google-Smtp-Source: AAOMgpdzx0pnPg1j7oXW81A/5NyuGB/esvrXH3vxL7SD+alIQU7gwzhX5vWI1MXgXH3l8Hr2W8QGDg==
X-Received: by 2002:a17:902:82c7:: with SMTP id u7-v6mr16627491plz.83.1531747875635;
        Mon, 16 Jul 2018 06:31:15 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k27-v6sm13193526pfg.34.2018.07.16.06.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:31:14 -0700 (PDT)
Subject: Re: watchdog: davinci_wdt: add possibility to configure watchdog
 period
To:     michele.dionisio@gmail.com, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michele Dionisio <michele.dionisio@powersoft.com>
References: <20180716121909.4869-1-michele.dionisio@gmail.com>
 <20180716121909.4869-2-michele.dionisio@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6803158b-27b2-63ae-1720-72d9da78df1f@roeck-us.net>
Date:   Mon, 16 Jul 2018 06:31:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180716121909.4869-2-michele.dionisio@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 05:19 AM, michele.dionisio@gmail.com wrote:
> From: Michele Dionisio <michele.dionisio@powersoft.com>
> 
> It is not possible to implement setting of watchdog period because it is
> not possible to stop watchdog so it is nice to have possibility to
> configure watchdog period at module loading.
> 
> Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
> 
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index 6c6594261cb7..5f95afa20fee 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -54,6 +54,10 @@
>   #define WDKEY_SEQ0		(0xa5c6 << 16)
>   #define WDKEY_SEQ1		(0xda7e << 16)
>   
> +static unsigned int init_timeout;
> +module_param(init_timeout, uint, 0);
> +MODULE_PARM_DESC(init_timeout, "initial watchdog timeout (in seconds)");
> +
>   static int heartbeat;
>   
>   /*
> @@ -223,8 +227,10 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>   	wdd->ops		= &davinci_wdt_ops;
>   	wdd->min_timeout	= 1;
>   	wdd->max_timeout	= MAX_HEARTBEAT;
> -	wdd->timeout		= DEFAULT_HEARTBEAT;
> -	wdd->parent		= &pdev->dev;
> +	if ((init_timeout >= 1) && (init_timeout <= MAX_HEARTBEAT))
> +		wdd->timeout = init_timeout;
> +	else
> +		wdd->timeout = DEFAULT_HEARTBEAT;
>   
>   	watchdog_init_timeout(wdd, heartbeat, dev);
>   

NACK. This is done with the 'heartbeat' module parameter already.

Guenter


