Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BBEC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A85521479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDM3sH59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A85521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeKUT3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:29:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45654 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbeKUT3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:29:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so4735836wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 00:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EkFpHvmJTEH1SGepR89qPfyza4Zrj2hXAHc4N1tJVEE=;
        b=dDM3sH59L9ygJvOE3lUVWfLocAn36ewYygEGWouJ3dQJEVH7qehs037X8bHDbUN2Z/
         3TThihWxtsOqiAj+wO55kPLm8QU+gL25Rhyx0NxJLUBIZ+uEMUEfFGUEBrrV60DtRfT6
         mlA8IkDrLCOiVBH9o0fZbQcWCkNg2R3fvWkf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EkFpHvmJTEH1SGepR89qPfyza4Zrj2hXAHc4N1tJVEE=;
        b=WWRevZkzvmi23uATDUo4kwUIfLoBYbEp5mbTPARPhESorD6qu/WXohtG3eq0SywC1/
         4UeNV0SjtCAGTL4X2sfBDMiV+bIB6iRx6Inv+oak5nuDpBkUuin7cA0i6wqL696PA3Iw
         e7hW7EzQf9bcLWIlzH/VqQX2PNWzZTaSjmbwd8tbfEVmHmh/ayNj3Squwuq/446bsKdu
         zegk4yIOdgHtEG7SsaHGstI5v37DIneTEU//cyoC5XPXVETmaQSm4wlrBkRxSRwe040h
         7wcCW3eRBMkmRCVPT9F76OXJ1O8WODR47IsPIxfZ7B50aCSjncFnR+/BDzuF/XONgiFA
         Y3Rw==
X-Gm-Message-State: AA+aEWZWSU2u3Cacl1l1QkCFpmaOhWOBykxGEVj3QY0utlxKvTKFzwJw
        KldTtRaVjDRy9KGF2eJzhYLyT1PFsFM=
X-Google-Smtp-Source: AFSGD/XatnA7ULp+nCkvN7BOSEcaSpSMYjcAvQCdFWm1ppZ9XEontRyqf2kk5YM1eWuEh+f3T81VpA==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr4692167wrr.74.1542790536310;
        Wed, 21 Nov 2018 00:55:36 -0800 (PST)
Received: from [192.168.0.40] (239.22.136.77.rev.sfr.net. [77.136.22.239])
        by smtp.googlemail.com with ESMTPSA id w8sm10573190wrv.7.2018.11.21.00.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 00:55:35 -0800 (PST)
Subject: Re: [PATCH v2 1/3] thermal: tegra: continue if sensor register fails
To:     Wei Ni <wni@nvidia.com>, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        linux-kernel@vger.kernel.org
References: <1542103567-5521-1-git-send-email-wni@nvidia.com>
 <1542103567-5521-2-git-send-email-wni@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d212af68-fd18-74d4-d81c-ed8b3c0f136a@linaro.org>
Date:   Wed, 21 Nov 2018 09:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542103567-5521-2-git-send-email-wni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2018 11:06, Wei Ni wrote:
> Don't bail when a sensor fails to register with the
> thermal zone and allow other sensors to register.
> This allows other sensors to register with thermal
> framework even if one sensor fails registration.

I'm not sure if ignoring the error is really safe. Can you describe the
real situation you want to overcome ? How do you differentiate critical
sensors ?

> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index ed28110a3535..a824d2e63af3 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -1370,9 +1370,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>  							 &tegra_of_thermal_ops);
>  		if (IS_ERR(z)) {
>  			err = PTR_ERR(z);
> -			dev_err(&pdev->dev, "failed to register sensor: %d\n",
> -				err);
> -			goto disable_clocks;
> +			dev_warn(&pdev->dev, "failed to register sensor %s: %d\n",
> +				 soc->ttgs[i]->name, err);
> +			continue;
>  		}
>  
>  		zone->tz = z;
> @@ -1434,6 +1434,8 @@ static int __maybe_unused soctherm_resume(struct device *dev)
>  		struct thermal_zone_device *tz;
>  
>  		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
> +		if (!tz)
> +			continue;
>  		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
>  		if (err) {
>  			dev_err(&pdev->dev,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

