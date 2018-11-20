Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2D8C46466
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558EE2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558EE2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeKUHLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:11:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54011 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeKUHLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:11:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2654D207B0; Tue, 20 Nov 2018 21:40:49 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id F1C98206A1;
        Tue, 20 Nov 2018 21:40:48 +0100 (CET)
Date:   Tue, 20 Nov 2018 21:40:49 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2: use the divided clock for SMC
Message-ID: <20181120204049.GG8367@piout.net>
References: <20181120165737.4998-1-romain.izard.pro@gmail.com>
 <20181120171612.GF8367@piout.net>
 <CAGkQfmPHRKqMvm6bNDf8S5qM7uE5T-izij=jm2nob0zrOgOM-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGkQfmPHRKqMvm6bNDf8S5qM7uE5T-izij=jm2nob0zrOgOM-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 19:01:32+0100, Romain Izard wrote:
> Le mar. 20 nov. 2018 à 18:16, Alexandre Belloni
> <alexandre.belloni@bootlin.com> a écrit :
> >
> > Hello Romain,
> >
> > On 20/11/2018 17:57:37+0100, Romain Izard wrote:
> > > The SAMA5D2 is different from SAMA5D3 and SAMA5D4, as there are two
> > > different clocks for the peripherals in the SoC. The Static Memory
> > > controller is connected to the divided master clock.
> > >
> > > Unfortunately, the device tree does not correctly show this and uses the
> > > master clock directly. This clock is then used by the code for the NAND
> > > controller to calculate the timings for the controller, and we end up with
> > > slow NAND Flash access.
> > >
> > > Fix the device tree, and the performance of Flash access is improved.
> > >
> > > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/sama5d2.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> > > index 61f68e5c48e9..b405992eb601 100644
> > > --- a/arch/arm/boot/dts/sama5d2.dtsi
> > > +++ b/arch/arm/boot/dts/sama5d2.dtsi
> > > @@ -308,7 +308,7 @@
> > >                                 0x1 0x0 0x60000000 0x10000000
> > >                                 0x2 0x0 0x70000000 0x10000000
> > >                                 0x3 0x0 0x80000000 0x10000000>;
> > > -                     clocks = <&mck>;
> > > +                     clocks = <&h32ck>;
> >
> > You will have to rebase on top of at91-dt. And if I'm not mistaken, this
> > line should be:
> >
> > +                       clocks = <&pmc PMC_TYPE_CORE PMC_MCK2>;
> >
> > >                       status = "disabled";
> > >
> > >                       nand_controller: nand-controller {
> 
> I guess you're right but this will only reach mainline in 4.21. I get slow
> flash access with 4.19 as well...
>

Ok, this is super annoying, I'll try to get that as fixes on v4.20 and
I'll rebase at91-dt on top of that...

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
