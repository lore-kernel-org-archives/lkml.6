Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8A0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9613F2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANo5n3pC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9613F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964779AbeGDInk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:43:40 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34280 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934202AbeGDIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:41:15 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so4461030wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cV7SdbP4Ln7u/mqu9LbIcpssyOsB9ZuYwun0o8MZlTc=;
        b=ANo5n3pCZoTXLeH84gmmnM6Z9lHcd2cUpuKE9PPXaaEJGJPpW97Veyf8BHofJj06uF
         P2FvG/M5NeD7TQd/iedcS2kGnipjYU2egPCikiFxI8jvAZob0m4Gf4kGM6wnbtC+jDJc
         Oz6GeK/Y3OXVdNXCSYscemsM/Hy7Pw9EbX2YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cV7SdbP4Ln7u/mqu9LbIcpssyOsB9ZuYwun0o8MZlTc=;
        b=JNTTBletpKrIk8EPSuq/jhOLLZmOiqYWeQQj5NIjL/1KZrSCv4BCborKI9nFkp8pUS
         U2AXLm/1VNpsTe4hbTI9qkKsNlzI7On9/XT8g2aYIJ4Mee9W4/jwOT/dK1GGOOFOL7eG
         FeZvjnu05ctRZqdt+/h7dxFbca1AfL8VZgGV+HCIN+fJgzQlRLSw4DIMPbeDE0DfR1h9
         i0nOJObuNRoDZv0Dbcz2/1D8tBWhdX6rEisZKnMaIsZytseJwSdc+BlnVWoU1/vkYAOy
         ZZY+Yy4tz+HrKNtYmcY24D9tmOob6B9Aa59gXbsLZuE92Nfv9cjnc5gy2MfEBHnDxPLv
         XTSg==
X-Gm-Message-State: APt69E33Rur3UCgtYiiGdoUFp6QChVb16oXLQ35wWL0Ibhkjut6tgHR3
        BGO7GTrGSgxAq1E1P/O63YVStw==
X-Google-Smtp-Source: AAOMgpc+4I/u7JH+JJeOXBTZ460C9ZRQaY4mVK7Dblqm25t+f5tu6Fba7g2dF2d3gCYLXcxw0r3jaQ==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr729507wre.12.1530693674232;
        Wed, 04 Jul 2018 01:41:14 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.73.209])
        by smtp.googlemail.com with ESMTPSA id 136-v6sm6849389wmr.18.2018.07.04.01.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:41:13 -0700 (PDT)
Subject: Re: [PATCH 0/2] Allwinner A64 timer workaround
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
 <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d72937af-cb46-27cf-809a-507ba5e47568@linaro.org>
Date:   Wed, 4 Jul 2018 10:41:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2018 10:16, Marc Zyngier wrote:
> On 03/07/18 19:42, Samuel Holland wrote:
>> On 07/03/18 10:09, Marc Zyngier wrote:
>>> On 11/05/18 03:27, Samuel Holland wrote:
>>>> Hello,
>>>>
>>>> Several people (including me) have experienced extremely large system
>>>> clock jumps on their A64-based devices, apparently due to the architectural
>>>> timer going backward, which is interpreted by Linux as the timer wrapping
>>>> around after 2^56 cycles.
>>>>
>>>> Investigation led to discovery of some obvious problems with this SoC's 
>>>> architectural timer, and this patch series introduces what I believe is
>>>> the simplest workaround. More details are in the commit message for patch
>>>> 1. Patch 2 simply enables the workaround in the device tree.
>>>
>>> What's the deal with this series? There was a couple of nits to address, and 
>>> I was more or less expecting a v2.
>>
>> I got reports that people were still occasionally having clock jumps after
>> applying this series, so I wanted to attempt a more complete fix, but I haven't
>> had time to do any deeper investigation. I think this series is still beneficial
>> even if it's not a complete solution, so I'll come back with another patch on
>> top of this if/once I get it fully fixed.
>>
>> I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (24MHz
>> timer) ≈ 150 should be a conservative iteration limit?
> 
> Should be OK.
> 
> Maxime: How do you want to deal with the documentation aspect? We need
> an erratum number, but AFAIU the concept hasn't made it into the silicom
> vendor's brain yet. Any chance you could come up with something that
> uniquely identifies this?

I went through the different pointers provided in the description but I
did not find a clear statement that is a hardware issue or may be I
missed it.

Are we sure there isn't another subsystem responsible on this
instability ? (eg PM or something else)

>> Also, does this make sense to CC to stable?
> 
> Probably not, as the HW never worked, so it is not a regression.
> 
> Thanks,
> 
> 	M.
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

