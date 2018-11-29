Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4365BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A552145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HELAlxjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A552145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeK3Iux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:50:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35204 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeK3Iux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:50:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so3746664wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uh6N5MgqZmpWD/cvej21FM+dBi4JoLOUCY/uIZvVvFQ=;
        b=HELAlxjfeRWaQkKp2Yp66omA2Tu1JJ1fw8/Ms6Mvp+tQ/oRcBQp+95vv11NwhP7oov
         3FIug9WDh3Fntrw8QF7kLeKXW4f5SZsXVp8gIMqaxD9jaTU3/LajtTfoKyQ8QkdpKGNW
         I4CGXYukJ/HrYm+h4ToZM4u3MpY/a2W+AvjP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uh6N5MgqZmpWD/cvej21FM+dBi4JoLOUCY/uIZvVvFQ=;
        b=fVpF8EtiMjdcV1RUHfx+TuZ35fM7b31W5h3qi2YfiYdJU/cbK+eHFLdTHO8k7rPbNf
         huENG9WCEWib7Zp0ZT3ce3SICipCc7YCowtgSK4/dXkDLVgba7OfsMgYPtQPZtOgcB6C
         03pHyyyJ4egdcmH8Cg/gD5pbWA1fpzyP9Odu3vw6iXhoa+Xi1xaAJsEaUMnRl7NFP9Mr
         467FpEPg76Wj+HpIs7qcu1EwVco8zqyuix1AXS99xL8EIafFmMHu100Deuf8qxvEpgFL
         4qD7u5ILFA3YXgOp7ef+Uag65QaeBlhfIJLE1NJ9+ZZich+v49De99slmWwDt+itpDsT
         /dUA==
X-Gm-Message-State: AA+aEWYHiof73S76GgoEYD2BOI7wqYcpOPR5wKmLKBE2z1FUiHPBz5HQ
        0w/v1zkTLtaI+STMIHmJwYd2HQ==
X-Google-Smtp-Source: AFSGD/VJ2xvFRaxShC9yq86lVVCiOLzm7XE9Iit5zxYzwfcbtXQfklmqgECQbITOiKE5lvJxYKwPyQ==
X-Received: by 2002:a1c:cf0d:: with SMTP id f13mr3092495wmg.70.1543527840564;
        Thu, 29 Nov 2018 13:44:00 -0800 (PST)
Received: from [192.168.0.40] (118.142.136.77.rev.sfr.net. [77.136.142.118])
        by smtp.googlemail.com with ESMTPSA id p74sm5386139wmd.29.2018.11.29.13.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:43:59 -0800 (PST)
Subject: Re: [PATCH] thermal/drivers/hisi: Fix bad initialization
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     rui.zhang@intel.com, vincent.guittot@linaro.org,
        john.stultz@linaro.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1543516016-28186-1-git-send-email-daniel.lezcano@linaro.org>
 <20181129193658.GA6844@localhost.localdomain>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4f3b1c28-5a5f-8f0a-aa5f-321ab557ce44@linaro.org>
Date:   Thu, 29 Nov 2018 22:43:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129193658.GA6844@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 20:36, Eduardo Valentin wrote:
> On Thu, Nov 29, 2018 at 07:26:56PM +0100, Daniel Lezcano wrote:
>> Without this patch, the thermal driver on hi6220 and hi3660 is broken.
>>
>> That is due because part of the posted patchset was merged but a small
>> change in the DT was dropped.
>>
>> The hi6220 and hi3660 do not have an interrupt name in the DT, so
>> finding interrupt by name fails.
>>
>> In addition, the hi3660 only defines one thermal zone in the DT and we
>> are trying to register two sensors assuming we have two thermal zones
>> in the DT.
>>
>> Fix this by adding a couple of line of code to add back compatibility
>> with older DT and change the sensors number to 1 for the hi3660.
> 
> Is this a case of adding dt versioning for those nodes?

I'm not sure how to do that, can you point me to some code ?

>> Fixes: 2cffaeff083f (thermal/drivers/hisi: Use platform_get_irq_byname)
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/hisi_thermal.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
>> index c4111a9..3ab0e63 100644
>> --- a/drivers/thermal/hisi_thermal.c
>> +++ b/drivers/thermal/hisi_thermal.c
>> @@ -424,7 +424,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
>>  	struct platform_device *pdev = data->pdev;
>>  	struct device *dev = &pdev->dev;
>>  
>> -	data->nr_sensors = 2;
>> +	data->nr_sensors = 1;
> 
> For bisectability (heh.. is that even a word?), would you please send
> one fix per patch?

I thought it was preferable to fix both into a single patch but if you
prefer two different patches, no problem.

>>  
>>  	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
>>  				    data->nr_sensors, GFP_KERNEL);
>> @@ -590,8 +590,13 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>>  		}
>>  
>>  		ret = platform_get_irq_byname(pdev, sensor->irq_name);
>> -		if (ret < 0)
>> -			return ret;
>> +		if (ret <= 0) {
> 
> Maybe a simple <  is enough? reading it seams awkward. From a glance, I
> dont think platform_get_irq* ever returns 0.
> 
>> +			ret = platform_get_irq(pdev, 0);
>> +			if (ret <=  0) {
> 
> Same here.

Actually, I'm not sure. of_irq_parse_and_map can return zero and it is
an error. Concerning platform_get_irq() I don't know, the last line is:

	return r ? r->start : -ENXIO;

Can 'start' be zero there?

The usage is also unclear:

git grep -C 1 platform_get_irq drivers/

drivers/ata/libahci_platform.c: irq = platform_get_irq(pdev, 0);
drivers/ata/libahci_platform.c- if (irq <= 0) {
--
drivers/ata/pata_arasan_cf.c-   /* if irq is 0, support only PIO */
drivers/ata/pata_arasan_cf.c:   acdev->irq = platform_get_irq(pdev, 0);
drivers/ata/pata_arasan_cf.c-   if (acdev->irq)
[...]

drivers/ata/pata_rb532_cf.c-
drivers/ata/pata_rb532_cf.c:    irq = platform_get_irq(pdev, 0);
drivers/ata/pata_rb532_cf.c-    if (irq <= 0) {
--
drivers/ata/sata_highbank.c-
drivers/ata/sata_highbank.c:    irq = platform_get_irq(pdev, 0);
drivers/ata/sata_highbank.c-    if (irq <= 0) {
--
drivers/base/platform.c:        while ((ret = platform_get_irq(dev, nr))
>= 0)
drivers/base/platform.c-                nr++;
--
drivers/char/hw_random/imx-rngc.c-
drivers/char/hw_random/imx-rngc.c:      irq = platform_get_irq(pdev, 0);
drivers/char/hw_random/imx-rngc.c-      if (irq <= 0) {
--
drivers/char/hw_random/omap-rng.c-
of_device_is_compatible(dev->of_node, "inside-secure,safexcel-eip76")) {
drivers/char/hw_random/omap-rng.c:              irq =
platform_get_irq(pdev, 0);
drivers/char/hw_random/omap-rng.c-              if (irq < 0) {

etc...

So in some places, if irq <= 0 (sata_highbank.c) it is considered an
error, if irq is different from zero it is correct (pata_arasan_cf.c)
and if it is >= 0 it is also correct (platform.c)

May be Linus can clarify ? (added in Cc)


>> +				dev_err(dev, "Failed get interrupt: %d\n", ret);
>> +				return ret;
>> +			}
>> +		}
>>  
>>  		ret = devm_request_threaded_irq(dev, ret, NULL,
>>  						hisi_thermal_alarm_irq_thread,
>> -- 
>> 2.7.4
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

