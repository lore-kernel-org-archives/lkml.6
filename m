Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1472BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9CF20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3GXq7bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9CF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeLJGP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:15:59 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:34340 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJGP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:15:59 -0500
Received: by mail-wm1-f53.google.com with SMTP id y185so5793846wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YCpIjC/pey9t7x0S3INi6bnwRsPNkYOiJUizFsxNObo=;
        b=h3GXq7bo8GhqZr7TJrTn+zAWC6rZV2HHuvjClZUSXIdiHcIveWPv0E36sWPAPmqBht
         4bq25g5Bmt1nYQ70Dq7Eq3O554uD9VK1Vl7hXuOm0MbRKGM9Buwv6Ld14YLM6PRYT1Gy
         LGTG80F4fRCb6dTa728nPgmNKXb/m5KpqpjgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YCpIjC/pey9t7x0S3INi6bnwRsPNkYOiJUizFsxNObo=;
        b=ZC/O/ETm2GhwWi3gMVZuk96zULTJqTA32PqkJYJ6tno7MFVTMLIhhPRNGa6mL0h5oU
         6pGnLjjLRF39lTZGz2HoBu73sQfYpH7ItskgMB3kusEYtwag5bBwzJg+eDlYaWuDtziZ
         Hr3T7PIbC4IDC2udL7Ezk5ggKiCWLSNjhz6rLW90IhysR8fr5o270xOFzIeRaDv5vXrN
         5i7BpeJmwYpZ4tKjB060SWwx10q6ZIO7v458S9of/f3tLpDv9uNUDwd5jvlbtHRiOnEk
         LrvhkDj20HS9ytFg55q8tETqxXKPQfZVvEyJKIW5JQ+KLKstSJmXggP1UQtM1gTEjW32
         znSQ==
X-Gm-Message-State: AA+aEWbZrRCw3q/G4A+8UnpGd7iJ7lqMbFBVV4LaWObPvq6/D8RXn5uQ
        vjmwOVnnt13oSx09MdS8JZUGtw==
X-Google-Smtp-Source: AFSGD/VN3kKQ/J8l5IxaK1/7lseg16LjGcX9gQAHQkRnobqIe5OJqCOFulvvfE1iVOYJ1d5iiDHF5Q==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr9033693wme.119.1544422557076;
        Sun, 09 Dec 2018 22:15:57 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id x8sm34258429wmd.45.2018.12.09.22.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:15:55 -0800 (PST)
Date:   Mon, 10 Dec 2018 06:15:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dmitry.torokhov@gmail.com, matthias.bgg@gmail.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Subject: Re: [PATCH -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
Message-ID: <20181210061557.GL26661@dell>
References: <20181209063440.27820-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181209063440.27820-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Dec 2018, YueHaibing wrote:

> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1..5027ebb 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -19,7 +19,6 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> -#include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>

You are removing the wrong one.

Please convert this patch's main intent to alphabetise the header
files.  Then you can remove any obvious duplicates.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
