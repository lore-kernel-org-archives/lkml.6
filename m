Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EACECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602C821480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkJKM64m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602C821480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeIXL7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 07:59:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50901 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeIXL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 07:59:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id s12-v6so8340395wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 22:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/johJ3UyAOovSnx7TvEP6A5RKo8jLj2X0tlzzx2ruyo=;
        b=DkJKM64m94Fipj2V9siEbJQoLhtrQO9vO+px1kjB+a+qCQh3yNXpipc++iOEhRcgZd
         X/EGCmu4Vvg1pq53fyDodIy/ZF3KVtMhzalTj59PmYKMccEqn7UUDIGPHJJLPj4weyJ2
         l25ZVlZpHMMJDE9/6pI8dESkuizHM4ow6TYnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/johJ3UyAOovSnx7TvEP6A5RKo8jLj2X0tlzzx2ruyo=;
        b=kM4Jb4cPyfRx0T7Kh2tbjECj/g+4e6x3twYUXoT//7wzyYyoOF6xyomuwx5q/2bKiU
         aRdxZJV2ojbGF5e7TfX75/d7kh2Y2NMKZuOL6QoM4eLvbsq8PVD/gw1BDpHZpnXwf7DT
         Gi3Q3HmlwWdI0iUgt9/LBt2ukj/k3ZsISo4JQwyvdkNHrtpcVdFK+o7aVdh+YcjPol6b
         pXthwv5pgR7FiajRI7t24SaGd+7fxexjLt8o+Z6RSjzXGug5G0Qin2KLrCly15+0aOXM
         AiNk3p0FV9THuFOgk8QnCO7+Ccn/v6STc6Wpki9pxC9XOdvSsSAMTWdoaTVDsYs5fENf
         PZuQ==
X-Gm-Message-State: ABuFfohRYUXxT3Oyq8hpqscVij82/4EeLtBKnYrRYnxrpwT8ysGQreZF
        SXxO5SzKOBCbWfJNWps/yvIznw==
X-Google-Smtp-Source: ACcGV63cwHQVPBsV0vN2M23izrDaFz7GC0tR1yqrl/uWJD0bz84zGR3F6YHiampD1L1paaZWC2dkkw==
X-Received: by 2002:a1c:208c:: with SMTP id g134-v6mr5833681wmg.144.1537768724934;
        Sun, 23 Sep 2018 22:58:44 -0700 (PDT)
Received: from [192.168.0.41] (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.googlemail.com with ESMTPSA id v192-v6sm14197856wmf.40.2018.09.23.22.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 22:58:44 -0700 (PDT)
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
References: <5ba87b02.1c69fb81.1da88.1457SMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e5104bd9-1564-266d-4f27-affa8a9e825d@linaro.org>
Date:   Mon, 24 Sep 2018 07:58:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ba87b02.1c69fb81.1da88.1457SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2018 07:49, Paul Cercueil wrote:
> 
> Le 24 sept. 2018 07:35, Daniel Lezcano <daniel.lezcano@linaro.org> a
> écrit :
>> 
>> On 24/09/2018 07:24, Paul Cercueil wrote:
>>> Hi Daniel,
>>> 
>>> Le 24 sept. 2018 05:12, Daniel Lezcano
>>> <daniel.lezcano@linaro.org> a écrit :
>>>> 
>>>> On 21/08/2018 19:16, Paul Cercueil wrote:
>>>>> This driver handles the TCU (Timer Counter Unit) present on
>>>>> the Ingenic JZ47xx SoCs, and provides the kernel with a
>>>>> system timer, and optionally with a clocksource and a
>>>>> sched_clock.
>>>>> 
>>>>> It also provides clocks and interrupt handling to client
>>>>> drivers.
>>>> 
>>>> Can you provide a much more complete description of the timer
>>>> in order to make my life easier for the review of this patch?
>>> 
>>> See patch [03/24], it adds a doc file that describes the
>>> hardware.
>> 
>> Thanks, I went through but it is incomplete to understand what the
>> timer do. I will reverse-engineer the code but it would help if you
>> can give the gross approach. Why multiple channels ? mutexes and
>> completion ?
> 
> Much of the complexity is because of the multi-purpose nature of the
> TCU channels. Each one can be used as timer/clocksource, or PWM.
> 
> The driver starts by using channels 0 and 1 as system timer and
> clocksource, respectively, the other ones being unused for now. Then,
> *if* the PWM driver requests one of the channels in use by the
> timer/clocksource driver, say channel 0, the timer/clocksource driver
> will dynamically reassign the system timer to a free channel, from
> channel 0 to e.g. channel 2. Only in that case the completion/mutex
> are actually used.

Why do you need to do this? Can't be the channels dedicated and reserved
for clocksource and clockevent?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

