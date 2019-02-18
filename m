Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92171C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538B521736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqcRCQf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbfBRQJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:09:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35624 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbfBRQJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:09:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id j5so4286887pfa.2;
        Mon, 18 Feb 2019 08:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QEkaUgUAIBmY1NVEn9hWurPwH2uNQdBvh8KbsAlzV/Y=;
        b=ZqcRCQf/nwBWbvc5n7lEgG9pPAa+18AZYanXSlyEfGOH1v2ZBW54Ro+wkNka5cMOob
         p0ze4lxrRHrhBdPRabRmgRsm5b8Ab311BviZ3T9J/rhIfmur1zygschxYThvc6CKER+c
         dcynkUuWUhTgiU6FEWp7y5NWcYk6EDw5J4443LgeRigjz6vvIlNqz4pnPT+OdWNkGczv
         z77UWtaDHClj87U+6AwEHpfSvmI04rkQxw66njrhk4/mPFMmN+O0LmYj/TDko2yfOVBu
         DTmJr2kntnDOnmGoqoDbNs/oLAnazeASBHVFx9CYg7PQS9KZTdJ4LuxTc+xMcSUCTAVD
         4lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QEkaUgUAIBmY1NVEn9hWurPwH2uNQdBvh8KbsAlzV/Y=;
        b=PM6fBlCm7qsPkp+i/vKJW2rkitW97q0Nh8f+/XUVGBxleY8sr+AyBkY1QvO61iaL7B
         luNDydiqzRZxpUwyvuUjVAXyz6MdYI8EBYxyFGYCRxPoacTaWhEml8npW64J2zYNMYCx
         3OVy183AKHI/OFCJDzSbCs3YEFgoL3j+Erk5fhiH7JEuuuhARki9ZVyZYoRIOaOr7ufO
         XTUaVYppIg0B7UyxUuzC3RNwNEPHI+LvpG8aTAm1RtRrXJaMqN2opX50Yo5bQEKaGlY5
         955WTDEu4GF8xXQceLGkog37Vw5Vs6Rt7BMecIwQrZJAd6WkwfrM2dlMYQVD3sw/LPmH
         jcIg==
X-Gm-Message-State: AHQUAubSh8jD48rVqyVWX72ykH26oq6y20c646E0umiUYpm5D2gPlMIT
        QRMCtNOGqMO+N2xOCsdqook=
X-Google-Smtp-Source: AHgI3IZqyzU3nCYT+M15752ZzggO/tEyNOYCDTSaAGQlhquxjEc5mrcqrwHAeC/v4/835IsBqOHzHw==
X-Received: by 2002:a62:5003:: with SMTP id e3mr25494298pfb.23.1550506158585;
        Mon, 18 Feb 2019 08:09:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y5sm24884997pge.49.2019.02.18.08.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:09:18 -0800 (PST)
Subject: Re: [PATCH] watchdog: pc87413: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190214202618.GA18658@embeddedor>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d7065d30-d56b-1b76-cfc6-e209aadc61c0@roeck-us.net>
Date:   Mon, 18 Feb 2019 08:09:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214202618.GA18658@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 12:26 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/watchdog/pc87413_wdt.c: In function ‘pc87413_ioctl’:
> drivers/watchdog/pc87413_wdt.c:439:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     pc87413_refresh();
>     ^~~~~~~~~~~~~~~~~
> drivers/watchdog/pc87413_wdt.c:441:2: note: here
>    case WDIOC_GETTIMEOUT:
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/pc87413_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
> index 06a892e36a8d..2ffa39b46970 100644
> --- a/drivers/watchdog/pc87413_wdt.c
> +++ b/drivers/watchdog/pc87413_wdt.c
> @@ -437,7 +437,7 @@ static long pc87413_ioctl(struct file *file, unsigned int cmd,
>   			return -EINVAL;
>   		timeout = new_timeout;
>   		pc87413_refresh();
> -		/* fall through and return the new timeout... */
> +		/* fall through - and return the new timeout... */
>   	case WDIOC_GETTIMEOUT:
>   		new_timeout = timeout * 60;
>   		return put_user(new_timeout, uarg.i);
> 

