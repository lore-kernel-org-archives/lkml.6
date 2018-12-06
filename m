Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A148DC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CAF20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+wup7CJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CAF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbeLFJnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:43:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37346 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeLFJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:43:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so305496wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZSk6hIsmK/zbcNqT53FU0KnRlMRG/z7GDbRCkUaGy7o=;
        b=H+wup7CJxMxA4AwAggu9UNYtiUSodyYLJ/cxd9IoqnKnmQCAhXgyG17+Z90oxXd98K
         SN1f761WuLchXP9E0t3/TPWWDVXmnwyptszNS/8zxfg1YT+jdgOB1UCS0SiipGkzGMWF
         11XIKiUsKUiGV1Pq4clyUO+WUf/qAYMPyK/vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZSk6hIsmK/zbcNqT53FU0KnRlMRG/z7GDbRCkUaGy7o=;
        b=bIB7VtYFy2Luv0lYx0kisOqwov8jMCJOxsshazLfft+OHKmDea+9kFJPnyZGWF4Qz8
         q/20qVPiDl4vqBkgfrpdoMV7x83A/wy0fgPmkal4fMcmY7jJFqKsrhtNfCQuO+pjz4vq
         FhYigsfHmKPN/aBzcq3KLqbsQJSde5+HUk3XmZjNfRfYDn4wKAWlAqNaniM8fV5W4LXe
         QugdbZ+3hx6e8hfl5ee41yzIApitDFiT4qzHFX/nIVsEsJ5UY9z8ynK+WalMOuiykTBD
         To3fA9+nr+1rW/eB9n0WS/OgFrUtbuekrWFQaTTlx9jsW9Hg8b9yj5wd3NFjr1GPdTvG
         pHvQ==
X-Gm-Message-State: AA+aEWZ4V2ALE3zCnzEQR04ncSqWYUidTYqTPpn68c0HqYGwCTFb66kp
        JMhE15l8HqlZNHjj9rMhn66zHQ==
X-Google-Smtp-Source: AFSGD/XvJXN8IJLduPGF6ZvZUe+4QJB7XN2klvbdjb4VTK9MGVEcE/62pT5iQW9V4/OaZa1L2e7EmA==
X-Received: by 2002:a1c:9a4c:: with SMTP id c73mr19841697wme.35.1544089412593;
        Thu, 06 Dec 2018 01:43:32 -0800 (PST)
Received: from [192.168.0.40] ([80.125.148.122])
        by smtp.googlemail.com with ESMTPSA id q12sm353131wmf.2.2018.12.06.01.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 01:43:31 -0800 (PST)
Subject: Re: [PATCH] thermal: stm32: read factory settings properly
To:     David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1544087575-22242-1-git-send-email-david.hernandezsanchez@st.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b6e93540-120d-9358-86df-d8b78f37b67a@linaro.org>
Date:   Thu, 6 Dec 2018 10:43:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544087575-22242-1-git-send-email-david.hernandezsanchez@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi David,

On 06/12/2018 10:12, David HERNANDEZ SANCHEZ wrote:
> Call stm_thermal_read_factory_settings once
> internal peripheral is properly clocked.
> 
> To avoid wrong initialization of fmt0
> (stm_thermal_sensor struct) member add
> brackets properly.
> 
> Change-Id: I150d00fd50e382df04bfad12f0653b1ed6a1db1b

Please do a cleanup of the log:
  - line wrap at 72 characters
  - No Change-Id

State the problem and then tell what you do to fix it.

For example, it is unclear what happens if the factory settings are read
before the clock is set.

The bracket change is not directly related to the clock ordering and it
should go in another patch.

In addition each patch is fixing something, in this case it is the
initial import, so each fixes should contain the tag:

Fixes: 1d693155 (thermal: add stm32 thermal driver)


> Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
> 
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index 47623da..bbd73c5 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -241,8 +241,8 @@ static int stm_thermal_read_factory_settings(struct stm_thermal_sensor *sensor)
>  		sensor->t0 = TS1_T0_VAL1;
>  
>  	/* Retrieve fmt0 and put it on Hz */
> -	sensor->fmt0 = ADJUST * readl_relaxed(sensor->base + DTS_T0VALR1_OFFSET)
> -					      & TS1_FMT0_MASK;
> +	sensor->fmt0 = ADJUST * (readl_relaxed(sensor->base +
> +				 DTS_T0VALR1_OFFSET) & TS1_FMT0_MASK);
>  
>  	/* Retrieve ramp coefficient */
>  	sensor->ramp_coeff = readl_relaxed(sensor->base + DTS_RAMPVALR_OFFSET) &
> @@ -532,6 +532,10 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
>  	if (ret)
>  		return ret;
>  
> +	ret = stm_thermal_read_factory_settings(sensor);
> +	if (ret)
> +		goto thermal_unprepare;
> +
>  	ret = stm_thermal_calibration(sensor);
>  	if (ret)
>  		goto thermal_unprepare;
> @@ -636,10 +640,6 @@ static int stm_thermal_probe(struct platform_device *pdev)
>  	/* Populate sensor */
>  	sensor->base = base;
>  
> -	ret = stm_thermal_read_factory_settings(sensor);
> -	if (ret)
> -		return ret;
> -
>  	sensor->clk = devm_clk_get(&pdev->dev, "pclk");
>  	if (IS_ERR(sensor->clk)) {
>  		dev_err(&pdev->dev, "%s: failed to fetch PCLK clock\n",
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

