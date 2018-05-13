Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEMMYS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 08:24:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40235 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeEMMYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 08:24:16 -0400
X-Google-Smtp-Source: AB8JxZq0N/wQlu/csg32wKsAOyP0Jdmd1Xxr/kRJOb50U27uFP7Ja4RJgQfIewt1jBbEMynb2cuncw==
Date: Sun, 13 May 2018 14:24:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH] ARM: dts: exynos: Use dedicated DT bindings for Odroid
 X/X2, U3
Message-ID: <20180513122412.shxdxtxt2phb46l5@kozik-lap>
References: <CGME20180511081032epcas2p30f381cf699cb7524d9a143390e9c74b5@epcas2p3.samsung.com>
 <20180511080947.3057-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180511080947.3057-1-s.nawrocki@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 10:09:47AM +0200, Sylwester Nawrocki wrote:
> Use dedicated Odroid audio subsystem DT bindings instead of the simple-card.
> This adds support for audio on the HDMI interface.

How about changing the subject to "Add suppor for audio over HDMI for
Odroid X/X2/U3"?


> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 33 ++++++++++++++-----------
>  arch/arm/boot/dts/exynos4412-odroidu3.dts       |  7 +++---
>  arch/arm/boot/dts/exynos4412-odroidx.dts        |  7 +++---
>  3 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index d7ad07fd48f9..bad08e70358a 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -37,20 +37,12 @@
>  	};
>  
>  	sound: sound {
> -		compatible = "simple-audio-card";
> -
> -		simple-audio-card,format = "i2s";
> -		simple-audio-card,bitclock-master = <&link0_codec>;
> -		simple-audio-card,frame-master = <&link0_codec>;
> -
> -		simple-audio-card,cpu {
> +		cpu {
>  			sound-dai = <&i2s0 0>;
> -			system-clock-frequency = <19200000>;
>  		};
>  
> -		link0_codec: simple-audio-card,codec {
> -			sound-dai = <&max98090>;
> -			clocks = <&i2s0 CLK_I2S_CDCLK>;
> +		codec {
> +			sound-dai = <&hdmi>, <&max98090>;
>  		};
>  	};
>  
> @@ -142,14 +134,25 @@
>  	pinctrl-0 = <>;
>  };
>  
> +&clock {
> +	assigned-clocks = <&clock CLK_FOUT_EPLL>;
> +	assigned-clock-rates = <45158401>;
> +};
> +
>  &clock_audss {
>  	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
>  			<&clock_audss EXYNOS_MOUT_I2S>,
>  			<&clock_audss EXYNOS_DOUT_SRP>,
> -			<&clock_audss EXYNOS_DOUT_AUD_BUS>;
> +			<&clock_audss EXYNOS_DOUT_AUD_BUS>,
> +			<&clock_audss EXYNOS_DOUT_I2S>;
> +
>  	assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
> -			<&clock_audss EXYNOS_MOUT_AUDSS>;
> -	assigned-clock-rates = <0>, <0>, <192000000>, <19200000>;
> +			  <&clock_audss EXYNOS_MOUT_AUDSS>;
> +
> +	assigned-clock-rates = <0>, <0>,
> +			<196608001>,
> +			<(196608001 / 2)>,
> +			<(196608001 / 8)>;
>  };
>  
>  &cpu0 {
> @@ -498,6 +501,8 @@
>  	pinctrl-0 = <&i2s0_bus>;
>  	pinctrl-names = "default";
>  	status = "okay";
> +	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
> +	assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>;
>  };
>  
>  &mixer {
> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> index bdcd4523cc1c..7a94a423097d 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> @@ -113,11 +113,12 @@
>  };
>  
>  &sound {
> -	simple-audio-card,name = "Odroid-U3";
> -	simple-audio-card,widgets =
> +	compatible = "hardkernel,odroid-xu4-audio";

The compatible is the same for all users using DTSI so it could be moved
to the exynos4412-odroid-common.dtsi itself.

Best regards,
Krzysztof

> +	model = "Odroid-U3";
> +	samsung,audio-widgets =
>  		"Headphone", "Headphone Jack",
>  		"Speakers", "Speakers";
> -	simple-audio-card,routing =
> +	samsung,audio-routing =
>  		"Headphone Jack", "HPL",
>  		"Headphone Jack", "HPR",
>  		"Headphone Jack", "MICBIAS",
> diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
> index 2dff129bc2ad..f0d5037f3a5d 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidx.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
> @@ -97,12 +97,13 @@
>  };
>  
>  &sound {
> -	simple-audio-card,name = "Odroid-X";
> -	simple-audio-card,widgets =
> +	compatible = "hardkernel,odroid-xu4-audio";
> +	model = "Odroid-X";
> +	samsung,audio-widgets =
>  		"Headphone", "Headphone Jack",
>  		"Microphone", "Mic Jack",
>  		"Microphone", "DMIC";
> -	simple-audio-card,routing =
> +	samsung,audio-routing =
>  		"Headphone Jack", "HPL",
>  		"Headphone Jack", "HPR",
>  		"IN1", "Mic Jack",
> -- 
> 2.14.2
> 
