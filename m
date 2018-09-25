Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E79C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0582083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9az/ZJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0582083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeIZCVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:21:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44653 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeIZCVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:21:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so24640076wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KD68OO+Zb8yNT0w8I5hNpU0qCH3+ExU40WmiuRcgeRo=;
        b=X9az/ZJOX1sLQP8M2TIj2losjHqznGeV/ki94HxOy/5ekO4rfs/cA/CVt/ULTPD9kB
         5ckH+v5AKBxhoTE1MFxU+6pG2ZU3DhR4NTDWBYD4ACon93jbORPlqKfqZl/YeKYhL8Is
         kJc90YmrwEttTsKpqdSdJUT3AjeEr4MNCSoW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KD68OO+Zb8yNT0w8I5hNpU0qCH3+ExU40WmiuRcgeRo=;
        b=ptaYIJNPhi1oxYuARkYBQfg3eHyM07Ws4K8sExuCsNQHAD+m/VelDhvSYiqjnekD3/
         R7VbxeccEJZ32ofKeFu4vkIss5qFnlpgQAtlb/ao3S78y9w8MIZKDqXDH8eTsRAgVVGQ
         f7RH5PXDY2Wt8NVNtl40lN5hFjgxv++K0RRE9d+ZDO9jPz7cXovJgDUnarsxd1uKeHxk
         vtwJVPlNfwblYZEek0nbrFsmPCA6uylopDLUwjpBGWSJsph1BkK5AJPUj6RcwzI4sWs/
         cOIOUwmjKcffivEAukXey0E2j+ApHV9kqHj61625zIu8NvXHU1ZCrcWeesyTGWZb3XW7
         gSfA==
X-Gm-Message-State: ABuFfojau9FlQP1VQwhbL/W8tMEz7G8hC0hO/kU/tm2eGg7stocBC3dS
        PKxakAjZyo/Xdxcf/c2M7fuuqA==
X-Google-Smtp-Source: ACcGV60OqFoavW+v4tDJ6TV48WmE7122ILnvjvGMFWlfHWEreh8Pj+XUlHZXxF0/nzPQGvLLcvplHA==
X-Received: by 2002:adf:ff08:: with SMTP id k8-v6mr2604535wrr.15.1537906351050;
        Tue, 25 Sep 2018 13:12:31 -0700 (PDT)
Received: from [192.168.0.41] (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.googlemail.com with ESMTPSA id u12-v6sm2840653wrs.48.2018.09.25.13.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:12:30 -0700 (PDT)
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-watchdog@vger.kernel.org, od@zcrc.me,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <5baa3fa9.1c69fb81.4c7b7.19fdSMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <346cb95c-f9ce-f19b-30f3-75e9fb379290@linaro.org>
Date:   Tue, 25 Sep 2018 22:12:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5baa3fa9.1c69fb81.4c7b7.19fdSMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2018 15:38, Paul Cercueil wrote:
> 
> Le 24 sept. 2018 9:14 AM, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
>>
>> On 24/09/2018 08:53, Paul Cercueil wrote: 
>>>
>>> Le 24 sept. 2018 07:58, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit : 
>>>>
>>>> On 24/09/2018 07:49, Paul Cercueil wrote: 
>>>>>
>>>>> Le 24 sept. 2018 07:35, Daniel Lezcano <daniel.lezcano@linaro.org> a 
>>>>> écrit : 
>>>>>>
>>>>>> On 24/09/2018 07:24, Paul Cercueil wrote: 
>>>>>>> Hi Daniel, 
>>>>>>>
>>>>>>> Le 24 sept. 2018 05:12, Daniel Lezcano 
>>>>>>> <daniel.lezcano@linaro.org> a écrit : 
>>>>>>>>
>>>>>>>> On 21/08/2018 19:16, Paul Cercueil wrote: 
>>>>>>>>> This driver handles the TCU (Timer Counter Unit) present on 
>>>>>>>>> the Ingenic JZ47xx SoCs, and provides the kernel with a 
>>>>>>>>> system timer, and optionally with a clocksource and a 
>>>>>>>>> sched_clock. 
>>>>>>>>>
>>>>>>>>> It also provides clocks and interrupt handling to client 
>>>>>>>>> drivers. 
>>>>>>>>
>>>>>>>> Can you provide a much more complete description of the timer 
>>>>>>>> in order to make my life easier for the review of this patch? 
>>>>>>>
>>>>>>> See patch [03/24], it adds a doc file that describes the 
>>>>>>> hardware. 
>>>>>>
>>>>>> Thanks, I went through but it is incomplete to understand what the 
>>>>>> timer do. I will reverse-engineer the code but it would help if you 
>>>>>> can give the gross approach. Why multiple channels ? mutexes and 
>>>>>> completion ? 
>>>>>
>>>>> Much of the complexity is because of the multi-purpose nature of the 
>>>>> TCU channels. Each one can be used as timer/clocksource, or PWM. 
>>>>>
>>>>> The driver starts by using channels 0 and 1 as system timer and 
>>>>> clocksource, respectively, the other ones being unused for now. Then, 
>>>>> *if* the PWM driver requests one of the channels in use by the 
>>>>> timer/clocksource driver, say channel 0, the timer/clocksource driver 
>>>>> will dynamically reassign the system timer to a free channel, from 
>>>>> channel 0 to e.g. channel 2. Only in that case the completion/mutex 
>>>>> are actually used. 
>>>>
>>>> Why do you need to do this? Can't be the channels dedicated and reserved 
>>>> for clocksource and clockevent? 
>>>
>>> That's what I had in place (ingenic,timer-channel and ingenic,clocksource-channel DT properties), but Rob didn't want any linux-specific properties in the devicetree binding :( 
>>
>> Isn't possible to specify the channel to use in the DT? like renesas16 ? 
> 
> That's what I did in V6 (and before), but Rob did not want me to add properties for Linux-specific concepts such as clocksource.

Hmm, I remember something like that, yes but I did a delete of the
previous version when you posted the v7. Can you give a pointer to its
answer ?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

