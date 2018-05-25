Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966973AbeEYLqQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:46:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41105 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966631AbeEYLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:46:12 -0400
Message-ID: <1527248760.3472.6.camel@pengutronix.de>
Subject: Re: [PATCH 15/15] arm: dts: imx: Add missing OPP properties for CPUs
From: Lucas Stach <l.stach@pengutronix.de>
To: Viresh Kumar <viresh.kumar@linaro.org>, arm@kernel.org,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, chris.redpath@arm.com,
        ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org
Date: Fri, 25 May 2018 13:46:00 +0200
In-Reply-To: <264124e14b966a1bbc07c364fbd89fc55aa765e6.1527244201.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
         <264124e14b966a1bbc07c364fbd89fc55aa765e6.1527244201.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

Am Freitag, den 25.05.2018, 16:02 +0530 schrieb Viresh Kumar:
> The OPP properties, like "operating-points", should either be present
> for all the CPUs of a cluster or none. If these are present only for a
> subset of CPUs of a cluster then things will start falling apart as soon
> as the CPUs are brought online in a different order. For example, this
> will happen because the operating system looks for such properties in
> the CPU node it is trying to bring up, so that it can create an OPP
> table.
> 
> Add such missing properties.
> 
> Fix other missing properties (like clocks, supply, clock latency) as
> well to make it all work.

This is a lot of duplicate information for what is effectively a shared
 cluster wide thing. This does absolutely not _feel_ right.

What problem are you solving here? Why do we need all this duplicate
information? Why can't we fix it by falling back to looking at cpu0 if
needed?

