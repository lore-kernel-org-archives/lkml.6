Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeCPMm1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:42:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeCPMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:42:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B01E060591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v2 12/13] ARM: dts: ipq8074: Add pcie nodes
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-13-git-send-email-sricharan@codeaurora.org>
 <69ff9b14b9b2fe4d90a02ca629059af2@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <28faf397-5d28-0ec2-15b1-2a39b2eb426f@codeaurora.org>
Date: Fri, 16 Mar 2018 18:12:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <69ff9b14b9b2fe4d90a02ca629059af2@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 3/16/2018 4:50 PM, Abhishek Sahu wrote:
> On 2018-03-16 15:08, Sricharan R wrote:
>> The driver/phy support for ipq8074 is available now.
>> So enabling the nodes in DT.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 157 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 156 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> index 806fc56..7562650 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> @@ -24,7 +24,7 @@
>>          ranges = <0 0 0 0xffffffff>;
>>          compatible = "simple-bus";
>>
>> -        pinctrl@1000000 {
>> +        tlmm: pinctrl@1000000 {
>>              compatible = "qcom,ipq8074-pinctrl";
>>              reg = <0x1000000 0x300000>;
>>              interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -229,6 +229,161 @@
>>              dma-names = "tx", "rx", "cmd";
>>              status = "disabled";
>>          };
>> +
>> +        pcie_phy0: phy@86000 {
>> +            compatible = "qcom,ipq8074-qmp-pcie-phy";
>> +            reg = <0x86000 0x1000>;
>> +            #phy-cells = <0>;
>> +            clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
>> +            clock-names = "pipe_clk";
>> +            clock-output-names = "pcie20_phy0_pipe_clk";
>> +
>> +            resets = <&gcc GCC_PCIE0_PHY_BCR>,
>> +                <&gcc GCC_PCIE0PHY_PHY_BCR>;
>> +            reset-names = "phy",
>> +                      "common";
>> +            status = "disabled";
>> +        };
>> +
>> +        pcie0: pci@20000000 {
>> +            compatible = "qcom,pcie-ipq8074";
>> +            reg =  <0x20000000 0xf1d
>> +                0x20000F20 0xa8
> 
>  s/0x20000F20/0x20000f20

ok

> 
>> +                0x80000 0x2000
>> +                0x20100000 0x1000>;
>> +            reg-names = "dbi", "elbi", "parf", "config";
>> +            device_type = "pci";
>> +            linux,pci-domain = <0>;
>> +            bus-range = <0x00 0xff>;
>> +            num-lanes = <1>;
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +
>> +            phys = <&pcie_phy0>;
>> +            phy-names = "pciephy";
>> +
>> +            ranges = <0x81000000 0 0x20200000 0x20200000
>> +                  0 0x00100000   /* downstream I/O */
> 
>  we can remove trailing zeros from address.
>  s/0x00100000/0x100000
> 
>> +                  0x82000000 0 0x20300000 0x20300000
>> +                  0 0x00d00000>; /* non-prefetchable memory */
> 
>  s/0x00d00000/0xd00000
> 
>  Same changes are for PCIE1 also.

 ok

> 
>  With that.
> 
>  Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>

 Thanks.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
