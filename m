Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeDCUVN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 16:21:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59516 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbeDCUVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 16:21:12 -0400
Date: Tue, 3 Apr 2018 22:21:08 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>, quentin.schulz@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 12/13] ARM: sun8i: smp: Add support for A83T
Message-ID: <20180403222108.14ca34d0@dell-desktop.home>
In-Reply-To: <CAGb2v64E4A2mBwLhydy+11d-3B=K3RYeZkvy-E=fw6JG3=NXDg@mail.gmail.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
        <20180403061836.3926-13-mylene.josserand@bootlin.com>
        <CAGb2v64E4A2mBwLhydy+11d-3B=K3RYeZkvy-E=fw6JG3=NXDg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen-Yu,

Thanks for your review.

On Tue, 3 Apr 2018 16:47:53 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Tue, Apr 3, 2018 at 2:18 PM, Mylène Josserand
> <mylene.josserand@bootlin.com> wrote:
> > Add the support for A83T.
> >
> > A83T SoC has an additional register than A80 to handle CPU configurations:
> > R_CPUS_CFG. Information about the register comes from Allwinner's BSP
> > driver.
> > An important difference is the Power Off Gating register for clusters
> > which is BIT(4) in case of SUN9I-A80 and BIT(0) in case of SUN8I-A83T.
> > There is also a bit swap between sun8i-a83t and sun9i-a80 that must be
> > handled.
> >
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/mach-sunxi/mc_smp.c | 120 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 117 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> > index 468a6c46bfc9..72e497dc43ac 100644
> > --- a/arch/arm/mach-sunxi/mc_smp.c
> > +++ b/arch/arm/mach-sunxi/mc_smp.c
> > @@ -55,22 +55,31 @@
> >  #define CPUCFG_CX_RST_CTRL_L2_RST      BIT(8)
> >  #define CPUCFG_CX_RST_CTRL_CX_RST(n)   BIT(4 + (n))
> >  #define CPUCFG_CX_RST_CTRL_CORE_RST(n) BIT(n)
> > +#define CPUCFG_CX_RST_CTRL_CORE_RST_ALL        (0xf << 0)
> >
> >  #define PRCM_CPU_PO_RST_CTRL(c)                (0x4 + 0x4 * (c))
> >  #define PRCM_CPU_PO_RST_CTRL_CORE(n)   BIT(n)
> >  #define PRCM_CPU_PO_RST_CTRL_CORE_ALL  0xf
> >  #define PRCM_PWROFF_GATING_REG(c)      (0x100 + 0x4 * (c))
> > +/* The power off register for clusters are different from a80 and a83t */
> > +#define PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I   BIT(0)
> >  #define PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I   BIT(4)
> >  #define PRCM_PWROFF_GATING_REG_CORE(n) BIT(n)
> >  #define PRCM_PWR_SWITCH_REG(c, cpu)    (0x140 + 0x10 * (c) + 0x4 * (cpu))
> >  #define PRCM_CPU_SOFT_ENTRY_REG                0x164
> >
> > +/* R_CPUCFG registers, specific to SUN8I */  
> 
> You should mention it as A83T specific, since sun8i covers the
> entire Cortex-A7-based SoC family.

Thanks, Maxime already told me that, I tried to pay attention to change
every "sun8i" into "sun8i-a83t" but I missed that one.

