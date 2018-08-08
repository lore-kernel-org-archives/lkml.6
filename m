Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1B3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5782821785
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5782821785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbeHHT6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:58:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43398 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeHHT6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:58:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44DF018A;
        Wed,  8 Aug 2018 10:38:09 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 912473F2EA;
        Wed,  8 Aug 2018 10:38:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: stratix10: Add Stratix10 SMMU support
To:     thor.thayer@linux.intel.com, joro@8bytes.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, will.deacon@arm.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1532543077-8933-1-git-send-email-thor.thayer@linux.intel.com>
 <1532543077-8933-2-git-send-email-thor.thayer@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <db4d8290-c015-aa8b-6058-11fd3d25464b@arm.com>
Date:   Wed, 8 Aug 2018 18:38:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532543077-8933-2-git-send-email-thor.thayer@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/18 19:24, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add SMMU support to the Stratix10 Device Tree which
> includes adding the SMMU node and adding IOMMU stream
> ids to the SMMU peripherals. Update bindings.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> This patch is dependent on the patch series
> "iommu/arm-smmu: Add runtime pm/sleep support"
> (https://patchwork.ozlabs.org/cover/946160/)
> ---
>   .../devicetree/bindings/iommu/arm,smmu.txt         | 25 ++++++++++++++++++
>   arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 30 ++++++++++++++++++++++
>   2 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 7c71a6ed465a..8e3fe0594e3e 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -18,6 +18,7 @@ conditions.
>                           "arm,mmu-500"
>                           "cavium,smmu-v2"
>                           "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
> +                        "altr,smmu-v2"

Can we guarantee that no Altera SoC will ever exist with a different 
SMMU implementation, configuration, or clock tree? If we must have 
compatibles for SoC-specific integrations, I'd be a lot happier if they 
were actually SoC-specific, i.e. at least "altr,stratix10-smmu", or even 
something like "altr,gx5500-smmu" if there's a chance of new 
incompatible designs being added to the Stratix 10 family in future.

I'm still dubious that we actually need this for MMU-500, though, since 
we will always need the TCU clock enabled to do anything, and given the 
difficulty in associating particular TBU clocks with whichever domains 
might cause allocations into which TBU's TLBs, it seems highly unlikely 
that it'll ever be feasible to work at a granularity finer than "all of 
the clocks". And at that point the names don't really matter, and we 
merely need something like the proposed of_clk_bulk_get()[1], which 
works fine regardless of how many TBUs and distinct clocks exist for a 
particular MMU-500 configuration and integration.

>   
>                     depending on the particular implementation and/or the
>                     version of the architecture implemented.
> @@ -179,3 +180,27 @@ conditions.
>   			 <&mmcc SMMU_MDP_AHB_CLK>;
>   		clock-names = "bus", "iface";
>   	};
> +
> +	/* Stratix10 arm,smmu-v2 implementation */
> +	smmu5: iommu@fa000000 {
> +		compatible = "altr,smmu-v2", "arm,mmu-500",
> +			     "arm,smmu-v2";
> +		reg = <0xfa000000 0x40000>;
> +		#global-interrupts = <2>;
> +		#iommu-cells = <1>;
> +		clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
> +		clock-names = "masters";

This isn't documented as an actual property, and if it also clocks the 
TCU then I'm not sure it's really the most accurate name.

Robin.

[1] https://patchwork.kernel.org/patch/10427095/

> +		interrupt-parent = <&intc>;
> +		interrupts = <0 128 4>,	/* Global Secure Fault */
> +			<0 129 4>, /* Global Non-secure Fault */
> +			/* Non-secure Context Interrupts (32) */
> +			<0 138 4>, <0 139 4>, <0 140 4>, <0 141 4>,
> +			<0 142 4>, <0 143 4>, <0 144 4>, <0 145 4>,
> +			<0 146 4>, <0 147 4>, <0 148 4>, <0 149 4>,
> +			<0 150 4>, <0 151 4>, <0 152 4>, <0 153 4>,
> +			<0 154 4>, <0 155 4>, <0 156 4>, <0 157 4>,
> +			<0 158 4>, <0 159 4>, <0 160 4>, <0 161 4>,
> +			<0 162 4>, <0 163 4>, <0 164 4>, <0 165 4>,
> +			<0 166 4>, <0 167 4>, <0 168 4>, <0 169 4>;
> +		stream-match-mask = <0x7ff0>;
> +	};
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index d033da401c26..e38ca86d48f6 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -137,6 +137,7 @@
>   			reset-names = "stmmaceth", "stmmaceth-ocp";
>   			clocks = <&clkmgr STRATIX10_EMAC0_CLK>;
>   			clock-names = "stmmaceth";
> +			iommus = <&smmu 1>;
>   			status = "disabled";
>   		};
>   
> @@ -150,6 +151,7 @@
>   			reset-names = "stmmaceth", "stmmaceth-ocp";
>   			clocks = <&clkmgr STRATIX10_EMAC1_CLK>;
>   			clock-names = "stmmaceth";
> +			iommus = <&smmu 2>;
>   			status = "disabled";
>   		};
>   
> @@ -163,6 +165,7 @@
>   			reset-names = "stmmaceth", "stmmaceth-ocp";
>   			clocks = <&clkmgr STRATIX10_EMAC2_CLK>;
>   			clock-names = "stmmaceth";
> +			iommus = <&smmu 3>;
>   			status = "disabled";
>   		};
>   
> @@ -273,6 +276,7 @@
>   			clocks = <&clkmgr STRATIX10_L4_MP_CLK>,
>   				 <&clkmgr STRATIX10_SDMMC_CLK>;
>   			clock-names = "biu", "ciu";
> +			iommus = <&smmu 5>;
>   			status = "disabled";
>   		};
>   
> @@ -307,6 +311,30 @@
>   			altr,modrst-offset = <0x20>;
>   		};
>   
> +		smmu: iommu@fa000000 {
> +			compatible = "altr,smmu-v2", "arm,mmu-500",
> +				     "arm,smmu-v2";
> +			reg = <0xfa000000 0x40000>;
> +			#global-interrupts = <2>;
> +			#iommu-cells = <1>;
> +			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
> +			clock-names = "masters";
> +			interrupt-parent = <&intc>;
> +			interrupts = <0 128 4>,	/* Global Secure Fault */
> +				<0 129 4>, /* Global Non-secure Fault */
> +				/* Non-secure Context Interrupts (32) */
> +				<0 138 4>, <0 139 4>, <0 140 4>, <0 141 4>,
> +				<0 142 4>, <0 143 4>, <0 144 4>, <0 145 4>,
> +				<0 146 4>, <0 147 4>, <0 148 4>, <0 149 4>,
> +				<0 150 4>, <0 151 4>, <0 152 4>, <0 153 4>,
> +				<0 154 4>, <0 155 4>, <0 156 4>, <0 157 4>,
> +				<0 158 4>, <0 159 4>, <0 160 4>, <0 161 4>,
> +				<0 162 4>, <0 163 4>, <0 164 4>, <0 165 4>,
> +				<0 166 4>, <0 167 4>, <0 168 4>, <0 169 4>;
> +			stream-match-mask = <0x7ff0>;
> +			status = "disabled";
> +		};
> +
>   		spi0: spi@ffda4000 {
>   			compatible = "snps,dw-apb-ssi";
>   			#address-cells = <1>;
> @@ -416,6 +444,7 @@
>   			resets = <&rst USB0_RESET>, <&rst USB0_OCP_RESET>;
>   			reset-names = "dwc2", "dwc2-ecc";
>   			clocks = <&clkmgr STRATIX10_USB_CLK>;
> +			iommus = <&smmu 6>;
>   			status = "disabled";
>   		};
>   
> @@ -428,6 +457,7 @@
>   			resets = <&rst USB1_RESET>, <&rst USB1_OCP_RESET>;
>   			reset-names = "dwc2", "dwc2-ecc";
>   			clocks = <&clkmgr STRATIX10_USB_CLK>;
> +			iommus = <&smmu 7>;
>   			status = "disabled";
>   		};
>   
> 
