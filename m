Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA901C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897EE20827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zf1LgOQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897EE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbeJ2SUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:20:15 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33678 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbeJ2SUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:20:15 -0400
Received: by mail-it1-f196.google.com with SMTP id p11-v6so36113itf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SNO+ayWg/9EyhuzToV8/RxVoQmSYNNM48hMqxYcoPzg=;
        b=Zf1LgOQvuxnNti47UEn/JnMXAAvu3D2u4BZ3+sLqfUu5QHUX1Nhwny2Zx4emhVnQ/E
         ztemPbl1vRVlGStZfulA2Lpf/n2UWTxjGGakK3j5idR4hB6Q7KD1rlmiOO8h/mp/r6HP
         f64vyteW21WM/L416EUXx1JAVNFHi4iiX7rAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SNO+ayWg/9EyhuzToV8/RxVoQmSYNNM48hMqxYcoPzg=;
        b=Fet538IjhpmTIQxWli4zitPtF7NGc/dYm98jq5+ABT4aKDHTF3m0W0sMa9VHgjh+Nh
         cTUY1NriaOivY6Acr8BCHRSaYh0Qde3GbI0BDm5Q8Z4ZknVh2tfdzRyGJEFsomHeWMII
         toA4Y+wDxBkm55AHl8kHUy7dbknqir0tzG/r/zrVsUt+lHtsJFnXcrT4pt1WI1wK+mur
         dM9DDSyndlm4UvdC/NQzQwtJSkK2tJyE+wDqjfmDeP3I6D64tNiA7H/GtduXg4tbogOg
         EIGddeqXZXYVZbetIQa1ntZhmaYYW7HsBesaCNTD+isSYTtSMzTntB4YVMoJcAeOH1kX
         4jcA==
X-Gm-Message-State: AGRZ1gIdKNS0AJWM633+VxVDOs7fTJztMJbMs5WzNrRKqpXHFSB0HVh7
        vdIUaj/pqSbr8LLBXaOJGKVN
X-Google-Smtp-Source: AJdET5copP7RjtHUhrDCM/v/h4vFwgMzVnICn1w6edRhfQLhX07w2L41n3dVKkbPSf1oNHEQtzTugw==
X-Received: by 2002:a02:8646:: with SMTP id e64-v6mr513882jai.113.1540805544661;
        Mon, 29 Oct 2018 02:32:24 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6091:9d4b:9d82:66b9:3ee6:ffac])
        by smtp.gmail.com with ESMTPSA id t190-v6sm7104063ita.39.2018.10.29.02.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 02:32:24 -0700 (PDT)
Date:   Mon, 29 Oct 2018 15:02:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        ezequiel@collabora.com, Wei Xu <xuwei5@hisilicon.com>,
        Michal Simek <michal.simek@xilinx.com>, pavel@ucw.cz,
        Andy Gross <andy.gross@linaro.org>, linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, koen.kooi@linaro.org,
        nicolas.dechesne@linaro.org
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: apq8016-sbc: Standardize LED
 labels
Message-ID: <20181029093210.GA6110@Mani-XPS-13-9360>
References: <20181029090006.4353-1-manivannan.sadhasivam@linaro.org>
 <20181029090006.4353-8-manivannan.sadhasivam@linaro.org>
 <CAHLCerM91ukzAJZHaxXxwoHU-6mVUV+X9_y_Rs0zmybNnRJCfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerM91ukzAJZHaxXxwoHU-6mVUV+X9_y_Rs0zmybNnRJCfA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 02:47:11PM +0530, Amit Kucheria wrote:
> On Mon, Oct 29, 2018 at 2:31 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > For all 96Boards, the following standard is used for onboard LEDs.
> >
> > green:user1  default-trigger: heartbeat
> > green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> > green:user3  default-trigger: mmc1 (SD-card)
> > green:user4  default-trigger: none, panic-indicator
> > yellow:wlan  default-trigger: phy0tx
> > blue:bt      default-trigger: hci0-power
> >
> > So lets adopt the same for APQ8016 SBC (Dragonboard410c), which is
> > one of the 96Boards CE platform.
> 
> You are missing a signed-off here :-)
>

ahh, my bad. Will fix it in next revision.

Thanks,
Mani

> Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
> 
> > ---
> >  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > index 46feedf7c989..35f95154316b 100644
> > --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > @@ -300,28 +300,28 @@
> >                         compatible = "gpio-leds";
> >
> >                         led@1 {
> > -                               label = "apq8016-sbc:green:user1";
> > +                               label = "green:user1";
> >                                 gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
> >                                 linux,default-trigger = "heartbeat";
> >                                 default-state = "off";
> >                         };
> >
> >                         led@2 {
> > -                               label = "apq8016-sbc:green:user2";
> > +                               label = "green:user2";
> >                                 gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
> >                                 linux,default-trigger = "mmc0";
> >                                 default-state = "off";
> >                         };
> >
> >                         led@3 {
> > -                               label = "apq8016-sbc:green:user3";
> > +                               label = "green:user3";
> >                                 gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
> >                                 linux,default-trigger = "mmc1";
> >                                 default-state = "off";
> >                         };
> >
> >                         led@4 {
> > -                               label = "apq8016-sbc:green:user4";
> > +                               label = "green:user4";
> >                                 gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
> >                                 linux,default-trigger = "none";
> >                                 panic-indicator;
> > @@ -329,14 +329,14 @@
> >                         };
> >
> >                         led@5 {
> > -                               label = "apq8016-sbc:yellow:wlan";
> > +                               label = "yellow:wlan";
> >                                 gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
> >                                 linux,default-trigger = "phy0tx";
> >                                 default-state = "off";
> >                         };
> >
> >                         led@6 {
> > -                               label = "apq8016-sbc:blue:bt";
> > +                               label = "blue:bt";
> >                                 gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
> >                                 linux,default-trigger = "bluetooth-power";
> >                                 default-state = "off";
> > --
> > 2.17.1
> >
