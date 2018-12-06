Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C20C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E7220868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+tWArTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E7220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeLFNaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:30:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46177 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbeLFNaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:30:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so447391wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 05:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mfKJIijKVOHLPxQxvHmWc2C5JM72MrjkRIP4pXrZkWY=;
        b=T+tWArTRgEaGFepCTqL+yHUkCUwdYkZiRNqw62iqM7J9KqQE/732sl2xnIGGszjuuQ
         F0sQzmgQQAiCkLLNvjK0dsMHBMTTM/vvyxvZSmnL9xW360xDhx10xkg6tIiChghlHh46
         tIIhhKB27dHUNplFNMbLZhg0bnP6A8NE+bFQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mfKJIijKVOHLPxQxvHmWc2C5JM72MrjkRIP4pXrZkWY=;
        b=VhRdEQJ7QGIZ6ErXVlZcsmgNYLqYvKhNC7RR+MhTX772bS/oxou59NYwVxNOJAEpwB
         EHZKDUp6JlACPir6D+QiFMKg74+JEL58UTiFrCXbK0yZ8H468TR3I2ksf2Fs42SgRILp
         8aLtOMA/160iW3QSS2OREgKGh06IHuTaqX/dtx+wGc4KGC4Vl1Cz/JtpuVzGmxkHiXkj
         T5TSvgJe7gj7XrFo99q10W1pqG3N91p+gfoMMjrLYv6h9aZx//yG6/MbSK8ya3q3ywRO
         Dq/FdJhWkbLT55WP6salcHUpOchH0TY++PRDxfYDVArWHEGIu5tuujA2p9W9LboQtL1f
         plkQ==
X-Gm-Message-State: AA+aEWbJwq+zNhtCl4bPRFtQBCu+GJRkxqcl+NkqhLfpgYbaGWe1H7Jx
        DXAVAgZt3Rju3RIWEwAAiBaWaw==
X-Google-Smtp-Source: AFSGD/VR2nEBF6Zhk9wMArU1Muo9rBNb+yYhlaUzkOhKknc8QJZ4ELqsmdGBMXWvwTL87wHa3OamWA==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr21909447wrs.318.1544103007242;
        Thu, 06 Dec 2018 05:30:07 -0800 (PST)
Received: from [192.168.0.40] (172.220.136.77.rev.sfr.net. [77.136.220.172])
        by smtp.googlemail.com with ESMTPSA id c9sm1406802wmh.27.2018.12.06.05.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 05:30:06 -0800 (PST)
Subject: Re: [PATCH] thermal: stm32: Fix stm_thermal_read_factory_settings
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ecfc241e-7453-36dd-70ba-34b0f2e69dc8@linaro.org>
Date:   Thu, 6 Dec 2018 14:30:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 14:23, David HERNANDEZ SANCHEZ wrote:
> Adding brackets allows to multiply the register value,
> masked by TS1_RAMP_COEFF_MASK, by an ADJUST value
> properly and not to multiply ADJUST by register value and
> then mask the whole.
> 
> Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
> Fixes: 1d693155 ("thermal: add stm32 thermal driver")

Usually 'Fixes' comes first in the list.

Other than that:

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index daa1257..bbd73c5 100644
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
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

