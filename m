Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBGWV5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 17:21:57 -0500
Received: from vern.gendns.com ([206.190.152.46]:39905 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751993AbeBGWVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 17:21:55 -0500
Subject: Re: [PATCH 5/7] ARM: dts: da850: add power-domains properties to
 device nodes
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180207134553.13510-1-brgl@bgdev.pl>
 <20180207134553.13510-6-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <25c285d4-4348-8bca-ba12-26464e13ed30@lechnology.com>
Date: Wed, 7 Feb 2018 16:21:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180207134553.13510-6-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Make all devices managed by PSCs use the genpd driver.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/boot/dts/da850.dtsi | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index ac2eef4e6b7c..a2a1a3b7de3c 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -83,6 +83,7 @@
>   			ti,intc-size = <101>;
>   			reg = <0xfffee000 0x2000>;
>   			clocks = <&psc0 6>;
> +			power-domains = <&pwc0>;

If we are making this a power domain consumer, we can probably drop the
clock property.

>   		};
>   	};
>   	clocks: clocks {
> @@ -125,6 +126,7 @@
>   		interrupt-parent = <&intc>;
>   		interrupts = <28>;
>   		clocks = <&psc0 15>;
> +		power-domains = <&pwc0>;
>   		status = "disabled";
>   	};
>   	soc@1c00000 {
> @@ -400,12 +402,14 @@
>   				clocks = <&psc1 1>, <&usb_refclkin>,
>   					 <&pll0_auxclk>;
>   				clock-names = "fck", "usb_refclkin", "auxclk";
> +				power-domains = <&pwc1>;

If we are going to use a power domain here, this driver will need to be re-written.

>   			};
>   			ehrpwm_tbclk: ehrpwm_tbclk {
>   				compatible = "ti,da830-tbclksync";
>   				#clock-cells = <0>;
>   				clocks = <&psc1 17>;
>   				clock-names = "fck";
> +				power-domains = <&pwc1>;

This is a clock node, not a (platform) device node, so I am not sure having
a power domain here makes sense.

>   			};
>   			div4p5_clk: div4.5 {
>   				compatible = "ti,da830-div4p5ena";
> @@ -439,6 +443,7 @@
>   
>   			ti,tptcs = <&edma0_tptc0 7>, <&edma0_tptc1 0>;
>   			clocks = <&psc0 0>;
> +			power-domains = <&pwc0>;

We really just need power-domains here, not clocks. Same applies to
the rest of the edma* nodes below.

>   		};
>   		edma0_tptc0: tptc@8000 {
>   			compatible = "ti,edma3-tptc";
> @@ -446,6 +451,7 @@
>   			interrupts = <13>;
>   			interrupt-names = "edm3_tcerrint";
>   			clocks = <&psc0 1>;
> +			power-domains = <&pwc0>;
>   		};
>   		edma0_tptc1: tptc@8400 {
>   			compatible = "ti,edma3-tptc";
> @@ -453,6 +459,7 @@
>   			interrupts = <32>;
>   			interrupt-names = "edm3_tcerrint";
>   			clocks = <&psc0 2>;
> +			power-domains = <&pwc0>;
>   		};
>   		edma1: edma@230000 {
>   			compatible = "ti,edma3-tpcc";
> @@ -465,6 +472,7 @@
>   
>   			ti,tptcs = <&edma1_tptc0 7>;
>   			clocks = <&psc1 0>;
> +			power-domains = <&pwc1>;
>   		};
>   		edma1_tptc0: tptc@238000 {
>   			compatible = "ti,edma3-tptc";
> @@ -472,6 +480,7 @@
>   			interrupts = <95>;
>   			interrupt-names = "edm3_tcerrint";
>   			clocks = <&psc1 21>;
> +			power-domains = <&pwc1>;
>   		};
>   		serial0: serial@42000 {
>   			compatible = "ti,da830-uart", "ns16550a";
> @@ -480,6 +489,7 @@
>   			reg-shift = <2>;
>   			interrupts = <25>;
>   			clocks = <&psc0 9>;
> +			power-domains = <&pwc0>;
>   			status = "disabled";
>   		};
>   		serial1: serial@10c000 {
> @@ -489,6 +499,7 @@
>   			reg-shift = <2>;
>   			interrupts = <53>;
>   			clocks = <&psc1 12>;
> +			power-domains = <&pwc1>;
>   			status = "disabled";
>   		};
>   		serial2: serial@10d000 {
> @@ -498,6 +509,7 @@
>   			reg-shift = <2>;
>   			interrupts = <61>;
>   			clocks = <&psc1 13>;
> +			power-domains = <&pwc1>;
>   			status = "disabled";
>   		};
>   		rtc0: rtc@23000 {
> @@ -523,6 +535,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			clocks = <&psc1 11>;
> +			power-domains = <&pwc1>;
>   			status = "disabled";
>   		};
>   		clocksource: timer@20000 {
> @@ -545,6 +558,7 @@
>   			dmas = <&edma0 16 0>, <&edma0 17 0>;
>   			dma-names = "rx", "tx";
>   			clocks = <&psc0 5>;
> +			power-domains = <&pwc0>;
>   			status = "disabled";
>   		};
>   		vpif: video@217000 {
> @@ -552,6 +566,7 @@
>   			reg = <0x217000 0x1000>;
>   			interrupts = <92>;
>   			clocks = <&psc1 9>;
> +			power-domains = <&pwc1>;
>   			status = "disabled";
>   
>   			/* VPIF capture port */
> @@ -575,6 +590,7 @@
>   			dmas = <&edma1 28 0>, <&edma1 29 0>;
>   			dma-names = "rx", "tx";
>   			clocks = <&psc1 18>;
> +			power-domains = <&pwc1>;
>   			status = "disabled";
>   		};
>   		ehrpwm0: pwm@300000 {
> @@ -585,6 +601,7 @@
>   			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
>   			clock-names = "fck", "tbclk";
>   			status = "disabled";
> +			power-domains = <&pwc1>;

nit picking: it would be nice to have power-domains before status just
to be consistent in the order.

>   		};
>   		ehrpwm1: pwm@302000 {
>   			compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm",
> @@ -592,6 +609,7 @@
>   			#pwm-cells = <3>;
>   			reg = <0x302000 0x2000>;
>   			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
> +			power-domains = <&pwc1>;
>   			clock-names = "fck", "tbclk";

nit picking: it would be nice to keep clocks and clock-names next to each
other. Also several places below.

>   			status = "disabled";
>   		};
> @@ -601,6 +619,7 @@
>   			#pwm-cells = <3>;
>   			reg = <0x306000 0x80>;
>   			clocks = <&psc1 20>;
> +			power-domains = <&pwc1>;
>   			clock-names = "fck";
>   			status = "disabled";
>   		};
> @@ -610,6 +629,7 @@
>   			#pwm-cells = <3>;
>   			reg = <0x307000 0x80>;
>   			clocks = <&psc1 20>;
> +			power-domains = <&pwc1>;
>   			clock-names = "fck";
>   			status = "disabled";
>   		};
> @@ -619,6 +639,7 @@
>   			#pwm-cells = <3>;
>   			reg = <0x308000 0x80>;
>   			clocks = <&psc1 20>;
> +			power-domains = <&pwc1>;
>   			clock-names = "fck";
>   			status = "disabled";
>   		};
> @@ -633,6 +654,7 @@
>   			dmas = <&edma0 14 0>, <&edma0 15 0>;
>   			dma-names = "rx", "tx";
>   			clocks = <&psc0 4>;
> +			power-domains = <&pwc0>;
>   			status = "disabled";
>   		};
>   		spi1: spi@30e000 {
> @@ -646,6 +668,7 @@
>   			dmas = <&edma0 18 0>, <&edma0 19 0>;
>   			dma-names = "rx", "tx";
>   			clocks = <&psc1 10>;
> +			power-domains = <&pwc1>;
>   			status = "disabled";
>   		};
>   		usb0: usb@200000 {
> @@ -658,6 +681,7 @@
>   			phys = <&usb_phy 0>;
>   			phy-names = "usb-phy";
>   			clocks = <&psc1 1>;
> +			power-domains = <&pwc1>;
>   			status = "disabled";
>   
>   			#address-cells = <1>;
> @@ -682,6 +706,7 @@
>   				#dma-cells = <2>;
>   				#dma-channels = <4>;
>   				clocks = <&psc1 1>;
> +				power-domains = <&pwc1>;

This node should not have clocks or power-domains since it is
a child node. Instead, the parent node should have clock-ranges.
I have already fixed this in my v7 branch.

>   				status = "okay";
>   			};
>   		};
> @@ -690,6 +715,7 @@
>   			reg = <0x218000 0x2000>, <0x22c018 0x4>;
>   			interrupts = <67>;
>   			clocks = <&psc1 8>, <&sata_refclk>;
> +			power-domains = <&pwc1>;
>   			clock-names = "fck", "refclk";
>   			status = "disabled";
>   		};
> @@ -713,6 +739,7 @@
>   			reg = <0x224000 0x1000>;
>   			clocks = <&psc1 5>;
>   			clock-names = "fck";
> +			power-domains = <&pwc1>;
>   			status = "disabled";
>   		};
>   		eth0: ethernet@220000 {
> @@ -729,6 +756,7 @@
>   					36
>   					>;
>   			clocks = <&psc1 5>;
> +			power-domains = <&pwc1>;
>   			status = "disabled";
>   		};
>   		usb1: usb@225000 {
> @@ -738,6 +766,7 @@
>   			phys = <&usb_phy 1>;
>   			phy-names = "usb-phy";
>   			clocks = <&psc1 2>;
> +			power-domains = <&pwc1>;
>   			status = "disabled";
>   		};
>   		gpio: gpio@226000 {
> @@ -756,6 +785,7 @@
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
>   			clocks = <&psc1 3>;
> +			power-domains = <&pwc1>;
>   			clock-names = "gpio";
>   		};
>   		psc1: clock-controller@227000 {
> @@ -788,6 +818,7 @@
>   				<&edma0 0 1>;
>   			dma-names = "tx", "rx";
>   			clocks = <&psc1 7>;
> +			power-domains = <&pwc1>;
>   		};
>   
>   		lcdc: display@213000 {
> @@ -797,6 +828,7 @@
>   			max-pixelclock = <37500>;
>   			clocks = <&psc1 16>;
>   			clock-names = "fck";
> +			power-domains = <&pwc1>;
>   			status = "disabled";
>   		};
>   	};
> @@ -809,6 +841,7 @@
>   		ranges = <0 0 0x60000000 0x08000000
>   			  1 0 0x68000000 0x00008000>;
>   		clocks = <&psc0 3>;
> +		power-domains = <&pwc0>;
>   		status = "disabled";
>   	};
>   	memctrl: memory-controller@b0000000 {
> 

Bigger picture question: what is the benefit of adding
power-domain nodes to all of these devices if they are
already working?
