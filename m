Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28891C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB79121479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5siaQNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB79121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbeKUXZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:25:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33388 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbeKUXZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:25:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id u9-v6so5588029wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 04:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rhFsEeOgeCjEhE6X9BoiZMxIWHOhMf7hfkfvzGQNMh0=;
        b=H5siaQNdTYAcHr5HOp9va8xhXDXuBmkkENm3gdbdwJlWSodLsXTr1UBzQpW+ceo3ke
         M5sqxPWdFUqYdp2rshWdLYcbZch7ZjMH53/STbUllhzFzkHklQuWmyaj0hV0heVGbmHU
         8czqWjIPb5UEm6dIPgNFN95rLCrbnT5i+ns+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rhFsEeOgeCjEhE6X9BoiZMxIWHOhMf7hfkfvzGQNMh0=;
        b=LapQo4tX6J2O0APS3cta5HzqVg4imux7zBpNqv7LOJGhX7T+TfjRIfoS3VrHGMOrUL
         6oj1DaF9NlLBO6Y6Dov2Pi8TibUdDrYvRZlGUorLStp2wXU1waPTpzlMFGQz9fRhQIAt
         fesjovGRZT5ms/6fbsGljs/Ftye16PKMQ5lM5K0BOy+UutClkViJyw+qWecNinYU/N7G
         Bf5nv/JqlATwehhxmrZbsMIATieoAXWbyA8mO71H02FFIflsFMoGZknhz08e8FBhJ9bN
         fp38byxiaS1JHqV2vS/i+PZ5DQdxxFZhQ/r5TzsB9wqL/4/y7Xp8OdGWAUQxztxBqj72
         hsvg==
X-Gm-Message-State: AA+aEWZt7swKXUgJ38kRP75lZWNy7wWZVrEdVoW7Jt/DrIZ26Q48K4sz
        LlBTCevJb4azmLx2ecK9PdDWYYXY/ls=
X-Google-Smtp-Source: AFSGD/XeGhVoV4NvfSrrgnGROwBsg2hOl02VA+PNq7nzU8bF4VhVi9Ch/ptqEi+FrJKCxYhEah+umg==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr5501780wrq.69.1542804680219;
        Wed, 21 Nov 2018 04:51:20 -0800 (PST)
Received: from [192.168.0.40] (239.22.136.77.rev.sfr.net. [77.136.22.239])
        by smtp.googlemail.com with ESMTPSA id 21-v6sm1375594wmv.5.2018.11.21.04.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 04:51:19 -0800 (PST)
Subject: Re: [PATCH v2 1/3] thermal: tegra: continue if sensor register fails
To:     Wei Ni <wni@nvidia.com>, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        linux-kernel@vger.kernel.org
References: <1542103567-5521-1-git-send-email-wni@nvidia.com>
 <1542103567-5521-2-git-send-email-wni@nvidia.com>
 <d212af68-fd18-74d4-d81c-ed8b3c0f136a@linaro.org>
 <70f08208-d04c-c9a4-07e6-d377c33a9386@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d77fe117-3cde-108f-e1d7-2871f3d4c485@linaro.org>
Date:   Wed, 21 Nov 2018 13:51:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <70f08208-d04c-c9a4-07e6-d377c33a9386@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 11:23, Wei Ni wrote:
> 
> 
> On 21/11/2018 4:55 PM, Daniel Lezcano wrote:
>> On 13/11/2018 11:06, Wei Ni wrote:
>>> Don't bail when a sensor fails to register with the
>>> thermal zone and allow other sensors to register.
>>> This allows other sensors to register with thermal
>>> framework even if one sensor fails registration.
>>
>> I'm not sure if ignoring the error is really safe. Can you describe the
>> real situation you want to overcome ? How do you differentiate critical
>> sensors ?
> 
> The driver will always try to register 4 thermal zones, including cpu,
> gpu, mem and pll, but if the dts file doesn't set the corresponding
> sensors, then the register will be failed.
> Normally, the dts file will set all 4 sensors, but there may have some
> platform doesn't support them all. So we post this patch.

Ignoring errors is not the way to go to support different platforms. Fix
the DT.


> BTW, what do you mean "critical sensors"? We will set critical trip temp
> for all sensors.

I meant sensor for thermal zone getting really high temperature.


>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>> ---
>>>  drivers/thermal/tegra/soctherm.c | 8 +++++---
>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>>> index ed28110a3535..a824d2e63af3 100644
>>> --- a/drivers/thermal/tegra/soctherm.c
>>> +++ b/drivers/thermal/tegra/soctherm.c
>>> @@ -1370,9 +1370,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>>>  							 &tegra_of_thermal_ops);
>>>  		if (IS_ERR(z)) {
>>>  			err = PTR_ERR(z);
>>> -			dev_err(&pdev->dev, "failed to register sensor: %d\n",
>>> -				err);
>>> -			goto disable_clocks;
>>> +			dev_warn(&pdev->dev, "failed to register sensor %s: %d\n",
>>> +				 soc->ttgs[i]->name, err);
>>> +			continue;
>>>  		}
>>>  
>>>  		zone->tz = z;
>>> @@ -1434,6 +1434,8 @@ static int __maybe_unused soctherm_resume(struct device *dev)
>>>  		struct thermal_zone_device *tz;
>>>  
>>>  		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
>>> +		if (!tz)
>>> +			continue;
>>>  		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
>>>  		if (err) {
>>>  			dev_err(&pdev->dev,
>>>
>>
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

