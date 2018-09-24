Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2D1ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E052145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+o2Fv41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E052145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeIXNPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:15:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42236 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeIXNPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:15:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id b11-v6so2310098wru.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WuG1X1M3KFSddiJgkJ0AwqTU/xMGLDpRyA5DOLC5w1U=;
        b=S+o2Fv41yiCbgxZnkAkjHKlxTtIEptB915xs1gdcKJQ3uXDJvskK56BFGCRuopQQ2t
         gWLg0P3P8LXWegkr66xzTgMxPp8E3i9huZUKOGup/ehJb7LxiIqhZx1MkJ25C6FRWo/p
         KaqGgKbUCeup3TLkPgxlf/W1mRwj/ceywId9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WuG1X1M3KFSddiJgkJ0AwqTU/xMGLDpRyA5DOLC5w1U=;
        b=JMz+PYktjkHw41dCcJ0hr89yHcUOXgS2wDZchXT805yg1govZeC6KarFHxrR9NfBf4
         RX+OfDJLDMomrNnrzmQM89fkPjT3kuuxgK2wc92dGCfH1PUevrU8sx5Ki4ANI+lpJtqn
         eDmHhq4bSW+bBzlrrZx3FRj+7ImqIcxFsCByyR5xqhj+3Ci9jqa0PRtCJZ7tTfx2DBg9
         l8BQW8lxRERhsZMj13HjQHSwechxa73EG3yEQdyrZSxAfJZP57sZ6wJKAr/cNXeWNRZj
         HVYgDyfXXbUU5A6BoyxuYCJlSZttWguS/sV293DPmc8NWse8DirnNxuwBzAMtjGEFRhA
         oIDA==
X-Gm-Message-State: ABuFfohhCGwV8lqdkeHbDhP6nidWxiYWw4fQhLXiumwxuLv1aIqI5udd
        ru0ZIcn3ew5GgUJBUhdNfErCjg==
X-Google-Smtp-Source: ACcGV60s4laND56QrgYhaZFALQur/k4kF1YTXHLrwNFcFHOwCO/BhsK4F0Mi5w89AooR/Mwfby0jJg==
X-Received: by 2002:a5d:4b52:: with SMTP id w18-v6mr7202299wrs.87.1537773268575;
        Mon, 24 Sep 2018 00:14:28 -0700 (PDT)
Received: from [192.168.0.41] (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.googlemail.com with ESMTPSA id l5sm838709wrx.69.2018.09.24.00.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 00:14:27 -0700 (PDT)
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
References: <5ba88a1a.1c69fb81.2ba56.ccdaSMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a9d7366a-7118-9819-4d15-cdc10fa6c41c@linaro.org>
Date:   Mon, 24 Sep 2018 09:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ba88a1a.1c69fb81.2ba56.ccdaSMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2018 08:53, Paul Cercueil wrote:
> 
> Le 24 sept. 2018 07:58, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
>>
>> On 24/09/2018 07:49, Paul Cercueil wrote: 
>>>
>>> Le 24 sept. 2018 07:35, Daniel Lezcano <daniel.lezcano@linaro.org> a 
>>> écrit : 
>>>>
>>>> On 24/09/2018 07:24, Paul Cercueil wrote: 
>>>>> Hi Daniel, 
>>>>>
>>>>> Le 24 sept. 2018 05:12, Daniel Lezcano 
>>>>> <daniel.lezcano@linaro.org> a écrit : 
>>>>>>
>>>>>> On 21/08/2018 19:16, Paul Cercueil wrote: 
>>>>>>> This driver handles the TCU (Timer Counter Unit) present on 
>>>>>>> the Ingenic JZ47xx SoCs, and provides the kernel with a 
>>>>>>> system timer, and optionally with a clocksource and a 
>>>>>>> sched_clock. 
>>>>>>>
>>>>>>> It also provides clocks and interrupt handling to client 
>>>>>>> drivers. 
>>>>>>
>>>>>> Can you provide a much more complete description of the timer 
>>>>>> in order to make my life easier for the review of this patch? 
>>>>>
>>>>> See patch [03/24], it adds a doc file that describes the 
>>>>> hardware. 
>>>>
>>>> Thanks, I went through but it is incomplete to understand what the 
>>>> timer do. I will reverse-engineer the code but it would help if you 
>>>> can give the gross approach. Why multiple channels ? mutexes and 
>>>> completion ? 
>>>
>>> Much of the complexity is because of the multi-purpose nature of the 
>>> TCU channels. Each one can be used as timer/clocksource, or PWM. 
>>>
>>> The driver starts by using channels 0 and 1 as system timer and 
>>> clocksource, respectively, the other ones being unused for now. Then, 
>>> *if* the PWM driver requests one of the channels in use by the 
>>> timer/clocksource driver, say channel 0, the timer/clocksource driver 
>>> will dynamically reassign the system timer to a free channel, from 
>>> channel 0 to e.g. channel 2. Only in that case the completion/mutex 
>>> are actually used. 
>>
>> Why do you need to do this? Can't be the channels dedicated and reserved 
>> for clocksource and clockevent? 
> 
> That's what I had in place (ingenic,timer-channel and ingenic,clocksource-channel DT properties), but Rob didn't want any linux-specific properties in the devicetree binding :(

Isn't possible to specify the channel to use in the DT? like renesas16 ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

