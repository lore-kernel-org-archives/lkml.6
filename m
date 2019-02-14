Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D881C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8432077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REHtJ+CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfBNQQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:16:12 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46167 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfBNQQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:16:12 -0500
Received: by mail-wr1-f48.google.com with SMTP id l9so7074926wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FJFftD26LG7g9koubYUF80zyZhS635rYIyiuVJ068dQ=;
        b=REHtJ+CBpzidj6bneh61zNlSr7hGifTtec4Q3vIN7bOp+fkmFlTi8i/7HLZirODr20
         9HLa/3RfNULWvTmzPbQX2Bz4MBfnYi0TMeys3uyXIpeuo7wF4Pgba5q1j5YqSZCzve97
         hVofEOhOxJyh288HtTyPlzaTrGbtllt9jIK4IJ1s0OTrXSZ7XEYlnTGbckIxlJ07cZ+C
         BORM2U/7Ljjvg3FFRS/Vv245dZzDpy1KT/qWFxwbl7ooE1/lcF3EWaiaaI8dj5OFtzEV
         fjRqwx4i/reHL3onh1GCj20Kmc0jnUJX0yeyA8DcThikfVwUqYyRMPbMhwOHrhs9KWup
         ZjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FJFftD26LG7g9koubYUF80zyZhS635rYIyiuVJ068dQ=;
        b=XEHQScfm6mkWTUxPtZSV9p+ItboBJVv89aX2N/a0HQCZPneK3Q4L5yiVslAcT2tGDR
         XoVx6oprNKaqACe2D9F1GBXa2gRV1fmPURrTOv2FIp8l8eFh0INvzdynfYaMftsraFt5
         gC1WoA3M/QI50XY77oWJSxabSF12Zdlx96Ba7L142EOJ35hsuVGmMqvruV/r0DMfv23S
         Q2ltg/Of0SfQ6i0wP/pa+atLRBEy9CmtxU6TwWfswt1mdkgMK2b0kPP8M6Dv4IJrJXOF
         VQXEwU5nY4iQXm6Up7+axfQqdWWFYZxrDBFn1gi4LKReInFG8qfPFFJXEhhjC/X5WR0t
         TlkA==
X-Gm-Message-State: AHQUAuaG7mV0u7lKsVh3nTX/Q74YKaPHfCHF+dCVCqhpqJoeYCoHu+Bn
        qt3OPUUc5QFS7FykRemX8ZBXj9kF2tU=
X-Google-Smtp-Source: AHgI3IbGah3DcnsCtcthMGY4zavv06y2jH7IpKh3adn3nMiKlX4+48znsZBA03jP6i71EKgiZVhV/Q==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr3467601wrs.3.1550160970198;
        Thu, 14 Feb 2019 08:16:10 -0800 (PST)
Received: from [192.168.27.66] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id z5sm1457895wmi.15.2019.02.14.08.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 08:16:09 -0800 (PST)
Subject: Re: How to know if there is a pending interrupt when they are masked?
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <bf2e6e81-7218-05e0-fd6e-27c9c5418813@linaro.org>
 <alpine.DEB.2.21.1902141620510.1561@nanos.tec.linutronix.de>
 <3a4ca5d5-9b90-e4e0-84ab-420bf5e460db@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9ff685f9-d378-1942-3678-7aff8f5b3aa3@linaro.org>
Date:   Thu, 14 Feb 2019 17:16:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3a4ca5d5-9b90-e4e0-84ab-420bf5e460db@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

thanks for the answer,

On 14/02/2019 16:47, Marc Zyngier wrote:
> On 14/02/2019 15:35, Thomas Gleixner wrote:
>> On Thu, 14 Feb 2019, Daniel Lezcano wrote:
>>> today we have the possibility to mask the local interrupt with the
>>> command local_irq_disable / local_irq_enable.
>>>
>>> The power management path disables the local interrupt in order to
>>> initiate a power down sequence. If there is a pending interrupt this one
>>> will make the power down function to abort, thus exiting right after
>>> calling the shutdown function after costly operations. It could be
>>> interesting to check if there is a pending interrupt before initiating
>>> the power down sequence.
>>>
>>> Is there a way to know if there is a pending interrupt on the current
>>> CPU when the local interrupt are disabled? Something like,
>>> local_irq_pending() function ?
>>
>> We have nothing like that today, but it would be possible to implement this
>> at least on x86 by peeking the local APIC registers.
> 
> On arm64, reading ISR_EL1 would give some indication of that, but...

Does 'some indication' means as soon as we read the ISR_EL1 it may be
outdated right after ?

>> OTOH, the question is whether it's worth the trouble because the interrupt
>> could come in right after the query and the same issue which you want to
>> address persists. It only makes sense if it reduces the time window so
>> significantly that it actually matters.
> 
> as Thomas explains, the potential race is pretty tight.

Is a simple hack possible on ARM64 to check if it is worth or not?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

