Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbeCPMoI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:44:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeCPMoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:44:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDE6760592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v2 11/13] ARM: dts: ipq8074: Add peripheral nodes
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-12-git-send-email-sricharan@codeaurora.org>
 <28b883a75162ccc8f3a212880a683714@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <7c452695-6647-12ea-01bb-1ec4ab2c5cb6@codeaurora.org>
Date: Fri, 16 Mar 2018 18:13:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <28b883a75162ccc8f3a212880a683714@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2018 4:17 PM, Abhishek Sahu wrote:
> On 2018-03-16 15:08, Sricharan R wrote:
>> Add serial, i2c, bam, spi, qpic peripheral nodes.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 105 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 105 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> index 2bc5dec..806fc56 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> @@ -124,6 +124,111 @@
>>              clock-names = "core", "iface";
>>              status = "disabled";
>>          };
>> +
>> +        blsp_dma: dma@7884000 {
>> +            compatible = "qcom,bam-v1.7.0";
>> +            reg = <0x07884000 0x2b000>;
> 
>  we can remove leading zero. s/0x07884000/0x7884000
> 
>> +            interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&gcc GCC_BLSP1_AHB_CLK>;
>> +            clock-names = "bam_clk";
>> +            #dma-cells = <1>;
>> +            qcom,ee = <0>;
>> +        };
>> +
>> +        serial_blsp0: serial@78af000 {
>> +            compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>> +            reg = <0x78af000 0x200>;
>> +            interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
>> +                 <&gcc GCC_BLSP1_AHB_CLK>;
>> +            clock-names = "core", "iface";
>> +            status = "disabled";
>> +        };
>> +
>> +        serial_blsp2: serial@78B1000 {
> 
>  For maintaining uniformity, we can have all address in lower case
>  s/78B1000/78b1000
> 
>> +            compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>> +            reg = <0x78B1000 0x200>;
> 
>  same thing, here also
> 
>> +            interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
>> +                <&gcc GCC_BLSP1_AHB_CLK>;
>> +            clock-names = "core", "iface";
>> +            dmas = <&blsp_dma 4>,
>> +                <&blsp_dma 5>;
>> +            dma-names = "tx", "rx";
>> +            status = "disabled";
>> +        };
>> +
>> +        spi_0: spi@78b5000 {
>> +            compatible = "qcom,spi-qup-v2.2.1";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0x78b5000 0x600>;
>> +            interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>> +            spi-max-frequency = <50000000>;
>> +            clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
>> +                <&gcc GCC_BLSP1_AHB_CLK>;
>> +            clock-names = "core", "iface";
>> +            dmas = <&blsp_dma 12>, <&blsp_dma 13>;
>> +            dma-names = "tx", "rx";
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c_0: i2c@78b6000 {
>> +            compatible = "qcom,i2c-qup-v2.2.1";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0x78b6000 0x600>;
>> +            interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&gcc GCC_BLSP1_AHB_CLK>,
>> +                <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
>> +            clock-names = "iface", "core";
>> +            clock-frequency  = <400000>;
> 
>  remove one extra space. clock-frequency = <400000>;
> 
>> +            dmas = <&blsp_dma 15>, <&blsp_dma 14>;
>> +            dma-names = "rx", "tx";
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c_1: i2c@78b7000 {
>> +            compatible = "qcom,i2c-qup-v2.2.1";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0x78b7000 0x600>;
>> +            interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&gcc GCC_BLSP1_AHB_CLK>,
>> +                <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
>> +            clock-names = "iface", "core";
>> +            clock-frequency  = <100000>;
> 
>  remove one extra space. clock-frequency = <100000>;
> 
>  with above changes.
> 
>  Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> 

 Sure, will take care of all the above. Thanks

Regards,
 Sricharan
-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
