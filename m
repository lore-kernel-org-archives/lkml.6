Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932298AbeB1Qez (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:34:55 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34646 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932358AbeB1Qev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:34:51 -0500
X-Google-Smtp-Source: AH8x224ak3H5QirggYCXj5b3ligWvwII4nsVILQpBl99nVDtDLChUJVVuDGwJXfuQLyEEl83ELvaLl1bzwnO5DccPKk=
MIME-Version: 1.0
In-Reply-To: <20180228144424.GC12303@lunn.ch>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com> <20180228144424.GC12303@lunn.ch>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 28 Feb 2018 08:34:49 -0800
Message-ID: <CAJ+vNU3hG7z1mB0xKFZu-8o1r3hj-pOqkfVnWHvxxaxzrpGuzw@mail.gmail.com>
Subject: Re: [RFC 0/4] Add support for the Gateworks System Controller
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 6:44 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Feb 27, 2018 at 05:21:10PM -0800, Tim Harvey wrote:
>> This series adds support for the Gateworks System Controller used on Gateworks
>> Laguna, Ventana, and Newport product families.
>>
>> The GSC is an MSP430 I2C slave controller whose firmware embeds the following
>> features:
>>  - I/O expander (16 GPIO's emulating a PCA955x)
>>  - EEPROM (enumating AT24)
>>  - RTC (enumating DS1672)
>
> Hi Tim
>
> Maybe it is in these patches, and i missed it....
>
> How do these emulated devices work? Does the controller respond to
> different addresses for these different emulated devices? Or is it an
> I2c bus mux?
>

Andrew,

You didn't miss it - I probably need to explain it better.

The 'emulated devices' do respond on different slave addresses (which
match one of or the only the slave addresses those parts support). For
example the device-tree for the GW54xx has the following which are all
from the GSC which is the only thing on i2c1:

&i2c1 {
        clock-frequency = <100000>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_i2c1>;
        status = "okay";

        gsc: gsc@20 {
                compatible = "gw,gsc_v2";
                reg = <0x20>;
                interrupt-parent = <&gpio1>;
                interrupts = <4 GPIO_ACTIVE_LOW>;
                interrupt-controller;
                #interrupt-cells = <1>;

                gsc_input {
                        compatible = "gw,gsc-input";
                };

                gsc_hwmon {
                        compatible = "gw,gsc-hwmon";
                        #address-cells = <1>;
                        #size-cells = <0>;

                        hwmon@0 { /* A0: Board Temperature */
                                type = <0>;
                                reg = <0x00>;
                                label = "temp";
                                /* lookup table */
                        };

                        hwmon@1 { /* A1: Input Voltage */
                                type = <1>;
                                reg = <0x02>;
                                label = "Vin";
                                gw,voltage-divider = <22100 1000>;
                                gw,offset = <800>;
                        };

                        hwmon@2 { /* A2: 5P0 */
                                type = <1>;
                                reg = <0x0b>;
                                label = "5P0";
                                gw,voltage-divider = <22100 1000>;
                        };

                        hwmon@4 { /* A4: 0-5V input */
                                type = <1>;
                                reg = <0x14>;
                                label = "ANL0";
                                gw,voltage-divider = <10000 10000>;
                        };

                        hwmon@5 { /* A5: 2P5 PCIe/GigE */
                                type = <1>;
                                reg = <0x23>;
                                label = "2P5";
                                gw,voltage-divider = <10000 10000>;
                        };

                        hwmon@6 { /* A6: 1P8 Aud/Vid */
                                type = <1>;
                                reg = <0x1d>;
                                label = "1P8";
                        };

                        hwmon@7 { /* A7: GPS */
                                type = <1>;
                                reg = <0x26>;
                                label = "GPS";
                                gw,voltage-divider = <4990 10000>;
                        };

                        hwmon@12 { /* A12: VDD_CORE */
                                type = <1>;
                                reg = <0x3>;
                                label = "VDD_CORE";
                        };

                        hwmon@13 { /* A13: VDD_SOC */
                                type = <1>;
                                reg = <0x11>;
                                label = "VDD_SOC";
                        };

                        hwmon@14 { /* A14: 1P0 PCIe SW */
                                type = <1>;
                                reg = <0x20>;
                                label = "1P0";
                        };

                        hwmon@15 { /* fan0 */
                                type = <2>;
                                reg = <0x2c>;
                                label = "fan_50p";
                        };

                        hwmon@16 { /* fan1 */
                                type = <2>;
                                reg = <0x2e>;
                                label = "fan_60p";
                        };

                        hwmon@17 { /* fan2 */
                                type = <2>;
                                reg = <0x30>;
                                label = "fan_70p";
                        };

                        hwmon@18 { /* fan3 */
                                type = <2>;
                                reg = <0x32>;
                                label = "fan_80p";
                        };

                        hwmon@19 { /* fan4 */
                                type = <2>;
                                reg = <0x34>;
                                label = "fan_90p";
                        };

                        hwmon@20 { /* fan5 */
                                type = <2>;
                                reg = <0x36>;
                                label = "fan_100p";
                        };
                };
        };

        gsc_gpio: pca9555@23 {
                compatible = "nxp,pca9555";
                reg = <0x23>;
                gpio-controller;
                #gpio-cells = <2>;
                interrupt-parent = <&gsc>;
                interrupts = <4>;
        };

        eeprom1: eeprom@50 {
                compatible = "atmel,24c02";
                reg = <0x50>;
                pagesize = <16>;
        };

        eeprom2: eeprom@51 {
                compatible = "atmel,24c02";
                reg = <0x51>;
                pagesize = <16>;
        };

        eeprom3: eeprom@52 {
                compatible = "atmel,24c02";
                reg = <0x52>;
                pagesize = <16>;
        };

        eeprom4: eeprom@53 {
                compatible = "atmel,24c02";
                reg = <0x53>;
                pagesize = <16>;
        };

        rtc: ds1672@68 {
                compatible = "dallas,ds1672";
                reg = <0x68>;
        };
};


One issue I'm trying to figure out the best way to deal with is the
fact that the GSC can 'NAK' transactions occasionally which is why I
override the regmap read/write functions and provide retries. This
resolves the issue for the mfd core driver and sub-module drivers but
doesn't resolve the issue with these 'emulated devices' which have
their own stand-alone drivers. I'm not sure how to best deal with that
yet. I tried to add retires to the i2c adapter but that wasn't
accepted upstream because it was too generic and I was told I need to
work around it in device-drivers. I'm guessing I need to write my own
sub-module drivers that will largely duplicate whats in the
stand-alone drivers (ds1672, at24, pca9553x).

Regards,

Tim
