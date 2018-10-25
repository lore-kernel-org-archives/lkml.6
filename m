Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD796C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E1020838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQLM5idG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E1020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeJYQ4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:56:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32986 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeJYQ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:56:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so1369632wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vkcr+tEHjtUR2k7LqyOb6slz/j2f5bY9ltqX6rIvzt0=;
        b=WQLM5idGIg8DbnJat4xJC5chg+s/Xd0+/aSoDUXooeeH6yM4QddIelYIxwXrsSnG0l
         +IFqW7l5eiJLmxu+uZHBLaM5IHUTUjj3asgSLyDGC7caaZr7AuQ3l64u0dZLCygDg/AT
         N+wop48IT/SsNlv/vJTbThpEgEKCZEDO+pH18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vkcr+tEHjtUR2k7LqyOb6slz/j2f5bY9ltqX6rIvzt0=;
        b=fa79sqJq3zPv6PxkMzVphqcsLBZ0wEXO1Vs+pQ9Z4/zBfWyFsFBnIpOa/i0uWrmPnR
         wUcK1jX+lf1N6Vg360+La2BN9i7BHJKZSEFQ/JERKI6MEDTEdP1BtRoJ5HRsE82RhRo2
         2Lf51MHTywuIFC91vflYiaQ9EaQofYbJ2abI7oIxIfn84PJz3zjQ3S0Yo/Wjq3nij4MJ
         tXDTKWRnJH4zhy5lgGsQHgJ1JO7iYv8NxVC5iZHfItu0sSpWbfYjKFAZxhWU5HZOx7an
         iUJESRSwZty/aG0f/VbQHy5C5BCFNJ1Hnh4tcTojxsLrG4X26CUcy8ulLZZm7M678BUa
         Kbvw==
X-Gm-Message-State: AGRZ1gJSL57/RwiimhHCzHAdJ2ppgC/jNMEV2KCXa1iphCAnGS1gCq4Z
        Ma/HtEpeDGT/ToOHkBrwEiGDpw==
X-Google-Smtp-Source: AJdET5c06OY6geQcpyLDTxEkAwc3slRdzN7f6YuZxGNqJ8jv0NF0bsX+KpFb6h9PAbv672jokW88Lw==
X-Received: by 2002:a1c:46c5:: with SMTP id t188-v6mr796558wma.68.1540455910814;
        Thu, 25 Oct 2018 01:25:10 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id a193-v6sm454108wma.19.2018.10.25.01.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:25:10 -0700 (PDT)
Date:   Thu, 25 Oct 2018 09:25:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mattias Wallin <mattias.wallin@stericsson.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: ab8500-core: Return zero in
 get_register_interruptible()
Message-ID: <20181025082508.GJ4939@dell>
References: <20181018080534.yw2crvhguen5vajg@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181018080534.yw2crvhguen5vajg@kili.mountain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018, Dan Carpenter wrote:

> I just noticed this in review.  The get_register_interruptible() should
> return zero on success but it instead returns the value that it read.
> 
> I looked at all the places that called this directly and they check for
> negatives and treat greater than or equal to zero as success.  This
> function is also called as the ->get_register() function pointer.  Some
> of the callers of that treat all non-zero returns as errors, so it's
> possible that this bug causes some problems in real life.
> 
> I could not find any callers that rely on the current behavior, and this
> makes the function align with the get_register_interruptible() in
> ab3100-core.c.
> 
> Fixes: 47c1697508f2 ("mfd: Align ab8500 with the abx500 interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/mfd/ab8500-core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> index 30d09d177171..66458a329127 100644
> --- a/drivers/mfd/ab8500-core.c
> +++ b/drivers/mfd/ab8500-core.c
> @@ -252,16 +252,18 @@ static int get_register_interruptible(struct ab8500 *ab8500, u8 bank,
>  	mutex_lock(&ab8500->lock);
>  
>  	ret = ab8500->read(ab8500, addr);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(ab8500->dev, "failed to read reg %#x: %d\n",
>  			addr, ret);
> -	else
> -		*value = ret;
> +		return ret;

Looks like you just broke the AB8500.

What is it you're trying to achieve here?  Apart from attempting to
return with the mutex still held, what semantics have you changed?

> +	}
> +
> +	*value = ret;
>  
>  	mutex_unlock(&ab8500->lock);
>  	dev_vdbg(ab8500->dev, "rd: addr %#x => data %#x\n", addr, ret);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int ab8500_get_register(struct device *dev, u8 bank,

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
