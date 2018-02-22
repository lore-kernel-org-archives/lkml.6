Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeBVVid convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:38:33 -0500
Received: from mout.perfora.net ([74.208.4.196]:42837 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751330AbeBVVib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:38:31 -0500
Date: Thu, 22 Feb 2018 22:37:48 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <278c02d3-7fc2-a92e-b309-1da8116e7c41@gmail.com>
References: <20180222143825.1517-1-marcel@ziswiler.com> <278c02d3-7fc2-a92e-b309-1da8116e7c41@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2] ARM: tegra: fix ulpi regression on tegra20
To: Dmitry Osipenko <digetx@gmail.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>
From: Marcel Ziswiler <marcel@ziswiler.com>
Message-ID: <23F053F8-8CE2-49A0-ADE6-1AC720953849@ziswiler.com>
X-Provags-ID: V03:K0:wlFH8lmSf8ipTTmMH6QQqmUZt0oooqVOCAifd8Ob0HR/4+Yl8vI
 hlPXWMf+7xaGesFqhFrn7yDvhsjHjiu4K1fHoVHZSUBFz4iU32ccrSgGXWwhugK7SlzIxd6
 3OWTnhO7aibBiVgKmEBXvb8ckglE6ljg9nSCGD1u5mSW3pp/FXaOf15xxIfCmls2fX/Iic8
 0VFWDP4yWlBDMoeTK+p8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U6b+z1CoZ/4=:1bAUB8qU0XmJ/IkhQOYP/U
 nS3Sl6FhiGQags1/0meuVMGDrjsgXwf4FImbxbkvNCPyW2wq9TVL5Ai6IgjSnMNbjB5/q6Yf+
 sESYTAYRc8PU7KPEze5nAQMoC2Udvls1elbrMXXzqgjnXbC9cKBu7XvRjAXceIyptMQ9Ek86N
 rCSLEeqoKO0kNqWmuTmvvpxTPpzZKuBtu4PbYr3IOdcu6GY6c5G8TlJO7s0DkanolyVoDXX1Z
 /suCRoC9EH9cU/pYodDVEXmIdOegPTfqdKDBNf4k7d/tr0JjBzlN5bKaGlvkpJdKSxkZrI18v
 zJUZLGXzQVeC+zgo+4wAobMFlIIcGBtBUYH2ql288JQkuGcoTcR5kiQ77bd7D6tVa3G5/ETFN
 /eJGMfCoDB5nLS6k6+atlqj0zcMOpCea1hdM6vjoJYWhGJp4ZstEXfKBf2mKzv0JYdbtpb0G6
 WVAhigNMoilGI4DNDTs3slHPznYxAnpTGlFDD2Bn1YkNhm20+81iA4JGncL6XyChCEKVQAuB5
 F99kJsLbTfP9ZRSTsq012uonyLFLTIhmFWJk4JnHMw/Ycm/veyWSCMxESlFZ8ldaOGfA3u59P
 vmIZMEtjnmuwjuHpvyI7eDMzTdifrjEYf2GKnZHtJFBgdEOKV5JpTKLWMb7lYxDDstaTomHtP
 mi/dOcCU4MKBZsVGBqv11U3YQ31+l8jNZfFSD2xcbp9dCUyaCbEHpMHxKgjDJh2o09JW5Av9y
 2ghhgCiydKgr9Btt8cyJFV4hhf0U2XoqLeyYYrxrxsBwO4ISPULTz7C4xIM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 22, 2018 9:08:44 PM GMT+01:00, Dmitry Osipenko <digetx@gmail.com> wrote:
