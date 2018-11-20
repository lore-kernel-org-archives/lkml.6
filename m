Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8249BC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3842A214DE
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RF/IHwW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3842A214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeKUGHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:07:12 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39074 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeKUGHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:07:12 -0500
Received: by mail-ua1-f66.google.com with SMTP id k10so1071786ual.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxASxAi720NLxxTHSY6dTLH5LCfoJ0gZ12XZK2NLFLc=;
        b=RF/IHwW1ncnZ9MIi45M7DkOwUAWKxQHPcVxIf19Gzishm93pNN9Q/hAOA+USdcJki4
         md/aniknIPI6lwu3fxF5IoXaXpq+XU7Y1hn8cE/CIJF54eLOy3QNXEC4GAgJNhoQz/PC
         FJknugZCPLFDPb2tUkEs4ft2IFIUdnpdYYrzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxASxAi720NLxxTHSY6dTLH5LCfoJ0gZ12XZK2NLFLc=;
        b=uHEeZkxJNwfpTz5Jtdfq1E4EofK/bHgbcyzEDl1y+FTSNaFFZYyHZ9Xxnax54CRWcc
         nfERXE0V1NWoiAqXCf4hUdE6+2Kc4PTJDYglyiuPb9Mkp8D/ZCQ1AUK0KAv+/BMi4ngX
         fONgqerSd3SMAZD4yOnNbofIUNhTAQoP46Q1M2RtWZv2sZPaPGWgPfGFE0yy5yDuIoE3
         qdfwns6nde0IvWOHdI32BlRJ69AM2VOVNlVQueveoKtGR03zEEPhDQCjK2eIXArvslfy
         JdTimXkfHHWa3FznQcezoW6A3lpFJlrMbzz6ya7uWI7lb+WaNYcn1xMXRhO4jk+p+Czh
         JdoQ==
X-Gm-Message-State: AA+aEWZGp5h9yCgiycGthb2b10xlYAhNUqAGKu8J00qjPuoXm5xfxQEp
        kVJktlbVWF9EOQn+iMt3IC+tJ+bd9O4=
X-Google-Smtp-Source: AFSGD/W5vC+gfyf9U1VZnemIlwHVg6663BT0SXZgRDUwgeClBp+VBzU+1swa9bg3z2uy5/1hMBfdOQ==
X-Received: by 2002:ab0:7196:: with SMTP id l22mr1545673uao.3.1542742584902;
        Tue, 20 Nov 2018 11:36:24 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 7sm1426296vky.37.2018.11.20.11.36.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 11:36:23 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id b74so1791680vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:36:21 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr1306132vsv.20.1542742580685;
 Tue, 20 Nov 2018 11:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20180927212253.177200-1-mka@chromium.org> <20181120182133.GR22824@google.com>
In-Reply-To: <20181120182133.GR22824@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 11:36:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XgnzYBgFb7PJCn4Exr2Y9zkfWJHSAVqskgPAtQtCfgLg@mail.gmail.com>
Message-ID: <CAD=FV=XgnzYBgFb7PJCn4Exr2Y9zkfWJHSAVqskgPAtQtCfgLg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: pm8998: Use ADC temperature to
 temp-alarm node
To:     Matthias Kaehlcke <mka@chromium.org>
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

On Tue, Nov 20, 2018 at 10:21 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Thu, Sep 27, 2018 at 02:22:53PM -0700, Matthias Kaehlcke wrote:
> > The temperature information from the temp-alarm block itself is very
> > coarse ("temperature is above/below trip points"). Provide the driver
> > with the die temperature channel of the ADC on the PMIC for more precise
> > readings.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > - based on agross/for-next (7a002fe0179c "Merge branch
> >   'defconfig-for-4.20' into all-for-4.20-redo"))
> > - depends on e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
> >   from IIO pull request:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.20a
> > - to work properly https://patchwork.kernel.org/patch/10594491/ is
> >   needed
> > ---
> >  arch/arm64/boot/dts/qcom/pm8998.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > index 048f19fa0150..fab5a826fb01 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > @@ -58,6 +58,8 @@
> >                       compatible = "qcom,spmi-temp-alarm";
> >                       reg = <0x2400>;
> >                       interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
> > +                     io-channels = <&pm8998_adc ADC5_DIE_TEMP>;
> > +                     io-channel-names = "thermal";
> >                       #thermal-sensor-cells = <0>;
> >               };
> >
>
> I think this should be ready to land in for-next now that "arm64: dts:
> qcom: pm8998: Add die temperature channel node to the ADC"
> (a789fd0bab57) has been added.

Agreed and this matches my understanding of how things are supposed to
work.  FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
