Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697F3C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4D12082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQl2yD3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4D12082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLDKCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:02:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47019 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLDKCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:02:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so15222401wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 02:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kl1PktiGGy+V87hOTKt/PDKZwipFLFtNgVpJR+2NfNw=;
        b=PQl2yD3sVN9oBVmNad9K/bPtgoPPvKalXj6JM5VOz1UJ+Ndrh3Jx75uxX41/tiBjb6
         hhwtbwCDxsDVOTYGwCCpyXtrE77/h27W4FUja3obr28wVe2ZoGCTd3IVv6qLzlk1yagR
         1zCkqRP+7p4Vcd/joqWCq3L4LWxwzurj/Eonw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kl1PktiGGy+V87hOTKt/PDKZwipFLFtNgVpJR+2NfNw=;
        b=mkZEsfXX1D+/9WYDvZWE3qYNzYeoZf2nRpWWhJtqB7+DWC9c8YT2Y90FnqLOZsQLIW
         SDXLWHJeeUKJuLV3QWNQNoxOlnA0IrEKD96i/3eiWuyXKb1EZE8XovVsYFHvRqjWPI7o
         5CMkEnqbm3AnlHb4B+Dl4TtILGx1n+utOOHBEL62L1d1wlXiV+K6fek9GmZ0nMnHFJJr
         uxph10Gjos1+42rLj46sVCHojafvFKsLHyAkzDabzV/HVteiR1vfYy0xoqOACcI1TGwc
         7sMhw0AOQC3HX7b4RYDOHh/csPBmwQxwPHIdZIgmcKuoC/mLQ6wzYe7HiguN4ti/wCjj
         70tg==
X-Gm-Message-State: AA+aEWYYYce0VrXgdurKUpho1YkUTuVbMZLOCZrJn8Xnll2yFIZWWXqB
        FUeRrFk/u/WrB3xHYcTGxTKDbg==
X-Google-Smtp-Source: AFSGD/ViCvZGBrBrBQQWKojD125GpeX3Zg717anUHAbmCuK7yf6tn+a64RiK+g+uNqa9ZFGfKhNung==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr17277637wru.222.1543917734805;
        Tue, 04 Dec 2018 02:02:14 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id l15sm14791341wrw.4.2018.12.04.02.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 02:02:14 -0800 (PST)
Subject: Re: [PATCH V5 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Olof Johansson <olof@lixom.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>
References: <1543325060-1599-1-git-send-email-daniel.lezcano@linaro.org>
 <1543325060-1599-2-git-send-email-daniel.lezcano@linaro.org>
 <2b050e93-f734-f2f3-ac67-a30d37bf1950@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <db264663-3b7c-6dd3-a180-d71de9dc83f2@linaro.org>
Date:   Tue, 4 Dec 2018 11:02:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2b050e93-f734-f2f3-ac67-a30d37bf1950@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dietmar,

thanks for the review and spotting this.

On 03/12/2018 14:46, Dietmar Eggemann wrote:
> Hi Daniel,
> 
> +cc: Russell King <linux@armlinux.org.uk>
> 
> On 11/27/18 2:24 PM, Daniel Lezcano wrote:
>> In the case of asymmetric SoC with the same micro-architecture, we
>> have a group of CPUs with smaller OPPs than the other group. One
>> example is the 96boards dragonboard 820c. There is no dmips/MHz
>> difference between both groups, so no need to specify the values in
>> the DT. Unfortunately, without these defined, there is no scaling
>> capacity computation triggered, so we need to write
>> 'capacity-dmips-mhz' for each CPU with the same value in order to
>> force the scaled capacity computation.
>>
>> In order to fix this situation, allocate 'raw_capacity' so the pointer
>> is set and the init_cpu_capacity_callback() function can be called.
>>
>> This was tested on db820c:
>>   - specified values in the DT (correct results)
>>   - partial values defined in the DT (error + fallback to defaults)
>>   - no specified values in the DT (correct results)
>>
>> correct results are:
>>    cat /sys/devices/system/cpu/cpu*/cpu_capacity
>>     758
>>     758
>>    1024
>>    1024
>>
>>    ... respectively for CPU0, CPU1, CPU2 and CPU3.
>>
>> That reflects the capacity for the max frequencies 1593600 and 2150400.
> 
> [...]
> 
> I'm afraid that this change is incompatible with the still existing
> cpu_efficiency interface we have in Arm32 for A15/A7 systems like Arm TC2:
> 
> In case you specify clock-frequency dt properties per cpu for such a
> system, the cpu_capacity values are determined via the cpu_efficiency
> code in arch/arm/kernel/topology.c.
> 
> So on Arm TC2 with clock-frequency = <1000000000> [A15] and <800000000>
> [A7] you get:
> 
> root@linaro-nano:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 606
> 1441
> 1441
> 606
> 606
> 
> With your patches on top (cpu_capacity functionality in
> drivers/base/arch_topology.c does not have to be switched on by
> specifying capacity-dmips-mhz dt properties anymore) we end up scaling
> by max frequency again:
> 
> root@linaro-nano:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 358
> 1024
> 1024
> 358
> 358
> 
> I tried to remove the cpu_efficiency based API a year ago but Russell
> pointed out that the compatibility has to be maintained for longer:
> 
> https://lore.kernel.org/lkml/20171024102718.16113-1-dietmar.eggemann@arm.com/
> 
> 
> I assume that the capacity-dmips-mhz dt property is like a switch to
> turn this functionality on for big.Little and so called gold/silver
> platforms, which have cores with the same uArch but in frequency domains
> with different max frequency values.
> 
> So what's wrong with specifying capacity-dmips-mhz = <1024> for all
> cores for those gold/silver platforms? 

There is nothing wrong, I just don't like to specify in a DT a default
values.

> I don't expect that there will be
> so many of them. And normal SMP platforms (w/o frequency domains w/o
> different max frequency values) don't have to execute this code.

Fair enough, I will send a DT change, I'm tired of playing mikado with
this code.

Thanks again for the review.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

