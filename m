Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B49DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC2B2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnuBbxQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC2B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeGZRv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:51:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44833 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbeGZRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:51:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so1486415pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w3LoNJ+r1fC1V0bdjbtCifoz+jvERHZVfX8KApM66Ls=;
        b=dnuBbxQap7ggM++8ixmYveXsi7IkxOCvE7ESQRjswZ5oIgxpYwHIdtO6dwfuOTupJv
         hpz7EsX7OEkEpnCUpkY3fxez++MTLJWAVaMv8dMwdMYg0cY0t5JqpE8Ar4YT9mGUWg8m
         YHXR6PxmReAU36xaSf986qT1URVeFzJbG0R2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3LoNJ+r1fC1V0bdjbtCifoz+jvERHZVfX8KApM66Ls=;
        b=PldziPV3MDwLJ82nhfE6ELbUH0/GpvF32KLJeda8a0UAJD7YDGm9a64iDcDT8sOuEY
         qGjbh+IjxVz5Sh8CfnBwlDi8GtuQbScUQpTFga4H5ag89u5HIwR20kdc7/GlzSlFj1Bc
         RxFkNNN3STbe4YlBE3fxK2ghJJoDYyE6b5imkvAM6Lf7TkEoIOJrnoHnT7vRIgiLtR0u
         AYD4RdIZudnj8d/JnB3/xGhC4MLrCJXRtdCkF7txJbvmJlJ+Kvmwzlqml/xGN20pLzTj
         EPeKBKu4heTfE1WTVgzBZzYeo668JPoqyyENm5ssQ4Ythl2HUtdFcbxAEeG5WiC/rx91
         Cgag==
X-Gm-Message-State: AOUpUlFpQ/hhhYLZRveRXa7O2B+FvoYk5OeStvLx+K6Cyz6s4JrXl+Iw
        mgaWLkJdgQz1cl/dKHYExrE0Hw==
X-Google-Smtp-Source: AAOMgpdyoKSIzLmfnYsMJEgSYi41hrbcxRcHneqKUco1zvPrejrJ8Lu9BCzEcppCAqiZqCqFPPTJAg==
X-Received: by 2002:a65:658d:: with SMTP id u13-v6mr2668415pgv.20.1532622831507;
        Thu, 26 Jul 2018 09:33:51 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u11-v6sm5138952pfd.117.2018.07.26.09.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 09:33:50 -0700 (PDT)
Date:   Thu, 26 Jul 2018 09:36:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] thermal: tsens: switch from of_iomap() to
 devm_ioremap_resource()
Message-ID: <20180726163659.GB5450@tuxbook-pro>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
 <a737a9decfee231ad065304077755267fa5466d7.1532600791.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a737a9decfee231ad065304077755267fa5466d7.1532600791.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Jul 03:33 PDT 2018, Amit Kucheria wrote:

> devm_ioremap_resources() automatically requests resources (so that the I/O
> region shows up in /proc/iomem) and devm_ wrappers do better error handling
> and unmapping of the I/O region when needed.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-common.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 25e7f247b027..6207d8d92351 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -127,13 +127,11 @@ static const struct regmap_config tsens_config = {
>  int __init init_common(struct tsens_device *tmdev)
>  {
>  	void __iomem *base;
> +	struct resource *res;
>  	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>  
>  	if (!op)
>  		return -EINVAL;
> -	base = of_iomap(tmdev->dev->of_node, 0);
> -	if (!base)
> -		return -EINVAL;
>  
>  	/* The driver only uses the TM register address space for now */
>  	if (op->num_resources > 1) {
> @@ -143,11 +141,14 @@ int __init init_common(struct tsens_device *tmdev)
>  		tmdev->tm_offset = 0x1000;
>  	}
>  
> +	res = platform_get_resource(op, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&op->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
>  	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
> -	if (IS_ERR(tmdev->map)) {
> -		iounmap(base);
> +	if (IS_ERR(tmdev->map))
>  		return PTR_ERR(tmdev->map);
> -	}
>  
>  	return 0;
>  }
> -- 
> 2.17.GIT
> 
