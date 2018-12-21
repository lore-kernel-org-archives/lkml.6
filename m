Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CD9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68A4218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKm9QK3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbeLUKNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:13:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33564 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388931AbeLUKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:13:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so13873452wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G0Yrxuu+YNoqPFW8E3C4nWKSQdHGf/2UsMLczlsVHqw=;
        b=hKm9QK3wxcgxCmGnfMkdHXlNt52TfB9Gjh+b6KcYkbEZVjGdzfp2MZZjZdw1ovfOc0
         Bzov9Q9dhBYM1JBYAEjFqyM/sFOP1Cp9I1k7VaMALrAt/tKBIRR/Gc1c7Lr7psIvB5bq
         O+35S1d4EPnHslmA5ttQthBHjNyHq7xKK8keg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G0Yrxuu+YNoqPFW8E3C4nWKSQdHGf/2UsMLczlsVHqw=;
        b=IOj4dOP1MeEArLSf6l8CIXLY9YrsxXEd0bORU4e8xbehqP0gojkcRx+1YbF75gXHuC
         amLvmpYG7d0ItZCUSrRWd0Pmx2fbcDY0yPV2RrMc7NDfO2ncFQTnlvU5d+0H8lRgKA6c
         tJe1uQu3JuTpZVF9e/OyxxhDZVe9b4d/7jIidkDGWHhkWAnAooqCR0o+VbLWuw3/Q4c6
         gWuuEtdDqoZdro0hAif1HJu7eEMhGdsQbBcWoL9i3ahdOXa26GoXDIVGMINF3sEhL/O4
         WkKId+etGQyS1Lt67DE6y7hUkzs/pImx1dWQi+Jcakow3cb56umQACwMRa7wkq4/PI5n
         twiQ==
X-Gm-Message-State: AA+aEWZ3pOk8Lw5Ez+BaM88Rwz+Rw2/bXtSTmCICzOXjeMWbV6aCXXBm
        R9RhcjIuSkVSqaQNkoHRrzKn9Q==
X-Google-Smtp-Source: AFSGD/WDG5+iplLLWPeOyt8Vk8s0XTvXSouAtP4xKKA9W3HahOObIRCgevvNoHWO1VE8Eo+PMULt+A==
X-Received: by 2002:a1c:c58d:: with SMTP id v135mr2295825wmf.88.1545387188786;
        Fri, 21 Dec 2018 02:13:08 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id g129sm10659092wmf.39.2018.12.21.02.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 02:13:07 -0800 (PST)
Date:   Fri, 21 Dec 2018 10:13:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] mfd: exynos-lpass: Enable UART module support
Message-ID: <20181221101306.GH13248@dell>
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
 <CGME20181214113416eucas1p2002adf7b5438c525c34ff3274ceacbd1@eucas1p2.samsung.com>
 <20181214113410.22848-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214113410.22848-2-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018, Marek Szyprowski wrote:

> From: Beomho Seo <beomho.seo@samsung.com>
> 
> This patch enables support for UART module in Exynos Audio SubSystem.
> There are boards (for example TM2), which use it for communication with
> bluetooth chip.

Does it though?  Or does it enable the interrupt and reset something?
These calls would probably benefit from some documentation by way of
comments.

> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> [mszyprow: rephrased commit message, added UART reset]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/mfd/exynos-lpass.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
> index ca829f85672f..2713de989f05 100644
> --- a/drivers/mfd/exynos-lpass.c
> +++ b/drivers/mfd/exynos-lpass.c
> @@ -82,11 +82,13 @@ static void exynos_lpass_enable(struct exynos_lpass *lpass)
>  		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
>  
>  	regmap_write(lpass->top, SFR_LPASS_INTR_CPU_MASK,
> -		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
> +		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S |
> +		     LPASS_INTR_UART);
>  
>  	exynos_lpass_core_sw_reset(lpass, LPASS_I2S_SW_RESET);
>  	exynos_lpass_core_sw_reset(lpass, LPASS_DMA_SW_RESET);
>  	exynos_lpass_core_sw_reset(lpass, LPASS_MEM_SW_RESET);
> +	exynos_lpass_core_sw_reset(lpass, LPASS_UART_SW_RESET);
>  }
>  
>  static void exynos_lpass_disable(struct exynos_lpass *lpass)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
