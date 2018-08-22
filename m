Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2699C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BBD214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BBD214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeHVSw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:52:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34578 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbeHVSw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:52:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03779ED1;
        Wed, 22 Aug 2018 08:27:09 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB7C93F2EA;
        Wed, 22 Aug 2018 08:27:05 -0700 (PDT)
Subject: Re: [PATCH v14 4/4] iommu/arm-smmu: Add support for qcom,smmu-v2
 variant
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        robdclark@gmail.com, linux-pm@vger.kernel.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org
References: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
 <20180727070224.23966-5-vivek.gautam@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <44c79159-bf14-cdf0-70ab-421b1dc3c83e@arm.com>
Date:   Wed, 22 Aug 2018 16:27:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727070224.23966-5-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/18 08:02, Vivek Gautam wrote:
> qcom,smmu-v2 is an arm,smmu-v2 implementation with specific
> clock and power requirements. This smmu core is used with
> multiple masters on msm8996, viz. mdss, video, etc.
> Add bindings for the same.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
> 
> Change since v13:
>   - No change.
> 
>   .../devicetree/bindings/iommu/arm,smmu.txt         | 42 ++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c                           | 13 +++++++
>   2 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 8a6ffce12af5..7c71a6ed465a 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -17,10 +17,19 @@ conditions.
>                           "arm,mmu-401"
>                           "arm,mmu-500"
>                           "cavium,smmu-v2"
> +                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
>   
>                     depending on the particular implementation and/or the
>                     version of the architecture implemented.
>   
> +                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
> +                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
> +                  string that should be present along with the "qcom,smmu-v2"
> +                  to facilitate SoC specific clocks/power connections and to
> +                  address specific bug fixes.

As demonstrated in the GPU thread, this proves a bit too vague for a 
useful binding. Provided Qcom folks can reach a consensus on what a 
given SoC is actually called, I'd rather just unambiguously list 
whatever sets of fully-defined strings we need.

Robin.

> +                  An example string would be -
> +                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
> +
>   - reg           : Base address and size of the SMMU.
>   
>   - #global-interrupts : The number of global interrupts exposed by the
> @@ -71,6 +80,22 @@ conditions.
>                     or using stream matching with #iommu-cells = <2>, and
>                     may be ignored if present in such cases.
>   
> +- clock-names:    List of the names of clocks input to the device. The
> +                  required list depends on particular implementation and
> +                  is as follows:
> +                  - for "qcom,smmu-v2":
> +                    - "bus": clock required for downstream bus access and
> +                             for the smmu ptw,
> +                    - "iface": clock required to access smmu's registers
> +                               through the TCU's programming interface.
> +                  - unspecified for other implementations.
> +
> +- clocks:         Specifiers for all clocks listed in the clock-names property,
> +                  as per generic clock bindings.
> +
> +- power-domains:  Specifiers for power domains required to be powered on for
> +                  the SMMU to operate, as per generic power domain bindings.
> +
>   ** Deprecated properties:
>   
>   - mmu-masters (deprecated in favour of the generic "iommus" binding) :
> @@ -137,3 +162,20 @@ conditions.
>                   iommu-map = <0 &smmu3 0 0x400>;
>                   ...
>           };
> +
> +	/* Qcom's arm,smmu-v2 implementation */
> +	smmu4: iommu {
> +		compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
> +		reg = <0xd00000 0x10000>;
> +
> +		#global-interrupts = <1>;
> +		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
> +		#iommu-cells = <1>;
> +		power-domains = <&mmcc MDSS_GDSC>;
> +
> +		clocks = <&mmcc SMMU_MDP_AXI_CLK>,
> +			 <&mmcc SMMU_MDP_AHB_CLK>;
> +		clock-names = "bus", "iface";
> +	};
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index e558abf1ecfc..2b4edba188a5 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -119,6 +119,7 @@ enum arm_smmu_implementation {
>   	GENERIC_SMMU,
>   	ARM_MMU500,
>   	CAVIUM_SMMUV2,
> +	QCOM_SMMUV2,
>   };
>   
>   struct arm_smmu_s2cr {
> @@ -1971,6 +1972,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
>   ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
>   ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>   
> +static const char * const qcom_smmuv2_clks[] = {
> +	"bus", "iface",
> +};
> +
> +static const struct arm_smmu_match_data qcom_smmuv2 = {
> +	.version = ARM_SMMU_V2,
> +	.model = QCOM_SMMUV2,
> +	.clks = qcom_smmuv2_clks,
> +	.num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
> +};
> +
>   static const struct of_device_id arm_smmu_of_match[] = {
>   	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
>   	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
> @@ -1978,6 +1990,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
>   	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
>   	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
>   	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
> +	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> 
