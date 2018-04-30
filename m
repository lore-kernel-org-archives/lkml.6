Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbeD3Jry (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:47:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752269AbeD3Jrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:47:52 -0400
Subject: Re: [linux-sunxi] [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
To: Icenowy Zheng <icenowy@aosc.io>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-4-icenowy@aosc.io>
 <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com>
 <83EDF187-5EB2-4FEB-99BC-9D5B728D3A45@aosc.io>
From: Andre Przywara <andre.przywara@arm.com>
Openpgp: preference=signencrypt
Message-ID: <45956397-a593-e51e-8637-655178c5901c@arm.com>
Date: Mon, 30 Apr 2018 10:47:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <83EDF187-5EB2-4FEB-99BC-9D5B728D3A45@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On 27/04/18 08:12, Icenowy Zheng wrote:
> 
> 
> 于 2018年4月27日 GMT+08:00 上午12:46:26, Andre Przywara <andre.przywara@arm.com> 写到:
>> Hi,
>>
>> On 26/04/18 15:07, Icenowy Zheng wrote:
>>> The Pine H64 board have a MicroSD slot connected to MMC0 controller
>> of
>>> the H6 SoC and a eMMC slot connected to MMC2.
>>>
>>> Enable them in the device tree.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 32
>> ++++++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>> index d36de5eb81f3..78b1cd54687c 100644
>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>> @@ -20,6 +20,38 @@
>>>  	chosen {
>>>  		stdout-path = "serial0:115200n8";
>>>  	};
>>> +
>>> +	reg_vcc3v3: vcc3v3 {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc3v3";
>>> +		regulator-min-microvolt = <3300000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +	};
>>> +
>>> +	reg_vcc1v8: vcc1v8 {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc1v8";
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <1800000>;
>>> +	};
>>> +};
>>> +
>>> +&mmc0 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&mmc0_pins>;
>>> +	vmmc-supply = <&reg_vcc3v3>;
>>
>> So this is actually CLDO1 on the AXP, correct?
> 
> I remember it's coupled between two LDOs, to provide enough power.
> 
>>
>>
>>> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&mmc2 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&mmc2_pins>;
>>> +	vmmc-supply = <&reg_vcc3v3>;
>>> +	vqmmc-supply = <&reg_vcc1v8>;
>>
>> And this is BLDO2?
> 
> Yes.
> 
>>
>> I am just asking because I want to avoid running into the same problem
>> as with the A64 before: that future DTs become incompatible with older
>> kernels, because we change the power supply to point to the AXP
>> regulators, which this kernel does not support yet.
> 
> The answer is just not to keep this compatibility, as it's not
> supported option to update DT without updating kernel.

Well, I recognise that statement.. ;-) and I understand that it's far
easier to handle it this way. But:
- Which .dtb are we going to write into the SPI flash? An older one,
which covers all kernels, but lacks features? Or a newer one, which
limits the bootable kernels to recent versions?
- Which DT are we going to give to EFI applications?
- Which DT are the BSDs suspected to take? They don't ship their own DTs
(which is good!).

So I understand that "shipping the DT with the kernel" is the old
(embedded!) way of doing things, but I really believe we should stop
relying on this and try to come up with backwards compatible DTs, which
live in the firmware and get updated there. Because this is what the
distros seem to expect from ARM64 boards these days.

> P.S. I think the DT will update twice on the kernel side, the
> first time keep reg_vcc3v3 (as it's coupled) but use real
> regulator for reg_vcc1v8, the second time use the real
> coupled regulator for reg_vcc3v3.
> 
>>
>> It looks like there are more users of those power rails, so we could
>> keep those supplies connected to these fixed regulators here, even with
>> AXP-805 support in the kernel.
> 
> It's not a good choice.
> 
>>
>> Or we keep this back until we get proper AXP support in the kernel? I
>> guess it's quite close to the existing PMICs, so it might be more a
>> copy&paste exercise to support the AXP-805?
> 
> It's not a reason to keep it back.

So I compared the manuals of the AXP806 and the AXP805, the register
interface looks identical to me. I only have a (somewhat) Chinese
version of the AXP806 manual, so couldn't really find the difference
between the two. Do you know more about it? Is it just maybe the
packaging and the electrical properties (like max current supported)?

If the I2C register interface is really the same, we could just add the
DT nodes for the regulator and be done.

Cheers,
Andre.

> 
>>
>> But apart from this this looks correct to me.
>>
>> Cheers,
>> Andre.
>>
>>> +	non-removable;
>>> +	cap-mmc-hw-reset;
>>> +	status = "okay";
>>>  };
>>>  
>>>  &uart0 {
>>>
