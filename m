Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF25ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441812075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfwxTzeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441812075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeGRGyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbeGRGyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:54:06 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A677C20850;
        Wed, 18 Jul 2018 06:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531894672;
        bh=dTkzOv+g7gnmCnjtc/aD4Sic0Oz+GgcatWQ7/GhmLqU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=NfwxTzeVFSWRIaynZtofILittMnh0mdcHTO6qU119cWIWbQlV1AAXrjCREg/6GrVh
         x2hCGadVUu1/Gw+mfVCY1PJmfwSRVRnZFzvFGu71GPEnzXh+tYLCZCswv4F8WVpqtU
         dW5/Iar9Uf3/dZLoO7Jmw8NQIcfzKnUiozU8tmmA=
Received: by mail-wm0-f50.google.com with SMTP id 69-v6so1532371wmf.3;
        Tue, 17 Jul 2018 23:17:52 -0700 (PDT)
X-Gm-Message-State: AOUpUlGARvE9tc70aGpM06otO/TkNxtGiR82I8m3M7pEZUzGqs6PInxp
        uI/EWKtCxHgx9Wsdc86HsRrHKRHHD5tZssIX/Gw=
X-Google-Smtp-Source: AAOMgpfgXBn2sly0wPtXW5c3TTAAqu9XXcsli4iOcb6TO6COD+/efiI5T94iPzkV3BgHzAyS3+sguDIKFY0J5vUo0po=
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr612493wme.135.1531894671152;
 Tue, 17 Jul 2018 23:17:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 23:17:50
 -0700 (PDT)
In-Reply-To: <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com> <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Jul 2018 08:17:50 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com>
Message-ID: <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com>
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

On 17 July 2018 at 22:23, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Krzysztof
>
> On 17 July 2018 at 17:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> Hi Anand,
>>
>> Thanks for patch.
>>
>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>> clk_summary do not show tmu_apbif clk enable, so replace
>>> the clk_prepare with clk_prepare_enables to enable tmu clk.
>>
>> This is not valid reason to do a change. What is clk_summary does not
>> really matter. Your change has negative impact on power consumption as
>> the clock stays enabled all the time. This is not what we want... so
>> please explain it more - why you need the clock to be enabled all the
>> time? What is broken (clk_summary is not broken in this case)?
>>
>
> Opps I could not explain some more in my commit message.
>
> Actually TMU sensor for Exynos process are controlled by so external clk
>
> Exynos4412 have VDD18_TS sensor which controls the CLK_SENSE tmu.
> Exynos5422 have VDD18_TS01 / VDD18_TS23 / VDD18_TS4 sensor which
> control the CLK_SENSE tmu.
>
> So as per my understanding tmu is clk driver which control the flow  PMIC.
>
> clk_prepare_enable combine clk_prepare and clk_enable
> and clk_disable_unprepare combine clk_disable and clk_unprepare.
>
> most of the driver prefer clk_prepare_enable and clk_disable_unprepare.
>
> clk_summary is just a reference looking point where we could check the
> clk is enable/disable.
>
> what is broken ?
> I still few more parameter need to tuned to configure the tmu driver.

I am sorry but I am still unable to see what is broken and what are
you trying to fix. I asked what is broken and you replied that there
is a sensor, there is a clock, drivers use clk_prepare_enable and some
more parameter need to be tuned... None of these are answers to
question - what is broken. How can I reproduce the problem?

Best regards,
Krzysztof
