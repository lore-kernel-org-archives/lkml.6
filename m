Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95D9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBE220854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB4bkBeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBE220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGRKoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbeGRKoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:44:07 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C2420854;
        Wed, 18 Jul 2018 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531908418;
        bh=XhOxADjsx32nUgQMfU+EpRByMBYl3lic4JtC9OoX5ow=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WB4bkBeII1EAUyQsk8jlWujcRMWXaoK77rlvAU+lX4olIHC66ikZ5R8hDTI9+FhBQ
         SZZ48hPJ4IkGhLiuqtRvm1VCr7skdsXH+pPyw5MwiBNTugMVFeF+V15k0QfW2k8psa
         rbLpd+ksa7LKUA6OSVIYHx3g40gXF3lb47t7HVm8=
Received: by mail-wm0-f50.google.com with SMTP id y22-v6so2258680wma.0;
        Wed, 18 Jul 2018 03:06:57 -0700 (PDT)
X-Gm-Message-State: AOUpUlEeCvUeMkug9J/p1T4ix4SxDJb5bXkfbctVAF84S7Lp1SaB3CuM
        m3qf5DPgJWNK0gUin8UAUb8hN2I2Eu86jNAGKuI=
X-Google-Smtp-Source: AAOMgpctHt5J3tIf0skJsj5yWC7AXDJgOeqn9Iv3K4FVzOnESNsvIP75VRlhH43f3gOjznhQ08XXRIhbHk671DsJ4Z4=
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr1205290wma.72.1531908416374;
 Wed, 18 Jul 2018 03:06:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:06:55
 -0700 (PDT)
In-Reply-To: <CANAwSgRFehdmYZvPL3yD1=Ng_w1Yhtij=nvZEOqkof7zj8fcwA@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
 <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com>
 <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com> <CANAwSgRFehdmYZvPL3yD1=Ng_w1Yhtij=nvZEOqkof7zj8fcwA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Jul 2018 12:06:55 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfRBPgmGc17XEzW5+MK80JcudCbhBfLeMFTQYjWLJ3JeA@mail.gmail.com>
Message-ID: <CAJKOXPfRBPgmGc17XEzW5+MK80JcudCbhBfLeMFTQYjWLJ3JeA@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos platform
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 11:24, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Krzysztof
>
> On 18 July 2018 at 11:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 17 July 2018 at 22:23, Anand Moon <linux.amoon@gmail.com> wrote:
>>> Hi Krzysztof
>>>
>>> On 17 July 2018 at 17:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>> Hi Anand,
>>>>
>>>> Thanks for patch.
>>>>
>>>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>>>> clk_summary do not show tmu_apbif clk enable, so replace
>>>>> the clk_prepare with clk_prepare_enables to enable tmu clk.
>>>>
>>>> This is not valid reason to do a change. What is clk_summary does not
>>>> really matter. Your change has negative impact on power consumption as
>>>> the clock stays enabled all the time. This is not what we want... so
>>>> please explain it more - why you need the clock to be enabled all the
>>>> time? What is broken (clk_summary is not broken in this case)?
>>>>
>>>
>>> Opps I could not explain some more in my commit message.
>>>
>>> Actually TMU sensor for Exynos process are controlled by so external clk
>>>
>>> Exynos4412 have VDD18_TS sensor which controls the CLK_SENSE tmu.
>>> Exynos5422 have VDD18_TS01 / VDD18_TS23 / VDD18_TS4 sensor which
>>> control the CLK_SENSE tmu.
>>>
>>> So as per my understanding tmu is clk driver which control the flow  PMIC.
>>>
>>> clk_prepare_enable combine clk_prepare and clk_enable
>>> and clk_disable_unprepare combine clk_disable and clk_unprepare.
>>>
>>> most of the driver prefer clk_prepare_enable and clk_disable_unprepare.
>>>
>>> clk_summary is just a reference looking point where we could check the
>>> clk is enable/disable.
>>>
>>> what is broken ?
>>> I still few more parameter need to tuned to configure the tmu driver.
>>
>> I am sorry but I am still unable to see what is broken and what are
>> you trying to fix. I asked what is broken and you replied that there
>> is a sensor, there is a clock, drivers use clk_prepare_enable and some
>> more parameter need to be tuned... None of these are answers to
>> question - what is broken. How can I reproduce the problem?
>>
>> Best regards,
>> Krzysztof
>
> Basically I use thermal testing.
>
> # git clone https://git.linaro.org/power/pm-qa.git
> # cd pm-qa
> # make -C thermal check
>
> most of the testcase failed on Exynos5422 but some pass on Exynos4412.
>
> Attach is the software overview from Exynos5422 user manual.
>
> I am not able to explain in deep technically, but I have studied other thermal
> driver to draw into conclusion that tmu clk's need to be enabled.

That is true in general - the clk has to be enabled in certain cases.
However you did not say at all when you want this clock to be
enabled... and the your patch enables it for entire lifetime of
device.

> If you feel the we should not enable these clk, them I will drop the
> clk_prepare_enable check
> and resubmit the changes with better commit message.

I don't know. This was fifth email in this thread and it is the first
time some real problem is mentioned. Still the issue is not described
entirely so I really do not have a clue whether this patch fixes
something or not.
What is more, you mentioned falling pm-qa tests here (not in commit
msg) but did not say whether this patch fixes anything or not.

So let me summarize it:
1. You did not describe the problem you want to fix.
2. The patch looks incorrect because it enables the clock for entire
lifetime of device which we do not want.
3. The patch might or not might fix some problem. We even do not know what...
4. The clock not being enabled when not needed... is obviously not a problem.

Please start from beginning. Find the problem, tell us how it can be
reproduced and deliver a single patch which fixes the problem.

This pattern of your code - fixing something without describing the
problem - happened many time before. I repeated this some times before
as well. I would prefer not to repeat to many times. Therefore I would
be happy if you follow the path mentioned in paragraph before always:
find the problem, tell how it can be reproduced, deliver single patch
which fixes the problem.

Best regards,
Krzysztof
