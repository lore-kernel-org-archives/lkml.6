Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84CBC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AAE20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYipzZ58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AAE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJOUML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:12:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52243 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeJOUML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:12:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so18714859wmw.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YH76ay1gqAjKUGCaTLWjFIWSJ4fOMg3I7KnS6lsPNOs=;
        b=DYipzZ588EnFIXP6qYlCALFTyG9dNpkoMvpgAyO1XYLbpsaOHhU1dIAJwfBq85IOiS
         S6fxoDk8zXecWUc5S5wuDS8UUrCcoKDZ9QAFwnJbtUZlzXzrfDGFNtYIKy8uFjOMxTaI
         RtNqNW/OxbMIc04011KeJCEedb/6ENq3ko3cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YH76ay1gqAjKUGCaTLWjFIWSJ4fOMg3I7KnS6lsPNOs=;
        b=g+IhU4njTQtgWBkEg925WwcAj3KVDc4AKHNGHxPWByAPrYA3k617BeyUU8dHTKHjjV
         lLwKdehmvwkV9jGd31D32ITHgB2gklQXkejkE7witEHvMzRUA872pN3Hbp+34lpMw2Du
         TUV8IIxMm1jsbHMQBPHklqira/S5QkyM3ddCcZ32A57qzyzfNs5qfoDN0S1eI3+oT0de
         jmhb/lnMLu4UTBAKOZwoqdtwop+hBgirdosAc76WcHOaAAYjIEmmub6TAsAaLlDfxPO6
         mzdsk7U6KiYxxy4Q1tbTlh6R+2HNySq/7S0OXSovRgbx3iqz+IOjDsoSqQ49Pn14pc5/
         ON0Q==
X-Gm-Message-State: ABuFfogVvaKLspt7vUh9yJ8ObPg8gRFudmw0YB5wSbgO7OIFljDx4BqL
        zZyOu/lA23rWBJCktijtYxUhBQ==
X-Google-Smtp-Source: ACcGV60OqjacmNhpJ8rBmufrSX+6QMmlQvd/WjxTDMOwNnirBVq1zAFdClaT7cDLLj4sTleKhIjGnA==
X-Received: by 2002:a1c:7a0a:: with SMTP id v10-v6mr13288663wmc.41.1539606424554;
        Mon, 15 Oct 2018 05:27:04 -0700 (PDT)
Received: from [192.168.0.40] (85.238.136.77.rev.sfr.net. [77.136.238.85])
        by smtp.googlemail.com with ESMTPSA id l38-v6sm7917078wre.38.2018.10.15.05.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 05:27:03 -0700 (PDT)
Subject: Re: [PATCH 4/7] clocksource: arch_timer: Add support for
 not-fw-configured timer on ARM64
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <Mark.Rutland@arm.com>
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
 <CGME20181008125048eucas1p229a94c202596ddd0a65009c15d9e3001@eucas1p2.samsung.com>
 <20181008125009.3721-5-m.szyprowski@samsung.com>
 <e9624612-4a94-b9bc-f5ec-0f16d5b12323@arm.com>
 <20181015121243eucas1p1dd6093945310db315fc28092e2c91b6e~dxxpPrR4A1710517105eucas1p1W@eucas1p1.samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cfbb2d68-1bdc-cbb6-9762-4bd174e0e7d7@linaro.org>
Date:   Mon, 15 Oct 2018 14:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015121243eucas1p1dd6093945310db315fc28092e2c91b6e~dxxpPrR4A1710517105eucas1p1W@eucas1p1.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2018 14:12, Marek Szyprowski wrote:
> Hi All,
> 
> On 2018-10-08 15:17, Marc Zyngier wrote:
>> + Mark Rutland
>>
>> Hi Marek,
>>
>> On 08/10/18 13:50, Marek Szyprowski wrote:
>>> Use common infrastructure for ARM Architected Timers erratum to enable
>>> support for systems with broken CPU firmware (timer registers not
>>> properly configured). This mode has been already availabled on ARM
>>> (32bits) architecture. This enables to run Linux kernel on ARM64 boards
>>> using physical architected timers instead of the virtual ones. Examples
>>> of such system with broken firmware are Samsung Exynos5433 SoC based
>>> TM2(e) boards, which is already deployed for years and updating firmware
>>> is not possible.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>   drivers/clocksource/Kconfig          | 11 +++++++++++
>>>   drivers/clocksource/arm_arch_timer.c | 15 ++++++++++++---
>>>   2 files changed, 23 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index a11f4ba98b05..a30752579b03 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -364,6 +364,17 @@ config ARM64_ERRATUM_858921
>>>         The workaround will be dynamically enabled when an affected
>>>         core is detected.
>>>   +config ARCH_TIMER_REGISTERS_NOT_FW_CONFIGURED
>>> +    bool "Workaround for arch timer registers not configured by
>>> firmware"
>>> +    default y
>>> +    select ARM_ARCH_TIMER_OOL_WORKAROUND
>>> +    depends on ARM_ARCH_TIMER && ARM64
>>> +    help
>>> +      This option enables a workaround for boards, on which arch timer
>>> +      registers are not properly configured by the board firmware.
>>> +      The workaround will be dynamically enabled when an affected
>>> +      board is detected.
>>> +
>>
>> I'm sorry, but I'm strongly pushing back on this.
>>
>> This horrible hack was accepted with the express condition that it
>> would be limited to ARMv7 platforms (on the ground that we never
>> really documented the arch timer boot requirements on that version of
>> the architecture), and would never proliferate on arm64. From day 1,
>> we established what the boot protocol was, and we mandated that either:
>>
>> - kernel is entered at EL2 on all CPUs
>> - cntvoff_el2 is zeroed on all CPUs
>>
>> and we've got most people to fix their firmware, or live with the
>> consequences. If these machines cannot receive a non-broken firmware,
>> what are the odds that they will receive a mainline kernel?
> 
> Well, I know that the firmware is broken, but I cannot do anything about it.
> On the other hand updating kernel is still possible and mainline runs fine
> on TM2(e) boards. I will send v2 without this patch then.

I second Marc's opinion.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

