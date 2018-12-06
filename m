Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF16DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB5B20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCDly5GN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB5B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeLFNc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:32:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54674 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeLFNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:32:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id z18so1000066wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 05:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ma7F/MaGF7iButmMQePk0cKTz/A+1Gb0fFsb/aq9g6M=;
        b=DCDly5GNurc+2KWbcML7ieCgR10KD2oe7OHdxENylgHVysEA1EZQNyMX6WIk6UOTLy
         vrl54p25WekKlkg4u+T84aALSWjcO8YOyg9TFAo4z0PW0k90dd/MaThVAsxO4Zl06ISt
         YP/jc9pxjr2Bf4YLaO2VgmacYc8xxQZo7mrLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ma7F/MaGF7iButmMQePk0cKTz/A+1Gb0fFsb/aq9g6M=;
        b=dpGjQsPV5uYrlM0wxzMF3pMWHFuTZReAFXzPyNQuDNkqoi+yn8hjpNFJrsOK8sEZ6q
         2CAxyy4pJ7CwjJW3P5j6PjlX1sS1LUVNCWZxhnbQa9MrENtXheJEwoVyjT6k+TpIQRbl
         9ilGTpXCZyePsPgWivijVMT3P6FRrX7LfskcEEFqKxhuM8QkdYxRVb9fT2d/fjKHhzEr
         2K75+N8ZE3mdWdeXQsq/GzErm4boW/sLd011pz9/LA0BhUojS87PQLvVgGx36AMgTd9f
         yCUptBObKSIg6kaGcx6DxIQ+OVtnYkbPhdpEZafm5rtIdaozqskjOoeDffbBePQxwsqb
         FFog==
X-Gm-Message-State: AA+aEWbY2f4apKMWiucDSWfzd4vrKcP1D5YGzWooIv8j4HCIJrkPOrgE
        mqzT8bovwJdjyrBXjtdLi6jHuA==
X-Google-Smtp-Source: AFSGD/XuZ/RhGcUUn+KzOqHjiBD9fkgMbTRRiAhklDRhuB4O3PNrIqviIVc9qYQnxVWfUH5N4mDuPQ==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr19935873wma.68.1544103143229;
        Thu, 06 Dec 2018 05:32:23 -0800 (PST)
Received: from [192.168.0.40] (172.220.136.77.rev.sfr.net. [77.136.220.172])
        by smtp.googlemail.com with ESMTPSA id d5sm788927wrx.22.2018.12.06.05.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 05:32:22 -0800 (PST)
Subject: Re: [PATCH] thermal: stm32: read factory settings inside
 stm_thermal_prepare
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
References: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
 <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7999967d-6f6e-635c-4d43-c0e1cd58ec4b@linaro.org>
Date:   Thu, 6 Dec 2018 14:32:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 14:23, David HERNANDEZ SANCHEZ wrote:
> Calling stm_thermal_read_factory_settings before clocking
> internal peripheral causes bad register values and makes
> temperature computation wrong.
> 
> Calling stm_thermal_read_factory_settings inside
> stm_thermal_prepare fixes this problem as internal
> peripheral is well clocked at this stage.
> 
> Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
> Fixes: 1d693155 ("thermal: add stm32 thermal driver")

Same comment as the first patch.

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index 47623da..daa1257 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
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

