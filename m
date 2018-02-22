Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeBVHsP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:48:15 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:56036 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752977AbeBVHsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:48:10 -0500
Date: Thu, 22 Feb 2018 08:47:57 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com
Subject: Re: [PATCH v3 1/7] ARM: sun8i: smp: Add support for A83T
Message-ID: <20180222084757.29e6f370@dell-desktop.home>
In-Reply-To: <CAGb2v66xZeeO4tqaj2mkWvn9TYvwE6K1LhF1b-4XAdQK1t0B0A@mail.gmail.com>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
        <20180219081837.15482-2-mylene.josserand@bootlin.com>
        <CAGb2v66xZeeO4tqaj2mkWvn9TYvwE6K1LhF1b-4XAdQK1t0B0A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen-Yu,

On Tue, 20 Feb 2018 11:32:03 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Mon, Feb 19, 2018 at 4:18 PM, Mylène Josserand
> <mylene.josserand@bootlin.com> wrote:
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
> >  arch/arm/mach-sunxi/mc_smp.c | 239 +++++++++++++++++++++++++++++++++++--------  
> 
> The same high-level comments as Maxime. Splitting the patch
> will make this much easier to understand.

Yep, I will do it in next version.

> 
> >  2 files changed, 198 insertions(+), 43 deletions(-)
> >
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index ce53ceaf4cc5..a0ad35c41c02 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -51,7 +51,7 @@ config MACH_SUN9I
> >  config ARCH_SUNXI_MC_SMP
> >         bool
> >         depends on SMP
> > -       default MACH_SUN9I
> > +       default y if MACH_SUN9I || MACH_SUN8I
> >         select ARM_CCI400_PORT_CTRL
> >         select ARM_CPU_SUSPEND
> >
> > diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> > index 11e46c6efb90..fec592bf68b4 100644
> > --- a/arch/arm/mach-sunxi/mc_smp.c
> > +++ b/arch/arm/mach-sunxi/mc_smp.c
> > @@ -55,20 +55,29 @@
> >  #define CPUCFG_CX_RST_CTRL_L2_RST      BIT(8)
> >  #define CPUCFG_CX_RST_CTRL_CX_RST(n)   BIT(4 + (n))
> >  #define CPUCFG_CX_RST_CTRL_CORE_RST(n) BIT(n)
> > +#define CPUCFG_CX_RST_CTRL_CORE_RST_ALL        (0xf << 0)
> >
> >  #define PRCM_CPU_PO_RST_CTRL(c)                (0x4 + 0x4 * (c))
> >  #define PRCM_CPU_PO_RST_CTRL_CORE(n)   BIT(n)
> >  #define PRCM_CPU_PO_RST_CTRL_CORE_ALL  0xf
> >  #define PRCM_PWROFF_GATING_REG(c)      (0x100 + 0x4 * (c))
> > -#define PRCM_PWROFF_GATING_REG_CLUSTER BIT(4)
> > +/* The power off register for clusters are different from SUN9I and SUN8I */
> > +#define PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I   BIT(0)
> > +#define PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I   BIT(4)
> >  #define PRCM_PWROFF_GATING_REG_CORE(n) BIT(n)
> >  #define PRCM_PWR_SWITCH_REG(c, cpu)    (0x140 + 0x10 * (c) + 0x4 * (cpu))
> >  #define PRCM_CPU_SOFT_ENTRY_REG                0x164
> >
> > +/* R_CPUCFG registers, specific to SUN8I */
> > +#define R_CPUCFG_CLUSTER_PO_RST_CTRL(c)        (0x30 + (c) * 0x4)
> > +#define R_CPUCFG_CLUSTER_PO_RST_CTRL_CORE(n)   BIT(n)
> > +#define R_CPUCFG_CPU_SOFT_ENTRY_REG    0x01a4
> > +
> >  #define CPU0_SUPPORT_HOTPLUG_MAGIC0    0xFA50392F
> >  #define CPU0_SUPPORT_HOTPLUG_MAGIC1    0x790DCA3A
> >
> >  static void __iomem *cpucfg_base;
> > +static void __iomem *r_cpucfg_base;
> >  static void __iomem *prcm_base;
> >  static void __iomem *sram_b_smp_base;
> >
> > @@ -157,6 +166,16 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
> >         reg &= ~PRCM_CPU_PO_RST_CTRL_CORE(cpu);
> >         writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
> >
> > +       if (r_cpucfg_base) {
> > +               /* assert cpu power-on reset */
> > +               reg  = readl(r_cpucfg_base +
> > +                            R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
> > +               reg &= ~(R_CPUCFG_CLUSTER_PO_RST_CTRL_CORE(cpu));
> > +               writel(reg, r_cpucfg_base +
> > +                      R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
> > +               udelay(10);
> > +       }
> > +
> >         /* Cortex-A7: hold L1 reset disable signal low */
> >         if (!sunxi_core_is_cortex_a15(cpu, cluster)) {
> >                 reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG0(cluster));
> > @@ -180,17 +199,37 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
> >         /* open power switch */
> >         sunxi_cpu_power_switch_set(cpu, cluster, true);
> >
> > +       /* Handle A83T bit swap */
> > +       if (of_machine_is_compatible("allwinner,sun8i-a83t")) {
> > +               if (cpu == 0)
> > +                       cpu = 4;
> > +       }
> > +
> >         /* clear processor power gate */
> >         reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> >         reg &= ~PRCM_PWROFF_GATING_REG_CORE(cpu);
> >         writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> >         udelay(20);
> >
> > +       if (of_machine_is_compatible("allwinner,sun8i-a83t")) {
> > +               if (cpu == 4)
> > +                       cpu = 0;
> > +       }
> > +
> >         /* de-assert processor power-on reset */
> >         reg = readl(prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
> >         reg |= PRCM_CPU_PO_RST_CTRL_CORE(cpu);
> >         writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
> >
> > +       if (r_cpucfg_base) {
> > +               reg  = readl(r_cpucfg_base +
> > +                            R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
> > +               reg |= R_CPUCFG_CLUSTER_PO_RST_CTRL_CORE(cpu);
> > +               writel(reg, r_cpucfg_base +
> > +                      R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
> > +               udelay(10);
> > +       }
> > +
> >         /* de-assert all processor resets */
> >         reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
> >         reg |= CPUCFG_CX_RST_CTRL_DBG_RST(cpu);
> > @@ -212,6 +251,14 @@ static int sunxi_cluster_powerup(unsigned int cluster)
> >         if (cluster >= SUNXI_NR_CLUSTERS)
> >                 return -EINVAL;
> >
> > +       /* For A83T, assert cluster cores resets */
> > +       if (of_machine_is_compatible("allwinner,sun8i-a83t")) {
> > +               reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
> > +               reg &= ~CPUCFG_CX_RST_CTRL_CORE_RST_ALL;   /* Core Reset    */
> > +               writel(reg, cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
> > +               udelay(10);
> > +       }
> > +
> >         /* assert ACINACTM */
> >         reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
> >         reg |= CPUCFG_CX_CTRL_REG1_ACINACTM;
> > @@ -222,6 +269,16 @@ static int sunxi_cluster_powerup(unsigned int cluster)
> >         reg &= ~PRCM_CPU_PO_RST_CTRL_CORE_ALL;
> >         writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
> >
> > +       /* assert cluster cores resets */
> > +       if (r_cpucfg_base) {
> > +               reg  = readl(r_cpucfg_base +
> > +                            R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
> > +               reg &= ~CPUCFG_CX_RST_CTRL_CORE_RST_ALL;
> > +               writel(reg, r_cpucfg_base +
> > +                      R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
> > +               udelay(10);
> > +       }
> > +
> >         /* assert cluster resets */
> >         reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
> >         reg &= ~CPUCFG_CX_RST_CTRL_DBG_SOC_RST;
> > @@ -252,7 +309,10 @@ static int sunxi_cluster_powerup(unsigned int cluster)
> >
> >         /* clear cluster power gate */
> >         reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> > -       reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER;
> > +       if (of_machine_is_compatible("allwinner,sun8i-a83t"))
> > +               reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I;
> > +       else
> > +               reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
> >         writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> >         udelay(20);
> >
> > @@ -516,7 +576,10 @@ static int sunxi_cluster_powerdown(unsigned int cluster)
> >         /* gate cluster power */
> >         pr_debug("%s: gate cluster power\n", __func__);
> >         reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> > -       reg |= PRCM_PWROFF_GATING_REG_CLUSTER;
> > +       if (of_machine_is_compatible("allwinner,sun8i-a83t"))
> > +               reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I;
> > +       else
> > +               reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
> >         writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> >         udelay(20);
> >
> > @@ -684,37 +747,25 @@ static int __init sunxi_mc_smp_lookback(void)
> >         return ret;
> >  }
> >
> > -static int __init sunxi_mc_smp_init(void)
> > +static int sun9i_dt_parsing(struct resource res)
> >  {
> > -       struct device_node *cpucfg_node, *sram_node, *node;
> > -       struct resource res;
> > +       struct device_node *prcm_node, *cpucfg_node, *sram_node;
> >         int ret;
> >
> > -       if (!of_machine_is_compatible("allwinner,sun9i-a80"))
> > -               return -ENODEV;
> > -
> > -       if (!sunxi_mc_smp_cpu_table_init())
> > -               return -EINVAL;
> > -
> > -       if (!cci_probed()) {
> > -               pr_err("%s: CCI-400 not available\n", __func__);
> > -               return -ENODEV;
> > -       }
> > -
> > -       node = of_find_compatible_node(NULL, NULL, "allwinner,sun9i-a80-prcm");
> > -       if (!node) {
> > -               pr_err("%s: PRCM not available\n", __func__);
> > +       prcm_node = of_find_compatible_node(NULL, NULL,
> > +                                      "allwinner,sun9i-a80-prcm");
> > +       if (!prcm_node)
> >                 return -ENODEV;
> > -       }
> >
> >         /*
> >          * Unfortunately we can not request the I/O region for the PRCM.
> >          * It is shared with the PRCM clock.
> >          */
> > -       prcm_base = of_iomap(node, 0);
> > -       of_node_put(node);
> > +       prcm_base = of_iomap(prcm_node, 0);
> > +       of_node_put(prcm_node);
> >         if (!prcm_base) {
> >                 pr_err("%s: failed to map PRCM registers\n", __func__);
> > +               iounmap(prcm_base);  
> 
> Why are you trying to unmap the pointer that you already failed to map?

Oops, indeed.

> 
> >                 return -ENOMEM;
> >         }
> >
> > @@ -748,35 +799,88 @@ static int __init sunxi_mc_smp_init(void)
> >                 goto err_put_sram_node;
> >         }
> >
> > -       /* Configure CCI-400 for boot cluster */
> > -       ret = sunxi_mc_smp_lookback();
> > -       if (ret) {
> > -               pr_err("%s: failed to configure boot cluster: %d\n",
> > -                      __func__, ret);
> > -               goto err_unmap_release_secure_sram;
> > -       }
> > +       r_cpucfg_base = NULL;  
> 
> This is not needed. Global static variables without initial values are
> always initialized to 0.

Okay, I will remove it.

> 
> >
> >         /* We don't need the CPUCFG and SRAM device nodes anymore */
> >         of_node_put(cpucfg_node);
> >         of_node_put(sram_node);
> >
> > -       /* Set the hardware entry point address */
> > -       writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
> > -              prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
> > -
> > -       /* Actually enable multi cluster SMP */
> > -       smp_set_ops(&sunxi_mc_smp_smp_ops);
> > -
> > -       pr_info("sunxi multi cluster SMP support installed\n");
> > -
> >         return 0;
> >
> > -err_unmap_release_secure_sram:
> > -       iounmap(sram_b_smp_base);
> > -       of_address_to_resource(sram_node, 0, &res);
> > +err_unmap_release_cpucfg:
> > +       iounmap(cpucfg_base);
> > +       of_address_to_resource(cpucfg_node, 0, &res);
> >         release_mem_region(res.start, resource_size(&res));
> >  err_put_sram_node:
> >         of_node_put(sram_node);
> > +err_put_cpucfg_node:
> > +       of_node_put(cpucfg_node);
> > +err_unmap_prcm:
> > +       iounmap(prcm_base);
> > +
> > +       return ret;
> > +}
> > +
> > +static int sun8i_dt_parsing(struct resource res)
> > +{
> > +       struct device_node *node, *cpucfg_node;
> > +       int ret;
> > +
> > +       node = of_find_compatible_node(NULL, NULL,
> > +                                      "allwinner,sun8i-a83t-prcm");
> > +       if (!node)
> > +               return -ENODEV;
> > +
> > +       /*
> > +        * Unfortunately we can not request the I/O region for the PRCM.
> > +        * It is shared with the PRCM clock.
> > +        */
> > +       prcm_base = of_iomap(node, 0);
> > +       of_node_put(node);
> > +       if (!prcm_base) {
> > +               pr_err("%s: failed to map PRCM registers\n", __func__);
> > +               iounmap(prcm_base);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       cpucfg_node = of_find_compatible_node(NULL, NULL,
> > +                                             "allwinner,sun8i-a83t-cpucfg");
> > +       if (!cpucfg_node) {
> > +               ret = -ENODEV;
> > +               pr_err("%s: CPUCFG not available\n", __func__);
> > +               goto err_unmap_prcm;
> > +       }
> > +
> > +       cpucfg_base = of_io_request_and_map(cpucfg_node, 0, "sunxi-mc-smp");
> > +       if (IS_ERR(cpucfg_base)) {
> > +               ret = PTR_ERR(cpucfg_base);
> > +               pr_err("%s: failed to map CPUCFG registers: %d\n",
> > +                      __func__, ret);
> > +               goto err_put_cpucfg_node;
> > +       }
> > +
> > +       node = of_find_compatible_node(NULL, NULL,
> > +                                      "allwinner,sun8i-a83t-r-cpucfg");
> > +       if (!node) {
> > +               ret = -ENODEV;
> > +               goto err_unmap_release_cpucfg;
> > +       }
> > +
> > +       r_cpucfg_base = of_iomap(node, 0);
> > +       if (!r_cpucfg_base) {
> > +               pr_err("%s: failed to map R-CPUCFG registers\n",
> > +                      __func__);
> > +               ret = -ENOMEM;
> > +               goto err_put_node;
> > +       }
> > +
> > +       /* We don't need the CPUCFG device node anymore */
> > +       of_node_put(cpucfg_node);
> > +       of_node_put(node);
> > +
> > +       return 0;
> > +err_put_node:
> > +       of_node_put(node);
> >  err_unmap_release_cpucfg:
> >         iounmap(cpucfg_base);
> >         of_address_to_resource(cpucfg_node, 0, &res);
> > @@ -785,6 +889,57 @@ static int __init sunxi_mc_smp_init(void)
> >         of_node_put(cpucfg_node);
> >  err_unmap_prcm:
> >         iounmap(prcm_base);
> > +
> > +       return ret;
> > +}
> > +
> > +static int __init sunxi_mc_smp_init(void)
> > +{
> > +       struct resource res;
> > +       int ret;
> > +
> > +       if (!of_machine_is_compatible("allwinner,sun9i-a80") &&
> > +           !of_machine_is_compatible("allwinner,sun8i-a83t"))
> > +               return -ENODEV;
> > +
> > +       if (!sunxi_mc_smp_cpu_table_init())
> > +               return -EINVAL;
> > +
> > +       if (!cci_probed()) {
> > +               pr_err("%s: CCI-400 not available\n", __func__);
> > +               return -ENODEV;
> > +       }
> > +
> > +       if (of_machine_is_compatible("allwinner,sun9i-a80"))
> > +               ret = sun9i_dt_parsing(res);
> > +       else
> > +               ret = sun8i_dt_parsing(res);
> > +       if (ret) {
> > +               pr_err("%s: failed to parse DT: %d\n", __func__, ret);
> > +               return ret;
> > +       }
> > +
> > +       /* Configure CCI-400 for boot cluster */
> > +       ret = sunxi_mc_smp_lookback();
> > +       if (ret) {
> > +               pr_err("%s: failed to configure boot cluster: %d\n",
> > +                      __func__, ret);
> > +               return ret; /* MYMY: Need to handle this error case */  
> 
> Please add functions to release the resources. They will need to be
> platform specific, since it requires you to find the device node to
> get the resource that you want to release (for CPUCFG / R-CPUCFG).
> For sun9i do it in the refactor patch. For A83T do it in the patch
> you add support.

It seems that I forgot to handle this error case (the comment was
a kind of "TODO" for myself). Thank you for pointing it out to me.

Thanks for the review!

Best regards,

Mylène

> 
> > +       }
> > +
> > +       /* Set the hardware entry point address */
> > +       if (of_machine_is_compatible("allwinner,sun9i-a80"))
> > +               writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
> > +                      prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
> > +       else
> > +               writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
> > +                      r_cpucfg_base + R_CPUCFG_CPU_SOFT_ENTRY_REG);
> > +
> > +       /* Actually enable multi cluster SMP */
> > +       smp_set_ops(&sunxi_mc_smp_smp_ops);
> > +
> > +       pr_info("sunxi multi cluster SMP support installed\n");
> > +
> >         return ret;
> >  }
> >
> > --
> > 2.11.0
> >  

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
