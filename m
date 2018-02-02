Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeBBWA6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:00:58 -0500
Received: from gloria.sntech.de ([95.129.55.99]:52212 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751809AbeBBWAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:00:52 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou
Date: Fri, 02 Feb 2018 23:00:37 +0100
Message-ID: <1896849.q5MJicbXVp@phil>
In-Reply-To: <20180130101531.41411-1-klaus.goger@theobroma-systems.com>
References: <20180130101531.41411-1-klaus.goger@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Klaus,

Am Dienstag, 30. Januar 2018, 11:15:31 CET schrieb Klaus Goger:
> Enable the NXP SGTL5000 audio codec on the RK3399-Q7 EVK baseboard
> Haikou.
> 
> The i2s0_2ch_bus definition is only done in the SoM dtsi as it is
> missing the LRCK_RX pin (that is used otherwise) and therefore not
> generic enough for the SoC dtsi.
> 
> Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>

I did fix up the small ordering issues already but then found the i2s
pinctrl issue below, which will need a slightly bigger change and thus
a respin please.


>  .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 49 ++++++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 18 ++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> index 9a7486058455..060c6be7d7e3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> @@ -61,6 +61,22 @@
>  		};
>  	};
>  
> +	i2s0_sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,name = "Haikou,I2S-codec";
> +		simple-audio-card,mclk-fs = <512>;
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s0>;
> +			frame-master;
> +			bitclock-master;
> +		};
> +		simple-audio-card,codec {
> +			sound-dai = <&sgtl5000>;
> +			clocks = <&sgtl5000_clk>;
> +		};
> +	};
> +

odering and a bit of spacing:

+	i2s0_sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Haikou,I2S-codec";
+		simple-audio-card,mclk-fs = <512>;
+
+		simple-audio-card,codec {
+			clocks = <&sgtl5000_clk>;
+			sound-dai = <&sgtl5000>;
+		};
+
+		simple-audio-card,cpu {
+			bitclock-master;
+			frame-master;
+			sound-dai = <&i2s0>;
+		};
+	};

>  	dc_12v: dc-12v {
>  		compatible = "regulator-fixed";
>  		regulator-name = "dc_12v";

> @@ -110,6 +148,17 @@
>  &i2c4 {
>  	status = "okay";
>  	clock-frequency = <400000>;
> +
> +	sgtl5000: codec@0a {
> +		#sound-dai-cells = <0>;
> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;
> +		VDDA-supply = <&vdda_codec>;
> +		VDDIO-supply = <&vdda_codec>;
> +		VDDD-supply = <&vddd_codec>;
> +		clocks = <&sgtl5000_clk>;
> +		status = "okay";
> +	};

ordering again

+	sgtl5000: codec@0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&sgtl5000_clk>;
+		#sound-dai-cells = <0>;
+		VDDA-supply = <&vdda_codec>;
+		VDDIO-supply = <&vdda_codec>;
+		VDDD-supply = <&vddd_codec>;
+		status = "okay";
+	};

>  };
>  
>  &i2c6 {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> index 1fc5060d7027..a3fcb803ff69 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> @@ -435,6 +435,14 @@
>  	};
>  };
>  
> +&i2s0 {
> +	#sound-dai-cells = <0>;
> +	status = "okay";
> +	pinctrl-0 = <&i2s0_2ch_bus>;
> +	rockchip,playback-channels = <2>;
> +	rockchip,capture-channels = <2>;
> +};

ordering

+&i2s0 {
+	pinctrl-0 = <&i2s0_2ch_bus>;
+	rockchip,playback-channels = <2>;
+	rockchip,capture-channels = <2>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+};


> @@ -461,6 +469,16 @@
>  		};
>  	};
>  
> +	i2s0 {
> +		i2s0_2ch_bus: i2s0_2ch_bus {

node names should use dashes, so
		i2s0_2ch_bus: i2s0-2ch-bus

But also, could you define the generic i2s0-2ch-bus (incl the phandle)
in rk3399.dtsi in a first patch and just override it here to not use that
LRCK_RX pin please?


Thanks
Heiko
