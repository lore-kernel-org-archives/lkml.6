Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6370CC00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A02F2089D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiHojB9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A02F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeJGTXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 15:23:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33092 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeJGTXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 15:23:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id e4-v6so17872550wrs.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 05:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UgFweVgnCUbXwns5CNhZGMBVwvIV/pOqWXpg6lA1Gw8=;
        b=XiHojB9v30wN2RlIyplBOcd/MApv0V+JMFo4Y2lxt4e1Ql06xNtZOUM81XVZ+MuiPd
         vCkYaj7sdPbsqmO5mRKoJN5hUbM6FXal38OgIvXD0GHqe1PT9tsPJiAdjy2J2ThyBy4D
         oLoDLkI1z66Wy4373RY3Pr/FaFaaVBPedLLsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UgFweVgnCUbXwns5CNhZGMBVwvIV/pOqWXpg6lA1Gw8=;
        b=iNNPGUtQHEpuDXXavROO3aiD0HIQpm7VFBtqt6TS5AAD25JCWB0KMJfFH99ALOkTWH
         XWMVSx7wy5icaxLr+kkCkHHHqmxKYpEVEQG9CgusvEShXDahvHWYsY+Gav6B9cZ3zHev
         hOB3F4uNDyzj1pNXLoJTQEGG4xr53Pup3Zu7XC67zp0kQYAKT2qRjbbZVYiDSsUt48Rl
         qVFRWjtfrwcGvCcMOINMDBcKK2JScHf1hydb4eF1c+wsJG4OdCIb0RQSFyYkIRDF7t/q
         vDt6re5ju402+utvDE/SB1UsoQcPwOZk+sAVHpmEW6Bsz4rX1OlrIv4rUAD+AePcO1NW
         XrPA==
X-Gm-Message-State: ABuFfogpImELK++V8XBKqQar1RCri44NjikYkVCxRxQ6Ielos5yFCFvO
        9o6wMMhYbeWWRpIblJp4kM8nH0kUXIE=
X-Google-Smtp-Source: ACcGV61k1BlgT6Erl2nM1EJdcQALhHbM05RhSYjg4VCaduP7TZjPTptrQH8FNLtp9ry9cTPN/2MZLg==
X-Received: by 2002:adf:ce10:: with SMTP id p16-v6mr12668586wrn.118.1538914579844;
        Sun, 07 Oct 2018 05:16:19 -0700 (PDT)
Received: from [192.168.0.40] (79.11.130.77.rev.sfr.net. [77.130.11.79])
        by smtp.googlemail.com with ESMTPSA id a105-v6sm32039609wrc.23.2018.10.07.05.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 05:16:19 -0700 (PDT)
Subject: Re: [PATCH 13/13] clocksource/drivers/dw_apb: Add reset control
To:     Marek Vasut <marex@denx.de>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
 <1538750143-4282-13-git-send-email-daniel.lezcano@linaro.org>
 <alpine.DEB.2.21.1810061433170.5454@nanos.tec.linutronix.de>
 <5ebc1d90-2067-8cb5-0c93-1c9f0677abc5@linaro.org>
 <alpine.DEB.2.21.1810061907030.5454@nanos.tec.linutronix.de>
 <d27e6960-5f59-4a81-09c2-8606f0bce344@denx.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a70866b1-cf62-ea03-e389-e08906e8580a@linaro.org>
Date:   Sun, 7 Oct 2018 14:16:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d27e6960-5f59-4a81-09c2-8606f0bce344@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 14:10, Marek Vasut wrote:
> On 10/06/2018 07:07 PM, Thomas Gleixner wrote:
>> On Sat, 6 Oct 2018, Daniel Lezcano wrote:
>>
>>> On 06/10/2018 14:34, Thomas Gleixner wrote:
>>>> On Fri, 5 Oct 2018, Daniel Lezcano wrote:
>>>>
>>>>> From: Dinh Nguyen <dinguyen@kernel.org>
>>>>>
>>>>> Add code to retrieve the reset property from the dw-apb timers and if
>>>>> the property is available, the safe operation is to assert the timer
>>>>> into reset, and followed by a deassert of the timer reset (brings the
>>>>> timer out of reset).
>>>>>
>>>>> This patch is needed for systems where the bootloader has left the timer
>>>>> not used in reset.
>>>>>
>>>>>  - Trivial conflict with commit a74bd1ad7a:
>>>>>     "Convert to using %pOFn instead of device_node.name"
>>>>>
>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>>>>
>>>> Ingo just noticed, that this SOB chain is wrong. How is Marek involved
>>>> here? Can you please fix that up and send me another pull request?
>>>
>>> Thomas,
>>>
>>> I will fix it as soon as possible but I would like to give the
>>> opportunity to Dinh to explain why he sent the patch with Marek's SOB.
>>>
>>> Dinh ?
>>
>> No rush.
> 
> I reported this to Dinh and gave him some prototype patches to start
> with, since I didn't have the time to write a patch. You can change it
> to Reported-by: if you want.

Ok, thanks


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

