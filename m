Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F91C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A586E214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDukd2yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A586E214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeIZOQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:16:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33340 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZOQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:16:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id r1-v6so14486609wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ONWisPtFURwS+Dv/RY9Ijg+ZXudgqyV5XWp/wD93EE4=;
        b=KDukd2ySxu3ajHjovgrOo8VKtSSAwHEUxFESObdGL6Gp9oEw5g8aXWSVu3aHB3ar5a
         4GrQte6urNaoeZ4/7RB2JAyflTfF8kZHR/ksDpGVqNXl0nfznGnNOAYQN8YnCX84ROiO
         c14ErtmL52sfmrXmUbmK39VwmE55Rr07MRCSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ONWisPtFURwS+Dv/RY9Ijg+ZXudgqyV5XWp/wD93EE4=;
        b=k10ulA6Kq6rc9qrLFk3316x2ENKCrktlzAqQhCSXxoTHh2puF9uLKPngimUlZNofBJ
         8OWGpYRDXkJnRfhr5oQrP5Tpbh5Kyjmx2MI7BR0UQmmDBesGgD71TQc83c/LSV+7QqCC
         SRG/DzFPGVHY5CoYwX8N9M84UuTxpoqyBxKYLfqY836yQ/2b4oePRwv4cXD9BUprfJSS
         m2r5ueYgkLY7RupnWDoVL+V1JJjM3jSkzfNgG7BV5Jgk690rK7/oGWPU5m7T1VigCCbX
         hfIIWqGXIxpgoENmCJrLYQ1/ohRxop4ynM6TAG6tX/rDsLIngON34Qw/8wfHQdsEaE43
         7bYA==
X-Gm-Message-State: ABuFfoj1jC7vpYQdYT/jfv8iLcW+45SLFi11RksXISMwtzJPEYpLBq6t
        HV3pSe24fC7SZx6KRhPkelDARw==
X-Google-Smtp-Source: ACcGV61YB0//qGNB5fJ37rThZMXcjhFfRTt3HGmJf+URWtGGKGr19WXg+SGonBnZo+OihsEdZHK8cw==
X-Received: by 2002:a1c:b58e:: with SMTP id e136-v6mr3234019wmf.114.1537949115637;
        Wed, 26 Sep 2018 01:05:15 -0700 (PDT)
Received: from [192.168.0.41] (42.168.88.92.rev.sfr.net. [92.88.168.42])
        by smtp.googlemail.com with ESMTPSA id k7-v6sm4468535wmf.41.2018.09.26.01.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:05:14 -0700 (PDT)
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        od@zcrc.me, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <5bab3024.1c69fb81.b6a71.9c38SMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5af26854-0752-312b-6148-3ffa9abb2570@linaro.org>
Date:   Wed, 26 Sep 2018 10:05:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5bab3024.1c69fb81.b6a71.9c38SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2018 08:01, Paul Cercueil wrote:
> 
> Le 25 sept. 2018 10:12 PM, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
>>
>> On 25/09/2018 15:38, Paul Cercueil wrote: 
>>>
>>> Le 24 sept. 2018 9:14 AM, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit : 
>>>>
>>>> On 24/09/2018 08:53, Paul Cercueil wrote: 
>>>>>
>>>>> Le 24 sept. 2018 07:58, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit : 
>>>>>>
>>>>>> On 24/09/2018 07:49, Paul Cercueil wrote: 
>>>>>>>
>>>>>>> Le 24 sept. 2018 07:35, Daniel Lezcano <daniel.lezcano@linaro.org> a 
>>>>>>> écrit : 
>>>>>>>>
>>>>>>>> On 24/09/2018 07:24, Paul Cercueil wrote: 
>>>>>>>>> Hi Daniel, 
>>>>>>>>>
>>>>>>>>> Le 24 sept. 2018 05:12, Daniel Lezcano 
>>>>>>>>> <daniel.lezcano@linaro.org> a écrit : 
>>>>>>>>>>
>>>>>>>>>> On 21/08/2018 19:16, Paul Cercueil wrote: 
>>>>>>>>>>> This driver handles the TCU (Timer Counter Unit) present on 
>>>>>>>>>>> the Ingenic JZ47xx SoCs, and provides the kernel with a 
>>>>>>>>>>> system timer, and optionally with a clocksource and a 
>>>>>>>>>>> sched_clock. 
>>>>>>>>>>>
>>>>>>>>>>> It also provides clocks and interrupt handling to client 
>>>>>>>>>>> drivers. 
>>>>>>>>>>
>>>>>>>>>> Can you provide a much more complete description of the timer 
>>>>>>>>>> in order to make my life easier for the review of this patch? 
>>>>>>>>>
>>>>>>>>> See patch [03/24], it adds a doc file that describes the 
>>>>>>>>> hardware. 
>>>>>>>>
>>>>>>>> Thanks, I went through but it is incomplete to understand what the 
>>>>>>>> timer do. I will reverse-engineer the code but it would help if you 
>>>>>>>> can give the gross approach. Why multiple channels ? mutexes and 
>>>>>>>> completion ? 
>>>>>>>
>>>>>>> Much of the complexity is because of the multi-purpose nature of the 
>>>>>>> TCU channels. Each one can be used as timer/clocksource, or PWM. 
>>>>>>>
>>>>>>> The driver starts by using channels 0 and 1 as system timer and 
>>>>>>> clocksource, respectively, the other ones being unused for now. Then, 
>>>>>>> *if* the PWM driver requests one of the channels in use by the 
>>>>>>> timer/clocksource driver, say channel 0, the timer/clocksource driver 
>>>>>>> will dynamically reassign the system timer to a free channel, from 
>>>>>>> channel 0 to e.g. channel 2. Only in that case the completion/mutex 
>>>>>>> are actually used. 
>>>>>>
>>>>>> Why do you need to do this? Can't be the channels dedicated and reserved 
>>>>>> for clocksource and clockevent? 
>>>>>
>>>>> That's what I had in place (ingenic,timer-channel and ingenic,clocksource-channel DT properties), but Rob didn't want any linux-specific properties in the devicetree binding :( 
>>>>
>>>> Isn't possible to specify the channel to use in the DT? like renesas16 ? 
>>>
>>> That's what I did in V6 (and before), but Rob did not want me to add properties for Linux-specific concepts such as clocksource. 
>>
>> Hmm, I remember something like that, yes but I did a delete of the 
>> previous version when you posted the v7. Can you give a pointer to its 
>> answer ? 
> 
> Yes, this was his answer:
> https://lkml.org/lkml/2018/7/25/508
> 
> Then mine:
> https://lkml.org/lkml/2018/7/30/883

Thanks !


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

