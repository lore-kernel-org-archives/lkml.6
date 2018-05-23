Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754450AbeEWIiU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:38:20 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:56608 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754168AbeEWIhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:37:52 -0400
Date: Wed, 23 May 2018 10:37:48 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] ARM: dts: r8a7791: Move enable-method to CPU nodes
Message-ID: <20180523083746.f4nkz4uhjwfgw7yz@verge.net.au>
References: <1526995765-29693-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526995765-29693-1-git-send-email-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 03:29:25PM +0200, Geert Uytterhoeven wrote:
> According to Documentation/devicetree/bindings/arm/cpus.txt, the
> "enable-method" property should be a property of the individual CPU
> nodes, not of the parent "cpus" node.  However, on R-Car M2-W (and on
> several other arm32 SoCs), the property is tied to the "cpus" node
> instead.
> 
> Secondary CPU bringup and CPU hot (un)plug work regardless, as
> arm_dt_init_cpu_maps() falls back to looking in the "cpus" node.
> 
> The cpuidle code does not have such a fallback, so it does not detect
> the enable-method.  Note that cpuidle does not support the
> "renesas,apmu" enable-method yet, so for now this does not make any
> difference.

Is the implication that if we keep the current binding for cpu nodes
then at some point we will need to update the cpuidle binding?

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Arm64 and powerpc do not have such a fallback, but SH has, like arm32.
> 
> This is marked RFC, as the alternative is to update the DT bindings to
> keep the status quo.
> ---
>  arch/arm/boot/dts/r8a7791.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index d568bd22d6cbd855..b214cb8f52e47109 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -71,7 +71,6 @@
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		enable-method = "renesas,apmu";
>  
>  		cpu0: cpu@0 {
>  			device_type = "cpu";
> @@ -83,6 +82,7 @@
>  			clock-latency = <300000>; /* 300 us */
>  			power-domains = <&sysc R8A7791_PD_CA15_CPU0>;
>  			next-level-cache = <&L2_CA15>;
> +			enable-method = "renesas,apmu";
>  
>  			/* kHz - uV - OPPs unknown yet */
>  			operating-points = <1500000 1000000>,
> @@ -101,6 +101,7 @@
>  			clocks = <&cpg CPG_CORE R8A7791_CLK_Z>;
>  			power-domains = <&sysc R8A7791_PD_CA15_CPU1>;
>  			next-level-cache = <&L2_CA15>;
> +			enable-method = "renesas,apmu";
>  		};
>  
>  		L2_CA15: cache-controller-0 {
> -- 
> 2.7.4
> 
