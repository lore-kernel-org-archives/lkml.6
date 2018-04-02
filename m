Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbeDBGfZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:35:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbeDBGfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:35:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A420602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v5 12/13] ARM: dts: ipq8074: Add pcie nodes
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        richardcochran@gmail.com, will.deacon@arm.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        absahu@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        linux-soc@vger.kernel.org, sboyd@codeaurora.org,
        linux-arm-kernel@lists.infradead.org
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-13-git-send-email-sricharan@codeaurora.org>
 <20180327174621.GO1403@tuxbook-pro>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <a3ff1d9e-25b2-b251-4914-0caf70165085@codeaurora.org>
Date: Mon, 2 Apr 2018 12:05:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327174621.GO1403@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2018 11:16 PM, Bjorn Andersson wrote:
> On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> 
>> The driver/phy support for ipq8074 is available now.
>> So enabling the nodes in DT.
>>
> 
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 

 Thanks.

Regards,
 Sricharan



> Regards,
> Bjorn
> 
>> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 157 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 156 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> index a8dbbf0..caf3485 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> @@ -24,7 +24,7 @@
>>  		ranges = <0 0 0 0xffffffff>;
>>  		compatible = "simple-bus";
>>  
>> -		pinctrl@1000000 {
>> +		tlmm: pinctrl@1000000 {
>>  			compatible = "qcom,ipq8074-pinctrl";
>>  			reg = <0x1000000 0x300000>;
>>  			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -229,6 +229,161 @@
>>  			dma-names = "tx", "rx", "cmd";
>>  			status = "disabled";
>>  		};
>> +
>> +		pcie_phy0: phy@86000 {
>> +			compatible = "qcom,ipq8074-qmp-pcie-phy";
>> +			reg = <0x86000 0x1000>;
>> +			#phy-cells = <0>;
>> +			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
>> +			clock-names = "pipe_clk";
>> +			clock-output-names = "pcie20_phy0_pipe_clk";
>> +
>> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
>> +				<&gcc GCC_PCIE0PHY_PHY_BCR>;
>> +			reset-names = "phy",
>> +				      "common";
>> +			status = "disabled";
>> +		};
>> +
>> +		pcie0: pci@20000000 {
>> +			compatible = "qcom,pcie-ipq8074";
>> +			reg =  <0x20000000 0xf1d
>> +				0x20000f20 0xa8
>> +				0x80000 0x2000
>> +				0x20100000 0x1000>;
>> +			reg-names = "dbi", "elbi", "parf", "config";
>> +			device_type = "pci";
>> +			linux,pci-domain = <0>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes = <1>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			phys = <&pcie_phy0>;
>> +			phy-names = "pciephy";
>> +
>> +			ranges = <0x81000000 0 0x20200000 0x20200000
>> +				  0 0x100000   /* downstream I/O */
>> +				  0x82000000 0 0x20300000 0x20300000
>> +				  0 0xd00000>; /* non-prefetchable memory */
>> +
>> +			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "msi";
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 75
>> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +					<0 0 0 2 &intc 0 78
>> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +					<0 0 0 3 &intc 0 79
>> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +					<0 0 0 4 &intc 0 83
>> +					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
>> +				 <&gcc GCC_PCIE0_AXI_M_CLK>,
>> +				 <&gcc GCC_PCIE0_AXI_S_CLK>,
>> +				 <&gcc GCC_PCIE0_AHB_CLK>,
>> +				 <&gcc GCC_PCIE0_AUX_CLK>;
>> +
>> +			clock-names = "iface",
>> +				      "axi_m",
>> +				      "axi_s",
>> +				      "ahb",
>> +				      "aux";
>> +			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
>> +				 <&gcc GCC_PCIE0_SLEEP_ARES>,
>> +				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
>> +				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
>> +				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
>> +				 <&gcc GCC_PCIE0_AHB_ARES>,
>> +				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>;
>> +			reset-names = "pipe",
>> +				      "sleep",
>> +				      "sticky",
>> +				      "axi_m",
>> +				      "axi_s",
>> +				      "ahb",
>> +				      "axi_m_sticky";
>> +			status = "disabled";
>> +		};
>> +
>> +		pcie_phy1: phy@8e000 {
>> +			compatible = "qcom,ipq8074-qmp-pcie-phy";
>> +			reg = <0x8e000 0x1000>;
>> +			#phy-cells = <0>;
>> +			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
>> +			clock-names = "pipe_clk";
>> +			clock-output-names = "pcie20_phy1_pipe_clk";
>> +
>> +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
>> +				<&gcc GCC_PCIE1PHY_PHY_BCR>;
>> +			reset-names = "phy",
>> +				      "common";
>> +			status = "disabled";
>> +		};
>> +
>> +		pcie1: pci@10000000 {
>> +			compatible = "qcom,pcie-ipq8074";
>> +			reg =  <0x10000000 0xf1d
>> +				0x10000f20 0xa8
>> +				0x88000 0x2000
>> +				0x10100000 0x1000>;
>> +			reg-names = "dbi", "elbi", "parf", "config";
>> +			device_type = "pci";
>> +			linux,pci-domain = <1>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes = <1>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			phys = <&pcie_phy1>;
>> +			phy-names = "pciephy";
>> +
>> +			ranges = <0x81000000 0 0x10200000 0x10200000
>> +				  0 0x100000   /* downstream I/O */
>> +				  0x82000000 0 0x10300000 0x10300000
>> +				  0 0xd00000>; /* non-prefetchable memory */
>> +
>> +			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "msi";
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 142
>> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +					<0 0 0 2 &intc 0 143
>> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +					<0 0 0 3 &intc 0 144
>> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +					<0 0 0 4 &intc 0 145
>> +					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
>> +				 <&gcc GCC_PCIE1_AXI_M_CLK>,
>> +				 <&gcc GCC_PCIE1_AXI_S_CLK>,
>> +				 <&gcc GCC_PCIE1_AHB_CLK>,
>> +				 <&gcc GCC_PCIE1_AUX_CLK>;
>> +			clock-names = "iface",
>> +				      "axi_m",
>> +				      "axi_s",
>> +				      "ahb",
>> +				      "aux";
>> +			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
>> +				 <&gcc GCC_PCIE1_SLEEP_ARES>,
>> +				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
>> +				 <&gcc GCC_PCIE1_AHB_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>;
>> +			reset-names = "pipe",
>> +				      "sleep",
>> +				      "sticky",
>> +				      "axi_m",
>> +				      "axi_s",
>> +				      "ahb",
>> +				      "axi_m_sticky";
>> +			status = "disabled";
>> +		};
>>  	};
>>  
>>  	cpus {
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
