Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB44C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53762251C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53762251C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbeKNEGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:06:12 -0500
Received: from muru.com ([72.249.23.125]:53994 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732227AbeKNEGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:06:12 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6D513809B;
        Tue, 13 Nov 2018 18:06:59 +0000 (UTC)
Date:   Tue, 13 Nov 2018 10:06:56 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Message-ID: <20181113180656.GE53235@atomide.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

* Belisko Marek <marek.belisko@gmail.com> [180703 18:34]:
> Hi Tony,
> 
> On Tue, Jul 3, 2018 at 10:45 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Belisko Marek <marek.belisko@gmail.com> [180620 09:40]:
> > > Hello,
> > >
> > > I'm trying to fix warning (for omap5 board) produced by recent change
> > > to avoid using IRQ_TYPE_NONE like:
> > > [    1.818666] WARNING: CPU: 1 PID: 778 at
> > > drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0x78/0x100
> > > [    1.828839] Modules linked in:
> > >
> > > I did look to other commit which did update and without deep knowledge
> > > I just simply do this small change:
> > > diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi
> > > b/arch/arm/boot/dts/omap5-board-common.dtsi
> > > index 218892b..ab2df8c 100644
> > > --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> > > +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> > > @@ -393,7 +393,7 @@
> > >
> > >         palmas: palmas@48 {
> > >                 compatible = "ti,palmas";
> > > -               interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
> > > +               interrupts = <GIC_SPI 7 IRQ_TYPE_HIGH>; /* IRQ_SYS_1N */
> > >                 reg = <0x48>;
> > >                 interrupt-controller;
> > >                 #interrupt-cells = <2>;
> > >
> > > and it looks board boots fine. Only issue is that gpadc driver is not
> > > working (at least not getting interrupts at all ADC fails with
> > > timeout). I did look to gpadc driver and driver is not using
> > > interrupts defined in dts but request interrupt directly from palmas
> > > mfd module. Any ideas what needs to be changed to have gpadc again
> > > working with mentioned patch?
> >
> > Can you try with IRQF_TRIGGER_HIGH added also to the flags to
> > regmap_add_irq_chip() in drivers/mfd/palmas.c?
> Nope issue is till present also after this change like:
> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi
> b/arch/arm/boot/dts/omap5-board-common.dtsi
> index 218892b..6912769 100644
> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> @@ -393,7 +393,7 @@
> 
>         palmas: palmas@48 {
>                 compatible = "ti,palmas";
> -               interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
> +               interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N */
>                 reg = <0x48>;
>                 interrupt-controller;
>                 #interrupt-cells = <2>;
> @@ -432,9 +432,9 @@
> 
>                 gpadc: gpadc {
>                         compatible = "ti,palmas-gpadc";
> -                       interrupts = <18 0
> -                                     16 0
> -                                     17 0>;
> +                       interrupts = <18 IRQ_TYPE_LEVEL_HIGH
> +                                     16 IRQ_TYPE_LEVEL_HIGH
> +                                     17 IRQ_TYPE_LEVEL_HIGH>;
>                         #io-channel-cells = <1>;
>                         ti,channel0-current-microamp = <5>;
>                         ti,channel3-current-microamp = <10>;
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index 663a239..15d23db 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -601,7 +601,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>         regmap_write(palmas->regmap[slave], addr, reg);
> 
>         ret = regmap_add_irq_chip(palmas->regmap[slave], palmas->irq,
> -                                 IRQF_ONESHOT | pdata->irq_flags, 0,
> +                                 IRQF_ONESHOT | IRQF_TRIGGER_HIGH |
> pdata->irq_flags, 0,
>                                   driver_data->irq_chip, &palmas->irq_data);
>         if (ret < 0)
>                 goto err_i2c;

Looks like the IRQ_TYPE_NONE issue still is there for omap5 and
should be fixed with IRQ_TYPE_HIGH.

No idea about why palmas interrupts would stop working though,
Peter, do you have any ideas on this one?

Regards,

Tony
