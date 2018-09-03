Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDAEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BE72086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWfWnmfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BE72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeIDAqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:46:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38737 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeIDAqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:46:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id u11-v6so581465plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gqa8DjAsLbslhqvdckp+9F2A4OfDGcqfjUcMGYSdaqk=;
        b=gWfWnmfQUB0zU90hzRMOcnCJ3JouO5RgHGzR+mbjS+OhyZ7bdCGxKjKTOY8eaCH497
         z0wSc8Es+PRpoSdYPcVJqR3Pw/IYBo96Qr9+8kVeeKvNsCAPN3cVgfvflQytX6B2aely
         2bFA/3r/0Al9VxW+MMGVbLwPjFIU/YYcKM6/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gqa8DjAsLbslhqvdckp+9F2A4OfDGcqfjUcMGYSdaqk=;
        b=sXbwV2QWZ+p7mWbA8M/Sb1N4bRU7yrpw6nsERnMS6C5pm9NWsh1ExYf7CKYnW3/lCl
         JRoBT6DrPCMm14/0s7sp/H9qED6Sry5FJAg1Tv4kEEAaL+pBdsmwaPoYyowCyowH0LRT
         loT6GVOrK0MBBx2G7gHQm+Tm4YQFVpz9uHXl4JnBiHoGluYc5RCXm5MYefNZHr+r5Nj7
         OdlEmn/BNCNY3lQFMngLF7KMzSQaNHKQo2L/NPk4yjMA76fJW4KsMLEXL+8PVPgcHl1y
         BgTdDmkBRyB0iCenEINkN46luA8Lu1LEpq4pbmz6lxyvLqduc+/qUhD5I5cSP/YizM4/
         UhDw==
X-Gm-Message-State: APzg51BizlhApjhB63+pwP7xTolWl7Q9iRQDMonvwy8bFvv+uiejDqmc
        asa2gvDcZJdtrJlj0assP0LoNQ==
X-Google-Smtp-Source: ANB0VdYVSoQbcCoJR8z4u+OY5P4G7ju9DaOinFY7TLcmMoOdbDQm+StL/BYAAvQed1ZC3HpPGZYWlQ==
X-Received: by 2002:a17:902:9a83:: with SMTP id w3-v6mr30967023plp.75.1536006268684;
        Mon, 03 Sep 2018 13:24:28 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d19-v6sm30525568pfe.42.2018.09.03.13.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 13:24:28 -0700 (PDT)
Date:   Mon, 3 Sep 2018 13:28:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 07/11] thermal: tsens: Add the SROT address map
Message-ID: <20180903202822.GS3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <d1d2e58288f4d78db924863ac1775c5e2e5c884a.1535462942.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d2e58288f4d78db924863ac1775c5e2e5c884a.1535462942.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:

> On platforms whose device trees specify two address spaces for TSENS, the
> second one points to the SROT registers. Initialise the SROT map on those
> platforms.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-common.c | 14 ++++++++++++--
>  drivers/thermal/qcom/tsens.h        |  1 +
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 0585084630b3..0b8a793f15f4 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -117,16 +117,26 @@ static const struct regmap_config tsens_config = {
>  
>  int __init init_common(struct tsens_device *tmdev)
>  {
> -	void __iomem *tm_base;
> +	void __iomem *tm_base, *srot_base;
>  	struct resource *res;
>  	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>  
>  	if (!op)
>  		return -EINVAL;
>  
> -	/* The driver only uses the TM register address space for now */
>  	if (op->num_resources > 1) {
> +		/* DT with separate SROT and TM address space */
>  		tmdev->tm_offset = 0;
> +		res = platform_get_resource(op, IORESOURCE_MEM, 1);
> +		srot_base = devm_ioremap_resource(&op->dev, res);
> +		if (IS_ERR(srot_base))
> +			return PTR_ERR(srot_base);
> +
> +		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev,
> +							srot_base, &tsens_config);
> +		if (IS_ERR(tmdev->srot_map))
> +			return PTR_ERR(tmdev->srot_map);
> +
>  	} else {
>  		/* old DTs where SROT and TM were in a contiguous 2K block */
>  		tmdev->tm_offset = 0x1000;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 58e98c4d3a8b..b9c4bcf255fa 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -70,6 +70,7 @@ struct tsens_device {
>  	struct device			*dev;
>  	u32				num_sensors;
>  	struct regmap			*tm_map;
> +	struct regmap			*srot_map;
>  	u32				tm_offset;
>  	struct tsens_context		ctx;
>  	const struct tsens_ops		*ops;
> -- 
> 2.17.1
> 
