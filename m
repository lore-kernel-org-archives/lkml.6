Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932846AbeD0TJk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:09:40 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37339 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932774AbeD0TJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:09:37 -0400
X-Google-Smtp-Source: AB8JxZrOEkDWqZvpaBB0cvqwofD3D+VoOYy1evM+BCnSR6iBxvwNdUHYi7+9urTxtPiCjDH99BsYuA==
From: Kevin Hilman <khilman@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] ARM64: dts: meson-axg: enable AP6255 wifi module
Organization: BayLibre
References: <20180423145729.14368-1-yixun.lan@amlogic.com>
Date: Fri, 27 Apr 2018 12:09:35 -0700
In-Reply-To: <20180423145729.14368-1-yixun.lan@amlogic.com> (Yixun Lan's
        message of "Mon, 23 Apr 2018 14:57:29 +0000")
Message-ID: <7h7eos1n68.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> The Meson-AXG S400 board is shipped with AP6255 wifi module,
> which is actually using the brcmfmac 43455 driver.
>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 44 ++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index f67d4e47e641..b3e1bdca32bb 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -51,7 +51,16 @@
>  
>  	sdio_pwrseq: sdio-pwrseq {
>  		compatible = "mmc-pwrseq-simple";
> -		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&gpio GPIOX_7 GPIO_ACTIVE_LOW>;

You didn't mention this GPIO change in the changelog.  Is it
intentional?

Kevin

> +		clocks = <&wifi32k>;
> +		clock-names = "ext_clock";
> +	};
> +
> +	wifi32k: wifi32k {
> +		compatible = "pwm-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		pwms = <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
>  	};
>  };
>  
> @@ -86,6 +95,12 @@
>  	pinctrl-names = "default";
>  };
>  
> +&pwm_ab {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_a_x20_pins>;
> +	pinctrl-names = "default";
> +};
> +
>  /* emmc storage */
>  &sd_emmc_c {
>  	status = "okay";
> @@ -105,3 +120,30 @@
>  	vmmc-supply = <&vcc_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
>  };
> +
> +/* wifi module */
> +&sd_emmc_b {
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	pinctrl-0 = <&sdio_pins>;
> +	pinctrl-1 = <&sdio_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	max-frequency = <100000000>;
> +	non-removable;
> +	disable-wp;
> +
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddio_boot>;
> +
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};