Regards,
Lucas

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/imx6dl.dtsi      | 23 ++++++++++
>  arch/arm/boot/dts/imx6q-cm-fx6.dts | 66 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6q.dtsi       | 87 ++++++++++++++++++++++++++++++++++++--
>  arch/arm/boot/dts/imx7d.dtsi       |  5 +++
>  4 files changed, 178 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index b384913c34dd..cc8ffc42d128 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -50,6 +50,29 @@
> >  			device_type = "cpu";
> >  			reg = <1>;
> >  			next-level-cache = <&L2>;
> > +			operating-points = <
> > +				/* kHz    uV */
> > +				996000  1250000
> > +				792000  1175000
> > +				396000  1150000
> > +			>;
> > +			fsl,soc-operating-points = <
> > +				/* ARM kHz  SOC-PU uV */
> > > +				996000	1175000
> > > +				792000	1175000
> > > +				396000	1175000
> > +			>;
> > +			clock-latency = <61036>; /* two CLK32 periods */
> > +			clocks = <&clks IMX6QDL_CLK_ARM>,
> > +				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
> > +				 <&clks IMX6QDL_CLK_STEP>,
> > +				 <&clks IMX6QDL_CLK_PLL1_SW>,
> > +				 <&clks IMX6QDL_CLK_PLL1_SYS>;
> > +			clock-names = "arm", "pll2_pfd2_396m", "step",
> > +				      "pll1_sw", "pll1_sys";
> > +			arm-supply = <&reg_arm>;
> > +			pu-supply = <&reg_pu>;
> > +			soc-supply = <&reg_soc>;
> >  		};
> >  	};
>  
> diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> index 65ef4cacbc71..18ae4f3be6e3 100644
> --- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
> +++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> @@ -187,6 +187,72 @@
> >  	>;
>  };
>  
> +&cpu1 {
> > +	/*
> > +	 * Although the imx6q fuse indicates that 1.2GHz operation is possible,
> > +	 * the module behaves unstable at this frequency. Hence, remove the
> > +	 * 1.2GHz operation point here.
> > +	 */
> > +	operating-points = <
> > > +		/* kHz	uV */
> > > +		996000	1250000
> > > +		852000	1250000
> > > +		792000	1175000
> > > +		396000	975000
> > +	>;
> > +	fsl,soc-operating-points = <
> > > +		/* ARM kHz	SOC-PU uV */
> > > +		996000		1250000
> > > +		852000		1250000
> > > +		792000		1175000
> > > +		396000		1175000
> > +	>;
> +};
> +
> +&cpu2 {
> > +	/*
> > +	 * Although the imx6q fuse indicates that 1.2GHz operation is possible,
> > +	 * the module behaves unstable at this frequency. Hence, remove the
> > +	 * 1.2GHz operation point here.
> > +	 */
> > +	operating-points = <
> > > +		/* kHz	uV */
> > > +		996000	1250000
> > > +		852000	1250000
> > > +		792000	1175000
> > > +		396000	975000
> > +	>;
> > +	fsl,soc-operating-points = <
> > > +		/* ARM kHz	SOC-PU uV */
> > > +		996000		1250000
> > > +		852000		1250000
> > > +		792000		1175000
> > > +		396000		1175000
> > +	>;
> +};
> +
> +&cpu3 {
> > +	/*
> > +	 * Although the imx6q fuse indicates that 1.2GHz operation is possible,
> > +	 * the module behaves unstable at this frequency. Hence, remove the
> > +	 * 1.2GHz operation point here.
> > +	 */
> > +	operating-points = <
> > > +		/* kHz	uV */
> > > +		996000	1250000
> > > +		852000	1250000
> > > +		792000	1175000
> > > +		396000	975000
> > +	>;
> > +	fsl,soc-operating-points = <
> > > +		/* ARM kHz	SOC-PU uV */
> > > +		996000		1250000
> > > +		852000		1250000
> > > +		792000		1175000
> > > +		396000		1175000
> > +	>;
> +};
> +
>  &ecspi1 {
> >  	cs-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>, <&gpio3 19 GPIO_ACTIVE_HIGH>;
> >  	pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 70483ce72ba6..78b89bb1bfed 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -50,25 +50,106 @@
> >  			soc-supply = <&reg_soc>;
> >  		};
>  
> > -		cpu@1 {
> > > +		cpu1: cpu@1 {
> >  			compatible = "arm,cortex-a9";
> >  			device_type = "cpu";
> >  			reg = <1>;
> >  			next-level-cache = <&L2>;
> > +			operating-points = <
> > +				/* kHz    uV */
> > +				1200000 1275000
> > +				996000  1250000
> > +				852000  1250000
> > +				792000  1175000
> > +				396000  975000
> > +			>;
> > +			fsl,soc-operating-points = <
> > +				/* ARM kHz  SOC-PU uV */
> > +				1200000 1275000
> > > +				996000	1250000
> > > +				852000	1250000
> > > +				792000	1175000
> > > +				396000	1175000
> > +			>;
> > +			clock-latency = <61036>; /* two CLK32 periods */
> > +			clocks = <&clks IMX6QDL_CLK_ARM>,
> > +				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
> > +				 <&clks IMX6QDL_CLK_STEP>,
> > +				 <&clks IMX6QDL_CLK_PLL1_SW>,
> > +				 <&clks IMX6QDL_CLK_PLL1_SYS>;
> > +			clock-names = "arm", "pll2_pfd2_396m", "step",
> > +				      "pll1_sw", "pll1_sys";
> > +			arm-supply = <&reg_arm>;
> > +			pu-supply = <&reg_pu>;
> > +			soc-supply = <&reg_soc>;
> >  		};
>  
> > -		cpu@2 {
> > > +		cpu2: cpu@2 {
> >  			compatible = "arm,cortex-a9";
> >  			device_type = "cpu";
> >  			reg = <2>;
> >  			next-level-cache = <&L2>;
> > +			operating-points = <
> > +				/* kHz    uV */
> > +				1200000 1275000
> > +				996000  1250000
> > +				852000  1250000
> > +				792000  1175000
> > +				396000  975000
> > +			>;
> > +			fsl,soc-operating-points = <
> > +				/* ARM kHz  SOC-PU uV */
> > +				1200000 1275000
> > > +				996000	1250000
> > > +				852000	1250000
> > > +				792000	1175000
> > > +				396000	1175000
> > +			>;
> > +			clock-latency = <61036>; /* two CLK32 periods */
> > +			clocks = <&clks IMX6QDL_CLK_ARM>,
> > +				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
> > +				 <&clks IMX6QDL_CLK_STEP>,
> > +				 <&clks IMX6QDL_CLK_PLL1_SW>,
> > +				 <&clks IMX6QDL_CLK_PLL1_SYS>;
> > +			clock-names = "arm", "pll2_pfd2_396m", "step",
> > +				      "pll1_sw", "pll1_sys";
> > +			arm-supply = <&reg_arm>;
> > +			pu-supply = <&reg_pu>;
> > +			soc-supply = <&reg_soc>;
> >  		};
>  
> > -		cpu@3 {
> > > +		cpu3: cpu@3 {
> >  			compatible = "arm,cortex-a9";
> >  			device_type = "cpu";
> >  			reg = <3>;
> >  			next-level-cache = <&L2>;
> > +			operating-points = <
> > +				/* kHz    uV */
> > +				1200000 1275000
> > +				996000  1250000
> > +				852000  1250000
> > +				792000  1175000
> > +				396000  975000
> > +			>;
> > +			fsl,soc-operating-points = <
> > +				/* ARM kHz  SOC-PU uV */
> > +				1200000 1275000
> > > +				996000	1250000
> > > +				852000	1250000
> > > +				792000	1175000
> > > +				396000	1175000
> > +			>;
> > +			clock-latency = <61036>; /* two CLK32 periods */
> > +			clocks = <&clks IMX6QDL_CLK_ARM>,
> > +				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
> > +				 <&clks IMX6QDL_CLK_STEP>,
> > +				 <&clks IMX6QDL_CLK_PLL1_SW>,
> > +				 <&clks IMX6QDL_CLK_PLL1_SYS>;
> > +			clock-names = "arm", "pll2_pfd2_396m", "step",
> > +				      "pll1_sw", "pll1_sys";
> > +			arm-supply = <&reg_arm>;
> > +			pu-supply = <&reg_pu>;
> > +			soc-supply = <&reg_soc>;
> >  		};
> >  	};
>  
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 4c9877ec29f2..5434a8aa5602 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -21,6 +21,11 @@
> >  			compatible = "arm,cortex-a7";
> >  			device_type = "cpu";
> >  			reg = <1>;
> > +			operating-points = <
> > > +				/* KHz	uV */
> > > +				996000	1075000
> > > +				792000	975000
> > +			>;
> >  			clock-frequency = <996000000>;
> >  		};
> >  	};
