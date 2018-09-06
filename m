Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF81EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7628320659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="anT1rZiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7628320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeIGA56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:57:58 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37553 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbeIGA55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:57:57 -0400
Received: by mail-ua1-f68.google.com with SMTP id y10-v6so10152569uao.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kFlKKQ+/69uIIR4WJO5EdC1jtbtoFf9Pi3YWjYW+e8k=;
        b=anT1rZiSFW54boC0agWYT9t7tfbxpCY5e6r8pOniulL2yW3ONqQhEHrRTFw7Q0MoFr
         UV+7wEGNMqSO8mW/onqQcTRVssErMjR8s/pG8kgD54wGXuY6Ld4JNlde/nrh4HimyByM
         ES79Ya2oGFY7INab6TBfL4k9kJaM9EIa8jzAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kFlKKQ+/69uIIR4WJO5EdC1jtbtoFf9Pi3YWjYW+e8k=;
        b=WiQxaLeTnpdkIGKitMrw3XOdYFXg27w4MJLBibIDFX8xlwTcEHildweXoynjO1rZM5
         p/FJpCHMCyo5WtrcAklPR2QELfBYErVZKZ5omMaYgYVhUeejGL1CPya0fdPwgpKqGNW1
         SRcjXJ0RnIJmxTCpilEOOu6Mt5g0TjvVWUwPplAtrywEs0Cf2HI52IHBsyOjYlK/NlXm
         A07hAQhR7NFAdj7PwHq7FM1iQUgto1TiVChWQxY1v98LWGSuTjqX31Ub5OInMNmH8Jeo
         NBd8bJc/YmM+0Sdk+JrW6KolzixvE9EhmDiAyNaX5IDJ7nciphataDkhWvBWBd48zu1+
         bHvg==
X-Gm-Message-State: APzg51DzQ9eVZareH6LtjnJVJwhXXWLZIk+5iInxaPaJkuO6kNpIQLki
        Le+CNN3+Z1xoXHOTQI/3K8/cLC40oX8=
X-Google-Smtp-Source: ANB0VdZsM9C+Prww0VwshJwU+uyePAxrteWTeLurLKQecuNcfxbmOtPp7/xi63T0Pmm76N6k6AxnXg==
X-Received: by 2002:a1f:aa8a:: with SMTP id t132-v6mr1629383vke.80.1536265250615;
        Thu, 06 Sep 2018 13:20:50 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id n14-v6sm3323810uai.40.2018.09.06.13.20.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 13:20:49 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id g18-v6so10160375uam.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 13:20:49 -0700 (PDT)
X-Received: by 2002:a1f:a784:: with SMTP id q126-v6mr1644098vke.70.1536265248957;
 Thu, 06 Sep 2018 13:20:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:5e8e:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 13:20:48 -0700 (PDT)
In-Reply-To: <20180906201206.GX2523@minitux>
References: <20180901221953.21666-1-bjorn.andersson@linaro.org>
 <CAD=FV=VE5gYyivgy=OrZV6g0UrtYfZZ+CGv7DV+v5be3teVSdw@mail.gmail.com> <20180906201206.GX2523@minitux>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Sep 2018 13:20:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Whf=Y3xrrOO46gA5EwxssJFxt1dZ9B=5=np=fo8R3dSQ@mail.gmail.com>
Message-ID: <CAD=FV=Whf=Y3xrrOO46gA5EwxssJFxt1dZ9B=5=np=fo8R3dSQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: pm8998 and pmi8998 regulators
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 6, 2018 at 1:12 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>> * Seems to have a few rails named differently LDO22 is named
>> "vreg_l22a_2p95" in your DTS but "vreg_l22a_2p85" in mine as one
>> example.  The schematics I have (from Dec 5, 2017) show it as 2p85.
>>
>
> Looks like a typo on my part, yours matches the schematics I have as
> well.

OK.  That was just one example.  Maybe do a diff of the two and see if
you find any where you believe your patch was right and mine was
wrong.


>> * Is lacking many alternate names for rails.  We can debate this also
>> if you want.
>>
>
> Afaict names such as "vdda_pcie_1p2" is the name of the pin on the
> SDM845, while the thing that comes out of the regulator is named
> vreg_l26a_1p2.
>
> So I believe this name should be used in the pcie node as:
>
>   vdda_pcie_1p2-supply = <&vreg_l26a_1p2>;

Adding labels for things like "vdda_pcie_1p2" is based on a suggestion
Stephen Boyd made to me that he felt it would be nice to be able to
refer to things by the name of the supply pin on the SoC.  This could
possibly enable better sharing of device tree snippets between
different boards using the same SoC and the idea seemed sane to me, so
I implemented it.  I described it in my commit message like this:

- Regulators that are hooked up to supply pins on the SoC are given
  an alias matching the name of that pin (pin name comes from the
  Qualcomm SoC "device specification" doc).

If folks don't like it, though, it's easy to remove.

>> * Have a few voltage values different.  If you have better info than
>> me we should update to yours.  Diffing against yours does make me
>> believe that perhaps LDO14 should be listed as 1.88 V in my patch.
>>
>
> Downstream it's listed as min: 1.8V max: 1.88V init: 1.8V.

I can change mine to that.  It's a very strange specification though.
Is it really 1.80 - 1.88 V?  Does something out there actually need
the voltage to be variable in this small range?


>> * Is lacking pm8005.
>>
>
> I didn't need this, yet...

OK.  I can certainly remove it as needed--the downstream patch I
started with had it so I figured I'd keep it in.


-Doug
