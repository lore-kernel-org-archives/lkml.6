Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeBISxK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:53:10 -0500
Received: from gloria.sntech.de ([95.129.55.99]:42124 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeBISxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:53:09 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou
Date: Fri, 09 Feb 2018 19:52:59 +0100
Message-ID: <2448065.tRKBKgXtGg@phil>
In-Reply-To: <20180203155016.51909-3-klaus.goger@theobroma-systems.com>
References: <20180203155016.51909-1-klaus.goger@theobroma-systems.com> <20180203155016.51909-3-klaus.goger@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Klaus,

Am Samstag, 3. Februar 2018, 16:50:16 CET schrieb Klaus Goger:
> Enable the NXP SGTL5000 audio codec on the RK3399-Q7 EVK baseboard
> Haikou.
> 
> The i2s0_2ch_bus definition is only done in the SoM dtsi as it is
> missing the LRCK_RX pin (that is used otherwise) and therefore not
> generic enough for the SoC dtsi.
> 
> Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>

as we talked about today at Fosdem, please add the changes as below

> +	i2s0_sound {

nit: is20-sound

[...]

>  		regulator-name = "vcc5v0_otg";
>  		regulator-always-on;
>  	};
> +
> +	vdda_codec: vdda-codec {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdda_codec";
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;

vin-supply, so that the regulator-tree becomes an actual tree?

> +	};
> +
> +	vddd_codec: vddd-codec {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vddd_codec";
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1600000>;
> +		regulator-max-microvolt = <1600000>;

vin-supply?


> -&i2s0 {
> -	status = "okay";
> -	rockchip,playback-channels = <8>;
> -	rockchip,capture-channels = <8>;
> -	#sound-dai-cells = <0>;
> -	status = "okay";
> -};
> -

please do the move of the &i2s0 block in a separate patch

> @@ -461,6 +469,23 @@
>  		};
>  	};
>  
> +	i2s0 {
> +		/*
> +		 * As Q7 does not specify neither a global nor a RX clock for I2S these
> +		 * signals are not used. Furthermore I2S0_LRCK_RX is used as GPIO.
> +		 * Therefore we have to redefine the i2s0_2ch_bus definition to prevent
> +		 * conflicts.
> +		 */
> +		/delete-node/ i2s0_2ch_bus;
> +		i2s0_2ch_bus: i2s0-2ch-bus {
> +			rockchip,pins =
> +				<RK_GPIO3 RK_PD0 RK_FUNC_1 &pcfg_pull_none>,
> +				<RK_GPIO3 RK_PD2 RK_FUNC_1 &pcfg_pull_none>,
> +				<RK_GPIO3 RK_PD3 RK_FUNC_1 &pcfg_pull_none>,
> +				<RK_GPIO3 RK_PD7 RK_FUNC_1 &pcfg_pull_none>;
> +		};
> +	};
> +

please keep the comment but make this an
&i2s0_2ch_bus {
	rockchip,pins =
}

as overriding only a single property doesn't require the /delete-node/
magic.


Thanks
Heiko
