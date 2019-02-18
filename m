Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EC0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AF020675
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqQ/fiYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfBRKYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:24:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55132 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfBRKYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:24:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so16787980wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 02:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BWGCuuvZHZX+r9SBWzJZUPE3587L0he98T9cKlhJ7WU=;
        b=WqQ/fiYI1W/NqvA3bC+blsHRxWQivFovezYEdwbKlTnDDF/eK9nTJh8qUCBJGq1wtO
         lx/ks1tMRIek41/LSRfkN/Z2rwVz50ni+5njrwn8z6z0Qc7YyuWLTigLIH9Yr8hBahB3
         iVrhya9oyXHmw1J3Ftpd5LT0ULzjgs2AZ78N17XafaHniMWO2xZOimpCRclHbBB0eMrU
         QdVGXKXpsS+p4z6zYv2sw2q20qIrlosK5wYQ0HMiYbdncOuWUE/sJQ/HvCivmUiCDxiN
         /V8DSOMp33yP0l1EGrTKAHXJVK7EJTJIDqealytjBdtXTToIgOGPF8FchC0FrCPNJIy1
         VJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BWGCuuvZHZX+r9SBWzJZUPE3587L0he98T9cKlhJ7WU=;
        b=imP5lTck9FtEd/4n+Cdzdqd0a6Xfe/PgvScz1hS8aoPzhi4wqL6RAMPvnx5dgR4rEj
         XcB9cCsWWiS46AR2rVFk8IIbnOEwf63zp7uiS7Dyv/QGpdZls369R+OzFJimnvD4APkA
         9XAfh2VvblfmvzGyph+uATPF1Th8SxwWiePqDREKuv6fInfkzB6coEh8y0dY05zA3nMX
         yGvjSZh+ORFO+ediIMs6le/wqzFihPFlv2T6VsXBKq/P6NPC3Jl/ySK9z0xDIgjD1VsG
         /LNkDmbXbPd1N1lSCLVKfZwOwoihdJvkMjPfS2+Jqnm06gSEcveAG5ZPDFJTg+MONkbm
         zamA==
X-Gm-Message-State: AHQUAuZrweBQrzwftv1lbpuTXzkP66+ZYXkZWtKyD78s164EL0kWbqm6
        p5e6QygQF+4rVoWSBtyFxLEXmQ==
X-Google-Smtp-Source: AHgI3IaXEvSBf8pa3dI0wZwFVSlgVPULbTlPp4qE7PMeTn8wxyzciuQQhQF129LBi778p77wRjcFVA==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr15188287wmb.148.1550485448147;
        Mon, 18 Feb 2019 02:24:08 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id a184sm18018534wmh.37.2019.02.18.02.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 02:24:07 -0800 (PST)
Subject: Re: [PATCH v7 2/3] thermal: tegra: fix memory allocation
To:     Wei Ni <wni@nvidia.com>, edubezval@gmail.com
Cc:     thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <1546510369-28491-3-git-send-email-wni@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e02ad969-129f-1967-57c2-78533e2c7dbe@linaro.org>
Date:   Mon, 18 Feb 2019 11:24:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546510369-28491-3-git-send-email-wni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2019 11:12, Wei Ni wrote:
> Fix memory allocation to store the pointers to
> thermal_zone_device.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---

Good catch

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


>  drivers/thermal/tegra/soctherm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index f07de8258e93..fd2703c0cfc5 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -1339,7 +1339,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>  	}
>  
>  	tegra->thermctl_tzs = devm_kcalloc(&pdev->dev,
> -					   soc->num_ttgs, sizeof(*z),
> +					   soc->num_ttgs, sizeof(z),
>  					   GFP_KERNEL);
>  	if (!tegra->thermctl_tzs)
>  		return -ENOMEM;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

