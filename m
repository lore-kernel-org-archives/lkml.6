Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F21DECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE9B2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JRijG3ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE9B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeJZPWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:22:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54258 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZPWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:22:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id l26-v6so321899wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 23:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=N1y7FaJ1MTdNaOElT/c2zGHayRSnq25mQagMp3Ikg90=;
        b=JRijG3ti6azTRh1LBFMw+VaUYC87p1I3pnJfx4bNXeW4Q0sIaD/LdYj7BSigRaLNAt
         5kGAFAPmLO9w+NKFYAwqqJ/wxxtDRWJJq432IJC1621ikMCUop3zdYB1Z08fHAz+ZyZR
         BKWRQHABSFHMP+3MyR92Nv+WWc6FbQONN39Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=N1y7FaJ1MTdNaOElT/c2zGHayRSnq25mQagMp3Ikg90=;
        b=IoXsR0J4b1LWZKKeddO7XQ0EObFz+MpYo4dfkmdI6KJ/ZOHEBNV94E2uDry9aKSPls
         NOpKly3gRka0ZUgFO02oJUjXmbPCxbeLKxI1uS7WH2lsJJqixP60y176DGQ+Z8Z75xmp
         iufcWkVOixEdoWAuLTL7Dl4Ygg0aBAntZWQ7C9N0MhRNx3l3rz6CRSRqf/ttv/dlsS2y
         jKltI7IWlG8B0yUpZiFCuF7A8qDbIXdtfaXtWwn447rPOVdn/ftYHd4AX2d50XKyTy6/
         NwJaeCGUU25whCr6uJS9ra2vLakCwqZ0UcF7vXndHVDVUz3VL7twJLrOnMImLh+tV0Ub
         4JeQ==
X-Gm-Message-State: AGRZ1gIvDuD8xuA4F9/iJAlGsGukD3i2ByepRIb7efhjEw3ofc5pnRDL
        fbl3+ey0zmgkcT/QcsWNpfe6JA==
X-Google-Smtp-Source: AJdET5ddoX8NCRIFv/FGzOvHT8KdzzuEvW7BtvcQulIbqhHtsMEhQKHWIM0r4R5eycF7YA4TXvQfnQ==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr4462319wmf.109.1540536377040;
        Thu, 25 Oct 2018 23:46:17 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id x197-v6sm4930462wme.15.2018.10.25.23.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 23:46:16 -0700 (PDT)
Date:   Fri, 26 Oct 2018 07:46:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Pascal PAILLET-LME <p.paillet@st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: mfd: document stpmic1
Message-ID: <20181026064614.GG4870@dell>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-2-git-send-email-p.paillet@st.com>
 <20181025094430.GQ4939@dell>
 <CAL_JsqKsp8kTK2v_cBrNm+enzieQSEh2G7KMxsBdidr+XhDwTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKsp8kTK2v_cBrNm+enzieQSEh2G7KMxsBdidr+XhDwTg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018, Rob Herring wrote:

> On Thu, Oct 25, 2018 at 4:44 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Rob: please grep your name for some feedback.

[Moved to the top]

> > I'm surprised Rob allowed you to add register bits in a DT property?
> 
> Yeah, they are certainly questionable and not something we encourage,
> but the alternative would be dozens of properties which only apply for
> this one device and just get translated back to register values.

I don't see how this device is any different to the 100's of devices
which are already supported in DT.

> > On Thu, 18 Oct 2018, Pascal PAILLET-LME wrote:
> >
> > > From: pascal paillet <p.paillet@st.com>
> 
> > > +Optional parent device properties:
> > > +- st,main-control-register:
> > > +     -bit 1: Power cycling will be performed on turn OFF condition
> > > +     -bit 2: PWRCTRL is functional
> > > +     -bit 3: PWRCTRL active high
> > > +- st,pads-pull-register:
> > > +     -bit 1: WAKEUP pull down is not active
> > > +     -bit 2: PWRCTRL pull up is active
> > > +     -bit 3: PWRCTRL pull down is active
> > > +     -bit 4: WAKEUP detector is disabled

This should be part of the Pinctrl configuration/driver.

And Pinctrl probably already has properties for this?

> > > +- st,vin-control-register:
> > > +     -bit 0: VINLOW monitoring is enabled
> > > +     -bit [1...3]: VINLOW rising threshold
> > > +             000 VINOK_f + 50mV
> > > +             001 VINOK_f + 100mV
> > > +             010 VINOK_f + 150mV
> > > +             011 VINOK_f + 200mV
> > > +             100 VINOK_f + 250mV
> > > +             101 VINOK_f + 300mV
> > > +             110 VINOK_f + 350mV
> > > +             111 VINOK_f + 400mV
> > > +     -bit [4...5]: VINLOW hyst
> > > +             00 100mV
> > > +             01 200mV
> > > +             10 300mV
> > > +             11 400mV
> > > +     -bit 6: SW_OUT detector is disabled
> > > +     -bit 7: SW_IN detector is enabled.

This should be part of the Regulator configuration/driver?

> > > +- st,usb-control-register:
> > > +     -bit 3: SW_OUT current limit
> > > +             0: 600mA
> > > +             1: 1.1A
> > > +     -bit 4: VBUS_OTG discharge is enabled
> > > +     -bit 5: SW_OUT discharge is enabled
> > > +     -bit 6: VBUS_OTG detection is enabled
> > > +     -bit 7: BOOST_OVP is disabled

This should be part of the USB configuration/driver?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
