Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeBYPZx convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 10:25:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57005 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbeBYPZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 10:25:49 -0500
Date: Sun, 25 Feb 2018 16:25:35 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v4 03/10] ARM: sun8i: smp: Add support for A83T
Message-ID: <20180225162535.7406803c@dell-desktop.home>
In-Reply-To: <20180223150305.7jsuxay2idzvcy2w@flea.lan>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
        <20180223133742.26044-4-mylene.josserand@bootlin.com>
        <20180223150305.7jsuxay2idzvcy2w@flea.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Feb 2018 16:03:05 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Fri, Feb 23, 2018 at 02:37:35PM +0100, Mylène Josserand wrote:
> > Add the support for A83T.
> > 
> > A83T SoC has an additional register than A80 to handle CPU configurations:
> > R_CPUS_CFG. Information about the register comes from Allwinner's BSP
> > driver.
> > An important difference is the Power Off Gating register for clusters
> > which is BIT(4) in case of SUN9I-A80 and BIT(0) in case of SUN8I-A83T.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/mach-sunxi/Kconfig  |   2 +-
> >  arch/arm/mach-sunxi/mc_smp.c | 168 +++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 162 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index ce53ceaf4cc5..a0ad35c41c02 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -51,7 +51,7 @@ config MACH_SUN9I
> >  config ARCH_SUNXI_MC_SMP
> >  	bool
> >  	depends on SMP
> > -	default MACH_SUN9I
> > +	default y if MACH_SUN9I || MACH_SUN8I
> >  	select ARM_CCI400_PORT_CTRL
> >  	select ARM_CPU_SUSPEND
> >  
> > diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> > index de02e5662557..3bd9066a1422 100644
> > --- a/arch/arm/mach-sunxi/mc_smp.c
> > +++ b/arch/arm/mach-sunxi/mc_smp.c
> > @@ -55,22 +55,32 @@
> >  #define CPUCFG_CX_RST_CTRL_L2_RST	BIT(8)
> >  #define CPUCFG_CX_RST_CTRL_CX_RST(n)	BIT(4 + (n))
> >  #define CPUCFG_CX_RST_CTRL_CORE_RST(n)	BIT(n)
> > +#define CPUCFG_CX_RST_CTRL_CORE_RST_ALL	(0xf << 0)
> >  
> >  #define PRCM_CPU_PO_RST_CTRL(c)		(0x4 + 0x4 * (c))
> >  #define PRCM_CPU_PO_RST_CTRL_CORE(n)	BIT(n)
> >  #define PRCM_CPU_PO_RST_CTRL_CORE_ALL	0xf
> >  #define PRCM_PWROFF_GATING_REG(c)	(0x100 + 0x4 * (c))
> > +/* The power off register for clusters are different from SUN9I and SUN8I */
> > +#define PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I	BIT(0)
> >  #define PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I	BIT(4)
> >  #define PRCM_PWROFF_GATING_REG_CORE(n)	BIT(n)
> >  #define PRCM_PWR_SWITCH_REG(c, cpu)	(0x140 + 0x10 * (c) + 0x4 * (cpu))
> >  #define PRCM_CPU_SOFT_ENTRY_REG		0x164
> >  
> > +/* R_CPUCFG registers, specific to SUN8I */
> > +#define R_CPUCFG_CLUSTER_PO_RST_CTRL(c)	(0x30 + (c) * 0x4)
> > +#define R_CPUCFG_CLUSTER_PO_RST_CTRL_CORE(n)	BIT(n)
> > +#define R_CPUCFG_CPU_SOFT_ENTRY_REG	0x01a4
> > +
> >  #define CPU0_SUPPORT_HOTPLUG_MAGIC0	0xFA50392F
> >  #define CPU0_SUPPORT_HOTPLUG_MAGIC1	0x790DCA3A
> >  
> >  static void __iomem *cpucfg_base;
> > +static void __iomem *r_cpucfg_base;
> >  static void __iomem *prcm_base;
> >  static void __iomem *sram_b_smp_base;
> > +static bool is_sun9i;  
> 
> Since you always check for that condition to always be false, can't
> you do the opposite, ie have it called is_a83t, and verify it to be
> true?

Yes, I will switch the test.

> 
> >  	/* Set the hardware entry point address */
> > -	writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
> > -	       prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
> > +	if (is_sun9i)
> > +		writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
> > +		       prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
> > +	else
> > +		writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
> > +		       r_cpucfg_base + R_CPUCFG_CPU_SOFT_ENTRY_REG);  
> 
> if (is_a83t)
> 	reg = prcm_base + PRCM_CPU_SOFT_ENTRY_REG;
> else
> 	reg = r_cpucfg_base + R_CPUCFG_CPU_SOFT_ENTRY_REG;
> writel(__pa_symbol(sunxi_mc_smp_secondary_startup), reg);
> 

Make sense, thanks for the review.

Mylene

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
