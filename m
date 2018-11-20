Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD98DC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B2E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zd8qtoDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B2E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeKUF7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:59:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47058 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeKUF7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 00:59:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so1733053ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FqynL/MlYat1lmfS5LcLiL5aZBhRz0mmBacRUdllV7U=;
        b=Zd8qtoDHU0nWA1+KC7h+SGItXZf/hWcxUG11wUmuVP1ofbYD/a7tNUFlVIBVfw8Ynq
         5rnw3YFPy+xufPOotHDtKs0KaeIamby4KeIq51F2Nwk/xP5xIOJvFU6vnr3IrmneLlZm
         dEGII+p7nOqDdpKWeDNpOacHY4RxsWZCI1DCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FqynL/MlYat1lmfS5LcLiL5aZBhRz0mmBacRUdllV7U=;
        b=ZQVz+Ir77nCiX0M1dOkkQ6/q0FVtDSyyTPeTt+swWJB7BH4xV3LS8PBHH6rC8mvj4i
         P3aOSrZFc4/IIth5qmpCsCJQsqaDBktVoPkr6b/P//yNFiJG7agXNsvIlKzJ5xw/54qU
         B24SPhsOAy+xHyatAp7bFnm61RaxfMTnIYKxV09T16tw+PZH30iYrE4p88aLHI0Ga73U
         p+EArlmDyjUu2fYm/B8fvpVpE37AS4r4/GhnkqOI42+sKqxSoJNkHb8NDB9dJyZQxWeU
         Ljk+mFJl6aih/x1UZErxPpplriISp/4TAE/+oYHor/Cq2P7AJeAUjQWk63qnFwzLeNqn
         7ZTw==
X-Gm-Message-State: AA+aEWaPPLgTe3OBrbt1xwr7M0IzgepoEo4h9zduCU1Mf7l965gNK6lw
        TyadlNPvUCjxoPOc8grgadq9
X-Google-Smtp-Source: AJdET5fJ0SPR4SovXHQ/UTvcBJJhcXKkBLSCWN0epKy7EjxvHOSecgkOfRRJSHdaVUzramYn4l4bDg==
X-Received: by 2002:a65:4946:: with SMTP id q6mr2974681pgs.201.1542742133060;
        Tue, 20 Nov 2018 11:28:53 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6008:86c4:249a:6443:23f2:61f3])
        by smtp.gmail.com with ESMTPSA id g190sm44967904pgc.28.2018.11.20.11.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 11:28:52 -0800 (PST)
Date:   Wed, 21 Nov 2018 00:58:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, zhao_steven@263.net,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 08/16] arm: dts: rda8810pl: Add interrupt controller
 support
Message-ID: <20181120192842.GA16122@Mani-XPS-13-9360>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-9-manivannan.sadhasivam@linaro.org>
 <CAL_JsqL3B3y3hYv-yf3wzXiUsvnM9pCYE7u_Y0i4zT7wFti5GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL3B3y3hYv-yf3wzXiUsvnM9pCYE7u_Y0i4zT7wFti5GA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Nov 19, 2018 at 12:29:07PM -0600, Rob Herring wrote:
> On Mon, Nov 19, 2018 at 11:11 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Add interrupt controller support for RDA Micro RDA8810PL SoC.
> 
> There's no point in splitting this to a separate patch. Without it,
> the DT is not functional.
> 

Okay. Will merge this patch with SoC DT patch.

> > Signed-off-by: Andreas Färber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm/boot/dts/rda8810pl.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
> > index 7f1ff2021eff..093d6980bfbd 100644
> > --- a/arch/arm/boot/dts/rda8810pl.dtsi
> > +++ b/arch/arm/boot/dts/rda8810pl.dtsi
> > @@ -9,6 +9,7 @@
> >
> >  / {
> >         compatible = "rda,8810pl";
> > +       interrupt-parent = <&intc>;
> >         #address-cells = <1>;
> >         #size-cells = <1>;
> >
> > @@ -49,6 +50,13 @@
> >                         #address-cells = <1>;
> >                         #size-cells = <1>;
> >                         ranges = <0x0 0x20800000 0x100000>;
> > +
> > +                       intc: interrupt-controller {
> 
> 
> unit-address?
> 

Will add it.

Thanks,
Mani

> > +                               compatible = "rda,8810pl-intc";
> > +                               reg = <0x0 0x1000>;
> > +                               interrupt-controller;
> > +                               #interrupt-cells = <2>;
> > +                       };
> >                 };
> >
> >                 apb@20900000 {
> > --
> > 2.17.1
> >
