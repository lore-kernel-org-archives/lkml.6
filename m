Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756839AbeDZQrD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:47:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56410 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754544AbeDZQq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:46:58 -0400
Subject: Re: [linux-sunxi] [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
To: icenowy@aosc.io, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-4-icenowy@aosc.io>
From: Andre Przywara <andre.przywara@arm.com>
Message-ID: <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com>
Date: Thu, 26 Apr 2018 17:46:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426140728.43155-4-icenowy@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/04/18 15:07, Icenowy Zheng wrote:
> The Pine H64 board have a MicroSD slot connected to MMC0 controller of
> the H6 SoC and a eMMC slot connected to MMC2.
> 
> Enable them in the device tree.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index d36de5eb81f3..78b1cd54687c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -20,6 +20,38 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	reg_vcc3v3: vcc3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	reg_vcc1v8: vcc1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins>;
> +	vmmc-supply = <&reg_vcc3v3>;

So this is actually CLDO1 on the AXP, correct?


> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_pins>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc1v8>;

And this is BLDO2?

I am just asking because I want to avoid running into the same problem
as with the A64 before: that future DTs become incompatible with older
kernels, because we change the power supply to point to the AXP
regulators, which this kernel does not support yet.

It looks like there are more users of those power rails, so we could
keep those supplies connected to these fixed regulators here, even with
AXP-805 support in the kernel.

Or we keep this back until we get proper AXP support in the kernel? I
guess it's quite close to the existing PMICs, so it might be more a
copy&paste exercise to support the AXP-805?

But apart from this this looks correct to me.

Cheers,
Andre.

> +	non-removable;
> +	cap-mmc-hw-reset;
> +	status = "okay";
>  };
>  
>  &uart0 {
> 
