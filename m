Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965153AbeCAIVG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:21:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60901 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934985AbeCAIVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:21:04 -0500
Date: Thu, 1 Mar 2018 09:21:02 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v4 08/10] ARM: sunxi: smp: Move assembly code into a
 file
Message-ID: <20180301092102.50d80937@dell-desktop.home>
In-Reply-To: <20180223150949.ky4blpbc64tf44tt@flea.lan>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
        <20180223133742.26044-9-mylene.josserand@bootlin.com>
        <20180223150949.ky4blpbc64tf44tt@flea.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 23 Feb 2018 16:09:49 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Fri, Feb 23, 2018 at 02:37:40PM +0100, Mylène Josserand wrote:
> > Move the assembly code for cluster cache enabling
> > into an assembly file instead of having it directly in C code.
> > 
> > Create a sunxi_boot entry that will perform a cluster cached
> > enabling and called secondary_startup.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/mach-sunxi/Makefile  |  1 +
> >  arch/arm/mach-sunxi/headsmp.S | 73 +++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-sunxi/mc_smp.c  | 76 ++++---------------------------------------
> >  3 files changed, 80 insertions(+), 70 deletions(-)
> >  create mode 100644 arch/arm/mach-sunxi/headsmp.S
> > 
> > diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
> > index 7de9cc286d53..d1a072b879ed 100644
> > --- a/arch/arm/mach-sunxi/Makefile
> > +++ b/arch/arm/mach-sunxi/Makefile
> > @@ -1,5 +1,6 @@
> >  CFLAGS_mc_smp.o	+= -march=armv7-a
> >  
> >  obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
> > +obj-$(CONFIG_ARCH_SUNXI) += headsmp.o
> >  obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o
> >  obj-$(CONFIG_SMP) += platsmp.o
> > diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> > new file mode 100644
> > index 000000000000..4f5957a6e188
> > --- /dev/null
> > +++ b/arch/arm/mach-sunxi/headsmp.S
> > @@ -0,0 +1,73 @@
> > +/*
> > + * SMP support for sunxi based systems with Cortex A7/A15
> > + *
> > + * Copyright (C) 2018 Bootlin  
> 
> This is just a copy, and while you can claim that you are one of the
> copyrights holder, you are not the sole one and the original author
> should be there.

yep, sorry about that.

> 
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.  
> 
> You want to use SPDX there instead.

Sure, I will update it.

> 
> > + */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/assembler.h>
> > +
> > +ENTRY(sunxi_mc_smp_cluster_cache_enable)
> > +	/*
> > +	* Enable cluster-level coherency, in preparation for turning on the MMU.
> > +	*
> > +	* Also enable regional clock gating and L2 data latency settings for
> > +	* Cortex-A15. These settings are from the vendor kernel.
> > +	*/  
> 
> The indentation is not correct there, the * should be aligned

Okay

> 
> > +	mrc	p15, 0, r1, c0, c0, 0
> > +	movw	r2, #(0xff00fff0&0xffff)
> > +	movt	r2, #(0xff00fff0>>16)  
> 
> This used to be defines, we should keep them, and we should have
> spaces around the operators as well.

Okay 

> 
> > +	and	r1, r1, r2
> > +	movw	r2, #(0x4100c0f0&0xffff)
> > +	movt	r2, #(0x4100c0f0>>16)
> > +	cmp	r1, r2
> > +	bne	not_a15
> > +
> > +	/* The following is Cortex-A15 specific */
> > +
> > +	/* ACTLR2: Enable CPU regional clock gates */
> > +	mrc p15, 1, r1, c15, c0, 4
> > +	orr r1, r1, #(0x1<<31)
> > +	mcr p15, 1, r1, c15, c0, 4
> > +
> > +	/* L2ACTLR */
> > +	mrc p15, 1, r1, c15, c0, 0
> > +	/* Enable L2, GIC, and Timer regional clock gates */
> > +	orr r1, r1, #(0x1<<26)
> > +	/* Disable clean/evict from being pushed to external */
> > +	orr r1, r1, #(0x1<<3)
> > +	mcr p15, 1, r1, c15, c0, 0
> > +
> > +	/* L2CTRL: L2 data RAM latency */
> > +	mrc p15, 1, r1, c9, c0, 2
> > +	bic r1, r1, #(0x7<<0)
> > +	orr r1, r1, #(0x3<<0)
> > +	mcr p15, 1, r1, c9, c0, 2
> > +
> > +	/* End of Cortex-A15 specific setup */
> > +	not_a15:
> > +
> > +	/* Get value of sunxi_mc_smp_first_comer */
> > +	adr	r1, first
> > +	ldr	r0, [r1]
> > +	ldr	r0, [r1, r0]
> > +
> > +	/* Skip cci_enable_port_for_self if not first comer */
> > +	cmp	r0, #0
> > +	bxeq	lr
> > +	b	cci_enable_port_for_self
> > +
> > +	.align 2
> > +	first: .word sunxi_mc_smp_first_comer - .
> > +ENDPROC(sunxi_mc_smp_cluster_cache_enable)
> > +
> > +#ifdef CONFIG_SMP  
> 
> I guess that whole file should be compiled only if we have SMP
> enabled.

True, thanks

> 
> > +ENTRY(sunxi_boot)
> > +	bl	sunxi_mc_smp_cluster_cache_enable
> > +	b	secondary_startup
> > +ENDPROC(sunxi_boot)
> > +#endif
> > diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> > index f2c2cfca28cd..4e807cc11a0f 100644
> > --- a/arch/arm/mach-sunxi/mc_smp.c
> > +++ b/arch/arm/mach-sunxi/mc_smp.c
> > @@ -82,6 +82,9 @@ static void __iomem *prcm_base;
> >  static void __iomem *sram_b_smp_base;
> >  static bool is_sun9i;
> >  
> > +extern void sunxi_boot(void);  
> 
> Why did you change the name of that function? The older one made it
> more obvious to tell what is going on.

Okay, I will use the old name.

> 
> > +extern void sunxi_cluster_cache_enable(void);  
> 
> Is that used somewhere?

No, I will remove it.

> 
> Thanks!
> Maxime
> 

Thanks,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
