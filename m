Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeCUF00 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 01:26:26 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40559 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeCUF0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 01:26:23 -0400
X-Google-Smtp-Source: AG47ELsnKKBsE7MYLEGhE5oKrhwHlsinjnZ1ELMfLbUpCnU5RsIr0/3XQTSwVIgyGrX3CMGV3InH4g==
Subject: Re: [PATCH] ARM: dts: db600c: add support to pcie refclk
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180320092840.4600-1-srinivas.kandagatla@linaro.org>
 <20180321033518.GB1403@tuxbook-pro>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <831e8c3b-06e1-8653-df0b-2c1de05834be@linaro.org>
Date: Wed, 21 Mar 2018 13:26:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180321033518.GB1403@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn for the review comments,

On 21/03/18 11:35, Bjorn Andersson wrote:
> On Tue 20 Mar 17:28 HKT 2018, Srinivas Kandagatla wrote:
> 
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to external pcie refclk.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm/boot/dts/qcom-apq8064-db600c.dts | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-db600c.dts
>> index 50151ef6e912..7587088c122f 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064-db600c.dts
>> +++ b/arch/arm/boot/dts/qcom-apq8064-db600c.dts
>> @@ -45,6 +45,18 @@
>>   
>>   	};
>>   
>> +	clocks {
>> +		compatible = "simple-bus";
>> +		pcie_refclk: pcie-refclk {
> 
> As the si53154 is used to acquire 3 different clocks (2 pcie and 1 sata)
> it would be nice to accurately represent this in the DT. That said,
> exposing this as a clock allow us to change the representation here
> later. (Both pcie_core_clk and pcie_eth_clk use the same gpio pin as
> enable pin, so I don't know how to represent this...)
> 
This is a refclk, which should be always same for both PCIe Controllers 
and connected PCIe endpoints.

For sata we should have one more refclk entry of its own.

> So for now, please name this "pcie_core_clk", per the schematics.

This is pcie refclk, if you follow the line in the schematics should see 
that it terminates to pcie refclk.

> 
>> +			pinctrl-0 = <&pcie_pins>;
>> +			pinctrl-names = "default";
>> +			compatible = "gpio-gate-clock";
>> +	                clocks = <&rpmcc 27>;
>> +			#clock-cells = <0>;
>> +			enable-gpios = <&pm8921_gpio 22 GPIO_ACTIVE_HIGH>;
>> +		};
>> +	};
>> +
>>   	hdmi-out {
>>   		compatible = "hdmi-connector";
>>   		type = "a";
>> @@ -140,6 +152,16 @@
>>   
>>   		qcom,ssbi@500000 {
>>   			pmic@0 {
>> +				gpio@150 {
>> +					pcie_pins: pcie_pins {
> 
> Please label this "pcie_clk_en_pin" and don't use '_' in the name of the
> node.
> 
I agree, Will fix it.
>> +						pios {
> 
> You can omit this level and just put the properties in directly in the
> pcie-clk-en node.
Okay.

thanks,
srini
> 
>> +							pins = "gpio22";
>> +							function = "normal";
>> +							power-source = <PM8921_GPIO_VPH>;
>> +						};
>> +					};
>> +				};
>> +
> 
> Regards,
> Bjorn
> 
