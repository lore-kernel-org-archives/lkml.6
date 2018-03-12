Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeCLMmL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:42:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53494 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeCLMmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:42:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83C79601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 3/3] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Marc Zyngier <marc.zyngier@arm.com>, andy.gross@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org,
        dianders@chromium.org, swboyd@chromium.org
References: <20180312080656.13247-1-rnayak@codeaurora.org>
 <20180312080656.13247-4-rnayak@codeaurora.org>
 <96fac632-8fb8-0933-cc1f-627acb38a595@arm.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <da996a5f-e498-1e21-d09e-c9827e99398b@codeaurora.org>
Date: Mon, 12 Mar 2018 18:12:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <96fac632-8fb8-0933-cc1f-627acb38a595@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/12/2018 04:59 PM, Marc Zyngier wrote:
> On 12/03/18 08:06, Rajendra Nayak wrote:
>> Add a skeletal sdm845 SoC dtsi and MTP board dts/dtsi files
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  15 ++
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 278 ++++++++++++++++++++++++++++++++
>>  3 files changed, 294 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 55ec5ee7f7e8..9319e74b8906 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-bullhead-rev-101.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> new file mode 100644
>> index 000000000000..979ab49913f1
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> @@ -0,0 +1,15 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * SDM845 MTP board device tree source
>> + *
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sdm845.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. SDM845 MTP";
>> +	compatible = "qcom,sdm845-mtp";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> new file mode 100644
>> index 000000000000..d2407cd7a561
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> 
> [...]
> 
>> +		intc: interrupt-controller@17a00000 {
>> +			compatible = "arm,gic-v3";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			#redistributor-regions = <1>;
>> +			redistributor-stride = <0x0 0x20000>;
> 
> You shouldn't need redistributor-stride here, unless your GIC
> implementation is not compliant with the architecture (i.e. really
> buggy). I only know of one such implementation, and I'd rather you
> remove this property unless your GIC is indeed non-compliant. If that's
> the case, you should also document it.

Thanks Marc, I will drop the redistributor-stride and #redistributor-regions
as the bindings document seems to suggest its optional and is needed only
when more than 1 such region is present.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
