Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4470EECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7382083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+hZUcad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7382083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeJSQcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:32:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40767 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeJSQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:32:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id g21-v6so9160482pfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z2CmEEME1S7DZlf+bnRUisRISuRM6nweM1fgMLPFTNo=;
        b=j+hZUcadCv3F0QlMxMwLx8mN6reMQ/uvO2umVQWRvAEfKpYvYEY/Qx3UqIcTzVhs/R
         hDuddB09++01XgNBqtKaIeNF9+auhOVHNKc8PQTwCZa//Ad/IQLgSnVpgommZQFf0K0a
         DDuOHODWMogYWz1FDXXhWGkOL/n/kTHQ8rYRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2CmEEME1S7DZlf+bnRUisRISuRM6nweM1fgMLPFTNo=;
        b=umUAacGhyZUOH0HQlnHR799av2m6lEJi0iWvfi5Le8PFaJaGpJCoEd20NF0ZJNXd5p
         R86q2pjXFnzSV+v98wGrQCSQ1M3JlLhAc137rfwpLQ253DDoikYF3C9Exu8N4tCZiBjy
         +J/fsx2qf9exe0DbcXKKadoQS1MSuKJcO5wxBb5PMIIhGnRN0aN9NRSZvARc9s7pG/fx
         1luS95EiJr5RcfyAnYEkAolNj9jOpOSl/2V7rVAGdzOGGlTO1TDhM3WD3pXT0XR0sK6D
         B9FUxMLkZBxCVw4wRZQRh/aQnbcl2b/2mUFDBIOYXD+5myhFbIFlYMLCoQ/k0y/oYfWP
         WmCg==
X-Gm-Message-State: ABuFfogog+MSS8Ru6XPyOn/bRzDLw9ymyB9aJ81sFGgqopnzh+o7m+7D
        nzqTO0OE/lfpb5n3I9jZnMln
X-Google-Smtp-Source: ACcGV639H4jBu4xdSm6+TnFY0XV5p+kepy3I0aZ8QGXBTCuRzuShYrCzf3h0GFJUFLhdi1YX4XOLxw==
X-Received: by 2002:a63:ff23:: with SMTP id k35-v6mr31650693pgi.62.1539937640865;
        Fri, 19 Oct 2018 01:27:20 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:7346:d6ac:9463:8a51:344:35b8])
        by smtp.gmail.com with ESMTPSA id w66-v6sm17383383pfb.51.2018.10.19.01.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 01:27:20 -0700 (PDT)
Date:   Fri, 19 Oct 2018 13:57:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Sean Wang =?utf-8?B?KOeOi+W/l+S6mCk=?= <sean.wang@mediatek.com>,
        linus.walleij@linaro.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] arm64: dts: mediatek: mt6797: Add pinctrl support
Message-ID: <20181019082713.GA2641@Mani-XPS-13-9360>
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
 <20181008191411.32555-3-manivannan.sadhasivam@linaro.org>
 <CAGp9LzoSA=06CF_yNMOHnfmRnFzpBA4R2YGhbWmxdSKci2uF0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGp9LzoSA=06CF_yNMOHnfmRnFzpBA4R2YGhbWmxdSKci2uF0w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:07:52PM +0800, Sean Wang wrote:
> On Tue, Oct 9, 2018 at 3:16 AM Manivannan Sadhasivam <
> manivannan.sadhasivam@linaro.org> wrote:
> 
> > Add pinctrl support for Mediatek MT6797 SoC.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt6797.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> > index 4beaa71107d7..231230d32d09 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> > @@ -14,6 +14,7 @@
> >  #include <dt-bindings/clock/mt6797-clk.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/pinctrl/mt6797-pinfunc.h>
> >
> >  / {
> >         compatible = "mediatek,mt6797";
> > @@ -129,6 +130,19 @@
> >                 #clock-cells = <1>;
> >         };
> >
> > +       pio: pinctrl@10005000 {
> > +               compatible = "mediatek,mt6797-pinctrl";
> > +               reg = <0 0x10005000 0 0x1000>,
> > +                     <0 0x10002000 0 0x400>,
> > +                     <0 0x10002400 0 0x400>,
> > +                     <0 0x10002800 0 0x400>,
> > +                     <0 0x10002C00 0 0x400>;
> > +               reg-names = "gpio", "iocfgl", "iocfgb",
> > +                           "iocfgr", "iocfgt";
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +       };
> > +
> >
> 
> The content looks good to me, but the dt-binding document is still being
> added the support for MT6797 SoC before the dts instance is being applied.
> 
>

Okay, will add a binding doc in next revision.

Thanks,
Mani

> >         scpsys: scpsys@10006000 {
> >                 compatible = "mediatek,mt6797-scpsys";
> >                 #power-domain-cells = <1>;
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> >
