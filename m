Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FBEC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E8E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VfDItB5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E8E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeKUGCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:02:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37949 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeKUGCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:02:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so1766666plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=riUJ6dQClMFxs4IjJPcQXD7P1YIeiym14Q2ZSNEbgXg=;
        b=VfDItB5CKFy6V5JXVlSzP95ag/8DRj6giVD3nOjhIkmw7xWKBxAqTKyLO8Nnpx1knz
         gIiBbESLKkapbhOV2VfVw7se2PTWOlhuambEw6HBsLx6Pxp/NIbUUvqFlvpvNe6FP0yQ
         NXFMz83g87MGsp9fmI6aylsxXhsEsx9FTarFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=riUJ6dQClMFxs4IjJPcQXD7P1YIeiym14Q2ZSNEbgXg=;
        b=IpU9W8s01VTWzU5WBJD8T1kFPsSlDARXFxxvneNXvngQsjP8FL/OYLEvpnOdlPYrpy
         +fKrNmXSusWgOO9UjyM/+0Hz94vz2LFwElSm+tK/CAwACMLXLkWk57vi9X3MLF3uZ39r
         X5UXV4NaK/MfWqQiqJI1WSUTyUWKLHvMbM8iFx7VjZjI6DdIhgq1LTaein1kcH5FnEYY
         hUzC5/MYX1B6n8yyIlEvuUxNtBswDbOVMpmQrUk3t0GOHgQikginaZHOrEyvBbM8Tznz
         jOk03Wu5maI4MpHnuyNl80F/4aM5934tR7B2FBCLPXQvgBGl0JvZH5yVG5QwHpFoeoHl
         7qsQ==
X-Gm-Message-State: AA+aEWax8wKIhRpDn2YPVvOy9BfaYYgwmdeYNwy81rp0nHzlHPnEazfT
        a2yQD0rGAg1V6Qw/PemHdLKB6Z9iaA==
X-Google-Smtp-Source: AFSGD/Xl+QdqE/gNLGWS1nm54hNsIgnogzlHzv/rl218te2HBGdYKcfAarVf1CtgLDVFB3rtkYGCyw==
X-Received: by 2002:a65:41c2:: with SMTP id b2mr3025922pgq.67.1542742309138;
        Tue, 20 Nov 2018 11:31:49 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6008:86c4:249a:6443:23f2:61f3])
        by smtp.gmail.com with ESMTPSA id z6-v6sm55516800pfb.77.2018.11.20.11.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 11:31:48 -0800 (PST)
Date:   Wed, 21 Nov 2018 01:01:37 +0530
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
Subject: Re: [PATCH 04/16] arm: dts: Add devicetree for RDA8810PL SoC
Message-ID: <20181120193137.GB16122@Mani-XPS-13-9360>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-5-manivannan.sadhasivam@linaro.org>
 <CAL_JsqLf_9ryCUtUkkE6P4GS8tC7nQ0pLHwLCQzy_HLJNTNMrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLf_9ryCUtUkkE6P4GS8tC7nQ0pLHwLCQzy_HLJNTNMrw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Nov 19, 2018 at 12:25:58PM -0600, Rob Herring wrote:
> On Mon, Nov 19, 2018 at 11:11 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Add initial device tree for RDA8810PL SoC from RDA Microelectronics.
> >
> > Signed-off-by: Andreas Färber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm/boot/dts/rda8810pl.dtsi | 95 ++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi
> >
> > diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
> > new file mode 100644
> > index 000000000000..7f1ff2021eff
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/rda8810pl.dtsi
> > @@ -0,0 +1,95 @@
> > +/*
> > + * RDA8810PL SoC
> > + *
> > + * Copyright (c) 2017 Andreas Färber
> > + * Copyright (c) 2018 Manivannan Sadhasivam
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> 
> Goes on 1st line. checkpatch.pl will tell you this.
> 

Ack.

> > + */
> > +
> > +/ {
> > +       compatible = "rda,8810pl";
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +
> > +       aliases {
> > +               serial0 = &uart0;
> > +               serial1 = &uart1;
> > +               serial2 = &uart2;
> > +       };
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               cpu@0 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a5";
> > +                       reg = <0x0>;
> > +               };
> > +       };
> > +
> > +       soc {
> 
> soc@0
> 

Ack.

> > +               compatible = "simple-bus";
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges = <0x0 0x0 0x80000000>;
> > +
> > +               sram@100000 {
> > +                       compatible = "mmio-sram";
> > +                       reg = <0x100000 0x10000>;
> 
> Based on the address of this and everything else, perhaps you should
> move this to the top-level (or another bus node) and then either get
> rid of the soc node level or make it start at 0x20000000. Kind of
> depends on what the rest of the memory map looks like.
>

Okay. Will move sram node to top level and make soc reg address start
from 0x20000000.

> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +               };
> > +
> > +               apb@20800000 {
> > +                       compatible = "simple-bus";
> > +                       reg = <0x20800000 0x100000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges = <0x0 0x20800000 0x100000>;
> > +               };
> > +
> > +               apb@20900000 {
> > +                       compatible = "simple-bus";
> > +                       reg = <0x20900000 0x100000>;
> 
> By definition of a simple-bus, it should not have any registers. Or
> you should also have a specific compatible.
> 

Okay, will remove the reg property.

Thanks,
Mani

> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges = <0x0 0x20900000 0x100000>;
> > +               };
> > +
> > +               apb@20a00000 {
> > +                       compatible = "simple-bus";
> > +                       reg = <0x20a00000 0x100000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges = <0x0 0x20a00000 0x100000>;
> > +
> > +                       uart0: serial@0 {
> > +                               compatible = "rda,8810pl-uart";
> > +                               reg = <0x0 0x1000>;
> > +                               status = "disabled";
> > +                       };
> > +
> > +                       uart1: serial@10000 {
> > +                               compatible = "rda,8810pl-uart";
> > +                               reg = <0x10000 0x1000>;
> > +                               status = "disabled";
> > +                       };
> > +
> > +                       uart2: serial@90000 {
> > +                               compatible = "rda,8810pl-uart";
> > +                               reg = <0x90000 0x1000>;
> > +                               status = "disabled";
> > +                       };
> > +               };
> > +
> > +               l2: cache-controller@21100000 {
> > +                       compatible = "arm,pl310-cache";
> > +                       reg = <0x21100000 0x1000>;
> > +                       cache-unified;
> > +                       cache-level = <2>;
> > +               };
> > +       };
> > +};
> > --
> > 2.17.1
> >
