Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbeCFChv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:37:51 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43527 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeCFCht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:37:49 -0500
X-Google-Smtp-Source: AG47ELu/h5kIDhZVPaMuEaZzIa6+oFuI3N3NQ68ZTNZp2r3ARVdnEcdzkninYe7ZgycW+v80PH0MsQ==
Date: Mon, 5 Mar 2018 20:37:47 -0600
From: Rob Herring <robh@kernel.org>
To: patrice.chotard@st.com
Cc: mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alexandre.torgue@st.com,
        lee.jones@linaro.org, mcoquelin.stm32@gmail.com
Subject: Re: [PATCH v2 4/6] ARM: dts: stm32: Enable sdio1 for stm32f769-disco
Message-ID: <20180306023747.lzh5yxfyugtlu62t@rob-hp-laptop>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
 <1519901623-23216-5-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519901623-23216-5-git-send-email-patrice.chotard@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:53:41AM +0100, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Adds SDIO related DT nodes for stm32f769-disco board.
> 
> broken-cd property is needed as it misses a pullup on board
> (resistor R76 is missing).
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  arch/arm/boot/dts/stm32f769-disco.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 9dba286c6d2f..2d922b5d4766 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -44,6 +44,7 @@
>  #include "stm32f746.dtsi"
>  #include "stm32f769-pinctrl.dtsi"
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	model = "STMicroelectronics STM32F769-DISCO board";
> @@ -62,6 +63,12 @@
>  		serial0 = &usart1;
>  	};
>  
> +	mmc_vcard: mmc_vcard {

mmc-vcard {

> +		compatible = "regulator-fixed";
> +		regulator-name = "mmc_vcard";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
>  };
>  
>  &cec {
> @@ -74,6 +81,18 @@
>  	clock-frequency = <25000000>;
>  };
>  
> +&sdio2 {
> +	status = "okay";
> +	vmmc-supply = <&mmc_vcard>;
> +	cd-gpios = <&gpioi 15 GPIO_ACTIVE_HIGH>;
> +	cd-inverted;
> +	broken-cd;
> +	pinctrl-names = "default", "opendrain";
> +	pinctrl-0 = <&sdio_pins_b>;
> +	pinctrl-1 = <&sdio_pins_od_b>;
> +	bus-width = <4>;
> +};
> +
>  &usart1 {
>  	pinctrl-0 = <&usart1_pins_a>;
>  	pinctrl-names = "default";
> -- 
> 1.9.1
> 
