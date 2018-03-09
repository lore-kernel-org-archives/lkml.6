Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbeCIOzf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:55:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48414 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeCIOzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:55:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54D5D6024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH 1/6] reset: qcom: AOSS (Always on subsystem) reset
 controller
To: Rob Herring <robh@kernel.org>
Cc: bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com,
        p.zabel@pengutronix.de, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org
References: <1520243613-30393-1-git-send-email-sibis@codeaurora.org>
 <1520243613-30393-2-git-send-email-sibis@codeaurora.org>
 <20180307213514.4sv7ucxo25jpomz3@rob-hp-laptop>
From: Sibi S <sibis@codeaurora.org>
Message-ID: <519c6298-0619-d98e-6c45-c70936af93c3@codeaurora.org>
Date: Fri, 9 Mar 2018 20:25:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180307213514.4sv7ucxo25jpomz3@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Thanks for the review, will add the changes in v3 of the patch series

On 03/08/2018 03:05 AM, Rob Herring wrote:
> On Mon, Mar 05, 2018 at 03:23:28PM +0530, sibis wrote:
>> Add reset controller driver for Qualcomm SDM845 SoC to
>> control reset signals provided by AOSS for Modem, Venus
>> ADSP, GPU, Camera, Wireless, Display subsystem
>>
>> Signed-off-by: sibis <sibis@codeaurora.org>
> 
> Need a full name here.
> 

Will correct it

>> ---
>>   .../devicetree/bindings/reset/qcom,aoss-reset.txt  |  54 ++++++++
> 
> Separate patch for bindings (with the header) please.
> 

Will make a separate patch

>>   drivers/reset/Kconfig                              |  10 ++
>>   drivers/reset/Makefile                             |   1 +
>>   drivers/reset/reset-qcom-aoss.c                    | 151 +++++++++++++++++++++
>>   include/dt-bindings/reset/qcom,aoss-sdm845.h       |  17 +++
>>   5 files changed, 233 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>>   create mode 100644 drivers/reset/reset-qcom-aoss.c
>>   create mode 100644 include/dt-bindings/reset/qcom,aoss-sdm845.h
>>
>> diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>> new file mode 100644
>> index 0000000..5318e14
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>> @@ -0,0 +1,54 @@
>> +Qualcomm AOSS Reset Controller
>> +======================================
>> +
>> +This binding describes a reset-controller found on AOSS (Always on SubSysem)
>> +for Qualcomm SDM845 SoCs.
>> +
>> +Required properties:
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: must be:
>> +		    "qcom,aoss-reset-sdm845", "syscon"
> 
> Someone in QCom needs to go fix the order of all your downstream
> compatibles or review your bindings before sending upstream. The
> standard ordering is <vendor>,<soc>-<block>.
>

Will correct it.

> Why syscon? The description is this is just a reset controller.
>

syscon was needed in the compatible list due to using
syscon_node_to_regmap in the reset driver but I guess
since it is just a reset controller the correct thing to do
be ioremap the reg space and do devm_regmap_init_mmio on it.
Will remove syscon.

>> +
>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: must specify the base address and size of the
>> +		    syscon device.
>> +
>> +
>> +- #reset-cells:
>> +	Usage: required
>> +	Value type: <uint>
>> +	Definition: must be 1; cell entry represents the reset index.
>> +
>> +example:
>> +
>> +aoss_reset: qcom,reset-controller@b2e0100 {
>> +	compatible = "qcom,aoss-reset-sdm845", "syscon";
>> +	reg = <0xc2b0000 0x20004>;
>> +	#reset-cells = <1>;
>> +};
>> +
>> +
>> +Specifying reset lines connected to IP modules
>> +==============================================
>> +
>> +Device nodes that need access to reset lines should
>> +specify them as a reset phandle in their corresponding node as
>> +specified in reset.txt.
>> +
>> +Example:
>> +
>> +	modem-pil@4080000 {
>> +		...
>> +
>> +		resets = <&aoss_reset AOSS_CC_MSS_RESTART>;
>> +		reset-names = "mss_restart";
>> +
>> +		...
>> +        };
>> +
>> +For list of all valid reset indicies see
>> +<dt-bindings/reset/qcom,aoss-sdm845.h>
> 
> Put this before the example.
>

ok

> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
