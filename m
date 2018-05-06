Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeEFVjJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 17:39:09 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:54650 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeEFVjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 17:39:07 -0400
Message-ID: <2f45fb80d9c56b11a93a2ffc80217a4074cb572b.camel@paulk.fr>
Subject: Re: [PATCH 3/3] ARM: dts: sun7i: Add support for the Ainol AW1
 tablet
From: Paul Kocialkowski <contact@paulk.fr>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org
Date: Sun, 06 May 2018 23:38:51 +0200
In-Reply-To: <20180506205619.5591-3-contact@paulk.fr>
References: <20180506205619.5591-1-contact@paulk.fr>
         <20180506205619.5591-3-contact@paulk.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ksghnooShb75xlCfqZvF"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ksghnooShb75xlCfqZvF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dimanche 06 mai 2018 =C3=A0 22:56 +0200, Paul Kocialkowski a =C3=A9crit =
:
> This adds support for the Ainol AW1, an A20-based 7" tablet from
> Ainol.
>=20
> The following board-specific features are supported:
> * LCD panel
> * Backlight
> * USB OTG
> * Buttons
> * Touchscreen (doesn't work without non-free firmware)
> * Accelerometer
> * Battery
>=20
> The following are untested:
> * Audio output
> * Audio speakers
> * USB via SPCI connector
>=20
> The following are not supported:
> * Wi-Fi
> * Bluetooth
> * NAND
> * Audio via SPCI connector
> * Audio via Bluetooth I2S
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts | 275
> ++++++++++++++++++++++
>  2 files changed, 276 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e2424957809..4a80971f2bc9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -946,6 +946,7 @@ dtb-$(CONFIG_MACH_SUN6I) +=3D \
>  	sun6i-a31s-sinovoip-bpi-m2.dtb \
>  	sun6i-a31s-yones-toptech-bs1078-v2.dtb
>  dtb-$(CONFIG_MACH_SUN7I) +=3D \
> +	sun7i-a20-ainol-aw1.dtb \
>  	sun7i-a20-bananapi.dtb \
>  	sun7i-a20-bananapi-m1-plus.dtb \
>  	sun7i-a20-bananapro.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> new file mode 100644
> index 000000000000..6bb7f47fd010
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> @@ -0,0 +1,275 @@
> +/*
> + * Copyright (C) 2018 Paul Kocialkowski <contact@paulk.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0+
> + */
> +
> +/dts-v1/;
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model =3D "Ainol AW1";
> +	compatible =3D "ainol,ainol-aw1", "allwinner,sun7i-a20";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> +		brightness-levels =3D <0 10 20 30 40 50 60 70 80 90
> 100>;
> +		default-brightness-level =3D <5>;
> +		enable-gpios =3D <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> +	};
> +
> +	panel: panel {
> +		compatible =3D "innolux,at070tn90";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-supply =3D <&panel_power>;
> +		backlight =3D <&backlight>;
> +
> +		port@0 {
> +			reg =3D <0>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			panel_input: endpoint@0 {
> +				reg =3D <0>;
> +				remote-endpoint =3D <&tcon0_out_panel>;
> +			};
> +		};
> +	};
> +
> +	panel_power: panel_power {
> +		compatible =3D "regulator-fixed";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&panel_power_pin>;
> +		regulator-name =3D "panel-power";
> +		regulator-min-microvolt =3D <10400000>;
> +		regulator-max-microvolt =3D <10400000>;
> +		gpio =3D <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
> +		enable-active-high;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&codec {
> +	allwinner,pa-gpios =3D <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
> +	status =3D "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&de {
> +	status =3D "okay";
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c0_pins_a>;
> +	status =3D "okay";
> +
> +	axp209: pmic@34 {
> +		reg =3D <0x34>;
> +		interrupt-parent =3D <&nmi_intc>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c1_pins_a>;
> +	status =3D "okay";
> +
> +	lis3dh: accelerometer@18 {
> +		compatible =3D "st,lis3dh-accel";
> +		reg =3D <0x18>;
> +		vdd-supply =3D <&reg_vcc3v3>;
> +		vddio-supply =3D <&reg_vcc3v3>;
> +		st,drdy-int-pin =3D <1>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c2_pins_a>;
> +	status =3D "okay";
> +	clock-frequency =3D <400000>;
> +
> +	gsl1680: touchscreen@40 {
> +		compatible =3D "silead,gsl1680";
> +		reg =3D <0x40>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21
> (PH21) */
> +		power-gpios =3D <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20
> */
> +		firmware-name =3D "gsl1680-ainol-aw1.fw";
> +		touchscreen-size-x =3D <480>;
> +		touchscreen-size-y =3D <800>;
> +		touchscreen-swapped-x-y;
> +		touchscreen-inverted-y;
> +		silead,max-fingers =3D <5>;
> +	};
> +};
> +
> +&lradc {
> +	vref-supply =3D <&reg_ldo2>;
> +	status =3D "okay";
> +
> +	button@571 {
> +		label =3D "Volume Up";
> +		linux,code =3D <KEY_VOLUMEUP>;
> +		channel =3D <0>;
> +		voltage =3D <571428>;
> +	};
> +
> +	button@761 {
> +		label =3D "Volume Down";
> +		linux,code =3D <KEY_VOLUMEDOWN>;
> +		channel =3D <0>;
> +		voltage =3D <761904>;
> +	};
> +
> +	button@952 {
> +		label =3D "Home";
> +		linux,code =3D <KEY_HOME>;
> +		channel =3D <0>;
> +		voltage =3D <952380>;
> +	};
> +};
> +
> +&mmc0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc0_pins_a>;
> +	vmmc-supply =3D <&reg_vcc3v3>;
> +	bus-width =3D <4>;
> +	cd-gpios =3D <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> +	cd-inverted;
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
> +	status =3D "okay";
> +};
> +
> +&ohci1 {
> +	status =3D "okay";
> +};
> +
> +&otg_sram {
> +	status =3D "okay";
> +};
> +
> +&pio {
> +	panel_power_pin: panel_power_pin@0 {
> +		pins =3D "PH8";
> +		function =3D "gpio_out";
> +	};
> +};
> +
> +&pwm {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pwm0_pins_a>;
> +	status =3D "okay";
> +};
> +
> +&tcon0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&lcd0_rgb888_pins>;

Mhh, looks like this should be lcd0_rgb666_pins.

> +	status =3D "okay";
> +};
> +
> +&tcon0_out {
> +	tcon0_out_panel: endpoint@0 {
> +		reg =3D <0>;
> +		remote-endpoint =3D <&panel_input>;
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart0_pins_a>;
> +	status =3D "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode =3D "otg";
> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	usb0_id_det-gpio =3D <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> +	usb0_vbus_power-supply =3D <&usb_power_supply>;
> +	usb0_vbus-supply =3D <&reg_usb0_vbus>;
> +	usb1_vbus-supply =3D <&reg_usb1_vbus>;
> +	usb2_vbus-supply =3D <&reg_usb2_vbus>;
> +	status =3D "okay";
> +};
> +
> +#include "axp209.dtsi"
> +
> +&battery_power_supply {
> +	status =3D "okay";
> +};
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1450000>;
> +	regulator-name =3D "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1400000>;
> +	regulator-name =3D "vdd-int-dll";
> +};
> +
> +&reg_ldo1 {
> +	regulator-name =3D "vdd-rtc";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <3000000>;
> +	regulator-max-microvolt =3D <3000000>;
> +	regulator-name =3D "avcc";
> +};
> +
> +&reg_usb0_vbus {
> +	status =3D "okay";
> +};
> +
> +&reg_usb1_vbus {
> +	status =3D "okay";
> +};
> +
> +&reg_usb2_vbus {
> +	status =3D "okay";
> +};
> +
> +&usb_power_supply {
> +	status =3D "okay";
> +};
--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-ksghnooShb75xlCfqZvF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrvdesACgkQhP3B6o/u
lQwX8Q//ZrTxkRkWS8IGQc0mVZtauRG7BCpGHLcJUJOemBgnMPXuQmofXNTGIRVJ
/0lL4YOzJbukt3xnEqnNEiPYLs+PEKmCmy0r1EKosS0bStpew86LPVkgFKQxOdCJ
qtCDKKYZoRcwjgVQkGpzsb14miZSkJ/aLPSt1gPA+YGG6346sMpc6hrn5E4fsiDI
fNswH43M1xB8dfeqUfL9kwKD7GMF+7oqnV0xYbjwsDn8zaMNqMsIveHogbO5RzOd
6Y0BN5kcKosrdrowwIcecE48KbCaEeXv3QqTeRrGMUQF7TvRHl789yiIPxVdOkaM
tjdJs2T0cpaRgFJIDdizqWhJxSdT/lHN2Ot68buNFsQ6VI90Eh7R05AHPY+LU5lt
Fb3AKxvaaMmeBjqwDNzDOU2OOHFBmIDqttdNNUIdYHhyyyMxOguEcD4OmV9RqTki
ACv8YaGxN97RUPKscSN3ceht6fa2cYKepOSt25N04YfyYVoGwfNKzjSOYUoQyVzd
q3CHkh7WYS0m9lfCQntw6psxGTrKsq5tGNUBtauS/1dTfdshkvbPmfgMc++5mJN4
DvrE5awVTTS42FBOz84j4OTU9vjNLMWwzUhNt0lPTwXLDnvcop3o3bVy/UQTcuHW
1IKVDom6cUctQhI3VWJr6F3b6ftqkWQ7bm8Ok97MX5PlBrJLK5g=
=UuhG
-----END PGP SIGNATURE-----

--=-ksghnooShb75xlCfqZvF--
