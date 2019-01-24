Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF7CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE2F218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gL5Xl8NE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAXJjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:39:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51578 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:39:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so2376066wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 01:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ac25Jice3h57eN8pcoXDQoHQmIr/VFnVEN4NgR0MbIE=;
        b=gL5Xl8NEau35LRK76hrQ5Q/CBwWDgAXYV4mn7ZLVcwLVR3v3Md/Kfs88A41gIDzhLx
         g0H8vdBYGfNaBriR/ve/XowBen0lK2BVRDXtX7jnqii1W0fy5Jc7EILUes4otY/1buYf
         7OUUzkOYcuh6YzYxpT8LoZ6pM9mpqidVErBo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ac25Jice3h57eN8pcoXDQoHQmIr/VFnVEN4NgR0MbIE=;
        b=VwoQgneJxEIewLeOfl1zglJ74T/6RfiCjspxXjj4O0ixARmXBcTkJ5USxMmQTYdl5l
         +e1tInrvdXDJ/H+yHT4RvlKLORxH9vtFuIQy5zJqqLDNCLct2GtpKlkDL79vTdwjzu3m
         TD9e880h3jhwFp6lkKnORwwq/YMmHPp6o/EPDKDrGajSdkoOKKrdSWQq6sXOaVAAgJvH
         32QlxKOWS9ZF19vu1P+LuICeN+7Kedx7CCYa+2BMbx3sx89nOycTFAfmpaCKkfCrO+ny
         aLRq3fwgesyWr6NsEW53+EEF1Zzd9YJCUhqMnp7WE+wF8MU4YEhMiARrlLegkdjSgaVS
         oTbQ==
X-Gm-Message-State: AJcUukdgRxgL2mZuyHH1iLoQxouttsF1DH09aIZNkpBkEPKEMcoqEwyO
        dVW174Nu4llWmwJc4naQOidBf5pjbP4=
X-Google-Smtp-Source: ALg8bN4gdFyPqXJTlM7m3OH7VDeRz4DCRS0JJH2Wj3Bu6f4n35ugwQL/Ts9EklpqX+ZBTBXVTcAAjQ==
X-Received: by 2002:a1c:2787:: with SMTP id n129mr1910087wmn.128.1548322740193;
        Thu, 24 Jan 2019 01:39:00 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id h10sm54334751wmf.44.2019.01.24.01.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 01:38:59 -0800 (PST)
Subject: Re: [PATCH] clocksource: sun5i: fail gracefully when clock rate is
 unavailable
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190110062207.18787-1-wens@csie.org>
 <0f9b4bc0-6969-97d3-8ac6-63931ea6db92@linaro.org>
 <CAGb2v65RJ2iwTr1bxXxXAROLtg2a1KP2x36uXpjGs=r38NrM6g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c00394ec-4817-629d-2a92-e62a7f2d31ab@linaro.org>
Date:   Thu, 24 Jan 2019 10:38:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v65RJ2iwTr1bxXxXAROLtg2a1KP2x36uXpjGs=r38NrM6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2019 09:56, Chen-Yu Tsai wrote:
> On Thu, Jan 10, 2019 at 5:19 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 10/01/2019 07:22, Chen-Yu Tsai wrote:
>>> If the clock tree is not fully populated when the timer-sun5i init code
>>> is called, attempts to get the clock rate for the timer would fail and
>>> return 0.
>>>
>>> Make the init code for both clock events and clocksource check the
>>> returned clock rate and fail gracefully if the result is 0, instead of
>>> causing a divide by 0 exception later on.
>>>
>>> Fixes: 4a59058f0b09 ("clocksource/drivers/sun5i: Refactor the current code")
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>
>> Applied thanks.
> 
> I'm not seeing this in linux-next, nor the patch
> 
>     arm64: arch_timer: Workaround for Allwinner A64 timer instability
> 
> Any idea where these ended up?

Yeah, I have a rough idea. They are now in linux-next via the
clockevents/next branch.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

