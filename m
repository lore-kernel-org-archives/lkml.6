Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9C2C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8203020671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YS3E9kFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8203020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeKTT6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:58:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41161 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbeKTT6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:58:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so1146849wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 01:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UpNGH7GHkRg/ZIvySw2YWx4ejA8+bu58IP9ac2NzE+Y=;
        b=YS3E9kFalM1BxlPstkDrebmEnoDv2da491e7J01LywPAubQMw826Es4m7gyiA81Avz
         vQ7GUer9Ox/lhldQS2Csz10bsh/m7o08enpcqAw1QkvKobe/a7IltNi5ktaTevVcnWcy
         CLpuHzwvyc+ERupgRn66kcfgZ6zA1ce0HTQ4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UpNGH7GHkRg/ZIvySw2YWx4ejA8+bu58IP9ac2NzE+Y=;
        b=N/bhoegrsJqwYYdz0UM6biCbkMr4twiVi9KMovV+eFxFPtF6+iksMbsz4Wdf1sFuu6
         oyZ048fmLR+J8ilID82xOECNc0if1CV+OXAMMkIqp/dSLDQ/kvzcNRI6/N6EmAVIzyAg
         /8zuT6hEVkMnCIyEpe/b5HVwr124lxm7v4skirb0wqRCt3W5v+0D444mClUYnT64dGIG
         XjPlqYoqEFWtlsrOcXfuqV8oedjbh5s/nT4HoO5pl63CehRFphLSCrznhtkKR+1CY8mz
         blBjuJHbzisHSeWjy/UUP0BwoproPa2ZAK3zXZPc0W5yLVvS0nfld++pKvGgEGWbHphu
         atPQ==
X-Gm-Message-State: AA+aEWZZGLvYVwVvW9Kv3wVpiaDrZilwRkRaaReiCxVYOmkE2Uf8T3NV
        e47dANVEvqn5KX3BxrYjYZQ1ZA==
X-Google-Smtp-Source: AFSGD/XTavd7KFvCDQMt5No8xYV2iyc37kbzwlugv+Z+0SaFHOljTFK2rv1szD2o/bp1ZuN/bCztGw==
X-Received: by 2002:adf:8342:: with SMTP id 60mr1172473wrd.212.1542706192754;
        Tue, 20 Nov 2018 01:29:52 -0800 (PST)
Received: from [192.168.0.40] (98.242.136.77.rev.sfr.net. [77.136.242.98])
        by smtp.googlemail.com with ESMTPSA id c188-v6sm28491063wma.39.2018.11.20.01.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 01:29:52 -0800 (PST)
Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
 <28d501b1-8016-cc1a-3f7c-ac485ab81aa2@linaro.org>
 <DB3PR0402MB391662A8DA6A1F43F26F095BF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <e4cf8bad-9a4f-32e5-2f0e-be44257b5fe2@linaro.org>
 <DB3PR0402MB391604AB207C160F09D3595EF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <93eff9f1-922f-f5c1-9a88-debacdd68168@linaro.org>
Date:   Tue, 20 Nov 2018 10:29:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB391604AB207C160F09D3595EF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 09:58, Anson Huang wrote:
> Hi, Daniel
> 
> Best Regards!
> Anson Huang
> 
>> -----Original Message-----
>> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
>> Sent: 2018年11月20日 16:54
>> To: Anson Huang <anson.huang@nxp.com>; rui.zhang@intel.com;
>> edubezval@gmail.com; linux-pm@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Cc: dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
>>
>> On 20/11/2018 09:47, Anson Huang wrote:
>>> Hi, Daniel
>>>
>>> Best Regards!
>>> Anson Huang
>>>
>>>> -----Original Message-----
>>>> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
>>>> Sent: 2018年11月20日 16:45
>>>> To: Anson Huang <anson.huang@nxp.com>; rui.zhang@intel.com;
>>>> edubezval@gmail.com; linux-pm@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org
>>>> Cc: dl-linux-imx <linux-imx@nxp.com>
>>>> Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
>>>>
>>>> On 24/10/2018 08:39, Anson Huang wrote:
>>>>> The thermal driver is a standalone driver for monitoring SoC
>>>>> temperature by enabling thermal sensor, so it can be enabled even
>>>>> when CONFIG_CPU_FREQ is NOT set. So remove the dependency with
>>>> CPU_THERMAL.
>>>>>
>>>>> Add CONFIG_CPU_FREQ check for cpu-freq related operation in thermal
>>>>> driver to make thermal driver probe successfully when
>>>>> CONFIG_CPU_FREQ is NOT set.
>>>>>
>>>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>>>> ---
>>>>
>>>> Why not simply kill this legacy code ?
>>>
>>> Because killing legacy code will have old dtb compatible issue, old
>>> dtb will NOT have cpufreq cooling function.
>>
>> Yeah, I imagine that is the reason why you want to keep the legacy code but do
>> you really care about old DTB based boards? Are they still updated with newer
>> *upstream vanilla* kernels?
> 
> I am NOT sure if there is someone care about it, but I did receive many comments
> about old dtb compatible when I sent out other patches, so is it a solid requirement
> of old dtb compatible when doing upstream, or each sub-system or maintainer has
> different requirement about it? Actually I am happy to just remove the legacy
> code, because it makes the code more clean and easy reading. Who can make the
> decision?

Yes, making sure to not break the compatibility makes the patch
submission easier. However, sometime it makes sense to put in question
if keeping old (and hackish) code really matters.

Old boards are rarely updated with newer kernels and when that happens,
usually the DT is updated also.

IMO, this decision is in the hands of the platform maintainers. I
suggest to send a patch removing the legacy code Cc'ing all of them.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

