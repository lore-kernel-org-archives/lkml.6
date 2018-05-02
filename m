Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeEBQlk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:41:40 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:57704 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeEBQli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:41:38 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.899
Subject: Re: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
 <20180322180508.my64gobhh5rc2x2m@flea>
 <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
 <20180424084137.7xfwji2gcibxavvt@flea>
 <03a02abb-e95c-b4ec-748f-907c0af67969@micronovasrl.com>
 <20180425184016.xktppxw7egddr7li@flea>
 <42feccc9-1d09-9ff2-3ccc-1dea63bacfb6@micronovasrl.com>
Message-ID: <839d2560-0250-9b3a-8019-4e83d9e931e2@micronovasrl.com>
Date: Wed, 2 May 2018 18:41:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <42feccc9-1d09-9ff2-3ccc-1dea63bacfb6@micronovasrl.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

>> You don't have to handcode the fragments anymore with the new syntax,
>> and U-Boot makes it really trivial to use if you use the FIT image
>> format to have multiple overlays bundled in the same image. You can
>> choose to apply them dynamically, for example based on an EEPROM or
>> some other metric to see which combination you have.
> 
> Ah, this is interesting. I'm going to experiment with that.
> 

I'm struggling against this, I don't really know how to proceed,
except keeping monolithic dts files including other dtsi files.

About dt-overlays I've tried to look around lot of time,
but the only thing I've found is this:
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tree/arch/arm/boot/dts?h=topic/renesas-overlays

where they use .dtso tagging them as "/plugin/;"
and compile all .dtso found in dts folder.
Then they obtain .dtbo files that should be the dt-overlays we have 
spoken about right?

What I can't understand is if there's a real standard at this time to 
follow, because on renesas-driver they use their way to handle all .dtso 
files, but on mainline there seems to be nothing about that.

So at the moment I'm trying to compile dts tagged as /plugin/;
but dtc gives me a lot of warnings.

dts:
"
/dts-v1/;
/plugin/;

#include <dt-bindings/gpio/gpio.h>
#include <dt-bindings/interrupt-controller/irq.h>

&i2c2 {
	pinctrl-names = "default";
	pinctrl-0 = <&i2c2_pins_a>;
	status = "okay";

	ft5x {
		compatible = "edt,edt-ft5306";
		reg = <0x38>;
		interrupt-parent = <&pio>;
		interrupts = <7 2 IRQ_TYPE_EDGE_FALLING>; /* PH2 */
		reset-gpios = <&pio 7 3 GPIO_ACTIVE_LOW>; /* PH3 */
		touchscreen-size-x = <480>;
		touchscreen-size-y = <272>;
	};
};
"

Build output issuing make ARCH=arm CROSS_COMPILE=arm-linux- aaa.dtb (I 
use aaa.dts as source):
"
arch/arm/boot/dts/aaa.dtb: Warning (reg_format): 
/fragment@0/__overlay__/ft5x:reg: property has invalid length (4 bytes) 
(#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aaa.dtb: Warning (pci_device_bus_num): Failed 
prerequisite 'reg_format'
arch/arm/boot/dts/aaa.dtb: Warning (simple_bus_reg): Failed prerequisite 
'reg_format'
arch/arm/boot/dts/aaa.dtb: Warning (avoid_default_addr_size): 
/fragment@0/__overlay__/ft5x: Relying on default #address-cells value
arch/arm/boot/dts/aaa.dtb: Warning (avoid_default_addr_size): 
/fragment@0/__overlay__/ft5x: Relying on default #size-cells value
"

Then in uboot I'm trying to do as follows:
# fdt addr 0x43000000 (where dtb is)
# fdt resize 8192
# fdt apply 0x430c0000 (where dtbo is)
But it gives me "libfdt fdt_check_header(): FDT_ERR_BADMAGIC"
(I was expecting some error)

Is there anywhere a guide for this?
Is this what you've meant before?
Using FIT for my use is not the best, so I would like to have many 
overlays in /boot folder and use different boot.scr depending on hardware.

Can you point me to somewhere or something?
I don't really know where to beat my head!

Thanks in advance.

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
