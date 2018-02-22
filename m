Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeBVJaT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:30:19 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:58591 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbeBVJaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:30:17 -0500
Date: Thu, 22 Feb 2018 10:30:15 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        quentin.schulz@bootlin.com, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/7] arm: dts: sun8i: a83t: Fix undefined offset with
 virtual timer
Message-ID: <20180222103015.40249fee@dell-desktop.home>
In-Reply-To: <823f256a-3240-7bb4-cc0b-711108f3076c@arm.com>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
        <20180219081837.15482-7-mylene.josserand@bootlin.com>
        <823f256a-3240-7bb4-cc0b-711108f3076c@arm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thank you for the review!

On Tue, 20 Feb 2018 18:07:54 +0000
Marc Zyngier <marc.zyngier@arm.com> wrote:

> Hi Mylène,
> 
> On 19/02/18 08:18, Mylène Josserand wrote:
> > The ARM architected timers use an offset between their physical and
> > virtual counters. That offset should be configured by the bootloader
> > in CNTVOFF.
> > 
> > However, the A83t bootloader fails to do so, and we end up with an
> > undefined offset (which in our case is random), meaning that each CPU
> > will have a different time, which isn't working very well.
> > 
> > Fix that by setting the arm,cpu-registers-not-fw-configured that will
> > make Linux use the physical timers instead of the virtual ones. One
> > possible side effect would be that the virtualization features would
> > be disabled. However, due to the way the GIC has been integrated in
> > the system, it is already unusable so we're effectively not losing any
> > feature.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > index e97a6d17b8d0..b9bdb891cf2f 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > @@ -123,6 +123,7 @@
> >  			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> >  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> >  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> > +		arm,cpu-registers-not-fw-configured;
> >  	};
> >  
> >  	clocks {
> >   
> 
> Is the firmware dropping you in the kernel in secure or non-secure mode?

For sun8i-a83t, the kernel is in secure mode.

> 
> If the later, what you have is the only solution. If the former, that
> I'd suggest you adopt what we already have for the Renesas stuff (see
> arch/arm/mach-shmobile/headsmp-apmu.S and commit 3fd45a136ff6).
> 
> It would allow you to use the virtual timer as intended.

Okay, thanks for the commit pointed, I will try to adopt what it is done
for Renesas.

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
