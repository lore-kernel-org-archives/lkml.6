Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeBFJKv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:10:51 -0500
Received: from hermes.aosc.io ([199.195.250.187]:56067 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751924AbeBFJKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:10:42 -0500
Date: Tue, 06 Feb 2018 17:10:26 +0800
In-Reply-To: <20180206090656.r52hs7sk7w5iynrk@flea>
References: <20180206044905.30508-1-icenowy@aosc.io> <20180206044905.30508-6-icenowy@aosc.io> <20180206090656.r52hs7sk7w5iynrk@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 05/10] ARM: sun8i: h3: add operating-points-v2 table for CPU
To: Maxime Ripard <maxime.ripard@bootlin.com>
CC: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <D4A773D5-E57C-4767-9D3C-0D386BF76DED@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年2月6日 GMT+08:00 下午5:06:56, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Tue, Feb 06, 2018 at 12:49:00PM +0800, Icenowy Zheng wrote:
>> The CPU on Allwinner H3 can do dynamic frequency scaling.
>> 
>> Add a DVFS table based on the one shipped with Allwinner's H3 SDK.
>The
>> voltage-frequency relationship seems to be conservative, and Armbian
>has
>> another DVFS table which uses lower voltage at a certain frequency.
>> However, the official one is chosen for safety.
>> 
>> Frequencies higher than 1008MHz are temporarily dropped in the table,
>as
>> they may lead to over voltage on boards without proper regulator
>> settings or over temperature on boards with proper regulator
>settings.
>> They will be added back once regulator settings are ready and thermal
>> sensor driver is merged.
>> 
>> In order to satisfy all different regulators (SY8106A which is 50mV
>per
>> level, SY8113B which have two states: 1.1V and 1.3V, and some board
>with
>> non-tweakable regulators), all the OPPs are defined with a range
>which has
>> the target value as the minimum allowed value, and 1.3V (the highest
>> VDD-CPUX voltage suggested by the datasheet) as the maximum allowed
>value.
>> It's proven to work well with a board with SY8113B.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes in v2:
>> - Switch to BSP OPP table, which is more conservative.
>> 
>>  arch/arm/boot/dts/sun8i-h3.dtsi | 32
>+++++++++++++++++++++++++++++++-
>>  1 file changed, 31 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
>b/arch/arm/boot/dts/sun8i-h3.dtsi
>> index 8495deecedad..36608c03f02b 100644
>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> @@ -43,32 +43,62 @@
>>  #include "sunxi-h3-h5.dtsi"
>>  
>>  / {
>> +	cpu0_opp_table: opp_table0 {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp@648000000 {
>> +			opp-hz = /bits/ 64 <648000000>;
>> +			opp-microvolt = <1040000 1040000 1300000>;
>> +			clock-latency-ns = <244144>; /* 8 32k periods */
>> +		};
>> +
>> +		opp@816000000 {
>> +			opp-hz = /bits/ 64 <816000000>;
>> +			opp-microvolt = <1100000 1100000 1300000>;
>> +			clock-latency-ns = <244144>; /* 8 32k periods */
>> +		};
>> +
>> +		opp@1008000000 {
>> +			opp-hz = /bits/ 64 <1008000000>;
>> +			opp-microvolt = <1200000 1200000 1300000>;
>> +			clock-latency-ns = <244144>; /* 8 32k periods */
>> +		};
>> +	};
>> +
>>  	cpus {
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>>  
>> -		cpu@0 {
>> +		cpu0: cpu@0 {
>>  			compatible = "arm,cortex-a7";
>>  			device_type = "cpu";
>>  			reg = <0>;
>> +			clocks = <&ccu CLK_CPUX>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +			#cooling-cells = <0x2>;
>
>So, that would be 2?

Okay.

>
>There's this pattern on pretty much all the other patches following
>this one as well, you should address them too.
>
>Maxime
