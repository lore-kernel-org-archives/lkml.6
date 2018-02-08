Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeBHTY4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:24:56 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:40643 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBHTYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:24:54 -0500
X-Google-Smtp-Source: AH8x226MQTnjbKpJYStIYgRc2d9srpw/V03fhPfxYEq5jHzBcJxuFn4lxA/zh2t5l364x7u1PJmUUj0upJWK+OSS09o=
MIME-Version: 1.0
In-Reply-To: <20180208090345.GH31910@dragon>
References: <20180206191704.7933-1-yungching0725@gmail.com> <20180208090345.GH31910@dragon>
From: Yung-Ching LIN <yungching0725@gmail.com>
Date: Thu, 8 Feb 2018 11:24:53 -0800
Message-ID: <CACGtqyz-Af6GijOrWYpAM9xvRjUfftA_M1aayf5q+xU1-x8kYQ@mail.gmail.com>
Subject: Re: [v3] ARM: dts: imx: Add support for Advantech DMS-BA16
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Thanks for pointing out the issues.
Please see my inline comments below.

On Thu, Feb 8, 2018 at 1:03 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Wed, Feb 07, 2018 at 03:17:04AM +0800, Ken Lin wrote:
>> Add support for Advantech DMS-BA16 board, which uses
>> the Advantech BA-16 module.
>>
>> Signed-off-by: Ken Lin <yungching0725@gmail.com>
>> ---
>> Changes in v3:
>> - Fix the SPDX lines issue
>> - Fix the eeprom setting issue
>>
>>  arch/arm/boot/dts/Makefile           |   1 +
>>  arch/arm/boot/dts/imx6q-dms-ba16.dts | 140 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 141 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/imx6q-dms-ba16.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index ade7a38543dc..585c3da4a47a 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -435,6 +435,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>>       imx6q-dfi-fs700-m60.dtb \
>>       imx6q-display5-tianma-tm070-1280x768.dtb \
>>       imx6q-dmo-edmqmx6.dtb \
>> +     imx6q-dms-ba16.dtb \
>>       imx6q-evi.dtb \
>>       imx6q-gk802.dtb \
>>       imx6q-gw51xx.dtb \
>> diff --git a/arch/arm/boot/dts/imx6q-dms-ba16.dts b/arch/arm/boot/dts/imx6q-dms-ba16.dts
>> new file mode 100644
>> index 000000000000..b5047fd88290
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6q-dms-ba16.dts
>> @@ -0,0 +1,140 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "imx6q-ba16.dtsi"
>> +
>> +/ {
>> +     model = "Advantech DMS-BA16";
>> +     compatible = "advantech,imx6q-dms-ba16", "advantech,imx6q-ba16", "fsl,imx6q";
>> +
>> +     reg_usb_otg_vbus: regulator-usbotgvbus {
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "usb_otg_vbus";
>> +             regulator-min-microvolt = <5000000>;
>> +             regulator-max-microvolt = <5000000>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&pinctrl_usbotgvbus>;
>> +             gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
>> +             enable-active-high;
>> +     };
>> +
>> +     sys_mclk: clock-sys-mclk {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <22000000>;
>> +     };
>> +
>> +     sound {
>> +             compatible = "fsl,imx6q-ba16-sgtl5000",
>> +                          "fsl,imx-audio-sgtl5000";
>> +             model = "imx6q-ba16-sgtl5000";
>> +             ssi-controller = <&ssi1>;
>> +             audio-codec = <&sgtl5000>;
>> +             audio-routing =
>> +                     "MIC_IN", "Mic Jack",
>> +                     "Mic Jack", "Mic Bias",
>> +                     "Headphone Jack", "HP_OUT";
>> +             mux-int-port = <1>;
>> +             mux-ext-port = <4>;
>> +     };
>> +};
>> +
>> +&ecspi5 {
>> +     cs-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_ecspi5>;
>> +     status = "okay";
>> +
>> +     m25_eeprom: m25p80@0 {
>> +             compatible = "atmel,at25256B", "atmel,at25";
>> +             spi-max-frequency = <20000000>;
>> +             size = <0x8000>;
>> +             pagesize = <64>;
>> +             reg = <0>;
>> +             address-width = <16>;
>> +     };
>> +};
>> +
>> +&iomuxc {
>> +
>
> Unnecessary newline.
>


Thanks. Will fix this in the v4.

>> +     pinctrl_usbotgvbus: usbotgvbusgrp {
>
> Please keep the pinctrl entries under iomuxc node alphabetically sorted.
>

Thanks. Will fix this in the v4.

>> +             fsl,pins = <
>> +                     MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x000b0
>> +                     MX6QDL_PAD_GPIO_1__USB_OTG_ID   0x17059
>
> MX6QDL_PAD_GPIO_1__USB_OTG_ID shouldn't belong to this group but
> pinctrl_usbotg.  However that has been defined in imx6q-ba16.dtsi using
> another USB_OTG_ID pinmux.  Confusing.
>
> Shawn

Will correct the USB_OTG_ID pinmux setting in the v4.
Do you mind if I redefine reg_usb_otg_vbus node since we just started
using OTG host/device mode on this board ?

>
>> +             >;
>> +     };
>> +
>> +     pinctrl_i2c1_gpio: i2c1gpiogrp {
>> +             fsl,pins = <
>> +                     MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26        0x1b0b0
>> +                     MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27        0x1b0b0
>> +             >;
>> +     };
>> +
>> +     pinctrl_i2c2_gpio: i2c2gpiogrp {
>> +             fsl,pins = <
>> +                     MX6QDL_PAD_KEY_COL3__GPIO4_IO12 0x1b0b0
>> +                     MX6QDL_PAD_KEY_ROW3__GPIO4_IO13 0x1b0b0
>> +             >;
>> +     };
>> +
>> +     pinctrl_i2c3_gpio: i2c3gpiogrp {
>> +             fsl,pins = <
>> +                     MX6QDL_PAD_GPIO_3__GPIO1_IO03   0x1b0b0
>> +                     MX6QDL_PAD_GPIO_6__GPIO1_IO06   0x1b0b0
>> +             >;
>> +     };
>> +};
>> +
>> +&i2c1 {
>> +     clock-frequency = <100000>;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_i2c1>;
>> +     status = "okay";
>> +
>> +     sgtl5000: codec@a {
>> +             compatible = "fsl,sgtl5000";
>> +             reg = <0x0a>;
>> +             clocks = <&sys_mclk>;
>> +             lrclk-strength = <0x3>;
>> +             VDDA-supply = <&reg_1p8v>;
>> +             VDDIO-supply = <&reg_3p3v>;
>> +     };
>> +};
>> +
>> +&pwm2 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_pwm2>;
>> +     status = "okay";
>> +};
>> +
>> +&sata {
>> +     fsl,no-spread-spectrum;
>> +     fsl,transmit-atten-16ths = <12>;
>> +     fsl,transmit-boost-mdB = <3330>;
>> +     fsl,transmit-level-mV = <1133>;
>> +     fsl,receive-dpll-mode = <1>;
>> +     status = "okay";
>> +};
>> +
>> +&usbotg {
>> +     vbus-supply = <&reg_usb_otg_vbus>;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_usbotg>;
>> +     dr_mode = "otg";
>> +     disable-over-current;
>> +     status = "okay";
>> +};
>> +
>> +&usdhc4 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_usdhc4>;
>> +     bus-width = <8>;
>> +     cd-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
>> +     no-1-8-v;
>> +     keep-power-in-suspend;
>> +     wakeup-source;
>> +     status = "okay";
>> +};
>> --
>> 2.11.0
>>
