Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbeBXHp7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 02:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750844AbeBXHp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 02:45:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA79621746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Sat, 24 Feb 2018 15:45:44 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
Message-ID: <20180224074543.GF3217@dragon>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 01:39:44PM +0100, Sebastian Reichel wrote:
> On i.MX53 it is necessary to set the DBG_EN bit in the
> platform GPC register to enable access to PMU counters
> other than the cycle counter.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  arch/arm/mach-imx/mach-imx53.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index 07c2e8dca494..658e28604dca 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -28,10 +28,47 @@ static void __init imx53_init_early(void)
>  	mxc_set_cpu_type(MXC_CPU_MX53);
>  }
>  
> +#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004

The base address should be retrieved from device tree.

Shawn

> +#define GPC_DBG_EN BIT(16)
> +
> +/*
> + * This enables the DBGEN bit in ARM_GPC register, which is
> + * required for accessing some performance counter features.
> + * Technically it is only required while perf is used, but to
> + * keep the source code simple we just enable it all the time
> + * when the kernel configuration allows using the feature.
> + */
> +static void imx53_pmu_init(void)
> +{
> +	void __iomem *gpc_reg;
> +	struct device_node *node;
> +	u32 gpc;
> +
> +	if (!IS_ENABLED(CONFIG_ARM_PMU))
> +		return;
> +
> +	node = of_find_compatible_node(NULL, NULL, "arm,cortex-a8-pmu");
> +	if (!node)
> +		return;
> +
> +	if (!of_property_read_bool(node, "secure-reg-access"))
> +		return;
> +
> +	gpc_reg = ioremap(MXC_CORTEXA8_PLAT_GPC, 4);
> +	if (!gpc_reg) {
> +		pr_warning("unable to map GPC to enable perf\n");
> +		return;
> +	}
> +
> +	gpc = readl_relaxed(gpc_reg);
> +	gpc |= GPC_DBG_EN;
> +	writel_relaxed(gpc, gpc_reg);
> +}
> +
>  static void __init imx53_dt_init(void)
>  {
>  	imx_src_init();
> -
> +	imx53_pmu_init();
>  	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
>  }
>  
> -- 
> 2.15.1
> 