>On 22.02.2018 17:38, Marcel Ziswiler wrote:
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> 
>> Since commit f8f8f1d04494 ("clk: Don't touch hardware when
>reparenting
>> during registration") ULPI has been broken on Tegra20 leading to the
>> following error message during boot:
>> 
>> [    1.974698] ulpi_phy_power_on: ulpi write failed
>> [    1.979384] tegra-ehci c5004000.usb: Failed to power on the phy
>> [    1.985434] tegra-ehci: probe of c5004000.usb failed with error
>-110
>> 
>> Debugging through the changes and finally also consulting the TRM
>> revealed that rather than the CDEV2 clock off OSC requiring such pin
>> muxing actually the PLL_P_OUT4 clock is in use. It looks like so far
>it
>> just worked by chance of that one having been enabled which Stephen's
>> commit now changed when reparenting sclk away from pll_p_out4 leaving
>> that one disabled. Fix this by properly assigning the PLL_P_OUT4
>clock
>> as the ULPI PHY clock.
>> 
>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
>Indeed CDEV2 clock doesn't exist on Tegra, but there is a CDEV2 pinmux
>pad
>group. Looks like another clk-related relic from downstream driver that
>was
>borrowed to upstream and stayed unnoticed for a long time.
>
>I think in practice all T20 boards have CDEV2 configured to PLL_P_OUT4,

Exactly.

>so this
>patch is correct to me. Probably it would also worth to set CDEV2
>parent to
>PLL_P_OUT4 in the clk driver for DT backwards compatibility

I guess that might work but what the original designer(s) probably meant by that strange otherwise nonexistent cdev2 clock might be the other configuration of that pad group called OSC which would allow outputting the base Oscillator frequency even with a separate divider allowing by 2, 4 or even 8 as far as I remember from glancing at the TRM. However like you correctly noted no design ever made use of any such as far as I can tell.

> or even
>make clk
>driver to read the CDEV2 pinmux config and set the proper parent based
>on it.

Sounds a little too fancy to me but might work if device tree backwards compatibility is required at utmost importance.

>CC'ed Peter.
>
>Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

Thanks Dmitry.

>> ---
>> 
>> Changes in v2:
>> - Updated device tree binding documentation as well.
>> - CCing Dmitry as well.
>> 
>>  Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt | 4
>+++-
>>  arch/arm/boot/dts/tegra20.dtsi                                   | 2
>+-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git
>a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
>b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
>> index a9aa79fb90ed..1aa6f2674af5 100644
>> ---
>a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
>> +++
>b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
>> @@ -21,7 +21,9 @@ Required properties :
>>     - timer: The timeout clock (clk_m). Present if phy_type == utmi.
>>     - utmi-pads: The clock needed to access the UTMI pad control
>registers.
>>       Present if phy_type == utmi.
>> -   - ulpi-link: The clock Tegra provides to the ULPI PHY (cdev2).
>> +   - ulpi-link: The clock Tegra provides to the ULPI PHY (usually
>pad DAP_MCLK2
>> +     with pad group aka "nvidia,pins" cdev2 and pin mux option
>config aka
>> +     "nvidia,function" pllp_out4).
>>       Present if phy_type == ulpi, and ULPI link mode is in use.
>>   - resets : Must contain an entry for each entry in reset-names.
>>     See ../reset/reset.txt for details.
>> diff --git a/arch/arm/boot/dts/tegra20.dtsi
>b/arch/arm/boot/dts/tegra20.dtsi
>> index 864a95872b8d..e05b6bb2599f 100644
>> --- a/arch/arm/boot/dts/tegra20.dtsi
>> +++ b/arch/arm/boot/dts/tegra20.dtsi
>> @@ -741,7 +741,7 @@
>>  		phy_type = "ulpi";
>>  		clocks = <&tegra_car TEGRA20_CLK_USB2>,
>>  			 <&tegra_car TEGRA20_CLK_PLL_U>,
>> -			 <&tegra_car TEGRA20_CLK_CDEV2>;
>> +			 <&tegra_car TEGRA20_CLK_PLL_P_OUT4>;
>>  		clock-names = "reg", "pll_u", "ulpi-link";
>>  		resets = <&tegra_car 58>, <&tegra_car 22>;
>>  		reset-names = "usb", "utmi-pads";
