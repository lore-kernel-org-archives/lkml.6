Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759479AbeD1Bzs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 21:55:48 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:6241 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759307AbeD1Bzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 21:55:47 -0400
Subject: Re: [PATCH] ARM64: dts: meson-axg: enable AP6255 wifi module
To: Kevin Hilman <khilman@baylibre.com>
References: <20180423145729.14368-1-yixun.lan@amlogic.com>
 <7h7eos1n68.fsf@baylibre.com>
CC: <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <30de15b8-4cc4-7f97-d134-7af75cb6ace1@amlogic.com>
Date: Sat, 28 Apr 2018 09:56:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <7h7eos1n68.fsf@baylibre.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/18 03:09, Kevin Hilman wrote:
> Yixun Lan <yixun.lan@amlogic.com> writes:
> 
>> The Meson-AXG S400 board is shipped with AP6255 wifi module,
>> which is actually using the brcmfmac 43455 driver.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 44 ++++++++++++++++++-
>>  1 file changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> index f67d4e47e641..b3e1bdca32bb 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> @@ -51,7 +51,16 @@
>>  
>>  	sdio_pwrseq: sdio-pwrseq {
>>  		compatible = "mmc-pwrseq-simple";
>> -		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
>> +		reset-gpios = <&gpio GPIOX_7 GPIO_ACTIVE_LOW>;
> 
> You didn't mention this GPIO change in the changelog.  Is it
> intentional?

Yes, the 'sdio_pwrseq' is used by wifi driver till now
previous the reset-gpio is wrongly configured (copy & paste error),
according to the schematics, it's GPIOX_7 which need to be fixed here.

to be clean, in s400 board
 GPIOX_6 is WIFI_WAKE_HOST pin
 GPIOX_7 is WIFI_PWREN pin

do you want me to put a note into the commit message? and resend this patch?

Thanks


> 
>> +		clocks = <&wifi32k>;
>> +		clock-names = "ext_clock";
>> +	};
>> +
>> +	wifi32k: wifi32k {
>> +		compatible = "pwm-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <32768>;
>> +		pwms = <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
>>  	};
>>  };
>>  
>> @@ -86,6 +95,12 @@
>>  	pinctrl-names = "default";
>>  };
>>  
>> +&pwm_ab {
>> +	status = "okay";
>> +	pinctrl-0 = <&pwm_a_x20_pins>;
>> +	pinctrl-names = "default";
>> +};
>> +
>>  /* emmc storage */
>>  &sd_emmc_c {
>>  	status = "okay";
>> @@ -105,3 +120,30 @@
>>  	vmmc-supply = <&vcc_3v3>;
>>  	vqmmc-supply = <&vddio_boot>;
>>  };
>> +
>> +/* wifi module */
>> +&sd_emmc_b {
>> +	status = "okay";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	pinctrl-0 = <&sdio_pins>;
>> +	pinctrl-1 = <&sdio_clk_gate_pins>;
>> +	pinctrl-names = "default", "clk-gate";
>> +
>> +	bus-width = <4>;
>> +	cap-sd-highspeed;
>> +	max-frequency = <100000000>;
>> +	non-removable;
>> +	disable-wp;
>> +
>> +	mmc-pwrseq = <&sdio_pwrseq>;
>> +
>> +	vmmc-supply = <&vddao_3v3>;
>> +	vqmmc-supply = <&vddio_boot>;
>> +
>> +	brcmf: wifi@1 {
>> +		reg = <1>;
>> +		compatible = "brcm,bcm4329-fmac";
>> +	};
>> +};
> 
> .
> 
