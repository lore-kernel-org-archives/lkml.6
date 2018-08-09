Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58602C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071CF21F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K9qmW+2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071CF21F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeHIWMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:12:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45874 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeHIWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:12:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so3315788pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ywkQ5v/qGGhn2bOYDuH8qj7dIUyevSy3XrFeiu1+oZQ=;
        b=K9qmW+2nc31N5bLfr+zBnoaVbWJiQmOlRkcPTpmlXF+LvkKCLLq632tq24jZHhAEUr
         +vVXFvxk6Fw2pu8neHFe0mOmZtMBui1vhcjz+x8LNV5m+/cZfF0ozfd6J8ouC0QeQMLp
         JbQ0KXdDRqLuxtVn6EUalS7m5kyDdAGSRHoYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ywkQ5v/qGGhn2bOYDuH8qj7dIUyevSy3XrFeiu1+oZQ=;
        b=RnqIctZk28wpdGdQJNI9L18yKUQksK/EEeb31BAIuSlQvclpve4JuvzIGBTl+bNo+3
         aHjgSSDpPAbjFlupNwDYEPt/p+CckG57VlhP9up3OGnaDrr6T0DuQaX5qlvBmI94r/g+
         M5plz9iC3vtJ93t2NjdJ3bNkBgbeft9akSNRJvBP67Vl7Q3jLGH0ZJAqxJ0lT95OhM0w
         jlaYLe8H4HNVrJBqwdMg8RbFpYQU2dz6i2kD4vE1AQjc0DG4lupmqnIQoYZc7LMF6iKQ
         FphAa9icNwpgTJl0auZEWfeLNDduIgG6/CLrT2Q0xWYg3riFUTjJScjJ/JGOQxi6KLpj
         GCGg==
X-Gm-Message-State: AOUpUlGI1KYZqc3ZJ5GTduuHX8FpcnPn+KVkAy2lmAAhLVMFdgGiilB3
        GfYDGuxcsb6TNgOUVf5EpPYf+A==
X-Google-Smtp-Source: AA+uWPyFhrWehnO+Ac94Y3Ei9nV11QX7Lwbp7yh2YTGX2X8BAfQvOeblmRB7X+sKfPdYyx4UnC6ZHg==
X-Received: by 2002:a63:dd49:: with SMTP id g9-v6mr3382321pgj.356.1533843963396;
        Thu, 09 Aug 2018 12:46:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id w192-v6sm8770803pfd.74.2018.08.09.12.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 12:46:02 -0700 (PDT)
Date:   Thu, 9 Aug 2018 12:46:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 06/10] thermal: tsens: Add the SROT address map
Message-ID: <20180809194602.GN160295@google.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <3759de54da8dac772f43c098fcec322de179c1a4.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3759de54da8dac772f43c098fcec322de179c1a4.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:38PM +0530, Amit Kucheria wrote:
> On platforms whose device trees specify two address spaces for TSENS, the
> second one points to the SROT registers. Initialise the SROT map on those
> platforms.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
