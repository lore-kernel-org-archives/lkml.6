Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeBAUrJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:47:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeBAUrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:47:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Feb 2018 12:47:01 -0800
From: Channa <ckadabi@codeaurora.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, sboyd@codeaurora.org, kyan@codeaurora.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
In-Reply-To: <20180201104808.rxgqcrlsevtotq55@lakrids.cambridge.arm.com>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
 <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
 <20180201104808.rxgqcrlsevtotq55@lakrids.cambridge.arm.com>
Message-ID: <2c343b57bf3ee8aeb3338aee0d27dc06@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-01 02:48, Mark Rutland wrote:
> On Thu, Jan 25, 2018 at 03:55:12PM -0800, Channagoud Kadabi wrote:
>> Documentation for last level cache controller device tree bindings,
>> client bindings usage examples.
>> 
>> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
>> ---
>>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 93 
>> ++++++++++++++++++++++
>>  1 file changed, 93 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>> 
>> +Example:
>> +
>> +	qcom,system-cache@1300000 {
>> +		compatible = "qcom,llcc-core", "syscon", "simple-mfd";
>> +		reg = <0x1300000 0x50000>;
>> +		reg-names = "llcc_base";
>> +
>> +		llcc: qcom,sdm845-llcc {
>> +			compatible = "qcom,sdm845-llcc";
>> +			#cache-cells = <1>;
>> +			max-slices = <32>;
>> +		};
>> +
>> +		qcom,llcc-ecc {
>> +			compatible = "qcom,llcc-ecc";
>> +		};
>> +
>> +		qcom,llcc-amon {
>> +			compatible = "qcom,llcc-amon";
>> +			qcom,fg-cnt = <0x7>;
>> +		};
>> +
>> +	};
> 
> The "qcom,llcc-ecc" and "qcom,llcc-amon" bindings doesn't seem to be
> used by the driver in patch 2, and it's not clear how they are intended
> to be used, so I think they should go from the binding for now.

Sure I can remove them for now and add them when the I push other 
drivers
for review.

> 
> I don't think you need syscon and simple-mfd, and I think you can

I used syscon and simple-mfd because three drivers touch the same 
address space.

Driver 1:
system cache core: The purpose of the driver is to partition the system 
cache
and program the settings such as priority, lines to probe while doing a 
look up
in the system cache, low power related settings etc.
The driver also provides API for clients to query the cache slice 
details,
activate and deactivate them.

Driver 2:
ECC to detect single and double bit errors in LLCC memory.
Implemented using EDAC framework.

Driver 3:
AMON: Activity Monitor to detect live lock ups in the HW block.
Implemented as SOC driver similar to driver #1.

Since the hardware block has multiple functional units the driver is 
implemented
to use syscon/regmap interface.

> simplify the binding to a single node like:
> 
> 	qcom,system-cache@1300000 {
> 		compatible = "qcom,sdm845-llcc";
> 		reg = <0x1300000 0x50000>;
> 		#cache-slice-cells = <1>;
> 		max-slices = <32>;
> 	}
> 
> If ECC and AMON are option features, we can always add boolean
> properties for those later, e.g. "has-ecc".
> 
> Thanks,
> Mark.

-- 
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
