Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDA0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA9320684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpx1jEuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA9320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395204AbeKVXqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:46:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38995 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731818AbeKVXqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:46:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so9083856wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0OrZMP0wVJU5/gmiIrkRGn6BTqPi8LtbJG/iIHEr1/U=;
        b=bpx1jEuVEl0ikS56rSmzE9nXWSXD1dDRhK2u82mDv/Y9+hbAugHDajXOlBHviJdryQ
         wC+n7bS6LUJ6CKieNwFy48MY4gaNTPTZZE0Idj/hD1VL/fjyj/f0jFLqMdpI9008xGW0
         3tONOAIgfbCIe2yxYz6fQeg8xTz3unL574+z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0OrZMP0wVJU5/gmiIrkRGn6BTqPi8LtbJG/iIHEr1/U=;
        b=oWRpiC0HJ9Mw8NFBHXzaZcdk4OAhd68n4zliTwJ4LSEpyF0pwUkZEhSfjPlQ2WWiSg
         igIT6DLD7DYDR934ETMzseoDZ6EDRxDmPeZq38SGMXC4jToeSvOhWge4KTPLzah/vhU5
         RUZnyamCDymgsBAiXTMfqiiP5NaS1YZ/N02aiGxzHmTETc49YHZIuySQZnusDY8rND1Y
         JkTrWx+1n8lNgUIxRIa295hMpRVWM9GRgbC/8hTxklMmQHGFc+SLuq7r0wO/kxTmV89Y
         Nf+IRjGeCrYrHWzd2QuLJ+5GegXC5sHnB4ThpWfI756UsnUG2H25C985CIq9NIL/Kr/l
         LpGA==
X-Gm-Message-State: AA+aEWaRo0Ti3sCVx1qb8roUgmX6hOamGQGdQbJskX9J7InL5yCoFNeC
        vlwXX1iIF+ng6+spe4KDneEJops8Vyo=
X-Google-Smtp-Source: AJdET5cAZ7tU34CNlbOfy28KMuW8r4bMISRNnV+Gyvqd9ZCyxSLhsUeB02uQWLp+0mHrgOnqQJzDBg==
X-Received: by 2002:a1c:950f:: with SMTP id x15-v6mr9925800wmd.3.1542892053712;
        Thu, 22 Nov 2018 05:07:33 -0800 (PST)
Received: from [192.168.0.40] (189.35.136.77.rev.sfr.net. [77.136.35.189])
        by smtp.googlemail.com with ESMTPSA id b13sm21976138wrn.28.2018.11.22.05.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:07:32 -0800 (PST)
Subject: Re: [PATCH v2 1/3] thermal: tegra: continue if sensor register fails
To:     Wei Ni <wni@nvidia.com>, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        linux-kernel@vger.kernel.org
References: <1542103567-5521-1-git-send-email-wni@nvidia.com>
 <1542103567-5521-2-git-send-email-wni@nvidia.com>
 <d212af68-fd18-74d4-d81c-ed8b3c0f136a@linaro.org>
 <70f08208-d04c-c9a4-07e6-d377c33a9386@nvidia.com>
 <d77fe117-3cde-108f-e1d7-2871f3d4c485@linaro.org>
 <5e09bc13-7880-40f2-3f90-01d2cc3510ba@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <299fc8a0-39e4-1bd9-821b-4712a7f25028@linaro.org>
Date:   Thu, 22 Nov 2018 14:07:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5e09bc13-7880-40f2-3f90-01d2cc3510ba@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 08:10, Wei Ni wrote:
> 
> 
> On 21/11/2018 8:51 PM, Daniel Lezcano wrote:
>> On 21/11/2018 11:23, Wei Ni wrote:
>>>
>>>
>>> On 21/11/2018 4:55 PM, Daniel Lezcano wrote:
>>>> On 13/11/2018 11:06, Wei Ni wrote:
>>>>> Don't bail when a sensor fails to register with the
>>>>> thermal zone and allow other sensors to register.
>>>>> This allows other sensors to register with thermal
>>>>> framework even if one sensor fails registration.
>>>>
>>>> I'm not sure if ignoring the error is really safe. Can you describe the
>>>> real situation you want to overcome ? How do you differentiate critical
>>>> sensors ?
>>>
>>> The driver will always try to register 4 thermal zones, including cpu,
>>> gpu, mem and pll, but if the dts file doesn't set the corresponding
>>> sensors, then the register will be failed.
>>> Normally, the dts file will set all 4 sensors, but there may have some
>>> platform doesn't support them all. So we post this patch.
>>
>> Ignoring errors is not the way to go to support different platforms. Fix
>> the DT.
> 
> The issue isn't in DT file. The Tegra soc thermal include 4 sensors:
> cpu, gpu, mem, pll. But in some platforms, for example, we may only need
> to support 2 sensors, such as cpu and gpu, so we only configure these
> two senors in DT file. But the driver will always try to register 4
> sensors, cpu/gpu/mem/pll, so mem and pll will be registered failed. So
> in this case we need to ignoring the failure, and continue to enable the
> driver.

You can fix this by changing the driver to support the platform and
register the sensor you are interested in.

Ignoring errors is not a good idea.


>>> BTW, what do you mean "critical sensors"? We will set critical trip temp
>>> for all sensors.
>>
>> I meant sensor for thermal zone getting really high temperature.
> 
> We doesn't have the critical sensors. We set the critical trip temp for
> all registered sensors. And these trip temp is set to the Tegra
> hardware. So it mean if the temperature reached the critical trip point,
> then the system will be shutdown directly.
> 
>>
>>
>>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>>>> ---
>>>>>  drivers/thermal/tegra/soctherm.c | 8 +++++---
>>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>>>>> index ed28110a3535..a824d2e63af3 100644
>>>>> --- a/drivers/thermal/tegra/soctherm.c
>>>>> +++ b/drivers/thermal/tegra/soctherm.c
>>>>> @@ -1370,9 +1370,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>>>>>  							 &tegra_of_thermal_ops);
>>>>>  		if (IS_ERR(z)) {
>>>>>  			err = PTR_ERR(z);
>>>>> -			dev_err(&pdev->dev, "failed to register sensor: %d\n",
>>>>> -				err);
>>>>> -			goto disable_clocks;
>>>>> +			dev_warn(&pdev->dev, "failed to register sensor %s: %d\n",
>>>>> +				 soc->ttgs[i]->name, err);
>>>>> +			continue;
>>>>>  		}
>>>>>  
>>>>>  		zone->tz = z;
>>>>> @@ -1434,6 +1434,8 @@ static int __maybe_unused soctherm_resume(struct device *dev)
>>>>>  		struct thermal_zone_device *tz;
>>>>>  
>>>>>  		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
>>>>> +		if (!tz)
>>>>> +			continue;
>>>>>  		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
>>>>>  		if (err) {
>>>>>  			dev_err(&pdev->dev,
>>>>>
>>>>
>>>>
>>
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