> 
> > +#define R_CPUCFG_CLUSTER_PO_RST_CTRL(c)        (0x30 + (c) * 0x4)
> > +#define R_CPUCFG_CLUSTER_PO_RST_CTRL_CORE(n)   BIT(n)
> > +#define R_CPUCFG_CPU_SOFT_ENTRY_REG            0x01a4
> > +
> >  #define CPU0_SUPPORT_HOTPLUG_MAGIC0    0xFA50392F
> >  #define CPU0_SUPPORT_HOTPLUG_MAGIC1    0x790DCA3A
> >
> >  static void __iomem *cpucfg_base;
> >  static void __iomem *prcm_base;
> >  static void __iomem *sram_b_smp_base;
> > +static void __iomem *r_cpucfg_base;
> >  static int index;
> >
> >  /*
> > @@ -81,6 +90,7 @@ struct sunxi_mc_smp_nodes {
> >         struct device_node *prcm_node;
> >         struct device_node *cpucfg_node;
> >         struct device_node *sram_node;
> > +       struct device_node *r_cpucfg_node;
> >  };
> >
> >  /* This structure holds SoC-specific bits tied to an enable-method string. */
> > @@ -94,6 +104,7 @@ extern void sunxi_mc_smp_secondary_startup(void);
> >  extern void sunxi_mc_smp_resume(void);
> >
> >  static int __init sun9i_a80_get_smp_nodes(struct sunxi_mc_smp_nodes *nodes);
> > +static int __init sun8i_a83t_get_smp_nodes(struct sunxi_mc_smp_nodes *nodes);
> >
> >  static const struct sunxi_mc_smp_data sunxi_mc_smp_data[] __initconst = {
> >         {
> > @@ -101,6 +112,11 @@ static const struct sunxi_mc_smp_data sunxi_mc_smp_data[] __initconst = {
> >                 .get_smp_nodes  = sun9i_a80_get_smp_nodes,
> >                 .is_sun9i       = true,
> >         },
> > +       {
> > +               .enable_method  = "allwinner,sun8i-a83t-smp",
> > +               .get_smp_nodes  = sun8i_a83t_get_smp_nodes,
> > +               .is_sun9i       = false,
> > +       },
> >  };
> >
> >  static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
> > @@ -188,6 +204,16 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
> >         reg &= ~PRCM_CPU_PO_RST_CTRL_CORE(cpu);
> >         writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
> >
> > +       if (r_cpucfg_base) {  
> 
> Please check against is_sun9i, since this is A83T specific. My point
> is we should be able to see clearly what parts of the code are shared,
> and what parts are SoC specific.

Okay, it is fine for me, I will update that and I will use a "is_sun8i"
as Maxime mentioned in previous series.

> 
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
> > @@ -211,17 +237,38 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
> >         /* open power switch */
> >         sunxi_cpu_power_switch_set(cpu, cluster, true);
> >
> > +       /* Handle A83T bit swap */
> > +       if (!sunxi_mc_smp_data[index].is_sun9i) {
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
> > +       /* Handle A83T bit swap */
> > +       if (!sunxi_mc_smp_data[index].is_sun9i) {
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
> 
> Same here.

ack

> 
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
> > @@ -243,6 +290,14 @@ static int sunxi_cluster_powerup(unsigned int cluster)
> >         if (cluster >= SUNXI_NR_CLUSTERS)
> >                 return -EINVAL;
> >
> > +       /* For A83T, assert cluster cores resets */
> > +       if (!sunxi_mc_smp_data[index].is_sun9i) {  
> 
> Here it is correct.

ack

> 
> > +               reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
> > +               reg &= ~CPUCFG_CX_RST_CTRL_CORE_RST_ALL;   /* Core Reset    */
> > +               writel(reg, cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
> > +               udelay(10);
> > +       }
> > +
> >         /* assert ACINACTM */
> >         reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
> >         reg |= CPUCFG_CX_CTRL_REG1_ACINACTM;
> > @@ -253,6 +308,16 @@ static int sunxi_cluster_powerup(unsigned int cluster)
> >         reg &= ~PRCM_CPU_PO_RST_CTRL_CORE_ALL;
> >         writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
> >
> > +       /* assert cluster cores resets */
> > +       if (r_cpucfg_base) {  
> 
> Same here.

ack

> 
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
> > @@ -285,6 +350,8 @@ static int sunxi_cluster_powerup(unsigned int cluster)
> >         reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> >         if (sunxi_mc_smp_data[index].is_sun9i)
> >                 reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
> > +       else
> > +               reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I;
> >         writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> >         udelay(20);
> >
> > @@ -483,6 +550,8 @@ static int sunxi_cluster_powerdown(unsigned int cluster)
> >         reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> >         if (sunxi_mc_smp_data[index].is_sun9i)
> >                 reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
> > +       else
> > +               reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I;
> >         writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> >         udelay(20);
> >
> > @@ -564,8 +633,12 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
> >         return !ret;
> >  }
> >
> > -static bool sunxi_mc_smp_cpu_can_disable(unsigned int __unused)
> > +static bool sunxi_mc_smp_cpu_can_disable(unsigned int cpu)
> >  {
> > +       /* CPU0 hotplug handled only for sun9i-a80 */
> > +       if (!sunxi_mc_smp_data[index].is_sun9i)
> > +               if (cpu == 0)
> > +                       return false;  
> 
> Once the above is fixed, this patch is
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks!

> 
> 
> Would it be possible for you to implement CPU0 hotplug? You needn't
> do so as part of this patch or even this series. I disassembled the
> BROM just now, and it is much simpler compared to the A80:
> 
> On boot, if running on cpu0, check magic register at 0x01f01dac
> for magic value 0xfa50392f. If found, follow secondary startup
> like other cores, otherwise continue normal boot procedure.
> As you can see they use a register in CPUS-CFG instead of
> secure SRAM this time.

Sure, I will do it with pleasure. Thank you for the explanation, I
will try that and I will let you know if it is working with this setup.

Best regards,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

> 
> >         return true;
> >  }
> >  #endif
> > @@ -645,6 +718,7 @@ static void __init sunxi_mc_smp_put_nodes(struct sunxi_mc_smp_nodes *nodes)
> >         of_node_put(nodes->prcm_node);
> >         of_node_put(nodes->cpucfg_node);
> >         of_node_put(nodes->sram_node);
> > +       of_node_put(nodes->r_cpucfg_node);
> >         memset(nodes, 0, sizeof(*nodes));
> >  }
> >
> > @@ -674,6 +748,32 @@ static int __init sun9i_a80_get_smp_nodes(struct sunxi_mc_smp_nodes *nodes)
> >         return 0;
> >  }
> >
> > +static int __init sun8i_a83t_get_smp_nodes(struct sunxi_mc_smp_nodes *nodes)
> > +{
> > +       nodes->prcm_node = of_find_compatible_node(NULL, NULL,
> > +                                                  "allwinner,sun8i-a83t-r-ccu");
> > +       if (!nodes->prcm_node) {
> > +               pr_err("%s: PRCM not available\n", __func__);
> > +               return -ENODEV;
> > +       }
> > +
> > +       nodes->cpucfg_node = of_find_compatible_node(NULL, NULL,
> > +                                                    "allwinner,sun8i-a83t-cpucfg");
> > +       if (!nodes->cpucfg_node) {
> > +               pr_err("%s: CPUCFG not available\n", __func__);
> > +               return -ENODEV;
> > +       }
> > +
> > +       nodes->r_cpucfg_node = of_find_compatible_node(NULL, NULL,
> > +                                                      "allwinner,sun8i-a83t-r-cpucfg");
> > +       if (!nodes->r_cpucfg_node) {
> > +               pr_err("%s: RCPUCFG not available\n", __func__);
> > +               return -ENODEV;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int __init sunxi_mc_smp_init(void)
> >  {
> >         struct sunxi_mc_smp_nodes nodes = { 0 };
> > @@ -752,6 +852,15 @@ static int __init sunxi_mc_smp_init(void)
> >                         pr_err("%s: failed to map secure SRAM\n", __func__);
> >                         goto err_unmap_release_cpucfg;
> >                 }
> > +       } else {
> > +               r_cpucfg_base = of_io_request_and_map(nodes.r_cpucfg_node,
> > +                                                     0, "sunxi-mc-smp");
> > +               if (IS_ERR(r_cpucfg_base)) {
> > +                       ret = PTR_ERR(r_cpucfg_base);
> > +                       pr_err("%s: failed to map R-CPUCFG registers\n",
> > +                              __func__);
> > +                       goto err_unmap_release_cpucfg;
> > +               }
> >         }
> >
> >         /* Configure CCI-400 for boot cluster */
> > @@ -759,7 +868,7 @@ static int __init sunxi_mc_smp_init(void)
> >         if (ret) {
> >                 pr_err("%s: failed to configure boot cluster: %d\n",
> >                        __func__, ret);
> > -               goto err_unmap_release_secure_sram;
> > +               goto err_unmap_release_sram_rcpucfg;
> >         }
> >
> >         /* We don't need the device nodes anymore */
> > @@ -768,6 +877,8 @@ static int __init sunxi_mc_smp_init(void)
> >         /* Set the hardware entry point address */
> >         if (sunxi_mc_smp_data[index].is_sun9i)
> >                 addr = prcm_base + PRCM_CPU_SOFT_ENTRY_REG;
> > +       else
> > +               addr = r_cpucfg_base + R_CPUCFG_CPU_SOFT_ENTRY_REG;
> >         writel(__pa_symbol(sunxi_mc_smp_secondary_startup), addr);
> >
> >         /* Actually enable multi cluster SMP */
> > @@ -777,10 +888,13 @@ static int __init sunxi_mc_smp_init(void)
> >
> >         return 0;
> >
> > -err_unmap_release_secure_sram:
> > +err_unmap_release_sram_rcpucfg:
> >         if (sunxi_mc_smp_data[index].is_sun9i) {
> >                 iounmap(sram_b_smp_base);
> >                 of_address_to_resource(nodes.sram_node, 0, &res);
> > +       } else {
> > +               iounmap(r_cpucfg_base);
> > +               of_address_to_resource(nodes.r_cpucfg_node, 0, &res);
> >         }
> >         release_mem_region(res.start, resource_size(&res));
> >  err_unmap_release_cpucfg:
> > --
> > 2.11.0
> >  
