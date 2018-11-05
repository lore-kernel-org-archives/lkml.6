Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F3CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAA12081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HtRL+MA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAA12081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbeKFCNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:13:30 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33563 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbeKFCNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:13:30 -0500
Received: by mail-vs1-f68.google.com with SMTP id p74so5531529vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyyUKHmtexwbpZfeWTOttjiouC1YbaLmdZ2FAklqlcc=;
        b=HtRL+MA7LPQS7WsvxNfQjR47oBTR9wZBOaVQn0ZEGdFWS9rBxNQB4Tr2e1z3raFmDh
         pfaD8yXuDj3oQs4i3PDs9st0VpxqdY02Ip5yyrCcc/U9zJplibxch5TzFjfSIp1RBpIK
         tO3Wyw3AJMVWXiGgiq/KUM16jLz78wXVTHs8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyyUKHmtexwbpZfeWTOttjiouC1YbaLmdZ2FAklqlcc=;
        b=lJQOgz7ROwh9iERfLs1KGOm/ammeU+b1yUg01ge4NR0Nk5kazKo8m75dD4v0311imx
         7zjolwdb0Y8yWkCAQIOgVvsH4pPxudYDaZ5kraXsCJ2hzdWlSJP0J5IEf/oPjUkIouVD
         mgBiadWck4FUmR2SKAZyDP72pBZoDr/nBUj8L6XoGP5dhhm8v//wiOveIZM6bU6Dmmbm
         K5OfqV6PDHP5YfdZSvRxWtq5cnwOTeMP+rV4sfMgMbdaIzjOGhxvs+uCuDaoMZ8Z2x8f
         8y7K3vsW1oHIm1vv/ss2h8siBgP+57wP9MsO3Py4JMpIdmlWw1w7TYawOy1kRGQjhsyr
         hiPQ==
X-Gm-Message-State: AGRZ1gLP3ePWyQliHlbXDdBpwFu1J8VP9I+mB0qE4g7GE5AkwWETQr37
        bKQSCrGI5X0yWOPYPz7ivsbCA41+lwE=
X-Google-Smtp-Source: AJdET5eFOQUr1TWXDaG1s1Oz7mXBbdNkfJfB4Rk2dohEWtS6iqgl3B9epJfQJhOP69eJAYf96VA1Dg==
X-Received: by 2002:a67:8a88:: with SMTP id m130mr9646146vsd.206.1541436775672;
        Mon, 05 Nov 2018 08:52:55 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id b77sm11354014vka.21.2018.11.05.08.52.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:52:54 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id z11so1505943uaa.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:52:54 -0800 (PST)
X-Received: by 2002:a9f:3829:: with SMTP id p38mr10470451uad.25.1541436773650;
 Mon, 05 Nov 2018 08:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20181026173544.136037-1-evgreen@chromium.org> <20181026173544.136037-2-evgreen@chromium.org>
 <154129921872.88331.15831802252403117971@swboyd.mtv.corp.google.com>
In-Reply-To: <154129921872.88331.15831802252403117971@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 5 Nov 2018 08:52:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UKfDsthT4W3H4jR0Qvw-izLShCjWngN2uBrY-FUEtDDQ@mail.gmail.com>
Message-ID: <CAD=FV=UKfDsthT4W3H4jR0Qvw-izLShCjWngN2uBrY-FUEtDDQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: phy-qcom-qmp: Fix register underspecification
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        cang@codeaurora.org, LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 3, 2018 at 7:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2018-10-26 10:35:40)
> >                         (or)
> > @@ -150,3 +153,54 @@ Example:
> >                 ...
> >                 ...
> >         };
> > +
> > +       phy@88eb000 {
> > +               compatible = "qcom,sdm845-qmp-usb3-uni-phy";
> > +               reg = <0x88eb000 0x18c>;
> > +               #clock-cells = <1>;
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges;
> > +
> > +               clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
> > +                        <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> > +                        <&gcc GCC_USB3_SEC_CLKREF_CLK>,
> > +                        <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
> > +               clock-names = "aux", "cfg_ahb", "ref", "com_aux";
> > +
> > +               resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
> > +                        <&gcc GCC_USB3_PHY_SEC_BCR>;
> > +               reset-names = "phy", "common";
> > +
> > +               lane@88eb200 {
> > +                       reg = <0x88eb200 0x128>,
> > +                             <0x88eb400 0x1fc>,
> > +                             <0x88eb800 0x218>,
> > +                             <0x88eb600 0x70>;
> > +                       #phy-cells = <0>;
> > +                       clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
> > +                       clock-names = "pipe0";
> > +                       clock-output-names = "usb3_uni_phy_pipe_clk_src";
>
> If this has clock-output-names then I would expect to see a #clock-cells
> property, but that isn't here in this node. Are we relying on the same
> property in the parent node?

If I had to guess, I believe it's yet more confusing than that.  I
believe you actually point to the parent phandle if you want to use
the clock.  I notice that the parent has #clock-cells as 1 so
presumably this is how you point to one child or the other?  ...but I
don't think it's documented how this works.  The lane nodes don't have
any sort of ID as far as I can tell.  ...and in any case having
#clock-cells of 1 makes no sense for USB 3 PHYs which are supposed to
only have one child?

Let's look at the code, maybe?  Hrm, phy_pipe_clk_register() takes no
ID or anything.  Huh?  OK, so as far as I can tell
of_clk_add_provider() is never called on this clock...

So I think the answer is that #clock-cells should be <0> and should
move to the child node to match with clock-output-names.  Then I guess
(if anyone references this clock from the device tree rather than
relying on the global clock-output-names) we should add the
of_clk_add_provider() into the code?

Maybe we can add that as a patch to the end of this series?  There are
so many crazy / random things wrong with these bindings that it makes
sense to make smaller / incremental changes?


-Doug
