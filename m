Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759314AbeD0VZ4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:25:56 -0400
Received: from foss.arm.com ([217.140.101.70]:46576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759262AbeD0VZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:25:54 -0400
Subject: Re: [linux-sunxi] [PATCH 2/3] arm64: allwinner: h6: add device tree
 nodes for MMC controllers
To: Icenowy Zheng <icenowy@aosc.io>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-3-icenowy@aosc.io>
 <9571735d-929f-a2ef-ed97-dc9193420b73@arm.com>
 <77DF7884-8DA8-4ED5-BB51-941CFDE4A123@aosc.io>
 <0ae1b6ce-c1cf-61e8-e09b-abec47b089b2@arm.com>
 <6EBD7D16-E985-4345-B2C2-D0CE7B32F8C5@aosc.io>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <8259b2d9-be02-68fb-90bb-bd0ebdee0b05@arm.com>
Date: Fri, 27 Apr 2018 22:25:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <6EBD7D16-E985-4345-B2C2-D0CE7B32F8C5@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/18 10:23, Icenowy Zheng wrote:
> 
> 
> 于 2018年4月27日 GMT+08:00 下午5:18:23, Andre Przywara <andre.przywara@arm.com> 写到:
>> Hi,
>>
>> On 27/04/18 09:36, Icenowy Zheng wrote:
>>>
>>>
>>> 于 2018年4月27日 GMT+08:00 上午12:45:38, Andre Przywara
>> <andre.przywara@arm.com> 写到:
>>>> Hi,
>>>>
>>>> On 26/04/18 15:07, Icenowy Zheng wrote:
>>>>> The Allwinner H6 SoC have 3 MMC controllers.
>>>>>
>>>>> Add device tree nodes for them.
>>>>>
>>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>>> ---
>>>>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 56
>>>> ++++++++++++++++++++++++++++
>>>>>  1 file changed, 56 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>>> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>>>> index 4debc3962830..3cbfc035c979 100644
>>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>>>> @@ -124,12 +124,68 @@
>>>>>  			interrupt-controller;
>>>>>  			#interrupt-cells = <3>;
>>>>>  
>>>>> +			mmc0_pins: mmc0-pins {
>>>>> +				pins = "PF0", "PF1", "PF2", "PF3",
>>>>> +				       "PF4", "PF5";
>>>>> +				function = "mmc0";
>>>>> +				drive-strength = <30>;
>>>>> +				bias-pull-up;
>>>>> +			};
>>>>> +
>>>>> +			mmc2_pins: mmc2-pins {
>>>>> +				pins = "PC1", "PC4", "PC5", "PC6",
>>>>> +				       "PC7", "PC8", "PC9", "PC10",
>>>>> +				       "PC11", "PC12", "PC13", "PC14";
>>>>> +				function = "mmc2";
>>>>> +				drive-strength = <30>;
>>>>> +				bias-pull-up;
>>>>> +			};
>>>>> +
>>>>>  			uart0_ph_pins: uart0-ph {
>>>>>  				pins = "PH0", "PH1";
>>>>>  				function = "uart0";
>>>>>  			};
>>>>>  		};
>>>>>  
>>>>> +		mmc0: mmc@4020000 {
>>>>> +			compatible = "allwinner,sun50i-h6-mmc";
>>>>
>>>> This should be:
>>>> 			compatible = "allwinner,sun50i-h6-mmc",
>>>> 				     "allwinner,sun50i-a64-mmc";
>>>
>>> I'm intended to not add A64 compatible, as
>>> H6 is a quite new design
>>> (new process) and there might be different behavior, even on mmc0/1.
>>
>> But as your patch proves, it is fully backwards compatible: An A64
>> driver works with this device.
> 
> No, my patch only proves "the current A64 driver works
> with this device", not "Any A64 driver works with device", as
> the current driver doesn't fully use the capability provided
> by A64 MMC cobtrollers.

Good point, but I still believe every A64 driver would be capable of
driving an H6 MMC controller, ....

>> And this is what this compatible string list says: If your system does
>> not have a specific H6 driver, you can use an A64 driver.
>> You might not get all the (potentially) new features, but it covers
>> everything the A64 has.
>>
>> And a new silicon process doesn't matter here, since the software
>> interface is unchanged. *If* we find bugs, we can add quirks matching
> 
> I think there's timing parameters for higher speed bins which
> are different among chips. As we have currently no support
> for speed bins higher than DDR50, they're not added yet.

True, but what are those differences? I compared the A64 and H6 manuals
side by side, the differences I found are:
SMHC_FIFOTH[+0x40]:
	BSIZE_OF_TRANS[30:28]:
	- H6 supports 16 transfers for SMHC0 also.
	other parameters:
	- H6 recommends better values for SMHC0 also
SMHC_CSDC[+0x54]:
	- H6 doesn't mention restriction to SMHC2
	(though this might be a mistake)
SMHC_NTSR_REG[+0x5C]:
	- H6 defines fields for bits[24:8]
SMHC_EMCE[+0x64] and SMHC_EMCE_DBG[+0x68]:
	- H6 adds, for EMCE support
EMMC_DDR_SBIT_DET_REG[0x10c]:
	- A64 doesn't mention restriction to SMHC2,
	  but I believe this is a mistake
SMHC_EMCE_BMn[0x150 + 0x4 * 0..31]
	- H6 adds, for EMCE support

All those pieces are only *additions* to the H6 over the A64, so don't
affect backwards compatibility.

>> on
>> the H6 compatible string - that's why we put it here already, despite
>> having a matching string in the kernel at the moment.
> 
> Device tree is not driver data but hardware description, so
> it should follow "how the device is formed" rather than
> "how the device works".

True, but as shown above, the compatibility is really at the device level.
Unless you have any other information ...

Cheers,
Andre.
