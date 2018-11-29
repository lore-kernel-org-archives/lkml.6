Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F21C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209D921104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIWAcqiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209D921104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeK3Fes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:34:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41849 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbeK3Fes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:34:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so2889945wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X/oAfxVh33z/9f0TA7f+7Si/guQ97abxNA8LBq6hbZs=;
        b=MIWAcqiBfBm2Ur47/GYn9qo223rJBI8kj6F8YU4xbqeWEpERxnFjJuC/bA7/IXfXFR
         c9BCZFM3C8PHzEO2bqJgCx5o8oSrd1wqz3BmErYXkHRG2bEOi80T24p5oEE5kCZ3iorZ
         +IMEyNUu27HYcJdLTFXzEzjQjE+DimCn/GZps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X/oAfxVh33z/9f0TA7f+7Si/guQ97abxNA8LBq6hbZs=;
        b=mUutmAuTHK58o5whg2tXrvfbr2DQ74OJoMlTH1G2KaFwQMn7Ok8tyauZFpuhxrpQAu
         qbr4aH9iHrR+bZIvHjBkww0OQg7yNUeCOfyYlqyMtgEUi8yfEFet9PPsISgVWuSUre3u
         m7eWNltLC7lZR3ARbk10dyOMXpdeuhITrFFUjdrdqGUZ4HxtHe+q6gRWzODCdFcb4BVH
         dJ5T50fm+pwJK8exW4U45EuC2n4ICEjg+nm6HTygPiceOlAj2Snuc3zMlHbnB0jtIX7I
         1TPb+qvLUafJZ6diyPD8D1eV3BvRGxTx6G+HEG9JK3M0a1+6nrb93g7Ycp1waDOtdinH
         e6NQ==
X-Gm-Message-State: AA+aEWbnB0G/ciZzs1+pCTmYKnPfwNmjjqN26c44lmTylPOh647ZC+Ee
        PTuvmgsprQxG5UZdsumpm6Nrl6eN0No=
X-Google-Smtp-Source: AFSGD/URTlGPQOLqzYCLV+S/RcI1knJeBrHHA0cpXxzV2bJCLtmijXl09FOfpZcK3Ws4ronJ7nJkWg==
X-Received: by 2002:adf:a14d:: with SMTP id r13mr2273075wrr.169.1543516109875;
        Thu, 29 Nov 2018 10:28:29 -0800 (PST)
Received: from [192.168.0.40] (183.250.136.77.rev.sfr.net. [77.136.250.183])
        by smtp.googlemail.com with ESMTPSA id v5sm2824610wrn.71.2018.11.29.10.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 10:28:29 -0800 (PST)
Subject: Re: [PATCH] thermal/drivers/hisi: Fix bad initialization
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     vincent.guittot@linaro.org, john.stultz@linaro.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1543516016-28186-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <835c09ee-17e1-cfdb-842b-f5f2d977689a@linaro.org>
Date:   Thu, 29 Nov 2018 19:28:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543516016-28186-1-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry typo in Vincent's email address, fixed now.

On 29/11/2018 19:26, Daniel Lezcano wrote:
> Without this patch, the thermal driver on hi6220 and hi3660 is broken.
> 
> That is due because part of the posted patchset was merged but a small
> change in the DT was dropped.
> 
> The hi6220 and hi3660 do not have an interrupt name in the DT, so
> finding interrupt by name fails.
> 
> In addition, the hi3660 only defines one thermal zone in the DT and we
> are trying to register two sensors assuming we have two thermal zones
> in the DT.
> 
> Fix this by adding a couple of line of code to add back compatibility
> with older DT and change the sensors number to 1 for the hi3660.
> 
> Fixes: 2cffaeff083f (thermal/drivers/hisi: Use platform_get_irq_byname)
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/hisi_thermal.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index c4111a9..3ab0e63 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -424,7 +424,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
>  	struct platform_device *pdev = data->pdev;
>  	struct device *dev = &pdev->dev;
>  
> -	data->nr_sensors = 2;
> +	data->nr_sensors = 1;
>  
>  	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
>  				    data->nr_sensors, GFP_KERNEL);
> @@ -590,8 +590,13 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  		}
>  
>  		ret = platform_get_irq_byname(pdev, sensor->irq_name);
> -		if (ret < 0)
> -			return ret;
> +		if (ret <= 0) {
> +			ret = platform_get_irq(pdev, 0);
> +			if (ret <=  0) {
> +				dev_err(dev, "Failed get interrupt: %d\n", ret);
> +				return ret;
> +			}
> +		}
>  
>  		ret = devm_request_threaded_irq(dev, ret, NULL,
>  						hisi_thermal_alarm_irq_thread,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

