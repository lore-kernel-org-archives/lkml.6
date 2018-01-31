Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754053AbeAaSOm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:14:42 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55437 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeAaSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:14:38 -0500
X-Google-Smtp-Source: AH8x224KJXGXXFQ/DTHkcdak7ILWW9nACDeybBby8vztV1rdGS3Fch7vP04LozpA+4s+4UQLL5t5rA==
Subject: Re: [PATCH v2 01/16] dt-bindings: update the Allwinner GPADC device
 tree binding for H3 & A83T
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
        rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
        krzk@kernel.org, icenowy@aosc.io, edu.molinas@gmail.com,
        singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-2-embed3d@gmail.com>
 <20180131174058.f7gog7yahcu67sqr@qschulz>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <4188f487-6c9d-8f1e-25cc-308650ddb9ae@gmail.com>
Date: Wed, 31 Jan 2018 19:14:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180131174058.f7gog7yahcu67sqr@qschulz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.01.2018 18:40, Quentin Schulz wrote:
> Hi Philipp,
> 
> On Mon, Jan 29, 2018 at 12:29:04AM +0100, Philipp Rossak wrote:
>> Allwinner H3 features a thermal sensor like the one in A33, but has its
>> register re-arranged, the clock divider moved to CCU (originally the
>> clock divider is in ADC) and added a pair of bus clock and reset.
>>
>> Allwinner A83T features a thermal sensor similar to the H3, the ths clock,
>> the bus clock and the reset was removed from the CCU. The THS in A83T
>> has a clock that is directly connected and runs with 24 MHz.
>>
>> Update the binding document to cover H3 and A83T.
>>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 50 ++++++++++++++++++++--
>>   1 file changed, 47 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> index 86dd8191b04c..22df0c5c23d4 100644
>> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> @@ -4,12 +4,35 @@ The Allwinner SoCs all have an ADC that can also act as a thermal sensor
>>   and sometimes as a touchscreen controller.
>>   
>>   Required properties:
>> -  - compatible: "allwinner,sun8i-a33-ths",
>> +  - compatible: must contain one of the following compatibles:
>> +		- "allwinner,sun8i-a33-ths"
>> +		- "allwinner,sun8i-h3-ths"
>> +		- "allwinner,sun8i-a83t-ths"
>>     - reg: mmio address range of the chip,
>> -  - #thermal-sensor-cells: shall be 0,
>> +  - #thermal-sensor-cells: shall be 0 or 1,
> 
> Well, thermal-sensor-cells is either 0 or 1 :)
> 
> Better to point to the documentation describing this
> thermal-sensor-cells IMHO.
> 

I agree, I will change this in the next version.

>>     - #io-channel-cells: shall be 0,
>>   
>> -Example:
>> +Required properties for the following compatibles:
>> +		- "allwinner,sun8i-h3-ths"
>> +		- "allwinner,sun8i-a83t-ths"
>> +  - interrupts: the sampling interrupt of the ADC,
>> +
>> +Required properties for the following compatibles:
>> +		- "allwinner,sun8i-h3-ths"
>> +  - clocks: the bus clock and the input clock of the ADC,
>> +  - clock-names: should be "bus" and "mod",
>> +  - resets: the bus reset of the ADC,
>> +
>> +Optional properties for the following compatibles:
>> +		- "allwinner,sun8i-h3-ths"
>> +  - nvmem-cells: A phandle to the calibration data provided by a nvmem device.
>> +		If unspecified default values shall be used. The size should
>> +		be 0x2 * sensorcount.
> 
> "twice the number of sensors" ?
> 

As already mentioned in an other answers, this here is not correct.
I got somehow a wrong information or mixed something up. For H5, H3, 
A83T and A64 the thermal sensor calibration data is always 64 bit wide 
and placed on the eFuse address  0x34 [1].

>> +  - nvmem-cell-names: Should be "calibration".
>> +
>> +Details see: bindings/nvmem/nvmem.txt
>> +
>> +Example for A33:
>>   	ths: ths@1c25000 {
>>   		compatible = "allwinner,sun8i-a33-ths";
>>   		reg = <0x01c25000 0x100>;
>> @@ -17,6 +40,27 @@ Example:
>>   		#io-channel-cells = <0>;
>>   	};
>>   
>> +Example for H3:
>> +	ths: thermal-sensor@1c25000 {
>> +		compatible = "allwinner,sun8i-h3-ths";
>> +		reg = <0x01c25000 0x400>;
>> +		clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
>> +		clock-names = "bus", "mod";
>> +		resets = <&ccu RST_BUS_THS>;
>> +		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
>> +		#thermal-sensor-cells = <0>;
>> +		#io-channel-cells = <0>;
>> +	};
>> +
>> +Example for A83T:
>> +	ths: thermal-sensor@1f04000 {
>> +		compatible = "allwinner,sun8i-a83t-ths";
>> +		reg = <0x01f04000 0x100>;
>> +		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>> +		#thermal-sensor-cells = <1>;
>> +		#io-channel-cells = <0>;
>> +	};
>> +
> 
> Aside from Maxime's comment on how we would like to refactor GPADC/THS,
> I'm not sure we really want an example for each an every thermal sensor
> supported.
> 
> Quentin
> 
I agree we don't want to have an example for every sensor, but I think 
at least those two are interesting, since one has 3 sensors and no 
clocks, and one has 1 sensor and clocks.

Thanks,
Philipp

[1]: http://linux-sunxi.org/SID_Register_Guide#eFUSE
