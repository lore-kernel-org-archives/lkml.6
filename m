Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A24BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21825205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENOYDFrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21825205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeJZUXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 16:23:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40787 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbeJZUXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 16:23:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id b203-v6so1143814wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 04:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NwG1Hi1zJtxPRjgtkYXVxzAQH2n3wxiUQmfEO2YaZvw=;
        b=ENOYDFrZeZj3BZUAWtV+l6jr7XghTErAnGGl8DIce1ay3RMyNck9urv/L1AD+9gD0G
         b55g8FZtDuRJFJm31OApW05QCxx9482JD+/a7Eon3bxmeFsjImxxqbs+wDut2CIv9IGp
         +sXkND1Bqez3pswrru2cXq/FFX0CqfCsamSzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NwG1Hi1zJtxPRjgtkYXVxzAQH2n3wxiUQmfEO2YaZvw=;
        b=GLs8LzbrTYJo21TUuT5TsIOHz/iwMGdVX5w8IN7zjdUfCocSwp//hjHUnOA3wHWwSX
         7vnubGCxoDs98ylKxisOcgiiaEmVNt5T2qAxGEOaH3oFp8WSZfZVhc7XPWW4SSpaJ/Iu
         iWUskOcPDdqfHhdgRHa8sQskcJlDtWKwv3nesfi1Pz3zeqC0uQxTbp1EzK8vKgqOekKU
         RKhSPuT7J+cgrIllD4OkEctbGtsNU7F9lhO5BMnovVL3LxljmB2EnyLr8QrDjv8J5AnD
         yAx/tyArKMQdeFrbKdXzXJ+r9hMnnlh9+gKdTrCaD3GFUNVBO4DbTfDV0DfJKqeInP39
         d0IA==
X-Gm-Message-State: AGRZ1gJcnMzsJ+FYJuWnopJlyvKSa+OiNZPhM26SvQjvgjha99JLU5no
        0XYDX+kbsyhdHLZtEQY7FLN3SA==
X-Google-Smtp-Source: AJdET5fnH5JIkEEzmhMCpTWnV9Mwepw68B9kgnT/pnz1vXZJpfwNQX6G5UjdJUy1qJ3SFJ60E3UH+w==
X-Received: by 2002:a1c:8288:: with SMTP id e130-v6mr5073464wmd.84.1540554381168;
        Fri, 26 Oct 2018 04:46:21 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id a1-v6sm8896545wrt.79.2018.10.26.04.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 04:46:20 -0700 (PDT)
Date:   Fri, 26 Oct 2018 12:46:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: mfd: document stpmic1
Message-ID: <20181026114618.GR4870@dell>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-2-git-send-email-p.paillet@st.com>
 <20181025094430.GQ4939@dell>
 <CAL_JsqKsp8kTK2v_cBrNm+enzieQSEh2G7KMxsBdidr+XhDwTg@mail.gmail.com>
 <20181026064614.GG4870@dell>
 <5BD2E2DB.5090305@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5BD2E2DB.5090305@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018, Pascal PAILLET-LME wrote:

> Hello Lee,
> 
> Le 10/26/2018 08:46 AM, Lee Jones a écrit :
> > On Thu, 25 Oct 2018, Rob Herring wrote:
> >
> >> On Thu, Oct 25, 2018 at 4:44 AM Lee Jones <lee.jones@linaro.org> wrote:
> >>> Rob: please grep your name for some feedback.
> > [Moved to the top]
> >
> >>> I'm surprised Rob allowed you to add register bits in a DT property?
> >> Yeah, they are certainly questionable and not something we encourage,
> >> but the alternative would be dozens of properties which only apply for
> >> this one device and just get translated back to register values.
> > I don't see how this device is any different to the 100's of devices
> > which are already supported in DT.
> >
> >>> On Thu, 18 Oct 2018, Pascal PAILLET-LME wrote:
> >>>
> >>>> From: pascal paillet <p.paillet@st.com>
> >>>> +Optional parent device properties:
> >>>> +- st,main-control-register:
> >>>> +     -bit 1: Power cycling will be performed on turn OFF condition
> >>>> +     -bit 2: PWRCTRL is functional
> >>>> +     -bit 3: PWRCTRL active high
> >>>> +- st,pads-pull-register:
> >>>> +     -bit 1: WAKEUP pull down is not active
> >>>> +     -bit 2: PWRCTRL pull up is active
> >>>> +     -bit 3: PWRCTRL pull down is active
> >>>> +     -bit 4: WAKEUP detector is disabled
> > This should be part of the Pinctrl configuration/driver.
> >
> > And Pinctrl probably already has properties for this?
> I will remove this in the next version.
> >>>> +- st,vin-control-register:
> >>>> +     -bit 0: VINLOW monitoring is enabled
> >>>> +     -bit [1...3]: VINLOW rising threshold
> >>>> +             000 VINOK_f + 50mV
> >>>> +             001 VINOK_f + 100mV
> >>>> +             010 VINOK_f + 150mV
> >>>> +             011 VINOK_f + 200mV
> >>>> +             100 VINOK_f + 250mV
> >>>> +             101 VINOK_f + 300mV
> >>>> +             110 VINOK_f + 350mV
> >>>> +             111 VINOK_f + 400mV
> >>>> +     -bit [4...5]: VINLOW hyst
> >>>> +             00 100mV
> >>>> +             01 200mV
> >>>> +             10 300mV
> >>>> +             11 400mV
> >>>> +     -bit 6: SW_OUT detector is disabled
> >>>> +     -bit 7: SW_IN detector is enabled.
> > This should be part of the Regulator configuration/driver?
> I will also remove this in the next version. I think this could be 
> handled by an hardware monitor future driver.
> >>>> +- st,usb-control-register:
> >>>> +     -bit 3: SW_OUT current limit
> >>>> +             0: 600mA
> >>>> +             1: 1.1A
> >>>> +     -bit 4: VBUS_OTG discharge is enabled
> >>>> +     -bit 5: SW_OUT discharge is enabled
> >>>> +     -bit 6: VBUS_OTG detection is enabled
> >>>> +     -bit 7: BOOST_OVP is disabled
> > This should be part of the USB configuration/driver?
> >
> I will also remove this in the next version. And I'm going to add active 
> discharge ops in the regulator driver.

And unless this device is in any way special, these subsystems should
already have generic bindings to set these hardware configuration
options.

I would say that passing raw register values is not the way to go.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
